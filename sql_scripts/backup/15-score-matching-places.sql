CREATE OR REPLACE FUNCTION
score_candidate(candidate candidates)
RETURNS candidates AS $$
BEGIN
END;
$$
LANGUAGE PLPGSQL;

SELECT find_matching_places('Portland', 0, 0);
