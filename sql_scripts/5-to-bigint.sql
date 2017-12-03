CREATE OR REPLACE FUNCTION to_bigint(arg text)
RETURNS bigint AS $$
    SELECT CASE WHEN arg~E'^\\d+$' THEN arg::bigint ELSE NULL END;
$$ LANGUAGE sql;
