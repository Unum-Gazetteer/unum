CREATE TABLE geonames (
    geonameid int,
    name varchar(200),
    asciiname varchar(200),
    alternatenames varchar(10000),
    latitude float,
    longitude float,
    feature_class char(1),
    feature_code varchar(10),
    country_code varchar(2),
    cc2 varchar(1000),
    admin1_code varchar(20),
    admin2_code varchar(80),
    admin3_code varchar(20),
    admin4_code varchar(20),
    population bigint,
    elevation varchar(10),
    dem int,
    timezone varchar(40),
    modification_date DATE
);

COPY geonames FROM '/tmp/gazetteers/allCountries.txt' WITH (DELIMITER E'\t');
