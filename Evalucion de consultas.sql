/*1.Seleccione los nombres del aprendiz, el id de la asesoría, la fecha y hora de la asesoría
 de las asesorías en estado Anulada. Asegúrese de mostrar 
 SOLO los registros con un aprendiz relacionado.*/

select ap.nombres,a.idasesoria,a.fecha,a.hora,a.estado from asesorias a inner join aprendices ap
on ap.documento=a.aprendiz where estado='Anulada' order by a.idasesoria;

/*Seleccione los apellidos y nombres del aprendiz, el nombre del programa de formación
de los aprendices que sean de ADSI. Muestre también el id de la asesoría SÓLO cuando
pertenezca dicha asesoría a un aprendiz relacionado. (no pueden salir valores nulos en 
los datos del aprendiz)*/
select ap.nombres,ap.apellidos,p.nombre as nombre_programa,a.idasesoria
from aprendices ap inner join asesorias a on ap.documento=a.aprendiz
inner join programas p on p.codigo=ap.programa where codigo='001' order by ap.apellidos;

/*Seleccione los datos de la asesoría, idasesoria, fecha y hora, los apellidos y nombres 
del aprendiz, el nombre del programa de formación de los aprendices, nombre del instructor
 y nombre del asesor. SIEMPRE debe existir los datos del instructor, pero no interesa si 
 existe o no datos del asesor o del aprendiz (pueden quedar nulos). Ordene los datos
 por el id de la asesoría.*/
 select a.idasesoria,a.fecha,a.hora,ap.nombres,ap.apellidos,p.nombre as n_Programa, 
 i.nombre as instructor, ase.nombres as asesor 
 from asesorias a 
 inner join instructores i on a.instructor=i.login 
 left join aprendices ap on ap.documento=a.aprendiz 
 left join asesores ase on a.asesor=ase.codigo
 left join programas p on p.codigo=ap.programa
 order by a.idasesoria;
/*Muestre la cantidad de asesorías que se han brindado por cada programa de formación.
Debe mostrar el nombre del programa de formación y cuantas asesorías se han brindado 
en cada programa. Deben aparecer los programas de formación así ninguno de los aprendices
 haya tenido asesorías relacionadas*/
 /*cantidad*/
select p.nombre,count(ase.idasesoria) as numeroAsesoria 
from programas p left join aprendices ap on p.codigo=ap.programa left join asesorias ase 
on ap.documento=ase.aprendiz
group by p.nombre 
order by  1;
/*Muestre la cantidad de asesorías que ha brindado cada instructor. Sólo muestre los instructores
 con más de 3 asesorías.*/
select i.nombre, count(ase.idasesoria) as numeroAsesoria 
 from instructores i inner join asesorias ase  
 on  ase.instructor=i.login group by i.nombre 
 having count(*)>=3
 order by ase.idasesoria;