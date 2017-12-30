/* Notes:
 * Doesn't include id field bc it wouldn't make sense here
 *
 */

DROP TYPE conflated_place;
CREATE TYPE conflated_place AS (
    admin1code varchar(100),            admin2code varchar(101),
    admin3code varchar(102),            admin4code varchar(103),
    admin_level int,                    asciiname varchar(2000),
    alternate_names varchar(10000),     attribution varchar(1001),
    city varchar(1002),                 county varchar(1004),
    country varchar(1003),              country_code varchar(2),
    dem varchar(1000),                  display_name varchar(504),
    elevation varchar(105),             east float,
    geoname_feature_class varchar(1006),geoname_feature_code varchar(1005),
    geonameid bigint,                   geo_tag_id bigint,
    grid_cell_1_degree varchar(10),     grid_cell_5_degrees varchar(10),
    grid_cell_10_degrees varchar(10),   has_admin_level boolean,
    has_population boolean,             importance decimal,
    latitude float,                     longitude float,
    name varchar(2000),                 name_en varchar(2000),
    name_en_unaccented varchar(2000),   normalized_name varchar(2000), /* unaccented and lowered */
    north float,                        osmname_class varchar(1007),
    osmname_id varchar(5009),           osmname_type varchar(1008),
    osm_type varchar(106),              osm_id varchar(107),
    place_rank int,                     place_type varchar(1),
    point geometry(Point,4326),         point_4 geometry(Point,4326),
    population bigint,                  south float,
    state varchar(1010),                street varchar(1011),
    timezone varchar(40),               west float,
    wikidata varchar(1008),              wikipageid bigint,
    wikititle varchar(1013),            wikiurl varchar(1012)
);
