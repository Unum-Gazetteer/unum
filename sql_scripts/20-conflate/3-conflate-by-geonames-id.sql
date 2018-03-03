DROP TABLE IF EXISTS same_geonames_id;


CREATE TABLE same_geonames_id (
    id serial primary key,
    place_ids varchar(10000),
    geonameid varchar(107),
    instance_count int
);


INSERT INTO same_geonames_id (place_ids, geonameid, instance_count)
SELECT array_to_string(array_agg(id), ','), geonameid, count(*)
FROM places
WHERE geonameid IS NOT NULL AND geonameid != 0
GROUP BY geonameid, admin_level;


DELETE FROM same_geonames_id WHERE instance_count = 1;


SELECT count(*) from same_geonames_id; 


SELECT count(*) AS num_places from places;


SELECT count(conflate_places_by_ids(place_ids)) FROM same_geonames_id;


SELECT count(*) AS num_places from places;


DELETE
FROM places
WHERE id IN (SELECT unnest(string_to_array(string_agg(place_ids, ','), ',')::bigint[]) FROM same_geonames_id);


SELECT count(*) AS num_places from places;
