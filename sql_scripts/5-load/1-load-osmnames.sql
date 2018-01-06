CREATE TABLE osmnames (
    name varchar(1000),
    alternative_names varchar(5000),
    osm_type varchar(200),
    osm_id varchar(100),
    class varchar(100),
    type varchar(1000), 
    lon varchar(100),
    lat varchar(100),
    place_rank varchar(100),
    importance varchar(100),
    street varchar(500),
    city varchar(500),
    county varchar(500),
    state varchar(500),
    country varchar(500),
    country_code varchar(500),
    display_name varchar(1400),
    west varchar(100),
    south varchar(100), 
    east varchar(100),
    north varchar(100),
    wikidata varchar(100),
    wikipedia varchar(1000),
    housenumbers varchar(1000000) null
);

COPY osmnames FROM '/tmp/gazetteers/planet-latest_geonames.tsv' WITH (FORMAT 'csv', DELIMITER E'\t');
