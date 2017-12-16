DROP TABLE geoname_feature_class_to_place_type;

CREATE TABLE geoname_feature_class_to_place_type (
    geoname_feature_class varchar(1),
    place_type varchar(1)
);

COPY geoname_feature_class_to_place_type FROM '/tmp/geoname_feature_class_to_place_type.csv' WITH (DELIMITER ',');



DROP TABLE osm_class_to_place_type;

CREATE TABLE osm_class_to_place_type (
    osm_class varchar(10),
    place_type varchar(1)
);

COPY osm_class_to_place_type FROM '/tmp/osm_class_to_place_type.csv' WITH (DELIMITER ',');




DROP TABLE osm_type_to_place_type;

CREATE TABLE osm_type_to_place_type (
    osm_type varchar(15),
    place_type varchar(1)
);

COPY osm_type_to_place_type FROM '/tmp/osm_type_to_place_type.csv' WITH (DELIMITER ',');


