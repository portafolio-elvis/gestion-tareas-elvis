# KanbanPro

Una app para organizar proyectos al estilo Kanban. La hice como proyecto Full Stack usando Node.js, Express, PostgreSQL y Handlebars. Está desplegada en Vercel con base de datos en Neon.

![Preview](./public/img/preview.png)

---

## ¿Para qué sirve?

Básicamente es un tablero Kanban donde puedes:

- Crear tableros para tus proyectos
- Agregar listas (Backlog, En Progreso, Finalizado, etc.)
- Crear tarjetas con título, descripción, prioridad, etiquetas, fechas y responsable
- Mover tarjetas entre listas
- Todo queda guardado en la base de datos, nada se pierde al recargar

Cada usuario tiene su propia cuenta y solo ve sus propios tableros.

---

## Tech Stack

| Área | Tecnología |
|------|-----------|
| Backend | Node.js + Express |
| Base de datos | PostgreSQL (Neon en producción) |
| ORM | Sequelize |
| Vistas | Handlebars (HBS) |
| Estilos | Tailwind CSS |
| Animaciones | GSAP |
| Auth | JWT + bcryptjs |
| Deploy | Vercel |

---

## Funcionalidades

- **Registro e inicio de sesión** — contraseñas hasheadas con bcrypt, sesión con JWT guardado en cookie httpOnly
- **Dashboard** — carga los tableros, listas y tarjetas del usuario desde la DB en tiempo real
- **CRUD completo** — crear, editar y eliminar tableros, listas y tarjetas vía API REST
- **Rutas protegidas** — middleware que verifica el JWT antes de dar acceso al dashboard
- **Al registrarse**, se crea automáticamente un tablero de ejemplo con 3 listas y una tarjeta de bienvenida

---

## Cómo correrlo en local

**1. Clonar el repo**

```bash
git clone https://github.com/tu-usuario/kanbanpro.git
cd kanbanpro
```

**2. Instalar dependencias**

```bash
npm install
```

**3. Crear el archivo `.env`** (basado en `.env.example`)

```env
DATABASE_URL=postgresql://usuario:password@localhost:5432/kanbanpro
JWT_SECRET=una_clave_secreta_larga
CORS_ORIGIN=http://localhost:3000
NODE_ENV=development
```

**4. Iniciar en modo desarrollo**

```bash
npm run dev
```

La app corre en `http://localhost:3000`. En modo desarrollo Sequelize crea las tablas automáticamente.

---

## Deploy en Vercel

La app está desplegada en:

**[gestion-tareas-elvis.vercel.app](https://gestion-tareas-elvis.vercel.app)**

### Variables de entorno requeridas en Vercel

```
DATABASE_URL    → cadena de conexión de Neon (postgresql://...)
JWT_SECRET      → clave secreta para firmar los tokens
CORS_ORIGIN     → URL del deploy en Vercel
NODE_ENV        → production
```

### Cosas que tuve que resolver para que funcionara en Vercel

- El archivo `vercel.json` incluye las carpetas `views/` y `public/` para que el servidor las encuentre dentro de la función serverless
- `app.listen()` y `sequelize.sync()` solo corren en desarrollo, en producción no
- Se importa `pg` explícitamente en `sequelize.js` porque Vercel no lo incluye automáticamente en el bundle
- Las cookies tienen `secure: true` y `sameSite: 'none'` en producción para que funcionen en HTTPS

---

## Estructura del proyecto

```
kanbanpro/
├── app.js                  # Entrada principal, configuración Express
├── vercel.json             # Configuración para Vercel
├── config/
│   └── sequelize.js        # Conexión a PostgreSQL
├── models/
│   ├── Usuario.js
│   ├── Tablero.js
│   ├── Lista.js
│   ├── Tarjeta.js
│   └── index.js            # Relaciones entre modelos
├── routes/
│   ├── api.routes.js
│   ├── auth.route.js
│   ├── tablero.routes.js
│   ├── lista.routes.js
│   └── tarjeta.routes.js
├── controllers/
│   ├── auth.controller.js
│   ├── tablero.controller.js
│   ├── lista.controller.js
│   └── tarjeta.controller.js
├── middlewares/
│   └── auth.middleware.js  # Verificación JWT
├── views/
│   ├── layouts/main.hbs
│   ├── home.hbs
│   ├── login.hbs
│   ├── register.hbs
│   └── dashboard.hbs
└── public/
    ├── kanban.js           # Lógica frontend (drag & drop, modales)
    └── style.css           # Tailwind compilado
```

---

## API Endpoints

| Método | Ruta | Descripción |
|--------|------|-------------|
| POST | `/api/auth/register` | Registrar usuario |
| POST | `/api/auth/login` | Iniciar sesión |
| POST | `/api/auth/logout` | Cerrar sesión |
| GET | `/api/tableros` | Obtener tableros del usuario |
| POST | `/api/tableros` | Crear tablero |
| DELETE | `/api/tableros/:id` | Eliminar tablero |
| POST | `/api/listas` | Crear lista |
| DELETE | `/api/listas/:id` | Eliminar lista |
| POST | `/api/tarjetas` | Crear tarjeta |
| PUT | `/api/tarjetas/:id` | Editar tarjeta |
| DELETE | `/api/tarjetas/:id` | Eliminar tarjeta |

Todas las rutas excepto login y register requieren el JWT en cookie.

---

## Autor

Elvis Andrade 