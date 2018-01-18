CREATE OR REPLACE FUNCTION conflate_places_by_ids(place_ids varchar(10000))
RETURNS void AS $$

  INSERT INTO places (
    admin1code,           admin2code,           admin3code,           admin4code,
    admin_level,          asciiname,            alternate_names,      attribution,
    city,                 county,               country,              country_code,
    dem,                  display_name,         elevation,            east,
    geoname_feature_class,geoname_feature_code, geonameid,            geo_tag_id,
    grid_cell_1_degree,   grid_cell_5_degrees,  grid_cell_10_degrees, has_admin_level,
    has_population,       importance,           latitude,             longitude,
    name,                 name_en,              name_en_unaccented,   normalized_name,
    north,                osmname_class,        osmname_id,           osmname_type,
    osm_type,             osm_id,               place_rank,           place_type,
    point,                point_4,              population,           south,
    state,                street,               timezone,             west,
    wikidata,             wikipageid,           wikititle,            wikiurl,
    enwiki_title
  )

  SELECT
  
    NULL, /* admin1code */
    NULL, /* admin2code */
    NULL, /* admin3code */
    NULL, /* admin4code */
    NULL, /* admin_level */
    longest(asciiname), /* asciiname */
    uniq(alternate_names), /* alternate_names */
    uniq(attribution)::varchar(998), /* attribution */
    longest(city)::varchar(997), /* city */
    longest(county)::varchar(996), /* county */
    longest(country)::varchar(995), /* country */
    longest(country_code), /* country_code */
    max(dem)::varchar(994), /* dem */
    longest(display_name), /* should we recompute instead? */
    max(elevation), /* elevation */
    max(east), /* east */
    most_popular(geoname_feature_class)::varchar(993), /* combine? */
    most_popular(geoname_feature_code)::varchar(992), /* combine? */
    first(geonameid), /* combine? */
    first(geo_tag_id), /* combine? */
    most_popular(grid_cell_1_degree), /* recompute? */
    most_popular(grid_cell_5_degrees), /* recompute? */
    most_popular(grid_cell_10_degrees), /* recompute? */
    bool_or(has_admin_level),
    bool_or(has_population),
    max(importance),
    first(latitude), /* just pick first one.. really should do most popular */
    first(longitude), /* just pick first one */
    longest(name), /* should get most popular */
    longest(name_en), /* recalculate? */
    longest(name_en_unaccented), /* recalculate? */
    longest(normalized_name), /* recalculate? */
    max(north),
    most_popular(osmname_class)::varchar(991), /* ?? */
    uniq(osmname_id)::varchar(990), /* smash? */
    most_popular(osmname_type)::varchar(989),
    most_popular(osm_type),
    first(osm_id),
    max(place_rank),
    most_popular(place_type),
    most_popular(point), /* really should get closest to centroid */
    most_popular(point_4),
    max(population),
    min(south),
    most_popular(state)::varchar(988),
    most_popular(street)::varchar(987),
    most_popular(timezone),
    min(west),
    uniq(wikidata),
    first(wikipageid),
    uniq(wikititle)::varchar(986),
    uniq(wikiurl)::varchar(985),
    first(enwiki_title)

    FROM places WHERE id = ANY(string_to_array(place_ids, ',')::int[])

/* Delete Old Records that have been merged */
/*DELETE FROM places WHERE id IN (SELECT unnest(string_to_array(string_agg(place_ids, ','), ',')::int[]) FROM matches_within_11_meters);
*/

$$ LANGUAGE sql VOLATILE;