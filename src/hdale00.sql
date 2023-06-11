WITH c AS (select * from currency where updated in (select max(updated) from currency group by id))

SELECT COALESCE(u.name, 'not defined')     AS name,
       COALESCE(u.lastname, 'not defined') AS lastname,
       b.type,
       sum(b.money) as value,
       COALESCE(c.name, 'not defined')     AS currency_name,
       COALESCE(c.rate_to_usd, 1)          AS last_rate_to_usd
FROM balance b
         LEFT JOIN public .user u ON u.id = b.user_id
         LEFT JOIN c ON c.id = b.currency_id
GROUP BY u.id, b.type, c.rate_to_usd, c.name



