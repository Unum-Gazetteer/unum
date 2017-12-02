CREATE TABLE verbose_geo_tags (
    gt_id int,
    gt_page_id int,
    gt_globe varchar(100),
    gt_primary smallint,
    gt_lat float,
    gt_lon float,
    gt_dim varchar(100),
    gt_type varchar(100),
    gt_name varchar(255),
    gt_country char(2),
    gt_region varchar(100),
    gt_page_title varchar(500)
);

COPY verbose_geo_tags FROM '/tmp/verbose_geo_tags.tsv' WITH (FORMAT 'csv', DELIMITER E'\t');
