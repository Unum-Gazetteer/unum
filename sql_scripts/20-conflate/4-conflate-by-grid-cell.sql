DROP TABLE IF EXISTS grid_cell_counts;


CREATE TABLE grid_cell_counts (
    id serial primary key,
    place_ids varchar(10000),
    normalized_name varchar(2000),
    place_type varchar(1),
    grid_cell_1_degree varchar(10),
    instance_count int
);


INSERT INTO grid_cell_counts (normalized_name, place_ids, place_type, grid_cell_1_degree, instance_count)
SELECT normalized_name, array_to_string(array_agg(id), ','), place_type, grid_cell_1_degree, count(*)
FROM places
WHERE normalized_name IS NOT NULL and normalized_name != '' AND place_type = 'P'
GROUP BY normalized_name, place_type, grid_cell_1_degree;


DELETE FROM grid_cell_counts WHERE instance_count = 1;


SELECT count(conflate_places_by_ids(place_ids)) FROM grid_cell_counts;


DELETE
FROM places
WHERE id IN (SELECT unnest(string_to_array(string_agg(place_ids, ','), ',')::bigint[]) FROM grid_cell_counts);