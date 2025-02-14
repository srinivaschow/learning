with customers as(
select
CustomerID,
customername,
segment,
country,
state from {{source('globalmart','customers')}}
)
select * from orders
