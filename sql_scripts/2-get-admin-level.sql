CREATE OR REPLACE FUNCTION get_admin_level(osmname_type text, place_rank int)
RETURNS int language plpgsql
AS $$
BEGIN
    IF osmname_type = 'administrative' THEN
        IF place_rank = 15 THEN
            RETURN NULL;
        ELSE
            RETURN place_rank / 2 - 2;
        END IF;
    ELSE
        RETURN NULL;
    END IF;
EXCEPTION when others THEN
    RETURN NULL;
END $$;


CREATE OR REPLACE FUNCTION get_ascii_name(name text)
RETURNS text language plpgsql
AS $$
begin
    return to_ascii(encode(convert_to(unaccent(name),'LATIN9'),'escape'),'LATIN9');
exception when others then
    return null;
end $$;
