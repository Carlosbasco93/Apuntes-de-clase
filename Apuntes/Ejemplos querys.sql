#use publications; #Comando + enter para ejecutar / Equivale a hacer doble click en el Schema
SELECT au_fname, au_lname, city 
FROM authors
where city='Salt Lake City';

select t.title, sum(t.price*s.qty) as revenue
from titles as t
left join sales as s
on t.title_id = s.title_id
group by title #Siempre hay que usar una suma, conteo o algo al usar group by
order by revenue asc;

select title, group_concat(concat(au_fname,' ', au_lname))as names
from authors as a
left join titleauthor as ta
on a.au_id = ta.au_id
left join titles as t
on t.title_id = ta.title_id
group by title;

select * 
FROM publishers
where city = 'Boston' or city= 'Chicago'
;

select *  #Equivalente útil para poner más casos
FROM publishers
where city in ('Boston','Chicago')
;

select price*qty as revenue#* #Many to Many // Los calculos que queramos van en el asterisco
from titles as t
left join titleauthor as ta
on t.title_id=ta.title_id
left join authors as a
on ta.au_id=a.au_id
#Esto puede seguir así...
left join sales as sa
on t.title_id=sa.title_id
left join stores as st
on sa.stor_id=st.stor_id
;

select t.title, concat(a.au_fname,' ', a.au_lname) completename
from titles as t
left join titleauthor as ta
on t.title_id=ta.title_id
left join authors as a
on ta.au_id=a.au_id
;

select t.title,
	group_concat(concat(a.au_fname, ' ', a.au_lname)) allauthors,
	year(max(pubdate)) as 'year',
    count(ta.title_id) as numauthors
    
from titles t

left join titleauthor as ta
on t.title_id=ta.title_id
left join authors as a
on ta.au_id=a.au_id

group by t.title
;

select au_id, city from authors
union #Pega por abajo ambas tablas, se quedará el nombre de la columna de arriba, tienen que tener el mismo num de cols.
select au_id, royaltyper from titleauthor; #Util para llevar un historico de logs o lo que sea


select * #--Formato de sub querys---------#
from 
(select title, type, price, royalty, pubdate, ta.title_id #Sub Query
from titles t
left join titleauthor as ta
on t.title_id=ta.title_id
left join authors as a
on ta.au_id=a.au_id) as tabla

left join sales as sa
on sa.title_id=tabla.title_id
;
