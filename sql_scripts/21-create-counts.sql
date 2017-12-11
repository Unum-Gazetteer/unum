DROP TABLE normalized_name_cell_counts;
CREATE TABLE normalized_name_cell_counts (
    id serial primary key,
    normalized_name varchar(2000),
    grid_cell_1_degree varchar(10),
    instance_count int
);

INSERT INTO normalized_name_cell_counts (normalized_name, grid_cell_1_degree, instance_count) SELECT normalized_name, grid_cell_1_degree, count(*) FROM places GROUP BY normalized_name, grid_cell_1_degree;
