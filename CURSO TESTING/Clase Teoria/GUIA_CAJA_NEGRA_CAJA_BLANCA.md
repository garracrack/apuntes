# 🧪 GUÍA COMPLETA: PRUEBAS DE CAJA NEGRA Y CAJA BLANCA

## 📋 Índice

1. [Introducción](#1-introducción)
2. [Procedimiento de Referencia](#2-procedimiento-de-referencia)
3. [PRUEBAS DE CAJA NEGRA](#3-pruebas-de-caja-negra)
   - 3.1 [Clases de Equivalencia](#31-clases-de-equivalencia)
   - 3.2 [Análisis de Valores Límite](#32-análisis-de-valores-límite)
   - 3.3 [Tablas de Decisión](#33-tablas-de-decisión)
   - 3.4 [Transición de Estados](#34-transición-de-estados)
   - 3.5 [Casos de Uso](#35-casos-de-uso)
4. [PRUEBAS DE CAJA BLANCA](#4-pruebas-de-caja-blanca)
   - 4.1 [Cobertura de Sentencias](#41-cobertura-de-sentencias)
   - 4.2 [Cobertura de Decisiones/Ramas](#42-cobertura-de-decisionesramas)
   - 4.3 [Cobertura de Condiciones](#43-cobertura-de-condiciones)
   - 4.4 [Cobertura de Caminos](#44-cobertura-de-caminos)
    - 4.5 [Cobertura de Condiciones vs Decisiones](#45-cobertura-de-condiciones-vs-decisiones)
    - 4.6 [Complejidad Ciclomática](#46-complejidad-ciclomática)
    - 4.7 [Pruebas de Mutación](#47-pruebas-de-mutación)
5. [Ejercicios Resueltos](#5-ejercicios-resueltos)
6. [Ejercicios Propuestos](#6-ejercicios-propuestos)

---

# 1. Introducción

## ¿Qué diferencia hay entre Caja Negra y Caja Blanca?

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CAJA NEGRA vs CAJA BLANCA                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   CAJA NEGRA                              CAJA BLANCA                       │
│   ──────────                              ───────────                       │
│                                                                             │
│   ┌─────────────────┐                     ┌─────────────────┐               │
│   │   ┌─────────┐   │                     │ IF x > 0 THEN   │               │
│   │   │  ? ? ?  │   │                     │   y = x + 1     │               │
│   │   │  ? ? ?  │   │                     │ ELSE            │               │
│   │   │  ? ? ?  │   │                     │   y = 0         │               │
│   │   └─────────┘   │                     │ END IF          │               │
│   └─────────────────┘                     └─────────────────┘               │
│                                                                             │
│   NO vemos el código                      SÍ vemos el código                │
│   Solo ENTRADAS → SALIDAS                 Analizamos la ESTRUCTURA          │
│                                                                             │
│   ¿QUÉ hace?                              ¿CÓMO lo hace?                    │
│   Basada en ESPECIFICACIÓN                Basada en CÓDIGO                  │
│                                                                             │
│   Técnicas:                               Técnicas:                         │
│   • Clases de equivalencia                • Cobertura de sentencias         │
│   • Valores límite                        • Cobertura de ramas              │
│   • Tablas de decisión                    • Cobertura de condiciones        │
│   • Transición de estados                 • Cobertura de caminos            │
│   • Casos de uso                          • Pruebas de mutación             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

> 💡 **Importante:** Caja Blanca y Caja Negra son **complementarias**, no excluyentes. Un programa puede funcionar estructuralmente perfecto pero NO hacer lo que debe (necesitas Caja Negra). Un programa puede producir salidas correctas para ciertos inputs pero tener código muerto o caminos no probados (necesitas Caja Blanca).

---

# 2. Procedimiento de Referencia

A lo largo de esta guía usaremos el siguiente procedimiento PL/SQL como ejemplo práctico para aplicar todas las técnicas:

```sql
CREATE OR REPLACE PROCEDURE validar_ajustar_salario(
    p_id_empleado   IN  NUMBER,
    p_nuevo_salario IN  NUMBER,
    p_motivo        IN  VARCHAR2,
    p_salario_ajustado OUT NUMBER,
    p_mensaje       OUT VARCHAR2
) IS
    v_salario_actual    NUMBER;
    v_incremento_pct    NUMBER;
    v_salario_final     NUMBER;
    v_count             NUMBER;

    -- Constantes de negocio
    c_salario_minimo    CONSTANT NUMBER := 1000;
    c_salario_maximo    CONSTANT NUMBER := 100000;
    c_incremento_max    CONSTANT NUMBER := 50; -- 50%

    -- Excepciones personalizadas
    e_empleado_no_existe EXCEPTION;
    e_salario_invalido   EXCEPTION;
BEGIN
    p_mensaje := 'OK';

    -- PUNTO DE DECISIÓN 1: Validar que el empleado existe
    SELECT COUNT(*) INTO v_count
    FROM empleados WHERE id_empleado = p_id_empleado;

    IF v_count = 0 THEN                              -- Decisión 1
        RAISE e_empleado_no_existe;
    END IF;

    -- PUNTO DE DECISIÓN 2: Validar salario positivo
    IF p_nuevo_salario <= 0 THEN                     -- Decisión 2
        RAISE e_salario_invalido;
    END IF;

    -- Obtener salario actual
    SELECT salario INTO v_salario_actual
    FROM empleados WHERE id_empleado = p_id_empleado;

    v_salario_final := p_nuevo_salario;

    -- PUNTO DE DECISIÓN 3: Ajuste por mínimo
    IF v_salario_final < c_salario_minimo THEN       -- Decisión 3
        v_salario_final := c_salario_minimo;
        p_mensaje := 'Salario ajustado al mínimo permitido: ' || c_salario_minimo;
    END IF;

    -- PUNTO DE DECISIÓN 4: Ajuste por máximo
    IF v_salario_final > c_salario_maximo THEN       -- Decisión 4
        v_salario_final := c_salario_maximo;
        p_mensaje := 'Salario ajustado al máximo permitido: ' || c_salario_maximo;
    END IF;

    -- PUNTO DE DECISIÓN 5: Verificar incremento excesivo
    IF v_salario_actual > 0 THEN                     -- Decisión 5
        v_incremento_pct := ((v_salario_final - v_salario_actual) / v_salario_actual) * 100;

        IF v_incremento_pct > c_incremento_max THEN  -- Decisión 6
            p_mensaje := 'ADVERTENCIA: Incremento de ' || 
                        ROUND(v_incremento_pct, 2) || 
                        '% supera el límite de ' || c_incremento_max || 
                        '%. Requiere aprobación gerencial.';
        END IF;
    END IF;

    UPDATE empleados SET salario = v_salario_final
    WHERE id_empleado = p_id_empleado;

    p_salario_ajustado := v_salario_final;
    COMMIT;

EXCEPTION
    WHEN e_empleado_no_existe THEN
        p_salario_ajustado := NULL;
        p_mensaje := 'ERROR: Empleado no existe';
        ROLLBACK;
    WHEN e_salario_invalido THEN
        p_salario_ajustado := NULL;
        p_mensaje := 'ERROR: Salario debe ser mayor a 0';
        ROLLBACK;
    WHEN OTHERS THEN
        p_salario_ajustado := NULL;
        p_mensaje := 'ERROR: ' || SQLERRM;
        ROLLBACK;
END validar_ajustar_salario;
```

### Reglas de Negocio del Procedimiento

| Regla | Descripción |
|-------|-------------|
| **RN1** | El empleado debe existir en la base de datos |
| **RN2** | El salario propuesto debe ser mayor a 0 |
| **RN3** | El salario mínimo permitido es 1.000€ |
| **RN4** | El salario máximo permitido es 100.000€ |
| **RN5** | Si el incremento supera el 50%, requiere aprobación gerencial |

---

# 3. PRUEBAS DE CAJA NEGRA

Las pruebas de Caja Negra se enfocan en verificar que el sistema cumple las especificaciones **sin conocer su implementación interna**.

> "Pruebas que ignoran el mecanismo interno de un componente y que se enfocan únicamente en las salidas generadas como respuesta a entradas y condiciones de ejecución seleccionadas" - IEEE

---

## 3.1 Clases de Equivalencia

### 3.1.1 Concepto

La técnica de **partición de equivalencia** agrupa los posibles valores de entrada en clases donde **todos los datos se comportan igual**. Probamos con **un único representante** de cada clase.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CLASES DE EQUIVALENCIA                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Todos los valores posibles                                                │
│   ─────────────────────────────────────────────────────────────────────     │
│                                                                             │
│   ┌─────────────┐  ┌─────────────────────────────┐  ┌─────────────┐        │
│   │   CLASE     │  │         CLASE               │  │   CLASE     │        │
│   │  INVÁLIDA   │  │        VÁLIDA               │  │  INVÁLIDA   │        │
│   │  (x < 0)    │  │     (0 ≤ x ≤ 100)           │  │  (x > 100)  │        │
│   │             │  │                             │  │             │        │
│   │  Rep: -50   │  │       Rep: 50               │  │  Rep: 150   │        │
│   └─────────────┘  └─────────────────────────────┘  └─────────────────────┘ │
│                                                                             │
│   En vez de probar TODOS los valores, probamos UN REPRESENTANTE             │
│   de cada clase (3 casos en vez de infinitos)                               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.1.2 Procedimiento

1. **Identificar** todas las variables de entrada
2. **Definir** el rango de definición de cada variable
3. **Formar** clases de equivalencia válidas (CEV) e inválidas (CEI)
4. **Elegir** un representante de cada clase
5. **Crear** casos de prueba combinando representantes

### 3.1.3 Ejemplo con el Procedimiento

Aplicamos la técnica al procedimiento `validar_ajustar_salario`:

**Variables de entrada:**
- `p_id_empleado`: Identificador del empleado
- `p_nuevo_salario`: Salario propuesto

**Clases de Equivalencia:**

| Variable | Clase | Descripción | Estado | Representante |
|----------|-------|-------------|--------|---------------|
| `p_id_empleado` | CE1 | ID existe en BD | Válido | 101 |
| | CE2 | ID no existe en BD | Inválido | 9999 |
| | CE3 | ID negativo | Inválido | -1 |
| | CE4 | ID nulo | Inválido | NULL |
| `p_nuevo_salario` | CE5 | 1000 ≤ x ≤ 100000 (rango normal) | Válido | 50000 |
| | CE6 | 0 < x < 1000 (se ajusta al mínimo) | Válido* | 500 |
| | CE7 | x > 100000 (se ajusta al máximo) | Válido* | 150000 |
| | CE8 | x ≤ 0 | Inválido | -1000 |
| | CE9 | x = NULL | Inválido | NULL |

*Válido porque el sistema lo procesa (ajustándolo), no genera error.

**Casos de Prueba derivados de las CE:**

| CP | p_id_empleado | p_nuevo_salario | Resultado Esperado |
|----|---------------|-----------------|-------------------|
| CP01 | 101 (CE1) | 50000 (CE5) | Salario = 50000, mensaje 'OK' |
| CP02 | 101 (CE1) | 500 (CE6) | Salario = 1000, mensaje 'ajustado al mínimo' |
| CP03 | 101 (CE1) | 150000 (CE7) | Salario = 100000, mensaje 'ajustado al máximo' |
| CP04 | 9999 (CE2) | 50000 (CE5) | ERROR: Empleado no existe |
| CP05 | -1 (CE3) | 50000 (CE5) | ERROR: Empleado no existe |
| CP06 | 101 (CE1) | -1000 (CE8) | ERROR: Salario debe ser mayor a 0 |
| CP07 | 101 (CE1) | 0 (CE8) | ERROR: Salario debe ser mayor a 0 |

### 3.1.4 Reglas para Combinar Clases

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    REGLAS DE COMBINACIÓN                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   CLASES VÁLIDAS:                                                           │
│   ─────────────────                                                         │
│   Se pueden combinar MÚLTIPLES clases válidas en UN caso de prueba          │
│   → Minimiza el número total de casos                                       │
│                                                                             │
│   CLASES INVÁLIDAS:                                                         │
│   ─────────────────                                                         │
│   Cada clase inválida debe probarse con TODAS las demás VÁLIDAS             │
│   → NO combinar dos clases inválidas en el mismo caso                       │
│   → ¿Por qué? Para no ENMASCARAR errores                                    │
│                                                                             │
│   Ejemplo INCORRECTO:                                                       │
│   ✗ p_id_empleado = -1 (inválido) + p_nuevo_salario = -1000 (inválido)     │
│     → Si falla, ¿cuál de los dos causó el error?                           │
│                                                                             │
│   Ejemplo CORRECTO:                                                         │
│   ✓ p_id_empleado = -1 (inválido) + p_nuevo_salario = 50000 (válido)       │
│   ✓ p_id_empleado = 101 (válido) + p_nuevo_salario = -1000 (inválido)      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 3.2 Análisis de Valores Límite

### 3.2.1 Concepto

El análisis de valores límite **amplía** las clases de equivalencia probando **los bordes** de cada clase. La experiencia demuestra que los errores son más frecuentes en las regiones límite.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    VALORES LÍMITE                                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Rango válido: 1000 ≤ salario ≤ 100000                                     │
│                                                                             │
│   ◄─── INVÁLIDO ───┼─────────── VÁLIDO ──────────────┼─── INVÁLIDO ──►      │
│                    │                                 │                      │
│        999    1000 │ 1001            99999    100000 │ 100001               │
│         ▲      ▲   │   ▲                ▲        ▲   │    ▲                 │
│         │      │   │   │                │        │   │    │                 │
│         │      └───┼───┘                └────────┼───┘    │                 │
│         │          │                             │        │                 │
│      LÍMITE     LÍMITES                       LÍMITES  LÍMITE               │
│      INFERIOR   VÁLIDOS                       VÁLIDOS  SUPERIOR             │
│      INVÁLIDO                                          INVÁLIDO             │
│                                                                             │
│   Valores a probar: 999, 1000, 1001, 99999, 100000, 100001                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.2.2 Técnica de 2 o 3 Valores

**Técnica de 2 valores** (menos exhaustiva):
- Valor justo en el límite
- Valor justo fuera del límite

**Técnica de 3 valores** (más exhaustiva):
- Valor justo antes del límite
- Valor en el límite exacto
- Valor justo después del límite

### 3.2.3 Ejemplo con el Procedimiento

Aplicamos valores límite al `p_nuevo_salario`:

| Límite | Tipo | Valores a Probar | Resultado Esperado |
|--------|------|------------------|-------------------|
| Salario mínimo (1000) | Inferior Inválido | 999 | Ajusta a 1000 |
| | Límite exacto | 1000 | Salario = 1000 (OK) |
| | Superior Válido | 1001 | Salario = 1001 (OK) |
| Salario máximo (100000) | Inferior Válido | 99999 | Salario = 99999 (OK) |
| | Límite exacto | 100000 | Salario = 100000 (OK) |
| | Superior Inválido | 100001 | Ajusta a 100000 |
| Salario cero | En límite | 0 | ERROR |
| | Justo encima | 1 | Ajusta a 1000 |
| | Justo debajo | -1 | ERROR |

**Casos de Prueba de Valores Límite:**

| CP | p_nuevo_salario | Resultado Esperado |
|----|-----------------|-------------------|
| VL01 | 0 | ERROR: Salario debe ser mayor a 0 |
| VL02 | 1 | Salario ajustado a 1000 |
| VL03 | 999 | Salario ajustado a 1000 |
| VL04 | 1000 | Salario = 1000 (OK) |
| VL05 | 1001 | Salario = 1001 (OK) |
| VL06 | 99999 | Salario = 99999 (OK) |
| VL07 | 100000 | Salario = 100000 (OK) |
| VL08 | 100001 | Salario ajustado a 100000 |

---

## 3.3 Tablas de Decisión

### 3.3.1 Concepto

Las tablas de decisión representan la lógica de negocio cuando hay **múltiples condiciones** que determinan diferentes **acciones**. Son especialmente útiles cuando las reglas de negocio son complejas.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ESTRUCTURA DE TABLA DE DECISIÓN                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                              REGLAS                                         │
│                    ┌────┬────┬────┬────┬────┐                              │
│                    │ R1 │ R2 │ R3 │ R4 │ R5 │                              │
│   ┌────────────────┼────┼────┼────┼────┼────┤                              │
│   │ CONDICIONES    │    │    │    │    │    │                              │
│   ├────────────────┼────┼────┼────┼────┼────┤                              │
│   │ Condición 1    │ S  │ S  │ S  │ N  │ N  │                              │
│   │ Condición 2    │ S  │ S  │ N  │ S  │ N  │                              │
│   │ Condición 3    │ S  │ N  │ -  │ -  │ -  │                              │
│   ├────────────────┼────┼────┼────┼────┼────┤                              │
│   │ ACCIONES       │    │    │    │    │    │                              │
│   ├────────────────┼────┼────┼────┼────┼────┤                              │
│   │ Acción 1       │ X  │    │ X  │    │    │                              │
│   │ Acción 2       │    │ X  │    │ X  │    │                              │
│   │ Acción 3       │    │    │    │    │ X  │                              │
│   └────────────────┴────┴────┴────┴────┴────┘                              │
│                                                                             │
│   Cada COLUMNA = Un CASO DE PRUEBA                                          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.3.2 Ejemplo con el Procedimiento

**Condiciones identificadas:**
- C1: ¿Empleado existe?
- C2: ¿Salario > 0?
- C3: ¿Salario < 1000 (mínimo)?
- C4: ¿Salario > 100000 (máximo)?
- C5: ¿Incremento > 50%?

**Tabla de Decisión:**

| | R1 | R2 | R3 | R4 | R5 | R6 | R7 |
|---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **CONDICIONES** |||||||
| C1: Empleado existe | N | S | S | S | S | S | S |
| C2: Salario > 0 | - | N | S | S | S | S | S |
| C3: Salario < 1000 | - | - | S | N | N | N | N |
| C4: Salario > 100000 | - | - | N | S | N | N | N |
| C5: Incremento > 50% | - | - | - | - | S | N | N |
| **ACCIONES** |||||||
| ERROR: Empleado no existe | X | | | | | | |
| ERROR: Salario inválido | | X | | | | | |
| Ajustar al mínimo (1000) | | | X | | | | |
| Ajustar al máximo (100000) | | | | X | | | |
| Advertencia incremento | | | | | X | | |
| Actualizar salario normal | | | | | | X | X |
| Mensaje OK | | | | | | | X |

**Casos de Prueba derivados:**

| Regla | Entrada | Resultado |
|-------|---------|-----------|
| R1 | id=9999, salario=50000 | ERROR: Empleado no existe |
| R2 | id=101, salario=-1000 | ERROR: Salario debe ser mayor a 0 |
| R3 | id=101, salario=500 | Salario ajustado a 1000 |
| R4 | id=101, salario=150000 | Salario ajustado a 100000 |
| R5 | id=101 (sal_actual=30000), salario=50000 | Advertencia: 66.67% > 50% |
| R6 | id=101 (sal_actual=40000), salario=50000 | OK (25% < 50%) |

---

## 3.4 Transición de Estados

### 3.4.1 Concepto

Los diagramas de transición de estados representan sistemas donde el comportamiento **depende del estado actual** y de la **historia de estados** por los que ha pasado.

### 3.4.2 Ejemplo con el Procedimiento

Modelamos el proceso de ajuste salarial como una máquina de estados:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DIAGRAMA DE ESTADOS                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                        ┌─────────────┐                                      │
│           ┌───────────►│   INICIO    │                                      │
│           │            └──────┬──────┘                                      │
│           │                   │                                             │
│           │                   ▼                                             │
│           │            ┌─────────────┐   empleado                           │
│           │            │  VALIDANDO  │──no existe──►┌─────────┐             │
│           │            │  EMPLEADO   │              │  ERROR  │             │
│           │            └──────┬──────┘              │ EMPLEADO│             │
│           │                   │ existe              └─────────┘             │
│           │                   ▼                                             │
│           │            ┌─────────────┐   salario                            │
│           │            │  VALIDANDO  │───≤ 0────►┌─────────┐                │
│           │            │   SALARIO   │           │  ERROR  │                │
│           │            └──────┬──────┘           │ SALARIO │                │
│           │                   │ > 0              └─────────┘                │
│           │                   ▼                                             │
│           │            ┌─────────────┐                                      │
│           │            │  AJUSTANDO  │◄──────────────────┐                  │
│    RETRY  │            │   SALARIO   │                   │                  │
│           │            └──────┬──────┘                   │                  │
│           │                   │                          │                  │
│           │        ┌──────────┼──────────┐               │                  │
│           │        ▼          ▼          ▼               │                  │
│           │   ┌────────┐ ┌────────┐ ┌────────┐           │                  │
│           │   │AJUSTE  │ │SALARIO │ │AJUSTE  │           │                  │
│           │   │MÍNIMO  │ │NORMAL  │ │MÁXIMO  │           │                  │
│           │   └───┬────┘ └───┬────┘ └───┬────┘           │                  │
│           │       └──────────┼──────────┘                │                  │
│           │                  ▼                           │                  │
│           │            ┌─────────────┐   incr>50%        │                  │
│           │            │ VERIFICANDO │──────────►┌───────┴─────┐            │
│           │            │ INCREMENTO  │           │ ADVERTENCIA │            │
│           │            └──────┬──────┘           │  GERENCIAL  │            │
│           │                   │ incr≤50%         └─────────────┘            │
│           │                   ▼                                             │
│           │            ┌─────────────┐                                      │
│           │            │  ACTUALIZAR │                                      │
│           │            │     BD      │                                      │
│           │            └──────┬──────┘                                      │
│           │                   │                                             │
│           │                   ▼                                             │
│           │            ┌─────────────┐                                      │
│           └────────────│     FIN     │                                      │
│                        │   (COMMIT)  │                                      │
│                        └─────────────┘                                      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Tabla de Transiciones:**

| Estado Actual | Evento/Condición | Estado Siguiente | Acción |
|---------------|------------------|------------------|--------|
| INICIO | Invocar procedimiento | VALIDANDO_EMPLEADO | - |
| VALIDANDO_EMPLEADO | Empleado existe | VALIDANDO_SALARIO | Cargar salario actual |
| VALIDANDO_EMPLEADO | Empleado no existe | ERROR | RAISE e_empleado_no_existe |
| VALIDANDO_SALARIO | Salario > 0 | AJUSTANDO | - |
| VALIDANDO_SALARIO | Salario ≤ 0 | ERROR | RAISE e_salario_invalido |
| AJUSTANDO | Salario < 1000 | VERIFICANDO | Ajustar a 1000 |
| AJUSTANDO | 1000 ≤ Salario ≤ 100000 | VERIFICANDO | Mantener salario |
| AJUSTANDO | Salario > 100000 | VERIFICANDO | Ajustar a 100000 |
| VERIFICANDO | Incremento > 50% | ADVERTENCIA | Generar mensaje |
| VERIFICANDO | Incremento ≤ 50% | ACTUALIZAR | - |
| ADVERTENCIA | - | ACTUALIZAR | - |
| ACTUALIZAR | - | FIN | UPDATE + COMMIT |
| ERROR | - | FIN | ROLLBACK |

**Casos de prueba para cobertura de transiciones:**

| CP | Camino | Descripción |
|----|--------|-------------|
| T1 | INICIO→VALIDANDO_EMPLEADO→ERROR | Empleado no existe |
| T2 | INICIO→V_EMP→V_SAL→ERROR | Salario ≤ 0 |
| T3 | INICIO→V_EMP→V_SAL→AJUSTANDO(mín)→VERIF→ACTUALIZAR→FIN | Ajuste mínimo |
| T4 | INICIO→V_EMP→V_SAL→AJUSTANDO(máx)→VERIF→ACTUALIZAR→FIN | Ajuste máximo |
| T5 | INICIO→V_EMP→V_SAL→AJUSTANDO→VERIF→ADVERTENCIA→ACTUALIZAR→FIN | Incremento alto |
| T6 | INICIO→V_EMP→V_SAL→AJUSTANDO→VERIF→ACTUALIZAR→FIN | Camino feliz |

---

## 3.5 Casos de Uso

### 3.5.1 Concepto

Las pruebas basadas en casos de uso validan el sistema siguiendo **escenarios reales** que el usuario enfrentará. Incluyen un escenario principal (camino feliz) y escenarios alternativos (errores, excepciones).

### 3.5.2 Caso de Uso: Ajustar Salario de Empleado

**Nombre:** UC-01 Ajustar Salario
**Actor:** Sistema de RRHH
**Precondiciones:** El empleado existe en la base de datos
**Postcondiciones:** El salario del empleado queda actualizado

**Escenario Principal:**
1. El sistema recibe la solicitud de ajuste salarial
2. El sistema valida que el empleado existe
3. El sistema valida que el nuevo salario es positivo
4. El sistema verifica que el salario está dentro de los límites
5. El sistema calcula el porcentaje de incremento
6. El sistema actualiza el salario
7. El sistema confirma la operación

**Escenarios Alternativos:**

| Paso | Condición | Acción |
|------|-----------|--------|
| 2a | Empleado no existe | Retornar error, terminar |
| 3a | Salario ≤ 0 | Retornar error, terminar |
| 4a | Salario < mínimo | Ajustar a 1000, continuar |
| 4b | Salario > máximo | Ajustar a 100000, continuar |
| 5a | Incremento > 50% | Generar advertencia, continuar |

**Casos de Prueba derivados del Caso de Uso:**

| CP | Escenario | Datos | Resultado Esperado |
|----|-----------|-------|-------------------|
| UC01 | Principal | id=101, salario=45000 | Actualizado OK |
| UC02 | Alternativo 2a | id=9999, salario=45000 | ERROR empleado |
| UC03 | Alternativo 3a | id=101, salario=-5000 | ERROR salario |
| UC04 | Alternativo 4a | id=101, salario=800 | Ajustado a 1000 |
| UC05 | Alternativo 4b | id=101, salario=120000 | Ajustado a 100000 |
| UC06 | Alternativo 5a | id=101 (actual=30000), nuevo=50000 | Advertencia gerencial |

---

# 4. PRUEBAS DE CAJA BLANCA

Las pruebas de Caja Blanca se basan en el conocimiento de la **estructura interna** del código. El objetivo es asegurar que todas las partes del código se ejecutan correctamente.

> "En las técnicas de caja blanca se trata de ejecutar partes del programa. En teoría deberían ser probadas todas las partes del programa al menos una vez durante las pruebas."

---

## 4.1 Cobertura de Sentencias

### 4.1.1 Concepto

La cobertura de sentencias busca **ejecutar todas las líneas de código** al menos una vez.

```
                    Nº de sentencias ejecutadas
Cobertura C0 = ─────────────────────────────────── × 100%
                    Nº total de sentencias
```

### 4.1.2 Grafo de Flujo del Procedimiento

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    GRAFO DE FLUJO DE CONTROL                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                            ┌───────┐                                        │
│                            │ START │                                        │
│                            └───┬───┘                                        │
│                                │                                            │
│                                ▼                                            │
│                         ┌────────────┐                                      │
│                         │ p_mensaje  │ Sentencia 1                          │
│                         │  := 'OK'   │                                      │
│                         └─────┬──────┘                                      │
│                               │                                             │
│                               ▼                                             │
│                      ┌─────────────────┐                                    │
│                      │ SELECT COUNT(*) │ Sentencia 2                        │
│                      └────────┬────────┘                                    │
│                               │                                             │
│                               ▼                                             │
│                    ┌────────────────────┐                                   │
│                    │   v_count = 0 ?    │ Decisión 1                        │
│                    └─────────┬──────────┘                                   │
│                    Sí        │          No                                  │
│              ┌───────────────┤                                              │
│              ▼               │                                              │
│        ┌──────────┐          │                                              │
│        │  RAISE   │ S3       │                                              │
│        │e_empleado│          │                                              │
│        └────┬─────┘          │                                              │
│             │                │                                              │
│             ▼                ▼                                              │
│        ┌─────────┐    ┌─────────────────┐                                   │
│        │EXCEPTION│    │ p_nuevo_salario │ Decisión 2                        │
│        │ HANDLER │    │     <= 0 ?      │                                   │
│        └─────────┘    └────────┬────────┘                                   │
│                       Sí       │        No                                  │
│                 ┌──────────────┤                                            │
│                 ▼              │                                            │
│           ┌──────────┐         │                                            │
│           │  RAISE   │ S4      │                                            │
│           │e_salario │         │                                            │
│           └────┬─────┘         │                                            │
│                │               │                                            │
│                ▼               ▼                                            │
│           ┌─────────┐   ┌─────────────┐                                     │
│           │EXCEPTION│   │SELECT salario│ S5                                 │
│           │ HANDLER │   └──────┬──────┘                                     │
│           └─────────┘          │                                            │
│                                ▼                                            │
│                    ┌───────────────────────┐                                │
│                    │ v_salario_final < 1000│ Decisión 3                     │
│                    └───────────┬───────────┘                                │
│                    Sí          │           No                               │
│              ┌─────────────────┤                                            │
│              ▼                 │                                            │
│        ┌───────────┐           │                                            │
│        │ajustar a  │ S6        │                                            │
│        │   1000    │           │                                            │
│        └─────┬─────┘           │                                            │
│              │                 │                                            │
│              └────────┬────────┘                                            │
│                       ▼                                                     │
│                    ┌────────────────────────┐                               │
│                    │ v_salario_final > 100000│ Decisión 4                   │
│                    └───────────┬────────────┘                               │
│                    Sí          │           No                               │
│              ┌─────────────────┤                                            │
│              ▼                 │                                            │
│        ┌───────────┐           │                                            │
│        │ajustar a  │ S7        │                                            │
│        │  100000   │           │                                            │
│        └─────┬─────┘           │                                            │
│              │                 │                                            │
│              └────────┬────────┘                                            │
│                       ▼                                                     │
│                    ┌────────────────────────┐                               │
│                    │ v_salario_actual > 0 ? │ Decisión 5                    │
│                    └───────────┬────────────┘                               │
│                    Sí          │           No                               │
│              ┌─────────────────┤                                            │
│              ▼                 │                                            │
│        ┌───────────┐           │                                            │
│        │ calcular  │ S8        │                                            │
│        │incremento │           │                                            │
│        └─────┬─────┘           │                                            │
│              │                 │                                            │
│              ▼                 │                                            │
│   ┌─────────────────────┐      │                                            │
│   │incremento > 50% ?   │ D6   │                                            │
│   └──────────┬──────────┘      │                                            │
│   Sí         │         No      │                                            │
│   ┌──────────┤                 │                                            │
│   ▼          │                 │                                            │
│┌────────┐    │                 │                                            │
││advertir│S9  │                 │                                            │
│└───┬────┘    │                 │                                            │
│    │         │                 │                                            │
│    └─────────┼─────────────────┤                                            │
│              │                 │                                            │
│              └────────┬────────┘                                            │
│                       ▼                                                     │
│                 ┌───────────┐                                               │
│                 │  UPDATE   │ S10                                           │
│                 │ empleados │                                               │
│                 └─────┬─────┘                                               │
│                       │                                                     │
│                       ▼                                                     │
│                 ┌───────────┐                                               │
│                 │  COMMIT   │ S11                                           │
│                 └─────┬─────┘                                               │
│                       │                                                     │
│                       ▼                                                     │
│                   ┌───────┐                                                 │
│                   │  END  │                                                 │
│                   └───────┘                                                 │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 4.1.3 Casos de Prueba para Cobertura de Sentencias

Para lograr **100% de cobertura de sentencias**, necesitamos ejecutar todas las líneas:

| Sentencia | Descripción | Caso que la cubre |
|-----------|-------------|-------------------|
| S1 | Inicializar mensaje | Cualquier caso |
| S2 | SELECT COUNT | Cualquier caso |
| S3 | RAISE e_empleado_no_existe | CP_S1: id=9999 |
| S4 | RAISE e_salario_invalido | CP_S2: id=101, sal=-1 |
| S5 | SELECT salario | CP_S3: id=101, sal=50000 |
| S6 | Ajustar a mínimo | CP_S4: id=101, sal=500 |
| S7 | Ajustar a máximo | CP_S5: id=101, sal=150000 |
| S8 | Calcular incremento | CP_S3 |
| S9 | Mensaje advertencia | CP_S6: id=101 (actual=30000), sal=50000 |
| S10 | UPDATE | CP_S3 |
| S11 | COMMIT | CP_S3 |

**Mínimo de casos para 100% cobertura de sentencias: 6 casos**

---

## 4.2 Cobertura de Decisiones/Ramas

### 4.2.1 Concepto

La cobertura de decisiones (o ramas) busca que **cada decisión tome los valores TRUE y FALSE** al menos una vez. Es más exhaustiva que la cobertura de sentencias.

```
                    Nº de ramas ejecutadas
Cobertura C1 = ─────────────────────────────────── × 100%
                    Nº total de ramas
```

> 💡 **Importante:** 100% de cobertura de ramas IMPLICA 100% de cobertura de sentencias, pero NO al revés.

### 4.2.2 Identificación de Decisiones

| Decisión | Condición | Rama TRUE | Rama FALSE |
|----------|-----------|-----------|------------|
| D1 | v_count = 0 | RAISE e_empleado | Continuar |
| D2 | p_nuevo_salario <= 0 | RAISE e_salario | Continuar |
| D3 | v_salario_final < 1000 | Ajustar a 1000 | Continuar |
| D4 | v_salario_final > 100000 | Ajustar a 100000 | Continuar |
| D5 | v_salario_actual > 0 | Calcular incremento | Saltar |
| D6 | v_incremento_pct > 50 | Advertencia | Continuar |

**Total: 6 decisiones × 2 ramas = 12 ramas a cubrir**

### 4.2.3 Casos de Prueba para Cobertura de Ramas

| CP | Decisiones cubiertas (T/F) | Datos |
|----|----------------------------|-------|
| CB1 | D1=T | id=9999, salario=50000 |
| CB2 | D1=F, D2=T | id=101, salario=0 |
| CB3 | D1=F, D2=F, D3=T, D4=F, D5=T, D6=F | id=101, salario=500 (actual=30000) |
| CB4 | D1=F, D2=F, D3=F, D4=T, D5=T, D6=T | id=101, salario=150000 (actual=50000) |
| CB5 | D1=F, D2=F, D3=F, D4=F, D5=T, D6=T | id=101, salario=80000 (actual=30000) |
| CB6 | D1=F, D2=F, D3=F, D4=F, D5=F*, D6=- | *(si salario_actual=0 o NULL) |

**Matriz de Cobertura de Ramas:**

| Decisión | Rama | CB1 | CB2 | CB3 | CB4 | CB5 | CB6 |
|----------|------|-----|-----|-----|-----|-----|-----|
| D1 | TRUE | ✓ | | | | | |
| D1 | FALSE | | ✓ | ✓ | ✓ | ✓ | ✓ |
| D2 | TRUE | | ✓ | | | | |
| D2 | FALSE | | | ✓ | ✓ | ✓ | ✓ |
| D3 | TRUE | | | ✓ | | | |
| D3 | FALSE | | | | ✓ | ✓ | ✓ |
| D4 | TRUE | | | | ✓ | | |
| D4 | FALSE | | | ✓ | | ✓ | ✓ |
| D5 | TRUE | | | ✓ | ✓ | ✓ | |
| D5 | FALSE | | | | | | ✓ |
| D6 | TRUE | | | | ✓ | ✓ | |
| D6 | FALSE | | | ✓ | | | |

---

## 4.3 Cobertura de Condiciones

### 4.3.1 Concepto

Cuando una decisión contiene **condiciones múltiples** (unidas por AND, OR), la cobertura de condiciones analiza cada **condición elemental** por separado.

Ejemplo de condición múltiple:
```sql
IF (edad >= 18 AND saldo > 0) THEN ...
```

### 4.3.2 Tipos de Cobertura de Condiciones

**Cobertura de Condiciones Simple:**
- Cada condición elemental debe tomar TRUE y FALSE al menos una vez
- NO garantiza todas las combinaciones

**Cobertura de Condiciones Múltiple:**
- TODAS las combinaciones posibles de TRUE/FALSE
- Para n condiciones: 2^n casos
- Muy exhaustiva pero costosa

**Cobertura Mínima de Condiciones Múltiple (MC/DC):**
- Cada condición elemental debe afectar independientemente al resultado
- Balance entre exhaustividad y número de casos

### 4.3.3 Ejemplo Hipotético

Si el procedimiento tuviera esta condición múltiple:

```sql
IF (p_nuevo_salario > 0 AND v_count > 0) THEN
```

**Cobertura Simple (2 casos mínimo):**
| Caso | p_nuevo_salario > 0 | v_count > 0 | Resultado |
|------|---------------------|-------------|-----------|
| 1 | TRUE | TRUE | TRUE |
| 2 | FALSE | FALSE | FALSE |

**Cobertura Múltiple (4 casos = 2²):**
| Caso | p_nuevo_salario > 0 | v_count > 0 | Resultado |
|------|---------------------|-------------|-----------|
| 1 | TRUE | TRUE | TRUE |
| 2 | TRUE | FALSE | FALSE |
| 3 | FALSE | TRUE | FALSE |
| 4 | FALSE | FALSE | FALSE |

**MC/DC (3 casos):**
| Caso | p_nuevo_salario > 0 | v_count > 0 | Resultado | Justificación |
|------|---------------------|-------------|-----------|---------------|
| 1 | TRUE | TRUE | TRUE | Base |
| 2 | FALSE | TRUE | FALSE | Cambio en cond.1 cambia resultado |
| 3 | TRUE | FALSE | FALSE | Cambio en cond.2 cambia resultado |

---

## 4.4 Cobertura de Caminos

### 4.4.1 Concepto

La cobertura de caminos busca ejecutar **todos los caminos posibles** a través del código. Es la más exhaustiva pero puede ser impracticable en código con bucles.

### 4.4.2 Caminos del Procedimiento

| Camino | Descripción | Secuencia de Decisiones |
|--------|-------------|-------------------------|
| C1 | Empleado no existe | D1=T → EXCEPTION |
| C2 | Salario inválido | D1=F, D2=T → EXCEPTION |
| C3 | Ajuste mínimo, sin advertencia | D1=F, D2=F, D3=T, D4=F, D5=T, D6=F |
| C4 | Ajuste mínimo, con advertencia | D1=F, D2=F, D3=T, D4=F, D5=T, D6=T |
| C5 | Ajuste máximo, sin advertencia | D1=F, D2=F, D3=F, D4=T, D5=T, D6=F |
| C6 | Ajuste máximo, con advertencia | D1=F, D2=F, D3=F, D4=T, D5=T, D6=T |
| C7 | Salario normal, sin advertencia | D1=F, D2=F, D3=F, D4=F, D5=T, D6=F |
| C8 | Salario normal, con advertencia | D1=F, D2=F, D3=F, D4=F, D5=T, D6=T |
| C9 | Salario actual = 0 (sin verificar incr.) | D1=F, D2=F, D3=F, D4=F, D5=F |

**Total: 9 caminos independientes**

---

## 4.5 Cobertura de Condiciones Simple ≠ Cobertura de Decisiones

Es importante distinguir entre estos dos tipos de cobertura cuando una decisión contiene condiciones compuestas.

- **Cobertura de Decisiones (Branch/Decision):** Cada decisión debe tomar el valor TRUE y FALSE al menos una vez (se asegura que las ramas se ejecutan).
- **Cobertura de Condiciones Simple (Condition Coverage simple):** Cada condición elemental dentro de una decisión compuesta debe tomar TRUE y FALSE al menos una vez, **sin exigir** que el resultado de la decisión cambie.

Estas metas son distintas y ninguna implica necesariamente a la otra salvo en casos sencillos (por ejemplo, decisiones con una sola condición).

Cobertura de Condiciones Simple ≠ Cobertura de Decisiones

### Ejemplos (decisión: `IF (A AND B) THEN ... ELSE ...`)

1) Decisión cubierta, condiciones NO cubiertas:

| Caso | A | B | Resultado (A AND B) |
|------|---|---|---------------------|
| 1 | TRUE  | TRUE  | TRUE  |
| 2 | TRUE  | FALSE | FALSE |

- Aquí la decisión ha tomado TRUE y FALSE (cobertura de decisiones satisfecha), pero la condición `A` nunca fue FALSE (no hay cobertura simple completa de condiciones).

2) Condiciones cubiertas, decisión NO cubierta:

| Caso | A | B | Resultado (A AND B) |
|------|---|---|---------------------|
| 1 | TRUE  | FALSE | FALSE |
| 2 | FALSE | TRUE  | FALSE |

- En estos dos casos cada condición elemental toma TRUE y FALSE al menos una vez (cobertura de condiciones simple satisfecha), pero la decisión nunca resulta TRUE (no hay cobertura de decisiones).


Son diferentes, aunque parecidas. La clave está en las condiciones compuestas:

|Tipo	            |Qué exige	                                |Ejemplo                            |
|-------------------|-------------------------------------------|-----------------------------------|
|Decisiones (C1)	|La decisión COMPLETA sea TRUE y FALSE	    |(A>0 AND B>0) = TRUE y FALSE       |
|Condiciones Simple	|Cada condición ELEMENTAL sea TRUE y FALSE	|A>0 = TRUE/FALSE, B>0 = TRUE/FALSE |

Problema: La cobertura de condiciones simple puede NO cumplir la de decisiones:

|Caso	|A > 0	|B > 0	|Decisión (A>0 AND B>0)|
|-------|-------|-------|----------------------|
|1	    |TRUE	|FALSE	|FALSE                 |
|2	    |FALSE	|TRUE	|FALSE                 |

✅ Cada condición elemental fue TRUE y FALSE
❌ ¡Pero la decisión NUNCA fue TRUE!

Cobertura de Condiciones Múltiple ≠ Cobertura de Caminos
También son diferentes:

|Tipo	                |Alcance	            |Foco                                                               |
|-----------------------|-----------------------|-------------------------------------------------------------------|
|Condiciones Múltiple	|UNA decisión compuesta	|Todas las combinaciones 2^n de sus condiciones elementales         |
|Caminos	T           |ODO el programa	    |Todos los caminos posibles (incluyendo bucles, múltiples IFs, etc.)|

Ejemplo:
```sql
    -- Decisión 1
    IF (A > 0 AND B > 0) THEN
        x := 1;
    END IF;

    -- Decisión 2  
    IF (C > 0) THEN
        y := 2;
    END IF;
```

- Condiciones Múltiple de D1: 4 combinaciones (TT, TF, FT, FF)
- Caminos del programa: Combina D1 × D2 = muchos más caminos

### Consecuencia práctica

- Para decisiones compuestas, alcanzar cobertura de condiciones simple no garantiza que ambas ramas de la decisión se hayan ejecutado. Y alcanzar cobertura de decisiones no garantiza que cada condición elemental haya sido probada en ambos valores.
- Por eso, en entornos críticos se suele exigir **MC/DC** (o una combinación de cobertura de decisiones más análisis de condiciones) para garantizar que cada condición puede afectar independientemente al resultado de la decisión.

---

Resumen de Jerarquía
```html
<pre>
┌─────────────────────────────────────────────────────────────────┐
│                    JERARQUÍA DE COBERTURAS                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   Cobertura de Caminos (la más exhaustiva)                      │
│         ▲                                                       │
│         │ implica                                               │
│         │                                                       │
│   Cobertura de Condiciones Múltiple                             │
│         ▲                                                       │
│         │ implica                                               │
│         │                                                       │
│   Cobertura de Decisiones (C1)  ◄───┐                           │
│         ▲                           │ NO se implican            │
│         │ implica                   │ mutuamente                │
│         │                           │                           │
│   Cobertura de Sentencias (C0)      │                           │
│                                     │                           │
│   Cobertura de Condiciones Simple ──┘                           │
│   (puede NO implicar decisiones)                                │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
</pre>
```

En resumen:

- Condiciones Simple y Decisiones son independientes (ninguna implica la otra)
- Condiciones Múltiple implica Decisiones (pero no es lo mismo que Caminos)
- Caminos es la más amplia de todas


## 4.6 Complejidad Ciclomática

### 4.6.1 Concepto

La complejidad ciclomática (V(G)) es una métrica que mide la **complejidad lógica** del código. Define el número de **caminos independientes** y el límite superior de casos de prueba necesarios.

### 4.6.2 Fórmulas de Cálculo

```
V(G) = E - N + 2

Donde:
  E = Número de aristas (flechas)
  N = Número de nodos

También:
  V(G) = Número de regiones cerradas + 1
  V(G) = Número de nodos predicado + 1
```

### 4.6.3 Cálculo para el Procedimiento

**Nodos predicado (decisiones):** 6
- D1: v_count = 0
- D2: p_nuevo_salario <= 0
- D3: v_salario_final < 1000
- D4: v_salario_final > 100000
- D5: v_salario_actual > 0
- D6: v_incremento_pct > 50

```
V(G) = 6 + 1 = 7
```

### 4.6.4 Interpretación

| Complejidad | Evaluación de Riesgo |
|-------------|---------------------|
| 1-10 | Programa simple, bajo riesgo |
| 11-20 | Más complejo, riesgo moderado |
| 21-50 | Complejo, alto riesgo |
| > 50 | Muy alto riesgo, difícil de probar |

**Nuestro procedimiento tiene V(G) = 7** → Programa simple, bajo riesgo.

> 💡 **Recomendación:** McCabe sugiere que V(G) no debe superar 10. Si lo supera, considerar refactorizar el código.

---

## 4.7 Pruebas de Mutación

### 4.7.1 Concepto

Las pruebas de mutación evalúan la **calidad de los casos de prueba** introduciendo pequeños cambios (mutantes) en el código. Si los casos de prueba son buenos, deben **detectar (matar)** los mutantes.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    PROCESO DE MUTACIÓN                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   CÓDIGO ORIGINAL              MUTANTE                                      │
│   ────────────────             ───────                                      │
│   IF x > 0 THEN           →    IF x >= 0 THEN    (cambio de operador)      │
│   y := x + 1              →    y := x + 2        (cambio de constante)     │
│   IF a AND b THEN         →    IF a OR b THEN    (cambio de operador)      │
│                                                                             │
│   Si el caso de prueba detecta diferencia → MUTANTE MUERTO ✓               │
│   Si el caso de prueba NO detecta diferencia → MUTANTE VIVO ✗              │
│                                                                             │
│                        Mutantes muertos                                     │
│   Mutation Score = ─────────────────────── × 100%                          │
│                      Total de mutantes                                      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 4.7.2 Tipos de Mutaciones Comunes

| Tipo | Original | Mutante |
|------|----------|---------|
| **Operador relacional** | `>` | `>=`, `<`, `=` |
| **Operador aritmético** | `+` | `-`, `*`, `/` |
| **Operador lógico** | `AND` | `OR` |
| **Constante** | `1000` | `1001`, `999` |
| **Variable** | `x` | `y` |
| **Eliminación** | `IF cond THEN` | `-- IF cond THEN` |

### 4.7.3 Ejemplo de Mutantes en el Procedimiento

**Mutante 1:** Cambiar operador en validación de salario
```sql
-- Original
IF p_nuevo_salario <= 0 THEN

-- Mutante
IF p_nuevo_salario < 0 THEN   -- Permite salario = 0
```

**Test que lo mata:** `p_nuevo_salario = 0`
- Original: ERROR (salario inválido)
- Mutante: Procesa (no detecta error)
- **¡Diferencia detectada! Mutante muerto ✓**

**Mutante 2:** Cambiar constante de salario mínimo
```sql
-- Original
c_salario_minimo CONSTANT NUMBER := 1000;

-- Mutante
c_salario_minimo CONSTANT NUMBER := 1001;
```

**Test que lo mata:** `p_nuevo_salario = 1000`
- Original: Salario = 1000 (no se ajusta)
- Mutante: Salario = 1001 (se ajusta porque 1000 < 1001)
- **¡Diferencia detectada! Mutante muerto ✓**

**Mutante 3:** Cambiar operador de comparación de incremento
```sql
-- Original
IF v_incremento_pct > c_incremento_max THEN

-- Mutante
IF v_incremento_pct >= c_incremento_max THEN
```

**Test que lo mata:** Incremento exactamente del 50%
- Original: No genera advertencia (50 no es > 50)
- Mutante: Genera advertencia (50 >= 50)
- **¡Diferencia detectada! Mutante muerto ✓**

---

# 5. Ejercicios Resueltos

## Ejercicio 1: Clases de Equivalencia (Caja Negra)

**Enunciado:** Un sistema de préstamos bancarios tiene las siguientes reglas:
- Monto del préstamo: entre 1.000€ y 50.000€
- Plazo: 12, 24, 36 o 60 meses
- Edad del solicitante: entre 18 y 65 años

Identifica las clases de equivalencia y diseña casos de prueba.

**Solución:**

| Variable | CE | Descripción | Estado | Representante |
|----------|-----|-------------|--------|---------------|
| Monto | CE1 | x < 1000 | Inválido | 500 |
| | CE2 | 1000 ≤ x ≤ 50000 | Válido | 25000 |
| | CE3 | x > 50000 | Inválido | 75000 |
| Plazo | CE4 | x ∈ {12, 24, 36, 60} | Válido | 24 |
| | CE5 | x ∉ {12, 24, 36, 60} | Inválido | 18 |
| Edad | CE6 | x < 18 | Inválido | 15 |
| | CE7 | 18 ≤ x ≤ 65 | Válido | 40 |
| | CE8 | x > 65 | Inválido | 70 |

**Casos de prueba:**

| CP | Monto | Plazo | Edad | Resultado |
|----|-------|-------|------|-----------|
| CP1 | 25000 (CE2) | 24 (CE4) | 40 (CE7) | APROBADO |
| CP2 | 500 (CE1) | 24 (CE4) | 40 (CE7) | ERROR monto |
| CP3 | 75000 (CE3) | 24 (CE4) | 40 (CE7) | ERROR monto |
| CP4 | 25000 (CE2) | 18 (CE5) | 40 (CE7) | ERROR plazo |
| CP5 | 25000 (CE2) | 24 (CE4) | 15 (CE6) | ERROR edad |
| CP6 | 25000 (CE2) | 24 (CE4) | 70 (CE8) | ERROR edad |

---

## Ejercicio 2: Valores Límite (Caja Negra)

**Enunciado:** Para el mismo sistema de préstamos, diseña casos de prueba usando valores límite para el monto (1.000€ - 50.000€).

**Solución:**

| CP | Monto | Resultado Esperado |
|----|-------|-------------------|
| VL1 | 999 | ERROR: Monto insuficiente |
| VL2 | 1000 | ACEPTADO (límite inferior) |
| VL3 | 1001 | ACEPTADO |
| VL4 | 49999 | ACEPTADO |
| VL5 | 50000 | ACEPTADO (límite superior) |
| VL6 | 50001 | ERROR: Monto excedido |

---

## Ejercicio 3: Cobertura de Sentencias (Caja Blanca)

**Enunciado:** Dado el siguiente código, ¿cuántos casos de prueba necesitas para 100% de cobertura de sentencias?

```sql
IF A > B THEN
    C := A - B;
ELSE
    C := A + B;
END IF;

IF C > 10 THEN
    D := C * 2;
END IF;
```

**Solución:**

Sentencias a cubrir:
- S1: `C := A - B` (rama IF)
- S2: `C := A + B` (rama ELSE)
- S3: `D := C * 2` (rama IF del segundo IF)

**Mínimo 2 casos de prueba:**

| CP | A | B | Sentencias cubiertas | Resultado |
|----|---|---|---------------------|-----------|
| 1 | 15 | 3 | S1 (A>B), S3 (C=12>10) | C=12, D=24 |
| 2 | 3 | 5 | S2 (A≤B), (C=8, no >10) | C=8, D=sin asignar |

**Cobertura: 100%** (3/3 sentencias)

---

## Ejercicio 4: Cobertura de Ramas (Caja Blanca)

**Enunciado:** Para el mismo código del ejercicio anterior, ¿cuántos casos para 100% de cobertura de ramas?

**Solución:**

| Decisión | Rama TRUE | Rama FALSE |
|----------|-----------|------------|
| D1: A > B | C := A - B | C := A + B |
| D2: C > 10 | D := C * 2 | (nada) |

**Mínimo 2 casos de prueba:**

| CP | A | B | D1 | D2 | Ramas cubiertas |
|----|---|---|----|----|-----------------|
| 1 | 15 | 3 | TRUE | TRUE (C=12) | D1-T, D2-T |
| 2 | 3 | 5 | FALSE | FALSE (C=8) | D1-F, D2-F |

**Cobertura: 100%** (4/4 ramas)

---

## Ejercicio 5: Complejidad Ciclomática (Caja Blanca)

**Enunciado:** Calcula la complejidad ciclomática del siguiente código:

```sql
IF condicion1 THEN
    IF condicion2 THEN
        accion1;
    ELSE
        accion2;
    END IF;
ELSE
    IF condicion3 THEN
        accion3;
    END IF;
END IF;
```

**Solución:**

Nodos predicado (decisiones): 3
- condicion1
- condicion2
- condicion3

```
V(G) = Nodos predicado + 1 = 3 + 1 = 4
```

**Interpretación:** El código tiene 4 caminos independientes y requiere al menos 4 casos de prueba para cobertura de caminos.

---

## Ejercicio 6: Cobertura Condiciones vs Decisiones (Caja Blanca)

**Enunciado:** Dado el siguiente fragmento:

```sql
IF (A AND B) THEN
    S1;
ELSE
    S2;
END IF;
```

a) Diseña un conjunto mínimo de casos de prueba que logren **cobertura de decisiones** pero NO cubran completamente las **condiciones simples**.
b) Diseña un conjunto mínimo de casos de prueba que cubran **las condiciones simples** pero NO logren cobertura de decisiones.

**Solución:**

a) Cobertura de decisiones (mínimo 2 casos):

| CP | A | B | Resultado |
|----|---|---|----------:|
| 1  | TRUE  | TRUE  | TRUE |
| 2  | TRUE  | FALSE | FALSE |

- La decisión toma TRUE y FALSE; sin embargo, la condición `A` nunca fue FALSE.

b) Cobertura de condiciones simples (mínimo 2 casos):

| CP | A | B | Resultado |
|----|---|---|----------:|
| 1  | TRUE  | FALSE | FALSE |
| 2  | FALSE | TRUE  | FALSE |

- Cada condición elemental toma TRUE y FALSE al menos una vez, pero la decisión nunca resulta TRUE.

**Comentario:** Comparar ambos conjuntos en clase y discutir por qué MC/DC es necesario en entornos críticos.

# 6. Ejercicios Propuestos

## Ejercicio 1: Clases de Equivalencia

Un sistema de calificación tiene estas reglas:
- Nota de 0 a 100
- 0-49: Suspenso
- 50-69: Aprobado
- 70-89: Notable
- 90-100: Sobresaliente

**Tarea:** Identifica las clases de equivalencia (válidas e inválidas) y diseña casos de prueba.

---

## Ejercicio 2: Tabla de Decisión

Un sistema de descuentos aplica:
- 10% si el cliente es premium
- 5% si la compra supera 100€
- Los descuentos son acumulables

**Tarea:** Construye la tabla de decisión y deriva los casos de prueba.

---

## Ejercicio 3: Cobertura de Código

```sql
PROCEDURE calcular_bono(
    p_ventas     IN NUMBER,
    p_antiguedad IN NUMBER,
    p_bono       OUT NUMBER
) IS
BEGIN
    IF p_ventas > 10000 THEN
        IF p_antiguedad > 5 THEN
            p_bono := p_ventas * 0.10;
        ELSE
            p_bono := p_ventas * 0.05;
        END IF;
    ELSE
        IF p_antiguedad > 10 THEN
            p_bono := 500;
        ELSE
            p_bono := 0;
        END IF;
    END IF;
END;
```

**Tareas:**
a) Dibuja el grafo de flujo de control
b) Calcula la complejidad ciclomática
c) Diseña casos para 100% de cobertura de sentencias
d) Diseña casos para 100% de cobertura de ramas
e) Identifica los caminos independientes

---

## Ejercicio 4: Pruebas de Mutación

Para el procedimiento `validar_ajustar_salario`, propón 3 mutantes diferentes y diseña casos de prueba que los "maten".

---

## Ejercicio 5: Caso Práctico Completo

Diseña un conjunto completo de pruebas para el procedimiento `validar_ajustar_salario` que incluya:
1. Clases de equivalencia
2. Valores límite
3. Casos para 100% de cobertura de ramas
4. Al menos 5 mutantes y sus casos de prueba

---

# 📚 Resumen Final

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    RESUMEN DE TÉCNICAS                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   CAJA NEGRA (QUÉ hace)              CAJA BLANCA (CÓMO lo hace)            │
│   ─────────────────────              ──────────────────────────            │
│                                                                             │
│   Clases de Equivalencia             Cobertura de Sentencias (C0)          │
│   → Agrupar valores similares        → Ejecutar todas las líneas           │
│                                                                             │
│   Valores Límite                     Cobertura de Ramas (C1)               │
│   → Probar los bordes                → Cada decisión TRUE y FALSE          │
│                                                                             │
│   Tablas de Decisión                 Cobertura de Condiciones              │
│   → Lógica compleja                  → Condiciones múltiples               │
│                                                                             │
│   Transición de Estados              Cobertura de Caminos                  │
│   → Sistemas con memoria             → Todos los caminos posibles          │
│                                                                             │
│   Casos de Uso                       Complejidad Ciclomática               │
│   → Escenarios reales                → Medir complejidad                   │
│                                                                             │
│                                      Pruebas de Mutación                   │
│                                      → Evaluar calidad de tests            │
│                                                                             │
│   ────────────────────────────────────────────────────────────────────     │
│                                                                             │
│   💡 Son COMPLEMENTARIAS: Un software puede pasar pruebas de caja negra    │
│      pero tener código muerto. Puede pasar caja blanca pero no cumplir     │
│      los requisitos. ¡USA AMBAS!                                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

> 📖 **Referencias:**
> - IEEE Standard for Software Testing
> - ISTQB Foundation Level Syllabus
> - Transparencias del Curso de Testing EOI 2025-2026
