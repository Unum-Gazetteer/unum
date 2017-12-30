/* DROP FUNCTION longest_accum(text, text) CASCADE; */
CREATE OR REPLACE FUNCTION longest_accum(accum text, value text)
RETURNS text AS $$
    SELECT CASE WHEN value IS NOT NULL AND char_length(value) >= char_length(accum) THEN value ELSE accum END;
$$
LANGUAGE SQL;

DROP AGGREGATE longest(text);
CREATE AGGREGATE longest(text)
(
    sfunc = longest_accum,
    stype = text,
    initcond = ''
);


/* first */
/* DROP FUNCTION first_accum(anyelement, anyelement) CASCADE; */
CREATE OR REPLACE FUNCTION first_accum(accum anyelement, value anyelement)
RETURNS anyelement AS $$
    SELECT CASE WHEN (accum IS NULL AND value::text != '') THEN value ELSE accum END;
$$
LANGUAGE SQL;

DROP AGGREGATE first(anyelement);
CREATE AGGREGATE first(anyelement)
(
    sfunc = first_accum,
    stype = anyelement
);

/* mode from https://wiki.postgresql.org/wiki/Aggregate_Mode */
CREATE OR REPLACE FUNCTION _final_mode(anyarray)
  RETURNS anyelement AS
$BODY$
    SELECT a
    FROM unnest($1) a
    GROUP BY 1 
    ORDER BY COUNT(1) DESC, 1
    LIMIT 1;
$BODY$
LANGUAGE SQL IMMUTABLE;
 
-- Tell Postgres how to use our aggregate
CREATE AGGREGATE most_popular(anyelement) (
  SFUNC=array_append, --Function to call for each row. Just builds the array
  STYPE=anyarray,
  FINALFUNC=_final_mode, --Function to call after everything has been added to array
  INITCOND='{}' --Initialize an empty array when starting
);


/* Need to figure out a way to filter out nulls I think */
CREATE OR REPLACE FUNCTION  _final_uniq(anyarray)
    RETURNS anyelement AS
$BODY$
    SELECT array_to_string(ARRAY(SELECT DISTINCT element FROM unnest($1) element WHERE element IS NOT NULL ORDER BY 1), ',');
$BODY$
LANGUAGE SQL IMMUTABLE;

CREATE AGGREGATE uniq(anyelement) (
    SFUNC=array_append,
    STYPE=anyarray,
    FINALFUNC=_final_uniq,
    INITCOND='{}'
)
