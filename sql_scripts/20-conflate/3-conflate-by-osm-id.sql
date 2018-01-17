SELECT conflate_places_by_ids(place_ids) FROM same_osm_id;


SELECT
    (
        DELETE
        FROM places
        WHERE id=ANY(string_to_array(place_ids))
    )
FROM same_osm_id;