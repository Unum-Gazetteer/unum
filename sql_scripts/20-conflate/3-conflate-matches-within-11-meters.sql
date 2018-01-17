/* https://gis.stackexchange.com/questions/8650/measuring-accuracy-of-latitude-and-longitude/8674#8674 */
DROP TABLE matches_within_11_meters;


CREATE TABLE matches_within_11_meters (
    id serial primary key,
    place_ids varchar(10000),
    normalized_name varchar(2000),
    place_type varchar(1),
    point_4 geometry(Point,4326),
    instance_count int
);


INSERT INTO matches_within_11_meters (normalized_name, place_ids, place_type, point_4, instance_count)
SELECT normalized_name, array_to_string(array_agg(id), ','), place_type, point_4, count(*)
FROM places
WHERE normalized_name IS NOT NULL AND normalized_name != '' AND place_type = 'B' or place_type = 'N'
GROUP BY normalized_name, place_type, point_4;


DELETE FROM matches_within_11_meters WHERE instance_count = 1;


SELECT conflate_places_by_ids(place_ids) FROM matches_within_11_meters;


DELETE FROM places WHERE id=ANY(ARRAY(SELECT string_to_array(string_agg(place_ids, ','), ',')::int[] FROM matches_within_11_meters LIMIT 1));