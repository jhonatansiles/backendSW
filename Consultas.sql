
-- Hacer una compra de dos cursos 

select * from Usuario
select * from Curso
select * from carrito
select * from item_carrito
select * from Pago
/* Usuarios y perfiles
Obtener información de un usuario por su ID o correo.
*/
select * from usuario where  correo='jgarcia@email.com'

select * from usuario where  id=5
/*
Listar todos los alumnos registrados.
*/
select nombre , apellido 
from usuario,alumno 
where usuario.id=alumno.id_usuario

/*

Ver los cursos en los que un usuario está inscrito y en que fecha se inscribio.
*/
SELECT curso.descripcion, pago.fecha_inicio
FROM curso
JOIN item_carrito ON item_carrito.id_curso = curso.id
JOIN carrito ON item_carrito.id_carrito = carrito.id
JOIN usuario ON carrito.id_usuario = usuario.id
JOIN pago ON carrito.id_pago = pago.id  -- Solo trae carritos que han sido pagados
WHERE usuario.id = 6;  -- Filtra por usuario específico
select * from pago
/*

Ver carrito actual de un alumno o usuario
*/
--mi cunsulta 
select curso.descripcion
from curso , alumno  ,pago , carrito , usuario , item_carrito
where   alumno.id_usuario=usuario.id and carrito.id_usuario=usuario.id 
and carrito.id_pago is null and item_carrito.id_carrito=carrito.id and 
item_carrito.id_curso= curso.id and usuario.id =6
select * from alumno
select * from usuario
select * from carrito
select * from curso
select * from item_carrito
-- la IA liciendoce pa
SELECT curso.descripcion
FROM curso
JOIN item_carrito ON item_carrito.id_curso = curso.id
JOIN carrito ON item_carrito.id_carrito = carrito.id
JOIN usuario ON carrito.id_usuario = usuario.id
WHERE carrito.id_pago IS NULL
AND usuario.id =6 ;  -- Reemplaza con el ID del usuario

/*
Ver cursos completados y en progreso de un usuario.

Consultar el historial de pagos de un usuario.

🔹 Cursos y contenido
Listar todos los cursos disponibles con sus detalles (precio, nivel, requisitos, instructor, etc.).

Consultar los cursos creados por un instructor específico.

Ver el contenido de un curso (módulos, lecciones, exámenes).

Obtener los cursos que tienen un descuento activo.

Filtrar cursos por categoría, dificultad o popularidad.

🔹 Progreso y exámenes
Consultar el progreso de un usuario en un curso (lecciones vistas, exámenes aprobados).

Obtener el puntaje de un usuario en un examen.

Listar los exámenes disponibles en un curso.

Consultar si un usuario aprobó el examen de validación para saltarse un curso.

Ver qué estudiantes han aprobado un curso en una fecha específica.

🔹 Pagos y facturación
Obtener los pagos de un usuario con fechas y montos.

Consultar los ingresos de un instructor en un periodo de tiempo.

Ver el total de ingresos generados por un curso.

Filtrar pagos por método (tarjeta, PayPal, criptomonedas, etc.).

Consultar el estado de una transacción específica.

🔹 Carrito de compras
Ver los cursos en el carrito de un usuario.

Consultar el total a pagar en el carrito.

Obtener los detalles de una compra antes de confirmar el pago.

Listar los cursos comprados por un usuario en una fecha específica.

Consultar si un usuario intentó comprar un curso que ya tiene.
*/
