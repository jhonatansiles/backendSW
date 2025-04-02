create database UdemyJr

CREATE TABLE Permiso (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE Rol (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE roles_permisos (
    id SERIAL PRIMARY KEY,
    id_permiso INT NOT NULL,
    id_rol INT NOT NULL,
    FOREIGN KEY (id_permiso) REFERENCES Permiso(id) ON DELETE CASCADE,
    FOREIGN KEY (id_rol) REFERENCES Rol(id) ON DELETE CASCADE
);

CREATE TABLE Usuario (
    id SERIAL PRIMARY KEY,
    apellido VARCHAR(255),
    correo VARCHAR(255) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    id_suscripcion INT,
    nombre VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE Admin (
    id SERIAL PRIMARY KEY,
    cargo VARCHAR(255),
    id_usuario INT UNIQUE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE
);

CREATE TABLE Docente (
    id SERIAL PRIMARY KEY,
    telefono VARCHAR(255),
    id_usuario INT UNIQUE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE
);

CREATE TABLE Alumno (
    id SERIAL PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE
);

CREATE TABLE Categoria (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT
);

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

CREATE TABLE Esquema (
    id SERIAL PRIMARY KEY,
    contenido TEXT,
    id_alumno INT NOT NULL,
    id_curso INT NOT NULL,
    titulo VARCHAR(255),
    FOREIGN KEY (id_alumno) REFERENCES Alumno(id) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES Curso(id) ON DELETE CASCADE
);

CREATE TABLE Reporte (
    id SERIAL PRIMARY KEY,
    descripcion TEXT,
    tipo VARCHAR(255)
);

CREATE TABLE Tema (
    id SERIAL PRIMARY KEY,
    descripcion TEXT,
    id_curso INT NOT NULL,
    titulo VARCHAR(255),
    FOREIGN KEY (id_curso) REFERENCES Curso(id) ON DELETE CASCADE
);

CREATE TABLE Ejemplo (
    id SERIAL PRIMARY KEY,
    contenido_audio TEXT,
    contenido_imagen TEXT,
    contenido_video TEXT,
    id_tema INT NOT NULL,
    FOREIGN KEY (id_tema) REFERENCES Tema(id) ON DELETE CASCADE
);

CREATE TABLE Examen (
    codigo SERIAL PRIMARY KEY,
    contenido TEXT,
    id_curso INT NOT NULL,
    id_tema INT NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES Curso(id) ON DELETE CASCADE,
    FOREIGN KEY (id_tema) REFERENCES Tema(id) ON DELETE CASCADE
);

CREATE TABLE Pregunta (
    id SERIAL PRIMARY KEY,
    id_examen INT NOT NULL,
    pregunta VARCHAR(255) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_examen) REFERENCES Examen(codigo) ON DELETE CASCADE
);

CREATE TABLE Respuesta (
    id SERIAL PRIMARY KEY,
    id_alumno INT NOT NULL,
    id_pregunta INT NOT NULL,
    respuesta TEXT NOT NULL,
    FOREIGN KEY (id_alumno) REFERENCES Alumno(id) ON DELETE CASCADE,
    FOREIGN KEY (id_pregunta) REFERENCES Pregunta(id) ON DELETE CASCADE
);

CREATE TABLE alumno_examen (
    id SERIAL PRIMARY KEY,
    fecha_tomado DATE NOT NULL,
    id_alumno INT NOT NULL,
    id_examen INT NOT NULL,
    nota INT NOT NULL,
    FOREIGN KEY (id_alumno) REFERENCES Alumno(id) ON DELETE CASCADE,
    FOREIGN KEY (id_examen) REFERENCES Examen(codigo) ON DELETE CASCADE
);

CREATE TABLE mensaje (
    id SERIAL PRIMARY KEY,
    fecha TIMESTAMP DEFAULT NOW(),
    id_alumno INT NOT NULL,
    id_mensaje_respuesta INT NULL,
    mensaje TEXT NOT NULL,
    FOREIGN KEY (id_alumno) REFERENCES Alumno(id) ON DELETE CASCADE,
    FOREIGN KEY (id_mensaje_respuesta) REFERENCES mensaje(id) ON DELETE SET NULL
);

CREATE TABLE debate (
    id SERIAL PRIMARY KEY,
    fecha TIMESTAMP DEFAULT NOW()
);

CREATE TABLE Tipo_pago (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);
CREATE TABLE Pago (
    id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    id_usuario INT NOT NULL,
    id_tipo_pago INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (id_tipo_pago) REFERENCES Tipo_pago(id) ON DELETE CASCADE
);


CREATE TABLE carrito (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE
);

CREATE TABLE Item_carrito (
    id SERIAL PRIMARY KEY,
    id_carrito INT NOT NULL,
    id_curso INT NOT NULL,
    FOREIGN KEY (id_carrito) REFERENCES carrito(id) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES Curso(id) ON DELETE CASCADE
);

CREATE TABLE notificaciones (
    id SERIAL PRIMARY KEY,
    asunto VARCHAR(255),
    descripcion TEXT,
    id_alumno INT NOT NULL,
    tipo VARCHAR(255),
    FOREIGN KEY (id_alumno) REFERENCES Alumno(id) ON DELETE CASCADE
);

-- Inserción en la tabla Permiso
INSERT INTO Permiso (name) VALUES 
('Crear Curso'), 
('Eliminar Usuario'), 
('Editar Perfil');

-- Inserción en la tabla Rol
INSERT INTO Rol (nombre) VALUES 
('Administrador'), 
('Docente'), 
('Alumno');

-- Asignación de permisos a roles
INSERT INTO roles_permisos (id_permiso, id_rol) VALUES 
(1, 2), -- Docente puede crear curso
(2, 1), -- Administrador puede eliminar usuarios
(3, 3); -- Alumno puede editar perfil

-- Inserción en la tabla Usuario
INSERT INTO Usuario (apellido, correo, fecha_nacimiento, nombre, password) VALUES 
('García', 'jgarcia@email.com', '1990-05-12', 'Juan', 'hashed_password1'),
('López', 'alopez@email.com', '1985-09-23', 'Ana', 'hashed_password2'),
('Martínez', 'cmartinez@email.com', '1998-07-14', 'Carlos', 'hashed_password3');

-- Inserción en la tabla Admin
INSERT INTO Admin (cargo, id_usuario) VALUES 
('Superadmin', 4);

-- Inserción en la tabla Docente
INSERT INTO Docente (telefono, id_usuario) VALUES 
('123-456-7890', 5);
-- Inserción en la tabla Alumno
INSERT INTO Alumno (id_usuario) VALUES 
(6);
-- Inserción en la tabla Categoria
INSERT INTO Categoria (nombre, descripcion) VALUES 
('Matemáticas', 'Cursos de álgebra, cálculo y más'), 
('Programación', 'Cursos de Python, Java y otros lenguajes');

-- Inserción en la tabla Curso
INSERT INTO Curso (descripcion, id_categoria, id_docente, imagen, precio, titulo) VALUES 
('Curso de Álgebra básica', 6, 2, 'algebra.jpg', 49.99, 'Álgebra 101'), 
('Curso de Python para principiantes', 5, 2, 'python.jpg', 59.99, 'Python desde cero');

-- Inserción en la tabla Tema
INSERT INTO Tema (descripcion, id_curso, titulo) VALUES 
('Ecuaciones lineales', 17, 'Tema 1: Ecuaciones'), 
('Variables y Tipos de Datos en Python', 18, 'Tema 1: Introducción');

-- Inserción en la tabla Ejemplo
INSERT INTO Ejemplo (contenido_audio, contenido_imagen, contenido_video, id_tema) VALUES 
('audio1.mp3', 'imagen1.png', 'video1.mp4', 3), 
('audio2.mp3', 'imagen2.png', 'video2.mp4', 4);

-- Inserción en la tabla Examen
INSERT INTO Examen (contenido, id_curso, id_tema) VALUES 
('Examen de Álgebra Básica', 17, 3), 
('Examen de Introducción a Python', 18, 4);

-- Inserción en la tabla Pregunta
INSERT INTO Pregunta (id_examen, pregunta, tipo) VALUES 
(5, '¿Cuánto es 2x + 3 = 7?', 'Opción Múltiple'), 
(6, '¿Qué tipo de dato es "Hola Mundo" en Python?', 'Opción Múltiple');

-- Inserción en la tabla Respuesta
INSERT INTO Respuesta (id_alumno, id_pregunta, respuesta) VALUES 
(2, 3, 'x = 2'), 
(2, 4, 'String');

-- Inserción en la tabla alumno_examen
INSERT INTO alumno_examen (fecha_tomado, id_alumno, id_examen, nota) VALUES 
('2025-03-30', 2, 5, 85), 
('2025-03-30', 2, 6, 90);

-- Inserción en la tabla carrito
INSERT INTO carrito (id_usuario) VALUES 
(6);
-- Inserción en la tabla Item_carrito
INSERT INTO Item_carrito (id_carrito, id_curso) VALUES 
(2, 18);
-- Inserción en la tabla Suscripción
INSERT INTO pago (fecha_inicio, id_usuario, id_tipo_pago) VALUES 
('2025-03-01', 6, 1);

-- Inserción en la tabla Tipo_pago
INSERT INTO Tipo_pago (nombre) VALUES 
('Tarjeta de Crédito'), 
('PayPal');

-- Inserción en la tabla notificaciones
INSERT INTO notificaciones (asunto, descripcion, id_alumno, tipo) VALUES 
('Nuevo Curso Disponible', 'Se ha agregado un nuevo curso de Álgebra', 2, 'Información');



