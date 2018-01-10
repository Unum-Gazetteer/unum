CREATE TABLE wikidata (
    primary_name varchar(1000),
    enwiki_title varchar(1001),
    other_names varchar(10000),
    country varchar(500),
    classes varchar(1002),
    elevation varchar(100),
    geonames_id varchar(100),
    latitude float,
    longitude float,
    population integer
);

COPY wikidata FROM '/tmp/gazetteers/wikidata-gazetteer.tsv' WITH (FORMAT 'csv', DELIMITER E'\t');