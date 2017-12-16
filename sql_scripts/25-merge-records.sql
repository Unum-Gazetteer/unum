/* Conflate places that have almost exactly same lat-long and are not places */
WITH conflated AS (
 SELECT (
  SELECT
    get_longest(string_agg(asciiname, ',')),
    uniquify(string_agg(alternate_names, ',')),
    uniquify(string_agg(attribution, ',')),
    get_longest(city),
    get_longest(county),
    get_longest(country),
    get_longest(country_code),
    max(dem),
    get_longest(display_name), /* should we recompute instead? */
    max(elevation),
    max(east),
    geoname_feature_class, /* should I really smash into one ? */
    geoname_feature_code, /* should I really smash into one ? */
    geonameid, /* conflating into one.. wonder if I should store multiple?? */
    geo_tag_id, /* conflating into one.. is that a good idea? */
    grid_cell_1_degree, /* should we combine?.. will make lookups harder, but more correct .. or at least recalculate */
    grid_cell_5_degrees,
    grid_cell_10_degrees,
    CAST(max(CAST(has_admin_level AS int)) AS bool),
    CAST(max(CAST(has_population AS int)) AS bool),
    max(importance),
    latitude, /* just pick first one.. really should do most popular */
    longitude, /* just pick first one */
    name, /* should get most popular */
    name_en, /* shoudl get more popular */
    name_en_unaccented, /* should get most popular */
    normalized_name, /* shoudl recalculate */
    max(north),
    osmname_class,
    osmname_id, /* smash? */
    osmname_type, /* could say multiple right? */
    osm_type, /* smash? */
    osm_id, /* should I smash? */
    max(place_rank),
    point, /* really should get closest to centroid */
    max(population),
    min(south),
    state,
    street,
    timezone,
    west,
    wikidata,
    wikipageid,
    wikititle,
    wikiurl
    FROM places WHERE id = ANY(string_to_array(place_ids, ',')::int[])
 ) as subquery
 FROM matches_within_11_meters
)
/*INSERT INTO places (asciiname, alternate_names, attribution, city, county, country, country_code, dem, display_name, elevation, east, geoname_feature_class, geoname_feature_code, geonameid, geo_tag_id, grid_cell_1_degree, grid_cell_5_degrees, grid_cell_10_degrees, has_admin_level, has_population, importance, latitude, longitude, name, name_en, name_en_unaccented, normalized_name, north, osmname_class, osmname_id, osmname_type, osm_type, osm_id, place_rank, point, population, south, state, street, timezone, west, wikidata, wikipageid, wikititle, wikiurl)*/
SELECT * FROM conflated LIMIT 1;
