CREATE ROLE test PASSWORD 'md5d3a77defa3ebde05a5325ee848c96ace' SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;
CREATE DATABASE test OWNER openstreetmap ENCODING 'UTF8';
CREATE DATABASE test OWNER osm_test ENCODING 'UTF8';
CREATE DATABASE test OWNER osm ENCODING 'UTF8';

