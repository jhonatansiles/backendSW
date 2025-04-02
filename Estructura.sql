-- Crear la base de datos
CREATE DATABASE UdemyJr1;

-- Crear la tabla Permiso
CREATE TABLE Permiso (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Crear la tabla Rol
CREATE TABLE Rol (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

-- Crear la tabla roles_permisos
CREATE TABLE roles_permisos (
    id SERIAL PRIMARY KEY,
    id_permiso INT NOT NULL,
    id_rol INT NOT NULL,
    FOREIGN KEY (id_permiso) REFERENCES Permiso(id) ON DELETE CASCADE,
    FOREIGN KEY (id_rol) REFERENCES Rol(id) ON DELETE CASCADE
);

-- Crear la tabla Usuario
CREATE TABLE Usuario (
    id SERIAL PRIMARY KEY,
    apellido VARCHAR(255),
    correo VARCHAR(255) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    id_suscripcion INT,
    nombre VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Crear la tabla Admin
CREATE TABLE Admin (
    id SERIAL PRIMARY KEY,
    cargo VARCHAR(255),
    id_usuario INT UNIQUE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE
);

-- Crear la tabla Docente
CREATE TABLE Docente (
    id SERIAL PRIMARY KEY,
    telefono VARCHAR(255),
    id_usuario INT UNIQUE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE
);

-- Crear la tabla Alumno
CREATE TABLE Alumno (
    id SERIAL PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE
);

-- Crear la tabla Categoria
CREATE TABLE Categoria (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT
);

-- Crear la tabla Curso
CREATE TABLE Curso (
    id SERIAL PRIMARY KEY,
    descripcion VARCHAR(255),
    id_categoria INT,
    id_docente INT,
    descuento NUMERIC(10,2),
    imagen VARCHAR(255),
    precio NUMERIC(10,2),
    titulo VARCHAR(255),
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id) ON DELETE SET NULL,
    FOREIGN KEY (id_docente) REFERENCES Docente(id) ON DELETE SET NULL
);

-- Crear la tabla Esquema
CREATE TABLE Esquema (
    id SERIAL PRIMARY KEY,
    contenido TEXT,
    id_alumno INT NOT NULL,
    id_curso INT NOT NULL,
    titulo VARCHAR(255),
    FOREIGN KEY (id_alumno) REFERENCES Alumno(id) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES Curso(id) ON DELETE CASCADE
);

-- Crear la tabla Reporte
CREATE TABLE Reporte (
    id SERIAL PRIMARY KEY,
    descripcion TEXT,
    tipo VARCHAR(255)
);

-- Crear la tabla Tema
CREATE TABLE Tema (
    id SERIAL PRIMARY KEY,
    descripcion TEXT,
    id_curso INT NOT NULL,
    titulo VARCHAR(255),
    FOREIGN KEY (id_curso) REFERENCES Curso(id) ON DELETE CASCADE
);

-- Crear la tabla Ejemplo
CREATE TABLE Ejemplo (
    id SERIAL PRIMARY KEY,
    contenido_audio TEXT,
    contenido_imagen TEXT,
    contenido_video TEXT,
    id_tema INT NOT NULL,
    FOREIGN KEY (id_tema) REFERENCES Tema(id) ON DELETE CASCADE
);

-- Crear la tabla Examen (modificada)
CREATE TABLE Examen (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(255) NOT NULL,
  descripcion TEXT,
  id_curso INT NOT NULL,
  duracion INT NOT NULL, -- NUEVO CAMPO
  fecha_inicio DATE NOT NULL, -- NUEVO CAMPO
  fecha_fin DATE NOT NULL, -- NUEVO CAMPO
  FOREIGN KEY (id_curso) REFERENCES Curso(id) ON DELETE CASCADE
);

-- Crear la tabla Pregunta (modificada)
CREATE TABLE Pregunta (
  id SERIAL PRIMARY KEY,
  texto VARCHAR(255) NOT NULL,
  id_tema INT NOT NULL,
  FOREIGN KEY (id_tema) REFERENCES Tema(id) ON DELETE CASCADE
);

-- Crear la tabla Opcion_Respuesta (NUEVA TABLA)
CREATE TABLE Opcion_Respuesta (
  id SERIAL PRIMARY KEY,
  texto VARCHAR(255) NOT NULL,
  id_pregunta INT NOT NULL,
  FOREIGN KEY (id_pregunta) REFERENCES Pregunta(id) ON DELETE CASCADE
);

-- Crear la tabla Examen_Pregunta (NUEVA TABLA)
CREATE TABLE Examen_Pregunta (
  id SERIAL PRIMARY KEY,
  id_examen INT NOT NULL,
  id_pregunta INT NOT NULL,
  FOREIGN KEY (id_examen) REFERENCES Examen(id) ON DELETE CASCADE,
  FOREIGN KEY (id_pregunta) REFERENCES Pregunta(id) ON DELETE CASCADE
);

-- Crear la tabla Resultado_Examen (NUEVA TABLA)
CREATE TABLE Resultado_Examen (
  id SERIAL PRIMARY KEY,
  id_alumno INT NOT NULL,
  id_examen INT NOT NULL,
  nota INT NOT NULL,
  fecha DATE NOT NULL,
  FOREIGN KEY (id_alumno) REFERENCES Alumno(id) ON DELETE CASCADE,
  FOREIGN KEY (id_examen) REFERENCES Examen(id) ON DELETE CASCADE
);

-- Crear la tabla mensaje
CREATE TABLE mensaje (
    id SERIAL PRIMARY KEY,
    fecha TIMESTAMP DEFAULT NOW(),
    id_alumno INT NOT NULL,
    id_mensaje_respuesta INT NULL,
    mensaje TEXT NOT NULL,
    FOREIGN KEY (id_alumno) REFERENCES Alumno(id) ON DELETE CASCADE,
    FOREIGN KEY (id_mensaje_respuesta) REFERENCES mensaje(id) ON DELETE SET NULL
);

-- Crear la tabla debate
CREATE TABLE debate (
    id SERIAL PRIMARY KEY,
    fecha TIMESTAMP DEFAULT NOW()
);

-- Crear la tabla Tipo_pago
CREATE TABLE Tipo_pago (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

-- Crear la tabla Pago
CREATE TABLE Pago (
    id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    id_usuario INT NOT NULL,
    id_tipo_pago INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (id_tipo_pago) REFERENCES Tipo_pago(id) ON DELETE CASCADE
);

-- Crear la tabla carrito
CREATE TABLE carrito (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE
);

-- Crear la tabla Item_carrito
CREATE TABLE Item_carrito (
    id SERIAL PRIMARY KEY,
    id_carrito INT NOT NULL,
    id_curso INT NOT NULL,
    FOREIGN KEY (id_carrito) REFERENCES carrito(id) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES Curso(id) ON DELETE CASCADE
);

-- Crear la tabla notificaciones
CREATE TABLE notificaciones (
    id SERIAL PRIMARY KEY,
    asunto VARCHAR(255),
    descripcion TEXT,
    id_alumno INT NOT NULL,
    tipo VARCHAR(255),
    FOREIGN KEY (id_alumno) REFERENCES Alumno(id) ON DELETE CASCADE
);



--######################################################################################################################################
--
--###########################################################################################################################################


-- Insertar permisos
INSERT INTO Permiso (name)
VALUES
  ('admin'),
  ('docente'),
  ('alumno');

-- Insertar roles
INSERT INTO Rol (nombre)
VALUES
  ('Administrador'),
  ('Docente'),
  ('Alumno');

-- Insertar roles_permisos
INSERT INTO roles_permisos (id_permiso, id_rol)
VALUES
  (1, 1),
  (2, 2),
  (3, 3);

-- Insertar usuarios
INSERT INTO Usuario (apellido, correo, fecha_nacimiento, id_suscripcion, nombre, password)
VALUES
  ('Pérez', 'juan@example.com', '1990-01-01', 1, 'Juan', 'password123'),
  ('Gómez', 'maria@example.com', '1992-02-02', 2, 'María', 'password123'),
  ('López', 'carlos@example.com', '1995-03-03', 3, 'Carlos', 'password123');

-- Insertar admins
INSERT INTO Admin (cargo, id_usuario)
VALUES
  ('Director', 1);

-- Insertar docentes
INSERT INTO Docente (telefono, id_usuario)
VALUES
  ('1234567890', 2);
-- Insertar alumnos
INSERT INTO Alumno (id_usuario)
VALUES
  (3);

-- Insertar categorías
INSERT INTO Categoria (nombre, descripcion)
VALUES
  ('Tecnología', 'Cursos de tecnología'),
  ('Arte', 'Cursos de arte'),
  ('Deportes', 'Cursos de deportes');
select * from curso
-- Insertar cursos
INSERT INTO Curso (descripcion, id_categoria, id_docente, descuento, imagen, precio, titulo)
VALUES
  ('Curso de programación', 1, 1, 10.00, 'imagen1.jpg', 100.00, 'Programación'),
  ('Curso de pintura', 2, 1, 20.00, 'imagen2.jpg', 200.00, 'Pintura'),
  ('Curso de fútbol', 3, 1, 30.00, 'imagen3.jpg', 300.00, 'Fútbol');

-- Insertar temas
INSERT INTO Tema (descripcion, id_curso, titulo)
VALUES
  ('Introducción a la programación', 9, 'Programación'),
  ('Técnicas de pintura', 10, 'Pintura'),
  ('Técnicas de fútbol', 11, 'Fútbol');
select * from tema
-- Insertar ejemplos
INSERT INTO Ejemplo (contenido_audio, contenido_imagen, contenido_video, id_tema)
VALUES
  ('audio1.mp3', 'imagen1.jpg', 'video1.mp4', 1),
  ('audio2.mp3', 'imagen2.jpg', 'video2.mp4', 2),
  ('audio3.mp3', 'imagen3.jpg', 'video3.mp4', 6);

-- Insertar exámenes
INSERT INTO Examen (titulo, descripcion, id_curso, duracion, fecha_inicio, fecha_fin)
VALUES
  ('Examen de programación', 'Examen para evaluar los conocimientos de programación', 9, 60, '2023-01-01', '2023-01-31'),
  ('Examen de pintura', 'Examen para evaluar los conocimientos de pintura', 10, 90, '2023-02-01', '2023-02-28'),
  ('Examen de fútbol', 'Examen para evaluar los conocimientos de fútbol', 11, 120, '2023-03-01', '2023-03-31');

-- Insertar preguntas
INSERT INTO Pregunta (texto, id_tema)
VALUES
  ('¿Cuál es el lenguaje de programación más popular?', 6),
  ('¿Cuál es la técnica de pintura más utilizada?', 7),
  ('¿Cuál es el equipo de fútbol más ganador?', 8);
select * from pregunta
-- Insertar opciones de respuesta
INSERT INTO Opcion_Respuesta (texto, id_pregunta)
VALUES
  ('Java', 1),
  ('Python', 1),
  ('C++', 1),
  ('Acuarela', 2),
  ('Óleo', 2),
  ('Acrílico', 2),
  ('Barcelona', 3),
  ('Real Madrid', 3),
  ('Manchester United', 3);

-- Insertar exámenes_preguntas
INSERT INTO Examen_Pregunta (id_examen, id_pregunta)
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (2, 2),
  (2, 3),
  (2, 1),
  (3, 3),
  (3, 2);

-- Insertar resultados de exámenes
INSERT INTO Resultado_Examen (id_alumno, id_examen, nota, fecha)
VALUES
  (1, 1, 80, '2023-01-15'),
  (1, 2, 90, '2023-02-15'),
  (1, 3, 70, '2023-03-15');

-- Insertar mensajes
INSERT INTO mensaje (fecha, id_alumno, id_mensaje_respuesta, mensaje)
VALUES
  ('2023-01-01', 1, NULL, 'Hola, ¿cómo estás?'),
  ('2023-01-02', 1, 1, 'Estoy bien, gracias'),
  ('2023-01-03', 1, 2, 'Genial, ¿qué onda?');

-- Insertar debates
INSERT INTO debate (fecha)
VALUES
  ('2023-01-01'),
  ('2023-01-02'),
  ('2023-01-03');

-- Insertar tipos de pago
INSERT INTO Tipo_pago (nombre)
VALUES
  ('Tarjeta de crédito'),
  ('PayPal'),
  ('Transferencia bancaria');

-- Insertar pagos
INSERT INTO Pago (fecha, id_usuario, id_tipo_pago)
VALUES
  ('2023-01-01', 1, 1),
  ('2023-01-02', 2, 2),
  ('2023-01-03', 3, 3);

-- Insertar carritos
INSERT INTO carrito (id_usuario)
VALUES
  (1),
  (2),
  (3);

-- Insertar items de carrito
INSERT INTO Item_carrito (id_carrito, id_curso)
VALUES
  (1, 1),
  (1, 2),
  (2, 2),
  (3, 1),
  (3, 2);

-- Insertar notificaciones
INSERT INTO notificaciones (asunto, descripcion, id_alumno, tipo)
VALUES
  ('Nueva notificación', 'Esta es una notificación nueva', 1, 'información'),
  ('Recordatorio', 'No te olvides de hacer tu tarea',1, 'recordatorio'),
  ('Aviso', 'Hay un problema con tu cuenta', 1, 'aviso');
