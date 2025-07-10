create database walmart
use walmart
CREATE TABLE transactions (
    product_id INT,
    user_id INT,
    spend DECIMAL(10, 2),
    transaction_date DATETIME
);

INSERT INTO transactions (product_id, user_id, spend, transaction_date)
VALUES
(3673, 123, 68.90, '2022-07-08 10:00:00'),
(9623, 123, 274.10, '2022-07-08 10:00:00'),
(1467, 115, 19.90, '2022-07-08 10:00:00'),
(2513, 159, 25.00, '2022-07-08 10:00:00'),
(1452, 159, 74.50, '2022-07-10 10:00:00'),
(1452, 123, 74.50, '2022-07-10 10:00:00'),
(9765, 123, 100.15, '2022-07-11 10:00:00'),
(6536, 115, 57.00, '2022-07-12 10:00:00'),
(7384, 159, 15.50, '2022-07-12 10:00:00'),
(1247, 159, 23.40, '2022-07-12 10:00:00');  
select * from transactions
with latest_transaction as(
select  transaction_date , user_id,product_id,rank() over(partition by user_id order by 
transaction_date desc) as transaction_rank  from transactions )
select transaction_date , user_id,count(product_id) as purchase_count from latest_transaction 
where transaction_rank=1
group by transaction_date , user_id order by transaction_date
