CREATE OR REPLACE FUNCTION get_place_type(osmname_class text, osmname_type text, geonames_feature_class text, geonames_feature_code text)
RETURNS int language plpgsql
AS $$
BEGIN
    IF osmname_type = 'administrative' OR geonames_feature_class = 'A' THEN
        RETURN 'admin';
    ELSIF geonames_feature_class = osmname_type
        RETURN NULL;
    END IF;
EXCEPTION when others THEN
    RETURN NULL;
END $$;
