CREATE OR REPLACE FUNCTION find_matching_places(
    _name varchar,
    _lat double precision,
    _lon double precision,
    _country_code varchar DEFAULT NULL,
    _population int DEFAULT NULL,
    _geonameid int DEFAULT NULL,
    _admin1_code varchar(20) DEFAULT NULL,
    _admin2_code varchar(20) DEFAULT NULL,
    _admin3_code varchar(20) DEFAULT NULL,
    _admin4_code varchar(20) DEFAULT NULL,
    _timezone varchar(40) DEFAULT NULL
)
RETURNS void AS $$
    INSERT INTO candidates
    SELECT
    *,
    within_x_meters(_lat, _lon, point, 1) AS within_1_meter,
    within_x_meters(_lat, _lon, point, 10) AS within_10_meters,
    within_x_meters(_lat, _lon, point, 100) AS within_100_meters,
    within_x_meters(_lat, _lon, point, 1000) AS within_1000_meters,
    within_x_meters(_lat, _lon, point, 10000) AS within_10000_meters,
    population IS NOT NULL AS population_exists,
    CASE WHEN population IS NOT NULL AND population > 0 THEN abs(_population - population)::decimal / GREATEST(_population, population)::decimal < 0.05 ELSE false END AS population_is_close,
    admin_level IS NOT NULL AS has_admin_level,
    to_float('0') AS score
    FROM places WHERE normalized_name = lower(unaccent(_name));
$$ LANGUAGE sql VOLATILE;

SELECT find_matching_places('Trenton', 0, 0);
