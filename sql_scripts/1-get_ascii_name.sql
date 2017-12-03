CREATE OR REPLACE FUNCTION get_ascii_name(name text)
RETURNS text language plpgsql
AS $$
begin
    return to_ascii(encode(convert_to(unaccent(name),'LATIN9'),'escape'),'LATIN9');
exception when others then
    return null;
end $$;
