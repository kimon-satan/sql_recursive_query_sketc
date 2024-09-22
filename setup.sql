BEGIN;

DROP TABLE IF EXISTS combi_test;

CREATE TABLE combi_test
(
    parent TEXT,
    attributes JSONB
);

INSERT INTO combi_test VALUES 
('parent_1', '{"attribute_1": "a"}'::JSONB),
('parent_1', '{"attribute_1": "b"}'::JSONB),
('parent_1', '{"attribute_2": "a"}'::JSONB),
('parent_1', '{"attribute_2": "b"}'::JSONB),
('parent_1', '{"attribute_3": "a"}'::JSONB),
('parent_1', '{"attribute_3": "b"}'::JSONB),
('parent_2', '{"attribute_1": "a"}'::JSONB),
('parent_2', '{"attribute_1": "b"}'::JSONB),
('parent_2', '{"attribute_2": "a"}'::JSONB),
('parent_2', '{"attribute_2": "b"}'::JSONB),
('parent_3', '{"attribute_1": "a"}'::JSONB),
('parent_3', '{"attribute_1": "b"}'::JSONB),
('parent_3', '{"attribute_1": "c"}'::JSONB),
('parent_3', '{"attribute_2": "a"}'::JSONB),
('parent_3', '{"attribute_2": "b"}'::JSONB),
('parent_3', '{"attribute_3": "a"}'::JSONB);

COMMIT;