/* Conflate places that have almost exactly same lat-long and are not places */
WITH conflated AS (
SELECT (
  SELECT regexp_split_to_array(concat_ws(
    '~@~',
    longest(asciiname),
    uniq(alternate_names),
    uniq(attribution),
    longest(city),
    longest(county),
    longest(country),
    longest(country_code),
    max(dem),
    longest(display_name), /* should we recompute instead? */
    max(elevation),
    max(east)::text,
    most_popular(geoname_feature_class), /* combine? */
    most_popular(geoname_feature_code), /* combine? */
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
    most_popular(osmname_class), /* ?? */
    uniq(osmname_id), /* smash? */
    most_popular(osmname_type),
    most_popular(osm_type),
    first(osm_id),
    max(place_rank),
    most_popular(point), /* really should get closest to centroid */
    max(population),
    min(south),
    most_popular(state),
    most_popular(street),
    most_popular(timezone),
    min(west),
    uniq(wikidata),
    first(wikipageid),
    uniq(wikititle),
    uniq(wikiurl)
  ), '~@~') AS a
  FROM places WHERE id = ANY(string_to_array(place_ids, ',')::int[])
)
FROM matches_within_11_meters LIMIT 2
)

INSERT INTO places (asciiname, alternate_names, attribution, city, county, country, country_code, dem, display_name, elevation, east, geoname_feature_class, geoname_feature_code, geonameid, geo_tag_id, grid_cell_1_degree, grid_cell_5_degrees, grid_cell_10_degrees, has_admin_level, has_population, importance, latitude, longitude, name, name_en, name_en_unaccented, normalized_name, north, osmname_class, osmname_id, osmname_type, osm_type, osm_id, place_rank, point, population, south, state, street, timezone, west, wikidata, wikipageid, wikititle, wikiurl)

SELECT a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11]::double precision, a[12], a[13], a[14]::bigint, a[15]::bigint, a[16], a[17], a[18], a[19]::boolean, a[20]::boolean, a[21]::numeric, a[22]::double precision, a[23]::double precision, a[24], a[25], a[26], a[27], a[28], a[29], a[30], a[31], a[32], a[33], a[34], a[35], a[36], a[37], a[38], a[39], a[40], a[41], a[42], a[43], a[44], a[45]
FROM conflated;

