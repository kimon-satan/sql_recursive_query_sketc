
WITH stage_1 AS (
	SELECT 
	ct1.parent AS parent,
	COALESCE(ct1.attribute_1, ct2.attribute_1) as attribute_1,
	COALESCE(ct1.attribute_2, ct2.attribute_2) as attribute_2,
	COALESCE(ct1.attribute_3, ct2.attribute_3) as attribute_3
	FROM combi_test ct1
	LEFT JOIN combi_test ct2 ON 
	ct1.parent = ct2.parent AND
	(ct1.attribute_1 IS NULL OR ct2.attribute_1 IS NULL) AND
	(ct1.attribute_2 IS NULL OR ct2.attribute_2 IS NULL) AND
	(ct1.attribute_3 IS NULL OR ct2.attribute_3 IS NULL) 
),
stage_2 AS (
	SELECT
	ct1.parent AS parent,
	COALESCE(ct1.attribute_1, ct2.attribute_1) as attribute_1,
	COALESCE(ct1.attribute_2, ct2.attribute_2) as attribute_2,
	COALESCE(ct1.attribute_3, ct2.attribute_3) as attribute_3
	FROM stage_1 ct1
	LEFT JOIN combi_test ct2 ON 
	ct1.parent = ct2.parent AND
	(ct1.attribute_1 IS NULL OR ct2.attribute_1 IS NULL) AND
	(ct1.attribute_2 IS NULL OR ct2.attribute_2 IS NULL) AND
	(ct1.attribute_3 IS NULL OR ct2.attribute_3 IS NULL)
)
SELECT
DISTINCT ON (attribute_1, attribute_2, attribute_3)
	*
FROM stage_2 ct1
ORDER BY
attribute_1,
attribute_2,
attribute_3