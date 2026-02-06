# APUNTES COMPLETOS DE TESTING DE SOFTWARE
## Curso de Técnico en Testing y Ciberseguridad Aplicada
### Versión para PROFESORES (Con Soluciones)

> ⚠️ **DOCUMENTO CONFIDENCIAL PARA USO DOCENTE**
> Este documento contiene las soluciones a todos los ejercicios.
> No compartir con alumnos.

---

# MÓDULO 1: CONCEPTOS FUNDAMENTALES DEL TESTING

## 1.1 Introducción: ¿Por qué necesitamos el Testing?

### 1.1.1 El Software en Nuestra Vida Diaria

Vivimos en un mundo completamente dependiente del software. Desde que nos despertamos hasta que nos acostamos, interactuamos con decenas de sistemas informáticos: el despertador del móvil, la aplicación del banco para ver nuestro saldo, el sistema de control del metro, el software que gestiona los semáforos, la plataforma de streaming donde vemos series, el sistema de reservas del restaurante...

Todos estos sistemas tienen algo en común: **fueron creados por seres humanos**. Y los seres humanos, por muy competentes que seamos, cometemos errores. Es una realidad inevitable de nuestra naturaleza.

### 1.1.2 El Coste de los Errores de Software

Los errores de software no son simplemente molestias técnicas. Pueden tener consecuencias devastadoras:

**Consecuencias Económicas:**
- Pérdidas directas por ventas no realizadas
- Costes de compensación a clientes afectados
- Gastos de corrección urgente (horas extra, consultores de emergencia)
- Multas por incumplimiento de regulaciones

**Consecuencias Reputacionales:**
- Pérdida de confianza de los clientes
- Comentarios negativos en redes sociales
- Daño a la imagen de marca que puede tardar años en recuperarse
- Pérdida de ventaja competitiva

**Consecuencias Legales:**
- Demandas por daños y perjuicios
- Sanciones por incumplimiento de normativas (GDPR, PCI-DSS, etc.)
- Responsabilidades civiles o incluso penales en casos graves

**Consecuencias Humanas (en sistemas críticos):**
- En software médico: diagnósticos erróneos, dosificaciones incorrectas
- En software aeronáutico: fallos en sistemas de navegación
- En software industrial: accidentes laborales
- En software de vehículos: accidentes de tráfico

### 1.1.3 Casos Reales de Fallos de Software Catastróficos

**El Therac-25 (1985-1987):**
Una máquina de radioterapia cuyo software tenía defectos que causaron sobredosis masivas de radiación a varios pacientes, resultando en muertes y lesiones graves. El problema: una condición de carrera (race condition) en el código que no fue detectada en las pruebas.

**El Ariane 5 (1996):**
El cohete europeo Ariane 5 explotó 37 segundos después del lanzamiento. Coste: 370 millones de dólares. La causa: un error de conversión de un número de 64 bits a 16 bits que causó un desbordamiento (overflow). El código había funcionado correctamente en Ariane 4, pero nadie lo probó adecuadamente para las nuevas condiciones de Ariane 5.

**Knight Capital (2012):**
Una empresa de trading perdió 440 millones de dólares en 45 minutos debido a un error de software en su sistema de trading automatizado. Un despliegue defectuoso activó código obsoleto que comenzó a realizar operaciones incorrectas a gran velocidad.

**Boeing 737 MAX (2018-2019):**
Dos accidentes aéreos con 346 víctimas mortales. Entre las causas: defectos en el sistema de software MCAS y deficiencias en el proceso de pruebas y certificación.

### 1.1.4 La Analogía de la Construcción

Imaginemos que estamos construyendo un edificio de viviendas. ¿Confiaríamos en que:
- Las instalaciones eléctricas funcionan sin probarlas?
- Las tuberías no tienen fugas sin verificarlo?
- La estructura soportará el peso sin cálculos verificados?
- Los ascensores funcionarán correctamente sin pruebas de seguridad?

Por supuesto que no. Existen normativas, inspecciones y pruebas obligatorias en cada fase de la construcción. El software debería tratarse con el mismo rigor, especialmente cuando vidas humanas o grandes cantidades de dinero dependen de él.

### 1.1.5 El Testing como Disciplina Profesional

El testing no es simplemente "probar cosas para ver si funcionan". Es una disciplina profesional con:

- **Fundamentos teóricos** basados en matemáticas, lógica y estadística
- **Metodologías estructuradas** desarrolladas durante décadas
- **Certificaciones internacionales** reconocidas (ISTQB, CSTE, etc.)
- **Herramientas especializadas** para diferentes tipos de pruebas
- **Roles profesionales específicos** con habilidades diferenciadas

Un tester profesional no es alguien que "simplemente usa el software". Es un especialista que:
- Diseña estrategias de prueba basadas en análisis de riesgos
- Crea casos de prueba usando técnicas formales
- Automatiza pruebas para eficiencia y repetibilidad
- Analiza resultados y comunica defectos de forma efectiva
- Contribuye a la mejora continua del proceso de desarrollo

---

## 1.2 Los Tres Conceptos Clave: Error, Defecto y Fallo

Estos tres términos son absolutamente fundamentales en el mundo del testing. Aunque en el lenguaje cotidiano a menudo se usan como sinónimos, en testing tienen significados muy precisos y diferenciados. Entender la diferencia es crucial para comunicarse correctamente en un equipo de desarrollo y para entender la cadena de causalidad de los problemas de software.

### 1.2.1 ERROR (Mistake / Equivocación)

#### Definición Formal
Un error es una **acción humana incorrecta** que produce un resultado incorrecto. Es el origen, la causa raíz de todo el problema. Los errores los cometen las personas: desarrolladores, analistas, diseñadores, arquitectos, e incluso los propios testers.

#### Características del Error

**1. Es una acción humana (no del software)**
El software no comete errores por sí mismo. El software hace exactamente lo que le dijeron que hiciera. Si hace algo incorrecto, es porque un humano le dio instrucciones incorrectas.

**2. Puede ocurrir en cualquier fase del desarrollo**
- En la fase de requisitos: malinterpretar lo que el cliente necesita
- En la fase de diseño: crear una arquitectura inadecuada
- En la fase de codificación: escribir código incorrecto
- En la fase de pruebas: diseñar casos de prueba que no detectan problemas
- En la fase de documentación: escribir instrucciones incorrectas

**3. Es la causa raíz de los problemas**
Cuando investigamos un fallo de software, si seguimos la cadena de causalidad hasta el origen, siempre encontraremos un error humano.

**4. Tiene múltiples causas posibles:**
- **Falta de conocimiento:** El desarrollador no conocía bien el lenguaje o la tecnología
- **Distracción:** Interrupciones, cansancio, multitarea
- **Presión de tiempo:** Prisas por entregar que llevan a descuidos
- **Mala comunicación:** Requisitos ambiguos o mal transmitidos
- **Complejidad:** El sistema es tan complejo que es fácil cometer errores
- **Herramientas inadecuadas:** El entorno de desarrollo no ayuda a prevenir errores

#### Ejemplos Detallados de Errores por Fase

**Errores en Requisitos:**

| Tipo de Error | Ejemplo | Consecuencia Potencial |
|---------------|---------|------------------------|
| Ambigüedad | "El sistema debe ser rápido" | Cada persona interpreta "rápido" de forma diferente |
| Omisión | No especificar qué pasa si el usuario cancela una operación | El sistema puede quedar en estado inconsistente |
| Contradicción | Un requisito dice máximo 100 caracteres, otro dice mínimo 150 | Imposible implementar correctamente |
| Incorrección | Especificar IVA del 18% cuando legalmente es 21% | Cálculos fiscales incorrectos |

**Errores en Diseño:**

| Tipo de Error | Ejemplo | Consecuencia Potencial |
|---------------|---------|------------------------|
| Arquitectura inadecuada | Diseño que no escala para el volumen esperado | Sistema colapsará bajo carga real |
| Seguridad deficiente | No contemplar cifrado de datos sensibles | Vulnerabilidad a ataques |
| Flujo incompleto | No diseñar qué pasa en casos de error | Comportamiento impredecible |

**Errores en Codificación:**

| Tipo de Error | Ejemplo | Consecuencia Potencial |
|---------------|---------|------------------------|
| Sintaxis | Escribir `>` en lugar de `>=` | Valores límite tratados incorrectamente |
| Lógica | Usar `AND` cuando debería ser `OR` | Condiciones evaluadas incorrectamente |
| Typo | Escribir `cantdad` en lugar de `cantidad` | Error de compilación o variable no definida |
| Off-by-one | Bucle de 0 a 10 cuando debería ser 0 a 9 | Procesamiento de elemento extra o faltante |

### 1.2.2 DEFECTO (Defect / Fault / Bug)

#### Definición Formal
Un defecto es una **imperfección o anomalía** en un producto de trabajo (código, documento, diseño, etc.) que puede hacer que el sistema falle en realizar su función requerida. El defecto es la manifestación del error en el producto.

#### La Relación Error → Defecto
Cuando un humano comete un error durante la creación de un producto de trabajo, ese error queda "plasmado" en el producto como un defecto. El error es la acción; el defecto es el resultado de esa acción.

```
┌─────────────────────────────────────────────────────────────────────┐
│                    ERROR → DEFECTO                                  │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   ACCIÓN HUMANA                      RESULTADO EN EL PRODUCTO       │
│   (Error)                            (Defecto)                      │
│                                                                     │
│   El programador escribe    ───►     El código fuente contiene     │
│   ">" en lugar de ">="               la condición incorrecta        │
│                                                                     │
│   El analista olvida        ───►     El documento de requisitos    │
│   especificar un caso                está incompleto                │
│                                                                     │
│   El diseñador calcula mal  ───►     El diagrama de arquitectura   │
│   la capacidad necesaria             es inadecuado                  │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

#### Características del Defecto

**1. Existe en el producto (código, documentación, diseño)**
A diferencia del error, que es una acción que ya pasó, el defecto es algo que existe físicamente y puede ser encontrado examinando el producto.

**2. Es introducido por un error humano**
Todo defecto tiene su origen en un error. No hay defectos "espontáneos".

**3. Puede estar "dormido" sin causar problemas**
Un defecto en el código puede existir durante años sin causar ningún fallo, simplemente porque nadie ejecutó esa parte del código con las condiciones necesarias para activarlo.

**4. También se le conoce como "bug"**
Este término tiene un origen histórico interesante.

#### Origen del Término "Bug"

El 9 de septiembre de 1947, Grace Hopper y su equipo estaban trabajando en el ordenador Mark II en la Universidad de Harvard cuando encontraron una polilla (moth) atrapada en un relé que estaba causando un mal funcionamiento. Pegaron la polilla en el libro de registro con la anotación "First actual case of bug being found" (Primer caso real de bug encontrado).

Aunque el término "bug" para referirse a fallos técnicos ya existía antes (Thomas Edison lo usaba), este incidente popularizó su uso en el contexto de la informática.

#### Tipos de Defectos

**Por su naturaleza:**
- **Defectos de función:** El sistema no hace lo que debería
- **Defectos de datos:** Procesa o almacena datos incorrectamente
- **Defectos de interfaz:** Problemas en la comunicación entre componentes
- **Defectos de rendimiento:** El sistema es más lento de lo requerido
- **Defectos de usabilidad:** El sistema es difícil de usar
- **Defectos de seguridad:** El sistema es vulnerable a ataques

**Por su severidad:**
- **Crítico:** El sistema no puede usarse, pérdida de datos, riesgo de seguridad
- **Mayor:** Funcionalidad importante no funciona, sin workaround
- **Menor:** Funcionalidad menor afectada, existe workaround
- **Trivial:** Problema cosmético o de documentación

#### Ejemplos Detallados de Defectos

**EJEMPLO 1: Defecto en Condición de Frontera**
```
Requisito: "Aplicar descuento del 10% si el importe es mayor o igual a 100€"

Código CORRECTO:
if (importe >= 100) {
    aplicarDescuento(10);
}

Código con DEFECTO:
if (importe > 100) {        // ← DEFECTO: falta el signo "="
    aplicarDescuento(10);
}

Análisis:
- El ERROR fue del programador al escribir ">" en lugar de ">="
- El DEFECTO es la condición incorrecta que ahora existe en el código
- El defecto causará un FALLO cuando alguien compre exactamente por 100€
```

**EJEMPLO 2: Defecto en Validación**
```
Requisito: "El campo edad debe aceptar valores entre 0 y 120 inclusive"

Código con DEFECTO:
function validarEdad(edad) {
    if (edad > 0 && edad < 120) {  // ← DEFECTO: no incluye 0 ni 120
        return true;
    }
    return false;
}

Análisis:
- Los valores 0 y 120 son válidos según el requisito
- El código los rechazará incorrectamente
- Un recién nacido (edad 0) no podría registrarse
- Una persona de 120 años tampoco
```

**EJEMPLO 3: Defecto en Manejo de Nulos**
```
Código con DEFECTO:
function obtenerNombreCompleto(usuario) {
    return usuario.nombre + " " + usuario.apellido;
}

Análisis:
- Si usuario es null o undefined, este código fallará
- Si nombre o apellido son null, el resultado será incorrecto
- Falta validación de datos de entrada
```

### 1.2.3 FALLO (Failure)

#### Definición Formal
Un fallo es la **manifestación visible** de un defecto durante la ejecución del software. Es cuando el usuario o el tester observa que el sistema no se comporta como debería. El fallo es lo que vemos; el defecto es la causa oculta.

#### La Relación Defecto → Fallo
Cuando el software se ejecuta y el flujo de ejecución pasa por código que contiene un defecto, con datos que activan ese defecto, se produce un fallo observable.

```
┌─────────────────────────────────────────────────────────────────────┐
│                    DEFECTO → FALLO                                  │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   DEFECTO EN EL CÓDIGO              FALLO OBSERVABLE                │
│   (Causa oculta)                    (Síntoma visible)               │
│                                                                     │
│   Condición ">" en lugar   ───►     Cliente de 100€ no recibe      │
│   de ">=" para descuento            su descuento prometido          │
│                                                                     │
│   División sin validar     ───►     Pantalla de error o sistema    │
│   que divisor sea ≠ 0               se congela                      │
│                                                                     │
│   Campo sin límite de      ───►     Datos truncados o error de     │
│   longitud                          base de datos                   │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

#### Características del Fallo

**1. Es observable (se puede ver, medir o detectar)**
A diferencia del defecto que puede estar oculto en el código, el fallo es algo que podemos percibir: un mensaje de error, un resultado incorrecto, un sistema que se congela, un tiempo de respuesta excesivo.

**2. Ocurre durante la ejecución**
Los fallos solo pueden producirse cuando el software está ejecutándose. Un defecto en código que nunca se ejecuta nunca producirá un fallo.

**3. Es consecuencia de un defecto**
Todo fallo tiene como causa un defecto (o varios defectos combinados).

**4. No todos los defectos producen fallos**
Esta es una distinción crucial:
- Un defecto puede estar en código que nunca se ejecuta ("código muerto")
- Un defecto puede requerir condiciones muy específicas para activarse
- Un defecto puede estar "compensado" accidentalmente por otro defecto

#### ¿Cuándo un Defecto NO Produce Fallo?

**Caso 1: Código Muerto**
```
function calcularPrecio(producto) {
    if (producto.tipo == "normal") {
        return producto.precio;
    } else if (producto.tipo == "premium") {
        return producto.precio * 1.2;
    } else {
        // Este código nunca se ejecuta porque todos los productos
        // son "normal" o "premium"
        return producto.precio / 0;  // ← DEFECTO pero nunca falla
    }
}
```

**Caso 2: Condiciones No Alcanzadas**
```
function validarCodigo(codigo) {
    if (codigo.length > 1000000) {  // Nunca nadie introduce códigos tan largos
        // Este código con defectos nunca se ejecuta en la práctica
    }
}
```

**Caso 3: Defectos que se Compensan**
```
// Defecto 1: calcula el doble
function calcularSubtotal(cantidad, precio) {
    return cantidad * precio * 2;  // ERROR: multiplica por 2
}

// Defecto 2: calcula la mitad
function calcularTotal(subtotal, impuesto) {
    return (subtotal + impuesto) / 2;  // ERROR: divide por 2
}

// Por "casualidad", los errores se compensan y el resultado final
// puede parecer correcto en algunos casos
```

#### Tipos de Fallos

**Por visibilidad:**
- **Fallos evidentes:** Pantallazos de error, sistema que se cierra
- **Fallos sutiles:** Resultado ligeramente incorrecto, pérdida de rendimiento
- **Fallos silenciosos:** Corrupción de datos sin mensaje de error

**Por frecuencia:**
- **Fallos sistemáticos:** Ocurren siempre bajo las mismas condiciones
- **Fallos intermitentes:** Ocurren solo a veces (los más difíciles de diagnosticar)
- **Fallos únicos:** Solo han ocurrido una vez

**Por impacto:**
- **Fallos bloqueantes:** Impiden continuar usando el sistema
- **Fallos degradantes:** El sistema funciona pero con limitaciones
- **Fallos cosméticos:** No afectan a la funcionalidad pero sí a la apariencia

### 1.2.4 La Cadena Causa-Efecto Completa

Ahora que entendemos los tres conceptos, veamos cómo se relacionan en una cadena completa de causa-efecto:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CADENA CAUSA-EFECTO COMPLETA                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌─────────────┐       ┌─────────────┐       ┌─────────────┐              │
│   │   ERROR     │ ────► │  DEFECTO    │ ────► │   FALLO     │              │
│   │  (Humano)   │       │ (Producto)  │       │ (Ejecución) │              │
│   └─────────────┘       └─────────────┘       └─────────────┘              │
│         │                     │                     │                       │
│         │                     │                     │                       │
│   ┌─────▼─────┐         ┌─────▼─────┐         ┌─────▼─────┐                │
│   │           │         │           │         │           │                │
│   │ El        │         │ El código │         │ Cuando    │                │
│   │ programador│        │ fuente    │         │ un cliente│                │
│   │ escribe   │         │ contiene: │         │ compra    │                │
│   │ ">" en    │         │           │         │ por 100€  │                │
│   │ lugar de  │         │ if(x>100) │         │ exactos,  │                │
│   │ ">="      │         │           │         │ no recibe │                │
│   │           │         │ en vez de │         │ el        │                │
│   │           │         │           │         │ descuento │                │
│   │           │         │ if(x>=100)│         │           │                │
│   │           │         │           │         │           │                │
│   └───────────┘         └───────────┘         └───────────┘                │
│                                                                             │
│   CAUSA RAÍZ            DEFECTO LATENTE       SÍNTOMA VISIBLE              │
│   (Ya pasó)             (Existe en código)    (Se observa)                 │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Puntos Clave para Recordar

1. **Un ERROR siempre precede a un DEFECTO**
   - Sin acción humana incorrecta, no hay defecto
   - El defecto es el "rastro" que deja el error

2. **Un DEFECTO puede o no producir un FALLO**
   - Depende de si se ejecuta ese código
   - Depende de las condiciones de ejecución

3. **Un FALLO siempre es causado por un DEFECTO**
   - Si observamos un fallo, sabemos que hay al menos un defecto
   - Encontrar el defecto a partir del fallo es parte del proceso de debugging

4. **El testing busca FALLOS para descubrir DEFECTOS**
   - El tester observa el comportamiento (busca fallos)
   - Al encontrar un fallo, sabemos que existe un defecto
   - El desarrollador luego localiza y corrige el defecto
   - Finalmente, se investiga el error para prevenir su repetición

### 1.2.5 El Proceso de Gestión de Defectos

Cuando un tester encuentra un fallo, inicia un proceso de gestión:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CICLO DE VIDA DEL DEFECTO                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐          │
│   │  NUEVO   │────►│ ASIGNADO │────►│ EN CURSO │────►│ RESUELTO │          │
│   │          │     │          │     │          │     │          │          │
│   └──────────┘     └──────────┘     └──────────┘     └────┬─────┘          │
│        │                                                   │                │
│        │ Rechazado                                         │                │
│        │ (no es defecto                                    │                │
│        │  o duplicado)                                     ▼                │
│        │                                             ┌──────────┐          │
│        │                                             │VERIFICADO│          │
│        ▼                                             │ (re-test)│          │
│   ┌──────────┐                                       └────┬─────┘          │
│   │ CERRADO  │◄───────────────────────────────────────────┘                │
│   │          │          Pasa las pruebas                                    │
│   └──────────┘                                                              │
│        ▲                                                                    │
│        │ No pasa (se reabre)                                               │
│        └───────────────────────────────────────────────────────────────────┘
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 1.2.6 Ejercicios de Práctica

---

**EJERCICIO 1:**
En un sistema de reservas de hotel, el requisito dice: "El número de noches debe estar entre 1 y 30". Un usuario introduce 0 noches y el sistema lo acepta sin mostrar error.

**Identifica:**
a) ¿Cuál fue el error?
b) ¿Cuál es el defecto?
c) ¿Cuál es el fallo?

**✅ SOLUCIÓN:**

a) **Error:** El programador no implementó correctamente la validación del número mínimo de noches, olvidando incluir la condición que rechaza valores menores a 1.

b) **Defecto:** El código de validación del formulario no incluye la verificación de que el número de noches sea >= 1 (falta una condición en el código).

c) **Fallo:** El sistema acepta 0 noches como valor válido cuando debería mostrar un mensaje de error indicando que el mínimo es 1 noche.

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

Un paquete de exactamente 2 kg cobra 5€. Analiza:
a) ¿Es correcto este resultado?
b) ¿Qué pasa con un paquete de exactamente 5 kg?
c) ¿Hay algún defecto en el código?

**✅ SOLUCIÓN:**

a) **Depende de la interpretación del requisito.** El requisito dice "Hasta 2 kg: 5€". "Hasta" puede interpretarse como "menor o igual que 2" o "menor que 2". Si la interpretación correcta es "menor o igual", entonces cobrar 5€ por exactamente 2 kg es CORRECTO. El código usa `pesoKg > 2`, lo que significa que 2 kg paga 5€.

b) **Un paquete de exactamente 5 kg paga 10€.** El código usa `pesoKg > 5` para los 15€, por lo que 5 kg exactos entra en el rango de 10€. Según el requisito "De 2 a 5 kg: 10€", esto parece correcto si "de 2 a 5" incluye el 5.

c) **Posible defecto de ambigüedad:** El código funciona correctamente PERO los requisitos son ambiguos. No está claro si los límites son inclusivos o exclusivos. En el mundo real, esto se debería clarificar con el cliente. Si el requisito fuera "2 kg o menos: 5€, más de 2 kg hasta 5 kg: 10€, más de 5 kg: 15€", el código sería correcto.

---

**EJERCICIO 3:**
Un sistema bancario permite transferencias. El requisito dice: "Las transferencias deben ser de mínimo 1€ y máximo 10.000€". Un usuario intenta transferir 10.001€ y el sistema lo permite.

**Identifica:**
a) ¿Cuál fue el error?
b) ¿Cuál es el defecto?
c) ¿Cuál es el fallo?

**✅ SOLUCIÓN:**

a) **Error:** El programador no implementó (u olvidó) la validación del límite superior de las transferencias (10.000€).

b) **Defecto:** El código de validación de transferencias no incluye la condición `importe <= 10000` o similar para rechazar cantidades superiores al máximo permitido.

c) **Fallo:** El sistema permite realizar una transferencia de 10.001€ cuando debería mostrar un mensaje de error indicando que el máximo es 10.000€.

**Nota adicional:** Este tipo de defecto en un sistema bancario podría tener graves consecuencias regulatorias y de seguridad.

---

**EJERCICIO 4:**
Lee el siguiente código y determina si existe algún defecto:

```python
def calcular_promedio(notas):
    suma = 0
    for nota in notas:
        suma = suma + nota
    promedio = suma / len(notas)
    return promedio
```

a) ¿Qué pasaría si se llama a la función con una lista vacía?
b) ¿Es esto un defecto? ¿Por qué?
c) ¿Bajo qué condiciones se manifestaría como fallo?

**✅ SOLUCIÓN:**

a) **Se produciría una excepción ZeroDivisionError.** Si la lista está vacía, `len(notas)` es 0, y al intentar dividir `suma / 0` Python lanza una excepción de división por cero.

b) **Sí, es un defecto.** El código no maneja el caso borde de una lista vacía. Debería validar que la lista tenga al menos un elemento antes de calcular el promedio, o devolver un valor apropiado (como 0 o None) con un mensaje adecuado.

c) **El fallo se manifestaría cuando:**
   - Un profesor intenta calcular el promedio de un alumno que no tiene notas registradas
   - Se procesa un archivo de notas vacío
   - Se llama a la función antes de que se hayan introducido datos
   - Cualquier situación donde la lista de notas esté vacía

**Código corregido:**
```python
def calcular_promedio(notas):
    if not notas:  # Si la lista está vacía
        return None  # o raise ValueError("No hay notas")
    suma = 0
    for nota in notas:
        suma = suma + nota
    promedio = suma / len(notas)
    return promedio
```

---

**EJERCICIO 5:**
Un desarrollador implementó una función de login. Al probarla, funciona perfectamente con usuarios correctos. Sin embargo, cuando un usuario introduce una contraseña incorrecta, en lugar de mostrar "Contraseña incorrecta", el sistema muestra los detalles técnicos del error de base de datos.

a) Identifica el error, defecto y fallo
b) ¿Qué riesgo de seguridad podría tener este defecto?

**✅ SOLUCIÓN:**

a) **Identificación:**
   - **Error:** El programador no implementó un manejo adecuado de excepciones (try-catch) que capture los errores de base de datos y muestre un mensaje genérico al usuario.
   - **Defecto:** El código no tiene manejo de excepciones o el bloque catch está mal implementado, dejando que los errores técnicos se propaguen hasta la interfaz de usuario.
   - **Fallo:** Cuando un usuario introduce credenciales incorrectas, en lugar de ver "Usuario o contraseña incorrectos", ve detalles técnicos del error de base de datos.

b) **Riesgos de seguridad:**
   - **Exposición de información sensible:** Los mensajes de error pueden revelar:
     - Nombre del servidor de base de datos
     - Estructura de las tablas (nombres de tablas y columnas)
     - Tipo de base de datos utilizada (MySQL, Oracle, etc.)
     - Rutas de archivos del servidor
     - Stack traces con información del código
   - **Facilita ataques:** Esta información es muy valiosa para un atacante:
     - Ayuda a planificar ataques de SQL Injection
     - Permite identificar versiones vulnerables
     - Facilita la enumeración de usuarios
   - **Incumplimiento normativo:** Puede violar normativas de protección de datos (GDPR, LOPD)

---

# MÓDULO 2: CALIDAD DEL SOFTWARE Y EL ROL DEL TESTING

## 2.1 ¿Qué es la Calidad del Software?

### 2.1.1 La Complejidad de Definir "Calidad"

Cuando hablamos de calidad en la vida cotidiana, todos tenemos una idea intuitiva de lo que significa: un producto de calidad es "bueno", funciona bien, dura mucho tiempo, cumple nuestras expectativas. Sin embargo, cuando intentamos aplicar este concepto al software, la cosa se complica.

¿Un software tiene calidad si:
- ¿No tiene errores?
- ¿Hace lo que el cliente pidió?
- ¿Es fácil de usar?
- ¿Es rápido?
- ¿Es seguro?
- ¿Es fácil de mantener?
- ¿Todas las anteriores?

La respuesta es que la calidad del software es un concepto **multidimensional** que abarca muchos aspectos diferentes. Diferentes stakeholders (partes interesadas) pueden tener diferentes perspectivas sobre qué significa "calidad" para ellos.

### 2.1.2 Definiciones Formales de Calidad

Las organizaciones internacionales de estandarización han propuesto definiciones formales que nos ayudan a establecer un marco común:

#### Definición según ISO/IEC 9126 (y su sucesora ISO/IEC 25010)

> "La calidad del software es la totalidad de características de un producto de software que le confieren la capacidad de satisfacer necesidades explícitas e implícitas."

**Análisis de esta definición:**

- **"Totalidad de características"**: No es solo una cosa; son múltiples aspectos combinados
- **"Necesidades explícitas"**: Lo que el cliente pide formalmente en los requisitos
- **"Necesidades implícitas"**: Lo que el cliente espera aunque no lo haya dicho

Las necesidades implícitas son especialmente importantes y a menudo se olvidan. Por ejemplo:
- El cliente no suele pedir que "el sistema no pierda mis datos", pero lo espera
- El cliente no suele especificar que "las pantallas deben cargar en un tiempo razonable", pero lo espera
- El cliente no suele pedir que "el sistema sea seguro", pero lo da por hecho

#### Definición según IEEE 610

> "El grado en que un componente, sistema o proceso cumple con los requisitos especificados y/o las necesidades y expectativas del usuario/cliente."

**Análisis:**
Esta definición introduce el concepto de "grado", lo que implica que la calidad no es binaria (tiene o no tiene calidad) sino que es una escala (más o menos calidad).

#### Definición según Philip Crosby

> "Calidad es conformidad con los requisitos."

**Análisis:**
Esta definición más simple pone el énfasis en los requisitos. Si cumples los requisitos, tienes calidad. Esto hace que sea crucial que los requisitos estén bien definidos.

#### Definición según Joseph Juran

> "Calidad es adecuación al uso."

**Análisis:**
Esta perspectiva se centra en el usuario final. No importa si técnicamente el software es perfecto; si el usuario no puede usarlo para su propósito, no tiene calidad.

### 2.1.3 Perspectivas de la Calidad

Diferentes personas ven la calidad de forma diferente:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    PERSPECTIVAS DE LA CALIDAD                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  USUARIO                 DESARROLLADOR             GERENTE/NEGOCIO          │
│  ───────                 ────────────             ───────────────           │
│                                                                             │
│  "Funciona bien"         "Código limpio"          "Dentro de presupuesto"   │
│  "Es fácil de usar"      "Bien documentado"       "Entregado a tiempo"      │
│  "No se cuelga"          "Fácil de mantener"      "Clientes satisfechos"    │
│  "Es rápido"             "Buena arquitectura"     "Pocas incidencias"       │
│  "Hace lo que necesito"  "Tests automatizados"    "Bajo coste operativo"    │
│                                                                             │
│  TESTER                  OPERACIONES              SEGURIDAD                 │
│  ──────                  ───────────              ─────────                 │
│                                                                             │
│  "Sin defectos críticos" "Fácil de desplegar"     "Sin vulnerabilidades"    │
│  "Requisitos cubiertos"  "Monitorizable"          "Datos protegidos"        │
│  "Casos de prueba pasan" "Recuperable"            "Cumple normativas"       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2.1.4 El Modelo de Calidad ISO/IEC 25010

Este estándar internacional define un modelo de calidad con **8 características principales**, cada una dividida en subcaracterísticas:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    MODELO DE CALIDAD ISO/IEC 25010                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  1. FUNCIONALIDAD                    5. FIABILIDAD                          │
│     ├── Completitud funcional           ├── Madurez                         │
│     ├── Corrección funcional            ├── Disponibilidad                  │
│     └── Adecuación funcional            ├── Tolerancia a fallos             │
│                                         └── Recuperabilidad                 │
│                                                                             │
│  2. EFICIENCIA DE DESEMPEÑO          6. SEGURIDAD                           │
│     ├── Comportamiento temporal         ├── Confidencialidad                │
│     ├── Utilización de recursos         ├── Integridad                      │
│     └── Capacidad                       ├── No repudio                      │
│                                         ├── Responsabilidad                 │
│                                         └── Autenticidad                    │
│                                                                             │
│  3. COMPATIBILIDAD                   7. MANTENIBILIDAD                      │
│     ├── Coexistencia                    ├── Modularidad                     │
│     └── Interoperabilidad               ├── Reusabilidad                    │
│                                         ├── Analizabilidad                  │
│                                         ├── Modificabilidad                 │
│                                         └── Testabilidad                    │
│                                                                             │
│  4. USABILIDAD                       8. PORTABILIDAD                        │
│     ├── Reconocibilidad                 ├── Adaptabilidad                   │
│     ├── Aprendibilidad                  ├── Instalabilidad                  │
│     ├── Operabilidad                    └── Reemplazabilidad                │
│     ├── Protección ante errores                                             │
│     ├── Estética de interfaz                                                │
│     └── Accesibilidad                                                       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Explicación Detallada de Cada Característica

**1. FUNCIONALIDAD (Functional Suitability)**
¿El software hace lo que debe hacer?

- **Completitud funcional:** ¿Están implementadas todas las funciones requeridas?
- **Corrección funcional:** ¿Las funciones producen resultados correctos?
- **Adecuación funcional:** ¿Las funciones facilitan el cumplimiento de las tareas?

*Ejemplo:* Un sistema de facturación que calcula correctamente los impuestos (corrección), permite crear todos los tipos de factura necesarios (completitud), y tiene un flujo de trabajo eficiente (adecuación).

**2. EFICIENCIA DE DESEMPEÑO (Performance Efficiency)**
¿Cómo utiliza los recursos?

- **Comportamiento temporal:** Tiempos de respuesta, tiempos de procesamiento
- **Utilización de recursos:** CPU, memoria, disco, red
- **Capacidad:** Límites máximos de usuarios, transacciones, datos

*Ejemplo:* Una web que carga en 2 segundos (temporal), no consume excesiva memoria del navegador (recursos), y soporta 10.000 usuarios concurrentes (capacidad).

**3. COMPATIBILIDAD**
¿Funciona bien con otros sistemas?

- **Coexistencia:** Puede funcionar junto a otros productos sin interferir
- **Interoperabilidad:** Puede intercambiar información con otros sistemas

*Ejemplo:* Una aplicación que puede exportar datos a Excel (interoperabilidad) y funciona sin problemas aunque haya otras aplicaciones abiertas (coexistencia).

**4. USABILIDAD**
¿Es fácil de usar?

- **Reconocibilidad:** ¿Se entiende para qué sirve?
- **Aprendibilidad:** ¿Es fácil aprender a usarlo?
- **Operabilidad:** ¿Es fácil de operar y controlar?
- **Protección ante errores:** ¿Protege al usuario de cometer errores?
- **Estética:** ¿Es visualmente agradable?
- **Accesibilidad:** ¿Pueden usarlo personas con discapacidades?

*Ejemplo:* Una aplicación con tutorial integrado (aprendibilidad), confirmaciones antes de acciones destructivas (protección), y soporte para lectores de pantalla (accesibilidad).

**5. FIABILIDAD (Reliability)**
¿Funciona de forma consistente?

- **Madurez:** Frecuencia de fallos en operación normal
- **Disponibilidad:** Porcentaje de tiempo que está operativo
- **Tolerancia a fallos:** Capacidad de operar a pesar de fallos
- **Recuperabilidad:** Capacidad de recuperar datos y estado tras un fallo

*Ejemplo:* Un sistema bancario que tiene 99.99% de disponibilidad, puede seguir operando si falla un servidor (tolerancia), y recupera las transacciones incompletas automáticamente (recuperabilidad).

**6. SEGURIDAD**
¿Protege la información?

- **Confidencialidad:** Solo acceden quienes deben
- **Integridad:** Los datos no se modifican sin autorización
- **No repudio:** Se puede probar quién hizo qué
- **Responsabilidad:** Se puede rastrear las acciones
- **Autenticidad:** Se puede verificar la identidad

*Ejemplo:* Un sistema con cifrado de datos (confidencialidad), logs de auditoría (responsabilidad), y autenticación de dos factores (autenticidad).

**7. MANTENIBILIDAD**
¿Es fácil de modificar?

- **Modularidad:** Componentes independientes
- **Reusabilidad:** Componentes que se pueden usar en otros contextos
- **Analizabilidad:** Facilidad para diagnosticar defectos
- **Modificabilidad:** Facilidad para hacer cambios
- **Testabilidad:** Facilidad para crear pruebas

*Ejemplo:* Software con arquitectura de microservicios (modularidad), buena cobertura de tests (testabilidad), y código bien documentado (analizabilidad).

**8. PORTABILIDAD**
¿Se puede trasladar a otros entornos?

- **Adaptabilidad:** Facilidad para adaptarse a diferentes entornos
- **Instalabilidad:** Facilidad de instalación
- **Reemplazabilidad:** Capacidad de reemplazar otro software

*Ejemplo:* Una aplicación que funciona en Windows, Mac y Linux (adaptabilidad), con instalador automático (instalabilidad).

### 2.1.5 Calidad del Producto vs Calidad del Proceso

Es importante distinguir entre:

**Calidad del Producto:**
Se refiere al software en sí mismo: ¿funciona bien?, ¿es seguro?, ¿es usable?

**Calidad del Proceso:**
Se refiere a cómo se desarrolla el software: ¿se siguen buenas prácticas?, ¿hay metodologías establecidas?, ¿se hace control de calidad?

Existe una correlación entre ambas: un proceso de calidad tiende a producir productos de calidad. Sin embargo, no es una garantía absoluta. Puedes tener un proceso excelente y aun así producir un producto defectuoso, y viceversa.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│           CALIDAD DEL PROCESO vs CALIDAD DEL PRODUCTO                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                    ┌────────────────────┐                                   │
│                    │ PROCESO DE CALIDAD │                                   │
│                    │                    │                                   │
│                    │ • Metodologías     │                                   │
│                    │ • Estándares       │                                   │
│                    │ • Revisiones       │                                   │
│                    │ • Testing          │                                   │
│                    │ • CI/CD            │                                   │
│                    └─────────┬──────────┘                                   │
│                              │                                              │
│                              │ Tiende a producir                            │
│                              ▼                                              │
│                    ┌────────────────────┐                                   │
│                    │PRODUCTO DE CALIDAD │                                   │
│                    │                    │                                   │
│                    │ • Funcional        │                                   │
│                    │ • Fiable           │                                   │
│                    │ • Eficiente        │                                   │
│                    │ • Seguro           │                                   │
│                    │ • Usable           │                                   │
│                    └────────────────────┘                                   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 2.2 Medidas de Aseguramiento de la Calidad

El aseguramiento de la calidad (QA - Quality Assurance) engloba todas las actividades planificadas y sistemáticas para asegurar que el software cumple los requisitos de calidad. Existen dos enfoques complementarios:

### 2.2.1 Medidas Constructivas (Proactivas)

Las medidas constructivas son acciones que se toman para **prevenir** la introducción de errores en primer lugar. Es el enfoque de "más vale prevenir que curar".

**Principio fundamental:** Es más barato y eficiente evitar que los errores entren en el producto que detectarlos y corregirlos después.

#### Tipos de Medidas Constructivas

**1. Metodologías y Estándares de Desarrollo**

Las metodologías estructuradas proporcionan un marco que reduce la probabilidad de errores:

- **Metodologías de desarrollo:** Scrum, Kanban, XP, RUP
- **Estándares de codificación:** Guías de estilo, convenciones de nombrado
- **Patrones de diseño:** Soluciones probadas a problemas comunes
- **Arquitecturas de referencia:** Estructuras probadas para tipos de sistemas

*Ejemplo:* Un equipo que sigue Scrum tiene revisiones regulares del código, lo que aumenta la probabilidad de detectar errores temprano.

**2. Formación y Capacitación**

Un equipo bien formado comete menos errores:

- Formación en tecnologías utilizadas
- Formación en buenas prácticas
- Certificaciones profesionales
- Mentoring y coaching

*Ejemplo:* Un desarrollador certificado en seguridad web tiene menos probabilidad de introducir vulnerabilidades.

**3. Herramientas de Prevención**

Las herramientas pueden prevenir ciertos tipos de errores:

- **IDEs inteligentes:** Detectan errores de sintaxis mientras escribes
- **Linters:** Detectan problemas de estilo y patrones peligrosos
- **Análisis estático:** Detectan defectos potenciales sin ejecutar el código
- **Compiladores estrictos:** Rechazan código potencialmente problemático

*Ejemplo:* Un linter configurado correctamente puede detectar que estás usando `==` en JavaScript cuando deberías usar `===`.

**4. Plantillas y Checklists**

Documentos estandarizados que aseguran que no se olvida nada:

- Plantillas de requisitos
- Plantillas de diseño
- Checklists de revisión de código
- Checklists de seguridad

**5. Programación en Pareja y Revisiones de Código**

Múltiples ojos detectan más problemas:

- **Pair Programming:** Dos desarrolladores trabajan juntos
- **Code Reviews:** Revisión del código por compañeros
- **Mob Programming:** Todo el equipo programa junto

*Ejemplo:* Un estudio mostró que las revisiones de código pueden detectar entre el 60-90% de los defectos antes de que lleguen a producción.

#### Analogía de las Medidas Constructivas

Las medidas constructivas son como lavarse las manos regularmente: es más eficiente prevenir enfermedades que curarlas después. Del mismo modo, es más eficiente prevenir defectos que corregirlos.

### 2.2.2 Medidas Analíticas (Reactivas)

Las medidas analíticas son acciones que se toman para **detectar** errores que ya se han introducido en el producto. Aunque preferimos prevenir, necesitamos también detectar lo que se nos escapó.

#### Clasificación de Medidas Analíticas

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    MEDIDAS ANALÍTICAS                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                      ESTÁTICAS                                      │   │
│  │              (Sin ejecutar el software)                             │   │
│  │                                                                     │   │
│  │  • Revisiones de documentos (requisitos, diseño)                    │   │
│  │  • Inspecciones formales de código                                  │   │
│  │  • Walkthroughs (recorridos guiados)                                │   │
│  │  • Análisis estático automatizado                                   │   │
│  │  • Revisiones de arquitectura                                       │   │
│  │                                                                     │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                      DINÁMICAS                                      │   │
│  │              (Ejecutando el software)                               │   │
│  │                                                                     │   │
│  │  • Pruebas de caja negra                                            │   │
│  │  • Pruebas de caja blanca                                           │   │
│  │  • Pruebas basadas en experiencia                                   │   │
│  │  • Pruebas de rendimiento                                           │   │
│  │  • Pruebas de seguridad                                             │   │
│  │                                                                     │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Medidas Estáticas

Las pruebas estáticas examinan los artefactos del proyecto sin ejecutar el software:

**1. Revisiones Informales**
- Lectura casual del código o documentos
- Sin proceso formal
- Útil para feedback rápido

**2. Walkthroughs (Recorridos)**
- El autor presenta su trabajo al equipo
- El equipo hace preguntas y comentarios
- Enfocado en educación y consenso

**3. Revisiones Técnicas**
- Proceso estructurado con checklist
- Participantes con roles definidos
- Enfocado en encontrar defectos específicos

**4. Inspecciones**
- El proceso más formal
- Roles específicos: moderador, autor, revisores, secretario
- Métricas y seguimiento
- Reglas estrictas de proceso

**5. Análisis Estático Automatizado**
- Herramientas que analizan el código sin ejecutarlo
- Detectan patrones problemáticos
- Muy eficientes para ciertos tipos de defectos

#### Medidas Dinámicas

Las pruebas dinámicas requieren ejecutar el software:

**1. Pruebas de Caja Negra**
- Sin conocimiento del código interno
- Basadas en requisitos y especificaciones
- Verifican el comportamiento externo

**2. Pruebas de Caja Blanca**
- Con conocimiento del código interno
- Basadas en la estructura del código
- Verifican caminos y lógica interna

**3. Pruebas Basadas en Experiencia**
- Basadas en el conocimiento del tester
- Exploratorias, ad-hoc
- Complementan las pruebas sistemáticas

### 2.2.3 Combinación de Medidas

En la práctica, se combinan medidas constructivas y analíticas:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ESTRATEGIA COMBINADA DE CALIDAD                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  FASE DE REQUISITOS                                                         │
│  ├── Constructiva: Plantillas estándar de requisitos                        │
│  └── Analítica: Revisión de requisitos                                      │
│                                                                             │
│  FASE DE DISEÑO                                                             │
│  ├── Constructiva: Patrones de diseño, arquitecturas de referencia          │
│  └── Analítica: Revisión de arquitectura                                    │
│                                                                             │
│  FASE DE CODIFICACIÓN                                                       │
│  ├── Constructiva: Estándares de código, pair programming, linters          │
│  └── Analítica: Revisión de código, análisis estático                       │
│                                                                             │
│  FASE DE PRUEBAS                                                            │
│  ├── Constructiva: Metodología de pruebas, automatización                   │
│  └── Analítica: Ejecución de pruebas, pruebas exploratorias                 │
│                                                                             │
│  FASE DE DESPLIEGUE                                                         │
│  ├── Constructiva: Checklists de despliegue, automatización                 │
│  └── Analítica: Pruebas de humo, monitorización                             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 2.3 ¿Cómo el Testing Eleva la Calidad?

### 2.3.1 Detección Temprana de Defectos

Una de las contribuciones más importantes del testing es la detección temprana de defectos. Existe un principio fundamental en el desarrollo de software:

> **Cuanto antes se detecta un defecto, más barato es corregirlo.**

Este principio se conoce como la "Regla del 1-10-100" o "Ley del Crecimiento Exponencial del Coste":

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              COSTE DE CORRECCIÓN DE DEFECTOS POR FASE                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│    Fase de Detección              Coste Relativo    Ejemplo Real           │
│    ─────────────────              ──────────────    ────────────           │
│                                                                             │
│    Requisitos                          1x           100€                    │
│    │                                                                        │
│    │  ×3-5                                                                  │
│    ▼                                                                        │
│    Diseño                              5x           500€                    │
│    │                                                                        │
│    │  ×2                                                                    │
│    ▼                                                                        │
│    Codificación                       10x           1.000€                  │
│    │                                                                        │
│    │  ×2                                                                    │
│    ▼                                                                        │
│    Pruebas Unitarias                  15x           1.500€                  │
│    │                                                                        │
│    │  ×2-3                                                                  │
│    ▼                                                                        │
│    Pruebas de Sistema                 40x           4.000€                  │
│    │                                                                        │
│    │  ×2-3                                                                  │
│    ▼                                                                        │
│    Producción                    100x o más         10.000€+                │
│                                                                             │
│    ¡Un defecto detectado en producción puede costar 100 veces              │
│     más que si se hubiera detectado en la fase de requisitos!              │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### ¿Por qué aumenta el coste?

**En Requisitos:**
- Corregir es solo cambiar un documento
- No hay código que modificar
- No hay que re-testear nada

**En Diseño:**
- Hay que modificar documentos de diseño
- Puede afectar a otros componentes diseñados
- Todavía no hay código

**En Codificación:**
- Hay que modificar código
- Puede requerir cambiar otros módulos
- Hay que volver a probar

**En Pruebas:**
- El código ya está escrito
- Hay que diagnosticar, corregir, re-testear
- Puede requerir nuevo despliegue en entorno de pruebas

**En Producción:**
- El sistema está en uso
- Usuarios afectados
- Posibles pérdidas económicas
- Daño reputacional
- Corrección urgente (más costosa)
- Despliegue de emergencia
- Comunicación a usuarios/clientes
- Posibles compensaciones

### 2.3.2 Verificación de Requisitos

El testing verifica que el software hace lo que se especificó. Sin pruebas, no tenemos garantía de que los requisitos se han implementado correctamente.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    VERIFICACIÓN DE REQUISITOS                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Requisito                           Caso de Prueba                        │
│   ─────────                           ──────────────                        │
│                                                                             │
│   "El usuario puede                   CP-001: Login con credenciales        │
│    iniciar sesión con    ───────►     válidas resulta en acceso             │
│    email y contraseña"                concedido                             │
│                                                                             │
│   "Las contraseñas                    CP-002: Contraseña almacenada         │
│    se almacenan          ───────►     no es legible en BD                   │
│    cifradas"                                                                │
│                                                                             │
│   "Después de 3                       CP-003: Tras 3 intentos               │
│    intentos fallidos,    ───────►     fallidos, cuenta bloqueada            │
│    bloquear cuenta"                   durante 30 minutos                    │
│                                                                             │
│   MATRIZ DE TRAZABILIDAD: Cada requisito tiene al menos                    │
│   un caso de prueba que lo verifica                                         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2.3.3 Generación de Evidencia Objetiva

Las pruebas proporcionan métricas y evidencias que permiten tomar decisiones informadas:

**Métricas de Ejecución:**
- Número total de casos de prueba
- Casos ejecutados vs pendientes
- Casos pasados vs fallados
- Porcentaje de éxito

**Métricas de Cobertura:**
- Cobertura de requisitos (% de requisitos con pruebas)
- Cobertura de código (% de líneas/ramas ejecutadas)
- Cobertura de riesgos (% de riesgos probados)

**Métricas de Defectos:**
- Defectos encontrados por severidad
- Defectos abiertos vs cerrados
- Tendencia de defectos en el tiempo
- Densidad de defectos (defectos por KLOC)

**Ejemplo de Dashboard de Calidad:**
```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DASHBOARD DE CALIDAD - Sprint 15                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  EJECUCIÓN DE PRUEBAS            DEFECTOS                                   │
│  ────────────────────            ────────                                   │
│                                                                             │
│  Total casos: 250                Críticos: 0  ✓                             │
│  Ejecutados:  248 (99%)          Mayores:  2  ⚠                             │
│  Pasados:     240 (97%)          Menores:  5                                │
│  Fallados:      8 (3%)           Triviales: 3                               │
│                                                                             │
│  COBERTURA                       TENDENCIA                                  │
│  ─────────                       ─────────                                  │
│                                                                             │
│  Requisitos: 95%                 Sprint 13: 15 defectos                     │
│  Código:     78%                 Sprint 14: 12 defectos                     │
│  Riesgos:    100%                Sprint 15: 10 defectos   ↓ Mejorando       │
│                                                                             │
│  DECISIÓN: Ready para release (con plan de corrección de 2 defectos        │
│            mayores en hotfix post-release)                                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2.3.4 Reducción de Riesgos

El testing reduce sistemáticamente los riesgos del proyecto:

**Riesgos que el Testing Mitiga:**

| Riesgo | Cómo lo Mitiga el Testing |
|--------|---------------------------|
| Fallos en producción | Detecta defectos antes del despliegue |
| Pérdidas económicas | Previene ventas perdidas, compensaciones |
| Daño reputacional | Evita que usuarios experimenten fallos |
| Incumplimiento normativo | Verifica conformidad con regulaciones |
| Vulnerabilidades de seguridad | Pruebas de seguridad encuentran fallos |
| Problemas de rendimiento | Pruebas de carga identifican cuellos de botella |

### 2.3.5 Contribución a la Mejora Continua

El testing no solo encuentra defectos; también proporciona información valiosa para mejorar el proceso de desarrollo:

- **Análisis de causa raíz:** ¿Por qué se introdujo este defecto?
- **Patrones de defectos:** ¿En qué áreas aparecen más defectos?
- **Eficacia de técnicas:** ¿Qué técnicas de prueba son más efectivas?
- **Puntos de mejora:** ¿Dónde podemos prevenir defectos?

### 2.3.6 Ejemplo Práctico: El Coste de No Hacer Testing

**Caso Real Simplificado: Empresa de E-commerce**

Una empresa decide lanzar una nueva funcionalidad de pago sin pruebas exhaustivas para llegar a tiempo al Black Friday. La funcionalidad se prueba "a ojo" por un par de desarrolladores y parece funcionar.

**Lo que pasó durante el Black Friday:**

| Impacto | Cantidad | Coste |
|---------|----------|-------|
| Transacciones fallidas | 30% del total | - |
| Clientes afectados | 10.000 | - |
| Ventas perdidas directamente | - | 500.000€ |
| Compensaciones a clientes | - | 50.000€ |
| Horas extra de desarrollo (emergencia) | 200 horas | 20.000€ |
| Consultores externos de emergencia | - | 15.000€ |
| **TOTAL TANGIBLE** | - | **585.000€** |
| Daño reputacional | - | Incalculable |
| Clientes perdidos permanentemente | ~2.000 | ~400.000€/año |

**Lo que hubiera costado hacer testing adecuado:**

| Concepto | Coste |
|----------|-------|
| 2 testers dedicados durante 2 semanas | 8.000€ |
| Entorno de pruebas | 2.000€ |
| Herramientas de pruebas de carga | 3.000€ |
| Automatización básica | 2.000€ |
| **TOTAL TESTING** | **15.000€** |

**Ahorro potencial: 570.000€** (sin contar daño reputacional)

**ROI del Testing = (585.000 - 15.000) / 15.000 = 3.800%**

Por cada euro invertido en testing, se hubieran ahorrado 38€.

## 2.4 Ejercicios de Práctica

---

**EJERCICIO 1:**
Una empresa tiene dos opciones para su próximo lanzamiento:

**Opción A:** Dedicar 2 semanas adicionales a testing antes del lanzamiento

**Opción B:** Lanzar inmediatamente y corregir los problemas que reporten los usuarios

Analiza qué factores debería considerar la empresa para tomar esta decisión. Enumera al menos 6 factores relevantes.

**✅ SOLUCIÓN:**

Factores a considerar:

1. **Criticidad del sistema:** ¿Es un sistema crítico donde los fallos pueden tener consecuencias graves (pérdidas económicas importantes, datos sensibles, salud/seguridad)?

2. **Base de usuarios:** ¿Cuántos usuarios se verán afectados? Un fallo con 1.000 usuarios es diferente que con 1.000.000.

3. **Ventana de mercado:** ¿Hay una fecha límite real (Black Friday, evento) que si se pierde no tiene sentido el lanzamiento?

4. **Competencia:** ¿Lanzar tarde significa perder mercado frente a competidores?

5. **Coste de corrección:** ¿Cuánto costaría corregir defectos en producción vs en testing? (Personal, horas extra, herramientas de emergencia)

6. **Reputación:** ¿Cómo afectaría a la imagen de la empresa un lanzamiento con fallos? ¿Es una primera impresión?

7. **Capacidad de rollback:** ¿Se puede volver atrás fácilmente si hay problemas?

8. **Histórico:** ¿Qué ha pasado en lanzamientos anteriores sin testing adecuado?

9. **Tipo de usuario:** ¿Son usuarios técnicos tolerantes a fallos o usuarios finales exigentes?

10. **Regulaciones:** ¿Hay normativas que exijan cierto nivel de calidad?

**Recomendación general:** En la mayoría de casos, la Opción A (testing adicional) es preferible. Los costes de corrección en producción suelen ser 10-100x mayores que en testing.

---

**EJERCICIO 2:**
Clasifica las siguientes acciones como medidas **Constructivas (C)** o **Analíticas (A)**:

a) Formar al equipo en buenas prácticas de programación
b) Ejecutar pruebas automatizadas cada noche
c) Usar una plantilla estándar para documentar requisitos
d) Revisar el código de un compañero antes de integrarlo
e) Realizar pruebas de rendimiento en un entorno de pre-producción
f) Implementar pair programming
g) Usar un linter que detecta errores de estilo
h) Hacer pruebas exploratorias de la nueva funcionalidad

**✅ SOLUCIÓN:**

a) **Constructiva (C)** - Formar al equipo previene errores futuros
b) **Analítica (A)** - Ejecutar pruebas detecta defectos existentes
c) **Constructiva (C)** - Las plantillas previenen requisitos mal documentados
d) **Analítica (A)** - La revisión de código detecta defectos ya introducidos
e) **Analítica (A)** - Las pruebas de rendimiento detectan problemas existentes
f) **Constructiva (C)** - El pair programming previene la introducción de errores
g) **Constructiva (C)** - El linter previene ciertos tipos de errores mientras se escribe el código (aunque también detecta, su uso principal es preventivo)
h) **Analítica (A)** - Las pruebas exploratorias detectan defectos existentes

**Nota:** Algunas herramientas como los linters pueden considerarse híbridas: previenen cuando detectan mientras escribes, pero también analizan código existente.

---

**EJERCICIO 3:**
Un sistema tiene los siguientes requisitos no funcionales:
- "El sistema debe estar disponible 99.9% del tiempo"
- "Las páginas deben cargar en menos de 2 segundos"
- "El sistema debe soportar 5.000 usuarios concurrentes"

¿A qué característica de calidad del modelo ISO/IEC 25010 corresponde cada uno?

**✅ SOLUCIÓN:**

| Requisito | Característica ISO 25010 | Subcaracterística |
|-----------|-------------------------|-------------------|
| "Disponible 99.9% del tiempo" | **Fiabilidad** | Disponibilidad |
| "Páginas cargan en menos de 2 segundos" | **Eficiencia de Rendimiento** | Comportamiento temporal |
| "5.000 usuarios concurrentes" | **Eficiencia de Rendimiento** | Capacidad |

**Explicación detallada:**
- **Disponibilidad** es una subcaracterística de Fiabilidad que mide el porcentaje de tiempo que el sistema está operativo.
- **Comportamiento temporal** es una subcaracterística de Eficiencia que mide tiempos de respuesta y procesamiento.
- **Capacidad** es una subcaracterística de Eficiencia que mide límites máximos (usuarios, transacciones, volumen de datos).

---

**EJERCICIO 4:**
Observa el siguiente escenario y calcula el ROI (Retorno de Inversión) del testing:

Una empresa invierte 25.000€ en testing para un proyecto. Gracias a las pruebas, se detectaron y corrigieron defectos antes del lanzamiento. Se estima que esos mismos defectos, si hubieran llegado a producción, habrían causado:
- Pérdidas de ventas: 80.000€
- Compensaciones a clientes: 20.000€
- Corrección de emergencia: 30.000€

Calcula:
a) El ahorro total por hacer testing
b) El ROI del testing

**✅ SOLUCIÓN:**

**Datos del problema:**
- Inversión en testing: 25.000€
- Costes evitados si hubieran llegado a producción:
  - Pérdidas de ventas: 80.000€
  - Compensaciones: 20.000€
  - Corrección de emergencia: 30.000€
  - **Total costes evitados: 130.000€**

**a) Ahorro total por hacer testing:**
```
Ahorro = Costes evitados - Inversión en testing
Ahorro = 130.000€ - 25.000€
Ahorro = 105.000€
```

**b) ROI del testing:**
```
ROI = (Beneficio - Inversión) / Inversión × 100
ROI = (130.000 - 25.000) / 25.000 × 100
ROI = 105.000 / 25.000 × 100
ROI = 4,2 × 100
ROI = 420%
```

**Interpretación:** Por cada euro invertido en testing, la empresa obtuvo un retorno de 4,20€. O dicho de otra forma, el testing multiplicó por 5,2 la inversión inicial.

---

**EJERCICIO 5:**
Lee las siguientes situaciones y determina qué perspectiva de calidad está fallando (usuario, desarrollador, negocio, seguridad, etc.):

a) El sistema funciona correctamente pero los usuarios se quejan de que es muy difícil de usar
b) El código fuente es tan complejo que cada cambio introduce nuevos bugs
c) El sistema funciona bien pero la empresa está perdiendo dinero porque el coste de mantenimiento es muy alto
d) Los datos de los clientes fueron robados por hackers
e) El sistema hace exactamente lo especificado pero los usuarios dicen que no les sirve para su trabajo

**✅ SOLUCIÓN:**

a) **Perspectiva del USUARIO (Usabilidad)** - El sistema funciona pero falla en la característica de Usabilidad del modelo ISO 25010. Específicamente en "Operabilidad" y "Aprendibilidad".

b) **Perspectiva del DESARROLLADOR (Mantenibilidad)** - El código tiene problemas de Mantenibilidad, específicamente en "Modificabilidad" y "Analizabilidad". Un código difícil de modificar sin introducir defectos indica baja mantenibilidad.

c) **Perspectiva del NEGOCIO (Eficiencia económica)** - Aunque técnicamente funciona, el alto coste de mantenimiento indica problemas de Mantenibilidad que afectan al negocio. También podría indicar problemas de arquitectura.

d) **Perspectiva de SEGURIDAD** - Claramente falla la característica de Seguridad, específicamente en "Confidencialidad" (datos accedidos sin autorización) y posiblemente "Integridad" si los datos fueron modificados.

e) **Perspectiva del USUARIO/NEGOCIO (Adecuación funcional + Validación)** - El sistema pasa la Verificación (hace lo especificado) pero falla la Validación (no cumple las necesidades reales). Es un problema de "Adecuación Funcional" (Appropriateness) y probablemente de requisitos mal capturados.

---

# MÓDULO 3: ASPECTOS A PROBAR - FUNCIONALES Y NO FUNCIONALES

## 3.1 Introducción: Las Dos Grandes Preguntas

Cuando nos enfrentamos a probar un sistema de software, debemos responder a dos preguntas fundamentales que guiarán todo nuestro trabajo:

1. **¿QUÉ hace el sistema?** → Aspectos Funcionales
2. **¿CÓMO lo hace el sistema?** → Aspectos No Funcionales

Estas dos preguntas representan las dos grandes categorías de características que debemos verificar en cualquier software. Ignorar cualquiera de ellas nos dejaría con una visión incompleta de la calidad del sistema.

### 3.1.1 La Analogía del Restaurante

Imaginemos que vamos a evaluar un restaurante:

**Aspectos Funcionales (¿Qué hace?):**
- ¿Sirven los platos que aparecen en la carta?
- ¿Los platos tienen los ingredientes correctos?
- ¿La cuenta está bien calculada?
- ¿Aceptan las formas de pago que anuncian?

**Aspectos No Funcionales (¿Cómo lo hace?):**
- ¿Cuánto tiempo tardan en servir?
- ¿Es agradable el ambiente?
- ¿El personal es amable?
- ¿Está limpio?
- ¿Es accesible para personas con movilidad reducida?

Un restaurante puede servir exactamente los platos de la carta (funcional correcto) pero tardar 2 horas en servirlos (no funcional incorrecto). O puede ser rapidísimo pero servir platos equivocados. Ambos aspectos son necesarios para una buena experiencia.

## 3.2 Aspectos Funcionales

### 3.2.1 Definición

Los aspectos funcionales se refieren a **las funciones, características y comportamientos que el sistema debe realizar** según sus requisitos. Son las capacidades del software, lo que el sistema hace.

Responden a preguntas como:
- ¿El sistema puede registrar usuarios?
- ¿El sistema calcula correctamente los impuestos?
- ¿El sistema envía notificaciones cuando corresponde?
- ¿El sistema genera los informes especificados?

### 3.2.2 Características Funcionales según ISO/IEC 25010

El estándar internacional define tres subcaracterísticas de la funcionalidad:

#### 1. Completitud Funcional (Functional Completeness)

**Definición:** Grado en el que el conjunto de funciones cubre todas las tareas y objetivos del usuario especificados.

**Pregunta clave:** ¿Están implementadas TODAS las funciones que se pidieron?

**Ejemplo de problema de completitud:**
```
Requisitos del cliente:
✓ El sistema debe permitir crear facturas
✓ El sistema debe permitir crear facturas rectificativas  
✗ El sistema debe permitir crear abonos  ← No implementado

El sistema está INCOMPLETO funcionalmente
```

**Cómo se prueba:**
- Revisar matriz de trazabilidad requisitos-funcionalidades
- Verificar que cada requisito tiene su implementación correspondiente
- Pruebas de cobertura de requisitos

#### 2. Corrección Funcional (Functional Correctness)

**Definición:** Grado en el que el sistema proporciona resultados correctos con el nivel de precisión requerido.

**Pregunta clave:** ¿Las funciones producen resultados CORRECTOS?

**Ejemplo de problema de corrección:**
```
Función: Calcular IVA del 21%

Entrada: Base imponible = 100€
Resultado esperado: 21€
Resultado obtenido: 20.99€  ← INCORRECTO

La función existe pero produce resultados incorrectos
```

**Cómo se prueba:**
- Casos de prueba con resultados esperados calculados
- Comparación de resultados obtenidos vs esperados
- Verificación de precisión numérica
- Validación contra reglas de negocio

#### 3. Adecuación Funcional (Functional Appropriateness)

**Definición:** Grado en el que las funciones facilitan el cumplimiento de tareas y objetivos específicos.

**Pregunta clave:** ¿Las funciones son ADECUADAS para el propósito del usuario?

**Ejemplo de problema de adecuación:**
```
Requisito: El usuario necesita registrar ventas rápidamente

Implementación: 
- Para registrar una venta hay que navegar por 5 pantallas
- Hay que introducir 20 campos obligatorios
- No hay atajos de teclado
- No se pueden guardar plantillas

Las funciones EXISTEN y son CORRECTAS, pero no son ADECUADAS
para el flujo de trabajo real del usuario
```

**Cómo se prueba:**
- Pruebas de usabilidad con usuarios reales
- Análisis de flujos de trabajo
- Medición de tiempo para completar tareas
- Feedback de usuarios

### 3.2.3 Otros Aspectos Funcionales Importantes

#### Interoperabilidad

**Definición:** Capacidad del sistema para intercambiar información con otros sistemas y utilizar esa información.

**Ejemplos:**
- Un ERP que exporta datos a Excel correctamente
- Un sistema que se comunica con la pasarela de pago
- Una aplicación que envía datos a Hacienda en el formato requerido
- Un CRM que se sincroniza con el correo electrónico

**Casos de prueba típicos:**
- Exportar datos y verificar que se pueden abrir en el sistema destino
- Importar datos y verificar que se interpretan correctamente
- Verificar comunicación con APIs externas
- Probar formatos de intercambio (XML, JSON, CSV, etc.)

#### Seguridad Funcional

**Definición:** Las funciones de seguridad hacen lo que deben hacer según los requisitos.

**Ejemplos:**
- El sistema bloquea la cuenta tras 3 intentos fallidos de login
- El sistema cierra la sesión tras 30 minutos de inactividad
- El sistema pide confirmación antes de eliminar datos
- El sistema registra quién hizo cada operación (auditoría)

**Nota:** Esto es diferente de la seguridad como característica no funcional. Aquí hablamos de funciones de seguridad específicas que están en los requisitos.

### 3.2.4 Ejemplo Completo de Pruebas Funcionales

**Sistema:** Tienda Online de Libros
**Función a probar:** Proceso de compra completo

**Requisitos funcionales:**
1. El usuario puede buscar libros por título, autor o ISBN
2. El usuario puede añadir libros al carrito
3. El sistema muestra el precio total incluyendo IVA
4. El sistema aplica descuentos si el usuario tiene cupón válido
5. El usuario puede pagar con tarjeta o PayPal
6. El sistema envía email de confirmación tras la compra
7. El sistema reduce el stock del libro vendido

**Casos de Prueba Funcionales:**

| ID | Función | Descripción del Caso | Datos de Entrada | Resultado Esperado |
|----|---------|---------------------|------------------|-------------------|
| F01 | Búsqueda | Buscar por título existente | Título: "Don Quijote" | Lista con libros que contienen "Don Quijote" |
| F02 | Búsqueda | Buscar por título inexistente | Título: "xyzabc123" | Mensaje "No se encontraron resultados" |
| F03 | Carrito | Añadir libro con stock | Libro con 5 uds. disponibles | Libro añadido, carrito muestra 1 unidad |
| F04 | Carrito | Añadir más unidades que stock | Stock: 3, Añadir: 5 | Error: "Solo hay 3 unidades disponibles" |
| F05 | Precio | Calcular total con IVA | Libro 10€, IVA 21% | Total: 12,10€ |
| F06 | Descuento | Aplicar cupón válido 10% | Cupón: "DESC10", Total: 100€ | Total con descuento: 90€ |
| F07 | Descuento | Aplicar cupón caducado | Cupón caducado | Error: "Cupón no válido o caducado" |
| F08 | Pago | Pagar con tarjeta válida | Datos correctos | Pago procesado, pedido confirmado |
| F09 | Pago | Pagar con tarjeta rechazada | Tarjeta sin fondos | Error: "Pago rechazado por el banco" |
| F10 | Confirmación | Email tras compra exitosa | Compra completada | Email recibido con datos del pedido |
| F11 | Stock | Stock actualizado tras venta | Stock inicial: 5, Compra: 2 | Stock final: 3 |

## 3.3 Aspectos No Funcionales

### 3.3.1 Definición

Los aspectos no funcionales se refieren a **cómo el sistema realiza sus funciones**, no a qué funciones realiza. Son atributos de calidad que describen el comportamiento del sistema.

Responden a preguntas como:
- ¿Qué tan rápido responde el sistema?
- ¿Cuántos usuarios puede soportar simultáneamente?
- ¿Es fácil de usar?
- ¿Es seguro contra ataques?
- ¿Es fácil de mantener?

### 3.3.2 Características No Funcionales Principales

#### 1. Rendimiento / Eficiencia (Performance Efficiency)

**Definición:** Cantidad de recursos utilizados bajo condiciones determinadas.

**Subcaracterísticas:**

**a) Comportamiento Temporal (Time Behaviour)**
- Tiempos de respuesta
- Tiempos de procesamiento
- Tasas de throughput (transacciones por segundo)

**Ejemplos de requisitos:**
- "La página de inicio debe cargar en menos de 2 segundos"
- "Las búsquedas deben devolver resultados en menos de 500ms"
- "El sistema debe procesar al menos 100 transacciones por segundo"

**b) Utilización de Recursos (Resource Utilization)**
- Uso de CPU
- Uso de memoria RAM
- Uso de disco
- Uso de red/ancho de banda

**Ejemplos de requisitos:**
- "La aplicación móvil no debe consumir más de 100MB de RAM"
- "El proceso batch no debe usar más del 50% de CPU"
- "La transferencia de archivos no debe saturar el ancho de banda"

**c) Capacidad (Capacity)**
- Número máximo de usuarios concurrentes
- Número máximo de transacciones
- Volumen máximo de datos

**Ejemplos de requisitos:**
- "El sistema debe soportar 10.000 usuarios simultáneos"
- "La base de datos debe manejar 100 millones de registros"
- "El sistema debe permitir archivos de hasta 1GB"

#### 2. Fiabilidad (Reliability)

**Definición:** Capacidad de mantener un nivel de rendimiento bajo condiciones definidas durante un período de tiempo.

**Subcaracterísticas:**

**a) Madurez (Maturity)**
Frecuencia con la que el sistema falla en operación normal.

**Métricas:**
- MTBF (Mean Time Between Failures): Tiempo medio entre fallos
- Tasa de fallos: Número de fallos por unidad de tiempo

**Ejemplo:** "El sistema no debe tener más de 1 fallo crítico al mes"

**b) Disponibilidad (Availability)**
Porcentaje del tiempo que el sistema está operativo y accesible.

**Cálculo:**
```
Disponibilidad = (Tiempo operativo / Tiempo total) × 100

Niveles típicos:
- 99% = 3.65 días de caída al año
- 99.9% = 8.76 horas de caída al año
- 99.99% = 52.6 minutos de caída al año
- 99.999% = 5.26 minutos de caída al año (los "cinco nueves")
```

**c) Tolerancia a Fallos (Fault Tolerance)**
Capacidad de operar correctamente incluso cuando hay fallos en componentes.

**Ejemplo:** "Si falla un servidor, el sistema debe seguir funcionando con los demás servidores"

**d) Recuperabilidad (Recoverability)**
Capacidad de recuperar datos y restablecer el estado tras un fallo.

**Ejemplo:** "Tras un fallo de energía, el sistema debe recuperarse en menos de 5 minutos sin pérdida de datos"

#### 3. Usabilidad (Usability)

**Definición:** Grado en que el sistema puede ser utilizado por usuarios específicos para lograr objetivos específicos con eficacia, eficiencia y satisfacción.

**Subcaracterísticas:**

**a) Reconocibilidad de Adecuación (Appropriateness Recognizability)**
¿El usuario puede reconocer si el sistema es adecuado para sus necesidades?

**b) Aprendibilidad (Learnability)**
¿Es fácil aprender a usar el sistema?

**Ejemplo:** "Un usuario nuevo debe poder completar una compra sin ayuda en menos de 5 minutos"

**c) Operabilidad (Operability)**
¿Es fácil operar y controlar el sistema?

**d) Protección contra Errores de Usuario (User Error Protection)**
¿El sistema protege al usuario de cometer errores?

**Ejemplos:**
- Pedir confirmación antes de eliminar datos
- Validar datos en tiempo real
- Permitir deshacer acciones

**e) Estética de la Interfaz (User Interface Aesthetics)**
¿La interfaz es visualmente agradable?

**f) Accesibilidad (Accessibility)**
¿Pueden usar el sistema personas con discapacidades?

**Ejemplos:**
- Compatibilidad con lectores de pantalla
- Contraste adecuado para personas con deficiencias visuales
- Tamaño de texto ajustable
- Navegación por teclado

#### 4. Seguridad (Security)

**Definición:** Grado de protección de la información y los datos.

**Subcaracterísticas:**

**a) Confidencialidad (Confidentiality)**
Los datos solo son accesibles por quienes tienen autorización.

**b) Integridad (Integrity)**
Los datos no pueden ser modificados sin autorización.

**c) No Repudio (Non-repudiation)**
Se puede demostrar que las acciones ocurrieron y quién las hizo.

**d) Responsabilidad (Accountability)**
Las acciones pueden ser rastreadas hasta un usuario específico.

**e) Autenticidad (Authenticity)**
Se puede verificar que la identidad de usuarios y recursos es la que declaran.

#### 5. Mantenibilidad (Maintainability)

**Definición:** Grado de eficacia y eficiencia con que el sistema puede ser modificado.

**Subcaracterísticas:**

**a) Modularidad:** Componentes independientes que pueden modificarse sin afectar a otros
**b) Reusabilidad:** Componentes que pueden usarse en otros sistemas
**c) Analizabilidad:** Facilidad para diagnosticar defectos
**d) Modificabilidad:** Facilidad para hacer cambios
**e) Testabilidad:** Facilidad para crear pruebas

#### 6. Portabilidad (Portability)

**Definición:** Grado de eficacia y eficiencia con que el sistema puede ser transferido de un entorno a otro.

**Ejemplos:**
- La aplicación funciona en Windows, Mac y Linux
- La app móvil funciona en Android e iOS
- El sistema puede desplegarse en diferentes proveedores cloud

### 3.3.3 Comparación Visual: Funcional vs No Funcional

```
┌─────────────────────────────────────────────────────────────────────────────┐
│          ASPECTOS FUNCIONALES vs NO FUNCIONALES                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  FUNCIONALES                          NO FUNCIONALES                        │
│  ────────────                         ──────────────                        │
│                                                                             │
│  • ¿QUÉ hace?                         • ¿CÓMO lo hace?                      │
│  • Comportamiento específico          • Atributos de calidad                │
│  • Generalmente explícitos            • A menudo implícitos                 │
│  • Verificación directa               • Requieren métricas                  │
│  • Pass/Fail claro                    • Grados de cumplimiento              │
│                                                                             │
│  EJEMPLOS:                            EJEMPLOS:                             │
│                                                                             │
│  "Calcular el total del carrito"      "Calcular en menos de 1 segundo"      │
│  "Enviar email de confirmación"       "Soportar 1000 usuarios"              │
│  "Validar tarjeta de crédito"         "Disponible 99.9% del tiempo"         │
│  "Mostrar historial de pedidos"       "Interfaz intuitiva"                  │
│  "Generar factura en PDF"             "Funcionar en móviles"                │
│  "Aplicar descuento con cupón"        "Proteger datos personales"           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.3.4 Tipos de Pruebas No Funcionales

#### Pruebas de Rendimiento

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    TIPOS DE PRUEBAS DE RENDIMIENTO                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  1. PRUEBAS DE CARGA (Load Testing)                                         │
│     ─────────────────────────────────                                       │
│     Objetivo: Verificar comportamiento bajo carga normal/esperada           │
│     Ejemplo: Simular 500 usuarios concurrentes (el máximo esperado)         │
│     Pregunta: ¿El sistema mantiene tiempos de respuesta aceptables?         │
│                                                                             │
│  2. PRUEBAS DE ESTRÉS (Stress Testing)                                      │
│     ────────────────────────────────                                        │
│     Objetivo: Encontrar el punto de ruptura del sistema                     │
│     Ejemplo: Aumentar usuarios hasta que el sistema falle                   │
│     Pregunta: ¿Cuándo y cómo falla el sistema?                              │
│                                                                             │
│  3. PRUEBAS DE PICO (Spike Testing)                                         │
│     ───────────────────────────────                                         │
│     Objetivo: Verificar respuesta a aumentos repentinos de carga            │
│     Ejemplo: De 100 a 2000 usuarios en 1 minuto                             │
│     Pregunta: ¿El sistema se recupera tras el pico?                         │
│                                                                             │
│  4. PRUEBAS DE RESISTENCIA (Endurance/Soak Testing)                         │
│     ─────────────────────────────────────────────────                       │
│     Objetivo: Verificar comportamiento bajo carga sostenida                 │
│     Ejemplo: 500 usuarios durante 8 horas continuas                         │
│     Pregunta: ¿Hay degradación o memory leaks con el tiempo?                │
│                                                                             │
│  5. PRUEBAS DE VOLUMEN (Volume Testing)                                     │
│     ─────────────────────────────────                                       │
│     Objetivo: Verificar comportamiento con grandes volúmenes de datos       │
│     Ejemplo: Cargar 100 millones de registros en la base de datos           │
│     Pregunta: ¿El sistema funciona bien con datos a escala real?            │
│                                                                             │
│  6. PRUEBAS DE ESCALABILIDAD (Scalability Testing)                          │
│     ─────────────────────────────────────────────                           │
│     Objetivo: Verificar capacidad de crecer                                 │
│     Ejemplo: Añadir más servidores y verificar mejora proporcional          │
│     Pregunta: ¿El sistema escala linealmente?                               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Pruebas de Seguridad

**Tipos principales:**

1. **Pruebas de Penetración (Pentesting)**
   - Simular ataques reales al sistema
   - Intentar explotar vulnerabilidades
   - Evaluar defensa en profundidad

2. **Análisis de Vulnerabilidades**
   - Escaneo automatizado de vulnerabilidades conocidas
   - Verificación de configuraciones seguras
   - Revisión de dependencias con vulnerabilidades

3. **Pruebas de Autenticación y Autorización**
   - Verificar que solo acceden usuarios autorizados
   - Probar bypass de autenticación
   - Verificar control de acceso por roles

4. **Pruebas de Protección de Datos**
   - Verificar cifrado en tránsito (HTTPS)
   - Verificar cifrado en reposo (BD, archivos)
   - Verificar no exposición de datos sensibles

#### Pruebas de Usabilidad

**Métodos:**

1. **Test con Usuarios Reales**
   - Observar usuarios completando tareas
   - Medir tiempo, errores, satisfacción
   - Identificar puntos de fricción

2. **Evaluación Heurística**
   - Expertos evalúan contra principios de usabilidad
   - Identificar problemas sin usuarios reales

3. **Eye Tracking**
   - Seguimiento de dónde mira el usuario
   - Identificar elementos ignorados o confusos

4. **A/B Testing**
   - Comparar dos versiones de interfaz
   - Medir cuál funciona mejor

## 3.4 La Importancia de Ambos Aspectos

### 3.4.1 ¿Por qué no basta con probar solo funcionalidad?

Un sistema puede ser funcionalmente perfecto pero completamente inútil si:
- Tarda 30 segundos en responder (rendimiento)
- Se cae cada hora (fiabilidad)
- Nadie sabe cómo usarlo (usabilidad)
- Los hackers pueden robar datos (seguridad)
- Hay que reiniciar el servidor para cada cambio (mantenibilidad)

### 3.4.2 ¿Por qué no basta con probar solo aspectos no funcionales?

Un sistema puede ser rapidísimo, muy seguro y fácil de usar, pero completamente inútil si:
- Calcula mal los precios
- No envía las notificaciones requeridas
- No genera los informes necesarios
- No se integra con los sistemas externos requeridos

### 3.4.3 El Equilibrio Necesario

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    EQUILIBRIO FUNCIONAL / NO FUNCIONAL                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                        SISTEMA DE CALIDAD                                   │
│                              │                                              │
│              ┌───────────────┴───────────────┐                              │
│              │                               │                              │
│       ┌──────▼──────┐                 ┌──────▼──────┐                       │
│       │  FUNCIONAL  │                 │NO FUNCIONAL│                        │
│       │             │                 │            │                        │
│       │ ¿Hace lo    │                 │ ¿Lo hace   │                        │
│       │  correcto?  │                 │   bien?    │                        │
│       │             │                 │            │                        │
│       └─────────────┘                 └────────────┘                        │
│                                                                             │
│       AMBOS SON NECESARIOS PARA UN SOFTWARE DE CALIDAD                      │
│                                                                             │
│       Funcional sin No Funcional = Software que funciona pero nadie usa     │
│       No Funcional sin Funcional = Software rápido que hace cosas mal       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 3.5 Ejercicios de Práctica

---

**EJERCICIO 1:**
Clasifica los siguientes requisitos como **Funcionales (F)** o **No Funcionales (NF)**:

a) "El sistema debe permitir búsqueda de productos por nombre"
b) "Las búsquedas deben devolver resultados en menos de 3 segundos"
c) "El sistema debe enviar email de bienvenida al registrarse"
d) "La aplicación debe funcionar en Android 10 o superior"
e) "Los usuarios pueden exportar sus datos en formato PDF"
f) "El sistema debe estar disponible 24/7"
g) "El carrito de compra debe mostrar el total actualizado"
h) "Los datos de tarjeta deben transmitirse cifrados"
i) "Un usuario debe poder completar una compra en menos de 3 clics"
j) "El sistema debe permitir cancelar pedidos en estado pendiente"

**✅ SOLUCIÓN:**

a) **F** - Funcional: Es una función que el sistema debe realizar (buscar productos)
b) **NF** - No Funcional: Es cómo de rápido debe hacerlo (rendimiento/tiempo de respuesta)
c) **F** - Funcional: Es una acción específica del sistema (enviar email)
d) **NF** - No Funcional: Es compatibilidad/portabilidad con un entorno específico
e) **F** - Funcional: Es una función de exportación de datos
f) **NF** - No Funcional: Es disponibilidad (fiabilidad)
g) **F** - Funcional: Es el comportamiento esperado del carrito
h) **NF** - No Funcional: Es seguridad (confidencialidad de datos)
i) **NF** - No Funcional: Es usabilidad (eficiencia de operación)
j) **F** - Funcional: Es una acción que el sistema debe permitir

---

**EJERCICIO 2:**
Para un sistema de banca online, indica qué **tipo de prueba no funcional** aplicarías para verificar cada requisito:

a) "El sistema debe soportar 10.000 usuarios simultáneos"
b) "Tras un fallo, el sistema debe recuperarse en menos de 30 segundos"
c) "Los datos sensibles deben estar cifrados"
d) "Un usuario nuevo debe poder hacer una transferencia sin ayuda en menos de 2 minutos"
e) "El sistema debe estar disponible el 99.9% del tiempo"
f) "La aplicación debe funcionar en los navegadores Chrome, Firefox y Safari"

**✅ SOLUCIÓN:**

| Requisito | Tipo de Prueba No Funcional |
|-----------|-----------------------------|
| a) 10.000 usuarios simultáneos | **Prueba de Carga (Load Testing)** - Simular la carga esperada |
| b) Recuperación en 30 segundos | **Prueba de Recuperabilidad** - Provocar un fallo y medir tiempo de recuperación |
| c) Datos cifrados | **Prueba de Seguridad** - Verificar cifrado en tránsito (HTTPS) y en reposo |
| d) Transferencia en 2 minutos | **Prueba de Usabilidad** - Test con usuarios reales midiendo tiempo para completar tarea |
| e) Disponibilidad 99.9% | **Prueba de Disponibilidad/Fiabilidad** - Monitorizar uptime durante un período |
| f) Funcionar en Chrome, Firefox, Safari | **Prueba de Compatibilidad** - Probar la aplicación en cada navegador |

---

**EJERCICIO 3:**
Para cada situación, indica qué característica de calidad está fallando y si es funcional o no funcional:

a) El sistema calcula correctamente los descuentos, pero tarda 45 segundos en mostrar el resultado
b) La aplicación es muy rápida, pero a veces aplica el IVA incorrecto
c) El sistema funciona perfectamente con 100 usuarios, pero se cae cuando hay 500
d) La exportación a Excel funciona, pero el archivo generado no se puede abrir en Excel
e) El sistema es seguro y rápido, pero los usuarios no encuentran dónde están las opciones

**✅ SOLUCIÓN:**

| Situación | Característica que Falla | Tipo |
|-----------|--------------------------|------|
| a) Calcula bien pero tarda 45 segundos | **Eficiencia de Rendimiento** (Comportamiento temporal) | No Funcional |
| b) Rápida pero IVA incorrecto | **Corrección Funcional** (el cálculo está mal) | Funcional |
| c) Funciona con 100 pero se cae con 500 | **Eficiencia de Rendimiento** (Capacidad) y/o **Fiabilidad** | No Funcional |
| d) Exporta pero no se puede abrir | **Interoperabilidad/Corrección Funcional** (el formato es incorrecto) | Funcional |
| e) Seguro y rápido pero confuso | **Usabilidad** (Operabilidad, Reconocibilidad) | No Funcional |

**Nota:** El caso (d) es interesante porque aunque la función "exportar" existe, el resultado no cumple su propósito, lo que podría verse como un problema de Corrección Funcional o de Interoperabilidad.

---

**EJERCICIO 4:**
Diseña 3 casos de prueba funcionales y 3 casos de prueba no funcionales para un "Sistema de Reserva de Citas Médicas" con los siguientes requisitos:

Requisitos Funcionales:
- El paciente puede buscar médicos por especialidad
- El paciente puede ver horas disponibles de un médico
- El paciente puede reservar una cita

Requisitos No Funcionales:
- El sistema debe responder en menos de 2 segundos
- El sistema debe soportar 1000 usuarios simultáneos
- Los datos médicos deben estar protegidos según normativa

**✅ SOLUCIÓN:**

**CASOS DE PRUEBA FUNCIONALES:**

| ID | Nombre | Pasos | Resultado Esperado |
|----|--------|-------|--------------------|
| F01 | Buscar médicos por especialidad | 1. Acceder a búsqueda 2. Seleccionar "Cardiología" 3. Pulsar buscar | Lista de cardiólogos disponibles |
| F02 | Ver horas disponibles | 1. Seleccionar Dr. García 2. Ver calendario | Mostrar horas libres marcadas en verde |
| F03 | Reservar cita | 1. Seleccionar hora 10:00 del 15/03 2. Confirmar reserva | Mensaje "Cita reservada" y email de confirmación |

**CASOS DE PRUEBA NO FUNCIONALES:**

| ID | Nombre | Tipo | Descripción | Criterio de Aceptación |
|----|--------|------|-------------|------------------------|
| NF01 | Tiempo de respuesta búsqueda | Rendimiento | Medir tiempo desde pulsar "buscar" hasta mostrar resultados | < 2 segundos |
| NF02 | Carga concurrente | Rendimiento/Capacidad | Simular 1000 usuarios buscando simultáneamente | Sistema responde sin errores, tiempo < 5 seg |
| NF03 | Protección de datos médicos | Seguridad | Verificar que historial médico solo visible por paciente y su médico | Acceso denegado a otros usuarios, datos cifrados en BD |

---

# MÓDULO 4: TIPOS DE PRUEBAS

## 4.1 Introducción: La Diversidad del Testing

Cuando hablamos de "testing" o "pruebas de software", en realidad estamos hablando de un universo muy amplio de técnicas, enfoques y niveles diferentes. No existe "un tipo de prueba" que sirva para todo. Diferentes tipos de pruebas tienen diferentes objetivos, se aplican en diferentes momentos, y detectan diferentes tipos de defectos.

En este módulo vamos a explorar las diferentes clasificaciones de pruebas para entender cuándo y por qué usar cada una.

## 4.2 Clasificación General de las Pruebas

Las pruebas se pueden clasificar según varios criterios. Es importante entender que estas clasificaciones son ortogonales: una misma prueba puede pertenecer a varias categorías simultáneamente.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CLASIFICACIÓN DE PRUEBAS                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Por CONOCIMIENTO del código interno                                        │
│  ─────────────────────────────────────                                      │
│  ├── Caja Negra (Black Box) → Sin ver el código                            │
│  ├── Caja Blanca (White Box) → Viendo el código                            │
│  └── Caja Gris (Grey Box) → Conocimiento parcial                           │
│                                                                             │
│  Por EJECUCIÓN del software                                                 │
│  ─────────────────────────────                                              │
│  ├── Estáticas → Sin ejecutar el software                                   │
│  └── Dinámicas → Ejecutando el software                                     │
│                                                                             │
│  Por OBJETIVO de la prueba                                                  │
│  ────────────────────────────                                               │
│  ├── Funcionales → Verificar QUÉ hace                                       │
│  ├── No Funcionales → Verificar CÓMO lo hace                                │
│  ├── De Regresión → Verificar que nada se ha roto                          │
│  └── De Mantenimiento → Tras cambios en producción                          │
│                                                                             │
│  Por NIVEL en el ciclo de desarrollo                                        │
│  ─────────────────────────────────────                                      │
│  ├── Unitarias/Componentes → Piezas individuales                            │
│  ├── Integración → Comunicación entre piezas                                │
│  ├── Sistema → Sistema completo                                             │
│  └── Aceptación → Validación del usuario                                    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 4.3 Pruebas Estáticas vs Dinámicas

Esta es una de las clasificaciones más fundamentales. La diferencia radica en si el software se ejecuta o no durante la prueba.

### 4.3.1 Pruebas Estáticas

**Definición:** Son aquellas que se realizan **sin ejecutar** el software. Se analizan los artefactos del proyecto (código, documentos, diseños) para encontrar defectos mediante inspección, revisión o análisis.

**¿Qué se puede probar estáticamente?**
- Documentos de requisitos
- Documentos de diseño
- Código fuente
- Casos de prueba
- Manuales de usuario
- Contratos y especificaciones

#### Técnicas de Pruebas Estáticas

**1. Revisión Informal (Informal Review)**

| Aspecto | Descripción |
|---------|-------------|
| Formalidad | Muy baja |
| Participantes | 1-2 personas |
| Proceso | Sin proceso definido |
| Documentación | Mínima o ninguna |
| Objetivo | Feedback rápido |
| Ejemplo | Un compañero lee tu código y te da comentarios |

**2. Walkthrough (Recorrido)**

| Aspecto | Descripción |
|---------|-------------|
| Formalidad | Baja a media |
| Participantes | Equipo pequeño |
| Proceso | El autor presenta y explica su trabajo |
| Documentación | Notas informales |
| Objetivo | Educación, consenso, encontrar defectos |
| Ejemplo | El desarrollador explica su diseño al equipo |

**3. Revisión Técnica (Technical Review)**

| Aspecto | Descripción |
|---------|-------------|
| Formalidad | Media a alta |
| Participantes | Equipo técnico con roles |
| Proceso | Checklist, criterios definidos |
| Documentación | Informe de revisión |
| Objetivo | Encontrar defectos, verificar estándares |
| Ejemplo | Revisión de código con checklist de seguridad |

**4. Inspección (Inspection)**

| Aspecto | Descripción |
|---------|-------------|
| Formalidad | Muy alta |
| Participantes | Moderador, autor, revisores, secretario |
| Proceso | Proceso formal con fases definidas |
| Documentación | Completa, con métricas |
| Objetivo | Encontrar defectos de forma sistemática |
| Ejemplo | Inspección formal de requisitos críticos |

**5. Análisis Estático Automatizado**

Herramientas que analizan el código sin ejecutarlo:

- **Linters:** Detectan problemas de estilo y patrones peligrosos
- **Analizadores de seguridad:** Detectan vulnerabilidades conocidas
- **Analizadores de complejidad:** Miden métricas de código
- **Detectores de código duplicado:** Encuentran copy-paste

**Ejemplo de análisis estático:**
```java
// Un analizador estático detectaría estos problemas sin ejecutar el código:

public void procesarDatos(String entrada) {
    // WARNING: Posible NullPointerException - entrada no validada
    int longitud = entrada.length();
    
    // WARNING: Recurso no cerrado - potencial memory leak
    FileInputStream file = new FileInputStream("datos.txt");
    
    // WARNING: Contraseña hardcodeada en código
    String password = "admin123";
    
    // WARNING: SQL Injection - concatenación de string en query
    String query = "SELECT * FROM users WHERE name = '" + entrada + "'";
}
```

#### Ventajas de las Pruebas Estáticas

1. **Detección muy temprana:** Pueden encontrar defectos antes de que haya código ejecutable
2. **Económicas:** No necesitan entorno de ejecución ni datos de prueba
3. **Encuentran defectos únicos:** Código muerto, incumplimiento de estándares, problemas de mantenibilidad
4. **Mejoran el conocimiento del equipo:** Las revisiones comparten conocimiento
5. **Previenen defectos futuros:** Educan sobre buenas prácticas

#### Limitaciones de las Pruebas Estáticas

1. No pueden detectar defectos que dependen del estado en tiempo de ejecución
2. No pueden verificar rendimiento ni comportamiento real
3. Requieren experiencia para ser efectivas
4. Pueden generar falsos positivos (especialmente las herramientas automatizadas)

### 4.3.2 Pruebas Dinámicas

**Definición:** Son aquellas que requieren **ejecutar** el software con datos de prueba y comparar los resultados obtenidos con los esperados.

**Componentes de una Prueba Dinámica:**

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    COMPONENTES DE UNA PRUEBA DINÁMICA                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   1. PRECONDICIONES                                                         │
│      Estado inicial del sistema antes de la prueba                          │
│      Ejemplo: "Usuario logueado, carrito vacío"                             │
│                                                                             │
│   2. DATOS DE ENTRADA                                                       │
│      Valores que se introducen en el sistema                                │
│      Ejemplo: "Producto ID: 123, Cantidad: 2"                               │
│                                                                             │
│   3. ACCIÓN / PASOS                                                         │
│      Operaciones que se realizan                                            │
│      Ejemplo: "Pulsar botón 'Añadir al carrito'"                            │
│                                                                             │
│   4. RESULTADO ESPERADO                                                     │
│      Lo que debería ocurrir según los requisitos                            │
│      Ejemplo: "Carrito muestra 2 unidades del producto 123"                 │
│                                                                             │
│   5. RESULTADO OBTENIDO                                                     │
│      Lo que realmente ocurre al ejecutar                                    │
│      Ejemplo: "Carrito muestra 1 unidad" ← FALLO                           │
│                                                                             │
│   6. VEREDICTO                                                              │
│      Comparación: ¿Esperado = Obtenido?                                     │
│      PASA si son iguales, FALLA si son diferentes                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### El Ciclo de una Prueba Dinámica

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CICLO DE EJECUCIÓN DE PRUEBA                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                          ┌─────────────┐                                    │
│                          │  PREPARAR   │                                    │
│                          │  ENTORNO    │                                    │
│                          └──────┬──────┘                                    │
│                                 │                                           │
│                                 ▼                                           │
│                          ┌─────────────┐                                    │
│                          │  CONFIGURAR │                                    │
│                          │  DATOS      │                                    │
│                          └──────┬──────┘                                    │
│                                 │                                           │
│                                 ▼                                           │
│                          ┌─────────────┐                                    │
│                          │  EJECUTAR   │                                    │
│                          │  PRUEBA     │                                    │
│                          └──────┬──────┘                                    │
│                                 │                                           │
│                                 ▼                                           │
│                          ┌─────────────┐                                    │
│                          │  CAPTURAR   │                                    │
│                          │  RESULTADO  │                                    │
│                          └──────┬──────┘                                    │
│                                 │                                           │
│                                 ▼                                           │
│                          ┌─────────────┐                                    │
│                          │  COMPARAR   │                                    │
│                          │  ESPERADO   │                                    │
│                          └──────┬──────┘                                    │
│                                 │                                           │
│              ┌──────────────────┴──────────────────┐                        │
│              │                                     │                        │
│              ▼                                     ▼                        │
│       ┌─────────────┐                       ┌─────────────┐                │
│       │    PASA     │                       │    FALLA    │                │
│       │   ✓         │                       │   ✗         │                │
│       └─────────────┘                       └──────┬──────┘                │
│                                                    │                        │
│                                                    ▼                        │
│                                             ┌─────────────┐                │
│                                             │  REPORTAR   │                │
│                                             │  DEFECTO    │                │
│                                             └─────────────┘                │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Ventajas de las Pruebas Dinámicas

1. **Verifican comportamiento real:** Prueban lo que realmente hace el software
2. **Detectan defectos de estado:** Problemas que dependen de la secuencia de acciones
3. **Verifican rendimiento:** Solo ejecutando se puede medir velocidad real
4. **Prueban integración:** Verifican que los componentes funcionan juntos
5. **Son convincentes:** Un fallo en ejecución es evidencia clara

#### Limitaciones de las Pruebas Dinámicas

1. Necesitan código ejecutable (no pueden hacerse muy temprano)
2. Necesitan entorno de pruebas configurado
3. Necesitan datos de prueba
4. No pueden probar código no ejecutado
5. Pueden ser lentas de ejecutar

### 4.3.3 Comparación Estática vs Dinámica

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ESTÁTICA vs DINÁMICA                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Característica          ESTÁTICA              DINÁMICA                    │
│   ──────────────          ────────              ────────                    │
│                                                                             │
│   ¿Ejecuta código?        No                    Sí                          │
│                                                                             │
│   ¿Cuándo se puede        Muy temprano          Necesita código            │
│   hacer?                  (desde requisitos)    ejecutable                  │
│                                                                             │
│   ¿Qué encuentra?         Defectos en           Fallos en                   │
│                           artefactos            comportamiento              │
│                                                                             │
│   ¿Necesita entorno       No                    Sí                          │
│   de ejecución?                                                             │
│                                                                             │
│   Coste                   Bajo                  Medio-Alto                  │
│                                                                             │
│   Defectos típicos        Estándares,           Funcionales,                │
│                           seguridad básica,     rendimiento,                │
│                           código muerto         integración                 │
│                                                                             │
│   Ejemplos                Revisión de código,   Pruebas unitarias,          │
│                           análisis estático,    pruebas de sistema,         │
│                           inspecciones          pruebas de carga            │
│                                                                             │
│   AMBAS SON COMPLEMENTARIAS Y NECESARIAS                                    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 4.4 Pruebas de Caja Negra vs Caja Blanca

Esta clasificación se basa en el conocimiento que el tester tiene (o usa) sobre la estructura interna del sistema.

### 4.4.1 Pruebas de Caja Negra (Black Box)

**Definición:** Pruebas basadas únicamente en los requisitos y especificaciones, sin conocimiento ni consideración del código interno.

**Analogía:** Es como probar un coche sin abrir el capó. Solo verificas que al girar el volante el coche gira, que al pisar el freno se detiene, etc. No te importa cómo funciona el motor por dentro.

**Características:**
- Se basan en requisitos y especificaciones
- No se necesita acceso al código fuente
- Se centran en QUÉ hace el sistema
- Las puede hacer alguien que no sabe programar (pero sí debe conocer el negocio)
- Verifican el comportamiento externo

**¿Quién las suele hacer?**
- Testers funcionales
- Analistas de QA
- Usuarios en pruebas de aceptación

**Técnicas de Caja Negra:**
1. Particiones de equivalencia
2. Análisis de valores límite
3. Tablas de decisión
4. Pruebas de transición de estados
5. Pruebas basadas en casos de uso

### 4.4.2 Pruebas de Caja Blanca (White Box)

**Definición:** Pruebas basadas en el conocimiento de la estructura interna del código, diseñadas para ejecutar caminos específicos del programa.

**Analogía:** Es como probar un coche con el capó abierto, verificando que cada componente del motor funciona correctamente, que el combustible fluye por las tuberías correctas, etc.

**Características:**
- Se basan en el código fuente
- Requieren conocimientos de programación
- Se centran en CÓMO funciona internamente
- Buscan cobertura de código
- Verifican la lógica interna

**¿Quién las suele hacer?**
- Desarrolladores
- Testers técnicos con conocimientos de programación

**Técnicas de Caja Blanca:**
1. Cobertura de sentencias
2. Cobertura de decisiones/ramas
3. Cobertura de condiciones
4. Cobertura de caminos
5. Pruebas de flujo de datos

### 4.4.3 Pruebas de Caja Gris (Grey Box)

**Definición:** Combinación de caja negra y caja blanca, donde el tester tiene conocimiento parcial de la estructura interna.

**Ejemplo:** Un tester que conoce la estructura de la base de datos pero no el código de la aplicación. Puede diseñar pruebas más efectivas sabiendo qué tablas consultar para verificar resultados.

### 4.4.4 Comparación Visual

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              CAJA NEGRA vs CAJA BLANCA vs CAJA GRIS                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   CAJA NEGRA                                                                │
│   ┌─────────────────────────────────────┐                                   │
│   │  ┌─────────────────────────────┐    │                                   │
│   │  │         ? ? ? ? ?           │    │                                   │
│   │  │         ? ? ? ? ?           │    │   No vemos el interior            │
│   │  │         ? ? ? ? ?           │    │   Solo entrada/salida             │
│   │  └─────────────────────────────┘    │                                   │
│   │     ▲                       │       │                                   │
│   │     │ Entrada               │ Salida│                                   │
│   └─────┴───────────────────────┴───────┘                                   │
│                                                                             │
│   CAJA BLANCA                                                               │
│   ┌─────────────────────────────────────┐                                   │
│   │  ┌─────────────────────────────┐    │                                   │
│   │  │  if (x > 0) {              │    │                                   │
│   │  │    proceso_A();            │    │   Vemos todo el código            │
│   │  │  } else {                  │    │   Probamos caminos internos       │
│   │  │    proceso_B();            │    │                                   │
│   │  │  }                         │    │                                   │
│   │  └─────────────────────────────┘    │                                   │
│   └─────────────────────────────────────┘                                   │
│                                                                             │
│   CAJA GRIS                                                                 │
│   ┌─────────────────────────────────────┐                                   │
│   │  ┌─────────────────────────────┐    │                                   │
│   │  │  █████ █████ ████          │    │                                   │
│   │  │  if (?) {   }              │    │   Conocimiento parcial            │
│   │  │  █████ █████               │    │   Ej: BD pero no código           │
│   │  │  Tables: users, orders     │    │                                   │
│   │  └─────────────────────────────┘    │                                   │
│   └─────────────────────────────────────┘                                   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 4.5 Pruebas de Regresión y Re-testing

Estos dos tipos de pruebas son cruciales en el mantenimiento del software y a menudo se confunden.

### 4.5.1 Re-testing (Re-prueba / Prueba de Confirmación)

**Definición:** Después de corregir un defecto, se vuelve a ejecutar el caso de prueba que lo detectó para confirmar que el defecto ha sido realmente corregido.

**Características:**
- Es específica: prueba exactamente lo que falló antes
- Es obligatoria: no se puede cerrar un defecto sin re-test
- Alcance limitado: solo el caso que falló

**Ejemplo:**
```
1. Tester ejecuta TC-045 → FALLA (defecto BUG-123)
2. Desarrollador corrige BUG-123
3. Tester ejecuta TC-045 de nuevo → ¿PASA?
   - Si PASA: BUG-123 se puede cerrar
   - Si FALLA: BUG-123 se reabre
```

### 4.5.2 Pruebas de Regresión

**Definición:** Después de cualquier cambio en el software (corrección de defecto, nueva funcionalidad, cambio de configuración), se ejecutan pruebas de funcionalidades existentes para verificar que el cambio no ha introducido defectos nuevos ni ha roto nada que funcionaba.

**Características:**
- Es amplia: prueba funcionalidades que NO han cambiado
- Es preventiva: busca efectos secundarios no deseados
- Alcance amplio: conjunto significativo de pruebas existentes

**¿Por qué son necesarias?**
Los cambios en el software pueden tener efectos inesperados:
- Modificar un módulo puede afectar a otros que dependen de él
- Cambiar una función común puede romper múltiples funcionalidades
- Cambios de configuración pueden tener efectos en cascada

**Ejemplo:**
```
Situación: Se corrige un bug en el cálculo de descuentos

Re-test: Ejecutar el caso que detectó el bug de descuentos

Regresión: Ejecutar también:
- Casos de cálculo de totales (usa descuentos)
- Casos de generación de facturas (incluye descuentos)
- Casos de informes de ventas (agregan descuentos)
- Casos de devoluciones (recalculan descuentos)
```

### 4.5.3 Comparación

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    RE-TEST vs REGRESIÓN                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Aspecto              RE-TEST                 REGRESIÓN                    │
│   ───────              ───────                 ─────────                    │
│                                                                             │
│   Objetivo             Confirmar que el        Verificar que los cambios   │
│                        defecto está            no han roto nada más        │
│                        corregido                                            │
│                                                                             │
│   Alcance              El caso que falló       Conjunto amplio de          │
│                                                funcionalidades              │
│                                                                             │
│   Obligatoriedad       Siempre obligatorio     Muy recomendable            │
│                        tras corrección                                      │
│                                                                             │
│   Quién lo define      El defecto define       Análisis de impacto        │
│                        qué re-testear          define el alcance           │
│                                                                             │
│   Automatización       Puede ser manual        Casi imprescindible         │
│                                                automatizar                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 4.5.4 Estrategias de Regresión

**1. Regresión Completa**
- Ejecutar TODOS los casos de prueba existentes
- Muy seguro pero muy costoso
- Solo viable si las pruebas están automatizadas

**2. Regresión Selectiva**
- Ejecutar un subconjunto basado en análisis de impacto
- Equilibrio entre coste y cobertura
- Requiere buen conocimiento del sistema

**3. Regresión Priorizada**
- Ejecutar primero las pruebas más críticas
- Si hay tiempo, continuar con las demás
- Basada en riesgo

## 4.6 Smoke Test y Sanity Test

Estos son dos tipos de pruebas rápidas que sirven como "filtros" antes de invertir más esfuerzo.

### 4.6.1 Smoke Test (Prueba de Humo)

**Definición:** Prueba rápida y superficial para verificar que las funcionalidades básicas del sistema funcionan y que vale la pena seguir probando.

**Origen del nombre:** Viene de la electrónica. Cuando se enciende un nuevo dispositivo, si "echa humo" es que hay un problema grave y no vale la pena seguir probando.

**Características:**
- Muy rápida (minutos, no horas)
- Cubre funcionalidades principales
- No es exhaustiva
- Si falla, se rechaza la build
- También llamada "Build Verification Test"

**Ejemplo de Smoke Test para e-commerce:**
1. ¿La aplicación arranca?
2. ¿Se puede acceder a la página principal?
3. ¿Funciona el login?
4. ¿Se pueden buscar productos?
5. ¿Se puede añadir al carrito?
6. ¿Se puede iniciar el proceso de pago?

Si cualquiera de estos falla, no tiene sentido probar funcionalidades avanzadas.

### 4.6.2 Sanity Test (Prueba de Cordura)

**Definición:** Prueba enfocada en verificar que una funcionalidad específica o un área concreta funciona correctamente después de un cambio menor.

**Características:**
- Enfocada en un área específica
- Más profunda que smoke pero menos que regresión completa
- Tras cambios menores o correcciones
- Verifica que el cambio tiene sentido ("cordura")

**Ejemplo:**
Tras corregir un bug en el cálculo de impuestos:
- Sanity test: Probar varios escenarios de cálculo de impuestos
- No probar todo el sistema, solo el área afectada

### 4.6.3 Comparación

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    SMOKE TEST vs SANITY TEST                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Aspecto              SMOKE TEST              SANITY TEST                  │
│   ───────              ──────────              ───────────                  │
│                                                                             │
│   Amplitud             Amplio pero superficial Estrecho pero profundo      │
│                                                                             │
│   Objetivo             ¿Funciona lo básico?    ¿Funciona esta área?        │
│                                                                             │
│   Cuándo               Cada nueva build        Tras cambios específicos    │
│                                                                             │
│   Duración             Muy corta (minutos)     Corta (hasta 1 hora)        │
│                                                                             │
│   Si falla             Rechazar build          Devolver al desarrollo      │
│                                                                             │
│   Cobertura            Funciones principales   Funcionalidad específica    │
│                                                                             │
│   Analogía             "¿El coche arranca?"    "¿Los frenos funcionan      │
│                                                bien tras cambiarlos?"       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 4.7 Pruebas Manuales vs Automatizadas

### 4.7.1 Pruebas Manuales

**Definición:** Un tester humano ejecuta los pasos de prueba manualmente, interactuando con el sistema y verificando los resultados.

**Ventajas:**
- Flexibilidad para explorar
- Puede detectar problemas de usabilidad
- No requiere inversión inicial en frameworks
- Mejor para pruebas que cambian frecuentemente
- Intuición humana para detectar anomalías

**Desventajas:**
- Lentas
- Propensas a errores humanos
- No escalables
- Aburridas para pruebas repetitivas
- Costosas a largo plazo

**Mejor para:**
- Pruebas exploratorias
- Pruebas de usabilidad
- Pruebas que se ejecutan pocas veces
- Casos muy complejos difíciles de automatizar

### 4.7.2 Pruebas Automatizadas

**Definición:** Scripts o programas ejecutan las pruebas sin intervención humana, comparando automáticamente resultados.

**Ventajas:**
- Rápidas
- Repetibles exactamente igual
- Escalables
- Ejecutables 24/7 (CI/CD)
- Económicas a largo plazo

**Desventajas:**
- Inversión inicial alta
- Mantenimiento de scripts
- No detectan problemas visuales sutiles
- No tienen intuición

**Mejor para:**
- Pruebas de regresión
- Pruebas que se ejecutan frecuentemente
- Pruebas de rendimiento
- Integración continua

### 4.7.3 La Pirámide de Automatización

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    PIRÁMIDE DE AUTOMATIZACIÓN                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                           /\                                                │
│                          /  \           MANUALES                            │
│                         /    \          Exploratorias, usabilidad           │
│                        / UI   \         Pocas, costosas, lentas             │
│                       /────────\                                            │
│                      /          \       E2E / UI AUTOMATIZADAS              │
│                     /  SERVICIO  \      Flujos completos                    │
│                    /──────────────\     Algunas, moderadas                  │
│                   /                \                                        │
│                  /   INTEGRACIÓN    \   INTEGRACIÓN                         │
│                 /────────────────────\  Entre componentes                   │
│                /                      \ Moderadas                           │
│               /       UNITARIAS        \                                    │
│              /──────────────────────────\  UNITARIAS                        │
│             /                            \ Muchas, rápidas, baratas         │
│            /______________________________\                                 │
│                                                                             │
│   BASE AMPLIA: Muchas pruebas unitarias automatizadas                       │
│   CIMA ESTRECHA: Pocas pruebas manuales exploratorias                       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 4.8 Ejercicios de Práctica

---

**EJERCICIO 1:**
Clasifica las siguientes actividades como **Estáticas (E)** o **Dinámicas (D)**:

a) Ejecutar un caso de prueba en el navegador
b) Revisar el documento de requisitos buscando ambigüedades
c) Pasar un linter al código JavaScript
d) Hacer login y verificar que se accede al dashboard
e) Inspección de código entre desarrolladores
f) Prueba de carga con 1000 usuarios simulados
g) Walkthrough del diseño de base de datos
h) Verificar que el botón de compra realiza la transacción

**✅ SOLUCIÓN:**

a) **D** - Dinámica: Requiere ejecutar el software
b) **E** - Estática: Es revisión de documentos sin ejecución
c) **E** - Estática: El linter analiza el código sin ejecutarlo
d) **D** - Dinámica: Requiere interactuar con el sistema ejecutándose
e) **E** - Estática: Inspección de código es revisión sin ejecución
f) **D** - Dinámica: Prueba de carga requiere ejecutar el sistema
g) **E** - Estática: Walkthrough es revisión de artefactos sin ejecución
h) **D** - Dinámica: Requiere ejecutar la transacción en el sistema

---

**EJERCICIO 2:**
Indica qué técnica usarías (caja negra, caja blanca, o ambas) para cada situación:

a) Verificar que se muestra error cuando el email no tiene formato válido
b) Asegurar que todas las ramas del código de validación se ejecutan
c) Probar que el sistema calcula correctamente el IVA según requisitos
d) Verificar que no hay código inalcanzable en una función
e) Comprobar que un usuario puede completar una compra
f) Analizar la cobertura de decisiones en un módulo crítico

**✅ SOLUCIÓN:**

a) **Caja Negra** - Se prueba el comportamiento observable (mensaje de error) sin necesidad de ver el código
b) **Caja Blanca** - Se necesita ver el código para identificar todas las ramas y asegurar que se ejecutan
c) **Caja Negra** - Se verifica contra requisitos (cálculo correcto de IVA) sin ver implementación
d) **Caja Blanca** - Se requiere análisis del código para identificar código inalcanzable
e) **Caja Negra** - Prueba de flujo de usuario basada en comportamiento esperado
f) **Caja Blanca** - La cobertura de decisiones requiere conocer la estructura del código

---

**EJERCICIO 3:**
Un equipo detecta un defecto en el cálculo de impuestos. El desarrollador lo corrige. ¿Qué tipos de prueba deberían ejecutarse y por qué?

**✅ SOLUCIÓN:**

Deberían ejecutarse DOS tipos de prueba:

**1. RE-TEST (Prueba de Confirmación):**
- **Qué:** Ejecutar el caso de prueba original que detectó el defecto
- **Por qué:** Para confirmar que el defecto ha sido realmente corregido
- **Obligatoriedad:** Siempre es obligatorio antes de cerrar el defecto

**2. PRUEBAS DE REGRESIÓN:**
- **Qué:** Ejecutar pruebas de funcionalidades relacionadas que podrían haberse visto afectadas
- **Por qué:** El cambio en el cálculo de impuestos puede afectar a:
  - Cálculo de totales de pedidos
  - Generación de facturas
  - Informes de ventas
  - Devoluciones y reembolsos
  - Contabilidad
- **Alcance:** Basado en análisis de impacto - ¿qué módulos usan el cálculo de impuestos?

**Razón fundamental:** Corregir un defecto puede introducir efectos secundarios no deseados en otras partes del sistema. Las pruebas de regresión verifican que "al arreglar una cosa no hemos roto otra".

---

**EJERCICIO 4:**
Se ha desplegado una nueva versión de una aplicación de banca online. Describe qué incluirías en:

a) El Smoke Test (5 verificaciones)
b) El conjunto de pruebas de regresión prioritarias (describe 5 áreas)

**✅ SOLUCIÓN:**

**a) SMOKE TEST (5 verificaciones básicas):**

1. **Acceso a la aplicación:** ¿La página principal carga correctamente?
2. **Login:** ¿Un usuario válido puede iniciar sesión?
3. **Consulta de saldo:** ¿Se puede ver el saldo de la cuenta?
4. **Transferencia básica:** ¿Se puede iniciar una transferencia? (no necesariamente completarla)
5. **Logout:** ¿Se puede cerrar sesión correctamente?

Estas verificaciones cubren las funciones críticas mínimas. Si alguna falla, la build se rechaza.

**b) PRUEBAS DE REGRESIÓN PRIORITARIAS (5 áreas):**

1. **Autenticación y Seguridad:**
   - Login con credenciales válidas/inválidas
   - Bloqueo tras intentos fallidos
   - Timeout de sesión
   - Doble factor si aplica

2. **Operaciones de Cuenta:**
   - Consulta de saldo
   - Consulta de movimientos
   - Descarga de extractos

3. **Transferencias:**
   - Transferencia entre cuentas propias
   - Transferencia a terceros
   - Transferencia programada
   - Límites de transferencia

4. **Pagos:**
   - Pago de recibos
   - Pago de impuestos
   - Pagos recurrentes

5. **Seguridad de Transacciones:**
   - Validación de OTP/firma
   - Límites diarios
   - Alertas de seguridad

---

**EJERCICIO 5:**
Para cada tipo de prueba, indica si debería ser principalmente manual (M) o automatizada (A), y justifica brevemente:

a) Prueba de regresión de 500 casos que se ejecuta cada noche
b) Prueba exploratoria de una nueva funcionalidad
c) Verificación de que la interfaz "se ve bien" en diferentes resoluciones
d) Prueba unitaria de una función de cálculo
e) Prueba de usabilidad con usuarios reales
f) Prueba de carga con 10.000 usuarios simultáneos

**✅ SOLUCIÓN:**

| Tipo de Prueba | Manual/Auto | Justificación |
|----------------|-------------|---------------|
| a) Regresión de 500 casos cada noche | **A** (Automatizada) | Imposible ejecutar 500 casos manualmente cada noche. La automatización permite ejecución repetible, consistente y sin coste humano recurrente. |
| b) Exploratoria de nueva funcionalidad | **M** (Manual) | Las pruebas exploratorias requieren intuición, creatividad y adaptación humana. No siguen script predefinido. |
| c) Interfaz "se ve bien" | **M** (Manual) | La evaluación estética requiere juicio humano. Aunque hay herramientas de comparación visual, detectar si algo "se ve bien" es subjetivo. |
| d) Unitaria de función de cálculo | **A** (Automatizada) | Las pruebas unitarias son perfectas para automatizar: rápidas, repetibles, ejecutadas en cada commit. |
| e) Usabilidad con usuarios reales | **M** (Manual) | Requiere observar comportamiento humano, recoger feedback, interpretar reacciones. No automatizable. |
| f) Carga con 10.000 usuarios | **A** (Automatizada) | Imposible coordinar 10.000 usuarios reales. Las herramientas (JMeter, Gatling) simulan la carga automáticamente. |

---

# MÓDULO 5: NIVELES DE PRUEBA

## 5.1 Introducción: La Construcción por Capas

El desarrollo de software es como construir un edificio: primero se ponen los cimientos, luego la estructura, después los cerramientos, y finalmente los acabados. Cada fase debe verificarse antes de pasar a la siguiente, porque los problemas en fases tempranas son mucho más costosos de corregir después.

De la misma manera, las pruebas de software se organizan en **niveles**, donde cada nivel:
- Prueba el software a diferente granularidad
- Tiene diferentes objetivos
- Requiere diferentes técnicas y herramientas
- Se realiza en diferentes momentos del desarrollo
- Es responsabilidad de diferentes roles

## 5.2 El Modelo en V: Pruebas Asociadas a Cada Fase

El Modelo en V es una representación visual que muestra cómo cada fase de desarrollo tiene su correspondiente fase de pruebas:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           MODELO EN V                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   DESARROLLO                                          PRUEBAS               │
│   ──────────                                          ───────               │
│                                                                             │
│   Requisitos ─────────────────────────────────► Pruebas de Aceptación       │
│        \                                              /                     │
│         \                                            /                      │
│   Diseño Sistema ──────────────────────────► Pruebas de Sistema             │
│           \                                        /                        │
│            \                                      /                         │
│   Diseño Arquitectura ─────────────────► Pruebas de Integración            │
│               \                                /                            │
│                \                              /                             │
│   Diseño Detallado ─────────────────► Pruebas Unitarias                    │
│                   \                        /                                │
│                    \                      /                                 │
│                     \                    /                                  │
│                      \──► CODIFICACIÓN ◄─/                                  │
│                                                                             │
│   Cada fase de desarrollo tiene su correspondiente nivel de pruebas         │
│   Las pruebas se diseñan en paralelo al desarrollo                          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 5.3 Nivel 1: Pruebas Unitarias (o de Componente)

### 5.3.1 Definición

**Pruebas Unitarias:** Verifican el funcionamiento correcto de las unidades más pequeñas de código de forma aislada. Una "unidad" suele ser una función, método o clase individual.

### 5.3.2 Características

| Aspecto | Descripción |
|---------|-------------|
| **¿Qué se prueba?** | Una función, método o clase individual |
| **¿Quién las hace?** | Normalmente los desarrolladores |
| **¿Cuándo?** | Durante y justo después de codificar |
| **Técnicas** | Principalmente caja blanca |
| **Automatización** | Casi siempre automatizadas |
| **Aislamiento** | Se usan mocks/stubs para aislar dependencias |

### 5.3.3 Objetivos

1. Verificar que cada unidad funciona correctamente de forma aislada
2. Detectar defectos lo antes posible (baratos de corregir)
3. Facilitar refactorización segura
4. Servir como documentación ejecutable
5. Habilitar desarrollo dirigido por pruebas (TDD)

### 5.3.4 Ejemplo de Prueba Unitaria

**Código a probar:**
```python
def calcular_descuento(precio, porcentaje):
    """Calcula el precio con descuento aplicado."""
    if precio < 0:
        raise ValueError("El precio no puede ser negativo")
    if porcentaje < 0 or porcentaje > 100:
        raise ValueError("El porcentaje debe estar entre 0 y 100")
    
    descuento = precio * (porcentaje / 100)
    return precio - descuento
```

**Pruebas unitarias:**
```python
# Test 1: Caso normal
def test_descuento_normal():
    resultado = calcular_descuento(100, 20)
    assert resultado == 80  # 100 - 20% = 80

# Test 2: Sin descuento
def test_sin_descuento():
    resultado = calcular_descuento(100, 0)
    assert resultado == 100

# Test 3: Descuento total
def test_descuento_total():
    resultado = calcular_descuento(100, 100)
    assert resultado == 0

# Test 4: Precio negativo (error esperado)
def test_precio_negativo():
    with pytest.raises(ValueError):
        calcular_descuento(-50, 20)

# Test 5: Porcentaje inválido
def test_porcentaje_invalido():
    with pytest.raises(ValueError):
        calcular_descuento(100, 150)
```

### 5.3.5 Mocks y Stubs: Aislamiento de Dependencias

Las unidades suelen depender de otras unidades (bases de datos, servicios externos, etc.). Para probarlas de forma aislada, usamos **dobles de prueba**:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DOBLES DE PRUEBA (Test Doubles)                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  STUB                                                                       │
│  ────                                                                       │
│  Proporciona respuestas predefinidas a llamadas                             │
│  No verifica cómo se usa                                                    │
│  Ejemplo: Un stub de servicio de pagos que siempre devuelve "OK"           │
│                                                                             │
│  MOCK                                                                       │
│  ────                                                                       │
│  Verifica que se llama correctamente (número de veces, parámetros)         │
│  Puede proporcionar respuestas predefinidas                                 │
│  Ejemplo: Verificar que se llamó al servicio de email exactamente una vez  │
│                                                                             │
│  FAKE                                                                       │
│  ────                                                                       │
│  Implementación simplificada funcional                                      │
│  Ejemplo: Base de datos en memoria en lugar de la real                     │
│                                                                             │
│  SPY                                                                        │
│  ───                                                                        │
│  Envuelve el objeto real y registra las llamadas                           │
│  Ejemplo: Registrar todas las llamadas a un servicio real                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 5.3.6 Frameworks de Pruebas Unitarias Populares

| Lenguaje | Frameworks |
|----------|------------|
| Java | JUnit, TestNG |
| Python | pytest, unittest |
| JavaScript | Jest, Mocha, Jasmine |
| C# | NUnit, MSTest, xUnit |
| PHP | PHPUnit |
| Ruby | RSpec, Minitest |

## 5.4 Nivel 2: Pruebas de Integración

### 5.4.1 Definición

**Pruebas de Integración:** Verifican la comunicación e interacción correcta entre componentes o sistemas que ya han sido probados individualmente.

### 5.4.2 Características

| Aspecto | Descripción |
|---------|-------------|
| **¿Qué se prueba?** | Interfaces y comunicación entre componentes |
| **¿Quién las hace?** | Desarrolladores o testers técnicos |
| **¿Cuándo?** | Después de las pruebas unitarias |
| **Técnicas** | Caja negra y caja blanca |
| **Automatización** | Generalmente automatizadas |
| **Entorno** | Puede requerir componentes reales |

### 5.4.3 ¿Por qué son necesarias?

Aunque cada unidad funcione perfectamente de forma aislada, pueden surgir problemas cuando se conectan:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              ¿POR QUÉ FALLAN LAS INTEGRACIONES?                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Componente A                    Componente B                               │
│  ┌──────────────┐               ┌──────────────┐                           │
│  │              │               │              │                           │
│  │  Envía:      │───────────────│  Espera:     │                           │
│  │  fecha como  │   PROBLEMA    │  fecha como  │                           │
│  │  "DD/MM/YYYY"│               │  "YYYY-MM-DD"│                           │
│  │              │               │              │                           │
│  └──────────────┘               └──────────────┘                           │
│                                                                             │
│  Problemas típicos de integración:                                          │
│                                                                             │
│  • Formato de datos incompatible                                            │
│  • Orden de parámetros diferente                                            │
│  • Unidades diferentes (metros vs pies, céntimos vs euros)                 │
│  • Manejo diferente de nulos                                                │
│  • Encoding de caracteres diferente                                         │
│  • Timeouts y tiempos de espera                                             │
│  • Gestión de errores inconsistente                                         │
│  • Versiones de API incompatibles                                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 5.4.4 Estrategias de Integración

#### Big Bang (Todo de Golpe)

```
Todos los componentes se integran simultáneamente

           ┌───┐ ┌───┐ ┌───┐ ┌───┐
           │ A │ │ B │ │ C │ │ D │    Componentes aislados
           └───┘ └───┘ └───┘ └───┘
             │     │     │     │
             └─────┴─────┴─────┘
                     │
                     ▼
              ┌─────────────┐
              │  SISTEMA    │           Todo junto de una vez
              │  COMPLETO   │
              └─────────────┘

Ventajas: Rápido si funciona
Desventajas: Muy difícil encontrar dónde está el problema si falla
```

#### Incremental Top-Down (De Arriba a Abajo)

```
Se empieza por los módulos de nivel superior y se van añadiendo los inferiores

    Paso 1:    ┌───┐                    Paso 2:    ┌───┐
               │ A │ (principal)                   │ A │
               └───┘                               └─┬─┘
                 │                                   │
                 ▼                                 ┌─┴─┐
               STUB                               │ B │ (real)
                                                  └───┘
                                                    │
                                                    ▼
                                                  STUB

Se usan STUBS para simular módulos inferiores aún no integrados
```

#### Incremental Bottom-Up (De Abajo a Arriba)

```
Se empieza por los módulos de nivel inferior y se van añadiendo los superiores

    Paso 1:    ┌───┐ ┌───┐              Paso 2:   DRIVER
               │ C │ │ D │ (bajo nivel)             │
               └───┘ └───┘                        ┌─┴─┐
                                                  │ B │ (real)
                                                  └─┬─┘
                                                  ┌─┴─┐
                                                  │ C │ │ D │
                                                  └───┘ └───┘

Se usan DRIVERS para simular módulos superiores que llaman a los integrados
```

#### Sandwich (Híbrido)

Combina top-down y bottom-up, integrando desde ambos extremos hacia el medio.

### 5.4.5 Tipos de Integración

**1. Integración de Componentes**
- Entre módulos dentro de la misma aplicación
- Ejemplo: Módulo de pedidos que llama al módulo de inventario

**2. Integración de Sistemas**
- Entre diferentes sistemas o aplicaciones
- Ejemplo: ERP que se conecta con sistema bancario

**3. Integración con Servicios Externos**
- Con APIs de terceros
- Ejemplo: Integración con pasarela de pago, servicios de geolocalización

## 5.5 Nivel 3: Pruebas de Sistema

### 5.5.1 Definición

**Pruebas de Sistema:** Verifican el comportamiento del sistema completo, integrado, en un entorno lo más parecido posible al de producción.

### 5.5.2 Características

| Aspecto | Descripción |
|---------|-------------|
| **¿Qué se prueba?** | El sistema completo end-to-end |
| **¿Quién las hace?** | Equipo de QA independiente |
| **¿Cuándo?** | Después de las pruebas de integración |
| **Técnicas** | Principalmente caja negra |
| **Automatización** | Mixto (manual y automatizado) |
| **Entorno** | Similar a producción |

### 5.5.3 Objetivos

1. Verificar que el sistema cumple todos los requisitos funcionales
2. Verificar requisitos no funcionales (rendimiento, seguridad, usabilidad)
3. Detectar defectos que solo aparecen con el sistema completo
4. Validar escenarios de negocio end-to-end
5. Preparar el sistema para pruebas de aceptación

### 5.5.4 Tipos de Pruebas a Nivel de Sistema

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              TIPOS DE PRUEBAS DE SISTEMA                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  FUNCIONALES                                                                │
│  ───────────                                                                │
│  • Pruebas de funcionalidad completa                                        │
│  • Pruebas end-to-end de flujos de negocio                                 │
│  • Verificación de requisitos funcionales                                   │
│                                                                             │
│  NO FUNCIONALES                                                             │
│  ─────────────                                                              │
│  • Rendimiento: Carga, estrés, volumen                                      │
│  • Seguridad: Penetración, vulnerabilidades                                 │
│  • Usabilidad: Con usuarios representativos                                 │
│  • Compatibilidad: Diferentes navegadores, dispositivos                     │
│  • Recuperación: Ante fallos y caídas                                       │
│  • Instalación: Proceso de instalación/despliegue                          │
│                                                                             │
│  EJEMPLO de prueba de sistema E2E:                                          │
│  "Como usuario, quiero poder registrarme, buscar un producto,              │
│   añadirlo al carrito, pagar con tarjeta, y recibir confirmación           │
│   por email" ← Todo el flujo completo                                      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 5.5.5 Diferencia con Pruebas de Integración

| Aspecto | Integración | Sistema |
|---------|-------------|---------|
| Foco | Interfaces entre componentes | Sistema completo |
| Alcance | Subconjunto de componentes | Todo el sistema |
| Entorno | Puede usar mocks | Entorno real/similar producción |
| Objetivo | Comunicación correcta | Cumplimiento de requisitos |

## 5.6 Nivel 4: Pruebas de Aceptación

### 5.6.1 Definición

**Pruebas de Aceptación:** Verifican que el sistema satisface las necesidades del negocio y está listo para ser utilizado por los usuarios finales o para ser puesto en producción.

### 5.6.2 Características

| Aspecto | Descripción |
|---------|-------------|
| **¿Qué se prueba?** | Valor de negocio, experiencia de usuario |
| **¿Quién las hace?** | Usuarios, clientes, Product Owner |
| **¿Cuándo?** | Última fase antes de producción |
| **Técnicas** | Caja negra, basadas en escenarios reales |
| **Automatización** | Pueden ser manuales o automatizadas (BDD) |
| **Entorno** | Producción o pre-producción |

### 5.6.3 Tipos de Pruebas de Aceptación

#### UAT - User Acceptance Testing (Pruebas de Aceptación de Usuario)

**Objetivo:** Verificar que el sistema satisface las necesidades de los usuarios finales.

**Características:**
- Realizadas por usuarios reales del sistema
- Basadas en escenarios de uso real
- El usuario decide si el sistema es aceptable
- Pueden revelar problemas de usabilidad no detectados antes

**Ejemplo:**
```
Escenario UAT: Un comercial de ventas prueba el nuevo CRM

1. Crear un nuevo cliente potencial
2. Registrar una llamada de seguimiento
3. Programar una reunión
4. Generar una propuesta comercial
5. Convertir el lead en cliente
6. Verificar que todo fluye como en su trabajo diario
```

#### BAT - Business Acceptance Testing (Pruebas de Aceptación de Negocio)

**Objetivo:** Verificar que el sistema cumple los objetivos de negocio y genera el valor esperado.

**Características:**
- Realizadas por stakeholders de negocio
- Verifican KPIs y métricas de negocio
- Pueden incluir validación de informes y datos

#### OAT - Operational Acceptance Testing (Pruebas de Aceptación Operacional)

**Objetivo:** Verificar que el sistema puede ser operado y mantenido correctamente.

**Aspectos que se prueban:**
- Procedimientos de backup y recuperación
- Procedimientos de instalación y actualización
- Gestión de usuarios y permisos
- Monitorización y alertas
- Procedimientos de contingencia

#### Pruebas Alpha y Beta

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    PRUEBAS ALPHA vs BETA                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ALPHA                                                                      │
│  ─────                                                                      │
│  • Realizadas en el entorno del desarrollador                               │
│  • Usuarios internos o grupo selecto                                        │
│  • Software aún no terminado                                                │
│  • Bajo supervisión del equipo de desarrollo                                │
│  • Objetivo: Encontrar defectos antes de exponer al público                │
│                                                                             │
│  BETA                                                                       │
│  ────                                                                       │
│  • Realizadas en el entorno de los usuarios                                 │
│  • Usuarios externos reales                                                 │
│  • Software casi terminado                                                  │
│  • Sin supervisión directa                                                  │
│  • Objetivo: Feedback real antes del lanzamiento oficial                   │
│                                                                             │
│  Ejemplo típico:                                                            │
│  - Alpha: Empleados de la empresa prueban la nueva app                     │
│  - Beta: 1000 usuarios seleccionados prueban antes del lanzamiento         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Contract Acceptance Testing (Pruebas de Aceptación Contractual)

**Objetivo:** Verificar que el software cumple los criterios definidos en el contrato.

**Uso típico:** Desarrollo a medida donde el cliente acepta formalmente la entrega.

#### Compliance Testing (Pruebas de Conformidad/Regulación)

**Objetivo:** Verificar que el sistema cumple normativas y regulaciones aplicables.

**Ejemplos:**
- GDPR para protección de datos
- PCI-DSS para pagos con tarjeta
- SOX para información financiera
- Accesibilidad WCAG

## 5.7 Resumen de Niveles de Prueba

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    RESUMEN: NIVELES DE PRUEBA                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  NIVEL           QUÉ                QUIÉN              CUÁNDO               │
│  ─────           ───                ─────              ──────               │
│                                                                             │
│  Unitarias       Funciones,         Desarrolladores    Durante              │
│                  métodos,                              codificación         │
│                  clases                                                     │
│                                                                             │
│  Integración     Interfaces,        Desarrolladores    Tras pruebas         │
│                  comunicación       o testers          unitarias            │
│                  entre módulos      técnicos                                │
│                                                                             │
│  Sistema         Sistema            Equipo QA          Tras                 │
│                  completo           independiente      integración          │
│                                                                             │
│  Aceptación      Valor de           Usuarios,          Antes de             │
│                  negocio            clientes           producción           │
│                                                                             │
│                                                                             │
│  CADA NIVEL ENCUENTRA DIFERENTES TIPOS DE DEFECTOS:                         │
│                                                                             │
│  Unitarias    → Errores de lógica en código individual                      │
│  Integración  → Problemas de comunicación entre componentes                 │
│  Sistema      → Defectos en requisitos, comportamiento global               │
│  Aceptación   → Expectativas no cumplidas, usabilidad                       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 5.8 Ejercicios de Práctica

---

**EJERCICIO 1:**
Para cada situación, indica qué nivel de prueba sería más apropiado:

a) Verificar que la función que calcula el IVA devuelve valores correctos
b) Comprobar que el módulo de facturación se comunica correctamente con el módulo de inventario
c) Verificar que un cliente puede completar todo el proceso de compra desde inicio a fin
d) El director financiero verifica que los informes de ventas muestran los datos que necesita
e) Comprobar que la API REST de productos devuelve JSON válido al sistema de la tienda online
f) Los empleados del call center prueban el nuevo sistema de tickets antes de usarlo

**✅ SOLUCIÓN:**

| Situación | Nivel de Prueba | Justificación |
|-----------|-----------------|---------------|
| a) Función calcula IVA correctamente | **Unitarias** | Es una función individual aislada |
| b) Facturación comunica con inventario | **Integración** | Verifica comunicación entre módulos |
| c) Cliente completa proceso de compra completo | **Sistema** | Flujo end-to-end del sistema completo |
| d) Director verifica informes de ventas | **Aceptación (UAT/BAT)** | Usuario de negocio valida el sistema |
| e) API devuelve JSON válido a tienda | **Integración** | Comunicación entre sistemas (API) |
| f) Empleados prueban sistema de tickets | **Aceptación (UAT)** | Usuarios finales validan antes de usar |

---

**EJERCICIO 2:**
Describe las diferencias entre pruebas de integración y pruebas de sistema usando el ejemplo de un sistema de reservas de hotel.

**✅ SOLUCIÓN:**

**PRUEBAS DE INTEGRACIÓN en Sistema de Reservas de Hotel:**

Verifican la comunicación correcta entre componentes específicos:

1. **Módulo Reservas ↔ Módulo Disponibilidad:**
   - Cuando se hace una reserva, ¿se actualiza correctamente la disponibilidad?
   - ¿El formato de fechas es compatible entre ambos módulos?

2. **Módulo Reservas ↔ Pasarela de Pago:**
   - ¿Se envían correctamente los datos de pago?
   - ¿Se recibe y procesa la confirmación de pago?

3. **Módulo Reservas ↔ Sistema de Email:**
   - ¿Se genera correctamente el email de confirmación?
   - ¿Los datos del email coinciden con la reserva?

**PRUEBAS DE SISTEMA en Sistema de Reservas de Hotel:**

Verifican el sistema completo con flujos end-to-end:

1. **Flujo completo de reserva:**
   - Cliente busca hotel → selecciona habitación → introduce datos → paga → recibe confirmación
   - Todo el proceso desde la perspectiva del usuario final

2. **Verificaciones transversales:**
   - El sistema funciona en diferentes navegadores
   - Los tiempos de respuesta son aceptables
   - El sistema gestiona correctamente 100 reservas simultáneas

**Diferencia clave:**
- **Integración:** "Módulo A se comunica bien con Módulo B"
- **Sistema:** "El cliente puede reservar una habitación de principio a fin"

---

**EJERCICIO 3:**
Explica qué son y para qué sirven los "mocks" y "stubs" en las pruebas unitarias. Pon un ejemplo de cuándo usarías cada uno.

**✅ SOLUCIÓN:**

**STUBS:**
Son objetos que proporcionan respuestas predefinidas a llamadas realizadas durante la prueba. No verifican cómo se usan, solo devuelven datos.

**Ejemplo de uso de STUB:**
```python
# Queremos probar un servicio de pedidos que consulta precios
# Creamos un stub del servicio de precios que siempre devuelve 100€

class StubServicioPrecios:
    def obtener_precio(self, producto_id):
        return 100  # Siempre devuelve 100, sin importar el producto

# Ahora podemos probar el servicio de pedidos sin depender
# del servicio de precios real (que podría estar caído, lento, etc.)
```

**MOCKS:**
Son objetos que además de proporcionar respuestas, **verifican** que se les llamó correctamente (cuántas veces, con qué parámetros, etc.).

**Ejemplo de uso de MOCK:**
```python
# Queremos verificar que al completar un pedido se envía un email
# Creamos un mock del servicio de email

class MockServicioEmail:
    def __init__(self):
        self.emails_enviados = []
    
    def enviar(self, destinatario, asunto, cuerpo):
        self.emails_enviados.append((destinatario, asunto, cuerpo))

# Después de la prueba, verificamos:
assert len(mock_email.emails_enviados) == 1  # Se envió exactamente 1 email
assert mock_email.emails_enviados[0][0] == "cliente@email.com"  # Al destinatario correcto
```

**Cuándo usar cada uno:**
- **Stub:** Cuando solo necesitas que la dependencia devuelva algo para que la prueba funcione
- **Mock:** Cuando necesitas verificar que la interacción con la dependencia fue correcta

---

**EJERCICIO 4:**
Una empresa está desarrollando una aplicación móvil de banca. Describe qué tipo de pruebas de aceptación serían necesarias y quién debería realizarlas.

**✅ SOLUCIÓN:**

**TIPOS DE PRUEBAS DE ACEPTACIÓN NECESARIAS:**

| Tipo | Descripción | Quién |
|------|-------------|-------|
| **UAT (User Acceptance Testing)** | Usuarios finales prueban que pueden realizar sus operaciones habituales: consultar saldo, hacer transferencias, pagar recibos | Clientes reales del banco (grupo piloto) o empleados actuando como clientes |
| **BAT (Business Acceptance Testing)** | Verificar que la app cumple objetivos de negocio: reducción de llamadas al call center, incremento de transacciones digitales | Directores de banca digital, responsables de producto |
| **OAT (Operational Acceptance Testing)** | Verificar que el equipo de TI puede operar la app: monitorización, gestión de incidencias, actualizaciones | Equipo de operaciones TI, administradores de sistemas |
| **Compliance/Regulatorio** | Verificar cumplimiento de PCI-DSS (pagos), GDPR (datos personales), normativa bancaria nacional | Equipo de compliance, auditores internos o externos |
| **Alpha Testing** | Empleados del banco prueban la app antes de exponerla a clientes | Empleados de sucursales, personal de oficinas centrales |
| **Beta Testing** | Grupo selecto de clientes reales prueba la app en sus dispositivos | 500-1000 clientes voluntarios con diferentes perfiles |
| **Security Acceptance** | Verificar que la app cumple estándares de seguridad bancaria | Equipo de ciberseguridad, pentesters externos |

**RECOMENDACIÓN DE SECUENCIA:**
1. Alpha con empleados
2. Security Acceptance
3. Compliance Testing
4. OAT
5. Beta con clientes
6. UAT final
7. BAT antes de lanzamiento masivo

---

# MÓDULO 6: PRINCIPIOS FUNDAMENTALES DEL TESTING

## 6.1 Introducción: Las Verdades Universales del Testing

A lo largo de décadas de práctica en testing de software, la comunidad ha identificado ciertos principios que se mantienen verdaderos independientemente de la tecnología, metodología o tipo de proyecto. Estos principios forman la base teórica del testing y guían las decisiones sobre cómo, cuándo y cuánto probar.

El ISTQB (International Software Testing Qualifications Board) ha formalizado **7 principios fundamentales** que todo profesional del testing debe conocer y comprender.

## 6.2 Principio 1: Las Pruebas Muestran la Presencia de Defectos

### 6.2.1 Enunciado

> **"Las pruebas pueden demostrar que existen defectos, pero NO pueden demostrar que no existen defectos."**

### 6.2.2 Explicación

Este es quizás el principio más importante y más malinterpretado. Probar un software reduce la probabilidad de que haya defectos ocultos, pero nunca puede eliminarla completamente.

**Analogía:** Si buscas un libro en tu casa y no lo encuentras después de buscar en 10 habitaciones, no puedes afirmar que "el libro no está en la casa". Solo puedes afirmar que "no lo encontré donde busqué".

### 6.2.3 Implicaciones Prácticas

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              QUÉ PUEDES Y QUÉ NO PUEDES DECIR                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ✓ PUEDES DECIR:                                                            │
│                                                                             │
│  • "Ejecuté 500 casos de prueba y encontré 23 defectos"                    │
│  • "El sistema pasó todas las pruebas de regresión"                        │
│  • "No encontramos defectos críticos en las pruebas de sistema"            │
│  • "La cobertura de código es del 85%"                                     │
│                                                                             │
│  ✗ NO PUEDES DECIR:                                                         │
│                                                                             │
│  • "El sistema no tiene defectos"                                          │
│  • "El software es 100% correcto"                                          │
│  • "Es imposible que falle"                                                │
│  • "Probamos todo"                                                         │
│                                                                             │
│  CONCLUSIÓN:                                                                │
│  El testing exitoso es el que ENCUENTRA defectos, no el que no los         │
│  encuentra. Si no encuentras defectos, quizás no estés buscando bien.      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 6.3 Principio 2: Las Pruebas Exhaustivas Son Imposibles

### 6.3.1 Enunciado

> **"Probar todo (todas las combinaciones de entradas y precondiciones) es imposible excepto en casos triviales. En lugar de pruebas exhaustivas, se debe usar análisis de riesgos y prioridades para enfocar los esfuerzos de prueba."**

### 6.3.2 Demostración Matemática

Consideremos un formulario simple:

```
Campo 1: Nombre (hasta 50 caracteres)  → 256^50 combinaciones posibles
Campo 2: Edad (0-150)                   → 151 valores posibles
Campo 3: Email (hasta 100 caracteres)  → 256^100 combinaciones posibles
Botón: Enviar

Combinaciones totales = 256^50 × 151 × 256^100 = Número astronómico

Si cada prueba tarda 1 segundo:
- Probar todas las combinaciones llevaría más tiempo que la edad del universo
```

### 6.3.3 Implicaciones Prácticas

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              ESTRATEGIAS ANTE LA IMPOSIBILIDAD DE PROBAR TODO               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  1. ANÁLISIS DE RIESGOS                                                     │
│     ─────────────────────                                                   │
│     Priorizar pruebas según:                                                │
│     • Probabilidad de fallo                                                 │
│     • Impacto del fallo                                                     │
│     • Criticidad del negocio                                                │
│                                                                             │
│  2. TÉCNICAS DE SELECCIÓN                                                   │
│     ─────────────────────────                                               │
│     • Clases de equivalencia (reducir infinitos casos a grupos)            │
│     • Valores límite (probar los bordes)                                    │
│     • Combinaciones críticas (pairwise testing)                            │
│                                                                             │
│  3. CRITERIOS DE COBERTURA                                                  │
│     ───────────────────────                                                 │
│     Definir qué significa "suficiente":                                     │
│     • 80% de cobertura de código                                            │
│     • 100% de requisitos críticos probados                                  │
│     • Todos los flujos principales cubiertos                                │
│                                                                             │
│  CONCLUSIÓN:                                                                │
│  No se trata de probar TODO, sino de probar LO CORRECTO.                   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 6.4 Principio 3: Las Pruebas Tempranas Ahorran Tiempo y Dinero

### 6.4.1 Enunciado

> **"Las actividades de prueba deben comenzar lo antes posible en el ciclo de vida del desarrollo y deben enfocarse en objetivos definidos."**

### 6.4.2 El Coste de los Defectos

El coste de corregir un defecto aumenta exponencialmente cuanto más tarde se descubre:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              COSTE DE CORRECCIÓN SEGÚN FASE DE DETECCIÓN                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Fase de Detección          Coste Relativo    Ejemplo Real                │
│   ─────────────────          ──────────────    ────────────                │
│                                                                             │
│   Requisitos                      1x           30 minutos de reunión       │
│                                                                             │
│   Diseño                          5x           2-3 horas de rediseño       │
│                                                                             │
│   Codificación                   10x           1 día de programador        │
│                                                                             │
│   Pruebas Unitarias              15x           1-2 días de corrección      │
│                                                                             │
│   Pruebas de Sistema             50x           1 semana + re-testing       │
│                                                                             │
│   Producción                  100-1000x        Pérdidas económicas,        │
│                                                daño reputacional,           │
│                                                posibles demandas            │
│                                                                             │
│        COSTE                                                                │
│          ▲                                                                  │
│      1000│                                              ████                │
│          │                                              ████                │
│       100│                                    ████      ████                │
│          │                          ████      ████      ████                │
│        10│            ████          ████      ████      ████                │
│          │   ████     ████          ████      ████      ████                │
│         1│   ████     ████          ████      ████      ████                │
│          └────────────────────────────────────────────────────► FASE       │
│              REQ    DISEÑO    CÓDIGO    TEST    PROD                        │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 6.4.3 Shift Left Testing

El concepto de "Shift Left" significa mover las actividades de testing hacia la izquierda del cronograma (más temprano):

```
ENFOQUE TRADICIONAL:
Requisitos → Diseño → Código → Pruebas → Producción
                                  ↑
                            Testing aquí (tarde)

SHIFT LEFT:
Requisitos → Diseño → Código → Pruebas → Producción
    ↑           ↑        ↑
Testing desde aquí (temprano)

Actividades de Shift Left:
• Revisión de requisitos
• Revisión de diseño
• TDD (Test-Driven Development)
• Integración continua
```

## 6.5 Principio 4: Los Defectos Se Agrupan (Clustering)

### 6.5.1 Enunciado

> **"Un pequeño número de módulos suele contener la mayoría de los defectos descubiertos. La distribución de defectos no es uniforme."**

### 6.5.2 Aplicación del Principio de Pareto

Típicamente se observa que aproximadamente el 80% de los defectos se encuentran en el 20% del código. Este fenómeno se conoce como "agrupamiento de defectos" o "clustering".

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              DISTRIBUCIÓN TÍPICA DE DEFECTOS                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Módulos del Sistema        Defectos Encontrados                          │
│   ──────────────────         ────────────────────                          │
│                                                                             │
│   Módulo A (Login)           ████████████████████████████  35 defectos     │
│   Módulo B (Pagos)           ████████████████████  25 defectos              │
│   Módulo C (Carrito)         ████████████  15 defectos                      │
│   Módulo D (Búsqueda)        ██████  8 defectos                             │
│   Módulo E (Perfil)          ████  5 defectos                               │
│   Módulo F (Favoritos)       ██  3 defectos                                 │
│   Módulo G (Ayuda)           █  1 defecto                                   │
│   Otros módulos              ████  8 defectos                               │
│                              ─────────────────────                          │
│                              TOTAL: 100 defectos                            │
│                                                                             │
│   Los módulos A, B y C (30% del sistema) contienen el 75% de los defectos  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 6.5.3 ¿Por qué ocurre?

Los defectos tienden a agruparse en módulos que:
- Son más complejos
- Fueron desarrollados con prisa
- Tienen requisitos poco claros
- Han sufrido muchos cambios
- Son desarrollados por personal menos experimentado
- Tienen muchas dependencias

### 6.5.4 Implicaciones Prácticas

1. **Identificar módulos problemáticos:** Analizar histórico de defectos
2. **Focalizar esfuerzos:** Probar más intensamente módulos con más defectos
3. **Predecir problemas:** Si un módulo tiene muchos defectos, probablemente tenga más
4. **Considerar reescritura:** A veces es más barato rehacer que seguir parcheando

## 6.6 Principio 5: La Paradoja del Pesticida

### 6.6.1 Enunciado

> **"Si las mismas pruebas se repiten una y otra vez, eventualmente dejarán de encontrar nuevos defectos. Para detectar nuevos defectos, las pruebas existentes y los datos de prueba deben cambiar o se deben escribir pruebas nuevas."**

### 6.6.2 Explicación

El nombre viene de la agricultura: si usas siempre el mismo pesticida, las plagas desarrollan resistencia y el pesticida deja de ser efectivo.

En software: los defectos que tus pruebas actuales pueden encontrar, ya los encontraste. Los defectos restantes están en áreas que tus pruebas no cubren.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              LA PARADOJA DEL PESTICIDA                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Ejecución 1:  ████████████████████████████   28 defectos encontrados     │
│   Ejecución 2:  ████████████████████           20 defectos encontrados     │
│   Ejecución 3:  ████████████                   12 defectos encontrados     │
│   Ejecución 4:  ████████                       8 defectos encontrados      │
│   Ejecución 5:  ████                           4 defectos encontrados      │
│   Ejecución 6:  ██                             2 defectos encontrados      │
│   Ejecución 7:  █                              1 defecto encontrado        │
│   Ejecución 8:  (ninguno)                      0 defectos encontrados      │
│                                                                             │
│   ¿Significa que ya no hay defectos? NO                                    │
│   Significa que estas pruebas ya no encuentran más.                        │
│                                                                             │
│   SOLUCIÓN: Escribir nuevas pruebas, cambiar datos, explorar nuevas áreas  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 6.6.3 Estrategias para Combatir la Paradoja

1. **Revisar y actualizar casos de prueba regularmente**
2. **Rotar testers** para obtener perspectivas frescas
3. **Pruebas exploratorias** para descubrir áreas no cubiertas
4. **Cambiar datos de prueba** periódicamente
5. **Análisis de mutaciones** para evaluar efectividad de pruebas
6. **Añadir pruebas para cada nuevo defecto encontrado en producción**

## 6.7 Principio 6: Las Pruebas Dependen del Contexto

### 6.7.1 Enunciado

> **"Las pruebas se realizan de manera diferente en diferentes contextos. No existe un enfoque universal que funcione para todos los proyectos."**

### 6.7.2 Ejemplos de Contextos Diferentes

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              TESTING EN DIFERENTES CONTEXTOS                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  SISTEMA BANCARIO                    JUEGO MÓVIL                            │
│  ────────────────                    ───────────                            │
│  • Seguridad: CRÍTICA                • Seguridad: Moderada                  │
│  • Precisión numérica: Esencial      • Precisión: No crítica                │
│  • Disponibilidad: 99.99%            • Disponibilidad: 95% aceptable        │
│  • Regulaciones: Muchas (PCI, etc.)  • Regulaciones: Pocas                  │
│  • Pruebas formales y exhaustivas    • Pruebas ágiles, rápidas             │
│  • Documentación extensa             • Documentación mínima                 │
│                                                                             │
│  SOFTWARE MÉDICO                     PROTOTIPO INTERNO                      │
│  ───────────────                     ─────────────────                      │
│  • Seguridad: VITAL (vidas)          • Seguridad: Baja                      │
│  • Validación regulatoria: FDA       • Sin validación formal                │
│  • Pruebas exhaustivas obligatorias  • Pruebas básicas suficientes          │
│  • Trazabilidad completa             • Sin requisitos de trazabilidad       │
│  • Certificaciones necesarias        • Sin certificaciones                  │
│                                                                             │
│  CONCLUSIÓN: Adaptar el enfoque al contexto, no aplicar recetas genéricas  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 6.7.3 Factores que Definen el Contexto

- **Criticidad del sistema:** ¿Qué pasa si falla?
- **Regulaciones aplicables:** ¿Qué normativas debe cumplir?
- **Perfil de usuarios:** ¿Técnicos o novatos?
- **Metodología de desarrollo:** ¿Waterfall o Agile?
- **Presupuesto y tiempo:** ¿Cuántos recursos hay?
- **Tamaño del equipo:** ¿Tester dedicado o desarrolladores prueban?
- **Historial de defectos:** ¿Qué ha fallado antes?

## 6.8 Principio 7: La Ausencia de Errores Es Una Falacia

### 6.8.1 Enunciado

> **"Encontrar y corregir defectos no sirve de nada si el sistema construido no satisface las necesidades y expectativas de los usuarios."**

### 6.8.2 Explicación

Este principio conecta con la diferencia entre **Verificación** y **Validación**:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              VERIFICACIÓN vs VALIDACIÓN                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  VERIFICACIÓN                        VALIDACIÓN                             │
│  ────────────                        ──────────                             │
│                                                                             │
│  "¿Estamos construyendo el          "¿Estamos construyendo el              │
│   producto CORRECTAMENTE?"            producto CORRECTO?"                   │
│                                                                             │
│  • El sistema cumple requisitos      • El sistema cumple necesidades       │
│  • Funciona según especificaciones   • Resuelve el problema real           │
│  • Código sin defectos               • Usuario satisfecho                   │
│                                                                             │
│  EJEMPLO:                                                                   │
│  ─────────                                                                  │
│  Un sistema de gestión de inventario que:                                   │
│  ✓ Funciona sin errores (verificación exitosa)                             │
│  ✓ Cumple todos los requisitos documentados                                │
│  ✗ Pero el usuario necesitaba algo diferente (validación fallida)         │
│                                                                             │
│  Resultado: Sistema técnicamente correcto pero INÚTIL                      │
│                                                                             │
│  "Un software sin defectos que nadie quiere usar sigue siendo un fracaso"  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 6.8.3 Implicaciones

1. Las pruebas técnicas no son suficientes
2. Se necesitan pruebas de aceptación de usuario
3. El feedback temprano de usuarios es crucial
4. Un sistema "sin bugs" puede ser un fracaso comercial
5. La calidad incluye utilidad, no solo corrección técnica

## 6.9 Resumen de los 7 Principios

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              LOS 7 PRINCIPIOS DEL TESTING - RESUMEN                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  1. LAS PRUEBAS MUESTRAN PRESENCIA DE DEFECTOS                             │
│     → Las pruebas encuentran defectos, no demuestran su ausencia           │
│                                                                             │
│  2. LAS PRUEBAS EXHAUSTIVAS SON IMPOSIBLES                                 │
│     → No se puede probar todo, hay que priorizar                           │
│                                                                             │
│  3. LAS PRUEBAS TEMPRANAS AHORRAN TIEMPO Y DINERO                          │
│     → Cuanto antes se detecte un defecto, más barato corregirlo            │
│                                                                             │
│  4. LOS DEFECTOS SE AGRUPAN                                                │
│     → Unos pocos módulos concentran la mayoría de defectos                 │
│                                                                             │
│  5. LA PARADOJA DEL PESTICIDA                                              │
│     → Las mismas pruebas dejan de encontrar nuevos defectos                │
│                                                                             │
│  6. LAS PRUEBAS DEPENDEN DEL CONTEXTO                                      │
│     → No hay un enfoque único válido para todos los proyectos              │
│                                                                             │
│  7. LA AUSENCIA DE ERRORES ES UNA FALACIA                                  │
│     → Un sistema sin bugs que no sirve para nada sigue siendo un fracaso   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 6.10 Ejercicios de Práctica

---

**EJERCICIO 1:**
Para cada situación, indica qué principio del testing se está violando:

a) "Ejecutamos 1000 casos de prueba sin encontrar fallos, por lo tanto el sistema no tiene defectos"
b) "Vamos a probar todas las posibles combinaciones de entrada del formulario"
c) "Las pruebas las haremos cuando el desarrollo esté completamente terminado"
d) "Usamos exactamente los mismos casos de prueba desde hace 3 años"
e) "Aplicamos la misma estrategia de testing para nuestra app móvil que para el software del marcapasos"

**✅ SOLUCIÓN:**

| Situación | Principio Violado | Explicación |
|-----------|-------------------|-------------|
| a) 1000 pruebas sin fallos = sin defectos | **Principio 1: Las pruebas muestran presencia de defectos** | No encontrar defectos NO demuestra que no existan. Solo demuestra que las pruebas ejecutadas no los encontraron. |
| b) Probar todas las combinaciones | **Principio 2: Las pruebas exhaustivas son imposibles** | El número de combinaciones es astronómico. Se debe usar análisis de riesgos y técnicas de selección (clases de equivalencia, valores límite). |
| c) Testing al final del desarrollo | **Principio 3: Las pruebas tempranas ahorran tiempo y dinero** | Cuanto más tarde se detecte un defecto, más caro será corregirlo. El testing debe empezar desde requisitos. |
| d) Mismos casos de prueba durante 3 años | **Principio 5: La paradoja del pesticida** | Las mismas pruebas dejan de encontrar nuevos defectos. Hay que actualizar, añadir y variar los casos de prueba. |
| e) Misma estrategia para app móvil y marcapasos | **Principio 6: Las pruebas dependen del contexto** | Un marcapasos (vida/muerte) requiere testing exhaustivo, regulado, certificado. Una app móvil puede permitirse un enfoque más ágil. |

---

**EJERCICIO 2:**
Explica con tus propias palabras la diferencia entre Verificación y Validación. Pon un ejemplo de un sistema que pase la verificación pero falle la validación.

**✅ SOLUCIÓN:**

**DIFERENCIA:**

| Concepto | Pregunta clave | Enfoque |
|----------|----------------|----------|
| **Verificación** | "¿Estamos construyendo el producto CORRECTAMENTE?" | Compara el producto contra las especificaciones. ¿Cumple lo que se documentó? |
| **Validación** | "¿Estamos construyendo el producto CORRECTO?" | Compara el producto contra las necesidades reales. ¿Sirve para lo que el usuario necesita? |

**En otras palabras:**
- **Verificación:** El software hace lo que dice el documento de requisitos
- **Validación:** El software hace lo que el usuario realmente necesita

**EJEMPLO:**

*Contexto:* Una empresa encarga un sistema de gestión de inventario. El analista documenta los requisitos tras reuniones con el jefe de almacén.

*Verificación (PASA):*
- El sistema registra entradas y salidas de productos ✓
- El sistema calcula stock disponible ✓
- El sistema genera informes mensuales ✓
- Todo funciona según especificaciones, sin bugs ✓

*Validación (FALLA):*
- Los operarios de almacén (usuarios finales) nunca fueron consultados
- Ellos necesitaban alertas de stock mínimo (no especificado)
- Necesitaban poder usar lectores de código de barras (no especificado)
- El sistema requiere introducción manual que es muy lenta para su flujo de trabajo

*Resultado:* El sistema cumple las especificaciones (verificado) pero no satisface las necesidades reales (no validado). Es técnicamente correcto pero INÚTIL.

---

**EJERCICIO 3:**
¿Cómo aplicarías el principio de "Shift Left" en un proyecto de desarrollo de software? Describe al menos 3 actividades concretas.

**✅ SOLUCIÓN:**

**¿Qué es Shift Left?**
Mover las actividades de testing hacia la izquierda del cronograma (más temprano en el ciclo de desarrollo), en lugar de concentrarlas al final.

**ACTIVIDADES CONCRETAS DE SHIFT LEFT:**

**1. Revisión de Requisitos por Testers:**
- Incluir testers en las reuniones de definición de requisitos
- Revisar documentos de requisitos buscando ambigüedades, contradicciones e incompletitudes
- Preguntar "¿Cómo probaré esto?" para cada requisito
- Escribir criterios de aceptación antes de empezar a codificar

**2. Test-Driven Development (TDD):**
- Escribir las pruebas unitarias ANTES del código
- El desarrollador primero define qué debe hacer el código (prueba)
- Luego escribe el código mínimo para pasar la prueba
- Resultado: Código con alta cobertura de pruebas desde el inicio

**3. Integración Continua con Pruebas Automatizadas:**
- Configurar pipeline CI que ejecute pruebas en cada commit
- Pruebas unitarias ejecutadas en segundos tras cada cambio
- Feedback inmediato al desarrollador si rompe algo
- No esperar a fase de testing para descubrir problemas

**4. Revisión de Diseño Arquitectónico:**
- Testers participan en revisiones de diseño
- Identificar problemas de testabilidad antes de implementar
- Sugerir mejoras para facilitar el testing

**5. Análisis Estático de Código:**
- Linters y analizadores estáticos integrados en el IDE
- Detectan problemas mientras el desarrollador escribe
- No esperar a revisión de código o testing

---

**EJERCICIO 4:**
Tu equipo tiene un historial de defectos de los últimos 6 meses. Analizando los datos, descubres que el 70% de los defectos se concentran en 2 de los 10 módulos del sistema. ¿Qué principio explica esto y qué acciones tomarías?

**✅ SOLUCIÓN:**

**PRINCIPIO QUE LO EXPLICA:**

**Principio 4: Los defectos se agrupan (Clustering)**

Este principio establece que un pequeño número de módulos suele contener la mayoría de los defectos. Es una aplicación del principio de Pareto (80/20): aproximadamente el 80% de los defectos se encuentran en el 20% del código.

**¿POR QUÉ OCURRE?**
Los módulos problemáticos suelen ser:
- Más complejos que otros
- Desarrollados con prisa o bajo presión
- Con requisitos poco claros o cambiantes
- Desarrollados por personal menos experimentado
- Con muchas dependencias o integraciones
- Con deuda técnica acumulada

**ACCIONES A TOMAR:**

1. **Aumentar la intensidad de testing en esos 2 módulos:**
   - Más casos de prueba
   - Pruebas exploratorias adicionales
   - Mayor cobertura de código

2. **Revisar el código de esos módulos:**
   - Análisis estático profundo
   - Revisión de código por pares
   - Identificar patrones de defectos comunes

3. **Considerar refactorización:**
   - Si el código es muy complejo, simplificarlo
   - En casos extremos, reescribir puede ser más económico que seguir parcheando

4. **Análisis de causa raíz:**
   - ¿Por qué estos módulos tienen tantos defectos?
   - ¿Qué podemos aprender para futuros desarrollos?

5. **Prevención:**
   - Para nuevos módulos similares, aplicar medidas preventivas extra
   - Revisar proceso de desarrollo para esos tipos de módulos

---

# MÓDULO 7: MODELOS DE DESARROLLO Y SU RELACIÓN CON EL TESTING

## 7.1 Introducción: El Testing No Existe en el Vacío

Las actividades de testing no ocurren de forma aislada, sino que se integran en un modelo de desarrollo de software. La forma en que se planifica, ejecuta y gestiona el testing varía significativamente según el modelo de desarrollo utilizado por el equipo.

En este módulo exploraremos los principales modelos de desarrollo y cómo el testing se adapta a cada uno de ellos.

## 7.2 Modelos Secuenciales (Tradicionales)

### 7.2.1 Modelo en Cascada (Waterfall)

**Descripción:** Las fases del desarrollo se ejecutan de forma secuencial, una tras otra. Cada fase debe completarse antes de pasar a la siguiente.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    MODELO EN CASCADA                                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌──────────────────┐                                                      │
│   │    REQUISITOS    │                                                      │
│   └────────┬─────────┘                                                      │
│            │                                                                │
│            ▼                                                                │
│   ┌──────────────────┐                                                      │
│   │     DISEÑO       │                                                      │
│   └────────┬─────────┘                                                      │
│            │                                                                │
│            ▼                                                                │
│   ┌──────────────────┐                                                      │
│   │  IMPLEMENTACIÓN  │                                                      │
│   └────────┬─────────┘                                                      │
│            │                                                                │
│            ▼                                                                │
│   ┌──────────────────┐                                                      │
│   │     PRUEBAS      │  ← Testing al final, cuando ya está todo hecho      │
│   └────────┬─────────┘                                                      │
│            │                                                                │
│            ▼                                                                │
│   ┌──────────────────┐                                                      │
│   │  MANTENIMIENTO   │                                                      │
│   └──────────────────┘                                                      │
│                                                                             │
│   Características:                                                          │
│   • Fases secuenciales y no solapadas                                       │
│   • Documentación extensa en cada fase                                      │
│   • Testing concentrado al final                                            │
│   • Difícil volver atrás                                                    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Testing en Cascada:**
- Las pruebas son una fase separada al final
- Gran riesgo de encontrar defectos graves tarde
- Los testers suelen estar inactivos al principio
- Presión al final por falta de tiempo para testing

**Ventajas:**
- Claro y fácil de entender
- Bien definido, fácil de gestionar
- Funciona para proyectos con requisitos muy estables

**Desventajas:**
- Testing muy tardío (costoso corregir)
- Poca flexibilidad ante cambios
- El cliente ve el producto muy tarde

### 7.2.2 Modelo en V

**Descripción:** Extensión del modelo en cascada que enfatiza la relación entre fases de desarrollo y niveles de prueba. Cada fase de desarrollo tiene su correspondiente fase de pruebas.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    MODELO EN V                                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  VERIFICACIÓN                                        VALIDACIÓN             │
│  (Desarrollo)                                        (Pruebas)              │
│                                                                             │
│  Requisitos ─────────────────────────────────► Pruebas de Aceptación       │
│  Usuario     \                                     /    │                   │
│               \     Planificar                    /     │                   │
│  Requisitos    \    pruebas en                   /      │                   │
│  Sistema ───────\   paralelo al ────────► Pruebas       │                   │
│                  \  desarrollo /          de Sistema    │                   │
│                   \           /                 │       │                   │
│  Diseño            \         /                  │       │                   │
│  Arquitectura ──────\───────/─────────► Pruebas │       │                   │
│                      \     /          Integración       │                   │
│                       \   /                     │       │                   │
│  Diseño                \ /                      │       │                   │
│  Detallado ─────────────X────────────► Pruebas  │       │                   │
│                        / \            Unitarias │       │                   │
│                       /   \                     │       │                   │
│                      /     \                    │       │                   │
│                 CODIFICACIÓN                    ▼       ▼                   │
│                                                                             │
│   Beneficios del Modelo en V:                                               │
│   • Las pruebas se planifican en paralelo al desarrollo                    │
│   • Clara trazabilidad entre fases                                          │
│   • Cada nivel de prueba valida un nivel de diseño                         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Testing en Modelo V:**
- Las pruebas se diseñan en paralelo al desarrollo
- Cada nivel de desarrollo tiene su nivel de pruebas correspondiente
- Mejor integración del testing en el proceso
- Sigue siendo secuencial, las pruebas se ejecutan después del código

## 7.3 Modelos Iterativos e Incrementales

### 7.3.1 Desarrollo Iterativo

**Descripción:** El software se desarrolla a través de ciclos repetidos (iteraciones). Cada iteración produce una versión más completa del sistema.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DESARROLLO ITERATIVO                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Iteración 1         Iteración 2         Iteración 3                       │
│  ┌───────────┐       ┌───────────┐       ┌───────────┐                     │
│  │ Análisis  │       │ Análisis  │       │ Análisis  │                     │
│  │ Diseño    │ ───►  │ Diseño    │ ───►  │ Diseño    │ ───► ...           │
│  │ Código    │       │ Código    │       │ Código    │                     │
│  │ Pruebas   │       │ Pruebas   │       │ Pruebas   │                     │
│  └───────────┘       └───────────┘       └───────────┘                     │
│       │                   │                   │                             │
│       ▼                   ▼                   ▼                             │
│  [Versión 0.1]       [Versión 0.2]       [Versión 0.3]                     │
│                                                                             │
│   • Cada iteración produce una versión funcional                           │
│   • Se incorpora feedback y se mejora en cada ciclo                        │
│   • El testing ocurre en cada iteración                                     │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 7.3.2 Desarrollo Incremental

**Descripción:** El sistema se construye y entrega en incrementos, donde cada incremento añade funcionalidad al sistema.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DESARROLLO INCREMENTAL                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Incremento 1: Módulo de Login                                             │
│   ┌─────────────────────────────────────────────────────────────┐          │
│   │ ████████████████                                            │          │
│   └─────────────────────────────────────────────────────────────┘          │
│                                                                             │
│   Incremento 2: + Gestión de Usuarios                                       │
│   ┌─────────────────────────────────────────────────────────────┐          │
│   │ ████████████████████████████████                            │          │
│   └─────────────────────────────────────────────────────────────┘          │
│                                                                             │
│   Incremento 3: + Catálogo de Productos                                     │
│   ┌─────────────────────────────────────────────────────────────┐          │
│   │ ██████████████████████████████████████████████              │          │
│   └─────────────────────────────────────────────────────────────┘          │
│                                                                             │
│   Incremento 4: + Carrito y Pagos                                           │
│   ┌─────────────────────────────────────────────────────────────┐          │
│   │ ████████████████████████████████████████████████████████████│          │
│   └─────────────────────────────────────────────────────────────┘          │
│                                                                             │
│   • Cada incremento añade funcionalidad                                     │
│   • El sistema crece gradualmente                                           │
│   • Se puede entregar valor desde el primer incremento                     │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Testing en Modelos Iterativos/Incrementales:**
- Testing integrado en cada iteración/incremento
- Pruebas de regresión cruciales (lo anterior sigue funcionando)
- Automatización casi obligatoria
- Feedback rápido y correcciones tempranas

## 7.4 Metodologías Ágiles

### 7.4.1 Principios Ágiles y Testing

El Manifiesto Ágil (2001) cambió la forma de desarrollar software y, por tanto, de hacer testing:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              VALORES ÁGILES Y SU IMPACTO EN TESTING                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  VALOR ÁGIL                           IMPACTO EN TESTING                    │
│  ───────────                          ──────────────────                    │
│                                                                             │
│  "Individuos e interacciones          • Colaboración estrecha              │
│   sobre procesos y herramientas"        tester-desarrollador               │
│                                       • Comunicación cara a cara            │
│                                                                             │
│  "Software funcionando sobre          • Pruebas continuas                   │
│   documentación extensiva"            • Demostrar con código funcional     │
│                                       • Menos documentación formal          │
│                                                                             │
│  "Colaboración con el cliente         • Usuario en pruebas de aceptación   │
│   sobre negociación contractual"      • Feedback frecuente                 │
│                                       • Criterios de aceptación claros     │
│                                                                             │
│  "Respuesta ante el cambio            • Pruebas automatizadas (regresión)  │
│   sobre seguir un plan"               • Adaptación rápida                  │
│                                       • Refactorización segura              │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 7.4.2 Scrum y Testing

**Scrum** es el framework ágil más utilizado. Estructura el trabajo en **Sprints** (iteraciones de 2-4 semanas).

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    TESTING EN SCRUM                                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   SPRINT (2-4 semanas)                                                      │
│   ┌─────────────────────────────────────────────────────────────┐          │
│   │                                                             │          │
│   │  Sprint    Daily          Desarrollo + Testing    Sprint    │          │
│   │  Planning  Standups       continuo               Review     │          │
│   │     │         │               │                     │       │          │
│   │     ▼         ▼               ▼                     ▼       │          │
│   │  ┌────┐   ┌────────────────────────────────────┐  ┌────┐   │          │
│   │  │PLAN│──►│  DESARROLLO + TESTING INTEGRADO   │──►│DEMO│   │          │
│   │  └────┘   └────────────────────────────────────┘  └────┘   │          │
│   │                         │                                   │          │
│   │                         ▼                                   │          │
│   │              INCREMENTO POTENCIALMENTE                      │          │
│   │                   ENTREGABLE                                │          │
│   │                                                             │          │
│   └─────────────────────────────────────────────────────────────┘          │
│                              │                                              │
│                              ▼                                              │
│                    Sprint Retrospective                                     │
│                    (¿Cómo mejorar?)                                         │
│                                                                             │
│   Características del testing en Scrum:                                     │
│   • El testing es parte del Definition of Done (DoD)                        │
│   • No hay fase separada de testing                                         │
│   • Tester integrado en el equipo (no equipo separado)                     │
│   • Las historias de usuario incluyen criterios de aceptación              │
│   • Cada sprint produce software testeado y potencialmente entregable      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 7.4.3 El Tester en Equipos Ágiles

En metodologías ágiles, el rol del tester evoluciona significativamente:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              ROL DEL TESTER: TRADICIONAL vs ÁGIL                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  TRADICIONAL                         ÁGIL                                   │
│  ───────────                         ────                                   │
│                                                                             │
│  Equipo de QA separado               Tester integrado en el equipo         │
│                                                                             │
│  "Guardián de la calidad"            "Coach de calidad"                    │
│  (encuentra defectos)                (previene defectos)                    │
│                                                                             │
│  Pruebas al final                    Pruebas continuas                      │
│                                                                             │
│  Comunicación formal                 Comunicación constante                 │
│  (informes, tickets)                 (cara a cara)                          │
│                                                                             │
│  Especialista en testing             Generalista (testing + otras skills)  │
│                                                                             │
│  Ejecuta casos de prueba             Participa en todo el proceso:         │
│                                      - Refinamiento de historias            │
│                                      - Definición de criterios              │
│                                      - Automatización                       │
│                                      - Exploratorio                         │
│                                                                             │
│  "El tester prueba"                  "Todos son responsables de la calidad"│
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 7.4.4 Prácticas de Testing Ágil

#### Test-Driven Development (TDD)

**Descripción:** Escribir las pruebas ANTES de escribir el código.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CICLO TDD: RED-GREEN-REFACTOR                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                         ┌─────────┐                                         │
│                    ┌───►│   RED   │◄───┐                                   │
│                    │    └────┬────┘    │                                   │
│                    │         │         │                                   │
│                    │    1. Escribir    │                                   │
│                    │    prueba que     │                                   │
│                    │    FALLA          │                                   │
│                    │         │         │                                   │
│                    │         ▼         │                                   │
│               ┌────┴────┐         ┌────┴────┐                              │
│               │REFACTOR │◄────────│  GREEN  │                              │
│               └─────────┘         └─────────┘                              │
│                    │                   │                                   │
│               3. Mejorar          2. Escribir                              │
│               código sin          código mínimo                            │
│               cambiar             para PASAR                               │
│               comportamiento      la prueba                                │
│                                                                             │
│   Beneficios:                                                               │
│   • Código diseñado para ser testeable                                      │
│   • Alta cobertura de pruebas automáticamente                              │
│   • Documentación ejecutable                                                │
│   • Refactorización segura                                                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Behavior-Driven Development (BDD)

**Descripción:** Definir el comportamiento esperado en lenguaje natural que todos entienden, usando formato Given-When-Then.

```
Feature: Carrito de compras
  Como cliente de la tienda
  Quiero poder añadir productos al carrito
  Para poder comprarlos después

  Scenario: Añadir un producto al carrito vacío
    Given el carrito está vacío
    And el producto "Laptop" tiene un precio de 999€
    When añado el producto "Laptop" al carrito
    Then el carrito contiene 1 producto
    And el total del carrito es 999€

  Scenario: Añadir varios productos
    Given el carrito contiene 1 "Laptop" de 999€
    When añado el producto "Ratón" de 29€ al carrito
    Then el carrito contiene 2 productos
    And el total del carrito es 1028€
```

**Beneficios de BDD:**
- Lenguaje común entre negocio, desarrollo y QA
- Especificaciones ejecutables
- Documentación viva que no se desactualiza
- Criterios de aceptación claros desde el inicio

#### Integración Continua (CI) y Testing

**Descripción:** Integrar código frecuentemente (varias veces al día) y ejecutar pruebas automáticas en cada integración.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    PIPELINE DE INTEGRACIÓN CONTINUA                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   DESARROLLADOR                                                             │
│        │                                                                    │
│        │ git push                                                           │
│        ▼                                                                    │
│   ┌─────────┐     ┌─────────┐     ┌─────────┐     ┌─────────┐             │
│   │ BUILD   │────►│ UNIT    │────►│ INTEGR. │────►│ E2E     │             │
│   │ Compilar│     │ TESTS   │     │ TESTS   │     │ TESTS   │             │
│   └────┬────┘     └────┬────┘     └────┬────┘     └────┬────┘             │
│        │               │               │               │                   │
│        ▼               ▼               ▼               ▼                   │
│   [2 min]         [5 min]         [15 min]        [30 min]                 │
│        │               │               │               │                   │
│        └───────────────┴───────────────┴───────────────┘                   │
│                              │                                              │
│                    ┌─────────┴─────────┐                                   │
│                    │                   │                                   │
│                    ▼                   ▼                                   │
│               ┌─────────┐        ┌─────────┐                               │
│               │  PASA   │        │  FALLA  │                               │
│               │   ✓     │        │   ✗     │                               │
│               └────┬────┘        └────┬────┘                               │
│                    │                  │                                    │
│                    ▼                  ▼                                    │
│              Deploy a            Notificar                                 │
│              staging             desarrollador                             │
│                                  (arreglar ya!)                            │
│                                                                             │
│   Principio: "Si rompes el build, es tu prioridad #1 arreglarlo"          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 7.5 Comparativa de Modelos y Testing

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              COMPARATIVA: TESTING EN DIFERENTES MODELOS                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Aspecto          Cascada       Modelo V      Iterativo    Ágil            │
│  ───────          ───────       ────────      ─────────    ────            │
│                                                                             │
│  Cuándo se        Al final      En paralelo   Cada         Continuo        │
│  planifica                      al diseño     iteración                    │
│  testing                                                                    │
│                                                                             │
│  Cuándo se        Al final      Al final      En cada      Continuo        │
│  ejecuta                        (pero mejor   iteración    (diario)        │
│  testing                        preparado)                                 │
│                                                                             │
│  Documentación    Extensa       Extensa       Moderada     Mínima          │
│  de pruebas                                                                 │
│                                                                             │
│  Automatización   Opcional      Recomendada   Importante   Esencial        │
│                                                                             │
│  Feedback         Muy tardío    Tardío        Frecuente    Muy             │
│                                                            frecuente       │
│                                                                             │
│  Regresión        Poca          Moderada      Importante   Crítica         │
│                                                                             │
│  Rol del          Separado      Separado      Puede estar  Integrado       │
│  tester           del equipo    del equipo    integrado    en equipo       │
│                                                                             │
│  Adaptación       Muy difícil   Difícil       Buena        Excelente       │
│  a cambios                                                                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 7.6 DevOps y Testing Continuo

### 7.6.1 ¿Qué es DevOps?

DevOps es una cultura y conjunto de prácticas que busca unificar el desarrollo (Dev) y las operaciones (Ops) para entregar software de forma más rápida y confiable.

### 7.6.2 Testing en DevOps

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    TESTING EN EL PIPELINE DEVOPS                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌──────────────────────────────────────────────────────────────────┐     │
│   │                     PIPELINE CI/CD                                │     │
│   │                                                                  │     │
│   │  CODE ──► BUILD ──► TEST ──► RELEASE ──► DEPLOY ──► MONITOR     │     │
│   │                       │                               │          │     │
│   │                       │                               │          │     │
│   │                       ▼                               ▼          │     │
│   │              ┌────────────────┐            ┌──────────────────┐ │     │
│   │              │ Pruebas Auto   │            │ Monitorización   │ │     │
│   │              │ • Unitarias    │            │ • Logs           │ │     │
│   │              │ • Integración  │            │ • Métricas       │ │     │
│   │              │ • E2E          │            │ • Alertas        │ │     │
│   │              │ • Rendimiento  │            │ • A/B Testing    │ │     │
│   │              │ • Seguridad    │            │ • Canary release │ │     │
│   │              └────────────────┘            └──────────────────┘ │     │
│   │                                                                  │     │
│   └──────────────────────────────────────────────────────────────────┘     │
│                                                                             │
│   Características del testing en DevOps:                                    │
│   • Todo automatizado                                                       │
│   • Testing como código (versionado)                                        │
│   • Feedback en minutos, no días                                            │
│   • Pruebas en producción (monitorizadas)                                  │
│   • Despliegues frecuentes (varias veces al día)                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 7.6.3 Shift-Right Testing

Mientras "Shift-Left" significa probar más temprano, "Shift-Right" significa probar también en producción:

**Técnicas de Shift-Right:**
- **Canary Releases:** Desplegar a un pequeño % de usuarios primero
- **A/B Testing:** Probar diferentes versiones con diferentes usuarios
- **Feature Flags:** Activar/desactivar funcionalidades sin desplegar
- **Chaos Engineering:** Provocar fallos controlados para probar resiliencia
- **Monitoring activo:** Detectar problemas antes que los usuarios

## 7.7 Ejercicios de Práctica

---

**EJERCICIO 1:**
Compara el modelo en cascada con el modelo ágil en términos de cuándo y cómo se realiza el testing. ¿Qué ventajas tiene cada enfoque?

**✅ SOLUCIÓN:**

| Aspecto | Modelo en Cascada | Modelo Ágil |
|---------|-------------------|-------------|
| **Cuándo se planifica** | Al inicio, para todo el proyecto | Cada sprint/iteración |
| **Cuándo se ejecuta** | Al final, tras completar desarrollo | Continuo, durante todo el sprint |
| **Quién hace testing** | Equipo QA separado | Tester integrado en el equipo (o todo el equipo) |
| **Documentación** | Extensa, formal | Mínima, pragmática |
| **Feedback** | Tardío (semanas/meses) | Rápido (días/horas) |
| **Automatización** | Opcional | Casi obligatoria |
| **Regresión** | Al final | Continua |

**VENTAJAS DEL CASCADA:**
- Clara definición de fases y entregables
- Mejor para proyectos con requisitos muy estables y bien conocidos
- Documentación completa para auditorías y certificaciones
- Más fácil de gestionar y presupuestar

**VENTAJAS DEL ÁGIL:**
- Detección temprana de defectos (más barato corregir)
- Adaptación rápida a cambios de requisitos
- Feedback continuo del cliente
- Menor riesgo de entregar algo que no sirve
- Producto funcional desde el principio

---

**EJERCICIO 2:**
Una empresa está desarrollando un software de gestión hospitalaria (crítico para la vida de los pacientes). ¿Qué modelo de desarrollo recomendarías y por qué? ¿Cómo debería ser el testing?

**✅ SOLUCIÓN:**

**MODELO RECOMENDADO: Modelo en V o Híbrido con elementos ágiles controlados**

**JUSTIFICACIÓN:**

1. **Regulaciones estrictas:** El software médico debe cumplir normativas (FDA en EEUU, marcado CE en Europa, IEC 62304). Estas normativas requieren:
   - Trazabilidad completa de requisitos
   - Documentación exhaustiva
   - Validación formal
   - Auditorías

2. **El Modelo en V proporciona:**
   - Clara correspondencia entre fases de desarrollo y testing
   - Documentación requerida por reguladores
   - Proceso verificable y auditable

3. **Elementos ágiles controlados:**
   - Se pueden usar sprints para desarrollo
   - Pero cada incremento debe pasar validación formal
   - La documentación no se puede reducir

**CÓMO DEBE SER EL TESTING:**

| Aspecto | Requisito |
|---------|----------|
| **Cobertura** | 100% de requisitos críticos probados |
| **Trazabilidad** | Cada requisito → casos de prueba → resultados |
| **Documentación** | Planes de prueba, casos, resultados, informes formales |
| **Niveles** | Todos: unitarias, integración, sistema, aceptación |
| **Tipos especiales** | Seguridad de pacientes, fiabilidad, recuperación ante fallos |
| **Validación** | Con usuarios clínicos reales en entorno controlado |
| **Regresión** | Completa ante cualquier cambio |
| **Independencia** | Equipo de validación independiente del desarrollo |

---

**EJERCICIO 3:**
Explica el ciclo TDD (Red-Green-Refactor) con un ejemplo práctico. ¿Por qué escribir las pruebas antes del código puede mejorar la calidad?

**✅ SOLUCIÓN:**

**CICLO TDD: RED-GREEN-REFACTOR**

**1. RED (Rojo):** Escribir una prueba que FALLA
- Primero defines QUÉ debe hacer el código
- La prueba falla porque el código aún no existe

**2. GREEN (Verde):** Escribir el código MÍNIMO para pasar la prueba
- Solo lo necesario para que la prueba pase
- No optimizar ni añadir funcionalidad extra

**3. REFACTOR:** Mejorar el código sin cambiar el comportamiento
- Limpiar, optimizar, eliminar duplicación
- Las pruebas garantizan que no rompes nada

**EJEMPLO PRÁCTICO: Función que calcula el precio con descuento**

```python
# PASO 1 - RED: Escribir prueba que falla
def test_descuento_20_porciento():
    assert calcular_precio_final(100, 20) == 80
# Ejecutar: FALLA (la función no existe)

# PASO 2 - GREEN: Código mínimo para pasar
def calcular_precio_final(precio, descuento):
    return precio - (precio * descuento / 100)
# Ejecutar: PASA

# PASO 3 - REFACTOR: Mejorar si es necesario
# En este caso simple, el código ya está bien

# PASO 1 - RED: Nueva prueba
def test_descuento_no_puede_ser_negativo():
    with pytest.raises(ValueError):
        calcular_precio_final(100, -10)
# Ejecutar: FALLA

# PASO 2 - GREEN: Añadir validación
def calcular_precio_final(precio, descuento):
    if descuento < 0:
        raise ValueError("Descuento no puede ser negativo")
    return precio - (precio * descuento / 100)
# Ejecutar: PASA
```

**¿POR QUÉ MEJORA LA CALIDAD?**

1. **Diseño mejorado:** El código se diseña para ser testeable desde el inicio
2. **Cobertura garantizada:** Todo el código tiene pruebas porque se escribió PARA pasar pruebas
3. **Documentación viva:** Las pruebas documentan qué debe hacer el código
4. **Refactorización segura:** Puedes mejorar el código con confianza
5. **Menos defectos:** Piensas en casos borde ANTES de codificar

---

**EJERCICIO 4:**
Un equipo Scrum tiene sprints de 2 semanas. Describe cómo debería integrarse el testing a lo largo del sprint, incluyendo qué actividades de testing ocurren y cuándo.

**✅ SOLUCIÓN:**

**DISTRIBUCIÓN DEL TESTING EN UN SPRINT DE 2 SEMANAS:**

| Día | Actividad de Testing |
|-----|----------------------|
| **Día 1** | **Sprint Planning:** Tester participa en planificación. Revisa historias de usuario. Define criterios de aceptación. Estima esfuerzo de testing. |
| **Días 2-3** | **Preparación:** Diseñar casos de prueba para historias del sprint. Preparar datos de prueba. Actualizar scripts de automatización si es necesario. |
| **Días 2-8** | **Testing continuo:** A medida que los desarrolladores completan historias, el tester las prueba inmediatamente. Pruebas exploratorias. Reportar defectos para corrección dentro del sprint. |
| **Días 4-9** | **Automatización:** Automatizar pruebas de regresión para nuevas funcionalidades. Integrar en pipeline CI. |
| **Días 8-9** | **Regresión completa:** Ejecutar suite completa de regresión. Verificar que funcionalidades anteriores siguen funcionando. |
| **Día 9** | **Bug fixing final:** Los desarrolladores corrigen los últimos bugs encontrados. Re-testing de correcciones. |
| **Día 10** | **Sprint Review:** Demostrar funcionalidades probadas. **Sprint Retrospective:** ¿Qué funcionó bien/mal en testing? ¿Cómo mejorar? |

**ACTIVIDADES DE TESTING DIARIAS:**
- **Daily Standup:** Tester reporta qué probó ayer, qué probará hoy, si hay bloqueos
- **Pair testing:** Trabajar con desarrolladores en historias complejas
- **Ejecución de pipeline CI:** Verificar que las pruebas automatizadas pasan

**DEFINICIÓN DE "DONE" incluye:**
- ✓ Código revisado
- ✓ Pruebas unitarias pasando
- ✓ Pruebas de aceptación pasando
- ✓ Sin defectos críticos abiertos
- ✓ Documentación actualizada

---

**EJERCICIO 5:**
¿Qué es la Integración Continua y por qué es importante para el testing? ¿Qué tipos de pruebas deberían ejecutarse automáticamente en un pipeline de CI?

**✅ SOLUCIÓN:**

**¿QUÉ ES LA INTEGRACIÓN CONTINUA (CI)?**

Es la práctica de integrar código de múltiples desarrolladores en un repositorio compartido varias veces al día, ejecutando automáticamente compilación y pruebas en cada integración.

**¿POR QUÉ ES IMPORTANTE PARA EL TESTING?**

1. **Feedback inmediato:** Si un cambio rompe algo, se detecta en minutos, no días
2. **Detección temprana:** Los problemas se encuentran cuando aún son fáciles de corregir
3. **Regresión automática:** Cada cambio verifica que no ha roto nada anterior
4. **Confianza:** El equipo puede hacer cambios con seguridad
5. **Historial:** Se sabe exactamente qué commit introdujo un problema
6. **Calidad constante:** El código siempre está en estado "desplegable"

**TIPOS DE PRUEBAS EN UN PIPELINE CI (por orden de ejecución):**

| Fase | Tipo de Prueba | Duración | Propósito |
|------|----------------|----------|----------|
| 1 | **Build/Compile** | ~1 min | Verificar que el código compila |
| 2 | **Análisis estático** | ~2 min | Linters, seguridad básica, estilo |
| 3 | **Pruebas unitarias** | ~5 min | Verificar lógica de funciones individuales |
| 4 | **Pruebas de integración** | ~10 min | Verificar comunicación entre componentes |
| 5 | **Pruebas E2E/UI** (subset) | ~15 min | Smoke test de flujos críticos |
| 6 | **Pruebas de seguridad** (SAST) | ~5 min | Vulnerabilidades en código |

**PIPELINE EJEMPLO:**
```
Commit → Build → Unit Tests → Integration Tests → Deploy to Staging → E2E Tests → ✓/✗
         [2min]    [5min]        [10min]            [2min]            [15min]
```

**PRINCIPIOS:**
- Si cualquier fase falla, el pipeline se detiene
- El desarrollador que rompió el build debe arreglarlo inmediatamente
- Las pruebas deben ser rápidas (feedback en <30 minutos idealmente)

---

# CIERRE: RESUMEN FINAL DEL CURSO

## Recapitulación de los 7 Módulos

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              MAPA MENTAL DEL CURSO COMPLETO                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                        TESTING DE SOFTWARE                                   │
│                              │                                              │
│      ┌──────────┬───────────┼───────────┬──────────┐                       │
│      │          │           │           │          │                       │
│      ▼          ▼           ▼           ▼          ▼                       │
│  CONCEPTOS   CALIDAD    ASPECTOS    TIPOS      NIVELES                     │
│  BÁSICOS     (M2)       (M3)        (M4)       (M5)                        │
│  (M1)                                                                       │
│      │          │           │           │          │                       │
│      │      ISO 25010   Funcional  Estática   Unitarias                    │
│      │      QA vs QC    No Func.   Dinámica   Integración                  │
│      │      Costes      Rendim.    Caja       Sistema                      │
│      │                  Seguridad  Negra      Aceptación                   │
│      │                  Usabilidad Blanca                                  │
│      │                                                                      │
│      └──────────────────────┬──────────────────────┘                       │
│                             │                                              │
│              ┌──────────────┴──────────────┐                               │
│              │                             │                               │
│              ▼                             ▼                               │
│         PRINCIPIOS                    MODELOS                              │
│         (M6)                          (M7)                                 │
│              │                             │                               │
│         7 Principios                  Cascada                              │
│         ISTQB                         Modelo V                             │
│                                       Iterativo                            │
│                                       Ágil/Scrum                           │
│                                       DevOps                               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Conceptos Clave para Recordar

1. **El testing es esencial** pero nunca puede demostrar ausencia de defectos
2. **La calidad tiene coste** pero los defectos cuestan más
3. **Probar temprano** siempre es más económico
4. **Funcional + No Funcional** = Visión completa de la calidad
5. **Diferentes tipos y niveles** de pruebas encuentran diferentes defectos
6. **El contexto importa** - no hay solución única para todos
7. **El modelo de desarrollo** condiciona cómo hacemos testing
8. **La automatización** es clave en entornos modernos
9. **El tester moderno** es un profesional integrado que previene defectos

---

*[Fin del Documento - Versión para PROFESORES con Soluciones]*
*Material de apoyo para el curso de Testing de Software - EOI 2026*
*⚠️ CONFIDENCIAL - No distribuir a alumnos*
