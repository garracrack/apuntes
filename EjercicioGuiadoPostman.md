
# EJERCICIO GUIADO EN POSTMAN

1.  **Colección modelo** (requests exactos y orden)
    
2.  **Pack de tests base** 
    

   

> **Nota importante (muy útil para evitar confusión):** JSONPlaceholder **simula** el POST, pero **no persiste** realmente el recurso. O sea, puedes hacer POST y te devuelve `201` con un `id`, pero luego ese `id` no necesariamente existe para un GET real.  
> Para el ejercicio de “encadenar requests”, conviene usar:
> 
> -   **GET existente → guardar id → GET por id**, o
>     
> -   `httpbin` para eco/inspección.
>     

----------

# 1) Colección modelo (lista exacta de requests en orden)

## Nombre de la colección

**Curso Postman Básico - Modelo**

## Environment recomendado: `dev`

Variables (crear antes de empezar):

-   `base_url` = `https://jsonplaceholder.typicode.com`
    
-   `post_id` = _(vacío)_
    
-   `timestamp` = _(vacío)_
    
-   `randomId` = _(vacío)_
    
-   `alumno` = `TuNombre`
    

----------

## Estructura recomendada de la colección

### Carpeta 01 - GET y params

### 1. `GET - Posts por usuario`

-   **Método:** `GET`
    
-   **URL:** `{{base_url}}/posts`
    
-   **Params:**
    
    -   `userId = 1`
        

**Tests (pegarlos en Tests):**

```javascript
pm.test("Status code es 200", function () {
    pm.response.to.have.status(200);
});

pm.test("La respuesta es JSON", function () {
    pm.response.to.be.json;
});

pm.test("La respuesta es un array", function () {
    const data = pm.response.json();
    pm.expect(Array.isArray(data)).to.eql(true);
});

pm.test("Hay al menos un elemento", function () {
    const data = pm.response.json();
    pm.expect(data.length).to.be.above(0);
});

```

----------

### 2. `GET - Posts por ID (manual)`

-   **Método:** `GET`
    
-   **URL:** `{{base_url}}/posts/1`
    

**Tests:**

```javascript
pm.test("Status code es 200", function () {
    pm.response.to.have.status(200);
});

pm.test("El body tiene id=1", function () {
    const data = pm.response.json();
    pm.expect(data.id).to.eql(1);
});

```

----------

### 3. `GET - Echo anything (httpbin)`

-   **Método:** `GET`
    
-   **URL:** `https://httpbin.org/anything`
    
-   **Params:**
    
    -   `curso = postman`
        
-   **Headers:**
    
    -   `X-Curso: Basico`
        

**Tests:**

```javascript
pm.test("Status code es 200", function () {
    pm.response.to.have.status(200);
});

pm.test("El query param curso llega", function () {
    const data = pm.response.json();
    pm.expect(data.args.curso).to.eql("postman");
});

pm.test("El header X-Curso llega", function () {
    const data = pm.response.json();
    const headers = data.headers || {};
    pm.expect(JSON.stringify(headers).toLowerCase()).to.include("x-curso");
});

```

----------

## Carpeta 02 - Body JSON (POST / PATCH / DELETE)

### 4. `POST - Crear post (simple)`

-   **Método:** `POST`
    
-   **URL:** `{{base_url}}/posts`
    
-   **Body → raw → JSON:**
    

```json
{
  "title": "Mi primer post desde Postman",
  "body": "Probando POST",
  "userId": 1
}

```

**Tests:**

```javascript
pm.test("Status code es 201", function () {
    pm.response.to.have.status(201);
});

pm.test("La respuesta devuelve un id", function () {
    const data = pm.response.json();
    pm.expect(data).to.have.property("id");
});

```

----------

### 5. `PATCH - Modificar post`

-   **Método:** `PATCH`
    
-   **URL:** `{{base_url}}/posts/1`
    
-   **Body → raw → JSON:**
    

```json
{
  "title": "Titulo modificado desde Postman"
}

```

**Tests:**

```javascript
pm.test("Status code es 200", function () {
    pm.response.to.have.status(200);
});

pm.test("Devuelve el title modificado", function () {
    const data = pm.response.json();
    pm.expect(data.title).to.eql("Titulo modificado desde Postman");
});

```

----------

### 6. `DELETE - Eliminar post`

-   **Método:** `DELETE`
    
-   **URL:** `{{base_url}}/posts/1`
    

**Tests:**

```javascript
pm.test("Status code es 200 o 204", function () {
    pm.expect(pm.response.code).to.be.oneOf([200, 202, 204]);
});

```

----------

## Carpeta 03 - Auth

### 7. `GET - Basic Auth (httpbin)`

-   **Método:** `GET`
    
-   **URL:** `https://httpbin.org/basic-auth/alumno/secreto`
    
-   **Auth:** Basic Auth
    
    -   Username: `alumno`
        
    -   Password: `secreto`
        

**Tests:**

```javascript
pm.test("Status code es 200", function () {
    pm.response.to.have.status(200);
});

pm.test("Autenticación correcta", function () {
    const data = pm.response.json();
    pm.expect(data.authenticated).to.eql(true);
    pm.expect(data.user).to.eql("alumno");
});

```

----------

## Carpeta 04 - Variables, scripts y encadenado

### 8. `POST - Crear post (dinámico)`

-   **Método:** `POST`
    
-   **URL:** `{{base_url}}/posts`
    

**Pre-request Script:**

```javascript
pm.environment.set("timestamp", new Date().toISOString());
pm.environment.set("randomId", Math.floor(Math.random() * 100000));

```

**Body → raw → JSON:**

```json
{
  "title": "Post {{randomId}}",
  "body": "Creado en {{timestamp}}",
  "userId": 1
}

```

**Tests:**

```javascript
pm.test("Status code es 201", function () {
    pm.response.to.have.status(201);
});

pm.test("La respuesta contiene id", function () {
    const data = pm.response.json();
    pm.expect(data).to.have.property("id");
});

```

----------

### 9. `GET - Guardar post_id desde post existente`

_(Este reemplaza el encadenado POST→GET por la limitación de JSONPlaceholder)_

-   **Método:** `GET`
    
-   **URL:** `{{base_url}}/posts/1`
    

**Tests (guardar variable):**

```javascript
pm.test("Status code es 200", function () {
    pm.response.to.have.status(200);
});

const data = pm.response.json();
pm.environment.set("post_id", data.id);

pm.test("Se guarda post_id en environment", function () {
    pm.expect(pm.environment.get("post_id")).to.eql(String(data.id));
});

```

----------

### 10. `GET - Post por {{post_id}}`

-   **Método:** `GET`
    
-   **URL:** `{{base_url}}/posts/{{post_id}}`
    

**Tests:**

```javascript
pm.test("Status code es 200", function () {
    pm.response.to.have.status(200);
});

pm.test("El id coincide con post_id", function () {
    const data = pm.response.json();
    pm.expect(String(data.id)).to.eql(String(pm.environment.get("post_id")));
});

```

----------

### 11. `GET - Echo con header alumno`

-   **Método:** `GET`
    
-   **URL:** `https://httpbin.org/anything`
    
-   **Headers:**
    
    -   `X-Alumno: {{alumno}}`
        

**Tests:**

```javascript
pm.test("Status code es 200", function () {
    pm.response.to.have.status(200);
});

pm.test("El header X-Alumno llega", function () {
    const data = pm.response.json();
    const raw = JSON.stringify(data.headers || {}).toLowerCase();
    pm.expect(raw).to.include("x-alumno");
});

```

----------

## Carpeta 05 - Runner (orden sugerido)

Para ejecutar en el Runner (orden recomendado):

1.  GET - Posts por usuario
    
2.  GET - Echo anything
    
3.  POST - Crear post (simple)
    
4.  PATCH - Modificar post
    
5.  DELETE - Eliminar post
    
6.  GET - Basic Auth (httpbin)
    
7.  POST - Crear post (dinámico)
    
8.  GET - Guardar post_id desde post existente
    
9.  GET - Post por {{post_id}}
    
10.  GET - Echo con header alumno
    

----------

# 2) Pack de tests base (copy/paste)

Estos son snippets reutilizables listos para copiar y adaptar.

----------

## A. Validar status code exacto

```javascript
pm.test("Status code esperado", function () {
    pm.response.to.have.status(200); // cambia 200 por 201, 204, etc.
});

```

----------

## B. Validar que la respuesta es JSON

```javascript
pm.test("La respuesta es JSON", function () {
    pm.response.to.be.json;
});

```

----------

## C. Validar array no vacío

```javascript
pm.test("Respuesta tipo array no vacío", function () {
    const data = pm.response.json();
    pm.expect(Array.isArray(data)).to.eql(true);
    pm.expect(data.length).to.be.above(0);
});

```

----------

## D. Validar que existe una propiedad

```javascript
pm.test("Existe la propiedad 'id'", function () {
    const data = pm.response.json();
    pm.expect(data).to.have.property("id");
});

```

----------

## E. Validar valor de propiedad

```javascript
pm.test("userId es 1", function () {
    const data = pm.response.json();
    pm.expect(data.userId).to.eql(1);
});

```

----------

## F. Guardar dato en variable de entorno

```javascript
const data = pm.response.json();
pm.environment.set("post_id", data.id);

pm.test("post_id guardado", function () {
    pm.expect(pm.environment.get("post_id")).to.exist;
});

```

----------

## G. Comparar respuesta con variable de entorno

```javascript
pm.test("El id coincide con post_id", function () {
    const data = pm.response.json();
    pm.expect(String(data.id)).to.eql(String(pm.environment.get("post_id")));
});

```

----------

## H. Validar tiempo de respuesta (simple)

```javascript
pm.test("Tiempo de respuesta < 1000 ms", function () {
    pm.expect(pm.response.responseTime).to.be.below(1000);
});

```

----------

## I. Validar header de respuesta

```javascript
pm.test("Content-Type incluye json", function () {
    const contentType = pm.response.headers.get("Content-Type") || "";
    pm.expect(contentType.toLowerCase()).to.include("json");
});

```

----------

## J. Validar query param/header en httpbin (eco)

```javascript
pm.test("httpbin devuelve args y headers", function () {
    const data = pm.response.json();
    pm.expect(data).to.have.property("args");
    pm.expect(data).to.have.property("headers");
});

```

----------

## K. Helper robusto para parsear JSON (opcional)

_(Útil si alguno intenta hacer tests sobre respuestas vacías/no JSON)_

```javascript
let data;

pm.test("Respuesta parseable como JSON", function () {
    data = pm.response.json();
    pm.expect(data).to.not.eql(null);
});

```

----------

# 3) Pack de Pre-request scripts (base)

## A. Timestamp ISO

```javascript
pm.environment.set("timestamp", new Date().toISOString());

```

## B. Número aleatorio

```javascript
pm.environment.set("randomId", Math.floor(Math.random() * 100000));

```

## C. Ambos juntos

```javascript
pm.environment.set("timestamp", new Date().toISOString());
pm.environment.set("randomId", Math.floor(Math.random() * 100000));

```
## Ejercicio
### Realiza una 

### Runner (colección)

✅ Debe verse:

-   ejecución de varios requests
    
-   resumen pass/fail
    
-   alumnos saben localizar en qué request falló
    

❌ Errores típicos:

-   orden incorrecto (variables no definidas aún)
    
-   environment no seleccionado en Runner
    
-   tests “frágiles” (p. ej. esperar exactamente un tamaño de array)
    


