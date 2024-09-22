WITH stage_1 AS (
SELECT 
ct1.parent as parent,
ct1.attributes || ct2.attributes as attributes
FROM 
public.combi_test ct1
JOIN public.combi_test ct2 
ON ct1.attributes || ct2.attributes = ct2.attributes || ct1.attributes 
AND ct1.attributes != ct2.attributes 
),
stage_2 AS(
SELECT DISTINCT ON (attributes)
ct1.parent,
ct1.attributes || ct2.attributes as attributes
FROM 
stage_1 ct1
JOIN stage_1 ct2 
ON ct1.attributes || ct2.attributes =  ct2.attributes || ct1.attributes 
AND ct1.attributes != ct2.attributes)
SELECT 
DISTINCT ON (attributes) * 
FROM stage_2;