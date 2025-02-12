WITH orders AS (
    SELECT * FROM {{ ref('orders') }}
),
customers AS (
    SELECT * FROM {{ ref('customers') }}
),
products AS (
    SELECT * FROM {{ ref('products') }}
),
order_aggregates AS (
    SELECT 
        o.CustomerID,
        COUNT(o.OrderID) AS total_orders,
        SUM(o.OrderSellingPrice) AS total_revenue,
        SUM(o.OrderSellingPrice - o.OrderCostPrice) AS total_profit,
        p.Category AS most_purchased_category
    FROM orders o
    LEFT JOIN products p ON o.ProductID = p.ProductID
    GROUP BY o.CustomerID, p.Category
),
final AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        c.Segment,
        c.Country,
        c.State,
        oa.total_orders,
        oa.total_revenue,
        oa.total_profit,
        oa.most_purchased_category
    FROM order_aggregates oa
    JOIN customers c ON oa.CustomerID = c.CustomerID
)

SELECT * FROM final
