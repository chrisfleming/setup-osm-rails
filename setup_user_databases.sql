CREATE ROLE openstreetmap PASSWORD 'md5d3a77defa3ebde05a5325ee848c96ace' SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;
CREATE DATABASE openstreetmap OWNER openstreetmap ENCODING 'UTF8';
CREATE DATABASE osm_test OWNER openstreetmap ENCODING 'UTF8';
CREATE DATABASE osm OWNER openstreetmap ENCODING 'UTF8';

