# APUNTES COMPLETOS DE TESTING DE SOFTWARE
## Curso de Técnico en Testing y Ciberseguridad Aplicada
### Versión para Profesor con Soluciones (v2 - Reorganizada)

---

# MÓDULO 1: INTRODUCCIÓN Y FUNDAMENTOS DEL TESTING

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
- Sanciones por incumplimiento de normativas (GDPR -Reglamento General de Protección de Datos-, PCI-DSS -estándar de seguridad para tarjetas de pago-, etc.)
- Responsabilidades civiles o incluso penales en casos graves

**Consecuencias Humanas (en sistemas críticos):**
- En software médico: diagnósticos erróneos, dosificaciones incorrectas
- En software aeronáutico: fallos en sistemas de navegación
- En software industrial: accidentes laborales
- En software de vehículos: accidentes de tráfico

### 1.1.3 Casos Reales de Fallos de Software Catastróficos

**El Therac-25 (1985-1987):**
Una máquina de radioterapia cuyo software tenía defectos que causaron sobredosis masivas de radiación a varios pacientes, resultando en muertes y lesiones graves. El problema: una condición de carrera (race condition: cuando dos procesos acceden al mismo recurso a la vez y el resultado depende del orden impredecible en que se ejecutan) en el código que no fue detectada en las pruebas.

**El Ariane 5 (1996):**
El cohete europeo Ariane 5 explotó 37 segundos después del lanzamiento. Coste: 370 millones de dólares. La causa: un error de conversión de un número de 64 bits a 16 bits que causó un desbordamiento (overflow). El código había funcionado correctamente en Ariane 4, pero nadie lo probó adecuadamente para las nuevas condiciones de Ariane 5.

**Knight Capital (2012):**
Una empresa de trading perdió 440 millones de dólares en 45 minutos debido a un error de software en su sistema de trading automatizado. Un despliegue defectuoso activó código obsoleto que comenzó a realizar operaciones incorrectas a gran velocidad.

**Boeing 737 MAX (2018-2019):**
Dos accidentes aéreos con 346 víctimas mortales. Entre las causas: defectos en el sistema de software MCAS y deficiencias en el proceso de pruebas y certificación.

### 1.1.4 El Testing como Disciplina Profesional

El testing no es simplemente "probar cosas para ver si funcionan". Es una disciplina profesional con:

- **Fundamentos teóricos** basados en matemáticas, lógica y estadística
- **Metodologías estructuradas** desarrolladas durante décadas
- **Certificaciones internacionales** reconocidas (ISTQB -International Software Testing Qualifications Board-, CSTE -Certified Software Tester-, etc.)
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
- **Mayor:** Funcionalidad importante no funciona, sin workaround (solución alternativa)
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

*Espacio para tu respuesta:*

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

*Espacio para tu respuesta:*

---

**EJERCICIO 3:**
Un sistema bancario permite transferencias. El requisito dice: "Las transferencias deben ser de mínimo 1€ y máximo 10.000€". Un usuario intenta transferir 10.001€ y el sistema lo permite.

**Identifica:**
a) ¿Cuál fue el error?
b) ¿Cuál es el defecto?
c) ¿Cuál es el fallo?

*Espacio para tu respuesta:*

---

## 1.3 Los 7 Principios Fundamentales del Testing (ISTQB - International Software Testing Qualifications Board)

Estos principios son verdades universales del testing que guían las decisiones sobre cómo, cuándo y cuánto probar.

### Principio 1: Las Pruebas Muestran la Presencia de Defectos

> **"Las pruebas pueden demostrar que existen defectos, pero NO pueden demostrar que no existen defectos."**

**Implicaciones:**
- No podemos decir "el sistema no tiene defectos"
- Solo podemos decir "no encontramos defectos en lo que probamos"
- El testing reduce la probabilidad de defectos ocultos, pero nunca la elimina
- El testing exitoso es el que ENCUENTRA defectos

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  ✓ PUEDES DECIR:                     ✗ NO PUEDES DECIR:                    │
├─────────────────────────────────────────────────────────────────────────────┤
│  "Ejecuté 500 casos sin fallos"      "El sistema no tiene defectos"        │
│  "Cobertura del 85%"                 "El software es 100% correcto"        │
│  "Pasó todas las pruebas"            "Es imposible que falle"              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Principio 2: Las Pruebas Exhaustivas Son Imposibles

> **"Probar todas las combinaciones de entradas y precondiciones es imposible excepto en casos triviales."**

**Demostración:**
```
Formulario con 3 campos:
- Nombre: hasta 50 caracteres → 256^50 combinaciones
- Edad: 0-150 → 151 valores
- Email: hasta 100 caracteres → 256^100 combinaciones

Total = Número astronómico (más que átomos en el universo)
```

**Estrategias:**
- Análisis de riesgos para priorizar
- Técnicas de selección (clases de equivalencia, valores límite)
- Criterios de cobertura definidos

### Principio 3: Las Pruebas Tempranas Ahorran Tiempo y Dinero

> **"Las actividades de prueba deben comenzar lo antes posible en el ciclo de vida."**

**Coste de corrección según fase de detección:**

```
   Fase de Detección          Coste Relativo    
   ─────────────────          ──────────────    
   Requisitos                      1x           
   Diseño                          5x           
   Codificación                   10x           
   Pruebas Unitarias              15x           
   Pruebas de Sistema             50x           
   Producción                  100-1000x        
```

**Shift Left Testing (desplazar las pruebas hacia la izquierda):** Mover el testing hacia fases más tempranas del ciclo de desarrollo:
- Revisar requisitos buscando ambigüedades
- Revisar diseños antes de implementar
- TDD (Test-Driven Development - Desarrollo guiado por pruebas: escribir el test antes que el código)
- Integración continua con pruebas automatizadas

### Principio 4: Los Defectos Se Agrupan (Clustering)

> **"Un pequeño número de módulos suele contener la mayoría de los defectos."**

**Principio de Pareto:** Aproximadamente el 80% de los defectos se encuentran en el 20% del código.

**¿Por qué ocurre?**
- Módulos más complejos
- Desarrollados con prisa
- Requisitos poco claros
- Muchos cambios acumulados
- Deuda técnica

**Acción:** Identificar módulos problemáticos y dedicarles más esfuerzo de pruebas.

### Principio 5: La Paradoja del Pesticida

> **"Si las mismas pruebas se repiten una y otra vez, eventualmente dejarán de encontrar nuevos defectos."**

**Analogía:** Como los pesticidas, si usas siempre el mismo, las plagas desarrollan resistencia.

**Soluciones:**
- Revisar y actualizar casos de prueba regularmente
- Rotar testers para perspectivas frescas
- Pruebas exploratorias
- Cambiar datos de prueba
- Añadir pruebas para cada defecto encontrado en producción

### Principio 6: Las Pruebas Dependen del Contexto

> **"Las pruebas se realizan de manera diferente en diferentes contextos."**

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  SISTEMA BANCARIO                    JUEGO MÓVIL                            │
├─────────────────────────────────────────────────────────────────────────────┤
│  • Seguridad: CRÍTICA                • Seguridad: Moderada                  │
│  • Pruebas formales                  • Pruebas ágiles                       │
│  • Documentación extensa             • Documentación mínima                 │
│  • Regulaciones estrictas            • Pocas regulaciones                   │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Factores que definen el contexto:**
- Criticidad del sistema
- Regulaciones aplicables
- Perfil de usuarios
- Metodología de desarrollo
- Presupuesto y tiempo
- Historial de defectos

### Principio 7: La Ausencia de Errores Es Una Falacia

> **"Encontrar y corregir defectos no sirve si el sistema no satisface las necesidades del usuario."**

**Verificación vs Validación: Construir bien vs Construir lo correcto**

En testing se distingue entre verificación y validación porque ayudan a evitar un error frecuente: **cumplir documentos y fallar en el mundo real**.

| Verificación | Validación |
|--------------|------------|
| ¿Construimos el producto **CORRECTAMENTE**? | ¿Construimos el producto **CORRECTO**? |
| Cumple especificaciones | Cumple necesidades reales |
| Funciona según documentación | El usuario está satisfecho |
| Se apoya en **especificaciones, criterios de aceptación y reglas de negocio formalizadas** | Se apoya en el **uso real, la intención del requisito y el valor para el usuario** |

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    VERIFICACIÓN vs VALIDACIÓN                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   VERIFICACIÓN                           VALIDACIÓN                         │
│   ────────────                           ──────────                         │
│                                                                             │
│   "¿Lo hicimos BIEN?"                    "¿Hicimos lo CORRECTO?"            │
│                                                                             │
│   • Comparar con especificaciones        • Comparar con necesidades reales  │
│   • Criterios de aceptación              • Intención del requisito          │
│   • Reglas de negocio documentadas       • Valor para el usuario            │
│   • Revisiones, inspecciones             • Pruebas de aceptación            │
│                                                                             │
│   ─────────────────────────────────────────────────────────────────────     │
│                                                                             │
│   Un sistema puede estar VERIFICADO porque hace lo que se pidió,            │
│   pero NO estar VALIDADO porque:                                            │
│     • No resuelve el problema real                                          │
│     • Contradice una norma                                                  │
│     • Genera una respuesta inaceptable para el usuario                      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Ejemplo:**
> Se especificó: *"El sistema debe mostrar el saldo en la moneda local"*
> 
> ✅ **Verificación PASA:** El sistema muestra el saldo en euros (moneda local de España).
> 
> ❌ **Validación FALLA:** El usuario es una empresa que opera en dólares y necesita ver el saldo en USD. El sistema hace lo que se pidió, pero no resuelve la necesidad real.

**Un software sin bugs que nadie quiere usar sigue siendo un fracaso.**

---

## 1.4 Ejercicios del Módulo 1 - CON SOLUCIONES

> 📝 **Nota:** Los ejercicios de Error/Defecto/Fallo (Ejercicios 1-4 de la sección 1.2.6) tienen sus soluciones en esa misma sección.

---

**EJERCICIO 1:**
Para cada situación, indica qué principio del testing se está violando:

a) "Ejecutamos 1000 casos de prueba sin encontrar fallos, por lo tanto el sistema no tiene defectos"
b) "Vamos a probar todas las posibles combinaciones de entrada del formulario"
c) "Las pruebas las haremos cuando el desarrollo esté completamente terminado"
d) "Usamos exactamente los mismos casos de prueba desde hace 3 años"
e) "Aplicamos la misma estrategia de testing para nuestra app móvil que para el software del marcapasos"

**✅ SOLUCIÓN:**

a) **Principio 1: Las pruebas muestran la presencia de defectos, no su ausencia.** Que no encontremos defectos no significa que no existan. Solo significa que las pruebas ejecutadas no los detectaron.

b) **Principio 2: Las pruebas exhaustivas son imposibles.** Es matemáticamente imposible probar todas las combinaciones. Hay que usar técnicas como particiones de equivalencia y valores límite.

c) **Principio 3: Las pruebas tempranas ahorran tiempo y dinero.** Esperar al final significa que los defectos encontrados serán mucho más costosos de corregir. El testing debe comenzar desde la fase de requisitos.

d) **Principio 5: Paradoja del pesticida.** Si usamos siempre los mismos casos de prueba, dejarán de encontrar nuevos defectos. Hay que revisarlos, actualizarlos y añadir nuevos.

e) **Principio 6: Las pruebas dependen del contexto.** El nivel de rigor, documentación, técnicas y estrategias debe adaptarse al contexto. Un software médico crítico requiere un enfoque completamente diferente a una app de entretenimiento.

---

**EJERCICIO 2:**
Explica con tus propias palabras la diferencia entre Verificación y Validación. Pon un ejemplo de un sistema que pase la verificación pero falle la validación.

**✅ SOLUCIÓN:**

**Diferencia:**
- **Verificación:** Comprueba que el producto se ha construido CORRECTAMENTE según las especificaciones. Responde a: "¿Estamos construyendo el producto bien?"
- **Validación:** Comprueba que se ha construido el producto CORRECTO, el que realmente necesita el usuario. Responde a: "¿Estamos construyendo el producto correcto?"

**Ejemplo clásico:**
Una empresa desarrolla un sistema de gestión de inventario siguiendo exactamente las especificaciones escritas hace 2 años:
- **Verificación:** ✓ PASA - El sistema cumple al 100% con las especificaciones documentadas. Todas las funciones especificadas funcionan correctamente.
- **Validación:** ✗ FALLA - Cuando los usuarios del almacén empiezan a usarlo, descubren que:
  - El proceso de entrada de productos tiene demasiados pasos
  - No permite escanear códigos de barras, que ahora todos usan
  - Los informes que genera no son los que la dirección necesita
  
El sistema hace exactamente lo que se especificó, pero esas especificaciones ya no reflejan lo que los usuarios realmente necesitan.

---

# MÓDULO 2: CALIDAD DEL SOFTWARE

Ahora que entendemos qué son los errores, defectos y fallos, y conocemos los principios que guían el testing, surge una pregunta fundamental: **¿qué estamos tratando de conseguir con todo esto?** La respuesta es: **calidad**. 

> 💡 **¿Por qué estudiar calidad en un curso de testing?** Porque **el testing es el principal instrumento para medir y verificar la calidad del software**. No podemos probar eficazmente si no sabemos qué características de calidad debemos verificar. Un tester que no entiende la calidad es como un médico que no entiende la salud: puede hacer pruebas, pero no sabrá interpretarlas ni priorizarlas correctamente.

Este módulo nos ayudará a entender qué significa realmente la calidad del software, cómo medirla, y así sabremos exactamente **qué debemos verificar** cuando diseñemos nuestras pruebas.

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

La respuesta es: **TODAS las anteriores**, y más. La calidad del software es un concepto **multidimensional** que incluye muchos aspectos diferentes.

### 2.1.2 Definición Formal de Calidad

Según el estándar **ISO/IEC 25010**, la calidad del software se define como:

> "El grado en que un sistema de software satisface las necesidades declaradas e implícitas de sus distintos stakeholders (partes interesadas), proporcionando así valor."

Esta definición nos dice varias cosas importantes:
1. **Grado:** La calidad no es binaria (tiene/no tiene), sino gradual
2. **Necesidades declaradas:** Lo que el cliente pidió explícitamente
3. **Necesidades implícitas:** Lo que el cliente espera aunque no lo dijo
4. **Stakeholders (partes interesadas):** No solo el usuario final, también desarrolladores, operadores, etc.
5. **Valor:** La calidad debe aportar valor real

### 2.1.3 Modelo de Calidad ISO/IEC 25010

El estándar ISO/IEC 25010 define **8 características principales** de calidad:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    MODELO ISO/IEC 25010                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                         CALIDAD DEL PRODUCTO                                │
│                                                                             │
│   ┌──────────────┬──────────────┬──────────────┬──────────────┐            │
│   │  ADECUACIÓN  │  EFICIENCIA  │COMPATIBILIDAD│  USABILIDAD  │            │
│   │  FUNCIONAL   │    DE        │              │              │            │
│   │              │ RENDIMIENTO  │              │              │            │
│   ├──────────────┼──────────────┼──────────────┼──────────────┤            │
│   │  FIABILIDAD  │  SEGURIDAD   │MANTENIBILIDAD│ PORTABILIDAD │            │
│   │              │              │              │              │            │
│   └──────────────┴──────────────┴──────────────┴──────────────┘            │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**1. ADECUACIÓN FUNCIONAL**
¿El sistema hace lo que debe hacer?
- Completitud funcional
- Corrección funcional
- Adecuación funcional

**2. EFICIENCIA DE RENDIMIENTO**
¿Lo hace de manera eficiente?
- Comportamiento temporal (tiempos de respuesta)
- Utilización de recursos
- Capacidad

**3. COMPATIBILIDAD**
¿Funciona bien con otros sistemas?
- Coexistencia
- Interoperabilidad

**4. USABILIDAD**
¿Es fácil de usar?
- Reconocibilidad de adecuación
- Aprendibilidad
- Operabilidad
- Protección contra errores
- Estética de la interfaz
- Accesibilidad

**5. FIABILIDAD**
¿Funciona de manera consistente?
- Madurez
- Disponibilidad
- Tolerancia a fallos
- Recuperabilidad

**6. SEGURIDAD**
¿Protege la información adecuadamente?
- Confidencialidad
- Integridad
- No repudio
- Responsabilidad
- Autenticidad

> 🔧 **Práctica:** Veremos técnicas de **SQL Injection** para entender cómo los atacantes explotan vulnerabilidades y cómo prevenirlas en nuestro código.

**7. MANTENIBILIDAD**
¿Es fácil de modificar?
- Modularidad
- Reusabilidad
- Analizabilidad
- Modificabilidad
- Testabilidad

**8. PORTABILIDAD**
¿Se puede trasladar a otros entornos?
- Adaptabilidad
- Instalabilidad
- Reemplazabilidad

## 2.2 QA (Quality Assurance) vs QC (Quality Control)

Ya sabemos QUÉ características debe tener un software de calidad (ISO 25010). Ahora veamos CÓMO conseguimos esa calidad. Existen dos enfoques complementarios que debemos distinguir:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              QA (ASEGURAMIENTO) vs QC (CONTROL)                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   QA - QUALITY ASSURANCE              QC - QUALITY CONTROL                  │
│   ──────────────────────              ────────────────────                  │
│                                                                             │
│   PREVENTIVO                          DETECTIVO                             │
│   Evitar que entren defectos          Encontrar defectos existentes         │
│                                                                             │
│   ENFOCADO EN PROCESO                 ENFOCADO EN PRODUCTO                  │
│   ¿Cómo trabajamos?                   ¿Qué hemos construido?                │
│                                                                             │
│   PROACTIVO                           REACTIVO                              │
│   Antes de que ocurran problemas      Después de que se construye          │
│                                                                             │
│   Ejemplos:                           Ejemplos:                             │
│   • Definir estándares de código      • Ejecutar pruebas                    │
│   • Establecer metodologías           • Revisar código                      │
│   • Formar al equipo                  • Inspeccionar entregables            │
│   • Auditar procesos                  • Validar requisitos                  │
│                                                                             │
│              QA + QC = GESTIÓN DE CALIDAD COMPLETA                          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2.2.1 Clasificación de las Medidas de Aseguramiento de Calidad

Las medidas de aseguramiento de la calidad se pueden clasificar según su **enfoque** y su **naturaleza**:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              MEDIDAS DE ASEGURAMIENTO DE LA CALIDAD                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ◄── PROACTIVAS ──────────────────┬────────────────── REACTIVAS ──►        │
│       (Evitar errores)             │              (Detectar errores)        │
│                                    │                                        │
│   "Los errores que no se           │   "El descubrimiento de errores        │
│    cometen no necesitan            │    sirve para corregir defectos        │
│    ser corregidos"                 │    y elevar la calidad"                │
│                                    │                                        │
│   ┌────────────────────────────────┴────────────────────────────────┐      │
│   │                                                                  │      │
│   │          CONSTRUCTIVAS              │         ANALÍTICAS         │      │
│   │                                     │                            │      │
│   ├─────────────┬───────────────────────┼──────────────┬─────────────┤      │
│   │  TÉCNICAS   │   ORGANIZATIVAS       │  ESTÁTICAS   │  DINÁMICAS  │      │
│   ├─────────────┼───────────────────────┼──────────────┼─────────────┤      │
│   │             │                       │              │             │      │
│   │ • Métodos   │ • Directrices         │ • Revisiones │ • Pruebas   │      │
│   │ • Plantillas│ • Estándares          │ • Análisis   │   Caja      │      │
│   │ • Herram.   │ • Checklists          │   de código  │   Blanca    │      │
│   │   de diseño │ • Guías de estilo     │ • Análisis   │ • Pruebas   │      │
│   │ • Patrones  │ • Procesos definidos  │   de flujo   │   Caja      │      │
│   │             │                       │ • Inspección │   Negra     │      │
│   │             │                       │              │ • Basadas   │      │
│   │             │                       │              │   en exp.   │      │
│   └─────────────┴───────────────────────┴──────────────┴─────────────┘      │
│                                                                             │
│   ─────────────────────────────────────────────────────────────────────     │
│   PREVENCIÓN (antes de crear)          DETECCIÓN (después de crear)         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Medidas PROACTIVAS (Constructivas):** Buscan **evitar** que los errores se introduzcan.
- **Técnicas:** Uso de métodos, plantillas, herramientas y patrones de diseño probados.
- **Organizativas:** Establecimiento de directrices, estándares de codificación, checklists (listas de verificación) y procesos.

**Medidas REACTIVAS (Analíticas):** Buscan **detectar** los errores ya introducidos.
- **Estáticas:** Revisiones, análisis de código, análisis de flujo (sin ejecutar el software).
- **Dinámicas:** Pruebas de caja blanca, caja negra y basadas en experiencia (ejecutando el software).

> 💡 **Clave:** Un buen programa de calidad combina **ambos enfoques**. Es más barato prevenir errores que encontrarlos y corregirlos después.

### 2.2.2 Tipos de Requisitos: Funcionales y No Funcionales

Ya sabemos CÓMO asegurar la calidad (QA/QC, medidas proactivas/reactivas). Ahora debemos entender QUÉ aspectos del software debemos verificar. Los requisitos de un sistema se dividen en dos grandes categorías:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              TIPOS DE REQUISITOS                                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   REQUISITOS FUNCIONALES              REQUISITOS NO FUNCIONALES             │
│   ──────────────────────              ─────────────────────────             │
│                                                                             │
│   ¿QUÉ hace el sistema?               ¿CÓMO lo hace? ¿CON QUÉ CALIDAD?      │
│                                                                             │
│   Describen COMPORTAMIENTO            Describen ATRIBUTOS DE CALIDAD        │
│   y FUNCIONES                         y RESTRICCIONES                       │
│                                                                             │
│   Ejemplos:                           Ejemplos:                             │
│   • El sistema permite login          • Tiempo de respuesta < 2 seg         │
│   • Calcular total del carrito        • Disponibilidad 99.9%                │
│   • Enviar email de confirmación      • Soportar 5.000 usuarios             │
│   • Generar factura PDF               • Datos encriptados                   │
│   • Buscar productos por nombre       • Interfaz en 3 idiomas               │
│                                                                             │
│   Se prueban verificando que          Se prueban midiendo MÉTRICAS          │
│   la SALIDA es correcta               contra UMBRALES definidos             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Requisitos Funcionales:**
- Definen **qué debe hacer** el sistema
- Son las funciones, operaciones y servicios que el sistema ofrece
- Responden a la pregunta: *"¿Qué hace el sistema cuando...?"*
- Ejemplo: *"El usuario puede añadir productos al carrito de compra"*

**Requisitos No Funcionales:**
- Definen **cómo debe comportarse** el sistema
- Son restricciones y atributos de calidad
- Responden a la pregunta: *"¿Con qué nivel de calidad lo hace?"*
- Ejemplo: *"La página debe cargar en menos de 2 segundos"*

#### Relación con ISO/IEC 25010

Las **8 características de calidad** que vimos en la sección 2.1.3 corresponden principalmente a **requisitos no funcionales**:

| Característica ISO 25010 | Tipo de Requisito | Ejemplo |
|-------------------------|-------------------|----------|
| **Adecuación Funcional** | Funcional | "El sistema calcula correctamente el IVA" |
| **Eficiencia de Rendimiento** | No Funcional | "Respuesta en menos de 2 segundos" |
| **Compatibilidad** | No Funcional | "Compatible con Chrome, Firefox y Edge" |
| **Usabilidad** | No Funcional | "Un usuario nuevo completa el registro en < 3 min" |
| **Fiabilidad** | No Funcional | "Disponibilidad del 99.9%" |
| **Seguridad** | No Funcional | "Contraseñas encriptadas con bcrypt" |
| **Mantenibilidad** | No Funcional | "Cobertura de tests > 80%" |
| **Portabilidad** | No Funcional | "Desplegable en AWS, Azure o Google Cloud" |

> 💡 **Nota:** La **Adecuación Funcional** es la única característica que evalúa requisitos funcionales. Las otras 7 evalúan aspectos no funcionales.

#### ¿Por qué es importante esta distinción?

1. **Diferentes técnicas de prueba:** Los requisitos funcionales se prueban verificando entradas/salidas. Los no funcionales requieren herramientas específicas (load testing, security scanning, etc.)

2. **Diferente momento de prueba:** Los funcionales se pueden probar desde las primeras fases. Algunos no funcionales (como rendimiento bajo carga) solo se pueden probar con el sistema completo.

3. **Diferente definición de "éxito":** Un requisito funcional pasa o falla. Un requisito no funcional se mide contra un umbral (ej: "<2 seg" o "99.9% disponibilidad").

> ⚠️ **Problema común:** Los requisitos no funcionales a menudo se dan de manera **implícita** o con definiciones vagas como "el sistema debe ser rápido". Un buen tester debe exigir criterios medibles.

---

## 2.3 El Coste de la Calidad

Tanto las actividades de QA (prevención) como las de QC (detección) requieren inversión. Pero, ¿vale la pena invertir en calidad? Para responder, necesitamos entender los diferentes tipos de costes asociados.

### 2.3.1 Tipos de Costes

**1. Costes de Prevención (QA)**
- Formación del equipo
- Definición de procesos
- Herramientas de desarrollo
- Planificación de calidad

**2. Costes de Evaluación (QC)**
- Ejecución de pruebas
- Revisiones de código
- Auditorías
- Entornos de prueba

**3. Costes de Fallos Internos**
- Corrección de defectos antes de producción
- Re-testing
- Retrabajo

**4. Costes de Fallos Externos**
- Corrección de defectos en producción
- Soporte al cliente
- Compensaciones
- Daño reputacional

### 2.3.2 El ROI del Testing

**Ejemplo práctico:**

Una empresa invierte 25.000€ en testing. Gracias a las pruebas, se detectaron defectos que en producción habrían causado:
- Pérdidas de ventas: 80.000€
- Compensaciones: 20.000€
- Corrección de emergencia: 30.000€
- **Total evitado: 130.000€**

```
ROI = (Beneficio - Inversión) / Inversión × 100
ROI = (130.000 - 25.000) / 25.000 × 100
ROI = 420%
```

Por cada euro invertido en testing, se ahorraron 4,20€.

---

## 2.4 Ejercicios del Módulo 2 - CON SOLUCIONES

---

**EJERCICIO 1:**
Un sistema tiene los siguientes requisitos no funcionales:
- "El sistema debe estar disponible 99.9% del tiempo"
- "Las páginas deben cargar en menos de 2 segundos"
- "El sistema debe soportar 5.000 usuarios concurrentes"

¿A qué característica de calidad del modelo ISO/IEC 25010 corresponde cada uno?

**✅ SOLUCIÓN:**

1. **"El sistema debe estar disponible 99.9% del tiempo"**
   → **FIABILIDAD** (subcaracterística: Disponibilidad)
   
   La disponibilidad mide el porcentaje de tiempo que el sistema está operativo y accesible cuando se necesita.

2. **"Las páginas deben cargar en menos de 2 segundos"**
   → **EFICIENCIA DE RENDIMIENTO** (subcaracterística: Comportamiento temporal)
   
   El comportamiento temporal se refiere a los tiempos de respuesta y procesamiento del sistema.

3. **"El sistema debe soportar 5.000 usuarios concurrentes"**
   → **EFICIENCIA DE RENDIMIENTO** (subcaracterística: Capacidad)
   
   La capacidad se refiere a los límites máximos que puede manejar el sistema (usuarios, transacciones, datos, etc.).

---

**EJERCICIO 2:**
Clasifica las siguientes acciones como **QA (Aseguramiento)** o **QC (Control)**:

a) Formar al equipo en buenas prácticas de programación
b) Ejecutar pruebas automatizadas cada noche
c) Definir estándares de codificación
d) Revisar el código de un compañero
e) Realizar pruebas exploratorias
f) Implementar pair programming

**✅ SOLUCIÓN:**

a) **QA** - La formación es una actividad preventiva que mejora las habilidades del equipo para evitar que cometan errores.

b) **QC** - La ejecución de pruebas es una actividad de detección que busca encontrar defectos en el producto ya construido.

c) **QA** - Definir estándares es preventivo, establece reglas para que el código se escriba correctamente desde el principio.

d) **QC** - La revisión de código es detección, se buscan defectos en código ya escrito.

e) **QC** - Las pruebas exploratorias buscan encontrar defectos en el producto existente.

f) **QA** - El pair programming es preventivo, dos personas trabajando juntas previenen errores en tiempo real.

---

# MÓDULO 3: EL TESTING EN EL CICLO DE VIDA DEL SOFTWARE

Ya sabemos qué es la calidad y por qué es importante invertir en ella. Pero, **¿cuándo y cómo debemos realizar el testing?** La respuesta depende del modelo de desarrollo que utilicemos. En este módulo veremos cómo el testing se integra de forma diferente según la metodología elegida.

## 3.1 Modelos de Desarrollo de Software

El modelo de desarrollo determina cuándo se realizan las pruebas, quién las hace y con qué intensidad. Veamos los principales modelos y cómo afectan al testing.

### 3.1.1 Modelo en Cascada (Waterfall)

**Descripción:** Las fases del desarrollo se ejecutan de forma secuencial, una tras otra.

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
│   │     PRUEBAS      │  ← Testing al final                                  │
│   └────────┬─────────┘                                                      │
│            │                                                                │
│            ▼                                                                │
│   ┌──────────────────┐                                                      │
│   │  MANTENIMIENTO   │                                                      │
│   └──────────────────┘                                                      │
│                                                                             │
│   Características:                                                          │
│   • Fases secuenciales                                                      │
│   • Documentación extensa                                                   │
│   • Testing concentrado al final                                            │
│   • Difícil volver atrás                                                    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Ventajas:**
- Claro y fácil de entender
- Bien definido, fácil de gestionar
- Funciona para requisitos muy estables

**Desventajas:**
- Testing muy tardío
- Poca flexibilidad ante cambios
- El cliente ve el producto muy tarde

### 3.1.2 Modelo en V

**Descripción:** Extensión del cascada que enfatiza la relación entre fases de desarrollo y niveles de prueba.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           MODELO EN V                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   VERIFICACIÓN                                        VALIDACIÓN            │
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
│                    \──► CODIFICACIÓN ◄───/                                  │
│                                                                             │
│   Beneficios:                                                               │
│   • Las pruebas se planifican en paralelo al desarrollo                    │
│   • Clara trazabilidad entre fases                                          │
│   • Cada nivel de prueba valida un nivel de diseño                         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.1.3 Desarrollo Iterativo e Incremental y Metodologías Ágiles (Scrum)

**Concepto base - Iterativo e Incremental:** El software se desarrolla a través de ciclos repetidos (iteraciones), cada uno produciendo un incremento funcional. Este enfoque surgió en los años 80 como alternativa al modelo en cascada.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DESARROLLO ITERATIVO E INCREMENTAL                       │
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
│   • El testing ocurre en cada iteración                                     │
│   • Feedback (retroalimentación) rápido y adaptación continua               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Scrum - La implementación más popular:** Scrum es una metodología ágil específica que implementa el enfoque iterativo/incremental con reglas concretas. Es como la diferencia entre "transporte con motor" (concepto) y "Toyota Corolla" (implementación específica).

> 💡 **Nota:** Existen otras metodologías iterativas además de Scrum: XP (Extreme Programming), Kanban, RUP (Rational Unified Process), etc. Scrum es simplemente la más extendida.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    SCRUM: TESTING EN LA PRÁCTICA                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   SPRINT (2-4 semanas)                                                      │
│   ┌─────────────────────────────────────────────────────────────┐          │
│   │                                                             │          │
│   │  Sprint    Daily     Desarrollo + Testing      Sprint       │          │
│   │  Planning  Standups  continuo                  Review       │          │
│   │     │         │           │                       │         │          │
│   │     ▼         ▼           ▼                       ▼         │          │
│   │  ┌────┐   ┌────────────────────────────────┐   ┌────┐      │          │
│   │  │PLAN│──►│  DESARROLLO + TESTING INTEGRADO │──►│DEMO│      │          │
│   │  └────┘   └────────────────────────────────┘   └────┘      │          │
│   │                         │                                   │          │
│   │                         ▼                                   │          │
│   │              INCREMENTO POTENCIALMENTE                      │          │
│   │                   ENTREGABLE                                │          │
│   └─────────────────────────────────────────────────────────────┘          │
│                                                                             │
│   Características del testing en Scrum:                                     │
│   • El testing es parte del Definition of Done (criterio de "terminado")   │
│   • No hay fase separada de testing                                         │
│   • Tester integrado en el equipo                                           │
│   • Automatización casi obligatoria                                         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.1.4 DevOps e Integración/Despliegue Continuos (CI/CD)

**¿Qué problema resuelve DevOps?**

Tradicionalmente existía una barrera entre los equipos de desarrollo (Dev) y operaciones (Ops):
- **Desarrolladores:** "¡Funciona en mi máquina!"
- **Operaciones:** "¡Esto no funciona en producción!"

**DevOps** es una **cultura y conjunto de prácticas** que elimina esta barrera, haciendo que un mismo equipo sea responsable de todo el ciclo de vida del software: desde escribir el código hasta mantenerlo en producción.

**CI/CD son las prácticas técnicas que lo hacen posible:**

| Sigla | Nombre completo | Qué significa |
|-------|-----------------|---------------|
| **CI** | Continuous Integration (Integración Continua) | Cada vez que alguien sube código, se compila y ejecutan pruebas automáticamente |
| **CD** | Continuous Delivery (Entrega Continua) | El código probado está siempre listo para desplegar con un clic |
| **CD** | Continuous Deployment (Despliegue Continuo) | El código se despliega automáticamente a producción sin intervención humana |

```
┌─────────────────────────────────────────────────────────────────────────────┐
│            PIPELINE CI/CD (Integración Continua / Despliegue Continuo)      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   El desarrollador sube código y automáticamente se ejecuta:                │
│                                                                             │
│   CODE ──► BUILD ──► TEST ──► RELEASE ──► DEPLOY ──► MONITOR               │
│   (subir)  (compilar) (probar) (empaquetar) (desplegar) (vigilar)          │
│                        │                               │                    │
│                        ▼                               ▼                    │
│               ┌────────────────┐            ┌──────────────────┐           │
│               │ Pruebas Auto   │            │ Monitorización   │           │
│               │ • Unitarias    │            │ • Logs           │           │
│               │ • Integración  │            │ • Métricas       │           │
│               │ • E2E (End to │            │ • Alertas        │           │
│               │   End, punta  │            │ • A/B Testing    │           │
│               │   a punta)    │            │ • Canary release │           │
│               │ • Rendimiento  │            │   (despliegue   │           │
│               │ • Seguridad    │            │   gradual)      │           │
│               └────────────────┘            └──────────────────┘           │
│                                                                             │
│   🔧 Herramientas que usaremos: Postman (APIs), utPLSQL (BD), HammerDB    │
│                                                                             │
│   Si las pruebas FALLAN → El código NO avanza → Feedback inmediato         │
│   Si las pruebas PASAN → El código avanza automáticamente                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**¿Por qué es revolucionario para el testing?**
- Las pruebas son **obligatorias**: sin ellas, el código no puede avanzar
- **Feedback en minutos**: sabes inmediatamente si rompiste algo
- **Automatización total**: no hay excusa para no probar
- **Testing en producción**: con técnicas como canary releases (desplegar solo al 5% de usuarios primero)

### 3.1.5 Comparativa de Modelos y Testing

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              COMPARATIVA: TESTING EN DIFERENTES MODELOS                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Aspecto          Cascada    Modelo V    Ágil/Scrum   DevOps/CI-CD         │
│  ───────          ───────    ────────    ──────────   ────────────         │
│                                                                             │
│  Cuándo se        Al final   En paralelo  Cada         Siempre             │
│  planifica                   al diseño    Sprint       (automatizado)      │
│  testing                                                                    │
│                                                                             │
│  Cuándo se        Al final   Al final     Continuo     Continuo            │
│  ejecuta                     (pero mejor  (cada día)   (cada commit)       │
│  testing                     preparado)                                     │
│                                                                             │
│  Documentación    Extensa    Extensa      Mínima       Código = Doc        │
│                                                                             │
│  Automatización   Opcional   Recomendada  Importante   Obligatoria         │
│                                                                             │
│  Feedback         Muy tardío Tardío       Frecuente    Inmediato           │
│  (semanas/meses)  (semanas)  (días)       (minutos)                        │
│                                                                             │
│  Coste de cambio  Muy alto   Alto         Bajo         Muy bajo            │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**¿Qué modelo es mejor?** Depende del contexto. No hay uno "mejor" universal:

| Modelo | Mejor para... | Evitar si... |
|--------|---------------|--------------|
| **Cascada** | Requisitos muy estables, contratos fijos, regulaciones estrictas | Hay incertidumbre, el cliente cambia de opinión |
| **Modelo en V** | Software crítico (médico, aeronáutico), necesitas trazabilidad total | Necesitas flexibilidad y entregas rápidas |
| **Ágil (Scrum)** | Requisitos cambiantes, feedback frecuente, startups, MVP (Minimum Viable Product - producto mínimo viable) | Cliente no disponible, equipo no preparado |
| **DevOps/CI-CD** | Entregas continuas, SaaS (Software as a Service -software en la nube-), web apps, apps móviles | Entornos muy regulados sin posibilidad de automatizar, equipos muy pequeños sin infraestructura |

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ¿QUÉ MODELO ELEGIR?                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ¿Los requisitos están claros y no van a cambiar?                          │
│      │                                                                      │
│      ├── SÍ ──► ¿Es software crítico (vidas en juego)?                      │
│      │              │                                                       │
│      │              ├── SÍ ──► MODELO EN V                                  │
│      │              │                                                       │
│      │              └── NO ──► CASCADA                                      │
│      │                                                                      │
│      └── NO ──► ¿El cliente puede dar feedback frecuente?                   │
│                     │                                                       │
│                     ├── SÍ ──► ¿Necesitas desplegar muy frecuentemente?     │
│                     │              │                                        │
│                     │              ├── SÍ ──► DEVOPS / CI-CD                │
│                     │              │                                        │
│                     │              └── NO ──► ÁGIL (SCRUM)                  │
│                     │                                                       │
│                     └── NO ──► ÁGIL (con iteraciones más largas)            │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Ejemplos reales:**

| Proyecto | Modelo recomendado | Por qué |
|----------|-------------------|---------|
| App de banco con regulación estricta | **Modelo en V** | Trazabilidad, auditorías, seguridad crítica |
| Startup con MVP | **Ágil/Scrum** | Requisitos cambiantes, pivotar rápido |
| Software de marcapasos | **Modelo en V** | Vidas en juego, certificaciones |
| Web de e-commerce (Amazon, eBay) | **DevOps/CI-CD** | Despliegues frecuentes, A/B testing |
| Proyecto con contrato cerrado | **Cascada** | Alcance fijo, precio fijo |
| App móvil (Instagram, TikTok) | **DevOps/CI-CD** | Actualizaciones continuas, millones de usuarios |
| Netflix, Spotify | **DevOps/CI-CD** | Miles de despliegues al día |
| Juego móvil | **Ágil/Scrum** | Feedback de usuarios, iteraciones rápidas |

---

## 3.2 Niveles de Prueba

Independientemente del modelo de desarrollo elegido, las pruebas se organizan en **niveles** según el alcance de lo que se prueba. Cada nivel tiene un objetivo diferente y encuentra tipos de defectos distintos. Estos niveles forman una pirámide donde cada uno construye sobre el anterior.

### 3.2.1 Nivel 1: Pruebas Unitarias (o de Componente)

**Definición:** Verifican el funcionamiento correcto de las unidades más pequeñas de código de forma aislada.

| Aspecto | Descripción |
|---------|-------------|
| **¿Qué se prueba?** | Una función, método o clase individual |
| **¿Quién las hace?** | Normalmente los desarrolladores |
| **¿Cuándo?** | Durante y justo después de codificar |
| **Técnicas** | Principalmente caja blanca |
| **Automatización** | Casi siempre automatizadas |

> 🔧 **Herramienta práctica:** Para pruebas unitarias en bases de datos Oracle, utilizaremos **utPLSQL**, un framework que permite escribir y ejecutar tests directamente en PL/SQL.

**Ejemplo de prueba unitaria:**
```python
def calcular_descuento(precio, porcentaje):
    if precio < 0:
        raise ValueError("El precio no puede ser negativo")
    if porcentaje < 0 or porcentaje > 100:
        raise ValueError("El porcentaje debe estar entre 0 y 100")
    return precio - (precio * porcentaje / 100)

# Pruebas unitarias
def test_descuento_normal():
    assert calcular_descuento(100, 20) == 80

def test_sin_descuento():
    assert calcular_descuento(100, 0) == 100

def test_precio_negativo():
    with pytest.raises(ValueError):
        calcular_descuento(-50, 20)
```

**Mocks y Stubs (objetos simulados):** Para aislar la unidad de sus dependencias:
- **Stub (sustituto):** Proporciona respuestas predefinidas
- **Mock (simulacro):** Además verifica que se llamó correctamente

### 3.2.2 Nivel 2: Pruebas de Integración

**Definición:** Verifican la comunicación e interacción correcta entre componentes que ya han sido probados individualmente.

| Aspecto | Descripción |
|---------|-------------|
| **¿Qué se prueba?** | Interfaces entre componentes |
| **¿Quién las hace?** | Desarrolladores o testers técnicos |
| **¿Cuándo?** | Después de las pruebas unitarias |
| **Objetivo** | Detectar problemas de comunicación |

> 🔧 **Herramienta práctica:** **Postman** es ideal para probar la integración entre componentes a través de APIs REST. Permite verificar que los servicios se comunican correctamente.

**Problemas típicos de integración:**
- Formato de datos incompatible
- Orden de parámetros diferente
- Unidades diferentes (metros vs pies)
- Manejo diferente de nulos
- Timeouts y tiempos de espera

#### Conceptos clave: Stubs y Drivers

Cuando integramos módulos, algunos pueden no estar disponibles todavía. Necesitamos **componentes simulados**:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    STUBS vs DRIVERS                                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   DRIVER (Controlador)                STUB (Sustituto)                      │
│   ────────────────────                ────────────────                      │
│                                                                             │
│   Simula un módulo SUPERIOR           Simula un módulo INFERIOR             │
│   que LLAMA al módulo bajo prueba     que ES LLAMADO por el módulo          │
│                                                                             │
│        ┌─────────┐                         ┌─────────┐                      │
│        │ DRIVER  │ (simula GUI)            │ Módulo  │                      │
│        └────┬────┘                         │  real   │                      │
│             │ llama                        └────┬────┘                      │
│             ▼                                   │ llama                     │
│        ┌─────────┐                              ▼                           │
│        │ Módulo  │                         ┌─────────┐                      │
│        │  real   │                         │  STUB   │ (simula BD)          │
│        └─────────┘                         └─────────┘                      │
│                                                                             │
│   Usado en: BOTTOM-UP                  Usado en: TOP-DOWN                   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Ejemplo práctico:**
- **Stub:** Probamos el módulo de "Carrito" pero la "Base de Datos" no está lista → Creamos un stub que devuelve productos ficticios
- **Driver:** Probamos el módulo "Calculadora de IVA" pero la "Interfaz de Usuario" no está lista → Creamos un driver que llama a la calculadora con valores de prueba

#### Estrategias de Integración

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ESTRATEGIAS DE INTEGRACIÓN                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  1. BIG BANG (Todo de golpe)                                                │
│     ├── Se integran TODOS los componentes a la vez                          │
│     ├── ✅ Simple, sin stubs ni drivers                                     │
│     └── ❌ Muy difícil localizar errores, mucho "tiempo muerto"             │
│                                                                             │
│  2. TOP-DOWN (Arriba → Abajo)                                               │
│     ├── Empezar por módulos de nivel superior (GUI, menú principal)         │
│     ├── Usar STUBS para simular módulos inferiores                          │
│     ├── ✅ Prueba temprana del flujo principal, detecta errores de diseño   │
│     └── ❌ Necesita muchos stubs, lógica de negocio se prueba tarde         │
│                                                                             │
│  3. BOTTOM-UP (Abajo → Arriba)                                              │
│     ├── Empezar por módulos de nivel inferior (BD, cálculos)                │
│     ├── Usar DRIVERS para invocar los módulos bajo prueba                   │
│     ├── ✅ Módulos base muy bien probados, sin stubs complejos              │
│     └── ❌ La interfaz de usuario se prueba tarde                           │
│                                                                             │
│  4. SANDWICH / HÍBRIDA                                                      │
│     ├── Combinar Top-Down y Bottom-Up simultáneamente                       │
│     ├── Un equipo desde arriba, otro desde abajo                            │
│     ├── ✅ Más rápido, aprovecha ventajas de ambos                          │
│     └── ❌ Requiere más coordinación                                        │
│                                                                             │
│  5. AD-HOC (Según disponibilidad)                                           │
│     ├── Integrar cada componente cuando esté listo                          │
│     ├── ✅ Sin tiempos muertos, desarrollo ágil                             │
│     └── ❌ Puede necesitar stubs y drivers según el caso                    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Visualización: Top-Down vs Bottom-Up

```
                    TOP-DOWN                           BOTTOM-UP
                    ────────                           ─────────
                                                       
    Paso 1:         [GUI]                              [GUI]           Paso 4
                      │                                  ▲
                      ▼                                  │
    Paso 2:     [Controlador]                      [Controlador]       Paso 3
                   /     \                            /     \
                  ▼       ▼                          ▲       ▲
    Paso 3:  [Servicio] [Servicio]              [Servicio] [Servicio]  Paso 2
                  │       │                          │       │
                  ▼       ▼                          ▲       ▲
    Paso 4:    [BD]     [API]                      [BD]     [API]      Paso 1
                                                   
               ↓ Flujo de                         ↑ Flujo de
               integración                        integración
               
               Usa STUBS                          Usa DRIVERS
               (simula lo de abajo)               (simula lo de arriba)
```

**Explicación de los componentes de la arquitectura:**

- **GUI (Graphical User Interface):** La interfaz gráfica que ve el usuario (páginas web, ventanas, formularios). Es la "cara" de la aplicación.
- **Controlador:** Recibe las peticiones del usuario desde la GUI, las procesa y decide qué hacer. Coordina el flujo de la aplicación.
- **Servicio:** Contiene la lógica de negocio (cálculos, validaciones, reglas). Es donde está la "inteligencia" de la aplicación.
- **BD (Base de Datos):** Almacena y recupera datos de forma persistente.
- **API (Application Programming Interface):** Interfaz para comunicarse con sistemas externos (servicios de terceros, otras aplicaciones).

**Las flechas representan las llamadas entre componentes:** La GUI llama al Controlador → el Controlador llama a los Servicios → los Servicios acceden a la BD o llaman a APIs externas.

**¿Cuándo se usan STUBS y DRIVERS?** Solo cuando **no está todo implementado todavía**:
- **Top-Down:** Si empiezas probando la GUI pero los servicios/BD aún no están desarrollados, usas **STUBS** para simular esas partes inferiores.
- **Bottom-Up:** Si empiezas probando la BD/servicios pero la GUI/controlador aún no existen, usas **DRIVERS** para simular las llamadas desde arriba.
- **Si todo está implementado:** No necesitas simular nada, pruebas la integración real directamente.

#### ¿Qué estrategia elegir?

| Situación | Estrategia recomendada | Razón |
|-----------|------------------------|-------|
| Proyecto pequeño, evolutivo | Big Bang | Simple, sin STUBS/DRIVERS ni coordinación |
| Interfaz de usuario prioritaria | Top-Down | Permite demos tempranas |
| Lógica de negocio crítica | Bottom-Up | Asegura cálculos correctos |
| Equipos grandes distribuidos | Bottom-Up o Híbrida | Trabajo paralelo |
| Software de terceros/Frameworks | Top-Down | Integración con código ajeno |
| Desarrollo ágil, sprints cortos | Ad-Hoc | Sin tiempos muertos |
| Proyecto con alto riesgo | Híbrida | Equilibra velocidad y calidad |

> 💡 **Consejo estratégico:** Lo ideal es **adaptar la estrategia** para optimizar riesgos o recursos:
> - **Estrategias mixtas:** Un equipo puede usar Top-Down (empezando por la GUI), mientras otros equipos usan Bottom-Up
> - **Combinar con fechas de desarrollo:** Adaptar la estrategia según las fechas previstas de finalización de cada módulo
> - **Priorizar interfaces críticas:** Integrar primero los módulos con interfaces más complejas o críticas

#### Ejemplo de Integración: E-commerce

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

Pruebas de integración a verificar:
1. Carrito → Base de Datos (¿guarda correctamente los productos?)
2. Carrito → Pagos (¿pasa correctamente el total?)
3. Pagos → Pasarela (¿se comunica correctamente con el banco?)
4. Pagos → Envíos (¿inicia el envío tras pago exitoso?)
5. Envíos → API transportista (¿obtiene tracking correctamente?)
```

### 3.2.3 Nivel 3: Pruebas de Sistema

**Definición:** Comprobación del **sistema integrado completo** respecto del cumplimiento de los requisitos específicos.

Desde el **punto de vista técnico**: ya se han probado todos los componentes y su interrelación.

Desde el **punto de vista del usuario**: se prueba el entorno, las funciones, la carga, etc.

| Aspecto | Descripción |
|---------|-------------|
| **¿Qué se prueba?** | El sistema completo end-to-end |
| **¿Quién las hace?** | Equipo de QA independiente |
| **¿Cuándo?** | Después de las pruebas de integración |
| **Técnicas** | Principalmente caja negra |
| **Entorno** | Debería corresponderse con el entorno de producción |

**¿Qué se prueba en las pruebas de sistema?**
- Implantación completa y correcta de los requisitos
- Implantación en el entorno real del sistema y con datos cercanos a la práctica
- Se omiten los controladores de pruebas y los stubs (todo es real)
- Todas las interfaces externas del sistema se probarán bajo condiciones de producción

> ⚠️ **Importante:** No suele ser buena idea lanzar pruebas en el entorno de producción:
> - Los errores surgidos pueden dañar el sistema productivo
> - El entorno del sistema está en movimiento (los datos, el estado de las aplicaciones…). Eso dificulta que las pruebas sean reproducibles.

#### Pruebas de Requisitos Funcionales

Como vimos en el Módulo 2 (sección 2.2.2), los requisitos funcionales definen **qué** hace el sistema. En las pruebas de sistema verificamos que todas las funciones especificadas se comportan correctamente.

Las pruebas de los requisitos funcionales pueden incluir:
1. **Pruebas basadas en riesgos y/o especificaciones de requisitos**: Los casos de prueba se deducen a partir de la definición de requisitos
2. **Pruebas basadas en procesos de negocio**: Los procesos de negocio individuales sirven como base para la creación de casos de prueba
3. **Pruebas basadas en casos de uso**: Los casos de prueba se deducen a partir de los casos de uso (procesos habituales del usuario)
4. **Cualquier otra descripción de alto nivel** del comportamiento del sistema

#### Pruebas de Requisitos No Funcionales

Como vimos en el Módulo 2 (sección 2.2.2), los requisitos no funcionales definen **cómo** debe comportarse el sistema y se relacionan con las características de calidad de ISO 25010. En las pruebas de sistema es donde verificamos su cumplimiento, aunque presentan desafíos específicos.

**Problemas comunes:**
- En la definición de requisitos no siempre está claro "cómo de bien" debe funcionar algo
- A menudo definiciones vagas: "manejar sin problemas", "pantallas claras"
- Los requisitos no funcionales se dan a menudo de manera **implícita** y por este motivo no se definen

**La prueba de un requisito no funcional se da como superada si se consigue un determinado valor en una métrica establecida:**
- **MTBF** (Mean Time Between Failures - Tiempo medio entre fallos)
- **MTTR** (Mean Time To Repair - Tiempo medio de reparación)

**Las pruebas no funcionales incluyen** (pero no están limitadas a):
- Pruebas de **prestaciones** (rendimiento)
- Pruebas de **carga**
- Pruebas de **estrés**
- Pruebas de **usabilidad**
- Pruebas de **mantenibilidad**
- Pruebas de **fiabilidad**
- Pruebas de **portabilidad**

> 🔧 **Herramienta práctica:** Para pruebas de rendimiento en bases de datos utilizaremos **HammerDB**, que permite simular cargas de trabajo realistas y medir tiempos de respuesta.

> 📈 **Las Pruebas de sistema deben estudiar los requisitos funcionales y no funcionales del sistema, así como las características de calidad de los datos.**

### 3.2.4 Nivel 4: Pruebas de Aceptación

**Definición:** Las pruebas de aceptación comprueban el producto desde el **punto de vista del usuario o del cliente** antes de su paso a producción. La pregunta clave es: **¿Se cumplen las expectativas del usuario/cliente?**

| Aspecto | Descripción |
|---------|-------------|
| **¿Qué se prueba?** | Valor de negocio, expectativas del usuario |
| **¿Quién las hace?** | Usuarios, clientes, Product Owner |
| **¿Cuándo?** | Última fase antes de producción |
| **Entorno** | Producción o pre-producción |

**Involucración del usuario según el tipo de software:**

La involucración del usuario varía según el grado de personalización del software:

| Tipo de Software | Involucración del Usuario |
|-----------------|---------------------------|
| **Software personalizado** | El software será probado directamente por el solicitante o cliente |
| **Productos "de masas"** | El software será probado por una selección representativa de usuarios |

> 💡 **Recomendación:** El usuario debería estar involucrado **desde el principio del proyecto**: aceptación de requisitos, validación de prototipos, revisión de diseños, etc. No dejes la validación con usuarios para el final.

**Tipos de pruebas de aceptación:**

| Tipo | Objetivo | Quién |
|------|----------|-------|
| **UAT** (User Acceptance Testing - Pruebas de aceptación de usuario) | Usuarios pueden hacer su trabajo | Usuarios finales |
| **BAT** (Business Acceptance Testing - Pruebas de aceptación de negocio) | Cumple objetivos de negocio | Stakeholders (partes interesadas) |
| **OAT** (Operational Acceptance Testing - Pruebas de aceptación operativa) | Se puede operar y mantener | Equipo de operaciones |
| **Alpha (alfa)** | Feedback (retroalimentación) interno | Empleados |
| **Beta** | Feedback externo | Usuarios seleccionados |
| **Contractual** | Cumple el contrato | Cliente |
| **Compliance** | Cumple regulaciones | Auditores |

### 3.2.5 Resumen de Niveles

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    RESUMEN: NIVELES DE PRUEBA                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  NIVEL           QUÉ                QUIÉN              DEFECTOS QUE ENCUENTRA│
│  ─────           ───                ─────              ─────────────────────│
│                                                                             │
│  Unitarias       Funciones,         Desarrolladores    Errores de lógica    │
│                  métodos                               en código            │
│                                                                             │
│  Integración     Interfaces         Desarrolladores    Problemas de         │
│                  entre módulos      o testers          comunicación         │
│                                                                             │
│  Sistema         Sistema            Equipo QA          Defectos en          │
│                  completo                              requisitos           │
│                                                                             │
│  Aceptación      Valor de           Usuarios,          Expectativas         │
│                  negocio            clientes           no cumplidas         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 3.3 Mantenimiento de las Pruebas

Hemos visto los niveles de prueba como si fueran un proceso lineal, pero en realidad el testing es **continuo**. El software evoluciona y las pruebas deben evolucionar con él. Este aspecto, a menudo olvidado, es crítico para mantener la efectividad del testing a lo largo del tiempo.

### 3.3.1 ¿Por qué es necesario el mantenimiento?

Las pruebas no son estáticas. El software evoluciona y las pruebas deben evolucionar con él:

**Causas de la necesidad de mantenimiento:**
- Cambios en requisitos
- Nuevas funcionalidades
- Corrección de defectos
- Cambios en el entorno
- Cambios en interfaces externas
- Obsolescencia de datos de prueba

### 3.3.2 Tipos de Mantenimiento de Pruebas

**1. Actualización por cambios funcionales**
- Nuevas funcionalidades requieren nuevos casos
- Funcionalidades modificadas requieren actualización de casos existentes
- Funcionalidades eliminadas requieren eliminar casos obsoletos

**2. Actualización por corrección de defectos**
- Añadir caso de prueba que detecte el defecto corregido
- Prevenir regresiones futuras

**3. Actualización por cambios de entorno**
- Nueva versión de navegador
- Nueva versión de base de datos
- Nuevo sistema operativo
- Cambios en APIs externas

**4. Mejora continua**
- Optimización de casos lentos
- Reducción de casos redundantes
- Mejora de la cobertura
- Actualización de datos de prueba

### 3.3.3 Gestión de la Suite de Pruebas

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CICLO DE MANTENIMIENTO                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌─────────────┐     ┌─────────────┐     ┌─────────────┐                  │
│   │  REVISAR    │────►│  ACTUALIZAR │────►│  VALIDAR    │                  │
│   │  (Analizar  │     │  (Modificar,│     │  (Ejecutar, │                  │
│   │   cambios)  │     │   añadir,   │     │   verificar)│                  │
│   └──────┬──────┘     │   eliminar) │     └──────┬──────┘                  │
│          │            └─────────────┘            │                          │
│          │                                       │                          │
│          └───────────────────────────────────────┘                          │
│                         CICLO CONTINUO                                      │
│                                                                             │
│   Buenas prácticas:                                                         │
│   • Revisar casos obsoletos periódicamente                                  │
│   • Mantener trazabilidad con requisitos                                    │
│   • Documentar razones de cambios                                           │
│   • Versionar los casos de prueba                                           │
│   • Automatizar lo que sea estable                                          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.3.4 Pruebas de Regresión en el Mantenimiento

Cada vez que el software cambia, existe el riesgo de romper algo que funcionaba. Las pruebas de regresión verifican que los cambios no han introducido defectos nuevos.

**Estrategias de regresión:**

| Estrategia | Descripción | Cuándo usar |
|------------|-------------|-------------|
| **Completa** | Ejecutar TODOS los casos | Cambios mayores, releases |
| **Selectiva** | Subconjunto basado en impacto | Cambios menores |
| **Priorizada** | Primero los más críticos | Tiempo limitado |
| **Automatizada** | Ejecutar suite automatizada | Integración continua |

---

## 3.4 Ejercicios del Módulo 3 - CON SOLUCIONES

---

**EJERCICIO 1:**
Para cada situación, indica qué nivel de prueba sería más apropiado:

a) Verificar que la función que calcula el IVA devuelve valores correctos
b) Comprobar que el módulo de facturación se comunica correctamente con el módulo de inventario
c) Verificar que un cliente puede completar todo el proceso de compra
d) El director financiero verifica que los informes muestran los datos que necesita
e) Los empleados del call center prueban el nuevo sistema de tickets

**✅ SOLUCIÓN:**

a) **PRUEBAS UNITARIAS** - Verificar una función individual (calcular_IVA) de forma aislada es exactamente el propósito de las pruebas unitarias.

b) **PRUEBAS DE INTEGRACIÓN** - Se verifica la comunicación entre dos módulos (facturación e inventario) que ya funcionan individualmente.

c) **PRUEBAS DE SISTEMA** - Un flujo completo end-to-end (búsqueda → carrito → pago → confirmación) es una prueba de sistema.

d) **PRUEBAS DE ACEPTACIÓN (BAT - Business Acceptance)** - El director (stakeholder de negocio) está validando que el sistema cumple sus necesidades de negocio.

e) **PRUEBAS DE ACEPTACIÓN (UAT - User Acceptance)** - Los usuarios finales (empleados de call center) validan que pueden hacer su trabajo con el sistema.

---

**EJERCICIO 2:**
Compara el modelo en cascada con el modelo ágil en términos de cuándo y cómo se realiza el testing. ¿Qué ventajas tiene cada enfoque?

**✅ SOLUCIÓN:**

| Aspecto | Cascada | Ágil |
|---------|---------|------|
| **Cuándo se planifica** | Al principio (plan global) | Continuo (cada sprint) |
| **Cuándo se ejecuta** | Al final del desarrollo | Continuo durante el desarrollo |
| **Quién hace testing** | Equipo QA separado | Tester integrado en el equipo |
| **Documentación** | Extensa y formal | Mínima, enfocada |
| **Automatización** | Opcional | Casi obligatoria |
| **Feedback** | Muy tardío | Muy frecuente |

**Ventajas del Cascada:**
- Planificación clara y predecible
- Documentación completa para proyectos complejos
- Adecuado cuando requisitos son muy estables y conocidos
- Fácil de gestionar y medir avance

**Ventajas del Ágil:**
- Feedback temprano y continuo
- Adaptación rápida a cambios
- Defectos encontrados y corregidos antes
- Cliente ve el producto desde el principio
- Menor coste de corrección de defectos

---

**EJERCICIO 3:**
Una empresa está desarrollando un software de gestión hospitalaria (crítico para la vida de los pacientes). ¿Qué modelo de desarrollo recomendarías y cómo debería ser el testing?

**✅ SOLUCIÓN:**

**Modelo recomendado:** **Modelo en V** o un **enfoque híbrido V + iterativo controlado**

**Justificación:**
- Es software **crítico para la vida** (safety-critical)
- Requiere **trazabilidad estricta** entre requisitos y pruebas
- Necesita **documentación exhaustiva** para auditorías y certificaciones
- Debe cumplir **regulaciones** médicas (FDA, CE, ISO 13485)

**Características del testing:**

1. **Planificación exhaustiva:**
   - Plan de pruebas formal desde el inicio
   - Análisis de riesgos detallado
   - Trazabilidad completa requisito → diseño → código → prueba

2. **Todos los niveles de prueba:**
   - Unitarias: Cobertura de código muy alta (>90%)
   - Integración: Verificar todas las interfaces críticas
   - Sistema: Pruebas funcionales, rendimiento, seguridad, recuperación
   - Aceptación: Con médicos y personal sanitario real

3. **Pruebas especiales:**
   - Pruebas de seguridad del paciente (failure modes)
   - Pruebas de recuperación ante fallos
   - Pruebas de integridad de datos
   - Pruebas de disponibilidad 24/7

4. **Proceso:**
   - Revisiones e inspecciones formales
   - Verificación y validación independiente
   - Gestión de configuración estricta
   - Documentación para auditoría

5. **Personal:**
   - Testers certificados
   - Equipo de QA independiente del desarrollo
   - Participación de expertos médicos

---

**EJERCICIO 4:**
Describe qué actividades de mantenimiento de pruebas serían necesarias en los siguientes escenarios:

a) Se añade un nuevo método de pago (Bizum) a una tienda online
b) Se detecta y corrige un bug en el cálculo de impuestos
c) El proveedor de la API de geolocalización cambia el formato de respuesta

**✅ SOLUCIÓN:**

**a) Nuevo método de pago (Bizum):**

1. **Crear nuevos casos de prueba:**
   - Pago exitoso con Bizum
   - Pago fallido (saldo insuficiente)
   - Timeout de la operación
   - Cancelación por el usuario

2. **Actualizar casos existentes:**
   - Caso de "selección de método de pago" debe incluir Bizum
   - Verificar que aparece en lista de métodos disponibles

3. **Pruebas de integración:**
   - Conexión con API de Bizum
   - Confirmación de pago
   - Manejo de errores

4. **Actualizar regresión:**
   - Verificar que métodos de pago existentes siguen funcionando
   - Añadir nuevos casos a la suite de regresión

**b) Bug corregido en cálculo de impuestos:**

1. **Crear caso de prueba específico:**
   - Caso que reproduce exactamente el bug corregido
   - Añadirlo a la suite de regresión permanente

2. **Revisar casos existentes:**
   - ¿Por qué los casos existentes no detectaron el bug?
   - Mejorar cobertura de casos de cálculo de impuestos

3. **Añadir valores límite:**
   - Si el bug era de límites, añadir más valores límite a probar

**c) Cambio en API de geolocalización:**

1. **Actualizar casos de integración:**
   - Adaptar datos esperados al nuevo formato de respuesta
   - Modificar parseo de respuestas en las pruebas

2. **Verificar código de adaptación:**
   - Si se creó una capa de adaptación, probarla exhaustivamente

3. **Pruebas de compatibilidad:**
   - Verificar funcionamiento en diferentes escenarios
   - Manejo de errores con nuevo formato

4. **Actualizar mocks/stubs:**
   - Los mocks de la API deben devolver el nuevo formato

---

# MÓDULO 4: TIPOS Y CLASIFICACIÓN DE PRUEBAS

Ya conocemos cuándo probar (modelos de desarrollo) y a qué nivel probar (unitarias, integración, sistema, aceptación). Ahora necesitamos responder: **¿qué tipos de pruebas existen y cuándo usar cada una?** Este módulo nos proporciona un mapa completo de las diferentes clasificaciones.

## 4.1 Clasificación General

Las pruebas se pueden clasificar según varios criterios ortogonales (una misma prueba puede pertenecer a varias categorías):

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CLASIFICACIÓN DE PRUEBAS                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Por EJECUCIÓN                    Por CONOCIMIENTO del código               │
│  ──────────────                   ───────────────────────────               │
│  • Estáticas (sin ejecutar)       • Caja Negra (sin ver código)             │
│  • Dinámicas (ejecutando)         • Caja Blanca (viendo código)             │
│                                   • Caja Gris (conocimiento parcial)        │
│                                                                             │
│  Por OBJETIVO                     Por AUTOMATIZACIÓN                        │
│  ────────────                     ──────────────────                        │
│  • Funcionales                    • Manuales                                │
│  • No Funcionales                 • Automatizadas                           │
│  • De Regresión                                                             │
│  • De Mantenimiento                                                         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 4.2 Pruebas Estáticas vs Dinámicas

### 4.2.1 Pruebas Estáticas

**Definición:** Se realizan **sin ejecutar** el software. Se analizan artefactos (código, documentos) mediante inspección o herramientas.

**Técnicas de pruebas estáticas:**

| Técnica | Formalidad | Descripción |
|---------|------------|-------------|
| **Revisión Informal** | Muy baja | Un compañero lee tu código |
| **Walkthrough (recorrido)** | Baja | El autor presenta y explica su trabajo |
| **Revisión Técnica** | Media | Checklist (lista de verificación), criterios definidos |
| **Inspección** | Alta | Proceso formal con roles definidos |
| **Análisis Estático** | Automatizada | Herramientas (linters, analizadores) |

**Ventajas:**
- Detección muy temprana
- No necesitan entorno de ejecución
- Encuentran defectos únicos (código muerto, estándares)

**Ejemplo de análisis estático:**
```java
// Un analizador estático detectaría:

public void procesarDatos(String entrada) {
    // WARNING: Posible NullPointerException
    int longitud = entrada.length();
    
    // WARNING: Recurso no cerrado
    FileInputStream file = new FileInputStream("datos.txt");
    
    // WARNING: SQL Injection
    String query = "SELECT * FROM users WHERE name = '" + entrada + "'";
}
```

> 🔒 **Práctica de seguridad:** Este ejemplo muestra una vulnerabilidad de **SQL Injection**. Practicaremos cómo detectar y explotar estas vulnerabilidades para aprender a prevenirlas.

### 4.2.2 Pruebas Dinámicas

**Definición:** Requieren **ejecutar** el software con datos de prueba y comparar resultados.

**Componentes de una prueba dinámica:**
1. **Precondiciones:** Estado inicial del sistema
2. **Datos de entrada:** Valores que se introducen
3. **Acción/Pasos:** Operaciones que se realizan
4. **Resultado esperado:** Lo que debería ocurrir
5. **Resultado obtenido:** Lo que realmente ocurre
6. **Veredicto:** PASA o FALLA

### 4.2.3 Comparación

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ESTÁTICA vs DINÁMICA                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   Característica          ESTÁTICA              DINÁMICA                    │
│   ──────────────          ────────              ────────                    │
│                                                                             │
│   ¿Ejecuta código?        No                    Sí                          │
│   ¿Cuándo se puede?       Muy temprano          Necesita código             │
│   ¿Qué encuentra?         Defectos en código    Fallos en comportamiento    │
│   ¿Necesita entorno?      No                    Sí                          │
│   Coste                   Bajo                  Medio-Alto                  │
│                                                                             │
│   AMBAS SON COMPLEMENTARIAS Y NECESARIAS                                    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 4.3 Pruebas de Caja Negra vs Caja Blanca

Otra clasificación fundamental es según el **conocimiento que tenemos del código interno**. Esta distinción determina qué técnicas de diseño de pruebas podemos aplicar y es ortogonal a la anterior (podemos hacer pruebas dinámicas de caja negra o de caja blanca).

### 4.3.1 Pruebas de Caja Negra (Black Box)

**Definición:** Pruebas basadas en requisitos y especificaciones, sin conocimiento del código interno.

**Características:**
- Se centran en QUÉ hace el sistema
- No requieren conocimientos de programación
- Verifican el comportamiento externo
- Las puede hacer alguien que no programó el sistema

**Ejemplo:**
```
Requisito: "El sistema debe mostrar error si el email no tiene formato válido"

Caso de prueba (Caja Negra):
- Entrada: "emailsinformato"
- Resultado esperado: Mensaje "Email no válido"
- No importa CÓMO lo valida internamente
```

### 4.3.2 Pruebas de Caja Blanca (White Box)

**Definición:** Pruebas basadas en el conocimiento del código, diseñadas para ejecutar caminos específicos.

**Características:**
- Se centran en CÓMO funciona internamente
- Requieren conocimientos de programación
- Buscan cobertura de código
- Las hace normalmente quien conoce el código

**Ejemplo:**
```python
def calcular_categoria(edad):
    if edad < 0:
        return "Error"
    elif edad < 18:
        return "Menor"
    elif edad < 65:
        return "Adulto"
    else:
        return "Senior"

# Pruebas de Caja Blanca (cubrir todas las ramas):
# edad = -1  → rama "Error"
# edad = 10  → rama "Menor"
# edad = 30  → rama "Adulto"
# edad = 70  → rama "Senior"
```

### 4.3.3 Caja Gris (Grey Box)

**Definición:** Combinación de ambas, con conocimiento parcial de la estructura interna.

**Ejemplo:** Conocer la estructura de la base de datos para diseñar mejores pruebas funcionales.

## 4.4 Pruebas Funcionales vs No Funcionales

La última clasificación importante es según el **objetivo de la prueba**: ¿verificamos QUÉ hace el sistema o CÓMO lo hace? Esta distinción es crucial porque un software puede funcionar correctamente pero ser lento, inseguro o difícil de usar.

### 4.4.1 Pruebas Funcionales

**Definición:** Verifican QUÉ hace el sistema (comportamiento según requisitos).

**Ejemplos:**
- ¿El sistema puede registrar usuarios?
- ¿El sistema calcula correctamente los impuestos?
- ¿El sistema envía notificaciones cuando corresponde?

### 4.4.2 Pruebas No Funcionales

**Definición:** Verifican CÓMO lo hace el sistema (atributos de calidad).

**Tipos principales:**

| Tipo | Pregunta | Ejemplos de requisitos |
|------|----------|------------------------|
| **Rendimiento** | ¿Qué tan rápido? | "Responder en < 2 segundos" |
| **Carga** | ¿Cuántos usuarios? | "Soportar 1000 usuarios" |
| **Estrés** | ¿Cuándo falla? | "Punto de ruptura" |
| **Seguridad** | ¿Es seguro? | "Datos cifrados" |
| **Usabilidad** | ¿Es fácil de usar? | "Completar compra en < 3 clics" |
| **Fiabilidad** | ¿Es estable? | "Disponible 99.9%" |
| **Portabilidad** | ¿Dónde funciona? | "Chrome, Firefox, Safari" |

> 🔧 **Herramientas prácticas:** Para pruebas de rendimiento, carga y estrés en bases de datos usaremos **HammerDB**. Para pruebas de seguridad, practicaremos técnicas de **SQL Injection**.

### 4.4.3 Comparación Visual

```
┌─────────────────────────────────────────────────────────────────────────────┐
│          FUNCIONALES vs NO FUNCIONALES                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  FUNCIONALES                          NO FUNCIONALES                        │
│  ────────────                         ──────────────                        │
│                                                                             │
│  • ¿QUÉ hace?                         • ¿CÓMO lo hace?                      │
│  • Comportamiento                     • Atributos de calidad                │
│  • Pass/Fail claro                    • Grados de cumplimiento              │
│                                                                             │
│  "Calcular el total"                  "Calcular en < 1 segundo"             │
│  "Enviar email"                       "Soportar 1000 usuarios"              │
│  "Validar tarjeta"                    "Proteger datos"                      │
│                                                                             │
│  AMBOS SON NECESARIOS PARA SOFTWARE DE CALIDAD                              │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 4.5 Otros Tipos de Pruebas Importantes

### 4.5.1 Re-Pruebas (Re-testing) y Pruebas de Regresión

Cuando se detecta un defecto y se corrige, son necesarios **dos tipos de pruebas** antes de dar por cerrado el bug:

#### 🔄 Re-Pruebas (Re-testing / Confirmation Testing)

**Re-testing** = Volver a ejecutar **exactamente los mismos casos de prueba** que detectaron el defecto original para **confirmar que la corrección funciona**.

**Características:**
- Es **obligatorio** tras cada corrección de bug
- Se ejecutan **solo** los casos que fallaron
- El objetivo es **confirmar** que el defecto ya no existe
- También llamado "Confirmation Testing" (Pruebas de Confirmación)

#### 🔍 Pruebas de Regresión

**Regresión** = Ejecutar un **conjunto amplio de casos de prueba** para verificar que la corrección **no ha roto ninguna otra funcionalidad** que antes funcionaba.

**Características:**
- Es **muy recomendable** (a veces obligatorio) tras cambios
- Se ejecutan **muchos** casos, no solo los relacionados con el bug
- El objetivo es **detectar efectos secundarios** de los cambios
- Ideal para **automatizar** (se ejecutan frecuentemente)

#### 📊 Comparativa Detallada

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    RE-TEST vs REGRESIÓN                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   RE-TEST (Re-prueba)                 REGRESIÓN                             │
│   ───────────────────                 ─────────                             │
│                                                                             │
│   Confirmar que el defecto            Verificar que el cambio no           │
│   específico está corregido           ha roto nada más                     │
│                                                                             │
│   Solo los casos que fallaron         Conjunto amplio de casos             │
│                                                                             │
│   Siempre OBLIGATORIO                 Muy RECOMENDABLE                     │
│   tras corrección                     (a veces obligatorio)                │
│                                                                             │
│   Ejecutado por QA que                Puede ser automatizado               │
│   reportó el bug                      o manual                             │
│                                                                             │
│   Responde: "¿Se arregló?"            Responde: "¿Rompimos algo?"          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### 🔄 Flujo de Trabajo Típico

```
  ┌─────────────────┐
  │  Bug detectado  │
  │  (TC-042 falla) │
  └────────┬────────┘
           ↓
  ┌─────────────────┐
  │  Se reporta el  │
  │  defecto (Jira) │
  └────────┬────────┘
           ↓
  ┌─────────────────┐
  │  Desarrollador  │
  │  corrige el bug │
  └────────┬────────┘
           ↓
  ┌─────────────────┐
  │   RE-TEST       │ ←── "¿TC-042 pasa ahora?"
  │   (obligatorio) │
  └────────┬────────┘
           ↓
       ¿Pasa?
      /      \
    Sí        No → Vuelve al desarrollador
     ↓
  ┌─────────────────┐
  │   REGRESIÓN     │ ←── "¿Lo demás sigue funcionando?"
  │   (recomendado) │
  └────────┬────────┘
           ↓
       ¿Todo OK?
      /      \
    Sí        No → Nuevo bug (efecto secundario)
     ↓
  ┌─────────────────┐
  │   Bug cerrado   │
  │   ✅ Verificado │
  └─────────────────┘
```

#### 💡 Ejemplo Práctico

> **Escenario:** En una tienda online, se detecta que el descuento del 10% para clientes VIP no se aplica.
>
> **Bug:** TC-042 - "Descuento VIP no se aplica en el carrito"
>
> **Corrección:** El desarrollador arregla la función `calcularDescuento()`
>
> **Re-test:** 
> - Ejecutar TC-042 de nuevo: Comprar como cliente VIP → ¿Se aplica el 10%?
> - Si PASA → Continuar con regresión
> - Si FALLA → Devolver al desarrollador
>
> **Regresión:**
> - ¿Los descuentos por cantidad siguen funcionando?
> - ¿Los cupones promocionales siguen funcionando?
> - ¿El cálculo de IVA sigue correcto?
> - ¿El proceso de pago completo funciona?
> - ¿Los clientes NO-VIP no reciben el descuento por error?

### 4.5.2 Smoke Test (prueba de humo) vs Sanity Test (prueba de cordura)

| Tipo | Objetivo | Amplitud | Cuándo |
|------|----------|----------|--------|
| **Smoke Test** (prueba de humo - ver si "echa humo" al encenderlo) | ¿Funciona lo básico? | Amplio pero superficial | Cada nueva build (compilación) |
| **Sanity Test** (prueba de cordura - ver si tiene sentido) | ¿Funciona esta área? | Estrecho pero profundo | Tras cambios específicos |

**Ejemplo de Smoke Test para e-commerce:**
1. ¿La aplicación arranca?
2. ¿Se puede hacer login?
3. ¿Se pueden buscar productos?
4. ¿Se puede añadir al carrito?
5. ¿Se puede iniciar el pago?

### 4.5.3 Pruebas Manuales vs Automatizadas

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    PIRÁMIDE DE AUTOMATIZACIÓN                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                           /\                                                │
│                          /  \           MANUALES                            │
│                         /    \          Exploratorias, usabilidad           │
│                        / UI   \         Pocas, costosas                     │
│                       /────────\                                            │
│                      /  E2E     \       E2E AUTOMATIZADAS                   │
│                     /────────────\      Flujos completos                    │
│                    /              \                                         │
│                   /  INTEGRACIÓN   \    INTEGRACIÓN                         │
│                  /──────────────────\   Entre componentes                   │
│                 /                    \                                      │
│                /     UNITARIAS        \ UNITARIAS                           │
│               /────────────────────────\ Muchas, rápidas, baratas           │
│                                                                             │
│   BASE: Muchas unitarias automatizadas                                      │
│   CIMA: Pocas exploratorias manuales                                        │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 4.6 Ejercicios del Módulo 4 - CON SOLUCIONES

---

**EJERCICIO 1:**
Clasifica las siguientes actividades como **Estáticas (E)** o **Dinámicas (D)**:

a) Ejecutar un caso de prueba en el navegador
b) Revisar el documento de requisitos
c) Pasar un linter al código JavaScript
d) Hacer login y verificar el dashboard
e) Inspección de código entre desarrolladores
f) Prueba de carga con 1000 usuarios

**✅ SOLUCIÓN:**

a) **D - Dinámica** - Se está ejecutando el software (el navegador interactúa con la aplicación)

b) **E - Estática** - Solo se lee y revisa un documento, no se ejecuta ningún código

c) **E - Estática** - El linter analiza el código sin ejecutarlo, busca patrones y errores

d) **D - Dinámica** - Se ejecuta el software (login, carga del dashboard)

e) **E - Estática** - Se revisa el código leyéndolo, sin ejecutarlo

f) **D - Dinámica** - Se ejecuta el sistema con carga de 1000 usuarios simulados

---

**EJERCICIO 2:**
Indica qué técnica usarías (caja negra, caja blanca, o caja gris) para cada situación:

a) Verificar que se muestra error cuando el email no tiene formato válido
b) Asegurar que todas las ramas del código se ejecutan
c) Probar que el sistema calcula correctamente el IVA según requisitos
d) Verificar que no hay código inalcanzable

**✅ SOLUCIÓN:**

a) **Caja Negra** - Solo nos importa el comportamiento: entrada inválida → mensaje de error. No necesitamos ver cómo se valida internamente.

b) **Caja Blanca** - La cobertura de ramas requiere conocer el código para diseñar casos que pasen por todas las ramas.

c) **Caja Negra** - Verificamos contra requisitos: entrada (importe, tipo IVA) → salida esperada. No nos importa la implementación.

d) **Caja Blanca** - Detectar código inalcanzable (dead code) requiere análisis del código fuente.

---

**EJERCICIO 3:**
Clasifica los siguientes requisitos como **Funcionales (F)** o **No Funcionales (NF)**:

a) "El sistema debe permitir búsqueda de productos"
b) "Las búsquedas deben devolver resultados en menos de 3 segundos"
c) "El sistema debe enviar email de bienvenida al registrarse"
d) "El sistema debe estar disponible 24/7"
e) "Los datos de tarjeta deben transmitirse cifrados"

**✅ SOLUCIÓN:**

a) **F - Funcional** - Describe QUÉ hace el sistema (la funcionalidad de búsqueda)

b) **NF - No Funcional** - Describe CÓMO debe hacerlo (el rendimiento, tiempo de respuesta)

c) **F - Funcional** - Describe QUÉ hace el sistema (enviar un email específico)

d) **NF - No Funcional** - Describe atributo de calidad (disponibilidad/fiabilidad)

e) **NF - No Funcional** - Describe atributo de calidad (seguridad)

---

**EJERCICIO 4:**
Se ha desplegado una nueva versión de una aplicación de banca online. Describe:
a) Qué incluirías en el Smoke Test (5 verificaciones)
b) Qué áreas cubrirían las pruebas de regresión prioritarias (5 áreas)

**✅ SOLUCIÓN:**

**a) Smoke Test (verificaciones rápidas para confirmar que lo básico funciona):**

1. **Acceso:** La aplicación carga y muestra la página de login
2. **Autenticación:** Se puede hacer login con credenciales válidas
3. **Consulta:** Se puede ver el saldo de las cuentas
4. **Operación básica:** Se puede iniciar una transferencia (no hace falta completarla)
5. **Navegación:** Los menús principales funcionan y cargan las secciones

**b) Pruebas de regresión prioritarias (áreas críticas a verificar):**

1. **Autenticación y seguridad:** Login, logout, 2FA, bloqueo por intentos
2. **Operaciones financieras:** Transferencias, pagos, operaciones con tarjeta
3. **Consultas de cuentas:** Saldos, movimientos, extractos
4. **Gestión de beneficiarios:** Añadir, modificar, eliminar destinatarios
5. **Alertas y notificaciones:** Emails, SMS, alertas de seguridad

---

# MÓDULO 5: TÉCNICAS DE DISEÑO DE PRUEBAS

Ya conocemos los tipos de pruebas que existen. Ahora llega la pregunta más práctica: **¿cómo diseñamos los casos de prueba concretos?** No podemos probar todo (Principio 2), así que necesitamos técnicas sistemáticas que nos ayuden a seleccionar los casos más efectivos. Este módulo es el más práctico: aquí aprenderemos a crear pruebas reales.

## 5.1 El Proceso de Desarrollo de Pruebas

Antes de ver las técnicas específicas, entendamos el proceso completo. El testing no es solo "ejecutar pruebas"; es un proceso estructurado con varias actividades.

### 5.1.1 Actividades del Proceso de Pruebas

El testing no es solo "ejecutar pruebas". Es un proceso completo con varias actividades:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    PROCESO DE PRUEBAS                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   1. PLANIFICACIÓN                                                          │
│      • Definir alcance, objetivos, recursos                                 │
│      • Identificar riesgos                                                  │
│      • Establecer cronograma                                                │
│      • Definir criterios de entrada/salida                                  │
│                                                                             │
│   2. ANÁLISIS                                                               │
│      • Revisar base de pruebas (requisitos, diseños)                        │
│      • Identificar condiciones de prueba                                    │
│      • Priorizar según riesgo                                               │
│                                                                             │
│   3. DISEÑO                                                                 │
│      • Crear casos de prueba                                                │
│      • Definir datos de prueba                                              │
│      • Diseñar entorno de pruebas                                           │
│                                                                             │
│   4. IMPLEMENTACIÓN                                                         │
│      • Preparar scripts y herramientas                                      │
│      • Crear datos de prueba (🔧 **Mockaroo** facilita esta tarea)         │
│      • Configurar entorno                                                   │
│                                                                             │
│   5. EJECUCIÓN                                                              │
│      • Ejecutar casos de prueba                                             │
│      • Comparar resultados                                                  │
│      • Registrar defectos                                                   │
│                                                                             │
│   6. EVALUACIÓN                                                             │
│      • Evaluar criterios de salida                                          │
│      • Analizar métricas                                                    │
│      • Decidir si continuar o parar                                         │
│                                                                             │
│   7. CIERRE                                                                 │
│      • Documentar lecciones aprendidas                                      │
│      • Archivar artefactos                                                  │
│      • Generar informe final                                                │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 5.1.2 Estructura de un Caso de Prueba

Un caso de prueba bien documentado debe incluir:

| Campo | Descripción | Ejemplo |
|-------|-------------|---------|
| **ID** | Identificador único | TC-LOGIN-001 |
| **Nombre** | Descripción breve | Login con credenciales válidas |
| **Precondiciones** | Estado inicial requerido | Usuario registrado, no logueado |
| **Pasos** | Acciones a realizar | 1. Ir a /login 2. Introducir email... |
| **Datos de entrada** | Valores específicos | email: user@test.com, pass: Test123 |
| **Resultado esperado** | Lo que debe ocurrir | Redirige a dashboard, muestra "Bienvenido" |
| **Prioridad** | Importancia | Alta |
| **Requisito asociado** | Trazabilidad | REQ-AUTH-001 |

---

## 5.2 Técnicas de Caja Negra

Comenzamos con las técnicas de caja negra porque son las más utilizadas y no requieren conocimiento del código. Se basan únicamente en los requisitos y especificaciones, lo que las hace accesibles para cualquier tester.

### 5.2.1 Particiones de Equivalencia

**Concepto:** Dividir el dominio de entrada en grupos (particiones) donde todos los valores de un grupo deberían comportarse de la misma manera. Probar un valor de cada partición es representativo de todo el grupo.

**Objetivo:** Reducir el número de casos de prueba sin perder efectividad.

> 🔧 **Herramienta práctica:** **Mockaroo** permite generar grandes volúmenes de datos de prueba realistas para cada partición de equivalencia de forma automática.

**Ejemplo:**
```
Requisito: "La edad debe estar entre 18 y 65 años"

Particiones:
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│   INVÁLIDA        │      VÁLIDA        │       INVÁLIDA        │
│   (edad < 18)     │   (18 ≤ edad ≤ 65) │       (edad > 65)     │
│                   │                    │                       │
│   Ej: 10          │   Ej: 30           │       Ej: 70          │
│                   │                    │                       │
└─────────────────────────────────────────────────────────────────┘

Casos de prueba mínimos:
1. edad = 10  → Debe rechazar (partición inválida inferior)
2. edad = 30  → Debe aceptar (partición válida)
3. edad = 70  → Debe rechazar (partición inválida superior)
```

**Reglas:**
- Cada valor pertenece a exactamente una partición
- Si un valor de la partición encuentra un defecto, cualquier otro valor de esa partición probablemente también lo encontraría
- Probar al menos un valor de cada partición

### 5.2.2 Análisis de Valores Límite

**Concepto:** Los defectos tienden a concentrarse en los límites de las particiones. Probar exactamente en los bordes y justo fuera de ellos.

**Valores a probar para cada límite:**
- El valor justo en el límite
- El valor justo por debajo del límite
- El valor justo por encima del límite

**Ejemplo:**
```
Requisito: "La edad debe estar entre 18 y 65 años"

Valores límite a probar:
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│   17        18        19    ...    64        65        66       │
│   │         │         │            │         │         │        │
│   ▼         ▼         ▼            ▼         ▼         ▼        │
│  Inválido  Válido    Válido      Válido    Válido   Inválido   │
│  (límite-1)(límite)  (límite+1)  (límite-1)(límite) (límite+1) │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

Casos de prueba:
1. edad = 17  → Debe rechazar
2. edad = 18  → Debe aceptar
3. edad = 19  → Debe aceptar
4. edad = 64  → Debe aceptar
5. edad = 65  → Debe aceptar
6. edad = 66  → Debe rechazar
```

### 5.2.3 Tablas de Decisión

**Concepto:** Cuando hay múltiples condiciones que se combinan para producir diferentes acciones, una tabla de decisión muestra todas las combinaciones posibles.

**Estructura:**
- Filas superiores: Condiciones (con valores posibles)
- Filas inferiores: Acciones (resultado para cada combinación)
- Columnas: Cada regla/combinación

**Ejemplo:**
```
Sistema de descuentos:
- Si es cliente VIP Y compra > 100€ → 20% descuento
- Si es cliente VIP Y compra ≤ 100€ → 10% descuento
- Si NO es VIP Y compra > 100€ → 5% descuento
- Si NO es VIP Y compra ≤ 100€ → Sin descuento

┌──────────────────────┬──────┬──────┬──────┬──────┐
│ CONDICIONES          │ R1   │ R2   │ R3   │ R4   │
├──────────────────────┼──────┼──────┼──────┼──────┤
│ ¿Es cliente VIP?     │ Sí   │ Sí   │ No   │ No   │
│ ¿Compra > 100€?      │ Sí   │ No   │ Sí   │ No   │
├──────────────────────┼──────┼──────┼──────┼──────┤
│ ACCIONES             │      │      │      │      │
├──────────────────────┼──────┼──────┼──────┼──────┤
│ Descuento 20%        │  X   │      │      │      │
│ Descuento 10%        │      │  X   │      │      │
│ Descuento 5%         │      │      │  X   │      │
│ Sin descuento        │      │      │      │  X   │
└──────────────────────┴──────┴──────┴──────┴──────┘

Casos de prueba: Uno para cada regla (R1, R2, R3, R4)
```

### 5.2.4 Pruebas de Transición de Estados

**Concepto:** Cuando el sistema tiene estados y transiciones entre ellos, probar todas las transiciones válidas (y algunas inválidas).

**Ejemplo: Sistema de pedidos**
```
┌─────────────────────────────────────────────────────────────────┐
│                    DIAGRAMA DE ESTADOS                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│                      ┌─────────────┐                            │
│         Crear        │             │       Pagar                │
│    ───────────────►  │  PENDIENTE  │  ──────────────►           │
│                      │             │                            │
│                      └──────┬──────┘                            │
│                             │                                   │
│                             │ Cancelar                          │
│                             ▼                                   │
│    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐       │
│    │  CANCELADO  │◄───│             │    │   PAGADO    │       │
│    └─────────────┘    │  CANCELADO  │    └──────┬──────┘       │
│                       │             │           │               │
│                       └─────────────┘           │ Enviar        │
│                                                 ▼               │
│                                          ┌─────────────┐       │
│                                          │  ENVIADO    │       │
│                                          └──────┬──────┘       │
│                                                 │               │
│                                                 │ Entregar      │
│                                                 ▼               │
│                                          ┌─────────────┐       │
│                                          │  ENTREGADO  │       │
│                                          └─────────────┘       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

Casos de prueba:
1. Crear pedido → Estado = Pendiente
2. Pendiente + Pagar → Estado = Pagado
3. Pendiente + Cancelar → Estado = Cancelado
4. Pagado + Enviar → Estado = Enviado
5. Enviado + Entregar → Estado = Entregado
6. (Inválido) Cancelado + Pagar → Debe rechazar
```

### 5.2.5 Pruebas Basadas en Casos de Uso

**Concepto:** Derivar casos de prueba de los casos de uso del sistema, probando el flujo principal y los flujos alternativos/excepcionales.

**Ejemplo:**
```
Caso de Uso: "Realizar compra"

Flujo Principal:
1. Usuario busca producto
2. Usuario añade al carrito
3. Usuario procede al pago
4. Usuario introduce datos de pago
5. Sistema procesa pago
6. Sistema confirma compra

Flujos Alternativos/Excepcionales:
2a. Producto sin stock → Mensaje "No disponible"
4a. Datos de tarjeta inválidos → Mensaje de error
5a. Pago rechazado → Volver a introducir datos

Casos de prueba:
- CP1: Flujo principal completo
- CP2: Producto sin stock
- CP3: Tarjeta inválida
- CP4: Pago rechazado
```

---

## 5.3 Técnicas de Caja Blanca

Mientras las técnicas de caja negra se centran en "qué hace" el software, las de caja blanca se centran en "cómo lo hace". Requieren acceso al código y buscan garantizar que todas las partes del código se ejecutan al menos una vez.

### 5.3.1 Cobertura de Sentencias

**Objetivo:** Ejecutar cada sentencia (línea) del código al menos una vez.

**Ejemplo:**
```python
def calcular_precio(cantidad, precio_unitario, descuento):
    total = cantidad * precio_unitario    # Línea 1
    if descuento > 0:                      # Línea 2
        total = total - (total * descuento / 100)  # Línea 3
    return total                           # Línea 4

# Para 100% cobertura de sentencias:
# Caso 1: descuento = 0 → Ejecuta líneas 1, 2, 4
# Caso 2: descuento = 10 → Ejecuta líneas 1, 2, 3, 4
# Con ambos casos: 100% cobertura de sentencias
```

### 5.3.2 Cobertura de Decisiones (Ramas)

**Objetivo:** Ejecutar cada decisión (condición) tanto como True como False.

**Ejemplo:**
```python
def categorizar(edad, ingresos):
    if edad >= 18:              # Decisión 1
        if ingresos > 30000:    # Decisión 2
            return "A"
        else:
            return "B"
    else:
        return "C"

# Para 100% cobertura de decisiones:
# Caso 1: edad=20, ingresos=40000 → D1=True, D2=True → "A"
# Caso 2: edad=20, ingresos=20000 → D1=True, D2=False → "B"
# Caso 3: edad=15, cualquier ingreso → D1=False → "C"
```

### 5.3.3 Cobertura de Condiciones

**Objetivo:** Cada condición atómica dentro de una decisión compuesta debe evaluarse tanto True como False.

**Ejemplo:**
```python
if (edad >= 18) AND (ingresos > 30000):
    # ...

# Condiciones atómicas:
# - C1: edad >= 18
# - C2: ingresos > 30000

# Para 100% cobertura de condiciones:
# Caso 1: edad=20 (C1=True), ingresos=40000 (C2=True)
# Caso 2: edad=15 (C1=False), ingresos=20000 (C2=False)
```

### 5.3.4 Cobertura de Caminos

**Objetivo:** Ejecutar todos los caminos posibles a través del código.

**Nota:** Puede ser imposible en código con bucles (infinitos caminos). Se usa cobertura de caminos independientes o se limitan las iteraciones de bucles.

---

## 5.4 Técnicas Basadas en Experiencia

Las técnicas de caja negra y blanca son sistemáticas y formales. Sin embargo, hay defectos que escapan a estas técnicas estructuradas. Las técnicas basadas en experiencia complementan a las anteriores aprovechando la intuición y el conocimiento acumulado del tester.

### 5.4.1 Pruebas Exploratorias

**Definición:** Diseño, ejecución y aprendizaje simultáneos. El tester explora el sistema sin casos predefinidos, usando su experiencia e intuición.

**Características:**
- No siguen scripts predefinidos
- El tester aprende mientras prueba
- Muy efectivas para encontrar defectos inesperados
- Complementan las pruebas estructuradas

**Sesiones de prueba exploratoria:**
```
┌─────────────────────────────────────────────────────────────────┐
│ CARTA DE SESIÓN EXPLORATORIA                                    │
├─────────────────────────────────────────────────────────────────┤
│ Misión: Explorar el proceso de checkout buscando problemas      │
│         de usabilidad y casos límite                            │
│ Duración: 60 minutos                                            │
│ Área: Carrito y proceso de pago                                 │
│ Tester: [Nombre]                                                │
│ Fecha: [Fecha]                                                  │
│                                                                 │
│ Notas durante la sesión:                                        │
│ - 10:05 - El botón "Aplicar cupón" no da feedback visual       │
│ - 10:15 - Si añado 999 unidades, el sistema acepta              │
│ - 10:30 - Al cambiar dirección, se pierde el cupón             │
│                                                                 │
│ Defectos encontrados: 3                                         │
│ Áreas no exploradas: Métodos de pago alternativos              │
└─────────────────────────────────────────────────────────────────┘
```

### 5.4.2 Predicción de Errores (Error Guessing)

**Definición:** Usar la experiencia para adivinar dónde pueden estar los defectos.

**Áreas típicas donde buscar:**
- Valores nulos o vacíos
- Divisiones por cero
- Fechas inválidas (29 febrero, 31 de meses con 30 días)
- Caracteres especiales
- Campos muy largos
- Operaciones concurrentes
- Límites de memoria

### 5.4.3 Pruebas Basadas en Checklists

**Definición:** Lista de verificación basada en experiencia previa y defectos comunes.

**Ejemplo de checklist para formularios:**
```
□ Campos obligatorios están marcados
□ Validación de formato de email
□ Validación de longitud máxima
□ Caracteres especiales manejados correctamente
□ Espacios al inicio/final son tratados
□ Mensaje de error claro si falla validación
□ Funciona con teclado (sin ratón)
□ Accesible para lectores de pantalla
```

> 🔧 **Herramienta práctica:** **Postman** permite crear colecciones de pruebas con checklists automatizados para APIs, ejecutándolas de forma repetible y documentada.

---

## 5.5 Ejercicios del Módulo 5 - CON SOLUCIONES

---

**EJERCICIO 1:**
Un campo de texto acepta códigos de producto con formato "XXX-9999" (3 letras, guión, 4 dígitos). Usando particiones de equivalencia, identifica las particiones y diseña los casos de prueba mínimos.

**✅ SOLUCIÓN:**

**Particiones identificadas:**

| Partición | Descripción | Ejemplo | Resultado esperado |
|-----------|-------------|---------|-------------------|
| P1: Válida | 3 letras + guión + 4 dígitos | ABC-1234 | Aceptado |
| P2: Inválida - pocas letras | < 3 letras | AB-1234 | Rechazado |
| P3: Inválida - muchas letras | > 3 letras | ABCD-1234 | Rechazado |
| P4: Inválida - pocas cifras | < 4 dígitos | ABC-123 | Rechazado |
| P5: Inválida - muchas cifras | > 4 dígitos | ABC-12345 | Rechazado |
| P6: Inválida - sin guión | Sin guión | ABC1234 | Rechazado |
| P7: Inválida - números en letras | Números donde van letras | 123-4567 | Rechazado |
| P8: Inválida - letras en números | Letras donde van números | ABC-DEFG | Rechazado |
| P9: Inválida - vacío | Campo vacío | (vacío) | Rechazado |

**Casos de prueba mínimos (uno por partición):**
1. "ABC-1234" → Válido
2. "AB-1234" → Inválido (pocas letras)
3. "ABCD-1234" → Inválido (muchas letras)
4. "ABC-123" → Inválido (pocos dígitos)
5. "ABC-12345" → Inválido (muchos dígitos)
6. "ABC1234" → Inválido (sin guión)
7. "123-4567" → Inválido (números donde letras)
8. "ABC-DEFG" → Inválido (letras donde números)
9. "" → Inválido (vacío)

---

**EJERCICIO 2:**
Un sistema acepta cantidades de compra entre 1 y 100 unidades. Usando análisis de valores límite, lista todos los valores que deberías probar.

**✅ SOLUCIÓN:**

**Valores límite a probar:**

```
Límite inferior (1):
- 0  → Inválido (justo fuera)
- 1  → Válido (en el límite)
- 2  → Válido (justo dentro)

Límite superior (100):
- 99  → Válido (justo dentro)
- 100 → Válido (en el límite)
- 101 → Inválido (justo fuera)
```

**Lista completa de valores a probar:**

| Valor | Resultado esperado | Razón |
|-------|-------------------|-------|
| 0 | Rechazar | Límite inferior - 1 |
| 1 | Aceptar | Límite inferior |
| 2 | Aceptar | Límite inferior + 1 |
| 99 | Aceptar | Límite superior - 1 |
| 100 | Aceptar | Límite superior |
| 101 | Rechazar | Límite superior + 1 |

**Nota:** Opcionalmente también se podría probar un valor muy interno (ej: 50) para representar la partición válida, y valores negativos (-1) para cubrir errores de tipo.

---

**EJERCICIO 3:**
Un sistema de préstamos tiene las siguientes reglas:
- Si el cliente tiene más de 2 años de antigüedad Y no tiene deudas → Aprobar
- Si el cliente tiene más de 2 años de antigüedad Y tiene deudas → Revisar
- Si el cliente tiene 2 años o menos de antigüedad → Rechazar

Crea la tabla de decisión correspondiente.

**✅ SOLUCIÓN:**

```
┌──────────────────────────────┬────────┬────────┬────────┬────────┐
│ CONDICIONES                  │   R1   │   R2   │   R3   │   R4   │
├──────────────────────────────┼────────┼────────┼────────┼────────┤
│ ¿Antigüedad > 2 años?        │   Sí   │   Sí   │   No   │   No   │
│ ¿Tiene deudas?               │   No   │   Sí   │   No   │   Sí   │
├──────────────────────────────┼────────┼────────┼────────┼────────┤
│ ACCIONES                     │        │        │        │        │
├──────────────────────────────┼────────┼────────┼────────┼────────┤
│ Aprobar préstamo             │   X    │        │        │        │
│ Revisar préstamo             │        │   X    │        │        │
│ Rechazar préstamo            │        │        │   X    │   X    │
└──────────────────────────────┴────────┴────────┴────────┴────────┘
```

**Casos de prueba derivados:**

| Caso | Antigüedad | Deudas | Resultado esperado |
|------|------------|--------|-------------------|
| R1 | 3 años | No | Aprobar |
| R2 | 5 años | Sí | Revisar |
| R3 | 1 año | No | Rechazar |
| R4 | 2 años | Sí | Rechazar |

**Nota:** Observar que R3 y R4 tienen la misma acción (Rechazar) porque cuando la antigüedad es ≤ 2 años, no importa si tiene deudas o no. Se podrían colapsar en una sola regla con "-" (no importa) en la condición de deudas, pero para la tabla completa se muestran las 4 combinaciones.

---

**EJERCICIO 4:**
Dado el siguiente código, diseña los casos de prueba necesarios para lograr 100% de cobertura de decisiones:

```python
def calcular_envio(peso, urgente, socio):
    if peso <= 1:
        precio = 5
    elif peso <= 5:
        precio = 10
    else:
        precio = 20
    
    if urgente:
        precio = precio * 2
    
    if socio:
        precio = precio * 0.9
    
    return precio
```

**✅ SOLUCIÓN:**

**Análisis de decisiones:**
- Decisión 1: `peso <= 1` (True/False)
- Decisión 2: `peso <= 5` (True/False, solo si D1 es False)
- Decisión 3: `urgente` (True/False)
- Decisión 4: `socio` (True/False)

**Casos de prueba para 100% cobertura de decisiones:**

| Caso | peso | urgente | socio | D1 | D2 | D3 | D4 | Precio |
|------|------|---------|-------|----|----|----|----|--------|
| 1 | 0.5 | False | False | T | - | F | F | 5 |
| 2 | 3 | True | False | F | T | T | F | 20 |
| 3 | 10 | False | True | F | F | F | T | 18 |
| 4 | 2 | True | True | F | T | T | T | 18 |

**Explicación de la cobertura:**
- **D1 True:** Caso 1 (peso=0.5)
- **D1 False, D2 True:** Casos 2 y 4 (peso=3 y peso=2)
- **D1 False, D2 False:** Caso 3 (peso=10)
- **D3 True:** Casos 2 y 4
- **D3 False:** Casos 1 y 3
- **D4 True:** Casos 3 y 4
- **D4 False:** Casos 1 y 2

Con estos 4 casos se cubren todas las ramas del código.

**Nota:** Se podrían reducir a 3 casos optimizando las combinaciones, pero 4 casos proporcionan buena cobertura y son fáciles de entender.

---

**EJERCICIO 5:**
Diseña una carta de sesión exploratoria para probar la funcionalidad de "recuperar contraseña" de una aplicación web.

**✅ SOLUCIÓN:**

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CARTA DE SESIÓN EXPLORATORIA                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│ MISIÓN: Explorar el flujo de recuperación de contraseña buscando           │
│         problemas de usabilidad, seguridad y casos límite.                  │
│                                                                             │
│ ÁREA BAJO PRUEBA: Funcionalidad "¿Olvidaste tu contraseña?"                │
│                                                                             │
│ DURACIÓN: 60 minutos                                                        │
│                                                                             │
│ TESTER: [Nombre del tester]                                                 │
│ FECHA: [Fecha de la sesión]                                                 │
│ ENTORNO: [Navegador, versión, dispositivo]                                  │
│                                                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│ ÁREAS A EXPLORAR:                                                           │
│                                                                             │
│ □ Solicitud de recuperación                                                 │
│   - Email válido existente                                                  │
│   - Email válido no existente (¿revela que no existe?)                     │
│   - Email con formato inválido                                              │
│   - Campo vacío                                                             │
│   - Múltiples solicitudes seguidas (rate limiting)                         │
│                                                                             │
│ □ Email de recuperación                                                     │
│   - ¿Llega el email? ¿En cuánto tiempo?                                    │
│   - ¿El enlace es único y seguro?                                          │
│   - ¿Expira el enlace? ¿Cuándo?                                            │
│   - ¿Se puede usar el enlace varias veces?                                 │
│                                                                             │
│ □ Formulario de nueva contraseña                                            │
│   - Validación de requisitos de contraseña                                  │
│   - Confirmación de contraseña (coinciden/no coinciden)                    │
│   - ¿Permite poner la contraseña anterior?                                 │
│   - Mostrar/ocultar contraseña                                             │
│                                                                             │
│ □ Seguridad                                                                 │
│   - ¿El enlace es predecible?                                              │
│   - ¿Funciona desde otra IP/dispositivo?                                   │
│   - ¿Se invalidan otras sesiones activas?                                  │
│                                                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│ HEURÍSTICAS A USAR:                                                         │
│ • SFDPOT (Structure, Function, Data, Platform, Operations, Time)           │
│ • Valores límite y casos extremos                                           │
│ • Flujos interrumpidos (abandonar a mitad)                                 │
│ • Usuarios maliciosos (¿qué haría un atacante?)                            │
│                                                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│ NOTAS DURANTE LA SESIÓN:                                                    │
│                                                                             │
│ [Timestamp] - [Observación/Hallazgo]                                        │
│ ___________ - ________________________________________                      │
│ ___________ - ________________________________________                      │
│ ___________ - ________________________________________                      │
│                                                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│ RESUMEN POST-SESIÓN:                                                        │
│                                                                             │
│ Defectos encontrados: ___                                                   │
│ Preguntas para el equipo: ___                                               │
│ Áreas no exploradas: ___                                                    │
│ Riesgos identificados: ___                                                  │
│ Recomendaciones: ___                                                        │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

# CIERRE: RESUMEN FINAL DEL CURSO

## Recapitulación de los 5 Módulos

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              MAPA MENTAL DEL CURSO COMPLETO                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                        TESTING DE SOFTWARE                                   │
│                              │                                              │
│         ┌───────────────────┼───────────────────┐                          │
│         │                   │                   │                          │
│         ▼                   ▼                   ▼                          │
│    FUNDAMENTOS          CALIDAD            CICLO DE VIDA                   │
│    (Módulo 1)          (Módulo 2)          (Módulo 3)                      │
│         │                   │                   │                          │
│    Error/Defecto/       ISO 25010           Modelos de                     │
│    Fallo                QA vs QC            desarrollo                     │
│    7 Principios         Coste calidad       Niveles de                     │
│    ISTQB                ROI                 prueba                         │
│                                             Mantenimiento                  │
│         │                   │                   │                          │
│         └───────────────────┼───────────────────┘                          │
│                             │                                              │
│              ┌──────────────┴──────────────┐                               │
│              │                             │                               │
│              ▼                             ▼                               │
│      TIPOS DE PRUEBAS              TÉCNICAS DE DISEÑO                      │
│      (Módulo 4)                    (Módulo 5)                              │
│              │                             │                               │
│      Estáticas/Dinámicas           Proceso de pruebas                      │
│      Caja Negra/Blanca             Particiones                             │
│      Funcionales/No Func.          Valores límite                          │
│      Regresión/Smoke               Tablas decisión                         │
│      Manual/Automatizado           Transición estados                      │
│                                    Cobertura código                        │
│                                    Exploratorias                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Conceptos Clave para Recordar

1. **Error → Defecto → Fallo:** La cadena de causalidad
2. **Los 7 principios ISTQB** guían todas las decisiones de testing
3. **La calidad es multidimensional** (ISO 25010: 8 características)
4. **El modelo de desarrollo** condiciona cómo y cuándo se prueba
5. **Los 4 niveles de prueba:** Unitarias → Integración → Sistema → Aceptación
6. **Las pruebas deben mantenerse** junto con el software
7. **Diferentes tipos de pruebas** encuentran diferentes tipos de defectos
8. **Las técnicas de diseño** sistematizan la creación de casos de prueba
9. **Combinar técnicas** (particiones + límites + exploratorias) da mejor cobertura

---

*[Fin del Documento - Versión para Profesor con Soluciones v2]*
*Material de apoyo para el curso de Testing de Software - EOI 2026*
