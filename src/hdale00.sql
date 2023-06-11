WITH 
c AS (SELECT * FROM currency WHERE (updated, id) IN (
	SELECT MAX(updated), id FROM currency GROUP BY id)),
n_t AS (SELECT COALESCE(u.name, 'not defined') AS name,
       COALESCE(u.lastname, 'not defined') AS lastname,
       b.type,
       sum(b.money) as volume,
       COALESCE(c.name, 'not defined') AS currency_name,
       COALESCE(c.rate_to_usd, 1) AS last_rate_to_usd
FROM balance b
         LEFT JOIN public .user u ON u.id = b.user_id
         LEFT JOIN c ON c.id = b.currency_id
GROUP BY u.id, b.type, c.rate_to_usd, c.name)
SELECT *, volume * last_rate_to_usd::float AS total_volume_in_usd
FROM n_t
ORDER BY name DESC, lastname, type;

