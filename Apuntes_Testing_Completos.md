# APUNTES COMPLETOS DE TESTING DE SOFTWARE
## Curso de Técnico en Testing y Ciberseguridad Aplicada

---

# MÓDULO 1: CONCEPTOS FUNDAMENTALES DEL TESTING

## 1.1 Introducción: ¿Por qué necesitamos el Testing?

Antes de adentrarnos en los conceptos técnicos, es importante entender por qué el testing es absolutamente esencial en el desarrollo de software.

Imaginemos que estamos construyendo una casa. ¿Confiaríamos ciegamente en que todas las instalaciones eléctricas funcionan correctamente sin probarlas? ¿Daríamos por hecho que las tuberías no tienen fugas sin verificarlo? Por supuesto que no. De la misma manera, el software necesita ser probado exhaustivamente antes de entregarlo a los usuarios finales.

El software es creado por seres humanos, y los seres humanos cometemos errores. Es una realidad inevitable. Por muy experto que sea un programador, por muy cuidadoso que sea un analista, siempre existe la posibilidad de que se introduzcan fallos en el sistema. El testing existe precisamente para detectar estos fallos antes de que lleguen a producción y afecten a los usuarios reales.

**Consecuencias de no hacer testing adecuado:**
- Pérdidas económicas (ventas perdidas, devoluciones, compensaciones)
- Daño a la reputación de la empresa
- Pérdida de clientes
- En casos extremos: riesgos para la salud o la vida (software médico, aeronáutico, etc.)

---

## 1.2 Los Tres Conceptos Clave: Error, Defecto y Fallo

Estos tres términos son fundamentales y a menudo se confunden entre sí. Vamos a definirlos con precisión y a entender cómo se relacionan.

### 1.2.1 ERROR (Mistake / Equivocación)

**Definición completa:**
Un error es una acción humana incorrecta que produce un resultado incorrecto. Es el origen de todo el problema. Los errores los cometen las personas: desarrolladores, analistas, diseñadores, incluso los propios testers.

**Características del error:**
- Es una acción humana (no del software)
- Puede ocurrir en cualquier fase del desarrollo
- Es la causa raíz de los problemas
- Puede deberse a falta de conocimiento, distracción, presión de tiempo, mala comunicación, etc.

**Ejemplos detallados de errores:**

| Fase | Tipo de Error | Ejemplo Concreto |
|------|---------------|------------------|
| Requisitos | Ambigüedad | "El sistema debe ser rápido" (¿qué significa rápido?) |
| Requisitos | Omisión | Olvidar especificar qué pasa si el usuario cancela una operación |
| Diseño | Lógica incorrecta | Diseñar un flujo que no contempla todos los casos |
| Codificación | Sintaxis | Escribir `>` en lugar de `>=` |
| Codificación | Lógica | Usar el operador `AND` cuando debería ser `OR` |
| Documentación | Información errónea | Manual que indica pasos incorrectos |

### 1.2.2 DEFECTO (Defect / Fault / Bug)

**Definición completa:**
Un defecto es una imperfección o anomalía en un componente o sistema que puede hacer que el sistema falle en realizar su función requerida. El defecto es la manifestación del error en el producto (código, documento, diseño, etc.).

**Características del defecto:**
- Existe en el producto (código, documentación, diseño)
- Es introducido por un error humano
- Puede estar "dormido" sin causar problemas hasta que se ejecuta
- También se le conoce como "bug" (término histórico)

**Origen del término "bug":**
En 1947, Grace Hopper encontró una polilla atrapada en un relé del ordenador Mark II de Harvard, causando un mal funcionamiento. Desde entonces, se usa el término "bug" (bicho) para referirse a los defectos del software.

**Ejemplos detallados de defectos:**

```
EJEMPLO 1: Defecto en condición
─────────────────────────────────
Requisito: "Aplicar descuento del 10% si el importe es mayor o igual a 100€"

Código CORRECTO:
if (importe >= 100) {
    aplicarDescuento(10);
}

Código con DEFECTO:
if (importe > 100) {        // Falta el signo "="
    aplicarDescuento(10);
}

El defecto: usar ">" en lugar de ">="
```

```
EJEMPLO 2: Defecto en validación
─────────────────────────────────
Requisito: "El campo edad debe aceptar valores entre 0 y 120"

Código con DEFECTO:
if (edad > 0 && edad < 120) {  // No incluye 0 ni 120
    guardarEdad(edad);
}

El defecto: las condiciones excluyen los valores límite válidos
```

### 1.2.3 FALLO (Failure)

**Definición completa:**
Un fallo es la manifestación visible de un defecto durante la ejecución del software. Es cuando el usuario o el tester observa que el sistema no se comporta como debería. El fallo es lo que vemos; el defecto es la causa oculta.

**Características del fallo:**
- Es observable (se puede ver, medir o detectar)
- Ocurre durante la ejecución
- Es consecuencia de un defecto
- No todos los defectos producen fallos (pueden estar en código que nunca se ejecuta)

**Ejemplos detallados de fallos:**

| Defecto | Condición de Ejecución | Fallo Observado |
|---------|------------------------|-----------------|
| `importe > 100` en vez de `>=` | Usuario compra por 100€ exactos | No se aplica el descuento prometido |
| División sin validar divisor | Usuario introduce 0 en un campo | El sistema muestra error o se cuelga |
| Campo de texto sin límite | Usuario pega un texto muy largo | La pantalla se descuadra o la BD rechaza el dato |

### 1.2.4 La Cadena Causa-Efecto

Es fundamental entender cómo estos tres conceptos se relacionan en una cadena de causa-efecto:

```
┌─────────────────────────────────────────────────────────────────────┐
│                    CADENA CAUSA-EFECTO                              │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   ┌─────────┐         ┌─────────┐         ┌─────────┐              │
│   │  ERROR  │ ──────► │ DEFECTO │ ──────► │  FALLO  │              │
│   │(Humano) │         │(Producto)│         │(Ejecución)│            │
│   └─────────┘         └─────────┘         └─────────┘              │
│        │                   │                   │                    │
│        ▼                   ▼                   ▼                    │
│   El programador      El código tiene     Al ejecutar con          │
│   escribe ">" en      la condición        importe=100, no          │
│   lugar de ">="       incorrecta          se aplica descuento      │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

**Puntos importantes a recordar:**
1. Un ERROR siempre precede a un DEFECTO
2. Un DEFECTO puede o no producir un FALLO (depende de si se ejecuta ese código)
3. Un FALLO siempre es causado por un DEFECTO
4. El testing busca FALLOS para descubrir DEFECTOS

### 1.2.5 Ejercicios Resueltos

**EJERCICIO 1:**
En un sistema de reservas de hotel, el requisito dice: "El número de noches debe estar entre 1 y 30". Un usuario introduce 0 noches y el sistema lo acepta sin mostrar error.

**Identifica:**
a) ¿Cuál fue el error?
b) ¿Cuál es el defecto?
c) ¿Cuál es el fallo?

**SOLUCIÓN:**
a) **Error:** El programador olvidó implementar la validación del límite inferior, o implementó mal la condición (posiblemente escribió `noches > 0` pensando que era correcto, sin darse cuenta de que 0 no es mayor que 0).

b) **Defecto:** En el código falta la validación `noches >= 1` o existe una condición incorrecta como `noches > 0` que debería ser `noches >= 1`.

c) **Fallo:** El sistema acepta una reserva de 0 noches cuando debería mostrar un mensaje de error indicando que el mínimo es 1 noche.

---

**EJERCICIO 2:**
Una tienda online tiene el siguiente código para calcular gastos de envío:

```javascript
if (pesoKg > 5) {
    gastosEnvio = 15;
} else if (pesoKg > 2) {
    gastosEnvio = 10;
} else {
    gastosEnvio = 5;
}
```

El requisito indica:
- Hasta 2 kg: 5€
- De 2 a 5 kg: 10€
- Más de 5 kg: 15€

Un paquete de exactamente 2 kg cobra 5€. ¿Es correcto?

**SOLUCIÓN:**
**Análisis:** Según el requisito "Hasta 2 kg: 5€", un paquete de exactamente 2 kg debería pagar 5€.

Veamos qué hace el código con pesoKg = 2:
- ¿2 > 5? No → sigue
- ¿2 > 2? No → sigue  
- Else → gastosEnvio = 5€

**Conclusión:** El código es CORRECTO para este caso. No hay fallo.

Pero... ¿qué pasa con exactamente 5 kg?
- ¿5 > 5? No → sigue
- ¿5 > 2? Sí → gastosEnvio = 10€

Según el requisito "De 2 a 5 kg: 10€", 5 kg debería pagar 10€. ¡CORRECTO!

Este código está bien implementado. No hay defecto.

---

**EJERCICIO 3:**
Un sistema bancario permite transferencias. El requisito dice: "Las transferencias deben ser de mínimo 1€ y máximo 10.000€". Un usuario intenta transferir 10.001€ y el sistema lo permite.

**SOLUCIÓN:**
a) **Error:** El programador implementó incorrectamente la validación del límite superior.

b) **Defecto:** Posiblemente el código tiene `importe < 10000` en lugar de `importe <= 10000`, o directamente falta la validación del máximo.

c) **Fallo:** El sistema permite una transferencia de 10.001€ cuando debería rechazarla con un mensaje indicando que el máximo permitido es 10.000€.

---

# MÓDULO 2: CALIDAD DEL SOFTWARE Y EL ROL DEL TESTING

## 2.1 ¿Qué es la Calidad del Software?

La calidad del software es un concepto amplio que ha sido definido por diversas organizaciones internacionales. Veamos las definiciones más importantes:

### 2.1.1 Definición según ISO/IEC 9126

> "La calidad del software es la totalidad de características de un producto de software que le confieren la capacidad de satisfacer necesidades explícitas e implícitas."

Esta definición nos dice que la calidad no es solo cumplir lo que el cliente pidió (necesidades explícitas), sino también lo que el cliente espera aunque no lo haya dicho (necesidades implícitas).

**Ejemplo:**
- **Necesidad explícita:** "El sistema debe permitir registrar usuarios"
- **Necesidad implícita:** El usuario espera que el registro sea razonablemente rápido, que no pierda sus datos si hay un error, que la interfaz sea comprensible...

### 2.1.2 Definición según IEEE 610

> "El grado en que un componente, sistema o proceso cumple con los requisitos especificados y/o las necesidades y expectativas del usuario/cliente."

### 2.1.3 Dimensiones de la Calidad del Software

La calidad se puede medir en múltiples dimensiones:

```
┌────────────────────────────────────────────────────────────────────────┐
│                    DIMENSIONES DE LA CALIDAD                           │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐     │
│  │  FUNCIONALIDAD   │  │   FIABILIDAD     │  │   USABILIDAD     │     │
│  │                  │  │                  │  │                  │     │
│  │ ¿Hace lo que     │  │ ¿Funciona de     │  │ ¿Es fácil de     │     │
│  │  debe hacer?     │  │ manera estable?  │  │    usar?         │     │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘     │
│                                                                        │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐     │
│  │   EFICIENCIA     │  │ MANTENIBILIDAD   │  │  PORTABILIDAD    │     │
│  │                  │  │                  │  │                  │     │
│  │ ¿Responde        │  │ ¿Es fácil de     │  │ ¿Puede moverse   │     │
│  │ rápido?          │  │ modificar?       │  │ a otros entornos?│     │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘     │
│                                                                        │
└────────────────────────────────────────────────────────────────────────┘
```

## 2.2 Medidas de Aseguramiento de la Calidad

Existen dos grandes enfoques para asegurar la calidad:

### 2.2.1 Medidas Constructivas (Proactivas)

Son acciones que se toman para **prevenir** la introducción de errores. Es mejor prevenir que curar.

**Ejemplos de medidas constructivas:**
- Uso de metodologías de desarrollo estructuradas
- Estándares de codificación
- Revisiones de código entre compañeros (code reviews)
- Formación continua del equipo
- Documentación clara y completa de requisitos
- Uso de herramientas de análisis estático
- Plantillas y checklists

**Analogía:** Es como lavarse las manos para prevenir enfermedades, en lugar de tomar medicinas después de enfermar.

### 2.2.2 Medidas Analíticas (Reactivas)

Son acciones que se toman para **detectar** errores que ya se han introducido.

```
MEDIDAS ANALÍTICAS
├── ESTÁTICAS (sin ejecutar el software)
│   ├── Revisiones de documentos
│   ├── Inspecciones de código
│   ├── Walkthroughs (recorridos)
│   └── Análisis estático automatizado
│
└── DINÁMICAS (ejecutando el software)
    ├── Pruebas de caja negra
    ├── Pruebas de caja blanca
    └── Pruebas basadas en experiencia
```

## 2.3 ¿Cómo el Testing Eleva la Calidad?

El testing contribuye a mejorar la calidad de varias formas:

### 2.3.1 Detección Temprana de Defectos

Cuanto antes se detecta un defecto, más barato es corregirlo. Esta es la famosa "Regla del 1-10-100":

```
┌────────────────────────────────────────────────────────────────────┐
│              COSTE DE CORRECCIÓN DE DEFECTOS                       │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│  Fase de detección          Coste relativo                         │
│  ──────────────────         ───────────────                        │
│  Requisitos                      1x                                │
│  Diseño                          5x                                │
│  Codificación                   10x                                │
│  Pruebas                        20x                                │
│  Producción                100x o más                              │
│                                                                    │
│  ¡Un defecto detectado en producción puede costar 100 veces       │
│   más que si se hubiera detectado en la fase de requisitos!        │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

### 2.3.2 Verificación de Requisitos

El testing verifica que el software hace lo que se especificó. Sin pruebas, no tenemos garantía de que los requisitos se han implementado correctamente.

### 2.3.3 Evidencia Objetiva

Las pruebas proporcionan métricas y evidencias:
- Número de casos ejecutados
- Porcentaje de casos exitosos
- Cobertura de requisitos
- Cobertura de código
- Número de defectos encontrados y corregidos

### 2.3.4 Reducción de Riesgos

El testing reduce el riesgo de:
- Fallos en producción
- Pérdidas económicas
- Daño a la reputación
- Insatisfacción del cliente

### 2.3.5 Ejemplo Práctico: El Coste de No Hacer Testing

**Caso real simplificado:**
Una empresa de comercio electrónico lanza una nueva funcionalidad de pago sin pruebas exhaustivas. Durante el Black Friday:

- El sistema falla con el 30% de las transacciones
- 10.000 clientes afectados
- Pérdida directa: 500.000€ en ventas
- Coste de compensaciones: 50.000€
- Daño reputacional: incalculable
- Coste de corrección urgente (horas extra, consultores): 30.000€

**Coste total del incidente: más de 580.000€**

Si se hubiera invertido en testing adecuado:
- Coste estimado de pruebas completas: 15.000€
- **Ahorro: más de 565.000€**

## 2.4 Ejercicios Resueltos

**EJERCICIO 1:**
Una empresa tiene dos opciones:
A) Dedicar 2 semanas adicionales a testing antes del lanzamiento
B) Lanzar ya y corregir los problemas que reporten los usuarios

¿Qué factores debería considerar para tomar la decisión?

**SOLUCIÓN:**
Factores a considerar:

1. **Criticidad del sistema:** ¿Es un sistema bancario, médico, o un blog personal? A mayor criticidad, más importante el testing.

2. **Base de usuarios:** ¿Cuántos usuarios se verán afectados por posibles fallos?

3. **Coste de los fallos:** Pérdidas económicas directas, compensaciones, daño reputacional.

4. **Competencia:** ¿Hay presión de mercado para lanzar antes que la competencia?

5. **Reversibilidad:** ¿Es fácil corregir y desplegar arreglos rápidamente?

6. **Tipo de software:** Software empaquetado vs. servicio web (el web se puede actualizar fácilmente).

En general, la opción A es más recomendable para sistemas críticos, con muchos usuarios o donde los fallos tienen alto coste.

---

**EJERCICIO 2:**
Clasifica las siguientes acciones como medidas constructivas o analíticas:

a) Formar al equipo en buenas prácticas de programación
b) Ejecutar pruebas automatizadas cada noche
c) Usar una plantilla estándar para documentar requisitos
d) Revisar el código de un compañero antes de integrarlo
e) Realizar pruebas de rendimiento en un entorno de pre-producción

**SOLUCIÓN:**
a) **Constructiva** - Es formación para prevenir errores
b) **Analítica (dinámica)** - Se ejecuta el software para detectar fallos
c) **Constructiva** - Estandarización para prevenir errores
d) **Analítica (estática)** - Se revisa sin ejecutar para detectar defectos
e) **Analítica (dinámica)** - Se ejecuta el software para medir rendimiento

---

# MÓDULO 3: ASPECTOS A PROBAR - FUNCIONALES Y NO FUNCIONALES

## 3.1 Aspectos Funcionales

Los aspectos funcionales responden a la pregunta: **"¿QUÉ hace el sistema?"**

Se refieren a las funciones, características y comportamientos que el sistema debe realizar según sus requisitos. Son las capacidades del software.

### 3.1.1 Características Funcionales Principales

**1. Idoneidad (Suitability)**
¿Son adecuadas las funciones disponibles para el uso previsto?

*Ejemplo:* Un sistema de facturación debe poder crear facturas, pero también rectificativas, abonos, etc. Si solo permite facturas simples, no es idóneo para empresas que necesitan más.

**2. Precisión (Accuracy)**
¿Los resultados son correctos con el nivel de precisión requerido?

*Ejemplo:* Una calculadora financiera debe manejar decimales con precisión. Si 10,30 + 10,30 da 20,59 en lugar de 20,60, no es precisa.

**3. Conformidad (Compliance)**
¿Cumple con normas, leyes y estándares aplicables?

*Ejemplo:* Un sistema de facturación en España debe generar facturas según el formato de la AEAT, con todos los campos obligatorios legales.

**4. Interoperabilidad**
¿Puede comunicarse correctamente con otros sistemas?

*Ejemplo:* Un ERP debe poder exportar datos a Excel, comunicarse con la pasarela de pago, enviar datos a Hacienda, etc.

**5. Seguridad Funcional**
¿Las funciones de seguridad hacen lo que deben?

*Ejemplo:* El sistema de login debe bloquear la cuenta tras 3 intentos fallidos (si así está especificado).

### 3.1.2 Ejemplo Detallado de Prueba Funcional

**Sistema:** Tienda online
**Función a probar:** Añadir producto al carrito

**Requisitos:**
1. El usuario puede añadir cualquier producto disponible al carrito
2. Se muestra confirmación al añadir
3. El contador del carrito se actualiza
4. El precio del carrito se actualiza
5. No se puede añadir más unidades que el stock disponible

**Casos de prueba funcionales:**

| ID | Descripción | Entrada | Resultado Esperado |
|----|-------------|---------|-------------------|
| F01 | Añadir producto con stock | Producto con 10 uds. disponibles, añadir 1 | Producto añadido, contador +1, precio actualizado |
| F02 | Añadir cantidad exacta al stock | Producto con 5 uds., añadir 5 | Se añaden 5, stock queda a 0 |
| F03 | Añadir más que stock | Producto con 3 uds., añadir 5 | Error: "Solo hay 3 unidades disponibles" |
| F04 | Añadir producto sin stock | Producto con 0 uds. | Botón deshabilitado o error al intentar |

## 3.2 Aspectos No Funcionales

Los aspectos no funcionales responden a la pregunta: **"¿CÓMO lo hace el sistema?"**

Se refieren a características de calidad que no son funciones en sí, sino atributos del comportamiento del sistema.

### 3.2.1 Características No Funcionales Principales

**1. Fiabilidad (Reliability)**
Capacidad de mantener un nivel de rendimiento bajo condiciones definidas durante un tiempo determinado.

*Métricas comunes:*
- MTBF (Mean Time Between Failures): Tiempo medio entre fallos
- MTTR (Mean Time To Repair): Tiempo medio de reparación
- Disponibilidad: % del tiempo que el sistema está operativo

*Ejemplo:* "El sistema debe tener una disponibilidad del 99,9% (solo 8,76 horas de caída al año)"

**2. Usabilidad**
Facilidad de uso, aprendizaje y satisfacción del usuario.

*Aspectos a evaluar:*
- Comprensibilidad: ¿Es fácil entender qué hace?
- Aprendibilidad: ¿Es fácil aprender a usarlo?
- Operabilidad: ¿Es fácil operarlo?
- Atractivo: ¿La interfaz es agradable?

*Ejemplo:* "Un usuario nuevo debe poder completar una compra sin ayuda en menos de 5 minutos"

**3. Eficiencia / Rendimiento**
Uso óptimo de recursos (tiempo, memoria, CPU, red).

*Aspectos a evaluar:*
- Tiempo de respuesta
- Throughput (transacciones por segundo)
- Uso de recursos

*Ejemplo:* "La página principal debe cargar en menos de 2 segundos con conexión 4G"

**4. Mantenibilidad**
Facilidad para modificar el sistema (correcciones, mejoras, adaptaciones).

*Aspectos a evaluar:*
- Analizabilidad: ¿Es fácil diagnosticar problemas?
- Modificabilidad: ¿Es fácil hacer cambios?
- Estabilidad: ¿Los cambios causan efectos secundarios?
- Testabilidad: ¿Es fácil probar los cambios?

**5. Portabilidad**
Facilidad para trasladar el sistema a otro entorno.

*Aspectos a evaluar:*
- Adaptabilidad: ¿Se adapta a diferentes entornos?
- Instalabilidad: ¿Es fácil de instalar?
- Coexistencia: ¿Puede convivir con otro software?
- Reemplazabilidad: ¿Es fácil reemplazar otro sistema?

*Ejemplo:* "La aplicación debe funcionar en Windows 10, Windows 11 y macOS 12+"

### 3.2.2 Comparación Visual

```
┌─────────────────────────────────────────────────────────────────────────┐
│          ASPECTOS FUNCIONALES vs NO FUNCIONALES                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  FUNCIONALES                          NO FUNCIONALES                    │
│  ────────────                         ──────────────                    │
│  • ¿Qué hace?                         • ¿Cómo lo hace?                  │
│  • Comportamiento                     • Atributos de calidad            │
│  • Requisitos explícitos              • A menudo implícitos             │
│  • Verificación directa               • Requieren métricas              │
│                                                                         │
│  Ejemplos:                            Ejemplos:                         │
│  "Calcular total del carrito"         "Calcular en menos de 1 segundo"  │
│  "Enviar email de confirmación"       "Soportar 1000 usuarios"          │
│  "Validar tarjeta de crédito"         "Disponible 99.9% del tiempo"     │
│  "Mostrar historial de pedidos"       "Interfaz intuitiva"              │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 3.2.3 Tipos de Pruebas No Funcionales

**Pruebas de Carga:**
Verificar el comportamiento bajo carga normal y esperada.
*Ejemplo:* Simular 500 usuarios concurrentes (el máximo esperado en hora punta)

**Pruebas de Estrés:**
Verificar el comportamiento bajo sobrecarga extrema.
*Ejemplo:* Simular 5.000 usuarios para ver cuándo y cómo falla el sistema

**Pruebas de Volumen:**
Verificar el comportamiento con grandes cantidades de datos.
*Ejemplo:* Cargar 10 millones de registros en la base de datos

**Pruebas de Seguridad:**
Verificar protección contra accesos no autorizados.
*Ejemplo:* Intentar inyección SQL, XSS, acceso sin autenticación

**Pruebas de Usabilidad:**
Verificar facilidad de uso con usuarios reales.
*Ejemplo:* Observar a 10 usuarios completando tareas típicas

## 3.3 Ejercicios Resueltos

**EJERCICIO 1:**
Clasifica los siguientes requisitos como funcionales (F) o no funcionales (NF):

a) "El sistema debe permitir búsqueda de productos por nombre"
b) "Las búsquedas deben devolver resultados en menos de 3 segundos"
c) "El sistema debe enviar email de bienvenida al registrarse"
d) "La aplicación debe funcionar en Android 10 o superior"
e) "Los usuarios pueden exportar sus datos en formato PDF"
f) "El sistema debe estar disponible 24/7"

**SOLUCIÓN:**
a) **F** - Es una función que debe realizar el sistema
b) **NF** - Es un requisito de rendimiento (cómo de rápido)
c) **F** - Es una acción concreta del sistema
d) **NF** - Es un requisito de portabilidad
e) **F** - Es una función de exportación
f) **NF** - Es un requisito de disponibilidad/fiabilidad

---

**EJERCICIO 2:**
Para un sistema de banca online, indica qué tipo de prueba no funcional aplicarías para verificar cada requisito:

a) "El sistema debe soportar 10.000 usuarios simultáneos"
b) "Tras un fallo, el sistema debe recuperarse en menos de 30 segundos"
c) "Los datos sensibles deben estar cifrados"
d) "Un usuario nuevo debe poder hacer una transferencia en menos de 2 minutos"

**SOLUCIÓN:**
a) **Prueba de carga/rendimiento** - Simular 10.000 usuarios concurrentes
b) **Prueba de recuperación/fiabilidad** - Provocar un fallo y medir tiempo de recuperación
c) **Prueba de seguridad** - Verificar cifrado en tránsito y en reposo, analizar vulnerabilidades
d) **Prueba de usabilidad** - Test con usuarios reales midiendo tiempo de completar tarea

---

# MÓDULO 4: TIPOS DE PRUEBAS

## 4.1 Clasificación General

Las pruebas se pueden clasificar según varios criterios:

```
TIPOS DE PRUEBAS
│
├── Por CONOCIMIENTO del sistema
│   ├── Caja Negra (Black Box)
│   ├── Caja Blanca (White Box)
│   └── Caja Gris (Grey Box)
│
├── Por EJECUCIÓN del software
│   ├── Estáticas (sin ejecutar)
│   └── Dinámicas (ejecutando)
│
├── Por OBJETIVO
│   ├── Funcionales
│   ├── No funcionales
│   ├── De regresión
│   └── De mantenimiento
│
└── Por NIVEL
    ├── Unitarias/Componentes
    ├── Integración
    ├── Sistema
    └── Aceptación
```

## 4.2 Pruebas Estáticas vs Dinámicas

### 4.2.1 Pruebas Estáticas

Son aquellas que se realizan **sin ejecutar** el software. Se analizan los artefactos del proyecto (código, documentos, diseños) para encontrar defectos.

**Técnicas estáticas:**

| Técnica | Descripción | Participantes |
|---------|-------------|---------------|
| Revisión informal | Lectura sin proceso formal | 1-2 personas |
| Walkthrough | El autor presenta y explica | Equipo |
| Revisión técnica | Revisión estructurada con checklist | Equipo técnico |
| Inspección | Proceso formal con roles definidos | Moderador, autor, revisores |

**Ventajas de las pruebas estáticas:**
- Detectan defectos muy temprano (antes de codificar)
- Son económicas (no necesitan entorno de ejecución)
- Encuentran defectos que las pruebas dinámicas no pueden encontrar fácilmente (código muerto, incumplimiento de estándares)

**Ejemplo de inspección de código:**
```java
// Código a revisar
public double calcularDescuento(double precio, int cantidad) {
    if (cantidad > 10)
        descuento = 0.15;  // ERROR: variable no declarada
    else if (cantidad > 5)
        descuento = 0.10;
    return precio * descuento;  // ERROR: puede no estar inicializada
}
```

Una revisión estática detectaría estos errores antes de ejecutar el código.

### 4.2.2 Pruebas Dinámicas

Son aquellas que requieren **ejecutar** el software con datos de prueba y comparar los resultados obtenidos con los esperados.

**Características:**
- Necesitan un entorno de ejecución
- Requieren datos de prueba
- Permiten observar el comportamiento real del sistema
- Pueden detectar fallos que dependen del estado o el entorno

**El ciclo de una prueba dinámica:**

```
┌─────────────────────────────────────────────────────────────────────┐
│                    CICLO DE PRUEBA DINÁMICA                         │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐      │
│  │ Preparar │───►│ Ejecutar │───►│ Comparar │───►│ Registrar│      │
│  │  datos   │    │  prueba  │    │resultados│    │  resultado│     │
│  └──────────┘    └──────────┘    └──────────┘    └──────────┘      │
│       │                                               │             │
│       │                                               ▼             │
│       │         ┌──────────────────────────────────────┐           │
│       └────────►│      Resultado esperado              │           │
│                 │           vs                         │           │
│                 │      Resultado obtenido              │           │
│                 │                                      │           │
│                 │  ¿Iguales? → PASA                    │           │
│                 │  ¿Diferentes? → FALLA                │           │
│                 └──────────────────────────────────────┘           │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

## 4.3 Pruebas Funcionales

Verifican que el sistema hace lo que debe hacer según los requisitos.

**Características:**
- Se basan en especificaciones y requisitos
- Prueban funcionalidades específicas
- Verifican entradas, procesos y salidas
- Pueden ser de caja negra o caja blanca

**Ejemplo de caso de prueba funcional:**

| Campo | Valor |
|-------|-------|
| **ID** | TC-001 |
| **Título** | Verificar login con credenciales válidas |
| **Precondiciones** | Usuario "test@email.com" existe con contraseña "Pass123" |
| **Pasos** | 1. Ir a la página de login |
|           | 2. Introducir email "test@email.com" |
|           | 3. Introducir contraseña "Pass123" |
|           | 4. Pulsar botón "Entrar" |
| **Resultado esperado** | Usuario autenticado y redirigido al dashboard |
| **Resultado obtenido** | (a completar en ejecución) |
| **Estado** | (PASA/FALLA) |

## 4.4 Pruebas No Funcionales

Verifican cómo se comporta el sistema en términos de rendimiento, seguridad, usabilidad, etc.

**Tipos principales:**

### Pruebas de Rendimiento
```
Tipos de pruebas de rendimiento:

1. CARGA (Load Testing)
   └── Verificar comportamiento con carga normal/esperada
   └── Ejemplo: 500 usuarios simultáneos

2. ESTRÉS (Stress Testing)
   └── Verificar comportamiento en el límite y más allá
   └── Ejemplo: Aumentar usuarios hasta que falle

3. PICO (Spike Testing)
   └── Verificar respuesta a aumentos repentinos de carga
   └── Ejemplo: De 100 a 1000 usuarios en 1 minuto

4. RESISTENCIA (Endurance/Soak Testing)
   └── Verificar comportamiento bajo carga sostenida
   └── Ejemplo: 500 usuarios durante 8 horas continuas

5. VOLUMEN (Volume Testing)
   └── Verificar comportamiento con grandes volúmenes de datos
   └── Ejemplo: Base de datos con 100 millones de registros
```

### Pruebas de Seguridad
- Pruebas de penetración (pentesting)
- Análisis de vulnerabilidades
- Pruebas de autenticación y autorización
- Pruebas de cifrado

### Pruebas de Usabilidad
- Tests con usuarios reales
- Análisis heurístico
- Eye tracking
- Encuestas de satisfacción

## 4.5 Pruebas de Regresión y Re-pruebas

**Re-prueba (Confirmation Testing):**
Después de corregir un defecto, se vuelve a ejecutar el caso de prueba que lo detectó para confirmar que está arreglado.

**Prueba de Regresión:**
Se ejecutan pruebas de funcionalidades existentes para verificar que los cambios recientes no han introducido nuevos defectos.

```
┌─────────────────────────────────────────────────────────────────────┐
│           RE-PRUEBA vs REGRESIÓN                                    │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  RE-PRUEBA                           REGRESIÓN                      │
│  ─────────                           ─────────                      │
│  • Verifica que el defecto           • Verifica que los cambios    │
│    está corregido                      no han roto nada existente  │
│                                                                     │
│  • Ejecuta el caso que falló         • Ejecuta un conjunto amplio  │
│                                        de casos existentes          │
│                                                                     │
│  • Alcance limitado                  • Alcance amplio               │
│                                                                     │
│  • Obligatoria tras corrección       • Recomendable tras cualquier │
│                                        cambio                       │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

**Smoke Test y Sanity Test:**

- **Smoke Test (prueba de humo):** Prueba rápida y superficial para verificar que las funcionalidades principales funcionan y vale la pena seguir probando. "¿Arranca sin echar humo?"

- **Sanity Test:** Prueba enfocada en verificar que una funcionalidad específica funciona correctamente después de un cambio menor.

## 4.6 Ejercicios Resueltos

**EJERCICIO 1:**
Un equipo detecta un defecto en el cálculo de impuestos. El desarrollador lo corrige. ¿Qué tipos de prueba deberían ejecutarse?

**SOLUCIÓN:**
1. **Re-prueba:** Ejecutar el caso de prueba que detectó el defecto para confirmar que está corregido.

2. **Prueba de regresión:** Ejecutar casos de prueba relacionados con cálculos financieros para asegurar que la corrección no ha afectado a otros cálculos.

---

**EJERCICIO 2:**
Indica qué técnica usarías para encontrar cada tipo de defecto:

a) Un requisito ambiguo que dice "el sistema debe ser rápido"
b) Un bucle infinito en el código
c) Una pantalla que tarda 30 segundos en cargar
d) Un botón que no hace nada al pulsarlo

**SOLUCIÓN:**
a) **Revisión estática de requisitos** - Detectar la ambigüedad antes de implementar

b) **Revisión estática de código** o **Prueba dinámica** - La revisión podría detectar el patrón peligroso; la prueba dinámica lo detectaría al ver que el sistema se cuelga

c) **Prueba dinámica de rendimiento** - Medir el tiempo real de carga

d) **Prueba dinámica funcional** - Ejecutar el sistema y verificar el comportamiento del botón

---

# MÓDULO 5: NIVELES DE PRUEBA

Los niveles de prueba representan las diferentes etapas en las que se prueban los componentes del software, desde las unidades más pequeñas hasta el sistema completo.

## 5.1 Pruebas de Componentes (Unitarias)

### 5.1.1 Definición y Características

Las pruebas de componentes, también llamadas pruebas unitarias, prueban las unidades más pequeñas del software de forma aislada.

**¿Qué es una "unidad"?**
- En programación orientada a objetos: un método o una clase
- En programación procedural: una función o procedimiento
- En general: el módulo más pequeño que se puede probar por separado

**Características:**
- Se ejecutan en un entorno controlado
- Se aísla la unidad de sus dependencias usando mocks o stubs
- Generalmente las realizan los desarrolladores
- Son rápidas de ejecutar
- Se suelen automatizar

### 5.1.2 Ejemplo Práctico

```java
// Función a probar
public class Calculadora {
    public int dividir(int dividendo, int divisor) {
        if (divisor == 0) {
            throw new IllegalArgumentException("No se puede dividir por cero");
        }
        return dividendo / divisor;
    }
}

// Pruebas unitarias
public class CalculadoraTest {
    
    @Test
    public void dividir_numerosPositivos_resultadoCorrecto() {
        Calculadora calc = new Calculadora();
        assertEquals(5, calc.dividir(10, 2));
    }
    
    @Test
    public void dividir_porCero_lanzaExcepcion() {
        Calculadora calc = new Calculadora();
        assertThrows(IllegalArgumentException.class, () -> {
            calc.dividir(10, 0);
        });
    }
    
    @Test
    public void dividir_numerosNegativos_resultadoCorrecto() {
        Calculadora calc = new Calculadora();
        assertEquals(-5, calc.dividir(-10, 2));
    }
}
```

## 5.2 Pruebas de Integración

### 5.2.1 Definición y Características

Las pruebas de integración verifican las interfaces y la interacción entre componentes o sistemas.

**¿Qué se prueba?**
- Comunicación entre módulos
- Interfaces entre componentes
- Flujo de datos entre sistemas
- Interacción con bases de datos, APIs externas, etc.

### 5.2.2 Estrategias de Integración

```
┌─────────────────────────────────────────────────────────────────────┐
│              ESTRATEGIAS DE INTEGRACIÓN                             │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  1. BIG BANG                                                        │
│     └── Integrar todos los componentes a la vez                     │
│     └── Simple pero difícil localizar errores                       │
│                                                                     │
│  2. TOP-DOWN (Arriba-Abajo)                                         │
│     └── Empezar por los módulos de nivel superior                   │
│     └── Usar STUBS para simular módulos inferiores                  │
│     └── Ventaja: prueba temprana del flujo principal                │
│                                                                     │
│  3. BOTTOM-UP (Abajo-Arriba)                                        │
│     └── Empezar por los módulos de nivel inferior                   │
│     └── Usar DRIVERS para simular módulos superiores                │
│     └── Ventaja: los módulos base están bien probados               │
│                                                                     │
│  4. SANDWICH (Híbrida)                                              │
│     └── Combinar Top-Down y Bottom-Up                               │
│     └── Integración simultánea desde arriba y abajo                 │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

**Conceptos clave:**
- **Stub:** Componente simulado que sustituye a un módulo de nivel inferior que aún no está disponible. Devuelve valores predefinidos.
- **Driver:** Componente simulado que sustituye a un módulo de nivel superior, usado para invocar al módulo bajo prueba.

### 5.2.3 Ejemplo de Integración

```
Sistema de Comercio Electrónico:

┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Carrito   │────►│   Pagos     │────►│   Envíos    │
│   de compra │     │             │     │             │
└─────────────┘     └─────────────┘     └─────────────┘
       │                   │                   │
       ▼                   ▼                   ▼
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  Base de    │     │  Pasarela   │     │  API        │
│  Datos      │     │  de pago    │     │  transportista│
└─────────────┘     └─────────────┘     └─────────────┘

Pruebas de integración:
1. Carrito → Base de Datos (¿guarda correctamente los productos?)
2. Carrito → Pagos (¿pasa correctamente el total?)
3. Pagos → Pasarela (¿se comunica correctamente con el banco?)
4. Pagos → Envíos (¿inicia el envío tras pago exitoso?)
```

## 5.3 Pruebas de Sistema

### 5.3.1 Definición y Características

Las pruebas de sistema verifican el comportamiento del sistema completo e integrado, comparándolo con los requisitos especificados.

**Características:**
- Se prueba el sistema como un todo
- En un entorno lo más parecido posible a producción
- Sin stubs ni drivers (todo es real o muy similar a real)
- Incluyen pruebas funcionales y no funcionales
- Generalmente las realiza un equipo de QA independiente

### 5.3.2 Qué se prueba

```
PRUEBAS DE SISTEMA
│
├── Funcionales
│   ├── Flujos de negocio completos (end-to-end)
│   ├── Validaciones de datos
│   ├── Reglas de negocio
│   └── Integraciones con sistemas externos
│
├── No Funcionales
│   ├── Rendimiento del sistema completo
│   ├── Seguridad
│   ├── Usabilidad
│   ├── Recuperación ante fallos
│   └── Instalación/despliegue
│
└── Características de datos
    ├── Integridad de datos
    ├── Conversión de datos (en migraciones)
    └── Persistencia
```

### 5.3.3 Ejemplo de Caso de Prueba de Sistema

| Campo | Valor |
|-------|-------|
| **ID** | SYS-001 |
| **Título** | Flujo completo de compra con tarjeta |
| **Objetivo** | Verificar que un usuario puede completar una compra end-to-end |
| **Precondiciones** | - Usuario registrado y logueado |
|                    | - Productos disponibles en catálogo |
|                    | - Pasarela de pago operativa |
| **Pasos** | 1. Buscar producto "Libro Testing" |
|           | 2. Añadir al carrito |
|           | 3. Ir al carrito |
|           | 4. Proceder al pago |
|           | 5. Seleccionar envío estándar |
|           | 6. Introducir datos de tarjeta válida |
|           | 7. Confirmar compra |
| **Resultado esperado** | - Pedido creado con estado "Confirmado" |
|                        | - Email de confirmación recibido |
|                        | - Stock del producto reducido en 1 |
|                        | - Cargo realizado en la tarjeta |

## 5.4 Pruebas de Aceptación

### 5.4.1 Definición y Características

Las pruebas de aceptación verifican si el sistema cumple con las necesidades del usuario y los criterios de aceptación definidos. Son la "última puerta" antes de producción.

**Tipos de pruebas de aceptación:**

```
PRUEBAS DE ACEPTACIÓN
│
├── UAT (User Acceptance Testing)
│   └── Realizadas por usuarios finales o representantes
│   └── Verifican que el sistema cumple sus necesidades reales
│
├── Pruebas Alpha
│   └── Realizadas internamente en la empresa desarrolladora
│   └── Con usuarios seleccionados antes del lanzamiento
│
├── Pruebas Beta
│   └── Realizadas por usuarios externos seleccionados
│   └── En entorno real antes del lanzamiento general
│
├── Pruebas de Contrato
│   └── Verifican cumplimiento de contrato con el cliente
│
└── Pruebas de Regulación/Compliance
    └── Verifican cumplimiento de normativas legales
    └── Ejemplo: GDPR, PCI-DSS, normativa bancaria
```

### 5.4.2 Criterios de Aceptación

Los criterios de aceptación definen las condiciones que deben cumplirse para que una funcionalidad se considere "aceptada".

**Ejemplo de criterios de aceptación:**

Historia de Usuario: "Como cliente, quiero poder filtrar productos por precio para encontrar lo que puedo permitirme"

| # | Criterio de Aceptación |
|---|------------------------|
| 1 | Existe un filtro de precio con valores mínimo y máximo |
| 2 | Los valores por defecto son 0 y el precio máximo del catálogo |
| 3 | Al aplicar el filtro, solo se muestran productos en ese rango |
| 4 | El filtro funciona en combinación con otros filtros |
| 5 | Si no hay productos en el rango, se muestra mensaje informativo |

## 5.5 Relación entre Niveles (Modelo en V)

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         MODELO EN V                                     │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   DESARROLLO                                          PRUEBAS           │
│   ──────────                                          ───────           │
│                                                                         │
│   Requisitos ─────────────────────────────────► Pruebas de Aceptación  │
│        │                                                   ▲            │
│        ▼                                                   │            │
│   Diseño Sistema ──────────────────────────► Pruebas de Sistema        │
│        │                                                   ▲            │
│        ▼                                                   │            │
│   Diseño Detallado ────────────────────► Pruebas de Integración        │
│        │                                                   ▲            │
│        ▼                                                   │            │
│   Codificación ─────────────────────────► Pruebas Unitarias            │
│                                                                         │
│   Cada fase de desarrollo se verifica con su nivel de prueba           │
│   correspondiente                                                       │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

## 5.6 Ejercicios Resueltos

**EJERCICIO 1:**
¿En qué nivel de prueba detectarías cada uno de estos defectos?

a) Una función de cálculo de IVA que devuelve un resultado incorrecto
b) El módulo de pagos no recibe correctamente el total desde el carrito
c) El sistema completo tarda 60 segundos en procesar un pedido
d) Los usuarios no entienden cómo funciona el formulario de registro

**SOLUCIÓN:**
a) **Pruebas unitarias** - Es un defecto en una función individual
b) **Pruebas de integración** - Es un problema de comunicación entre módulos
c) **Pruebas de sistema** - Es un problema de rendimiento del sistema completo
d) **Pruebas de aceptación (usabilidad)** - Es un problema de experiencia de usuario

---

**EJERCICIO 2:**
Una empresa desarrolla un sistema de reservas de hoteles. Indica qué probarías en cada nivel:

**SOLUCIÓN:**

**Pruebas unitarias:**
- Función que calcula el precio según fechas y tipo de habitación
- Función que valida formato de email
- Función que verifica disponibilidad

**Pruebas de integración:**
- Carrito de reserva → Sistema de pagos
- Sistema de reservas → Base de datos
- Sistema → API del hotel

**Pruebas de sistema:**
- Flujo completo: buscar → seleccionar → reservar → pagar
- Rendimiento con múltiples usuarios
- Seguridad de datos de pago

**Pruebas de aceptación:**
- Usuarios reales completan reservas
- Verificar que cumple requisitos del contrato
- Validar usabilidad de la interfaz

---

# MÓDULO 6: PRINCIPIOS GENERALES DEL TESTING

## 6.1 Los Siete Principios del Testing

Estos principios son reconocidos internacionalmente (ISTQB) y representan las verdades fundamentales sobre el testing que todo profesional debe conocer.

### 6.1.1 Principio 1: El testing muestra la presencia de defectos, no su ausencia

**Explicación detallada:**
Este es probablemente el principio más importante. Por muchas pruebas que ejecutemos, nunca podremos demostrar que el software está libre de defectos. Solo podemos demostrar que existen defectos cuando los encontramos.

**Analogía:**
Es como buscar agujas en un pajar. Si encuentras una aguja, sabes que hay al menos una. Si no encuentras ninguna después de buscar un rato, no puedes asegurar que no hay ninguna; solo que no la has encontrado.

**Implicaciones prácticas:**
- No asumas que un sistema está libre de errores porque las pruebas pasaron
- El objetivo es encontrar defectos, no confirmar que todo funciona
- Siempre existe un riesgo residual

```
┌─────────────────────────────────────────────────────────────────────┐
│                                                                     │
│   "Las pruebas pueden mostrar que hay defectos,                     │
│    pero no pueden probar que no los hay"                            │
│                                                    - Edsger Dijkstra │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 6.1.2 Principio 2: El testing exhaustivo es imposible

**Explicación detallada:**
No es posible probar absolutamente todas las combinaciones de entradas, estados, condiciones y caminos de un programa (excepto en casos triviales). El número de posibles combinaciones crece exponencialmente.

**Ejemplo numérico:**
Un simple formulario con:
- 3 campos de texto (consideremos 10 valores típicos por campo)
- 2 checkboxes (2 estados cada uno)
- 1 dropdown con 5 opciones

Combinaciones posibles: 10 × 10 × 10 × 2 × 2 × 5 = 20.000 combinaciones

Si cada prueba toma 1 minuto: 20.000 minutos = 333 horas = casi 42 días de trabajo continuo

¡Y esto es solo un formulario simple!

**Implicaciones prácticas:**
- Debemos priorizar qué probar
- Usamos técnicas para reducir casos sin perder cobertura
- El análisis de riesgos guía la selección de pruebas

### 6.1.3 Principio 3: Las pruebas tempranas ahorran tiempo y dinero

**Explicación detallada:**
Cuanto antes se encuentre un defecto en el ciclo de desarrollo, más barato será corregirlo. Un defecto encontrado en producción puede costar hasta 100 veces más que si se hubiera encontrado en la fase de requisitos.

**La regla del 1-10-100:**
```
┌─────────────────────────────────────────────────────────────────────┐
│              COSTE RELATIVO DE CORRECCIÓN                           │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   Fase                    Coste relativo                            │
│   ────                    ──────────────                            │
│   Requisitos                   1x                                   │
│   Diseño                       3x                                   │
│   Codificación                10x                                   │
│   Pruebas unitarias           15x                                   │
│   Pruebas de sistema          40x                                   │
│   Producción               100x o más                               │
│                                                                     │
│   ¡Detectar un defecto en producción puede costar 100 veces        │
│    más que detectarlo en requisitos!                                │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

**Implicaciones prácticas:**
- Revisar requisitos y diseños antes de codificar
- Implementar pruebas unitarias durante el desarrollo
- No dejar todas las pruebas para el final

### 6.1.4 Principio 4: Los defectos se agrupan (Clustering)

**Explicación detallada:**
Los defectos no se distribuyen uniformemente en el código. Tienden a concentrarse en ciertos módulos o áreas del sistema. Generalmente, un pequeño número de módulos contiene la mayoría de los defectos.

**La regla del 80/20 (Pareto):**
Aproximadamente el 80% de los defectos se encuentran en el 20% del código.

**¿Por qué ocurre esto?**
- Módulos más complejos → más probabilidad de errores
- Código escrito con prisa → más errores
- Desarrolladores menos experimentados → más errores
- Requisitos poco claros → más malentendidos
- Código modificado frecuentemente → más errores introducidos

**Implicaciones prácticas:**
- Identificar los módulos "problemáticos"
- Concentrar más esfuerzo de pruebas en áreas de alto riesgo
- Analizar métricas de defectos históricos

### 6.1.5 Principio 5: La paradoja del pesticida

**Explicación detallada:**
Si ejecutamos siempre las mismas pruebas, eventualmente dejarán de encontrar defectos nuevos, igual que los insectos desarrollan resistencia a los pesticidas.

**¿Por qué ocurre?**
- Los defectos que esas pruebas podían encontrar ya fueron corregidos
- Los nuevos defectos están en áreas no cubiertas por esas pruebas
- El código ha cambiado pero las pruebas no

**Implicaciones prácticas:**
- Revisar y actualizar los casos de prueba regularmente
- Añadir nuevas pruebas cuando cambia el código
- Usar diferentes técnicas y enfoques de prueba
- Rotar testers entre áreas del sistema

```
Ciclo de la paradoja del pesticida:

     ┌─────────────────────────────────────────────────┐
     │                                                 │
     ▼                                                 │
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ Ejecutar │───►│ Encontrar│───►│ Corregir │───►│ Ya no    │
│ pruebas  │    │ defectos │    │ defectos │    │encuentra │──┘
└──────────┘    └──────────┘    └──────────┘    │ nuevos   │
                                               └──────────┘
                                                     │
                                                     ▼
                                               ┌──────────┐
                                               │ RENOVAR  │
                                               │ PRUEBAS  │
                                               └──────────┘
```

### 6.1.6 Principio 6: El testing depende del contexto

**Explicación detallada:**
No existe una única estrategia de testing válida para todos los proyectos. El enfoque debe adaptarse al tipo de sistema, los riesgos, las normativas aplicables, los recursos disponibles, etc.

**Ejemplos de diferentes contextos:**

| Contexto | Enfoque de Testing |
|----------|-------------------|
| App móvil de juegos | Usabilidad, rendimiento, múltiples dispositivos |
| Software médico | Seguridad, normativas, trazabilidad completa |
| Banca online | Seguridad extrema, precisión, auditoría |
| E-commerce | Rendimiento, disponibilidad, usabilidad |
| Sistema embebido | Recursos limitados, tiempo real, hardware |

**Implicaciones prácticas:**
- Analizar el contexto antes de definir la estrategia
- Adaptar técnicas y herramientas al proyecto
- Considerar restricciones legales y normativas
- Evaluar los riesgos específicos del negocio

### 6.1.7 Principio 7: La falacia de la ausencia de defectos

**Explicación detallada:**
Encontrar y corregir defectos no sirve de nada si el sistema construido no cumple las necesidades del usuario. Un sistema sin defectos pero inútil no tiene valor.

**Diferencia entre Verificación y Validación:**
- **Verificación:** ¿Estamos construyendo el producto correctamente? (cumple especificaciones)
- **Validación:** ¿Estamos construyendo el producto correcto? (cumple necesidades reales)

**Ejemplo:**
Un sistema de facturación puede pasar todas las pruebas técnicas y funcionar perfectamente según la especificación, pero si los usuarios no pueden generar las facturas que necesitan para su negocio, el sistema es un fracaso.

**Implicaciones prácticas:**
- Involucrar a usuarios reales en las pruebas
- No solo probar contra requisitos, también contra expectativas
- Las pruebas de aceptación son fundamentales

## 6.2 Ejercicios Resueltos

**EJERCICIO 1:**
¿Qué principio se aplica en cada situación?

a) Un equipo decide concentrar el 60% del esfuerzo de pruebas en 2 módulos que históricamente han tenido más defectos.

b) Después de 3 meses ejecutando la misma suite de regresión, el equipo decide revisarla y añadir nuevos casos.

c) Un sistema de control de tráfico aéreo invierte mucho más en testing que una aplicación de notas personal.

d) El equipo programa revisiones de requisitos antes de empezar a codificar.

**SOLUCIÓN:**
a) **Principio 4: Los defectos se agrupan** - Concentrar esfuerzo donde hay más probabilidad de encontrar defectos.

b) **Principio 5: Paradoja del pesticida** - Renovar pruebas para seguir encontrando defectos.

c) **Principio 6: El testing depende del contexto** - El nivel de criticidad determina la inversión.

d) **Principio 3: Pruebas tempranas** - Detectar problemas antes de que se conviertan en código.

---

**EJERCICIO 2:**
Un cliente dice: "Hemos ejecutado 5.000 casos de prueba y todos pasan. El sistema está listo para producción". ¿Qué le responderías basándote en los principios del testing?

**SOLUCIÓN:**
Basándome en los principios del testing, le explicaría:

1. **Principio 1:** Que todas las pruebas pasen no demuestra que no haya defectos. Solo significa que no hemos encontrado defectos con esas pruebas específicas.

2. **Principio 2:** 5.000 casos pueden parecer muchos, pero el testing exhaustivo es imposible. ¿Se han cubierto los escenarios de mayor riesgo?

3. **Principio 5:** Si esos 5.000 casos son siempre los mismos, pueden haber dejado de ser efectivos para encontrar nuevos defectos.

4. **Principio 7:** Que pase las pruebas técnicas no garantiza que el sistema sea útil para los usuarios. ¿Se han hecho pruebas de aceptación con usuarios reales?

5. **Principio 6:** ¿El enfoque de pruebas es adecuado para el contexto? ¿Se han considerado todos los aspectos relevantes (seguridad, rendimiento, usabilidad)?

---

# MÓDULO 7: MODELOS DE DESARROLLO Y SU RELACIÓN CON EL TESTING

## 7.1 Introducción

El modelo de desarrollo que sigue un proyecto determina cuándo y cómo se realizan las pruebas. No existe un modelo "mejor" que otro; cada uno tiene sus ventajas según el contexto del proyecto.

## 7.2 Modelo en Cascada

### 7.2.1 Descripción

El modelo en cascada es el más antiguo y tradicional. Las fases se ejecutan de forma secuencial, una tras otra, como una cascada de agua que fluye hacia abajo.

```
┌─────────────────────────────────────────────────────────────────────┐
│                    MODELO EN CASCADA                                │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   ┌─────────────┐                                                   │
│   │ Requisitos  │                                                   │
│   └──────┬──────┘                                                   │
│          │                                                          │
│          ▼                                                          │
│   ┌─────────────┐                                                   │
│   │   Diseño    │                                                   │
│   └──────┬──────┘                                                   │
│          │                                                          │
│          ▼                                                          │
│   ┌─────────────┐                                                   │
│   │Implementación│                                                  │
│   └──────┬──────┘                                                   │
│          │                                                          │
│          ▼                                                          │
│   ┌─────────────┐                                                   │
│   │  Pruebas    │  ◄── Las pruebas son una fase al final           │
│   └──────┬──────┘                                                   │
│          │                                                          │
│          ▼                                                          │
│   ┌─────────────┐                                                   │
│   │Mantenimiento│                                                   │
│   └─────────────┘                                                   │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 7.2.2 Testing en el Modelo en Cascada

**Características:**
- Las pruebas se concentran en una fase específica al final
- Requiere que los requisitos estén completos desde el principio
- Los cambios en fases anteriores son costosos
- Documentación exhaustiva en cada fase

**Ventajas para el testing:**
- Documentación clara disponible para diseñar pruebas
- Tiempo dedicado específicamente a pruebas
- Roles bien definidos

**Desventajas para el testing:**
- Defectos se detectan tarde
- Correcciones son costosas
- Si se acortan plazos, se recorta el testing

## 7.3 Modelo en V

### 7.3.1 Descripción

El modelo en V es una evolución del modelo en cascada que integra las actividades de verificación y validación desde el principio. Cada fase de desarrollo tiene su correspondiente fase de prueba.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         MODELO EN V                                     │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  Requisitos                                         Pruebas Aceptación  │
│      │                                                        ▲         │
│      │   Validación de requisitos                            │         │
│      └────────────────────────────────────────────────────────┘         │
│      │                                                                  │
│      ▼                                                                  │
│  Diseño Sistema                                      Pruebas Sistema   │
│      │                                                        ▲         │
│      │   Verificación de diseño                              │         │
│      └────────────────────────────────────────────────────────┘         │
│      │                                                                  │
│      ▼                                                                  │
│  Diseño Detallado                                 Pruebas Integración   │
│      │                                                        ▲         │
│      │   Verificación de diseño detallado                    │         │
│      └────────────────────────────────────────────────────────┘         │
│      │                                                                  │
│      ▼                                                                  │
│  Codificación ─────────────────────────────────► Pruebas Unitarias     │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 7.3.2 Testing en el Modelo en V

**Características:**
- Las pruebas se planifican en paralelo al desarrollo
- Cada fase de desarrollo tiene su nivel de prueba correspondiente
- Los casos de prueba se diseñan basándose en los documentos de cada fase

**Correspondencias:**

| Fase de Desarrollo | Nivel de Prueba |
|-------------------|-----------------|
| Requisitos de usuario | Pruebas de Aceptación |
| Requisitos de sistema | Pruebas de Sistema |
| Diseño de arquitectura | Pruebas de Integración |
| Diseño detallado | Pruebas Unitarias |

**Ventajas:**
- Integración temprana del testing
- Mejor trazabilidad entre requisitos y pruebas
- Detección más temprana de defectos

## 7.4 Modelos Iterativos e Incrementales

### 7.4.1 Descripción

En estos modelos, el desarrollo se realiza en ciclos cortos (iteraciones) que van construyendo el producto de forma incremental. Cada iteración incluye todas las actividades: análisis, diseño, desarrollo y pruebas.

```
┌─────────────────────────────────────────────────────────────────────────┐
│               MODELO ITERATIVO INCREMENTAL                              │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  Iteración 1          Iteración 2          Iteración 3                 │
│  ───────────          ───────────          ───────────                 │
│  ┌─────────┐          ┌─────────┐          ┌─────────┐                 │
│  │Análisis │          │Análisis │          │Análisis │                 │
│  ├─────────┤          ├─────────┤          ├─────────┤                 │
│  │ Diseño  │          │ Diseño  │          │ Diseño  │                 │
│  ├─────────┤          ├─────────┤          ├─────────┤                 │
│  │Desarrollo│         │Desarrollo│         │Desarrollo│                │
│  ├─────────┤          ├─────────┤          ├─────────┤                 │
│  │ PRUEBAS │          │ PRUEBAS │          │ PRUEBAS │                 │
│  └─────────┘          └─────────┘          └─────────┘                 │
│       │                    │                    │                       │
│       ▼                    ▼                    ▼                       │
│  ┌─────────┐          ┌─────────┐          ┌─────────┐                 │
│  │Incremento│  ───►   │Incremento│  ───►   │Incremento│                │
│  │    1    │          │   1+2   │          │  1+2+3  │                 │
│  └─────────┘          └─────────┘          └─────────┘                 │
│                                                                         │
│  Cada iteración añade funcionalidad al producto                        │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 7.4.2 Testing en Modelos Iterativos

**Características:**
- Pruebas continuas en cada iteración
- Importancia de las pruebas de regresión
- Automatización casi obligatoria
- Feedback rápido

**Ventajas:**
- Defectos detectados pronto
- Menos riesgo de grandes sorpresas al final
- El producto se puede usar antes (versiones parciales)

**Desafíos:**
- Requiere alta automatización
- Las pruebas de regresión crecen con cada iteración
- Necesidad de integración continua

## 7.5 Metodologías Ágiles

### 7.5.1 Descripción

Las metodologías ágiles (Scrum, XP, Kanban, etc.) son un tipo específico de desarrollo iterativo con énfasis en:
- Individuos e interacciones sobre procesos y herramientas
- Software funcionando sobre documentación extensiva
- Colaboración con el cliente sobre negociación de contratos
- Respuesta al cambio sobre seguir un plan

### 7.5.2 Testing en Metodologías Ágiles

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    TESTING EN ÁGIL (SCRUM)                              │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   Sprint (2-4 semanas)                                                  │
│   ─────────────────────                                                 │
│                                                                         │
│   ┌───────────────────────────────────────────────────────────────┐    │
│   │                                                               │    │
│   │  Día 1-2    │  Día 3-8     │  Día 9-10    │  Día 10          │    │
│   │  ──────     │  ────────    │  ─────────   │  ───────         │    │
│   │  Planning   │  Desarrollo  │  Testing     │  Review +        │    │
│   │  +          │  +           │  intensivo   │  Retrospectiva   │    │
│   │  Refinement │  Testing     │  +           │                  │    │
│   │             │  continuo    │  Regresión   │                  │    │
│   │                                                               │    │
│   └───────────────────────────────────────────────────────────────┘    │
│                                                                         │
│   Prácticas de testing en ágil:                                         │
│   • TDD (Test-Driven Development)                                       │
│   • BDD (Behavior-Driven Development)                                   │
│   • Integración Continua (CI)                                           │
│   • Automatización extensiva                                            │
│   • Testing como parte del equipo (no separado)                         │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

**Características del testing ágil:**
- El tester es parte del equipo de desarrollo
- Las historias de usuario incluyen criterios de aceptación
- Automatización es fundamental
- Testing continuo, no una fase separada
- Toda la squad es responsable de la calidad

### 7.5.3 TDD (Test-Driven Development)

En TDD, se escriben las pruebas ANTES del código:

```
Ciclo TDD (Red-Green-Refactor):

1. RED:     Escribir una prueba que falle
               │
               ▼
2. GREEN:   Escribir el código mínimo para que pase
               │
               ▼
3. REFACTOR: Mejorar el código sin romper la prueba
               │
               └──────────► Volver a 1
```

## 7.6 Comparativa de Modelos

| Aspecto | Cascada | Modelo V | Iterativo | Ágil |
|---------|---------|----------|-----------|------|
| Cuándo se prueba | Al final | En paralelo | Cada iteración | Continuamente |
| Flexibilidad a cambios | Baja | Baja | Media | Alta |
| Automatización | Opcional | Recomendada | Necesaria | Imprescindible |
| Documentación | Exhaustiva | Exhaustiva | Media | Mínima viable |
| Feedback | Tardío | Medio | Frecuente | Continuo |
| Mejor para | Requisitos estables | Proyectos formales | Requisitos cambiantes | Entornos dinámicos |

## 7.7 Ejercicios Resueltos

**EJERCICIO 1:**
Una empresa va a desarrollar un sistema de gestión hospitalaria. Los requisitos están muy bien definidos por normativas legales y no van a cambiar. El cliente quiere documentación completa. ¿Qué modelo recomendarías?

**SOLUCIÓN:**
Recomendaría el **Modelo en V** porque:
- Los requisitos están bien definidos y son estables → no necesitamos flexibilidad para cambios
- Hay normativas legales → necesitamos trazabilidad completa entre requisitos y pruebas
- El cliente quiere documentación → el modelo V genera documentación en cada fase
- Es un sistema crítico → el modelo V asegura verificación y validación formal

El modelo en cascada también podría servir, pero el modelo V es mejor porque integra el testing desde el principio, lo cual es crucial para un sistema hospitalario.

---

**EJERCICIO 2:**
Una startup quiere desarrollar una app móvil. No tienen claro exactamente qué funcionalidades tendrá porque dependerá del feedback de los usuarios. Quieren lanzar algo rápido y evolucionar. ¿Qué modelo recomendarías?

**SOLUCIÓN:**
Recomendaría una **metodología ágil (Scrum)** porque:
- Los requisitos no están claros → necesitan flexibilidad
- Quieren feedback de usuarios → las iteraciones cortas permiten incorporarlo
- Quieren lanzar rápido → el desarrollo incremental permite tener versiones usables pronto
- Es una startup → equipos pequeños, poca burocracia

El testing sería:
- Automatización desde el principio para permitir iteraciones rápidas
- Pruebas de aceptación basadas en historias de usuario
- Integración continua para detectar problemas rápidamente
- Posiblemente TDD para asegurar calidad desde el código

---

# RESUMEN FINAL DEL CURSO

Este documento ha cubierto los fundamentos esenciales del testing de software:

1. **Conceptos fundamentales:** Error → Defecto → Fallo, y cómo se relacionan
2. **Calidad del software:** Qué es y cómo el testing contribuye a mejorarla
3. **Aspectos a probar:** Funcionales (qué hace) vs No funcionales (cómo lo hace)
4. **Tipos de pruebas:** Estáticas, dinámicas, funcionales, no funcionales, regresión
5. **Niveles de prueba:** Unitarias, integración, sistema, aceptación
6. **Principios del testing:** Los 7 principios que todo tester debe conocer
7. **Modelos de desarrollo:** Cascada, V, iterativo, ágil, y cómo afectan al testing

---

**Recuerda siempre:**
> "La calidad no es un acto, es un hábito" - Aristóteles

> "El testing no puede demostrar la ausencia de defectos, solo su presencia" - Dijkstra

> "Si no tienes tiempo para hacerlo bien, ¿cuándo tendrás tiempo para hacerlo de nuevo?" - John Wooden
