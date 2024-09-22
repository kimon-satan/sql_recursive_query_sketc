/**
  This query takes distinct set of attributes and values expressed as JSONB
  And uses it to generate a superset - the set of all possible combinations of values.
**/

WITH RECURSIVE all_combinations
AS(
    -- anchor member
    SELECT 
	* ,
	(SELECT count(*) FROM jsonb_object_keys(attributes)) AS num_keys
	FROM public.combi_test

    UNION

    SELECT 
        ct1.parent as parent,
        ct1.attributes || ct2.attributes as attributes,
		(SELECT count(*) FROM jsonb_object_keys(ct1.attributes || ct2.attributes)) AS num_keys
    FROM 
		all_combinations ct1
    JOIN public.combi_test ct2
    ON ct1.parent = ct2.parent
    AND ct1.attributes || ct2.attributes = ct2.attributes || ct1.attributes 
    AND ct1.attributes != ct2.attributes 
),
aggregated AS (
SELECT 
parent,
MAX(num_keys) AS max_keys
FROM all_combinations
GROUP BY parent
)
SELECT 
all_combinations.parent, 
all_combinations.attributes 
FROM all_combinations
JOIN aggregated USING(parent)
WHERE all_combinations.num_keys = aggregated.max_keys;