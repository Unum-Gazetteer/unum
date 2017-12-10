CREATE OR REPLACE FUNCTION within_x_meters(latitude float, longitude float, point geometry(Point,4326), distance integer)
RETURNS boolean AS $$
    SELECT ST_DWithin(CAST(ST_SetSRID(ST_Point(longitude, latitude), 4326) AS geography), point, distance);
$$ LANGUAGE sql VOLATILE;
