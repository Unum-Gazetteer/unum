CREATE OR REPLACE FUNCTION to_float(arg text)
RETURNS float AS $$
    SELECT CASE WHEN arg~E'^[-\\d.]+$' THEN arg::float ELSE NULL END;
$$ LANGUAGE sql;
