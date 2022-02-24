23

Select distinct p.maker
from product as p
inner join (
select pc.model, pc.speed
from pc
union
select l.model, l.speed
from laptop l
) as M on M.model = p.model
where M.speed >= 750



SELECT DISTINCT maker 
FROM product 
WHERE model IN (SELECT model 
 FROM PC 
 WHERE speed >= 750
 ) OR 
 model IN (SELECT model 
 FROM Laptop 
 WHERE speed >= 750
 );

6 

Select p.maker, l.speed
from product p 
right join laptop l on p.model = l.model
where l.hd >= 10 and p.type = 'laptop'

18

select p.maker, pr.price
from product p
join printer pr on p.model = pr.model
where pr.color = 'y'
order by price

8

select maker
from product
where type = 'PC'
except
select maker
from product
where type = 'laptop'

select distinct p1.maker
from product p1
left join product p2
on p1.model = p2.model
where p2.type not in ('laptop') and p1.type in ('PC')




p1.type = 'PC' and p1.type != 'laptop'p1