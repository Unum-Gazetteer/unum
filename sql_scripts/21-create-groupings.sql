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
INSERT INTO matches_within_11_meters (normalized_name, place_ids, place_type, point_4, instance_count) SELECT normalized_name, array_to_string(array_agg(id), ','), place_type, point_4, count(*) FROM places WHERE normalized_name IS NOT NULL AND normalized_name != '' AND place_type = 'B' or place_type = 'N' GROUP BY normalized_name, place_type, point_4;
DELETE FROM matches_within_11_meters WHERE instance_count = 1;

DROP TABLE normalized_name_cell_counts;
CREATE TABLE normalized_name_cell_counts (
    id serial primary key,
    place_ids varchar(10000),
    normalized_name varchar(2000),
    place_type varchar(1),
    grid_cell_1_degree varchar(10),
    instance_count int
);
INSERT INTO normalized_name_cell_counts (normalized_name, place_ids, place_type, grid_cell_1_degree, instance_count) SELECT normalized_name, array_to_string(array_agg(id), ','), place_type, grid_cell_1_degree, count(*) FROM places WHERE normalized_name IS NOT NULL and normalized_name != '' AND place_type = 'P' GROUP BY normalized_name, place_type, grid_cell_1_degree;
DELETE FROM normalized_name_cell_counts WHERE instance_count = 1;
