## Project: Fundamental SQL Group By and Having

----

#### Sample of Dataset Project

<details>
<summary markdown="span">invoice</summary>

| invoice_id | invoice_code | customer_id | invoice_date        | product_id | total_price | pinalty |
|------------|--------------|-------------|---------------------|------------|-------------|---------|
|          1 | INV-43378-1  |           1 | 2018-10-05 00:00:00 |      10001 |      100000 | NULL    |
|          2 | INV-43379-2  |           2 | 2018-10-06 00:00:00 |      10001 |      100000 | NULL    |
|          3 | INV-43380-3  |           3 | 2018-10-07 00:00:00 |      10003 |      300000 | NULL    |
|          4 | INV-43381-4  |           4 | 2018-10-08 00:00:00 |      10001 |      100000 | NULL    |
|          5 | INV-43382-5  |           5 | 2018-10-09 00:00:00 |      10003 |      300000 | NULL    |

</details>

----

#### Mendapatkan jumlah nilai pinalty
Pada pelayanan terdapat customer yang mendapatkan pinalty yang diakibatkan telat membayar.</br>
Carilah customer-customer id dan jumlah pinalty dari yang dibayarkan oleh customer yang mendapatkan pinalty.

```sql
SELECT 
  customer_id, 
  sum(pinalty) 
FROM 
  invoice
GROUP BY 
  customer_id
HAVING 
  SUM(pinalty) > 0;
```

<details>
<summary markdown="span">OUTPUT :</summary>

| customer_id | sum(pinalty) |
|-------------|--------------|
|          31 |        50000 |
|          32 |        25000 |
|          33 |        63000 |
|          34 |        52500 |
|          35 |        52500 |
|          36 |        52500 |
|          37 |        52500 |
|          38 |        63000 |
|          39 |       252000 |
|          40 |        63000 |
|          41 |        63000 |
|          42 |       105000 |
|          43 |        63000 |
|          44 |       105000 |
|          45 |       252000 |
|          46 |        52500 |

</details>

----

#### Mencari customer yang mengganti layanan
Dalam pelayanan jaringan internet akan terjadi perubahan paket yang dilakukan oleh konsumen tersebut.
Sekarang kita akan mencari konsumen-konsumen yang melakukan perubahan layanannya.</br>
</br>
Ada 3 table yang dibutuhkan dalam mencari data tersebut:</br>
1. customer</br>
2. subscription</br>
3. product</br>
</br>
Lakukanlah query dengan petunjuk sebagai berikut:</br>
Filtrasi dahulu customer_id yang memiliki subscription lebih dari 1 pada table subscription.
Kemudian query tersebut digunakan untuk mendapatkan nama customer pada table customer dan lakukan join antara subscription dan product 
untuk mendapatkan product_name, gunakan function group_concat untuk product_name.

```sql
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
```

<details>
<summary markdown="span">OUTPUT :</summary>

| name                 | GROUP_CONCAT(t3.product_name) |
|----------------------|-------------------------------|
| Aisyah Umi Agustina  | Gamer Package,Faster Package  |
| Laswi Saputra        | Family Package,Gamer Package  |
| Makara Pangestu      | Faster Package,Family Package |
| Rama Putra           | Family Package,Family Package |
| Tugiman Jailani M.Ak | Faster Package,Family Package |
| Wani Nurdiyanti      | Family Package,Private User   |

</details>
