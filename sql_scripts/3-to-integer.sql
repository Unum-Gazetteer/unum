CREATE OR REPLACE FUNCTION to_integer(arg text)
RETURNS int AS $$
    SELECT CASE WHEN arg~E'^\\d+$' THEN arg::integer ELSE NULL END;
$$ LANGUAGE sql;
