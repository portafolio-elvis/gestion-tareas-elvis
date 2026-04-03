-- ============================================================
--  KanbanPro – Estructura de base de datos
--  Compatible con PostgreSQL (Neon, Supabase, Railway, etc.)
--  Generado desde los modelos Sequelize del proyecto
-- ============================================================

-- Tabla: Usuarios
CREATE TABLE IF NOT EXISTS "Usuarios" (
  "id"         SERIAL       PRIMARY KEY,
  "nombre"     VARCHAR(255) NOT NULL,
  "email"      VARCHAR(255) UNIQUE,
  "password"   VARCHAR(255),
  "rol"        VARCHAR(255) DEFAULT 'usuario',
  "createdAt"  TIMESTAMP    NOT NULL DEFAULT NOW(),
  "updatedAt"  TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- Tabla: Tableros
CREATE TABLE IF NOT EXISTS "Tableros" (
  "id"          SERIAL       PRIMARY KEY,
  "nombre"      VARCHAR(255) NOT NULL,
  "descripcion" TEXT,
  "usuarioId"   INTEGER      REFERENCES "Usuarios"("id") ON DELETE CASCADE,
  "createdAt"   TIMESTAMP    NOT NULL DEFAULT NOW(),
  "updatedAt"   TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- Tabla: Listas
CREATE TABLE IF NOT EXISTS "Listas" (
  "id"         SERIAL       PRIMARY KEY,
  "nombre"     VARCHAR(255) NOT NULL,
  "tableroId"  INTEGER      REFERENCES "Tableros"("id") ON DELETE CASCADE,
  "createdAt"  TIMESTAMP    NOT NULL DEFAULT NOW(),
  "updatedAt"  TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- Tabla: Tarjetas
CREATE TABLE IF NOT EXISTS "Tarjetas" (
  "id"           SERIAL       PRIMARY KEY,
  "titulo"       VARCHAR(255) NOT NULL,
  "descripcion"  TEXT,
  "prioridad"    VARCHAR(255),
  "tag"          VARCHAR(255),
  "fecha_inicio" VARCHAR(255),
  "fecha_fin"    VARCHAR(255),
  "autor"        VARCHAR(255),
  "responsable"  VARCHAR(255),
  "estado"       VARCHAR(255),
  "listaId"      INTEGER      REFERENCES "Listas"("id") ON DELETE CASCADE,
  "createdAt"    TIMESTAMP    NOT NULL DEFAULT NOW(),
  "updatedAt"    TIMESTAMP    NOT NULL DEFAULT NOW()
);
