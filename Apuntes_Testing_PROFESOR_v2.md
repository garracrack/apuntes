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

### 1.1.4 El Testing como Disciplina Profesional

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

## 1.2 Conceptos Clave: Error, Defecto y Fallo

Estos tres términos son absolutamente fundamentales en el mundo del testing. Aunque en el lenguaje cotidiano a menudo se usan como sinónimos, en testing tienen significados muy precisos y diferenciados.

### 1.2.1 ERROR (Mistake / Equivocación)

**Definición:** Un error es una **acción humana incorrecta** que produce un resultado incorrecto. Es el origen, la causa raíz de todo el problema.

**Características:**
- Es una acción humana (no del software)
- El software no comete errores por sí mismo
- Los cometen: desarrolladores, analistas, diseñadores, arquitectos, testers

**Tipos de errores comunes:**
- Errores de interpretación de requisitos
- Errores de lógica al programar
- Errores de comunicación en el equipo
- Errores por desconocimiento técnico
- Errores por fatiga o presión

### 1.2.2 DEFECTO (Bug / Defect / Fault)

**Definición:** Un defecto es una **imperfección en el software** que puede causar que el sistema falle. Es la manifestación del error en el código o documentación.

**Características:**
- Está en el producto (código, documentos, configuración)
- Es el resultado de un error humano
- Puede existir sin manifestarse (código no ejecutado)
- También llamado "bug", "fault", "problema"

**Tipos de defectos:**
- Defectos en el código fuente
- Defectos en requisitos (ambigüedades, contradicciones)
- Defectos en diseño
- Defectos en configuración
- Defectos en documentación

### 1.2.3 FALLO (Failure)

**Definición:** Un fallo es la **manifestación visible** de un defecto cuando el software no se comporta como se esperaba durante su ejecución.

**Características:**
- Es observable por el usuario o el tester
- Ocurre durante la ejecución del software
- No todos los defectos causan fallos
- Puede haber fallos sin defectos (entorno, hardware)

### 1.2.4 La Cadena de Causalidad

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CADENA DE CAUSALIDAD                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   PERSONA                    SOFTWARE                   EJECUCIÓN           │
│   comete                     contiene                   produce             │
│                                                                             │
│   ┌───────┐    introduce    ┌─────────┐    causa      ┌───────┐            │
│   │ ERROR │ ──────────────► │ DEFECTO │ ────────────► │ FALLO │            │
│   └───────┘                 └─────────┘               └───────┘            │
│                                                                             │
│   (Acción                   (En el                    (Comportamiento       │
│    humana)                   producto)                 incorrecto)          │
│                                                                             │
│   Ejemplo:                                                                  │
│   Programador      →        Código con      →         Sistema rechaza      │
│   entiende mal              condición                 usuarios válidos     │
│   el requisito              incorrecta                                      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 1.3 Los 7 Principios Fundamentales del Testing (ISTQB)

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

**Shift Left Testing:** Mover el testing hacia la izquierda (más temprano):
- Revisar requisitos buscando ambigüedades
- Revisar diseños antes de implementar
- TDD (Test-Driven Development)
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

**Verificación vs Validación:**

| Verificación | Validación |
|--------------|------------|
| ¿Construimos el producto CORRECTAMENTE? | ¿Construimos el producto CORRECTO? |
| Cumple especificaciones | Cumple necesidades reales |
| Funciona según documentación | El usuario está satisfecho |

**Un software sin bugs que nadie quiere usar sigue siendo un fracaso.**

---

## 1.4 Ejercicios del Módulo 1 - CON SOLUCIONES

---

**EJERCICIO 1:**
En un sistema de reservas de hotel, el requisito dice: "El número de noches debe estar entre 1 y 30". Un usuario introduce 0 noches y el sistema lo acepta sin mostrar error.

Identifica: a) ¿Cuál fue el error? b) ¿Cuál es el defecto? c) ¿Cuál es el fallo?

**✅ SOLUCIÓN:**

a) **ERROR:** El programador no implementó (o implementó incorrectamente) la validación del límite inferior del número de noches. Posiblemente interpretó mal el requisito pensando que solo importaba el límite superior (30), o se olvidó de validar el mínimo.

b) **DEFECTO:** El código tiene una validación incompleta o ausente. Probablemente el código dice algo como `if (noches > 30) mostrarError()` en lugar de `if (noches < 1 || noches > 30) mostrarError()`. El defecto está en el código fuente.

c) **FALLO:** El sistema acepta 0 noches como valor válido cuando debería mostrar un mensaje de error indicando que el mínimo es 1 noche. El comportamiento observable es incorrecto.

---

**EJERCICIO 2:**
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

**EJERCICIO 3:**
Un sistema bancario permite transferencias. El requisito dice: "Las transferencias deben ser de mínimo 1€ y máximo 10.000€". Un usuario intenta transferir 10.001€ y el sistema lo permite.

Identifica: a) ¿Cuál fue el error? b) ¿Cuál es el defecto? c) ¿Cuál es el fallo?

**✅ SOLUCIÓN:**

a) **ERROR:** El desarrollador cometió un error al implementar la validación del límite superior. Posiblemente usó el operador incorrecto: `importe >= 10000` en lugar de `importe > 10000` (error off-by-one), o simplemente no implementó la validación del máximo.

b) **DEFECTO:** En el código fuente existe una condición incorrecta o ausente. Donde debería haber `if (importe > 10000) rechazarTransferencia()`, el código permite pasar importes superiores.

c) **FALLO:** El sistema permite realizar una transferencia de 10.001€ cuando según los requisitos debería rechazarla y mostrar un mensaje indicando que el máximo es 10.000€.

**Nota adicional para el profesor:** Este es un caso clásico de valor límite, que debería haberse detectado con pruebas de valores límite (probar 9.999€, 10.000€ y 10.001€).

---

**EJERCICIO 4:**
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

> "El grado en que un sistema de software satisface las necesidades declaradas e implícitas de sus distintos stakeholders, proporcionando así valor."

Esta definición nos dice varias cosas importantes:
1. **Grado:** La calidad no es binaria (tiene/no tiene), sino gradual
2. **Necesidades declaradas:** Lo que el cliente pidió explícitamente
3. **Necesidades implícitas:** Lo que el cliente espera aunque no lo dijo
4. **Stakeholders:** No solo el usuario final, también desarrolladores, operadores, etc.
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

Es fundamental entender la diferencia entre estos dos conceptos:

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

## 2.3 El Coste de la Calidad

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

**EJERCICIO 3:**
Una empresa invierte 40.000€ en testing para un proyecto. Los defectos detectados habrían causado en producción: pérdidas de ventas (120.000€), compensaciones (35.000€) y corrección de emergencia (45.000€).

Calcula: a) El ahorro total b) El ROI del testing

**✅ SOLUCIÓN:**

a) **Ahorro total:**
   - Pérdidas de ventas evitadas: 120.000€
   - Compensaciones evitadas: 35.000€
   - Corrección de emergencia evitada: 45.000€
   - **Total evitado = 120.000 + 35.000 + 45.000 = 200.000€**

b) **ROI del testing:**
   ```
   ROI = (Beneficio - Inversión) / Inversión × 100
   ROI = (200.000 - 40.000) / 40.000 × 100
   ROI = 160.000 / 40.000 × 100
   ROI = 4 × 100
   ROI = 400%
   ```
   
   **Por cada euro invertido en testing, se ahorraron 4€** (o dicho de otra manera, el retorno fue del 400%).

---

# MÓDULO 3: EL TESTING EN EL CICLO DE VIDA DEL SOFTWARE

## 3.1 Modelos de Desarrollo de Software

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

### 3.1.3 Desarrollo Iterativo e Incremental

**Descripción:** El software se desarrolla a través de ciclos repetidos (iteraciones), cada uno produciendo un incremento funcional.

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
│   • El testing ocurre en cada iteración                                     │
│   • Feedback rápido y adaptación continua                                   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.1.4 Metodologías Ágiles (Scrum)

**Descripción:** Framework que estructura el trabajo en Sprints (iteraciones de 2-4 semanas).

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    TESTING EN SCRUM                                         │
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
│   • El testing es parte del Definition of Done                              │
│   • No hay fase separada de testing                                         │
│   • Tester integrado en el equipo                                           │
│   • Automatización casi obligatoria                                         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.1.5 DevOps e Integración Continua

**Descripción:** Cultura y prácticas que unifican desarrollo y operaciones para entregas continuas.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    PIPELINE CI/CD                                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   CODE ──► BUILD ──► TEST ──► RELEASE ──► DEPLOY ──► MONITOR               │
│                        │                               │                    │
│                        ▼                               ▼                    │
│               ┌────────────────┐            ┌──────────────────┐           │
│               │ Pruebas Auto   │            │ Monitorización   │           │
│               │ • Unitarias    │            │ • Logs           │           │
│               │ • Integración  │            │ • Métricas       │           │
│               │ • E2E          │            │ • Alertas        │           │
│               │ • Rendimiento  │            │ • A/B Testing    │           │
│               │ • Seguridad    │            │ • Canary release │           │
│               └────────────────┘            └──────────────────┘           │
│                                                                             │
│   Características:                                                          │
│   • Todo automatizado                                                       │
│   • Feedback en minutos                                                     │
│   • Despliegues frecuentes (varias veces al día)                           │
│   • Testing en producción (monitorizado)                                   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.1.6 Comparativa de Modelos y Testing

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
│                                                                             │
│  Automatización   Opcional      Recomendada   Importante   Esencial        │
│                                                                             │
│  Feedback         Muy tardío    Tardío        Frecuente    Muy frecuente   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 3.2 Niveles de Prueba

### 3.2.1 Nivel 1: Pruebas Unitarias (o de Componente)

**Definición:** Verifican el funcionamiento correcto de las unidades más pequeñas de código de forma aislada.

| Aspecto | Descripción |
|---------|-------------|
| **¿Qué se prueba?** | Una función, método o clase individual |
| **¿Quién las hace?** | Normalmente los desarrolladores |
| **¿Cuándo?** | Durante y justo después de codificar |
| **Técnicas** | Principalmente caja blanca |
| **Automatización** | Casi siempre automatizadas |

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

**Mocks y Stubs:** Para aislar la unidad de sus dependencias:
- **Stub:** Proporciona respuestas predefinidas
- **Mock:** Además verifica que se llamó correctamente

### 3.2.2 Nivel 2: Pruebas de Integración

**Definición:** Verifican la comunicación e interacción correcta entre componentes que ya han sido probados individualmente.

| Aspecto | Descripción |
|---------|-------------|
| **¿Qué se prueba?** | Interfaces entre componentes |
| **¿Quién las hace?** | Desarrolladores o testers técnicos |
| **¿Cuándo?** | Después de las pruebas unitarias |
| **Objetivo** | Detectar problemas de comunicación |

**Problemas típicos de integración:**
- Formato de datos incompatible
- Orden de parámetros diferente
- Unidades diferentes (metros vs pies)
- Manejo diferente de nulos
- Timeouts y tiempos de espera

**Estrategias de integración:**
- **Big Bang:** Todo junto de una vez (difícil depurar)
- **Top-Down:** Desde módulos superiores hacia inferiores
- **Bottom-Up:** Desde módulos inferiores hacia superiores
- **Sandwich:** Combinación de ambas direcciones

### 3.2.3 Nivel 3: Pruebas de Sistema

**Definición:** Verifican el comportamiento del sistema completo en un entorno similar a producción.

| Aspecto | Descripción |
|---------|-------------|
| **¿Qué se prueba?** | El sistema completo end-to-end |
| **¿Quién las hace?** | Equipo de QA independiente |
| **¿Cuándo?** | Después de las pruebas de integración |
| **Técnicas** | Principalmente caja negra |
| **Entorno** | Similar a producción |

**Tipos de pruebas a nivel de sistema:**
- Funcionales (flujos completos)
- Rendimiento (carga, estrés)
- Seguridad
- Usabilidad
- Compatibilidad

### 3.2.4 Nivel 4: Pruebas de Aceptación

**Definición:** Verifican que el sistema satisface las necesidades del negocio y está listo para producción.

| Aspecto | Descripción |
|---------|-------------|
| **¿Qué se prueba?** | Valor de negocio |
| **¿Quién las hace?** | Usuarios, clientes, Product Owner |
| **¿Cuándo?** | Última fase antes de producción |
| **Entorno** | Producción o pre-producción |

**Tipos de pruebas de aceptación:**

| Tipo | Objetivo | Quién |
|------|----------|-------|
| **UAT** (User Acceptance) | Usuarios pueden hacer su trabajo | Usuarios finales |
| **BAT** (Business Acceptance) | Cumple objetivos de negocio | Stakeholders |
| **OAT** (Operational Acceptance) | Se puede operar y mantener | Equipo de operaciones |
| **Alpha** | Feedback interno | Empleados |
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
| **Walkthrough** | Baja | El autor presenta y explica su trabajo |
| **Revisión Técnica** | Media | Checklist, criterios definidos |
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

### 4.5.1 Pruebas de Regresión vs Re-testing

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    RE-TEST vs REGRESIÓN                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   RE-TEST                             REGRESIÓN                             │
│   ───────                             ─────────                             │
│                                                                             │
│   Confirmar que el defecto            Verificar que el cambio no           │
│   está corregido                      ha roto nada más                     │
│                                                                             │
│   Solo el caso que falló              Conjunto amplio de casos             │
│                                                                             │
│   Siempre obligatorio                 Muy recomendable                     │
│   tras corrección                                                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 4.5.2 Smoke Test vs Sanity Test

| Tipo | Objetivo | Amplitud | Cuándo |
|------|----------|----------|--------|
| **Smoke Test** | ¿Funciona lo básico? | Amplio pero superficial | Cada nueva build |
| **Sanity Test** | ¿Funciona esta área? | Estrecho pero profundo | Tras cambios específicos |

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

## 5.1 El Proceso de Desarrollo de Pruebas

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
│      • Crear datos de prueba                                                │
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

### 5.2.1 Particiones de Equivalencia

**Concepto:** Dividir el dominio de entrada en grupos (particiones) donde todos los valores de un grupo deberían comportarse de la misma manera. Probar un valor de cada partición es representativo de todo el grupo.

**Objetivo:** Reducir el número de casos de prueba sin perder efectividad.

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
