CREATE OR REPLACE FUNCTION round_degree(arg text)
RETURNS numeric(7,4) AS $$
    SELECT CASE WHEN arg~E'^[-\\d.]+$' THEN arg::numeric(7,4) ELSE NULL END;
$$ LANGUAGE sql;
