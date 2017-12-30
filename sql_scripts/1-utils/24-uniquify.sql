CREATE OR REPLACE FUNCTION uniquify(input text)
RETURNS text AS $$
    SELECT array_to_string(ARRAY(SELECT DISTINCT * FROM unnest(string_to_array(input, ',')) ORDER BY 1), ',');
$$
LANGUAGE SQL;
