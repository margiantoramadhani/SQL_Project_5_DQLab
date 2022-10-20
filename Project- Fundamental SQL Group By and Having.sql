# Mendapatkan jumlah nilai pinalty

SELECT 
  customer_id, 
  sum(pinalty) 
FROM 
  invoice
GROUP BY 
  customer_id
HAVING 
  SUM(pinalty) > 0;
  
# Mencari customer yang mengganti layanan

SELECT
	Name as name,
	GROUP_CONCAT(t3.product_name) 
FROM 
	customer t1 
JOIN 
	subscription t2 
	ON 
	t1.id = customer_id 
JOIN 
	product t3 
	ON 
	product_id=t3.ID 
	WHERE 
		t1.id 
		IN (select 
			customer_id 
			FROM subscription 
			GROUP BY customer_id 
			HAVING COUNT(customer_id)>1)
GROUP BY 
	name;