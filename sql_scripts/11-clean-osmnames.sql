/*
    This ends up deleting the header row if that snuck in and also the South Pole because
    latitude in NaN for South Pole
*/

DELETE FROM osmnames WHERE to_float(lat) IS NULL OR to_float(lon) IS NULL OR name IS NULL;
