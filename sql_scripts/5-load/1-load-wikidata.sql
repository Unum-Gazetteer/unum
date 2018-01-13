DROP TABLE IF EXISTS wikidata;

CREATE TABLE wikidata (
    primary_name varchar(1000),
    enwiki_title varchar(1001),
    other_names varchar(20000),
    country varchar(500),
    country_code varchar(5),
    classes varchar(1002),
    elevation varchar(100),
    geonames_id varchar(100),
    latitude float,
    longitude float,
    population varchar(100),
    osm_id varchar(100)
);

COPY wikidata FROM '/tmp/gazetteers/wikidata-gazetteer.tsv' WITH (FORMAT 'csv', DELIMITER E'\t', HEADER);