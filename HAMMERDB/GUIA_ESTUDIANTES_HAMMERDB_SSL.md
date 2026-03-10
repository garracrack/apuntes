# Guía Completa: Configurar HammerDB con XAMPP MariaDB

## 📋 ÍNDICE
1. [Descripción del Problema](#problema)
2. [Prerequisitos](#prerequisitos)
3. [Paso 1: Generar Certificados SSL](#paso-1)
4. [Paso 2: Configurar MySQL para SSL](#paso-2)
5. [Paso 3: Reiniciar MySQL](#paso-3)
6. [Paso 4: Verificar SSL](#paso-4)
7. [Paso 5: Crear Usuario MySQL](#paso-5)
8. [Paso 6: Configurar HammerDB GUI](#paso-6)
9. [Verificación Final](#verificacion)
10. [Troubleshooting](#troubleshooting)

---

## 🔴 DESCRIPCIÓN DEL PROBLEMA {#problema}

**Síntoma:** HammerDB muestra el error:
```
TLS/SSL error: SSL is required, but the server does not support it
```

**Causa:** HammerDB versión 4.10+ requiere SSL para conectarse a MariaDB, pero XAMPP por defecto NO tiene SSL habilitado en MySQL.

**Solución:** Generar certificados SSL y configurar MySQL para soportar conexiones SSL (luego podrás usar con o sin SSL).

---

## ✅ PREREQUISITOS {#prerequisitos}

Antes de empezar, verifica que tienes:

- ✅ XAMPP instalado (con MySQL/MariaDB)
- ✅ HammerDB instalado (versión 4.10 o 5.0)
- ✅ MySQL corriendo en puerto 3306
- ✅ PowerShell (viene con Windows)

**Verificar que MySQL está corriendo:**
```powershell
netstat -an | findstr :3306
```
Debe mostrar algo como: `TCP    0.0.0.0:3306`

---

## 📝 PASO 1: GENERAR CERTIFICADOS SSL {#paso-1}

### 1.1 Abrir PowerShell como Administrador
1. Click derecho en el botón de Windows
2. Seleccionar "Windows PowerShell (Administrador)"

### 1.2 Navegar al directorio de datos de MySQL
```powershell
cd d:\xampp\mysql\data
```
⚠️ **IMPORTANTE:** Si tu XAMPP está en otra ruta (ej: `c:\xampp`), ajusta el comando.

### 1.3 Generar certificado CA (Certificate Authority)

**Paso A - Generar clave privada CA:**
```powershell
cmd /c "d:\xampp\apache\bin\openssl.exe genrsa 2048 > ca-key.pem 2>nul"
```

**Paso B - Generar certificado CA:**
```powershell
cmd /c "d:\xampp\apache\bin\openssl.exe req -new -x509 -nodes -days 3650 -key ca-key.pem -out ca.pem -subj /C=ES/ST=Madrid/L=Madrid/O=Student/OU=Database/CN=MySQL_CA 2>nul"
```

### 1.4 Generar certificado del servidor

**Paso A - Generar clave privada del servidor:**
```powershell
cmd /c "d:\xampp\apache\bin\openssl.exe genrsa 2048 > server-key.pem 2>nul"
```

**Paso B - Generar solicitud de certificado:**
```powershell
cmd /c "d:\xampp\apache\bin\openssl.exe req -new -key server-key.pem -out server-req.pem -subj /C=ES/ST=Madrid/L=Madrid/O=Student/OU=Database/CN=localhost 2>nul"
```

**Paso C - Firmar certificado del servidor:**
```powershell
cmd /c "d:\xampp\apache\bin\openssl.exe x509 -req -in server-req.pem -days 3650 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem 2>nul"
```

### 1.5 Limpiar archivos temporales
```powershell
Remove-Item server-req.pem -Force -ErrorAction SilentlyContinue
```

### 1.6 Verificar certificados generados
```powershell
Get-ChildItem *.pem | Select-Object Name, Length
```

**Debes ver estos archivos:**
```
Name            Length
----            ------
ca-key.pem      ~1700
ca.pem          ~1300
server-cert.pem ~1200
server-key.pem  ~1700
```

✅ Si ves estos 4 archivos con tamaños similares, **¡perfecto!**

---

## ⚙️ PASO 2: CONFIGURAR MYSQL PARA SSL {#paso-2}

### 2.1 Abrir archivo de configuración de MySQL

**Ubicación del archivo:** `d:\xampp\mysql\bin\my.ini`

Abre este archivo con **Bloc de notas** o **Notepad++** (como Administrador).

### 2.2 Buscar la sección [mysqld]

Busca en el archivo la línea que dice:
```ini
[mysqld]
```

### 2.3 Agregar configuración SSL

Busca la línea que dice:
```ini
log_error="mysql_error.log"
```

Justo DESPUÉS de esa línea, agrega estas 5 líneas:
```ini

# SSL Configuration (para HammerDB)
ssl-ca=ca.pem
ssl-cert=server-cert.pem
ssl-key=server-key.pem
```

### 2.4 Guardar el archivo

⚠️ **IMPORTANTE:** 
- Guarda el archivo (Ctrl+S)
- Si te dice "Acceso denegado", cierra el bloc de notas y ábrelo como Administrador
- Click derecho en Notepad → "Ejecutar como administrador" → Abrir my.ini

---

## 🔄 PASO 3: REINICIAR MYSQL {#paso-3}

### 3.1 Detener MySQL

**Opción A - Usando script de XAMPP:**
```powershell
d:\xampp\mysql_stop.bat
```

**Opción B - Panel de Control de XAMPP:**
1. Abrir XAMPP Control Panel
2. Click en "Stop" junto a MySQL
3. Esperar hasta que diga "Stopped"

### 3.2 Esperar 3 segundos
```powershell
Start-Sleep -Seconds 3
```

### 3.3 Iniciar MySQL

**Opción A - Usando script de XAMPP:**
```powershell
d:\xampp\mysql_start.bat
```

**Opción B - Panel de Control de XAMPP:**
1. Click en "Start" junto a MySQL
2. Esperar hasta que diga "Running"
3. Debe mostrar puerto 3306

### 3.4 Verificar que MySQL inició correctamente

```powershell
netstat -an | findstr :3306
```

Debe mostrar: `TCP    0.0.0.0:3306`

---

## ✔️ PASO 4: VERIFICAR SSL HABILITADO {#paso-4}

### 4.1 Abrir PowerShell (no necesita ser Administrador)

### 4.2 Verificar estado SSL
```powershell
d:\xampp\mysql\bin\mysql.exe -u root -h 127.0.0.1 -e "SHOW VARIABLES LIKE 'have_ssl';"
```

**Resultado esperado:**
```
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| have_ssl      | YES   |
+---------------+-------+
```

✅ Si dice **"YES"** → ¡SSL está habilitado correctamente!

❌ Si dice **"DISABLED"** → Revisa los pasos anteriores, especialmente:
- Verifica que los archivos .pem existen en `d:\xampp\mysql\data\`
- Verifica que editaste correctamente `my.ini`
- Reinicia MySQL de nuevo

### 4.3 Verificar rutas de certificados
```powershell
d:\xampp\mysql\bin\mysql.exe -u root -h 127.0.0.1 -e "SHOW VARIABLES LIKE 'ssl%';"
```

**Resultado esperado:**
```
ssl_ca          | ca.pem
ssl_cert        | server-cert.pem
ssl_key         | server-key.pem
```

---

## � PASO 5: CREAR USUARIO MYSQL {#paso-5}

### 5.1 ¿Por qué crear un usuario?

**IMPORTANTE:** Por seguridad y para evitar problemas de conexión, es **recomendado crear un usuario dedicado** con contraseña en lugar de usar root sin contraseña.

### 5.2 Crear usuario desde PowerShell

```powershell
d:\xampp\mysql\bin\mysql.exe -u root -h 127.0.0.1 -e "CREATE USER 'tpcc'@'localhost' IDENTIFIED BY 'tpcc'; GRANT ALL PRIVILEGES ON *.* TO 'tpcc'@'localhost'; CREATE USER 'tpcc'@'%' IDENTIFIED BY 'tpcc'; GRANT ALL PRIVILEGES ON *.* TO 'tpcc'@'%'; FLUSH PRIVILEGES;"
```

**Explicación:**
- Crea usuario: `tpcc`
- Contraseña: `tpcc`
- Permisos: Todos (`ALL PRIVILEGES`)
- Conexiones desde: localhost y cualquier host (`%`)

### 5.3 Verificar usuario creado

```powershell
d:\xampp\mysql\bin\mysql.exe -u tpcc -ptpcc -e "SELECT USER(), CURRENT_USER();"
```

**Resultado esperado:**
```
+----------------+----------------+
| USER()         | CURRENT_USER() |
+----------------+----------------+
| tpcc@localhost | tpcc@localhost |
+----------------+----------------+
```

✅ Si ves esto, el usuario fue creado correctamente.

### 5.4 Crear base de datos tpcc

**IMPORTANTE:** HammerDB necesita que exista una base de datos llamada `tpcc` para el benchmark TPC-C.

```powershell
d:\xampp\mysql\bin\mysql.exe -u root -h 127.0.0.1 -e "CREATE DATABASE IF NOT EXISTS tpcc CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
```

**Verificar base de datos creada:**

```powershell
d:\xampp\mysql\bin\mysql.exe -u tpcc -ptpcc -e "SHOW DATABASES;"
```

**Deberías ver:**
```
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql             |
| performance_schema |
| tpcc              |
| test              |
+--------------------+
```

✅ Si ves la base de datos `tpcc`, está lista para usarse con HammerDB.

**Nota:** Si usas el **script automático** (`setup_hammerdb_ssl.ps1`), este paso se hace automáticamente.

---

## 🖥️ PASO 6: CONFIGURAR HAMMERDB GUI {#paso-6}

### 6.1 Abrir HammerDB

```powershell
"C:\Program Files\HammerDB-5.0\hammerdb.exe"
```

O busca HammerDB en el menú de Windows.

### 6.2 Seleccionar Benchmark

1. En la barra superior, click en **"Benchmark"**
2. Seleccionar **"TPC-C"**

### 6.3 Seleccionar Base de Datos

1. Click en **"Database"**
2. Seleccionar **"MariaDB"**

### 6.4 Configurar Conexión

1. Click en **"Options"**
2. Expandir **"MariaDB"** en el árbol de la izquierda
3. Click en **"Connection"**

### 6.5 Llenar los campos de conexión

```
MariaDB Host: localhost
MariaDB Port: 3306
MariaDB Socket: null
```

### 6.6 Configurar SSL

**OPCIÓN A - CON SSL (Recomendado primero):**
```
☑ Enable SSL: MARCADO
⚫ SSL One-Way: SELECCIONADO (círculo marcado)
⚪ SSL Two-Way: NO seleccionado

SSL CApath: (DEJAR VACÍO)
SSL CA: d:/xampp/mysql/data/ca.pem
SSL Cert: (DEJAR VACÍO)
SSL Key: (DEJAR VACÍO)
SSL Cipher: (DEJAR VACÍO)
```

⚠️ **NOTAS IMPORTANTES:**
- Usa **forward slashes** `/` no backslashes `\`
- **NO** pongas comillas
- **SSL CApath** debe estar **VACÍO**
- Solo llena **SSL CA** con la ruta completa al archivo `ca.pem`

**OPCIÓN B - SIN SSL (Si Opción A falla o para simplificar):**
```
☐ Enable SSL: DESMARCADO
(Todos los campos SSL deshabilitados)
```

### 6.7 Configurar Usuario y Base de Datos

**CONFIGURACIÓN RECOMENDADA (usuario creado en Paso 5):**
```
MariaDB User: tpcc
MariaDB User Password: tpcc
TPROC-C MariaDB Database: test
```

⚠️ **ALTERNATIVA (si prefieres usar root):**
```
MariaDB User: root
MariaDB User Password: (dejar vacío si no configuraste password)
TPROC-C MariaDB Database: test
```

👉 **NOTA:** Si creaste una base de datos `tpcc` dedicada:
```
TPROC-C MariaDB Database: tpcc
```

### 6.8 Aplicar Configuración

1. Click en **"OK"** en la parte inferior de la ventana
2. Esperar mensaje de confirmación

---

## 🎯 VERIFICACIÓN FINAL {#verificacion}

### Test 1: Verificar conexión desde HammerDB

1. En HammerDB, ir a **"Schema"**
2. Expandir **"TPC-C Schema Options"**
3. Configurar:
   ```
   Number of Warehouses: 1
   Virtual Users to Build Schema: 1
   ```
4. Click en **"Schema Build"**
5. Click en **"Build"**

**Resultado esperado:**
```
Checking schema...
Connection successful
```

### Test 2: Verificar desde línea de comandos

```powershell
d:\xampp\mysql\bin\mysql.exe -u root --ssl -h localhost -e "SELECT 'SSL OK' AS Test;"
```

**Resultado esperado:**
```
+--------+
| Test   |
+--------+
| SSL OK |
+--------+
```

### Test 3: Ver si la conexión usa SSL

```powershell
d:\xampp\mysql\bin\mysql.exe -u root --ssl -h localhost -e "STATUS;" | findstr SSL
```

**Resultado esperado:**
```
SSL: Cipher in use is ECDHE-RSA-AES256-GCM-SHA384
```

---

## 🔧 TROUBLESHOOTING {#troubleshooting}

### Problema 1: "have_ssl: DISABLED"

**Causa:** Los certificados no están en la ubicación correcta o my.ini no se guardó bien.

**Solución:**
```powershell
# Verificar certificados existen
Test-Path d:\xampp\mysql\data\ca.pem
Test-Path d:\xampp\mysql\data\server-cert.pem
Test-Path d:\xampp\mysql\data\server-key.pem

# Si alguno es False, repite PASO 1
```

Verifica `my.ini`:
```powershell
Select-String -Path "d:\xampp\mysql\bin\my.ini" -Pattern "ssl-ca"
```
Debe mostrar: `ssl-ca=ca.pem`

---

### Problema 2: "SSL CApath is not valid directory"

**Causa:** Pusiste una ruta de archivo en el campo CApath (que espera un directorio).

**Solución:**
- **SIEMPRE** deja **SSL CApath VACÍO**
- Solo llena **SSL CA** con la ruta completa: `d:/xampp/mysql/data/ca.pem`

---

### Problema 3: "Error: missing value to go with key"

**Causa:** Campos SSL mal configurados en HammerDB.

**Solución A - Usar SSL correctamente:**
```
SSL CApath: (VACÍO)
SSL CA: d:/xampp/mysql/data/ca.pem
SSL Cert: (VACÍO)
SSL Key: (VACÍO)
SSL Cipher: (VACÍO)
```

**Solución B - Desactivar SSL completamente:**
```
☐ Enable SSL: DESMARCAR
```

---

### Problema 4: MySQL no arranca después de editar my.ini

**Causa:** Error de sintaxis en my.ini.

**Solución:**
1. Ver log de errores:
```powershell
Get-Content "d:\xampp\mysql\data\mysql_error.log" -Tail 20
```

2. Buscar líneas con `[ERROR]`

3. Problemas comunes:
   - Olvidaste el salto de línea antes de `# SSL Configuration`
   - Usaste comillas en las rutas (NO uses comillas)
   - Nombre de archivo incorrecto

4. Si no puedes arreglarlo, abre `my.ini` y **ELIMINA** estas líneas:
```ini
# SSL Configuration (para HammerDB)
ssl-ca=ca.pem
ssl-cert=server-cert.pem
ssl-key=server-key.pem
```

5. Guarda y reinicia MySQL

---

### Problema 5: HammerDB no conecta incluso con SSL configurado

**Solución rápida - Desactivar SSL en HammerDB:**

1. Options → Connection
2. **DESMARCAR** ☐ Enable SSL
3. OK
4. Intentar conectar

**¿Por qué funciona?**
MySQL ahora soporta **AMBAS** conexiones:
- ✅ Con SSL (cifradas)
- ✅ Sin SSL (sin cifrar)

Para prácticas locales, **sin SSL es suficiente**.

---

### Problema 6: "Access denied for user 'root'@'localhost'"

**Causa:** Password de root configurado.

**Soluciones:**
1. Intentar con password vacío
2. Recuperar password de root:
   - Abrir phpMyAdmin: `http://localhost/phpmyadmin/`
   - Si funciona, root no tiene password
3. Crear nuevo usuario para HammerDB:
```sql
CREATE USER 'tpcc'@'localhost' IDENTIFIED BY 'tpcc';
CREATE DATABASE tpcc;
GRANT ALL PRIVILEGES ON tpcc.* TO 'tpcc'@'localhost';
FLUSH PRIVILEGES;
```

Luego en HammerDB usar:
```
MariaDB User: tpcc
MariaDB User Password: tpcc
Database: tpcc
```

---

### Problema 7: "Can't connect to MySQL server on 'localhost'"

**Causa:** MySQL no está corriendo.

**Solución:**
```powershell
# Verificar si corre
netstat -an | findstr :3306

# Si no aparece, iniciar MySQL
d:\xampp\mysql_start.bat

# Esperar 5 segundos
Start-Sleep -Seconds 5

# Verificar de nuevo
netstat -an | findstr :3306
```

---

### Problema 8: Script falla en "Generando certificado CA", "Generando solicitud servidor" y "Firmando certificado servidor"

**Síntoma:** 
- ✅ Generando clave CA... OK
- ✅ Generando clave servidor... OK
- ❌ Generando certificado CA... ERROR
- ❌ Generando solicitud servidor... ERROR
- ❌ Firmando certificado servidor... ERROR

**Causa:** OpenSSL tiene problemas con el parámetro `-subj` en algunos sistemas Windows, o requiere entrada interactiva.

**Solución A - Generar certificados manualmente (MODO INTERACTIVO):**

```powershell
# 1. Abrir PowerShell como Administrador
cd d:\xampp\mysql\data

# 2. Generar CA key
d:\xampp\apache\bin\openssl.exe genrsa 2048 > ca-key.pem

# 3. Generar CA cert (TE PEDIRÁ DATOS - puedes pulsar Enter en todo)
d:\xampp\apache\bin\openssl.exe req -new -x509 -nodes -days 3650 -key ca-key.pem -out ca.pem

# Te preguntará (puedes dejar en blanco con Enter):
# Country Name (2 letter code): ES
# State or Province Name: Madrid
# Locality Name: Madrid
# Organization Name: Student
# Organizational Unit Name: Database
# Common Name: MySQL_CA
# Email Address: [Enter]

# 4. Generar server key
d:\xampp\apache\bin\openssl.exe genrsa 2048 > server-key.pem

# 5. Generar server request (TE PEDIRÁ DATOS)
d:\xampp\apache\bin\openssl.exe req -new -key server-key.pem -out server-req.pem

# IMPORTANTE: En "Common Name" escribe: localhost
# El resto puedes dejarlo en blanco

# 6. Firmar certificado
d:\xampp\apache\bin\openssl.exe x509 -req -in server-req.pem -days 3650 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem

# 7. Limpiar temporal
Remove-Item server-req.pem -Force

# 8. Verificar que todos están creados
Get-ChildItem *.pem | Select-Object Name, Length
```

**Solución B - Con archivo de configuración:**

Si el modo interactivo da problemas, crea un archivo de configuración temporal:

```powershell
cd d:\xampp\mysql\data

# Crear archivo de configuración
@"
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn

[dn]
C=ES
ST=Madrid
L=Madrid
O=Student
OU=Database
CN=
"@ | Out-File -FilePath openssl_ca.cnf -Encoding ASCII

# Modificar CN para CA
(Get-Content openssl_ca.cnf) -replace 'CN=$', 'CN=MySQL_CA' | Set-Content openssl_ca.cnf

# Generar CA
d:\xampp\apache\bin\openssl.exe genrsa 2048 > ca-key.pem
d:\xampp\apache\bin\openssl.exe req -new -x509 -nodes -days 3650 -key ca-key.pem -out ca.pem -config openssl_ca.cnf

# Modificar CN para server
(Get-Content openssl_ca.cnf) -replace 'CN=.*', 'CN=localhost' | Set-Content openssl_server.cnf

# Generar server cert
d:\xampp\apache\bin\openssl.exe genrsa 2048 > server-key.pem
d:\xampp\apache\bin\openssl.exe req -new -key server-key.pem -out server-req.pem -config openssl_server.cnf
d:\xampp\apache\bin\openssl.exe x509 -req -in server-req.pem -days 3650 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem

# Limpiar
Remove-Item server-req.pem, openssl_*.cnf -Force
```

**Después de generar los certificados manualmente:**
1. Continúa con el **PASO 2** de la guía (editar my.ini)
2. O vuelve a ejecutar el script - detectará los certificados existentes

---

## 📚 RESUMEN RÁPIDO

### Comandos esenciales (copia y pega en orden):

```powershell
# 1. Ir al directorio
cd d:\xampp\mysql\data

# 2. Generar certificados
cmd /c "d:\xampp\apache\bin\openssl.exe genrsa 2048 > ca-key.pem 2>nul"
cmd /c "d:\xampp\apache\bin\openssl.exe req -new -x509 -nodes -days 3650 -key ca-key.pem -out ca.pem -subj /C=ES/ST=Madrid/L=Madrid/O=Student/OU=Database/CN=MySQL_CA 2>nul"
cmd /c "d:\xampp\apache\bin\openssl.exe genrsa 2048 > server-key.pem 2>nul"
cmd /c "d:\xampp\apache\bin\openssl.exe req -new -key server-key.pem -out server-req.pem -subj /C=ES/ST=Madrid/L=Madrid/O=Student/OU=Database/CN=localhost 2>nul"
cmd /c "d:\xampp\apache\bin\openssl.exe x509 -req -in server-req.pem -days 3650 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem 2>nul"
Remove-Item server-req.pem -Force -ErrorAction SilentlyContinue

# 3. Verificar
Get-ChildItem *.pem | Select-Object Name, Length
```

### Editar my.ini:

1. Abrir: `d:\xampp\mysql\bin\my.ini` (como Administrador)
2. Buscar: `log_error="mysql_error.log"`
3. Agregar DESPUÉS:
```ini

# SSL Configuration (para HammerDB)
ssl-ca=ca.pem
ssl-cert=server-cert.pem
ssl-key=server-key.pem
```
4. Guardar

### Reiniciar MySQL:

```powershell
d:\xampp\mysql_stop.bat
Start-Sleep -Seconds 3
d:\xampp\mysql_start.bat
Start-Sleep -Seconds 5
```

### Verificar:

```powershell
d:\xampp\mysql\bin\mysql.exe -u root -h 127.0.0.1 -e "SHOW VARIABLES LIKE 'have_ssl';"
```

Debe mostrar: `have_ssl | YES`

### Configurar HammerDB:

1. Options → Connection
2. Enable SSL: **MARCAR ☑**
3. SSL One-Way: **SELECCIONAR ⚫**
4. SSL CA: `d:/xampp/mysql/data/ca.pem`
5. Resto: **VACÍO**
6. OK

---

## 🎓 EXPLICACIÓN PARA ENTENDER

### ¿Por qué necesitamos SSL?

- **HammerDB 4.10+** requiere SSL por defecto para conexiones a MariaDB
- Es una medida de seguridad del software
- XAMPP no trae SSL habilitado por defecto

### ¿Qué hacen los certificados?

- **ca.pem**: Certificate Authority - Firma y valida otros certificados
- **server-cert.pem**: Certificado del servidor MySQL
- **server-key.pem**: Clave privada del servidor

### ¿Por qué funciona con y sin SSL después?

Porque configuramos MySQL para:
1. ✅ **Soportar SSL** (can_ssl = YES)
2. ❌ **NO requerir SSL** (require_secure_transport = OFF)

Esto significa que MySQL acepta **ambos tipos de conexión**.

---

## 📞 AYUDA ADICIONAL

Si después de seguir todos los pasos sigues teniendo problemas:

1. Captura pantalla del error
2. Ejecuta estos comandos y guarda la salida:
```powershell
d:\xampp\mysql\bin\mysql.exe -u root -e "SHOW VARIABLES LIKE '%ssl%';"
Get-Content "d:\xampp\mysql\data\mysql_error.log" -Tail 30
Get-ChildItem "d:\xampp\mysql\data\*.pem" | Select-Object Name, Length
```

3. Consulta con tu profesor

---

## ✅ CHECKLIST FINAL

Antes de la práctica, verifica:

- [ ] MySQL corriendo (puerto 3306)
- [ ] 4 archivos .pem en `d:\xampp\mysql\data\`
- [ ] my.ini editado con configuración SSL
- [ ] `have_ssl = YES` en MySQL
- [ ] HammerDB instalado
- [ ] Configuración de HammerDB guardada

---

**Fecha de creación:** Marzo 2026  
**Versión:** 1.0  
**Probado con:** XAMPP 8.2.12, MariaDB 10.4.32, HammerDB 5.0  
**Sistema operativo:** Windows 10/11

---

**¡Buena suerte con la práctica!** 🎓
