CREATE OR REPLACE FUNCTION get_longest_from_stringified_array(input text)
RETURNS text AS $$
    SELECT element FROM (
        SELECT DISTINCT element, char_length FROM (
            SELECT element::text, char_length(element::text)
            FROM (SELECT unnest(string_to_array(input, ','))) AS element
        ) AS subquery2
        ORDER BY char_length
        DESC
    ) AS subquery3
    LIMIT 1;
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION longest_accum(a text, b text)
RETURNS text AS $$
    SELECT CASE WHEN char_length(a) >= char_length(b) THEN a ELSE b END;
$$
LANGUAGE SQL;

CREATE AGGREGATE longest(text)
(
    sfunc = longest_accum,
    stype = text,
    initcond = ''
);
