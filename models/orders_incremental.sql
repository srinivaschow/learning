{{ config(
    materialized='incremental', 
    unique_key='OrderID'
) }}

WITH new_orders AS (
    SELECT 
        OrderID, 
        CustomerID, 
        ProductID, 
        OrderDate, 
        OrderSellingPrice, 
        OrderCostPrice
    FROM {{ source('globalmart', 'orders') }}
    
    {% if is_incremental() %}
    WHERE OrderDate > (SELECT MAX(OrderDate) FROM {{ this }})
    {% endif %}
)

SELECT 
    OrderID, 
    CustomerID, 
    ProductID, 
    OrderDate, 
    OrderSellingPrice, 
    OrderCostPrice,
    (OrderSellingPrice - OrderCostPrice) AS profit
FROM new_orders;
