with products as(
select
category,
ProductID,
ProductName,
subcategory
from {{source('globalmart','products')}}
)
select * from products;