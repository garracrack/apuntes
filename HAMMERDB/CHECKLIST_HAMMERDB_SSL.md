# ✅ CHECKLIST RÁPIDO: HammerDB + XAMPP + SSL

## 🎯 OBJETIVO
Configurar SSL en MySQL (XAMPP) para que HammerDB pueda conectarse correctamente.

---

## 📋 ANTES DE EMPEZAR

- [ ] XAMPP instalado
- [ ] MySQL corriendo (puerto 3306)
- [ ] HammerDB instalado
- [ ] PowerShell abierto **como Administrador**

**Verificar MySQL corriendo:**
```powershell
netstat -an | findstr :3306
```

---

## 🚀 OPCIÓN A: SCRIPT AUTOMÁTICO (5 minutos)

### Paso 1: Descargar archivos del profesor
- [ ] `setup_hammerdb_ssl.ps1`
- [ ] `GUIA_ESTUDIANTES_HAMMERDB_SSL.md`

### Paso 2: Ejecutar script
```powershell
cd d:\xampp
.\setup_hammerdb_ssl.ps1
```

### Paso 3: Configurar HammerDB
- [ ] Abrir HammerDB GUI
- [ ] Benchmark → TPC-C
- [ ] Database → MariaDB
- [ ] Options → Connection → Enable SSL ☑
- [ ] SSL CA: `d:/xampp/mysql/data/ca.pem`
- [ ] Click OK

✅ **¡LISTO!**

---

## 🛠️ OPCIÓN B: MANUAL (15 minutos)

### PASO 1: Generar Certificados (copiar y pegar en PowerShell)

```powershell
cd d:\xampp\mysql\data

cmd /c "d:\xampp\apache\bin\openssl.exe genrsa 2048 > ca-key.pem 2>nul"

cmd /c "d:\xampp\apache\bin\openssl.exe req -new -x509 -nodes -days 3650 -key ca-key.pem -out ca.pem -subj /C=ES/ST=Madrid/L=Madrid/O=Student/OU=Database/CN=MySQL_CA 2>nul"

cmd /c "d:\xampp\apache\bin\openssl.exe genrsa 2048 > server-key.pem 2>nul"

cmd /c "d:\xampp\apache\bin\openssl.exe req -new -key server-key.pem -out server-req.pem -subj /C=ES/ST=Madrid/L=Madrid/O=Student/OU=Database/CN=localhost 2>nul"

cmd /c "d:\xampp\apache\bin\openssl.exe x509 -req -in server-req.pem -days 3650 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem 2>nul"
```

**Verificar:**
```powershell
Get-ChildItem *.pem | Select-Object Name, Length
```

Debes ver: `ca.pem`, `server-cert.pem`, `server-key.pem`

---

### PASO 2: Editar my.ini

- [ ] Abrir Notepad++ **como Administrador**
- [ ] Abrir archivo: `d:\xampp\mysql\bin\my.ini`
- [ ] Buscar: `log_error="mysql_error.log"`
- [ ] Agregar DESPUÉS estas líneas:

```ini

# SSL Configuration (para HammerDB)
ssl-ca=ca.pem
ssl-cert=server-cert.pem
ssl-key=server-key.pem
```

- [ ] Guardar (Ctrl+S)

---

### PASO 3: Reiniciar MySQL

```powershell
d:\xampp\mysql_stop.bat
Start-Sleep -Seconds 3
d:\xampp\mysql_start.bat
Start-Sleep -Seconds 5
```

---

### PASO 4: Verificar SSL

```powershell
d:\xampp\mysql\bin\mysql.exe -u root -e "SHOW VARIABLES LIKE 'have_ssl';"
```

**Resultado esperado:**
```
have_ssl | YES
```

✅ Si dice **YES** → Perfecto, continúa

❌ Si dice **DISABLED** → Revisa los pasos anteriores

---

### PASO 5: Configurar HammerDB

#### Abrir HammerDB GUI
```
C:\Program Files\HammerDB-5.0\hammerdb.exe
```

#### Configuración Básica
- [ ] Benchmark → **TPC-C**
- [ ] Database → **MariaDB**

#### Configuración de Conexión
**Options → MariaDB → Connection:**

```
MariaDB Host:        localhost
MariaDB Port:        3306
MariaDB User:        root
MariaDB Password:    (vacío)
Database:            test
```

#### Configuración SSL - DOS OPCIONES:

**OPCIÓN 1 - CON SSL (Recomendado primero):**
```
☑ Enable SSL:       MARCADO
⚫ SSL One-Way:      SELECCIONADO
SSL CApath:         (VACÍO)
SSL CA:             d:/xampp/mysql/data/ca.pem
SSL Cert:           (VACÍO)
SSL Key:            (VACÍO)
SSL Cipher:         (VACÍO)
```

⚠️ **IMPORTANTE:** 
- Usa `/` (forward slash) no `\`
- NO pongas comillas
- Solo llena SSL CA

**OPCIÓN 2 - SIN SSL (Si falla la Opción 1):**
```
☐ Enable SSL:       DESMARCADO
(Todo lo demás deshabilitado)
```

#### Probar Conexión
- [ ] Click **OK**
- [ ] Schema → Build
- [ ] Si conecta correctamente → ✅ **¡LISTO!**

---

## 🔧 PROBLEMAS COMUNES

### ❌ Error: "SSL CApath is not valid directory"
**Solución:** Deja SSL CApath **VACÍO**, solo llena SSL CA

### ❌ Error: "missing value to go with key"
**Solución:** Desmarca Enable SSL (usa conexión sin SSL)

### ❌ MySQL no arranca después de editar my.ini
**Solución:** 
1. Ver errores:
```powershell
Get-Content "d:\xampp\mysql\data\mysql_error.log" -Tail 20
```
2. Si no funciona, elimina las líneas SSL de my.ini

### ❌ have_ssl = DISABLED
**Solución:**
1. Verifica que los archivos .pem existen:
```powershell
Test-Path d:\xampp\mysql\data\ca.pem
Test-Path d:\xampp\mysql\data\server-cert.pem
Test-Path d:\xampp\mysql\data\server-key.pem
```
2. Verifica my.ini tiene las líneas SSL
3. Reinicia MySQL de nuevo

---

## 📞 AYUDA

Si nada funciona:
1. Captura pantalla del error
2. Ejecuta y guarda resultado:
```powershell
d:\xampp\mysql\bin\mysql.exe -u root -e "SHOW VARIABLES LIKE '%ssl%';"
```
3. Muestra al profesor

---

## 🎓 RESUMEN

**CON SSL configurado, MySQL acepta AMBOS tipos de conexión:**
- ✅ Con SSL (cifrada) - Enable SSL marcado
- ✅ Sin SSL (sin cifrar) - Enable SSL desmarcado

**Para prácticas locales, sin SSL es suficiente.**

---

## ⏱️ TIEMPOS ESTIMADOS

- Script automático: **5 minutos**
- Configuración manual: **15 minutos**
- Troubleshooting (si hay problemas): **10-30 minutos**

---

**Versión:** 1.0 | **Fecha:** Marzo 2026 | **Probado con:** XAMPP 8.2.12, MariaDB 10.4.32, HammerDB 5.0
