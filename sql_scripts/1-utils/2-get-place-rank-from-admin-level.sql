CREATE OR REPLACE FUNCTION get_place_rank_from_admin_level(admin_level int)
RETURNS int language plpgsql
AS $$
BEGIN
    IF admin_level IS NULL THEN
        RETURN NULL;
    ELSE
        RETURN 2 * (admin_level + 2);
    END IF;
EXCEPTION when others THEN
    RETURN NULL;
END $$;
