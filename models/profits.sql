with product_sales as (
    select
        p.ProductID,
        p.ProductName,
        count(o.OrderID) as TotalSold
    from globalmart_schema.orders o
    left join globalmart_schema.products p on o.ProductID = p.ProductID
    group by p.ProductID, p.ProductName
)
select
    ProductID,
    ProductName,
    TotalSold
from product_sales
order by TotalSold desc