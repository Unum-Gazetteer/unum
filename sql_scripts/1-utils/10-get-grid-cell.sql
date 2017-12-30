CREATE OR REPLACE FUNCTION get_grid_cell(latitude float, longitude float, size_in_degrees integer)
RETURNS varchar(10) AS $$
    SELECT CAST(width_bucket(abs(90 - latitude), 0, 180, 180 / size_in_degrees) AS text) || '-' || CAST(width_bucket(abs(-180 - longitude), 0, 360, 360 / size_in_degrees) AS text);
$$ LANGUAGE sql VOLATILE;
