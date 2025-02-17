{{config(
    materialized = 'table'
)}}

with orders as(
SELECT 
    OrderID,
    OrderDate,
    ShipDate,
    ShipMode,
    CustomerID,
    ProductID,
    OrderCostPrice,
    OrderSellingPrice
FROM {{source('globalmart','orders')}}
)
select * from orders
