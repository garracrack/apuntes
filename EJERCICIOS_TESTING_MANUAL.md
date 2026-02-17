# Ejercicios de Testing Manual — Enunciados y Código Fuente

Este documento contiene únicamente los enunciados y el código fuente de los 6 ejercicios de testing (caja negra y caja blanca). El objetivo es que los alumnos completen para cada ejercicio:
- La técnica de testing utilizada
- Los casos de prueba derivados
- Los tests manuales o automáticos

---

## Ejercicio 1 — Clases de equivalencia y valores límite

### Enunciado
Vas a implementar una función que, dado la edad de un cliente, devuelve el tipo de entrada de cine que le corresponde.

- La función recibe un parámetro `edad` que representa la edad en años cumplidos.
- Si la edad es inválida (valor negativo), la función debe **rechazar** el dato lanzando `ValueError`.
- Para edades válidas:
  - `0 ≤ edad ≤ 12` → "INFANTIL"
  - `13 ≤ edad ≤ 17` → "JOVEN"
  - `18 ≤ edad ≤ 64` → "ADULTO"
  - `edad ≥ 65` → "SENIOR"

#### Código fuente
```python
def tipo_entrada_cine(edad: int) -> str:
    if edad < 0:
        raise ValueError("edad inválida")
    if edad <= 12:
        return "INFANTIL"
    if edad <= 17:
        return "JOVEN"
    if edad <= 64:
        return "ADULTO"
    return "SENIOR"
```

---

## Ejercicio 2 — Tabla de decisión

### Enunciado
Una tienda online necesita calcular el coste de envío y si el pedido puede ser **urgente**.

Entradas:
- `prime: bool` — cliente Prime
- `importe: float` — total del carrito (sin incluir envío). Debe ser `>= 0`.
- `internacional: bool` — `True` si se envía fuera del país
- `fragil: bool` — `True` si requiere embalaje especial

Salida:
- `coste` (float, redondeado a 2 decimales)
- `urgente` (bool)

#### Código fuente
```python
from dataclasses import dataclass

@dataclass(frozen=True)
class Envio:
    coste: float
    urgente: bool

def calcular_envio(prime: bool, importe: float, internacional: bool, fragil: bool) -> Envio:
    if importe < 0:
        raise ValueError("importe inválido")

    # Base + urgente
    if internacional:
        coste = 9.99
        urgente = False
    else:
        if prime or importe >= 50:
            coste = 0.0
        else:
            coste = 4.99
        urgente = True

    # Recargo frágil
    if fragil:
        coste += 2.50

    return Envio(round(coste, 2), urgente)
```

---

## Ejercicio 3 — Casos de uso y transición de estados

### Enunciado
Vas a modelar una sesión de login de un sistema web con bloqueo por intentos fallidos.

Estados:
- `LOGGED_OUT`: no hay sesión iniciada
- `LOGGED_IN`: sesión iniciada
- `LOCKED`: cuenta bloqueada por seguridad

Operaciones:
- `login(ok: bool) -> str`
- `logout() -> str`
- `unlock() -> str`

#### Código fuente
```python
from dataclasses import dataclass

@dataclass
class SesionLogin:
    estado: str = "LOGGED_OUT"
    fallos: int = 0

    def login(self, ok: bool) -> str:
        if self.estado == "LOCKED":
            return self.estado

        if self.estado == "LOGGED_IN":
            return self.estado

        if ok:
            self.estado = "LOGGED_IN"
            self.fallos = 0
            return self.estado
        self.fallos += 1
        if self.fallos >= 3:
            self.estado = "LOCKED"
        return self.estado

    def logout(self) -> str:
        if self.estado == "LOGGED_IN":
            self.estado = "LOGGED_OUT"
            self.fallos = 0
        return self.estado

    def unlock(self) -> str:
        self.estado = "LOGGED_OUT"
        self.fallos = 0
        return self.estado
```

---

## Ejercicio 4 — Sentencias, decisiones y condiciones

### Enunciado
Implementa una función `precio_final` que aplica descuentos y recargos:

Entradas:
- `base: float` precio inicial (debe ser `>= 0`)
- `es_estudiante: bool` si aplica 10% descuento
- `tiene_cupon: bool` cupón fijo de 5€ (se resta)
- `es_festivo: bool` si es festivo, se aplica un 5% de recargo salvo que el precio haya quedado negativo tras descuentos, en cuyo caso el precio final es 0.

#### Código fuente
```python
def precio_final(base: float, es_estudiante: bool, tiene_cupon: bool, es_festivo: bool) -> float:
    if base < 0:
        raise ValueError("base inválida")

    precio = base

    if es_estudiante:
        precio *= 0.9

    if tiene_cupon:
        precio -= 5

    if es_festivo:
        if precio < 0:
            return 0.0
        precio *= 1.05

    return round(precio, 2)
```

---

## Ejercicio 5 — Condiciones múltiples y MC/DC

### Enunciado
Un banco usa una regla simplificada para **aprobar** o **rechazar** un préstamo.

Entradas:
- `credit_score: int` (puntuación crediticia)
- `income: int` (ingresos anuales)
- `debt_ratio: float` (ratio de deuda; cuanto más bajo, mejor)

Predicados atómicos:
- A: `credit_score >= 700`
- B: `income >= 30000`
- C: `debt_ratio < 0.35`

Decisión global:
- Se aprueba si: `A and (B or C)`

#### Código fuente
```python
def aprobar_prestamo(credit_score: int, income: int, debt_ratio: float) -> str:
    A = credit_score >= 700
    B = income >= 30000
    C = debt_ratio < 0.35

    if A and (B or C):
        return "APROBADO"
    return "RECHAZADO"
```

---

## Ejercicio 6 — Caminos y complejidad ciclomática

### Enunciado
Una tienda evalúa devoluciones según estas variables:

Entradas:
- `dias_desde_compra: int` — días desde la compra (0 = mismo día). Debe ser `>= 0`.
- `tiene_ticket: bool` — si el cliente presenta ticket/justificante.
- `abierto: bool` — si el producto ha sido abierto/used (impacta elegibilidad).
- `es_premium: bool` — cliente premium tiene un beneficio limitado.
- `uso_cupon: bool` — si el pedido usó cupón (si se devuelve, implica penalización si el producto está abierto).

Salidas posibles:
- "RECHAZADA"
- "ACEPTADA_COMPLETA"
- "ACEPTADA_PARCIAL"
- "ACEPTADA_CON_PENALIZACION"
- "ACEPTADA_SIN_TICKET"

#### Código fuente
```python
def evaluar_devolucion(dias_desde_compra: int, tiene_ticket: bool, abierto: bool, es_premium: bool, uso_cupon: bool) -> str:
    if dias_desde_compra < 0:
        raise ValueError("días inválidos")

    if not tiene_ticket:
        return "RECHAZADA"

    if dias_desde_compra > 30:
        if es_premium and (not abierto):
            return "ACEPTADA_SIN_TICKET"
        return "RECHAZADA"

    if abierto:
        if uso_cupon:
            return "ACEPTADA_CON_PENALIZACION"
        return "ACEPTADA_PARCIAL"

    return "ACEPTADA_COMPLETA"
```

---

> Completa para cada ejercicio: técnica, casos de prueba y tests.
