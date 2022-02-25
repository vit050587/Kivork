/*Написать 2 SQL запроса для поиска значений среднего и медианы по сумме продажи. 
Сумму транзакции округляем до целой части. 
Нельзя использовать стандартные функции среднего и медианы в SQL. 
Можно использовать только агр функции SUM и COUNT.*/

--**************************** первый вариант ***********************************

SELECT
   id,
   AVG(sale_amount)
FROM
(
   SELECT
      id,
      sale_amount,
     
      ROW_NUMBER() OVER (
         PARTITION BY id
         ORDER BY sale_amount ASC) AS RowAsc,
      ROW_NUMBER() OVER (
         PARTITION BY id
         ORDER BY sale_amount DESC) AS RowDesc
   FROM orders
) x
WHERE RowAsc IN (RowDesc, RowDesc - 1, RowDesc + 1)
GROUP BY id
ORDER BY id; -- медианы

--**************************** Еще вариант **************************************
SELECT
(
   (SELECT MAX(sale_amount) FROM
       (SELECT TOP 50 PERCENT sale_amount FROM orders ORDER BY sale_amount) AS a)
   +
   (SELECT MIN(sale_amount) FROM
       (SELECT TOP 50 PERCENT sale_amount FROM orders ORDER BY sale_amount DESC) AS b)
) / 2 AS Median -- медианы


-- Написать SQL-запрос для поиска задублированных в результате ошибки транзакций. Схема данных:

__******************************* первый вариант ********************************

 SELECT transaction_id COUNT(transaction_id) 
 FROM purchases 
 GROUP BY transaction_id 
 HAVING COUNT(transaction_id) > 1;
 
 /*Написать SQL-запрос для построения воронки перехода из установки в оформление пробного периода и в покупку платной версии приложения в разрезе стран. 
 На одного юзера возможна только одно оформление пробного периода и одна покупка платной версии. Покупка возможна только после истечения срока пробного периода. 
 На выходе должна получится таблица с колонками “country”, “installs”, “trials”, “purchases”, “conversion_rate_to_trial”, “conversion_rate_to_purchase”*/