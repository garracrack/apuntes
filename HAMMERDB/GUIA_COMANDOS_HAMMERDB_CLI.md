# Guia de Comandos HammerDB CLI - TPC-C Oracle

## Que es HammerDB

HammerDB es una herramienta open-source de benchmarking de bases de datos. 
Permite medir el rendimiento usando benchmarks estandar como TPC-C (transaccional) y TPC-H (analitico).

Puede usarse via **GUI** (interfaz grafica) o via **CLI** (linea de comandos con scripts Tcl).

---

## Metricas principales

| Metrica | Significado |
|---------|-------------|
| **NOPM** | New Orders Per Minute - pedidos nuevos por minuto. Es la metrica principal independiente de la base de datos. |
| **TPM**  | Transactions Per Minute - todas las transacciones por minuto (incluye Payment, Order Status, Delivery, Stock Level). |

**Como calcula HammerDB el NOPM:**
1. Antes del test: lee `SELECT SUM(d_next_o_id) FROM district` → valor_inicio
2. Ejecuta el benchmark durante N minutos
3. Despues del test: lee la misma query → valor_fin
4. **NOPM = (valor_fin - valor_inicio) / duracion_en_minutos**

---

## Comandos del script paso a paso

### 1. Seleccionar base de datos y benchmark

```tcl
dbset db oracle
dbset bm TPC-C
```

- `dbset db <tipo>` — Selecciona la base de datos (oracle, mysql, pg, mssql, db2, maria).
- `dbset bm <benchmark>` — Selecciona el benchmark (TPC-C para transaccional, TPC-H para analitico).

Equivalente GUI: seleccionar en el menu desplegable de la esquina superior izquierda.

---

### 2. Configurar la conexion (`diset connection`)

```tcl
diset connection system_user pdbadmin
diset connection system_password 1234
diset connection instance 192.168.192.132:1521/PDB1
```

- `diset connection system_user` — Usuario administrador para tareas de monitoring/AWR.
- `diset connection system_password` — Contrasena del usuario administrador.
- `diset connection instance` — Cadena de conexion: `host:puerto/servicio`.

Equivalente GUI: pestana "Options" → seccion "Connection".

---

### 3. Configurar el benchmark TPC-C (`diset tpcc`)

```tcl
diset tpcc tpcc_user tpcc
diset tpcc tpcc_pass tpcc
diset tpcc oracle_count_ware 3
diset tpcc oracle_driver timed
diset tpcc rampup 0
diset tpcc duration 2
diset tpcc allwarehouse true
diset tpcc timeprofile true
```

| Comando | Descripcion |
|---------|-------------|
| `tpcc_user` / `tpcc_pass` | Usuario y contrasena del schema TPC-C (los workers se conectan con este) |
| `oracle_count_ware` | Numero de warehouses cargados en la BD |
| `oracle_driver timed` | **CRITICO** — Activa el modo temporizado. Sin esto, `rampup` y `duration` se ignoran |
| `rampup` | Minutos de calentamiento antes de empezar a medir (0 = sin calentamiento) |
| `duration` | Minutos que dura la medicion del benchmark |
| `allwarehouse` | Si es `true`, cada VU puede acceder a cualquier warehouse (mas carga) |
| `timeprofile` | Activa el perfil de tiempos detallado por tipo de transaccion |

Equivalente GUI: pestana "Options" → seccion "Driver Options / TPC-C".

---

### 4. Pre-cargar Oratcl

```tcl
package require Oratcl
```

**CRITICO** — Carga la libreria Oracle (Oratcl) en el hilo principal del proceso
**ANTES** de `loadscript`. Sin esto, el monitor VUser 1 no puede conectarse a
Oracle para calcular NOPM/TPM y falla con `FINISHED FAILED`.

Equivalente GUI: la GUI lo hace automaticamente al inicializarse.

---

### 5. Cargar el driver script

```tcl
loadscript
```

Carga el script de driver correspondiente a la BD y benchmark seleccionados. 
Este script es el codigo Tcl que cada Virtual User ejecutara contra la BD.

Equivalente GUI: boton "Load" en la barra de herramientas.

---

### 6. Crear y gestionar Virtual Users

```tcl
vuset vu 10                ;# Configurar cuantos VUs crear
vucreate                   ;# Crear los VUs (threads)
vurun                      ;# Lanzar la ejecucion (ASINCRONO)

# Esperar procesando eventos (CRITICO):
set ::wait_done 0
after [expr {(rampup + duration + 2) * 60000}] {set ::wait_done 1}
vwait ::wait_done

vudestroy                  ;# Destruir los VUs y liberar recursos
```

| Comando | Descripcion |
|---------|-------------|
| `vuset vu N` | Define el numero de Virtual Users (usuarios simulados concurrentes) |
| `vucreate` | Crea los hilos de ejecucion. Con `oracle_driver timed`, HammerDB crea N+1 VUs (el extra es el monitor que calcula NOPM/TPM) |
| `vurun` | **Inicia** la ejecucion. **ES ASINCRONO** — retorna inmediatamente sin esperar |
| `after <ms> {script}` | Programa un callback que se ejecutara tras N milisegundos |
| `vwait variable` | **CRITICO** — Bloquea el hilo principal **procesando eventos** hasta que la variable cambie. Sin `vwait`, los VUsers no pueden comunicar sus resultados al hilo principal |
| `vudestroy` | Finaliza y libera los threads de los Virtual Users |

> **Por que `after` solo NO funciona:**
> `after <ms>` (sin callback) bloquea el hilo principal **sin procesar eventos**.
> Los VUsers son threads Tcl que necesitan el event loop para comunicar resultados.
> Si el hilo principal no procesa eventos, VUser 1 (monitor) no puede entregar
> el TEST RESULT y falla con `FINISHED FAILED`.
>
> La solucion es usar `after <ms> {callback}` + `vwait`, que SI procesa eventos.

Equivalente GUI: botones "Virtual Users" → "Create", "Run" (la GUI procesa eventos automaticamente).

---

### 7. Comandos Tcl generales usados

```tcl
set variable valor                       ;# Asignar valor a variable
puts "texto $variable"                   ;# Imprimir por pantalla
expr {$a - $b}                           ;# Evaluar expresion matematica
clock seconds                            ;# Timestamp actual en segundos
clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S}  ;# Formato legible
format %.2f $numero                      ;# Formatear numero con 2 decimales
if {condicion} { ... } else { ... }      ;# Condicional
```

---

## Errores comunes

### 1. Olvidar `oracle_driver timed`
**Sintoma:** El test ejecuta un numero fijo de transacciones en vez de correr durante N minutos. `rampup` y `duration` no tienen efecto.

### 2. Usar `after` bloqueante en vez de `after` + `vwait`
**Sintoma:** VUser 1 aparece como `FINISHED FAILED` y no se imprime la linea `TEST RESULT` con NOPM/TPM.  
**Causa:** `after <ms>` (sin callback) bloquea sin procesar eventos. Los threads de los VUsers necesitan el event loop activo para comunicar resultados.  
**Solucion:** Usar `after <ms> {set ::wait_done 1}` + `vwait ::wait_done`.

### 3. Olvidar `package require Oratcl`
**Sintoma:** VUser 1 falla con `FINISHED FAILED` al intentar calcular NOPM.  
**Causa:** La libreria Oracle no esta cargada en el proceso. Debe ejecutarse `package require Oratcl` ANTES de `loadscript`.

### 4. Calcular TPM como NOPM * factor
**Problema:** HammerDB mide TPM contando TODAS las transacciones reales. No es correcto multiplicar NOPM por un factor fijo. Con `oracle_driver timed`, HammerDB reporta el TPM real automaticamente.

---

## Flujo completo (equivalencia GUI → CLI)

```
GUI                          CLI
───────────────────          ──────────────────────────
Seleccionar Oracle       →   dbset db oracle
Seleccionar TPC-C        →   dbset bm TPC-C
Configurar conexion      →   diset connection ...
Configurar driver        →   diset tpcc ...
Pre-cargar Oracle        →   package require Oratcl
Pulsar "Load"            →   loadscript
Crear VUs                →   vuset vu N + vucreate
Pulsar "Run"             →   vurun + after/vwait
(espera automatica)      →   (vwait procesa eventos en CLI)
Ver resultados NOPM/TPM  →   HammerDB los imprime en stdout
Destruir VUs             →   vudestroy
```

---

## Referencia rapida

| Accion | Comando |
|--------|---------|
| Seleccionar BD | `dbset db oracle` |
| Seleccionar benchmark | `dbset bm TPC-C` |
| Configurar parametro de conexion | `diset connection <param> <valor>` |
| Configurar parametro TPC-C | `diset tpcc <param> <valor>` |
| Ver configuracion actual | `print dict` |
| Pre-cargar Oracle | `package require Oratcl` |
| Cargar script | `loadscript` |
| Definir numero de VUs | `vuset vu <N>` |
| Crear VUs | `vucreate` |
| Ejecutar VUs | `vurun` |
| Esperar fin de VUs | `after <ms> {callback}` + `vwait` |
| Destruir VUs | `vudestroy` |
| Ver estado de VUs | `vustatus` |
