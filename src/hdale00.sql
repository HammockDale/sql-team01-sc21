
WITH
t AS (
	SELECT name, MAX(updated) AS max_updated
	FROM currency
	GROUP BY name),
c AS (
	SELECT cu.id, cu.name, cu.rate_to_usd, t.max_updated
	FROM currency cu
		JOIN t ON t.name = cu.name AND t.max_updated = cu.updated
)


SELECT
 COALESCE(u.name, 'not defined') AS name, COALESCE(u.lastname, 'not defined') AS lastname, b.type, 
 SUM(b.money), 
 COALESCE(c.name, 'not defined') AS currency_name, COALESCE(c.rate_to_usd, 1) AS last_rate_to_usd
FROM balance b
    LEFT JOIN "user" u ON b.user_id = u.id
    LEFT JOIN c ON b.currency_id = c.id
GROUP BY u.id, b.type, c.rate_to_usd, c.name


