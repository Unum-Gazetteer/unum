DROP TABLE IF EXISTS wikidata_instance_of_to_admin_level;

CREATE TABLE wikidata_instance_of_to_admin_level (
    instance_of varchar(100),
    admin_level smallint NULL
);

COPY wikidata_instance_of_to_admin_level FROM '/tmp/wikidata_instance_of_to_admin_level.csv' WITH (DELIMITER ',');


