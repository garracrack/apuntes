# ============================================
# Script Automatico: Configurar SSL para HammerDB
# ============================================
# Ejecutar como Administrador
# Uso: .\setup_hammerdb_ssl.ps1
# ============================================

param(
    [string]$XamppPath = "d:\xampp"
)

Write-Host "`n" -NoNewline
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " CONFIGURACION SSL PARA HAMMERDB + XAMPP" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Variables
$mysqlDataDir = "$XamppPath\mysql\data"
$mysqlBinDir = "$XamppPath\mysql\bin"
$myIniPath = "$mysqlBinDir\my.ini"
$opensslPath = "$XamppPath\apache\bin\openssl.exe"
$errorCount = 0

# Funcion para imprimir pasos
function Write-Step {
    param([string]$Message, [string]$Status = "INFO")
    
    $color = switch ($Status) {
        "OK" { "Green" }
        "ERROR" { "Red" }
        "WARN" { "Yellow" }
        default { "White" }
    }
    
    $symbol = switch ($Status) {
        "OK" { "[OK]" }
        "ERROR" { "[ERROR]" }
        "WARN" { "[AVISO]" }
        default { "[INFO]" }
    }
    
    Write-Host "$symbol " -ForegroundColor $color -NoNewline
    Write-Host $Message
}

# ============================================
# PASO 0: Verificaciones previas
# ============================================
Write-Host "`n[PASO 0] VERIFICACIONES PREVIAS" -ForegroundColor Yellow
Write-Host "============================================`n"

# Verificar que se ejecuta como Administrador
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Step "Este script debe ejecutarse como Administrador" "ERROR"
    Write-Host "`nClick derecho en PowerShell -> 'Ejecutar como administrador'`n" -ForegroundColor Yellow
    exit 1
}
Write-Step "Permisos de Administrador" "OK"

# Verificar XAMPP existe
if (-not (Test-Path $XamppPath)) {
    Write-Step "XAMPP no encontrado en: $XamppPath" "ERROR"
    Write-Host "`nSi XAMPP esta en otra ubicacion, ejecuta:" -ForegroundColor Yellow
    Write-Host "  .\setup_hammerdb_ssl.ps1 -XamppPath C:\xampp`n"
    exit 1
}
Write-Step "XAMPP encontrado en: $XamppPath" "OK"

# Verificar OpenSSL existe
if (-not (Test-Path $opensslPath)) {
    Write-Step "OpenSSL no encontrado en: $opensslPath" "ERROR"
    exit 1
}
Write-Step "OpenSSL encontrado" "OK"

# Verificar directorio data existe
if (-not (Test-Path $mysqlDataDir)) {
    Write-Step "Directorio de datos MySQL no encontrado: $mysqlDataDir" "ERROR"
    exit 1
}
Write-Step "Directorio de datos MySQL encontrado" "OK"

# ============================================
# PASO 1: Generar certificados SSL
# ============================================
Write-Host "`n[PASO 1] GENERAR CERTIFICADOS SSL" -ForegroundColor Yellow
Write-Host "============================================`n"

Set-Location $mysqlDataDir

# Verificar si ya existen certificados
$existingCerts = @()
if (Test-Path "ca.pem") { $existingCerts += "ca.pem" }
if (Test-Path "server-cert.pem") { $existingCerts += "server-cert.pem" }
if (Test-Path "server-key.pem") { $existingCerts += "server-key.pem" }

if ($existingCerts.Count -gt 0) {
    Write-Step "Certificados existentes encontrados: $($existingCerts -join ', ')" "WARN"
    $respuesta = Read-Host "Deseas regenerar los certificados? (S/N)"
    if ($respuesta -ne "S" -and $respuesta -ne "s") {
        Write-Step "Usando certificados existentes" "OK"
        $skipCerts = $true
    } else {
        Write-Step "Regenerando certificados..." "INFO"
        Remove-Item *.pem -Force -ErrorAction SilentlyContinue
        $skipCerts = $false
    }
} else {
    $skipCerts = $false
}

if (-not $skipCerts) {
    # Generar CA key
    Write-Host "  Generando clave CA..." -NoNewline
    $result = cmd /c "$opensslPath genrsa 2048 > ca-key.pem 2>nul"
    if (Test-Path "ca-key.pem") {
        Write-Host " OK" -ForegroundColor Green
    } else {
        Write-Host " ERROR" -ForegroundColor Red
        $errorCount++
    }

    # Generar CA cert
    Write-Host "  Generando certificado CA..." -NoNewline
    $result = cmd /c "$opensslPath req -new -x509 -nodes -days 3650 -key ca-key.pem -out ca.pem -subj /C=ES/ST=Madrid/L=Madrid/O=Student/OU=Database/CN=MySQL_CA 2>nul"
    if (Test-Path "ca.pem") {
        Write-Host " OK" -ForegroundColor Green
    } else {
        Write-Host " ERROR" -ForegroundColor Red
        $errorCount++
    }

    # Generar server key
    Write-Host "  Generando clave servidor..." -NoNewline
    $result = cmd /c "$opensslPath genrsa 2048 > server-key.pem 2>nul"
    if (Test-Path "server-key.pem") {
        Write-Host " OK" -ForegroundColor Green
    } else {
        Write-Host " ERROR" -ForegroundColor Red
        $errorCount++
    }

    # Generar server request
    Write-Host "  Generando solicitud servidor..." -NoNewline
    $result = cmd /c "$opensslPath req -new -key server-key.pem -out server-req.pem -subj /C=ES/ST=Madrid/L=Madrid/O=Student/OU=Database/CN=localhost 2>nul"
    if (Test-Path "server-req.pem") {
        Write-Host " OK" -ForegroundColor Green
    } else {
        Write-Host " ERROR" -ForegroundColor Red
        $errorCount++
    }

    # Firmar certificado servidor
    Write-Host "  Firmando certificado servidor..." -NoNewline
    $result = cmd /c "$opensslPath x509 -req -in server-req.pem -days 3650 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem 2>nul"
    if (Test-Path "server-cert.pem") {
        Write-Host " OK" -ForegroundColor Green
    } else {
        Write-Host " ERROR" -ForegroundColor Red
        $errorCount++
    }

    # Limpiar temporal
    Remove-Item server-req.pem -Force -ErrorAction SilentlyContinue

    # Verificar certificados
    Write-Host "`n  Certificados generados:" -ForegroundColor Cyan
    Get-ChildItem *.pem | Select-Object Name, Length | Format-Table -AutoSize
}

# ============================================
# PASO 2: Configurar my.ini
# ============================================
Write-Host "`n[PASO 2] CONFIGURAR MYSQL (my.ini)" -ForegroundColor Yellow
Write-Host "============================================`n"

# Leer my.ini
if (-not (Test-Path $myIniPath)) {
    Write-Step "Archivo my.ini no encontrado: $myIniPath" "ERROR"
    exit 1
}

$iniContent = Get-Content $myIniPath -Raw

# Verificar si SSL ya esta configurado
if ($iniContent -match 'ssl-ca=') {
    Write-Step "SSL ya configurado en my.ini" "OK"
} else {
    Write-Step "Agregando configuracion SSL a my.ini..." "INFO"
    
    # Hacer backup
    $backupPath = "$myIniPath.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    Copy-Item $myIniPath $backupPath
    Write-Step "Backup creado: $backupPath" "OK"
    
    # Buscar donde insertar config SSL
    if ($iniContent -match 'log_error="mysql_error.log"') {
        $sslConfig = @"

# SSL Configuration (para HammerDB)
ssl-ca=ca.pem
ssl-cert=server-cert.pem
ssl-key=server-key.pem
"@
        $iniContent = $iniContent -replace '(log_error="mysql_error.log")', "`$1$sslConfig"
        Set-Content -Path $myIniPath -Value $iniContent -Encoding UTF8
        Write-Step "Configuracion SSL agregada a my.ini" "OK"
    } else {
        Write-Step "No se encontro linea 'log_error' en my.ini" "WARN"
        Write-Host "  Por favor, agrega manualmente estas lineas en la seccion [mysqld]:" -ForegroundColor Yellow
        Write-Host "  ssl-ca=ca.pem"
        Write-Host "  ssl-cert=server-cert.pem"
        Write-Host "  ssl-key=server-key.pem"
    }
}

# ============================================
# PASO 3: Reiniciar MySQL
# ============================================
Write-Host "`n[PASO 3] REINICIAR MYSQL" -ForegroundColor Yellow
Write-Host "============================================`n"

$mysqlStopBat = "$XamppPath\mysql_stop.bat"
$mysqlStartBat = "$XamppPath\mysql_start.bat"

# Detener MySQL
if (Test-Path $mysqlStopBat) {
    Write-Step "Deteniendo MySQL..." "INFO"
    Start-Process -FilePath $mysqlStopBat -Wait -NoNewWindow
    Start-Sleep -Seconds 3
    Write-Step "MySQL detenido" "OK"
} else {
    Write-Step "Script mysql_stop.bat no encontrado" "WARN"
    Write-Host "  Detén MySQL manualmente desde XAMPP Control Panel" -ForegroundColor Yellow
    Read-Host "  Presiona Enter cuando hayas detenido MySQL"
}

# Iniciar MySQL
if (Test-Path $mysqlStartBat) {
    Write-Step "Iniciando MySQL..." "INFO"
    Start-Process -FilePath $mysqlStartBat -WindowStyle Hidden
    Start-Sleep -Seconds 5
    Write-Step "MySQL iniciado" "OK"
} else {
    Write-Step "Script mysql_start.bat no encontrado" "WARN"
    Write-Host "  Inicia MySQL manualmente desde XAMPP Control Panel" -ForegroundColor Yellow
    Read-Host "  Presiona Enter cuando MySQL este corriendo"
}

# ============================================
# PASO 4: Verificar SSL
# ============================================
Write-Host "`n[PASO 4] VERIFICAR SSL HABILITADO" -ForegroundColor Yellow
Write-Host "============================================`n"

$mysqlExe = "$mysqlBinDir\mysql.exe"

if (Test-Path $mysqlExe) {
    Start-Sleep -Seconds 2
    
    Write-Step "Verificando estado SSL..." "INFO"
    $sslStatus = & $mysqlExe -u root -h 127.0.0.1 -e "SHOW VARIABLES LIKE 'have_ssl';" 2>&1
    
    if ($sslStatus -match "YES") {
        Write-Step "SSL HABILITADO correctamente!" "OK"
        Write-Host "`n$sslStatus`n"
    } elseif ($sslStatus -match "DISABLED") {
        Write-Step "SSL esta DESHABILITADO" "ERROR"
        Write-Host "  Revisa que los archivos .pem existen y my.ini este correcto" -ForegroundColor Yellow
        $errorCount++
    } else {
        Write-Step "No se pudo verificar estado SSL" "WARN"
        Write-Host "  Error: $sslStatus" -ForegroundColor Yellow
        Write-Host "  Verifica manualmente con: mysql -u root -e `"SHOW VARIABLES LIKE 'have_ssl';`"" -ForegroundColor Yellow
    }
} else {
    Write-Step "mysql.exe no encontrado en: $mysqlExe" "ERROR"
    $errorCount++
}

# ============================================
# PASO 5: Crear usuario MySQL para HammerDB
# ============================================
Write-Host "`n[PASO 5] CREAR USUARIO MYSQL" -ForegroundColor Yellow
Write-Host "============================================`n"

if (Test-Path $mysqlExe) {
    Write-Step "Creando usuario 'tpcc' con contraseña..." "INFO"
    
    # Verificar si el usuario ya existe
    $userCheck = & $mysqlExe -u root -h 127.0.0.1 -e "SELECT User FROM mysql.user WHERE User='tpcc';" 2>&1
    
    if ($userCheck -match "tpcc") {
        Write-Step "Usuario 'tpcc' ya existe" "OK"
    } else {
        # Crear usuario y otorgar permisos
        $createUser = & $mysqlExe -u root -h 127.0.0.1 -e "CREATE USER 'tpcc'@'localhost' IDENTIFIED BY 'tpcc'; GRANT ALL PRIVILEGES ON *.* TO 'tpcc'@'localhost'; CREATE USER 'tpcc'@'%' IDENTIFIED BY 'tpcc'; GRANT ALL PRIVILEGES ON *.* TO 'tpcc'@'%'; FLUSH PRIVILEGES;" 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Step "Usuario 'tpcc' creado exitosamente" "OK"
            Write-Host "  Usuario: " -NoNewline -ForegroundColor White
            Write-Host "tpcc" -ForegroundColor Green
            Write-Host "  Password: " -NoNewline -ForegroundColor White
            Write-Host "tpcc" -ForegroundColor Green
            Write-Host "  Permisos: " -NoNewline -ForegroundColor White
            Write-Host "ALL PRIVILEGES" -ForegroundColor Green
        } else {
            Write-Step "Error al crear usuario: $createUser" "ERROR"
            Write-Host "  Puedes crear el usuario manualmente:" -ForegroundColor Yellow
            Write-Host "  mysql -u root -e `"CREATE USER 'tpcc'@'localhost' IDENTIFIED BY 'tpcc'; GRANT ALL PRIVILEGES ON *.* TO 'tpcc'@'localhost'; FLUSH PRIVILEGES;`""
            $errorCount++
        }
    }
} else {
    Write-Step "No se pudo crear usuario (mysql.exe no encontrado)" "WARN"
    Write-Host "  Crea el usuario manualmente antes de usar HammerDB" -ForegroundColor Yellow
}

# ============================================
# PASO 6: Instrucciones HammerDB
# ============================================
Write-Host "`n[PASO 6] CONFIGURAR HAMMERDB" -ForegroundColor Yellow
Write-Host "============================================`n"

Write-Host "1. Abre HammerDB GUI" -ForegroundColor Cyan
Write-Host "   Path: C:\Program Files\HammerDB-5.0\hammerdb.exe`n"

Write-Host "2. Selecciona:" -ForegroundColor Cyan
Write-Host "   - Benchmark: TPC-C"
Write-Host "   - Database: MariaDB`n"

Write-Host "3. Configuracion de Conexion:" -ForegroundColor Cyan
Write-Host "   Options -> MariaDB -> Connection`n"

Write-Host "   MariaDB Host: " -NoNewline -ForegroundColor White
Write-Host "localhost" -ForegroundColor Green
Write-Host "   MariaDB Port: " -NoNewline -ForegroundColor White
Write-Host "3306" -ForegroundColor Green
Write-Host "   MariaDB User: " -NoNewline -ForegroundColor White
Write-Host "tpcc" -ForegroundColor Green
Write-Host "   MariaDB Password: " -NoNewline -ForegroundColor White
Write-Host "tpcc" -ForegroundColor Green
Write-Host "   Database: " -NoNewline -ForegroundColor White
Write-Host "test" -ForegroundColor Green

Write-Host "`n4. Configuracion SSL:" -ForegroundColor Cyan
Write-Host "   [X] Enable SSL: " -NoNewline -ForegroundColor White
Write-Host "MARCADO" -ForegroundColor Yellow
Write-Host "   ( ) SSL One-Way: " -NoNewline -ForegroundColor White
Write-Host "SELECCIONADO" -ForegroundColor Yellow
Write-Host "   SSL CApath: " -NoNewline -ForegroundColor White
Write-Host "(VACIO)" -ForegroundColor Green
Write-Host "   SSL CA: " -NoNewline -ForegroundColor White
Write-Host "$mysqlDataDir\ca.pem" -ForegroundColor Yellow
Write-Host "         (usa forward slashes: " -NoNewline
Write-Host "$($mysqlDataDir -replace '\\','/')/ca.pem" -ForegroundColor Green -NoNewline
Write-Host ")"
Write-Host "   SSL Cert: " -NoNewline -ForegroundColor White
Write-Host "(VACIO)" -ForegroundColor Green
Write-Host "   SSL Key: " -NoNewline -ForegroundColor White
Write-Host "(VACIO)" -ForegroundColor Green
Write-Host "   SSL Cipher: " -NoNewline -ForegroundColor White
Write-Host "(VACIO)" -ForegroundColor Green

Write-Host "`n5. ALTERNATIVA - Sin SSL (mas simple):" -ForegroundColor Cyan
Write-Host "   [ ] Enable SSL: " -NoNewline -ForegroundColor White
Write-Host "DESMARCAR" -ForegroundColor Green
Write-Host "   (MySQL acepta ambas conexiones)`n"

# ============================================
# RESUMEN FINAL
# ============================================
Write-Host "`n============================================" -ForegroundColor Cyan
Write-Host " RESUMEN" -ForegroundColor Cyan
Write-Host "============================================`n" -ForegroundColor Cyan

if ($errorCount -eq 0) {
    Write-Host "[OK] " -ForegroundColor Green -NoNewline
    Write-Host "Configuracion completada exitosamente!"
    Write-Host "`nCertificados SSL:" -ForegroundColor Yellow
    Write-Host "  Ubicacion: $mysqlDataDir"
    Write-Host "  Archivos: ca.pem, server-cert.pem, server-key.pem"
    Write-Host "`nMySQL:" -ForegroundColor Yellow
    Write-Host "  Estado SSL: HABILITADO"
    Write-Host "  Puerto: 3306"
    Write-Host "`nHammerDB:" -ForegroundColor Yellow
    Write-Host "  Listo para configurar con las instrucciones de arriba"
} else {
    Write-Host "[ERROR] " -ForegroundColor Red -NoNewline
    Write-Host "Se encontraron $errorCount errores"
    Write-Host "`nRevisa los mensajes de error y consulta la guia:" -ForegroundColor Yellow
    Write-Host "  $XamppPath\GUIA_ESTUDIANTES_HAMMERDB_SSL.md"
}

Write-Host "`n============================================`n" -ForegroundColor Cyan

# Fin
Read-Host "Presiona Enter para salir"
