
--2. Find the number of suppliers from every country.

SELECT n_name, COUNT(s_name)
FROM supplier, nation
WHERE
    s_nationkey = n_nationkey
    GROUP BY n_name
