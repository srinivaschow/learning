select orderdate,
sum(ordercostprice) as total_revenue 
from globalmart_schema.orders
group by orderdate