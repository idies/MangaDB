--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: functions; Type: SCHEMA; Schema: -; Owner: manga
--

CREATE SCHEMA functions;


ALTER SCHEMA functions OWNER TO manga;

--
-- Name: mangaauxdb; Type: SCHEMA; Schema: -; Owner: manga
--

CREATE SCHEMA mangaauxdb;


ALTER SCHEMA mangaauxdb OWNER TO manga;

--
-- Name: mangadapdb; Type: SCHEMA; Schema: -; Owner: manga
--

CREATE SCHEMA mangadapdb;


ALTER SCHEMA mangadapdb OWNER TO manga;

--
-- Name: mangadatadb; Type: SCHEMA; Schema: -; Owner: manga
--

CREATE SCHEMA mangadatadb;


ALTER SCHEMA mangadatadb OWNER TO manga;

--
-- Name: mangasampledb; Type: SCHEMA; Schema: -; Owner: manga
--

CREATE SCHEMA mangasampledb;


ALTER SCHEMA mangasampledb OWNER TO manga;

--
-- Name: platelist; Type: SCHEMA; Schema: -; Owner: manga
--

CREATE SCHEMA platelist;


ALTER SCHEMA platelist OWNER TO manga;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: cstore_fdw; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS cstore_fdw WITH SCHEMA public;


--
-- Name: EXTENSION cstore_fdw; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION cstore_fdw IS 'foreign-data wrapper for flat cstore access';


--
-- Name: pg_buffercache; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_buffercache WITH SCHEMA public;


--
-- Name: EXTENSION pg_buffercache; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_buffercache IS 'examine the shared buffer cache';


SET search_path = functions, pg_catalog;

--
-- Name: filter_wavelength(real[], integer, integer); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION filter_wavelength(wavelength real[], minwave integer, maxwave integer) RETURNS numeric[]
    LANGUAGE plpgsql STABLE
    AS $$

DECLARE result numeric[];
BEGIN
select array_agg(f) from (select unnest(wavelength) as f) as g where (f between minwave and maxwave) into result;
return result;
END; $$;


ALTER FUNCTION functions.filter_wavelength(wavelength real[], minwave integer, maxwave integer) OWNER TO manga;

--
-- Name: pg_schema_size(text); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION pg_schema_size(text) RETURNS bigint
    LANGUAGE sql
    AS $_$
SELECT SUM(pg_total_relation_size(quote_ident(schemaname) || '.' || quote_ident(tablename)))::BIGINT FROM pg_tables WHERE schemaname = $1
$_$;


ALTER FUNCTION functions.pg_schema_size(text) OWNER TO manga;

--
-- Name: q3c_ellipse_join(double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION q3c_ellipse_join(leftra double precision, leftdec double precision, rightra double precision, rightdec double precision, majoraxis double precision, axisratio double precision, pa double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT (((q3c_ang2ipix($3,$4)>=(q3c_ellipse_nearby_it($1,$2,$5,$6,$7,0))) AND (q3c_ang2ipix($3,$4)<=(q3c_ellipse_nearby_it($1,$2,$5,$6,$7,1))))
    OR ((q3c_ang2ipix($3,$4)>=(q3c_ellipse_nearby_it($1,$2,$5,$6,$7,2))) AND (q3c_ang2ipix($3,$4)<=(q3c_ellipse_nearby_it($1,$2,$5,$6,$7,3))))
    OR ((q3c_ang2ipix($3,$4)>=(q3c_ellipse_nearby_it($1,$2,$5,$6,$7,4))) AND (q3c_ang2ipix($3,$4)<=(q3c_ellipse_nearby_it($1,$2,$5,$6,$7,5))))
    OR ((q3c_ang2ipix($3,$4)>=(q3c_ellipse_nearby_it($1,$2,$5,$6,$7,6))) AND (q3c_ang2ipix($3,$4)<=(q3c_ellipse_nearby_it($1,$2,$5,$6,$7,7))))) 
    AND q3c_in_ellipse($3,$4,$1,$2,$5,$6,$7)
$_$;


ALTER FUNCTION functions.q3c_ellipse_join(leftra double precision, leftdec double precision, rightra double precision, rightdec double precision, majoraxis double precision, axisratio double precision, pa double precision) OWNER TO manga;

--
-- Name: q3c_ellipse_query(double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION q3c_ellipse_query(ra_col double precision, dec_col double precision, ra_ell double precision, dec_ell double precision, majax double precision, axis_ratio double precision, pa double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT (
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,0,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,1,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,2,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,3,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,4,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,5,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,6,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,7,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,8,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,9,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,10,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,11,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,12,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,13,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,14,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,15,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,16,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,17,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,18,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,19,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,20,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,21,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,22,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,23,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,24,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,25,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,26,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,27,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,28,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,29,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,30,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,31,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,32,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,33,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,34,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,35,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,36,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,37,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,38,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,39,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,40,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,41,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,42,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,43,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,44,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,45,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,46,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,47,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,48,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,49,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,50,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,51,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,52,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,53,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,54,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,55,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,56,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,57,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,58,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,59,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,60,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,61,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,62,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,63,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,64,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,65,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,66,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,67,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,68,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,69,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,70,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,71,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,72,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,73,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,74,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,75,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,76,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,77,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,78,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,79,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,80,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,81,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,82,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,83,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,84,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,85,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,86,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,87,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,88,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,89,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,90,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,91,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,92,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,93,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,94,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,95,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,96,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,97,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,98,1) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,99,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,0,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,1,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,2,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,3,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,4,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,5,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,6,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,7,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,8,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,9,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,10,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,11,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,12,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,13,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,14,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,15,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,16,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,17,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,18,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,19,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,20,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,21,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,22,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,23,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,24,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,25,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,26,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,27,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,28,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,29,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,30,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,31,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,32,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,33,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,34,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,35,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,36,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,37,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,38,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,39,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,40,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,41,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,42,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,43,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,44,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,45,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,46,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,47,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,48,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,49,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,50,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,51,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,52,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,53,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,54,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,55,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,56,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,57,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,58,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,59,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,60,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,61,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,62,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,63,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,64,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,65,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,66,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,67,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,68,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,69,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,70,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,71,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,72,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,73,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,74,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,75,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,76,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,77,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,78,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,79,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,80,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,81,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,82,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,83,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,84,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,85,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,86,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,87,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,88,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,89,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,90,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,91,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,92,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,93,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,94,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,95,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,96,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,97,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_ellipse_query_it($3,$4,$5,$6,$7,98,0) AND q3c_ang2ipix($1,$2)<q3c_ellipse_query_it($3,$4,$5,$6,$7,99,0)) 
) AND 
q3c_in_ellipse($1,$2,$3,$4,$5,$6,$7)
$_$;


ALTER FUNCTION functions.q3c_ellipse_query(ra_col double precision, dec_col double precision, ra_ell double precision, dec_ell double precision, majax double precision, axis_ratio double precision, pa double precision) OWNER TO manga;

--
-- Name: q3c_ipixcenter(double precision, double precision, integer); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION q3c_ipixcenter(ra double precision, decl double precision, integer) RETURNS bigint
    LANGUAGE sql
    AS $_$SELECT ((q3c_ang2ipix($1,$2))>>((2*$3))<<((2*$3))) +
			((1::bigint)<<(2*($3-1))) -1$_$;


ALTER FUNCTION functions.q3c_ipixcenter(ra double precision, decl double precision, integer) OWNER TO manga;

--
-- Name: q3c_join(double precision, double precision, real, real, double precision); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION q3c_join(leftra double precision, leftdec double precision, rightra real, rightdec real, radius double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT (((q3c_ang2ipix($3,$4)>=(q3c_nearby_it($1,$2,$5,0))) AND (q3c_ang2ipix($3,$4)<=(q3c_nearby_it($1,$2,$5,1))))
    OR ((q3c_ang2ipix($3,$4)>=(q3c_nearby_it($1,$2,$5,2))) AND (q3c_ang2ipix($3,$4)<=(q3c_nearby_it($1,$2,$5,3))))
    OR ((q3c_ang2ipix($3,$4)>=(q3c_nearby_it($1,$2,$5,4))) AND (q3c_ang2ipix($3,$4)<=(q3c_nearby_it($1,$2,$5,5))))
    OR ((q3c_ang2ipix($3,$4)>=(q3c_nearby_it($1,$2,$5,6))) AND (q3c_ang2ipix($3,$4)<=(q3c_nearby_it($1,$2,$5,7))))) 
    AND q3c_sindist($1,$2,$3,$4)<POW(SIN(RADIANS($5)/2),2)
$_$;


ALTER FUNCTION functions.q3c_join(leftra double precision, leftdec double precision, rightra real, rightdec real, radius double precision) OWNER TO manga;

--
-- Name: q3c_join(double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION q3c_join(leftra double precision, leftdec double precision, rightra double precision, rightdec double precision, radius double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT (((q3c_ang2ipix($3,$4)>=(q3c_nearby_it($1,$2,$5,0))) AND (q3c_ang2ipix($3,$4)<=(q3c_nearby_it($1,$2,$5,1))))
    OR ((q3c_ang2ipix($3,$4)>=(q3c_nearby_it($1,$2,$5,2))) AND (q3c_ang2ipix($3,$4)<=(q3c_nearby_it($1,$2,$5,3))))
    OR ((q3c_ang2ipix($3,$4)>=(q3c_nearby_it($1,$2,$5,4))) AND (q3c_ang2ipix($3,$4)<=(q3c_nearby_it($1,$2,$5,5))))
    OR ((q3c_ang2ipix($3,$4)>=(q3c_nearby_it($1,$2,$5,6))) AND (q3c_ang2ipix($3,$4)<=(q3c_nearby_it($1,$2,$5,7))))) 
    AND q3c_sindist($1,$2,$3,$4)<POW(SIN(RADIANS($5)/2),2)
$_$;


ALTER FUNCTION functions.q3c_join(leftra double precision, leftdec double precision, rightra double precision, rightdec double precision, radius double precision) OWNER TO manga;

--
-- Name: q3c_join(double precision, double precision, double precision, double precision, bigint, double precision); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION q3c_join(double precision, double precision, double precision, double precision, bigint, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT ((($5>=(q3c_nearby_it($1,$2,$6,0))) AND ($5<=(q3c_nearby_it($1,$2,$6,1))))
    OR (($5>=(q3c_nearby_it($1,$2,$6,2))) AND ($5<=(q3c_nearby_it($1,$2,$6,3))))
    OR (($5>=(q3c_nearby_it($1,$2,$6,4))) AND ($5<=(q3c_nearby_it($1,$2,$6,5))))
    OR (($5>=(q3c_nearby_it($1,$2,$6,6))) AND ($5<=(q3c_nearby_it($1,$2,$6,7))))) 
    AND q3c_sindist($1,$2,$3,$4)<POW(SIN(RADIANS($6)/2),2)
$_$;


ALTER FUNCTION functions.q3c_join(double precision, double precision, double precision, double precision, bigint, double precision) OWNER TO manga;

--
-- Name: q3c_poly_query(real, real, double precision[]); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION q3c_poly_query(real, real, double precision[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT 
(
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,0,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,1,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,2,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,3,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,4,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,5,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,6,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,7,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,8,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,9,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,10,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,11,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,12,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,13,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,14,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,15,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,16,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,17,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,18,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,19,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,20,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,21,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,22,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,23,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,24,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,25,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,26,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,27,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,28,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,29,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,30,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,31,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,32,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,33,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,34,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,35,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,36,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,37,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,38,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,39,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,40,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,41,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,42,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,43,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,44,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,45,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,46,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,47,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,48,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,49,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,50,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,51,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,52,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,53,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,54,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,55,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,56,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,57,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,58,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,59,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,60,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,61,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,62,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,63,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,64,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,65,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,66,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,67,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,68,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,69,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,70,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,71,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,72,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,73,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,74,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,75,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,76,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,77,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,78,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,79,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,80,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,81,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,82,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,83,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,84,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,85,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,86,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,87,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,88,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,89,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,90,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,91,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,92,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,93,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,94,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,95,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,96,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,97,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,98,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,99,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,0,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,1,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,2,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,3,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,4,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,5,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,6,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,7,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,8,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,9,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,10,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,11,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,12,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,13,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,14,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,15,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,16,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,17,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,18,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,19,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,20,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,21,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,22,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,23,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,24,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,25,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,26,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,27,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,28,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,29,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,30,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,31,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,32,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,33,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,34,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,35,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,36,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,37,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,38,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,39,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,40,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,41,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,42,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,43,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,44,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,45,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,46,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,47,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,48,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,49,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,50,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,51,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,52,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,53,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,54,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,55,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,56,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,57,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,58,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,59,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,60,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,61,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,62,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,63,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,64,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,65,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,66,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,67,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,68,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,69,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,70,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,71,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,72,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,73,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,74,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,75,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,76,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,77,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,78,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,79,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,80,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,81,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,82,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,83,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,84,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,85,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,86,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,87,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,88,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,89,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,90,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,91,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,92,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,93,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,94,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,95,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,96,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,97,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,98,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,99,0)) 
) AND 
q3c_in_poly($1,$2,$3) ;
$_$;


ALTER FUNCTION functions.q3c_poly_query(real, real, double precision[]) OWNER TO manga;

--
-- Name: q3c_poly_query(double precision, double precision, double precision[]); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION q3c_poly_query(double precision, double precision, double precision[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT 
(
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,0,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,1,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,2,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,3,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,4,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,5,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,6,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,7,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,8,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,9,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,10,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,11,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,12,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,13,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,14,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,15,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,16,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,17,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,18,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,19,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,20,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,21,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,22,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,23,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,24,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,25,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,26,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,27,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,28,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,29,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,30,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,31,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,32,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,33,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,34,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,35,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,36,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,37,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,38,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,39,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,40,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,41,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,42,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,43,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,44,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,45,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,46,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,47,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,48,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,49,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,50,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,51,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,52,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,53,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,54,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,55,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,56,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,57,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,58,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,59,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,60,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,61,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,62,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,63,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,64,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,65,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,66,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,67,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,68,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,69,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,70,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,71,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,72,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,73,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,74,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,75,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,76,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,77,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,78,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,79,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,80,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,81,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,82,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,83,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,84,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,85,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,86,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,87,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,88,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,89,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,90,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,91,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,92,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,93,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,94,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,95,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,96,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,97,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,98,1) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,99,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,0,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,1,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,2,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,3,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,4,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,5,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,6,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,7,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,8,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,9,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,10,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,11,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,12,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,13,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,14,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,15,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,16,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,17,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,18,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,19,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,20,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,21,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,22,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,23,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,24,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,25,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,26,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,27,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,28,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,29,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,30,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,31,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,32,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,33,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,34,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,35,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,36,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,37,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,38,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,39,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,40,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,41,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,42,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,43,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,44,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,45,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,46,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,47,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,48,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,49,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,50,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,51,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,52,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,53,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,54,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,55,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,56,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,57,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,58,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,59,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,60,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,61,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,62,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,63,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,64,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,65,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,66,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,67,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,68,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,69,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,70,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,71,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,72,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,73,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,74,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,75,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,76,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,77,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,78,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,79,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,80,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,81,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,82,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,83,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,84,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,85,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,86,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,87,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,88,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,89,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,90,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,91,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,92,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,93,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,94,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,95,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,96,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,97,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_poly_query_it($3,98,0) AND q3c_ang2ipix($1,$2)<q3c_poly_query_it($3,99,0)) 
) AND 
q3c_in_poly($1,$2,$3);
$_$;


ALTER FUNCTION functions.q3c_poly_query(double precision, double precision, double precision[]) OWNER TO manga;

--
-- Name: q3c_radial_query(real, real, double precision, double precision, double precision); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION q3c_radial_query(real, real, double precision, double precision, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT (
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,0,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,1,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,2,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,3,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,4,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,5,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,6,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,7,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,8,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,9,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,10,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,11,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,12,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,13,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,14,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,15,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,16,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,17,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,18,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,19,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,20,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,21,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,22,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,23,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,24,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,25,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,26,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,27,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,28,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,29,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,30,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,31,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,32,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,33,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,34,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,35,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,36,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,37,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,38,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,39,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,40,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,41,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,42,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,43,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,44,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,45,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,46,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,47,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,48,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,49,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,50,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,51,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,52,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,53,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,54,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,55,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,56,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,57,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,58,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,59,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,60,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,61,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,62,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,63,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,64,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,65,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,66,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,67,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,68,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,69,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,70,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,71,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,72,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,73,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,74,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,75,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,76,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,77,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,78,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,79,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,80,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,81,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,82,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,83,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,84,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,85,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,86,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,87,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,88,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,89,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,90,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,91,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,92,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,93,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,94,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,95,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,96,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,97,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,98,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,99,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,0,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,1,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,2,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,3,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,4,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,5,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,6,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,7,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,8,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,9,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,10,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,11,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,12,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,13,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,14,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,15,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,16,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,17,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,18,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,19,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,20,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,21,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,22,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,23,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,24,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,25,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,26,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,27,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,28,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,29,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,30,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,31,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,32,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,33,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,34,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,35,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,36,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,37,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,38,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,39,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,40,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,41,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,42,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,43,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,44,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,45,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,46,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,47,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,48,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,49,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,50,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,51,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,52,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,53,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,54,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,55,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,56,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,57,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,58,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,59,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,60,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,61,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,62,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,63,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,64,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,65,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,66,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,67,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,68,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,69,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,70,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,71,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,72,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,73,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,74,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,75,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,76,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,77,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,78,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,79,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,80,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,81,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,82,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,83,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,84,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,85,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,86,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,87,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,88,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,89,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,90,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,91,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,92,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,93,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,94,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,95,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,96,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,97,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,98,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,99,0)) 
) AND
q3c_sindist($1,$2,$3,$4)<POW(SIN(RADIANS($5)/2),2)
$_$;


ALTER FUNCTION functions.q3c_radial_query(real, real, double precision, double precision, double precision) OWNER TO manga;

--
-- Name: q3c_radial_query(double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION q3c_radial_query(double precision, double precision, double precision, double precision, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT 
(
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,0,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,1,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,2,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,3,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,4,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,5,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,6,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,7,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,8,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,9,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,10,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,11,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,12,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,13,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,14,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,15,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,16,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,17,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,18,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,19,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,20,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,21,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,22,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,23,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,24,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,25,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,26,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,27,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,28,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,29,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,30,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,31,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,32,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,33,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,34,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,35,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,36,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,37,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,38,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,39,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,40,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,41,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,42,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,43,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,44,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,45,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,46,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,47,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,48,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,49,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,50,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,51,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,52,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,53,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,54,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,55,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,56,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,57,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,58,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,59,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,60,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,61,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,62,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,63,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,64,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,65,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,66,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,67,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,68,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,69,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,70,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,71,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,72,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,73,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,74,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,75,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,76,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,77,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,78,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,79,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,80,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,81,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,82,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,83,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,84,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,85,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,86,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,87,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,88,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,89,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,90,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,91,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,92,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,93,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,94,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,95,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,96,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,97,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,98,1) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,99,1)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,0,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,1,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,2,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,3,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,4,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,5,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,6,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,7,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,8,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,9,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,10,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,11,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,12,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,13,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,14,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,15,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,16,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,17,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,18,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,19,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,20,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,21,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,22,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,23,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,24,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,25,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,26,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,27,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,28,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,29,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,30,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,31,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,32,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,33,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,34,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,35,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,36,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,37,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,38,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,39,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,40,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,41,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,42,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,43,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,44,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,45,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,46,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,47,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,48,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,49,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,50,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,51,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,52,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,53,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,54,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,55,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,56,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,57,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,58,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,59,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,60,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,61,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,62,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,63,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,64,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,65,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,66,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,67,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,68,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,69,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,70,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,71,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,72,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,73,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,74,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,75,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,76,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,77,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,78,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,79,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,80,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,81,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,82,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,83,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,84,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,85,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,86,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,87,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,88,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,89,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,90,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,91,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,92,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,93,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,94,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,95,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,96,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,97,0)) OR
(q3c_ang2ipix($1,$2)>=q3c_radial_query_it($3,$4,$5,98,0) AND q3c_ang2ipix($1,$2)<q3c_radial_query_it($3,$4,$5,99,0)) 
) AND
q3c_sindist($1,$2,$3,$4)<POW(SIN(RADIANS($5)/2),2)
$_$;


ALTER FUNCTION functions.q3c_radial_query(double precision, double precision, double precision, double precision, double precision) OWNER TO manga;

--
-- Name: q3c_radial_query(bigint, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION q3c_radial_query(bigint, double precision, double precision, double precision, double precision, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT 
(
($1>=q3c_radial_query_it($4,$5,$6,0,1) AND $1<q3c_radial_query_it($4,$5,$6,1,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,2,1) AND $1<q3c_radial_query_it($4,$5,$6,3,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,4,1) AND $1<q3c_radial_query_it($4,$5,$6,5,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,6,1) AND $1<q3c_radial_query_it($4,$5,$6,7,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,8,1) AND $1<q3c_radial_query_it($4,$5,$6,9,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,10,1) AND $1<q3c_radial_query_it($4,$5,$6,11,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,12,1) AND $1<q3c_radial_query_it($4,$5,$6,13,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,14,1) AND $1<q3c_radial_query_it($4,$5,$6,15,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,16,1) AND $1<q3c_radial_query_it($4,$5,$6,17,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,18,1) AND $1<q3c_radial_query_it($4,$5,$6,19,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,20,1) AND $1<q3c_radial_query_it($4,$5,$6,21,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,22,1) AND $1<q3c_radial_query_it($4,$5,$6,23,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,24,1) AND $1<q3c_radial_query_it($4,$5,$6,25,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,26,1) AND $1<q3c_radial_query_it($4,$5,$6,27,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,28,1) AND $1<q3c_radial_query_it($4,$5,$6,29,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,30,1) AND $1<q3c_radial_query_it($4,$5,$6,31,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,32,1) AND $1<q3c_radial_query_it($4,$5,$6,33,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,34,1) AND $1<q3c_radial_query_it($4,$5,$6,35,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,36,1) AND $1<q3c_radial_query_it($4,$5,$6,37,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,38,1) AND $1<q3c_radial_query_it($4,$5,$6,39,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,40,1) AND $1<q3c_radial_query_it($4,$5,$6,41,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,42,1) AND $1<q3c_radial_query_it($4,$5,$6,43,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,44,1) AND $1<q3c_radial_query_it($4,$5,$6,45,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,46,1) AND $1<q3c_radial_query_it($4,$5,$6,47,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,48,1) AND $1<q3c_radial_query_it($4,$5,$6,49,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,50,1) AND $1<q3c_radial_query_it($4,$5,$6,51,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,52,1) AND $1<q3c_radial_query_it($4,$5,$6,53,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,54,1) AND $1<q3c_radial_query_it($4,$5,$6,55,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,56,1) AND $1<q3c_radial_query_it($4,$5,$6,57,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,58,1) AND $1<q3c_radial_query_it($4,$5,$6,59,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,60,1) AND $1<q3c_radial_query_it($4,$5,$6,61,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,62,1) AND $1<q3c_radial_query_it($4,$5,$6,63,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,64,1) AND $1<q3c_radial_query_it($4,$5,$6,65,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,66,1) AND $1<q3c_radial_query_it($4,$5,$6,67,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,68,1) AND $1<q3c_radial_query_it($4,$5,$6,69,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,70,1) AND $1<q3c_radial_query_it($4,$5,$6,71,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,72,1) AND $1<q3c_radial_query_it($4,$5,$6,73,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,74,1) AND $1<q3c_radial_query_it($4,$5,$6,75,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,76,1) AND $1<q3c_radial_query_it($4,$5,$6,77,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,78,1) AND $1<q3c_radial_query_it($4,$5,$6,79,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,80,1) AND $1<q3c_radial_query_it($4,$5,$6,81,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,82,1) AND $1<q3c_radial_query_it($4,$5,$6,83,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,84,1) AND $1<q3c_radial_query_it($4,$5,$6,85,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,86,1) AND $1<q3c_radial_query_it($4,$5,$6,87,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,88,1) AND $1<q3c_radial_query_it($4,$5,$6,89,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,90,1) AND $1<q3c_radial_query_it($4,$5,$6,91,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,92,1) AND $1<q3c_radial_query_it($4,$5,$6,93,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,94,1) AND $1<q3c_radial_query_it($4,$5,$6,95,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,96,1) AND $1<q3c_radial_query_it($4,$5,$6,97,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,98,1) AND $1<q3c_radial_query_it($4,$5,$6,99,1)) OR
($1>=q3c_radial_query_it($4,$5,$6,0,0) AND $1<q3c_radial_query_it($4,$5,$6,1,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,2,0) AND $1<q3c_radial_query_it($4,$5,$6,3,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,4,0) AND $1<q3c_radial_query_it($4,$5,$6,5,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,6,0) AND $1<q3c_radial_query_it($4,$5,$6,7,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,8,0) AND $1<q3c_radial_query_it($4,$5,$6,9,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,10,0) AND $1<q3c_radial_query_it($4,$5,$6,11,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,12,0) AND $1<q3c_radial_query_it($4,$5,$6,13,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,14,0) AND $1<q3c_radial_query_it($4,$5,$6,15,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,16,0) AND $1<q3c_radial_query_it($4,$5,$6,17,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,18,0) AND $1<q3c_radial_query_it($4,$5,$6,19,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,20,0) AND $1<q3c_radial_query_it($4,$5,$6,21,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,22,0) AND $1<q3c_radial_query_it($4,$5,$6,23,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,24,0) AND $1<q3c_radial_query_it($4,$5,$6,25,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,26,0) AND $1<q3c_radial_query_it($4,$5,$6,27,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,28,0) AND $1<q3c_radial_query_it($4,$5,$6,29,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,30,0) AND $1<q3c_radial_query_it($4,$5,$6,31,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,32,0) AND $1<q3c_radial_query_it($4,$5,$6,33,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,34,0) AND $1<q3c_radial_query_it($4,$5,$6,35,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,36,0) AND $1<q3c_radial_query_it($4,$5,$6,37,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,38,0) AND $1<q3c_radial_query_it($4,$5,$6,39,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,40,0) AND $1<q3c_radial_query_it($4,$5,$6,41,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,42,0) AND $1<q3c_radial_query_it($4,$5,$6,43,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,44,0) AND $1<q3c_radial_query_it($4,$5,$6,45,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,46,0) AND $1<q3c_radial_query_it($4,$5,$6,47,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,48,0) AND $1<q3c_radial_query_it($4,$5,$6,49,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,50,0) AND $1<q3c_radial_query_it($4,$5,$6,51,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,52,0) AND $1<q3c_radial_query_it($4,$5,$6,53,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,54,0) AND $1<q3c_radial_query_it($4,$5,$6,55,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,56,0) AND $1<q3c_radial_query_it($4,$5,$6,57,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,58,0) AND $1<q3c_radial_query_it($4,$5,$6,59,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,60,0) AND $1<q3c_radial_query_it($4,$5,$6,61,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,62,0) AND $1<q3c_radial_query_it($4,$5,$6,63,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,64,0) AND $1<q3c_radial_query_it($4,$5,$6,65,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,66,0) AND $1<q3c_radial_query_it($4,$5,$6,67,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,68,0) AND $1<q3c_radial_query_it($4,$5,$6,69,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,70,0) AND $1<q3c_radial_query_it($4,$5,$6,71,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,72,0) AND $1<q3c_radial_query_it($4,$5,$6,73,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,74,0) AND $1<q3c_radial_query_it($4,$5,$6,75,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,76,0) AND $1<q3c_radial_query_it($4,$5,$6,77,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,78,0) AND $1<q3c_radial_query_it($4,$5,$6,79,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,80,0) AND $1<q3c_radial_query_it($4,$5,$6,81,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,82,0) AND $1<q3c_radial_query_it($4,$5,$6,83,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,84,0) AND $1<q3c_radial_query_it($4,$5,$6,85,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,86,0) AND $1<q3c_radial_query_it($4,$5,$6,87,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,88,0) AND $1<q3c_radial_query_it($4,$5,$6,89,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,90,0) AND $1<q3c_radial_query_it($4,$5,$6,91,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,92,0) AND $1<q3c_radial_query_it($4,$5,$6,93,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,94,0) AND $1<q3c_radial_query_it($4,$5,$6,95,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,96,0) AND $1<q3c_radial_query_it($4,$5,$6,97,0)) OR
($1>=q3c_radial_query_it($4,$5,$6,98,0) AND $1<q3c_radial_query_it($4,$5,$6,99,0)) 
) AND 
q3c_sindist($2,$3,$4,$5)<POW(SIN(RADIANS($6)/2),2)

$_$;


ALTER FUNCTION functions.q3c_radial_query(bigint, double precision, double precision, double precision, double precision, double precision) OWNER TO manga;

--
-- Name: rest_wavelength(double precision); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION rest_wavelength(nsaz double precision) RETURNS numeric[]
    LANGUAGE plpgsql STABLE
    AS $$

DECLARE result numeric[];
BEGIN
select array_agg(f) from (select unnest(w.wavelength)/(1+nsaz) as f from mangadatadb.wavelength as w) as g into result;
return result;
END; $$;


ALTER FUNCTION functions.rest_wavelength(nsaz double precision) OWNER TO manga;

--
-- Name: sizedb(); Type: FUNCTION; Schema: functions; Owner: manga
--

CREATE FUNCTION sizedb() RETURNS text
    LANGUAGE sql
    AS $$
SELECT pg_size_pretty(pg_database_size(current_database()));
$$;


ALTER FUNCTION functions.sizedb() OWNER TO manga;

SET search_path = public, pg_catalog;

--
-- Name: generate_create_table_statement(character varying); Type: FUNCTION; Schema: public; Owner: swerner
--

CREATE FUNCTION generate_create_table_statement(p_table_name character varying) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE
    v_table_ddl   text;
    column_record record;
BEGIN
    FOR column_record IN 
        SELECT 
            b.nspname as schema_name,
            b.relname as table_name,
            a.attname as column_name,
            pg_catalog.format_type(a.atttypid, a.atttypmod) as column_type,
            CASE WHEN 
                (SELECT substring(pg_catalog.pg_get_expr(d.adbin, d.adrelid) for 128)
                 FROM pg_catalog.pg_attrdef d
                 WHERE d.adrelid = a.attrelid AND d.adnum = a.attnum AND a.atthasdef) IS NOT NULL THEN
                'DEFAULT '|| (SELECT substring(pg_catalog.pg_get_expr(d.adbin, d.adrelid) for 128)
                              FROM pg_catalog.pg_attrdef d
                              WHERE d.adrelid = a.attrelid AND d.adnum = a.attnum AND a.atthasdef)
            ELSE
                ''
            END as column_default_value,
            CASE WHEN a.attnotnull = true THEN 
                'NOT NULL'
            ELSE
                'NULL'
            END as column_not_null,
            a.attnum as attnum,
            e.max_attnum as max_attnum
        FROM 
            pg_catalog.pg_attribute a
            INNER JOIN 
             (SELECT c.oid,
                n.nspname,
                c.relname
              FROM pg_catalog.pg_class c
                   LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
              WHERE c.relname ~ ('^('||p_table_name||')$')
                AND pg_catalog.pg_table_is_visible(c.oid)
              ORDER BY 2, 3) b
            ON a.attrelid = b.oid
            INNER JOIN 
             (SELECT 
                  a.attrelid,
                  max(a.attnum) as max_attnum
              FROM pg_catalog.pg_attribute a
              WHERE a.attnum > 0 
                AND NOT a.attisdropped
              GROUP BY a.attrelid) e
            ON a.attrelid=e.attrelid
        WHERE a.attnum > 0 
          AND NOT a.attisdropped
        ORDER BY a.attnum
    LOOP
        IF column_record.attnum = 1 THEN
            v_table_ddl:='CREATE TABLE '||column_record.schema_name||'.'||column_record.table_name||' (';
        ELSE
            v_table_ddl:=v_table_ddl||',';
        END IF;

        IF column_record.attnum <= column_record.max_attnum THEN
            v_table_ddl:=v_table_ddl||chr(10)||
                     '    '||column_record.column_name||' '||column_record.column_type||' '||column_record.column_default_value||' '||column_record.column_not_null;
        END IF;
    END LOOP;

    v_table_ddl:=v_table_ddl||');';
    RETURN v_table_ddl;
END;
$_$;


ALTER FUNCTION public.generate_create_table_statement(p_table_name character varying) OWNER TO swerner;

--
-- Name: cstore_server; Type: SERVER; Schema: -; Owner: swerner
--

CREATE SERVER cstore_server FOREIGN DATA WRAPPER cstore_fdw;


ALTER SERVER cstore_server OWNER TO swerner;

SET search_path = mangaauxdb, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cube_header; Type: TABLE; Schema: mangaauxdb; Owner: manga
--

CREATE TABLE cube_header (
    pk integer NOT NULL,
    header json,
    cube_pk integer
);


ALTER TABLE cube_header OWNER TO manga;

--
-- Name: cube_header_pk_seq; Type: SEQUENCE; Schema: mangaauxdb; Owner: manga
--

CREATE SEQUENCE cube_header_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cube_header_pk_seq OWNER TO manga;

--
-- Name: cube_header_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangaauxdb; Owner: manga
--

ALTER SEQUENCE cube_header_pk_seq OWNED BY cube_header.pk;


--
-- Name: maskbit; Type: TABLE; Schema: mangaauxdb; Owner: manga
--

CREATE TABLE maskbit (
    pk integer NOT NULL,
    flag text,
    "bit" integer,
    label text,
    description text
);


ALTER TABLE maskbit OWNER TO manga;

--
-- Name: maskbit_labels; Type: TABLE; Schema: mangaauxdb; Owner: manga
--

CREATE TABLE maskbit_labels (
    pk integer NOT NULL,
    maskbit integer,
    labels json,
    flag text
);


ALTER TABLE maskbit_labels OWNER TO manga;

--
-- Name: maskbit_labels_pk_seq; Type: SEQUENCE; Schema: mangaauxdb; Owner: manga
--

CREATE SEQUENCE maskbit_labels_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE maskbit_labels_pk_seq OWNER TO manga;

--
-- Name: maskbit_labels_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangaauxdb; Owner: manga
--

ALTER SEQUENCE maskbit_labels_pk_seq OWNED BY maskbit_labels.pk;


--
-- Name: maskbit_pk_seq; Type: SEQUENCE; Schema: mangaauxdb; Owner: manga
--

CREATE SEQUENCE maskbit_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE maskbit_pk_seq OWNER TO manga;

--
-- Name: maskbit_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangaauxdb; Owner: manga
--

ALTER SEQUENCE maskbit_pk_seq OWNED BY maskbit.pk;


SET search_path = mangadapdb, pg_catalog;

--
-- Name: binid; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE binid (
    pk integer NOT NULL,
    id integer
);


ALTER TABLE binid OWNER TO manga;

--
-- Name: binmode; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE binmode (
    pk integer NOT NULL,
    name text
);


ALTER TABLE binmode OWNER TO manga;

--
-- Name: binmode_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE binmode_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE binmode_pk_seq OWNER TO manga;

--
-- Name: binmode_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE binmode_pk_seq OWNED BY binmode.pk;


--
-- Name: bintype; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE bintype (
    pk integer NOT NULL,
    name text
);


ALTER TABLE bintype OWNER TO manga;

--
-- Name: bintype_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE bintype_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bintype_pk_seq OWNER TO manga;

--
-- Name: bintype_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE bintype_pk_seq OWNED BY bintype.pk;


--
-- Name: c5_cstore; Type: FOREIGN TABLE; Schema: mangadapdb; Owner: manga
--

CREATE FOREIGN TABLE c5_cstore (
    pk bigint,
    file_pk integer,
    spaxel_index integer,
    binid_pk integer,
    spx_skycoo_on_sky_x real,
    spx_skycoo_on_sky_y real,
    spx_ellcoo_elliptical_radius real,
    spx_ellcoo_elliptical_azimuth real,
    spx_mflux real,
    spx_mflux_ivar double precision,
    spx_snr real,
    binid integer,
    bin_lwskycoo_lum_weighted_on_sky_x real,
    bin_lwskycoo_lum_weighted_on_sky_y real,
    bin_lwellcoo_lum_weighted_elliptical_radius real,
    bin_lwellcoo_lum_weighted_elliptical_azimuth real,
    bin_area real,
    bin_farea real,
    bin_mflux real,
    bin_mflux_ivar double precision,
    bin_mflux_mask integer,
    bin_snr real,
    stellar_vel real,
    stellar_vel_ivar double precision,
    stellar_vel_mask integer,
    stellar_sigma real,
    stellar_sigma_ivar double precision,
    stellar_sigma_mask integer,
    stellar_sigmacorr real,
    stellar_cont_fresid_68th_percentile real,
    stellar_cont_fresid_99th_percentile real,
    stellar_cont_rchi2 real,
    emline_sflux_oiid_3728 real,
    emline_sflux_hb_4862 real,
    emline_sflux_oiii_4960 real,
    emline_sflux_oiii_5008 real,
    emline_sflux_oi_6302 real,
    emline_sflux_oi_6365 real,
    emline_sflux_nii_6549 real,
    emline_sflux_ha_6564 real,
    emline_sflux_nii_6585 real,
    emline_sflux_sii_6718 real,
    emline_sflux_sii_6732 real,
    emline_sflux_oii_3727 real,
    emline_sflux_oii_3729 real,
    emline_sflux_heps_3971 real,
    emline_sflux_hdel_4102 real,
    emline_sflux_hgam_4341 real,
    emline_sflux_heii_4687 real,
    emline_sflux_hei_5877 real,
    emline_sflux_siii_8831 real,
    emline_sflux_siii_9071 real,
    emline_sflux_siii_9533 real,
    emline_sflux_ivar_oiid_3728 double precision,
    emline_sflux_ivar_hb_4862 double precision,
    emline_sflux_ivar_oiii_4960 double precision,
    emline_sflux_ivar_oiii_5008 double precision,
    emline_sflux_ivar_oi_6302 double precision,
    emline_sflux_ivar_oi_6365 double precision,
    emline_sflux_ivar_nii_6549 double precision,
    emline_sflux_ivar_ha_6564 double precision,
    emline_sflux_ivar_nii_6585 double precision,
    emline_sflux_ivar_sii_6718 double precision,
    emline_sflux_ivar_sii_6732 double precision,
    emline_sflux_ivar_oii_3727 double precision,
    emline_sflux_ivar_oii_3729 double precision,
    emline_sflux_ivar_heps_3971 double precision,
    emline_sflux_ivar_hdel_4102 double precision,
    emline_sflux_ivar_hgam_4341 double precision,
    emline_sflux_ivar_heii_4687 double precision,
    emline_sflux_ivar_hei_5877 double precision,
    emline_sflux_ivar_siii_8831 double precision,
    emline_sflux_ivar_siii_9071 double precision,
    emline_sflux_ivar_siii_9533 double precision,
    emline_sflux_mask_oiid_3728 integer,
    emline_sflux_mask_hb_4862 integer,
    emline_sflux_mask_oiii_4960 integer,
    emline_sflux_mask_oiii_5008 integer,
    emline_sflux_mask_oi_6302 integer,
    emline_sflux_mask_oi_6365 integer,
    emline_sflux_mask_nii_6549 integer,
    emline_sflux_mask_ha_6564 integer,
    emline_sflux_mask_nii_6585 integer,
    emline_sflux_mask_sii_6718 integer,
    emline_sflux_mask_sii_6732 integer,
    emline_sflux_mask_oii_3727 integer,
    emline_sflux_mask_oii_3729 integer,
    emline_sflux_mask_heps_3971 integer,
    emline_sflux_mask_hdel_4102 integer,
    emline_sflux_mask_hgam_4341 integer,
    emline_sflux_mask_heii_4687 integer,
    emline_sflux_mask_hei_5877 integer,
    emline_sflux_mask_siii_8831 integer,
    emline_sflux_mask_siii_9071 integer,
    emline_sflux_mask_siii_9533 integer,
    emline_sew_oiid_3728 double precision,
    emline_sew_hb_4862 double precision,
    emline_sew_oiii_4960 double precision,
    emline_sew_oiii_5008 double precision,
    emline_sew_oi_6302 double precision,
    emline_sew_oi_6365 double precision,
    emline_sew_nii_6549 double precision,
    emline_sew_ha_6564 double precision,
    emline_sew_nii_6585 double precision,
    emline_sew_sii_6718 double precision,
    emline_sew_sii_6732 double precision,
    emline_sew_oii_3727 double precision,
    emline_sew_oii_3729 double precision,
    emline_sew_heps_3971 double precision,
    emline_sew_hdel_4102 double precision,
    emline_sew_hgam_4341 double precision,
    emline_sew_heii_4687 double precision,
    emline_sew_hei_5877 double precision,
    emline_sew_siii_8831 double precision,
    emline_sew_siii_9071 double precision,
    emline_sew_siii_9533 double precision,
    emline_sew_ivar_oiid_3728 double precision,
    emline_sew_ivar_hb_4862 double precision,
    emline_sew_ivar_oiii_4960 double precision,
    emline_sew_ivar_oiii_5008 double precision,
    emline_sew_ivar_oi_6302 double precision,
    emline_sew_ivar_oi_6365 double precision,
    emline_sew_ivar_nii_6549 double precision,
    emline_sew_ivar_ha_6564 double precision,
    emline_sew_ivar_nii_6585 double precision,
    emline_sew_ivar_sii_6718 double precision,
    emline_sew_ivar_sii_6732 double precision,
    emline_sew_ivar_oii_3727 double precision,
    emline_sew_ivar_oii_3729 double precision,
    emline_sew_ivar_heps_3971 double precision,
    emline_sew_ivar_hdel_4102 double precision,
    emline_sew_ivar_hgam_4341 double precision,
    emline_sew_ivar_heii_4687 double precision,
    emline_sew_ivar_hei_5877 double precision,
    emline_sew_ivar_siii_8831 double precision,
    emline_sew_ivar_siii_9071 double precision,
    emline_sew_ivar_siii_9533 double precision,
    emline_sew_mask_oiid_3728 integer,
    emline_sew_mask_hb_4862 integer,
    emline_sew_mask_oiii_4960 integer,
    emline_sew_mask_oiii_5008 integer,
    emline_sew_mask_oi_6302 integer,
    emline_sew_mask_oi_6365 integer,
    emline_sew_mask_nii_6549 integer,
    emline_sew_mask_ha_6564 integer,
    emline_sew_mask_nii_6585 integer,
    emline_sew_mask_sii_6718 integer,
    emline_sew_mask_sii_6732 integer,
    emline_sew_mask_oii_3727 integer,
    emline_sew_mask_oii_3729 integer,
    emline_sew_mask_heps_3971 integer,
    emline_sew_mask_hdel_4102 integer,
    emline_sew_mask_hgam_4341 integer,
    emline_sew_mask_heii_4687 integer,
    emline_sew_mask_hei_5877 integer,
    emline_sew_mask_siii_8831 integer,
    emline_sew_mask_siii_9071 integer,
    emline_sew_mask_siii_9533 integer,
    emline_gflux_oiid_3728 real,
    emline_gflux_hb_4862 real,
    emline_gflux_oiii_4960 real,
    emline_gflux_oiii_5008 double precision,
    emline_gflux_oi_6302 real,
    emline_gflux_oi_6365 real,
    emline_gflux_nii_6549 real,
    emline_gflux_ha_6564 double precision,
    emline_gflux_nii_6585 double precision,
    emline_gflux_sii_6718 real,
    emline_gflux_sii_6732 double precision,
    emline_gflux_oii_3727 double precision,
    emline_gflux_oii_3729 real,
    emline_gflux_heps_3971 real,
    emline_gflux_hdel_4102 real,
    emline_gflux_hgam_4341 real,
    emline_gflux_heii_4687 real,
    emline_gflux_hei_5877 real,
    emline_gflux_siii_8831 real,
    emline_gflux_siii_9071 real,
    emline_gflux_siii_9533 real,
    emline_gflux_ivar_oiid_3728 double precision,
    emline_gflux_ivar_hb_4862 double precision,
    emline_gflux_ivar_oiii_4960 double precision,
    emline_gflux_ivar_oiii_5008 double precision,
    emline_gflux_ivar_oi_6302 double precision,
    emline_gflux_ivar_oi_6365 double precision,
    emline_gflux_ivar_nii_6549 double precision,
    emline_gflux_ivar_ha_6564 double precision,
    emline_gflux_ivar_nii_6585 double precision,
    emline_gflux_ivar_sii_6718 double precision,
    emline_gflux_ivar_sii_6732 double precision,
    emline_gflux_ivar_oii_3727 double precision,
    emline_gflux_ivar_oii_3729 double precision,
    emline_gflux_ivar_heps_3971 double precision,
    emline_gflux_ivar_hdel_4102 double precision,
    emline_gflux_ivar_hgam_4341 double precision,
    emline_gflux_ivar_heii_4687 double precision,
    emline_gflux_ivar_hei_5877 double precision,
    emline_gflux_ivar_siii_8831 double precision,
    emline_gflux_ivar_siii_9071 double precision,
    emline_gflux_ivar_siii_9533 double precision,
    emline_gflux_mask_oiid_3728 integer,
    emline_gflux_mask_hb_4862 integer,
    emline_gflux_mask_oiii_4960 integer,
    emline_gflux_mask_oiii_5008 integer,
    emline_gflux_mask_oi_6302 integer,
    emline_gflux_mask_oi_6365 integer,
    emline_gflux_mask_nii_6549 integer,
    emline_gflux_mask_ha_6564 integer,
    emline_gflux_mask_nii_6585 integer,
    emline_gflux_mask_sii_6718 integer,
    emline_gflux_mask_sii_6732 integer,
    emline_gflux_mask_oii_3727 integer,
    emline_gflux_mask_oii_3729 integer,
    emline_gflux_mask_heps_3971 integer,
    emline_gflux_mask_hdel_4102 integer,
    emline_gflux_mask_hgam_4341 integer,
    emline_gflux_mask_heii_4687 integer,
    emline_gflux_mask_hei_5877 integer,
    emline_gflux_mask_siii_8831 integer,
    emline_gflux_mask_siii_9071 integer,
    emline_gflux_mask_siii_9533 integer,
    emline_gvel_oiid_3728 real,
    emline_gvel_hb_4862 real,
    emline_gvel_oiii_4960 real,
    emline_gvel_oiii_5008 real,
    emline_gvel_oi_6302 real,
    emline_gvel_oi_6365 real,
    emline_gvel_nii_6549 real,
    emline_gvel_ha_6564 real,
    emline_gvel_nii_6585 real,
    emline_gvel_sii_6718 real,
    emline_gvel_sii_6732 real,
    emline_gvel_oii_3727 real,
    emline_gvel_oii_3729 real,
    emline_gvel_heps_3971 real,
    emline_gvel_hdel_4102 real,
    emline_gvel_hgam_4341 real,
    emline_gvel_heii_4687 real,
    emline_gvel_hei_5877 real,
    emline_gvel_siii_8831 real,
    emline_gvel_siii_9071 real,
    emline_gvel_siii_9533 real,
    emline_gvel_ivar_oiid_3728 double precision,
    emline_gvel_ivar_hb_4862 double precision,
    emline_gvel_ivar_oiii_4960 double precision,
    emline_gvel_ivar_oiii_5008 double precision,
    emline_gvel_ivar_oi_6302 double precision,
    emline_gvel_ivar_oi_6365 double precision,
    emline_gvel_ivar_nii_6549 double precision,
    emline_gvel_ivar_ha_6564 double precision,
    emline_gvel_ivar_nii_6585 double precision,
    emline_gvel_ivar_sii_6718 double precision,
    emline_gvel_ivar_sii_6732 double precision,
    emline_gvel_ivar_oii_3727 double precision,
    emline_gvel_ivar_oii_3729 double precision,
    emline_gvel_ivar_heps_3971 double precision,
    emline_gvel_ivar_hdel_4102 double precision,
    emline_gvel_ivar_hgam_4341 double precision,
    emline_gvel_ivar_heii_4687 double precision,
    emline_gvel_ivar_hei_5877 double precision,
    emline_gvel_ivar_siii_8831 double precision,
    emline_gvel_ivar_siii_9071 double precision,
    emline_gvel_ivar_siii_9533 double precision,
    emline_gvel_mask_oiid_3728 integer,
    emline_gvel_mask_hb_4862 integer,
    emline_gvel_mask_oiii_4960 integer,
    emline_gvel_mask_oiii_5008 integer,
    emline_gvel_mask_oi_6302 integer,
    emline_gvel_mask_oi_6365 integer,
    emline_gvel_mask_nii_6549 integer,
    emline_gvel_mask_ha_6564 integer,
    emline_gvel_mask_nii_6585 integer,
    emline_gvel_mask_sii_6718 integer,
    emline_gvel_mask_sii_6732 integer,
    emline_gvel_mask_oii_3727 integer,
    emline_gvel_mask_oii_3729 integer,
    emline_gvel_mask_heps_3971 integer,
    emline_gvel_mask_hdel_4102 integer,
    emline_gvel_mask_hgam_4341 integer,
    emline_gvel_mask_heii_4687 integer,
    emline_gvel_mask_hei_5877 integer,
    emline_gvel_mask_siii_8831 integer,
    emline_gvel_mask_siii_9071 integer,
    emline_gvel_mask_siii_9533 integer,
    emline_gsigma_oiid_3728 real,
    emline_gsigma_hb_4862 real,
    emline_gsigma_oiii_4960 real,
    emline_gsigma_oiii_5008 real,
    emline_gsigma_oi_6302 real,
    emline_gsigma_oi_6365 real,
    emline_gsigma_nii_6549 real,
    emline_gsigma_ha_6564 real,
    emline_gsigma_nii_6585 real,
    emline_gsigma_sii_6718 real,
    emline_gsigma_sii_6732 real,
    emline_gsigma_oii_3727 real,
    emline_gsigma_oii_3729 real,
    emline_gsigma_heps_3971 real,
    emline_gsigma_hdel_4102 real,
    emline_gsigma_hgam_4341 real,
    emline_gsigma_heii_4687 real,
    emline_gsigma_hei_5877 real,
    emline_gsigma_siii_8831 real,
    emline_gsigma_siii_9071 real,
    emline_gsigma_siii_9533 real,
    emline_gsigma_ivar_oiid_3728 double precision,
    emline_gsigma_ivar_hb_4862 double precision,
    emline_gsigma_ivar_oiii_4960 double precision,
    emline_gsigma_ivar_oiii_5008 double precision,
    emline_gsigma_ivar_oi_6302 double precision,
    emline_gsigma_ivar_oi_6365 double precision,
    emline_gsigma_ivar_nii_6549 double precision,
    emline_gsigma_ivar_ha_6564 double precision,
    emline_gsigma_ivar_nii_6585 double precision,
    emline_gsigma_ivar_sii_6718 double precision,
    emline_gsigma_ivar_sii_6732 double precision,
    emline_gsigma_ivar_oii_3727 double precision,
    emline_gsigma_ivar_oii_3729 double precision,
    emline_gsigma_ivar_heps_3971 double precision,
    emline_gsigma_ivar_hdel_4102 double precision,
    emline_gsigma_ivar_hgam_4341 double precision,
    emline_gsigma_ivar_heii_4687 double precision,
    emline_gsigma_ivar_hei_5877 double precision,
    emline_gsigma_ivar_siii_8831 double precision,
    emline_gsigma_ivar_siii_9071 double precision,
    emline_gsigma_ivar_siii_9533 double precision,
    emline_gsigma_mask_oiid_3728 integer,
    emline_gsigma_mask_hb_4862 integer,
    emline_gsigma_mask_oiii_4960 integer,
    emline_gsigma_mask_oiii_5008 integer,
    emline_gsigma_mask_oi_6302 integer,
    emline_gsigma_mask_oi_6365 integer,
    emline_gsigma_mask_nii_6549 integer,
    emline_gsigma_mask_ha_6564 integer,
    emline_gsigma_mask_nii_6585 integer,
    emline_gsigma_mask_sii_6718 integer,
    emline_gsigma_mask_sii_6732 integer,
    emline_gsigma_mask_oii_3727 integer,
    emline_gsigma_mask_oii_3729 integer,
    emline_gsigma_mask_heps_3971 integer,
    emline_gsigma_mask_hdel_4102 integer,
    emline_gsigma_mask_hgam_4341 integer,
    emline_gsigma_mask_heii_4687 integer,
    emline_gsigma_mask_hei_5877 integer,
    emline_gsigma_mask_siii_8831 integer,
    emline_gsigma_mask_siii_9071 integer,
    emline_gsigma_mask_siii_9533 integer,
    emline_instsigma_oiid_3728 real,
    emline_instsigma_hb_4862 real,
    emline_instsigma_oiii_4960 real,
    emline_instsigma_oiii_5008 real,
    emline_instsigma_oi_6302 real,
    emline_instsigma_oi_6365 real,
    emline_instsigma_nii_6549 real,
    emline_instsigma_ha_6564 real,
    emline_instsigma_nii_6585 real,
    emline_instsigma_sii_6718 real,
    emline_instsigma_sii_6732 real,
    emline_instsigma_oii_3727 real,
    emline_instsigma_oii_3729 real,
    emline_instsigma_heps_3971 real,
    emline_instsigma_hdel_4102 real,
    emline_instsigma_hgam_4341 real,
    emline_instsigma_heii_4687 real,
    emline_instsigma_hei_5877 real,
    emline_instsigma_siii_8831 real,
    emline_instsigma_siii_9071 real,
    emline_instsigma_siii_9533 real,
    specindex_d4000 real,
    specindex_dn4000 real,
    specindex_ivar_d4000 double precision,
    specindex_ivar_dn4000 double precision,
    specindex_mask_d4000 integer,
    specindex_mask_dn4000 integer,
    specindex_corr_d4000 real,
    specindex_corr_dn4000 real,
    x integer,
    y integer
)
SERVER cstore_server
OPTIONS (
    compression 'pglz',
    filename '/xfs/postgres_db/cstore/c5_cstore.cstore'
);


ALTER FOREIGN TABLE c5_cstore OWNER TO manga;

--
-- Name: c5_cstore_ssd; Type: FOREIGN TABLE; Schema: mangadapdb; Owner: swerner
--

CREATE FOREIGN TABLE c5_cstore_ssd (
    pk bigint,
    file_pk integer,
    spaxel_index integer,
    binid_pk integer,
    spx_skycoo_on_sky_x real,
    spx_skycoo_on_sky_y real,
    spx_ellcoo_elliptical_radius real,
    spx_ellcoo_elliptical_azimuth real,
    spx_mflux real,
    spx_mflux_ivar double precision,
    spx_snr real,
    binid integer,
    bin_lwskycoo_lum_weighted_on_sky_x real,
    bin_lwskycoo_lum_weighted_on_sky_y real,
    bin_lwellcoo_lum_weighted_elliptical_radius real,
    bin_lwellcoo_lum_weighted_elliptical_azimuth real,
    bin_area real,
    bin_farea real,
    bin_mflux real,
    bin_mflux_ivar double precision,
    bin_mflux_mask integer,
    bin_snr real,
    stellar_vel real,
    stellar_vel_ivar double precision,
    stellar_vel_mask integer,
    stellar_sigma real,
    stellar_sigma_ivar double precision,
    stellar_sigma_mask integer,
    stellar_sigmacorr real,
    stellar_cont_fresid_68th_percentile real,
    stellar_cont_fresid_99th_percentile real,
    stellar_cont_rchi2 real,
    emline_sflux_oiid_3728 real,
    emline_sflux_hb_4862 real,
    emline_sflux_oiii_4960 real,
    emline_sflux_oiii_5008 real,
    emline_sflux_oi_6302 real,
    emline_sflux_oi_6365 real,
    emline_sflux_nii_6549 real,
    emline_sflux_ha_6564 real,
    emline_sflux_nii_6585 real,
    emline_sflux_sii_6718 real,
    emline_sflux_sii_6732 real,
    emline_sflux_oii_3727 real,
    emline_sflux_oii_3729 real,
    emline_sflux_heps_3971 real,
    emline_sflux_hdel_4102 real,
    emline_sflux_hgam_4341 real,
    emline_sflux_heii_4687 real,
    emline_sflux_hei_5877 real,
    emline_sflux_siii_8831 real,
    emline_sflux_siii_9071 real,
    emline_sflux_siii_9533 real,
    emline_sflux_ivar_oiid_3728 double precision,
    emline_sflux_ivar_hb_4862 double precision,
    emline_sflux_ivar_oiii_4960 double precision,
    emline_sflux_ivar_oiii_5008 double precision,
    emline_sflux_ivar_oi_6302 double precision,
    emline_sflux_ivar_oi_6365 double precision,
    emline_sflux_ivar_nii_6549 double precision,
    emline_sflux_ivar_ha_6564 double precision,
    emline_sflux_ivar_nii_6585 double precision,
    emline_sflux_ivar_sii_6718 double precision,
    emline_sflux_ivar_sii_6732 double precision,
    emline_sflux_ivar_oii_3727 double precision,
    emline_sflux_ivar_oii_3729 double precision,
    emline_sflux_ivar_heps_3971 double precision,
    emline_sflux_ivar_hdel_4102 double precision,
    emline_sflux_ivar_hgam_4341 double precision,
    emline_sflux_ivar_heii_4687 double precision,
    emline_sflux_ivar_hei_5877 double precision,
    emline_sflux_ivar_siii_8831 double precision,
    emline_sflux_ivar_siii_9071 double precision,
    emline_sflux_ivar_siii_9533 double precision,
    emline_sflux_mask_oiid_3728 integer,
    emline_sflux_mask_hb_4862 integer,
    emline_sflux_mask_oiii_4960 integer,
    emline_sflux_mask_oiii_5008 integer,
    emline_sflux_mask_oi_6302 integer,
    emline_sflux_mask_oi_6365 integer,
    emline_sflux_mask_nii_6549 integer,
    emline_sflux_mask_ha_6564 integer,
    emline_sflux_mask_nii_6585 integer,
    emline_sflux_mask_sii_6718 integer,
    emline_sflux_mask_sii_6732 integer,
    emline_sflux_mask_oii_3727 integer,
    emline_sflux_mask_oii_3729 integer,
    emline_sflux_mask_heps_3971 integer,
    emline_sflux_mask_hdel_4102 integer,
    emline_sflux_mask_hgam_4341 integer,
    emline_sflux_mask_heii_4687 integer,
    emline_sflux_mask_hei_5877 integer,
    emline_sflux_mask_siii_8831 integer,
    emline_sflux_mask_siii_9071 integer,
    emline_sflux_mask_siii_9533 integer,
    emline_sew_oiid_3728 double precision,
    emline_sew_hb_4862 double precision,
    emline_sew_oiii_4960 double precision,
    emline_sew_oiii_5008 double precision,
    emline_sew_oi_6302 double precision,
    emline_sew_oi_6365 double precision,
    emline_sew_nii_6549 double precision,
    emline_sew_ha_6564 double precision,
    emline_sew_nii_6585 double precision,
    emline_sew_sii_6718 double precision,
    emline_sew_sii_6732 double precision,
    emline_sew_oii_3727 double precision,
    emline_sew_oii_3729 double precision,
    emline_sew_heps_3971 double precision,
    emline_sew_hdel_4102 double precision,
    emline_sew_hgam_4341 double precision,
    emline_sew_heii_4687 double precision,
    emline_sew_hei_5877 double precision,
    emline_sew_siii_8831 double precision,
    emline_sew_siii_9071 double precision,
    emline_sew_siii_9533 double precision,
    emline_sew_ivar_oiid_3728 double precision,
    emline_sew_ivar_hb_4862 double precision,
    emline_sew_ivar_oiii_4960 double precision,
    emline_sew_ivar_oiii_5008 double precision,
    emline_sew_ivar_oi_6302 double precision,
    emline_sew_ivar_oi_6365 double precision,
    emline_sew_ivar_nii_6549 double precision,
    emline_sew_ivar_ha_6564 double precision,
    emline_sew_ivar_nii_6585 double precision,
    emline_sew_ivar_sii_6718 double precision,
    emline_sew_ivar_sii_6732 double precision,
    emline_sew_ivar_oii_3727 double precision,
    emline_sew_ivar_oii_3729 double precision,
    emline_sew_ivar_heps_3971 double precision,
    emline_sew_ivar_hdel_4102 double precision,
    emline_sew_ivar_hgam_4341 double precision,
    emline_sew_ivar_heii_4687 double precision,
    emline_sew_ivar_hei_5877 double precision,
    emline_sew_ivar_siii_8831 double precision,
    emline_sew_ivar_siii_9071 double precision,
    emline_sew_ivar_siii_9533 double precision,
    emline_sew_mask_oiid_3728 integer,
    emline_sew_mask_hb_4862 integer,
    emline_sew_mask_oiii_4960 integer,
    emline_sew_mask_oiii_5008 integer,
    emline_sew_mask_oi_6302 integer,
    emline_sew_mask_oi_6365 integer,
    emline_sew_mask_nii_6549 integer,
    emline_sew_mask_ha_6564 integer,
    emline_sew_mask_nii_6585 integer,
    emline_sew_mask_sii_6718 integer,
    emline_sew_mask_sii_6732 integer,
    emline_sew_mask_oii_3727 integer,
    emline_sew_mask_oii_3729 integer,
    emline_sew_mask_heps_3971 integer,
    emline_sew_mask_hdel_4102 integer,
    emline_sew_mask_hgam_4341 integer,
    emline_sew_mask_heii_4687 integer,
    emline_sew_mask_hei_5877 integer,
    emline_sew_mask_siii_8831 integer,
    emline_sew_mask_siii_9071 integer,
    emline_sew_mask_siii_9533 integer,
    emline_gflux_oiid_3728 real,
    emline_gflux_hb_4862 real,
    emline_gflux_oiii_4960 real,
    emline_gflux_oiii_5008 double precision,
    emline_gflux_oi_6302 real,
    emline_gflux_oi_6365 real,
    emline_gflux_nii_6549 real,
    emline_gflux_ha_6564 double precision,
    emline_gflux_nii_6585 double precision,
    emline_gflux_sii_6718 real,
    emline_gflux_sii_6732 double precision,
    emline_gflux_oii_3727 double precision,
    emline_gflux_oii_3729 real,
    emline_gflux_heps_3971 real,
    emline_gflux_hdel_4102 real,
    emline_gflux_hgam_4341 real,
    emline_gflux_heii_4687 real,
    emline_gflux_hei_5877 real,
    emline_gflux_siii_8831 real,
    emline_gflux_siii_9071 real,
    emline_gflux_siii_9533 real,
    emline_gflux_ivar_oiid_3728 double precision,
    emline_gflux_ivar_hb_4862 double precision,
    emline_gflux_ivar_oiii_4960 double precision,
    emline_gflux_ivar_oiii_5008 double precision,
    emline_gflux_ivar_oi_6302 double precision,
    emline_gflux_ivar_oi_6365 double precision,
    emline_gflux_ivar_nii_6549 double precision,
    emline_gflux_ivar_ha_6564 double precision,
    emline_gflux_ivar_nii_6585 double precision,
    emline_gflux_ivar_sii_6718 double precision,
    emline_gflux_ivar_sii_6732 double precision,
    emline_gflux_ivar_oii_3727 double precision,
    emline_gflux_ivar_oii_3729 double precision,
    emline_gflux_ivar_heps_3971 double precision,
    emline_gflux_ivar_hdel_4102 double precision,
    emline_gflux_ivar_hgam_4341 double precision,
    emline_gflux_ivar_heii_4687 double precision,
    emline_gflux_ivar_hei_5877 double precision,
    emline_gflux_ivar_siii_8831 double precision,
    emline_gflux_ivar_siii_9071 double precision,
    emline_gflux_ivar_siii_9533 double precision,
    emline_gflux_mask_oiid_3728 integer,
    emline_gflux_mask_hb_4862 integer,
    emline_gflux_mask_oiii_4960 integer,
    emline_gflux_mask_oiii_5008 integer,
    emline_gflux_mask_oi_6302 integer,
    emline_gflux_mask_oi_6365 integer,
    emline_gflux_mask_nii_6549 integer,
    emline_gflux_mask_ha_6564 integer,
    emline_gflux_mask_nii_6585 integer,
    emline_gflux_mask_sii_6718 integer,
    emline_gflux_mask_sii_6732 integer,
    emline_gflux_mask_oii_3727 integer,
    emline_gflux_mask_oii_3729 integer,
    emline_gflux_mask_heps_3971 integer,
    emline_gflux_mask_hdel_4102 integer,
    emline_gflux_mask_hgam_4341 integer,
    emline_gflux_mask_heii_4687 integer,
    emline_gflux_mask_hei_5877 integer,
    emline_gflux_mask_siii_8831 integer,
    emline_gflux_mask_siii_9071 integer,
    emline_gflux_mask_siii_9533 integer,
    emline_gvel_oiid_3728 real,
    emline_gvel_hb_4862 real,
    emline_gvel_oiii_4960 real,
    emline_gvel_oiii_5008 real,
    emline_gvel_oi_6302 real,
    emline_gvel_oi_6365 real,
    emline_gvel_nii_6549 real,
    emline_gvel_ha_6564 real,
    emline_gvel_nii_6585 real,
    emline_gvel_sii_6718 real,
    emline_gvel_sii_6732 real,
    emline_gvel_oii_3727 real,
    emline_gvel_oii_3729 real,
    emline_gvel_heps_3971 real,
    emline_gvel_hdel_4102 real,
    emline_gvel_hgam_4341 real,
    emline_gvel_heii_4687 real,
    emline_gvel_hei_5877 real,
    emline_gvel_siii_8831 real,
    emline_gvel_siii_9071 real,
    emline_gvel_siii_9533 real,
    emline_gvel_ivar_oiid_3728 double precision,
    emline_gvel_ivar_hb_4862 double precision,
    emline_gvel_ivar_oiii_4960 double precision,
    emline_gvel_ivar_oiii_5008 double precision,
    emline_gvel_ivar_oi_6302 double precision,
    emline_gvel_ivar_oi_6365 double precision,
    emline_gvel_ivar_nii_6549 double precision,
    emline_gvel_ivar_ha_6564 double precision,
    emline_gvel_ivar_nii_6585 double precision,
    emline_gvel_ivar_sii_6718 double precision,
    emline_gvel_ivar_sii_6732 double precision,
    emline_gvel_ivar_oii_3727 double precision,
    emline_gvel_ivar_oii_3729 double precision,
    emline_gvel_ivar_heps_3971 double precision,
    emline_gvel_ivar_hdel_4102 double precision,
    emline_gvel_ivar_hgam_4341 double precision,
    emline_gvel_ivar_heii_4687 double precision,
    emline_gvel_ivar_hei_5877 double precision,
    emline_gvel_ivar_siii_8831 double precision,
    emline_gvel_ivar_siii_9071 double precision,
    emline_gvel_ivar_siii_9533 double precision,
    emline_gvel_mask_oiid_3728 integer,
    emline_gvel_mask_hb_4862 integer,
    emline_gvel_mask_oiii_4960 integer,
    emline_gvel_mask_oiii_5008 integer,
    emline_gvel_mask_oi_6302 integer,
    emline_gvel_mask_oi_6365 integer,
    emline_gvel_mask_nii_6549 integer,
    emline_gvel_mask_ha_6564 integer,
    emline_gvel_mask_nii_6585 integer,
    emline_gvel_mask_sii_6718 integer,
    emline_gvel_mask_sii_6732 integer,
    emline_gvel_mask_oii_3727 integer,
    emline_gvel_mask_oii_3729 integer,
    emline_gvel_mask_heps_3971 integer,
    emline_gvel_mask_hdel_4102 integer,
    emline_gvel_mask_hgam_4341 integer,
    emline_gvel_mask_heii_4687 integer,
    emline_gvel_mask_hei_5877 integer,
    emline_gvel_mask_siii_8831 integer,
    emline_gvel_mask_siii_9071 integer,
    emline_gvel_mask_siii_9533 integer,
    emline_gsigma_oiid_3728 real,
    emline_gsigma_hb_4862 real,
    emline_gsigma_oiii_4960 real,
    emline_gsigma_oiii_5008 real,
    emline_gsigma_oi_6302 real,
    emline_gsigma_oi_6365 real,
    emline_gsigma_nii_6549 real,
    emline_gsigma_ha_6564 real,
    emline_gsigma_nii_6585 real,
    emline_gsigma_sii_6718 real,
    emline_gsigma_sii_6732 real,
    emline_gsigma_oii_3727 real,
    emline_gsigma_oii_3729 real,
    emline_gsigma_heps_3971 real,
    emline_gsigma_hdel_4102 real,
    emline_gsigma_hgam_4341 real,
    emline_gsigma_heii_4687 real,
    emline_gsigma_hei_5877 real,
    emline_gsigma_siii_8831 real,
    emline_gsigma_siii_9071 real,
    emline_gsigma_siii_9533 real,
    emline_gsigma_ivar_oiid_3728 double precision,
    emline_gsigma_ivar_hb_4862 double precision,
    emline_gsigma_ivar_oiii_4960 double precision,
    emline_gsigma_ivar_oiii_5008 double precision,
    emline_gsigma_ivar_oi_6302 double precision,
    emline_gsigma_ivar_oi_6365 double precision,
    emline_gsigma_ivar_nii_6549 double precision,
    emline_gsigma_ivar_ha_6564 double precision,
    emline_gsigma_ivar_nii_6585 double precision,
    emline_gsigma_ivar_sii_6718 double precision,
    emline_gsigma_ivar_sii_6732 double precision,
    emline_gsigma_ivar_oii_3727 double precision,
    emline_gsigma_ivar_oii_3729 double precision,
    emline_gsigma_ivar_heps_3971 double precision,
    emline_gsigma_ivar_hdel_4102 double precision,
    emline_gsigma_ivar_hgam_4341 double precision,
    emline_gsigma_ivar_heii_4687 double precision,
    emline_gsigma_ivar_hei_5877 double precision,
    emline_gsigma_ivar_siii_8831 double precision,
    emline_gsigma_ivar_siii_9071 double precision,
    emline_gsigma_ivar_siii_9533 double precision,
    emline_gsigma_mask_oiid_3728 integer,
    emline_gsigma_mask_hb_4862 integer,
    emline_gsigma_mask_oiii_4960 integer,
    emline_gsigma_mask_oiii_5008 integer,
    emline_gsigma_mask_oi_6302 integer,
    emline_gsigma_mask_oi_6365 integer,
    emline_gsigma_mask_nii_6549 integer,
    emline_gsigma_mask_ha_6564 integer,
    emline_gsigma_mask_nii_6585 integer,
    emline_gsigma_mask_sii_6718 integer,
    emline_gsigma_mask_sii_6732 integer,
    emline_gsigma_mask_oii_3727 integer,
    emline_gsigma_mask_oii_3729 integer,
    emline_gsigma_mask_heps_3971 integer,
    emline_gsigma_mask_hdel_4102 integer,
    emline_gsigma_mask_hgam_4341 integer,
    emline_gsigma_mask_heii_4687 integer,
    emline_gsigma_mask_hei_5877 integer,
    emline_gsigma_mask_siii_8831 integer,
    emline_gsigma_mask_siii_9071 integer,
    emline_gsigma_mask_siii_9533 integer,
    emline_instsigma_oiid_3728 real,
    emline_instsigma_hb_4862 real,
    emline_instsigma_oiii_4960 real,
    emline_instsigma_oiii_5008 real,
    emline_instsigma_oi_6302 real,
    emline_instsigma_oi_6365 real,
    emline_instsigma_nii_6549 real,
    emline_instsigma_ha_6564 real,
    emline_instsigma_nii_6585 real,
    emline_instsigma_sii_6718 real,
    emline_instsigma_sii_6732 real,
    emline_instsigma_oii_3727 real,
    emline_instsigma_oii_3729 real,
    emline_instsigma_heps_3971 real,
    emline_instsigma_hdel_4102 real,
    emline_instsigma_hgam_4341 real,
    emline_instsigma_heii_4687 real,
    emline_instsigma_hei_5877 real,
    emline_instsigma_siii_8831 real,
    emline_instsigma_siii_9071 real,
    emline_instsigma_siii_9533 real,
    specindex_d4000 real,
    specindex_dn4000 real,
    specindex_ivar_d4000 double precision,
    specindex_ivar_dn4000 double precision,
    specindex_mask_d4000 integer,
    specindex_mask_dn4000 integer,
    specindex_corr_d4000 real,
    specindex_corr_dn4000 real,
    x integer,
    y integer
)
SERVER cstore_server
OPTIONS (
    compression 'pglz',
    filename '/ssd/postgres_db/manga/c5_ssd_cstore.cstore'
);


ALTER FOREIGN TABLE c5_cstore_ssd OWNER TO swerner;

--
-- Name: c5_cx; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE c5_cx (
    pk bigint,
    file_pk integer,
    spaxel_index integer,
    binid_pk integer,
    spx_skycoo_on_sky_x real,
    spx_skycoo_on_sky_y real,
    spx_ellcoo_elliptical_radius real,
    spx_ellcoo_elliptical_azimuth real,
    spx_mflux real,
    spx_mflux_ivar double precision,
    spx_snr real,
    binid integer,
    bin_lwskycoo_lum_weighted_on_sky_x real,
    bin_lwskycoo_lum_weighted_on_sky_y real,
    bin_lwellcoo_lum_weighted_elliptical_radius real,
    bin_lwellcoo_lum_weighted_elliptical_azimuth real,
    bin_area real,
    bin_farea real,
    bin_mflux real,
    bin_mflux_ivar double precision,
    bin_mflux_mask integer,
    bin_snr real,
    stellar_vel real,
    stellar_vel_ivar double precision,
    stellar_vel_mask integer,
    stellar_sigma real,
    stellar_sigma_ivar double precision,
    stellar_sigma_mask integer,
    stellar_sigmacorr real,
    stellar_cont_fresid_68th_percentile real,
    stellar_cont_fresid_99th_percentile real,
    stellar_cont_rchi2 real,
    emline_sflux_oiid_3728 real,
    emline_sflux_hb_4862 real,
    emline_sflux_oiii_4960 real,
    emline_sflux_oiii_5008 real,
    emline_sflux_oi_6302 real,
    emline_sflux_oi_6365 real,
    emline_sflux_nii_6549 real,
    emline_sflux_ha_6564 real,
    emline_sflux_nii_6585 real,
    emline_sflux_sii_6718 real,
    emline_sflux_sii_6732 real,
    emline_sflux_oii_3727 real,
    emline_sflux_oii_3729 real,
    emline_sflux_heps_3971 real,
    emline_sflux_hdel_4102 real,
    emline_sflux_hgam_4341 real,
    emline_sflux_heii_4687 real,
    emline_sflux_hei_5877 real,
    emline_sflux_siii_8831 real,
    emline_sflux_siii_9071 real,
    emline_sflux_siii_9533 real,
    emline_sflux_ivar_oiid_3728 double precision,
    emline_sflux_ivar_hb_4862 double precision,
    emline_sflux_ivar_oiii_4960 double precision,
    emline_sflux_ivar_oiii_5008 double precision,
    emline_sflux_ivar_oi_6302 double precision,
    emline_sflux_ivar_oi_6365 double precision,
    emline_sflux_ivar_nii_6549 double precision,
    emline_sflux_ivar_ha_6564 double precision,
    emline_sflux_ivar_nii_6585 double precision,
    emline_sflux_ivar_sii_6718 double precision,
    emline_sflux_ivar_sii_6732 double precision,
    emline_sflux_ivar_oii_3727 double precision,
    emline_sflux_ivar_oii_3729 double precision,
    emline_sflux_ivar_heps_3971 double precision,
    emline_sflux_ivar_hdel_4102 double precision,
    emline_sflux_ivar_hgam_4341 double precision,
    emline_sflux_ivar_heii_4687 double precision,
    emline_sflux_ivar_hei_5877 double precision,
    emline_sflux_ivar_siii_8831 double precision,
    emline_sflux_ivar_siii_9071 double precision,
    emline_sflux_ivar_siii_9533 double precision,
    emline_sflux_mask_oiid_3728 integer,
    emline_sflux_mask_hb_4862 integer,
    emline_sflux_mask_oiii_4960 integer,
    emline_sflux_mask_oiii_5008 integer,
    emline_sflux_mask_oi_6302 integer,
    emline_sflux_mask_oi_6365 integer,
    emline_sflux_mask_nii_6549 integer,
    emline_sflux_mask_ha_6564 integer,
    emline_sflux_mask_nii_6585 integer,
    emline_sflux_mask_sii_6718 integer,
    emline_sflux_mask_sii_6732 integer,
    emline_sflux_mask_oii_3727 integer,
    emline_sflux_mask_oii_3729 integer,
    emline_sflux_mask_heps_3971 integer,
    emline_sflux_mask_hdel_4102 integer,
    emline_sflux_mask_hgam_4341 integer,
    emline_sflux_mask_heii_4687 integer,
    emline_sflux_mask_hei_5877 integer,
    emline_sflux_mask_siii_8831 integer,
    emline_sflux_mask_siii_9071 integer,
    emline_sflux_mask_siii_9533 integer,
    emline_sew_oiid_3728 double precision,
    emline_sew_hb_4862 double precision,
    emline_sew_oiii_4960 double precision,
    emline_sew_oiii_5008 double precision,
    emline_sew_oi_6302 double precision,
    emline_sew_oi_6365 double precision,
    emline_sew_nii_6549 double precision,
    emline_sew_ha_6564 double precision,
    emline_sew_nii_6585 double precision,
    emline_sew_sii_6718 double precision,
    emline_sew_sii_6732 double precision,
    emline_sew_oii_3727 double precision,
    emline_sew_oii_3729 double precision,
    emline_sew_heps_3971 double precision,
    emline_sew_hdel_4102 double precision,
    emline_sew_hgam_4341 double precision,
    emline_sew_heii_4687 double precision,
    emline_sew_hei_5877 double precision,
    emline_sew_siii_8831 double precision,
    emline_sew_siii_9071 double precision,
    emline_sew_siii_9533 double precision,
    emline_sew_ivar_oiid_3728 double precision,
    emline_sew_ivar_hb_4862 double precision,
    emline_sew_ivar_oiii_4960 double precision,
    emline_sew_ivar_oiii_5008 double precision,
    emline_sew_ivar_oi_6302 double precision,
    emline_sew_ivar_oi_6365 double precision,
    emline_sew_ivar_nii_6549 double precision,
    emline_sew_ivar_ha_6564 double precision,
    emline_sew_ivar_nii_6585 double precision,
    emline_sew_ivar_sii_6718 double precision,
    emline_sew_ivar_sii_6732 double precision,
    emline_sew_ivar_oii_3727 double precision,
    emline_sew_ivar_oii_3729 double precision,
    emline_sew_ivar_heps_3971 double precision,
    emline_sew_ivar_hdel_4102 double precision,
    emline_sew_ivar_hgam_4341 double precision,
    emline_sew_ivar_heii_4687 double precision,
    emline_sew_ivar_hei_5877 double precision,
    emline_sew_ivar_siii_8831 double precision,
    emline_sew_ivar_siii_9071 double precision,
    emline_sew_ivar_siii_9533 double precision,
    emline_sew_mask_oiid_3728 integer,
    emline_sew_mask_hb_4862 integer,
    emline_sew_mask_oiii_4960 integer,
    emline_sew_mask_oiii_5008 integer,
    emline_sew_mask_oi_6302 integer,
    emline_sew_mask_oi_6365 integer,
    emline_sew_mask_nii_6549 integer,
    emline_sew_mask_ha_6564 integer,
    emline_sew_mask_nii_6585 integer,
    emline_sew_mask_sii_6718 integer,
    emline_sew_mask_sii_6732 integer,
    emline_sew_mask_oii_3727 integer,
    emline_sew_mask_oii_3729 integer,
    emline_sew_mask_heps_3971 integer,
    emline_sew_mask_hdel_4102 integer,
    emline_sew_mask_hgam_4341 integer,
    emline_sew_mask_heii_4687 integer,
    emline_sew_mask_hei_5877 integer,
    emline_sew_mask_siii_8831 integer,
    emline_sew_mask_siii_9071 integer,
    emline_sew_mask_siii_9533 integer,
    emline_gflux_oiid_3728 real,
    emline_gflux_hb_4862 real,
    emline_gflux_oiii_4960 real,
    emline_gflux_oiii_5008 double precision,
    emline_gflux_oi_6302 real,
    emline_gflux_oi_6365 real,
    emline_gflux_nii_6549 real,
    emline_gflux_ha_6564 double precision,
    emline_gflux_nii_6585 double precision,
    emline_gflux_sii_6718 real,
    emline_gflux_sii_6732 double precision,
    emline_gflux_oii_3727 double precision,
    emline_gflux_oii_3729 real,
    emline_gflux_heps_3971 real,
    emline_gflux_hdel_4102 real,
    emline_gflux_hgam_4341 real,
    emline_gflux_heii_4687 real,
    emline_gflux_hei_5877 real,
    emline_gflux_siii_8831 real,
    emline_gflux_siii_9071 real,
    emline_gflux_siii_9533 real,
    emline_gflux_ivar_oiid_3728 double precision,
    emline_gflux_ivar_hb_4862 double precision,
    emline_gflux_ivar_oiii_4960 double precision,
    emline_gflux_ivar_oiii_5008 double precision,
    emline_gflux_ivar_oi_6302 double precision,
    emline_gflux_ivar_oi_6365 double precision,
    emline_gflux_ivar_nii_6549 double precision,
    emline_gflux_ivar_ha_6564 double precision,
    emline_gflux_ivar_nii_6585 double precision,
    emline_gflux_ivar_sii_6718 double precision,
    emline_gflux_ivar_sii_6732 double precision,
    emline_gflux_ivar_oii_3727 double precision,
    emline_gflux_ivar_oii_3729 double precision,
    emline_gflux_ivar_heps_3971 double precision,
    emline_gflux_ivar_hdel_4102 double precision,
    emline_gflux_ivar_hgam_4341 double precision,
    emline_gflux_ivar_heii_4687 double precision,
    emline_gflux_ivar_hei_5877 double precision,
    emline_gflux_ivar_siii_8831 double precision,
    emline_gflux_ivar_siii_9071 double precision,
    emline_gflux_ivar_siii_9533 double precision,
    emline_gflux_mask_oiid_3728 integer,
    emline_gflux_mask_hb_4862 integer,
    emline_gflux_mask_oiii_4960 integer,
    emline_gflux_mask_oiii_5008 integer,
    emline_gflux_mask_oi_6302 integer,
    emline_gflux_mask_oi_6365 integer,
    emline_gflux_mask_nii_6549 integer,
    emline_gflux_mask_ha_6564 integer,
    emline_gflux_mask_nii_6585 integer,
    emline_gflux_mask_sii_6718 integer,
    emline_gflux_mask_sii_6732 integer,
    emline_gflux_mask_oii_3727 integer,
    emline_gflux_mask_oii_3729 integer,
    emline_gflux_mask_heps_3971 integer,
    emline_gflux_mask_hdel_4102 integer,
    emline_gflux_mask_hgam_4341 integer,
    emline_gflux_mask_heii_4687 integer,
    emline_gflux_mask_hei_5877 integer,
    emline_gflux_mask_siii_8831 integer,
    emline_gflux_mask_siii_9071 integer,
    emline_gflux_mask_siii_9533 integer,
    emline_gvel_oiid_3728 real,
    emline_gvel_hb_4862 real,
    emline_gvel_oiii_4960 real,
    emline_gvel_oiii_5008 real,
    emline_gvel_oi_6302 real,
    emline_gvel_oi_6365 real,
    emline_gvel_nii_6549 real,
    emline_gvel_ha_6564 real,
    emline_gvel_nii_6585 real,
    emline_gvel_sii_6718 real,
    emline_gvel_sii_6732 real,
    emline_gvel_oii_3727 real,
    emline_gvel_oii_3729 real,
    emline_gvel_heps_3971 real,
    emline_gvel_hdel_4102 real,
    emline_gvel_hgam_4341 real,
    emline_gvel_heii_4687 real,
    emline_gvel_hei_5877 real,
    emline_gvel_siii_8831 real,
    emline_gvel_siii_9071 real,
    emline_gvel_siii_9533 real,
    emline_gvel_ivar_oiid_3728 double precision,
    emline_gvel_ivar_hb_4862 double precision,
    emline_gvel_ivar_oiii_4960 double precision,
    emline_gvel_ivar_oiii_5008 double precision,
    emline_gvel_ivar_oi_6302 double precision,
    emline_gvel_ivar_oi_6365 double precision,
    emline_gvel_ivar_nii_6549 double precision,
    emline_gvel_ivar_ha_6564 double precision,
    emline_gvel_ivar_nii_6585 double precision,
    emline_gvel_ivar_sii_6718 double precision,
    emline_gvel_ivar_sii_6732 double precision,
    emline_gvel_ivar_oii_3727 double precision,
    emline_gvel_ivar_oii_3729 double precision,
    emline_gvel_ivar_heps_3971 double precision,
    emline_gvel_ivar_hdel_4102 double precision,
    emline_gvel_ivar_hgam_4341 double precision,
    emline_gvel_ivar_heii_4687 double precision,
    emline_gvel_ivar_hei_5877 double precision,
    emline_gvel_ivar_siii_8831 double precision,
    emline_gvel_ivar_siii_9071 double precision,
    emline_gvel_ivar_siii_9533 double precision,
    emline_gvel_mask_oiid_3728 integer,
    emline_gvel_mask_hb_4862 integer,
    emline_gvel_mask_oiii_4960 integer,
    emline_gvel_mask_oiii_5008 integer,
    emline_gvel_mask_oi_6302 integer,
    emline_gvel_mask_oi_6365 integer,
    emline_gvel_mask_nii_6549 integer,
    emline_gvel_mask_ha_6564 integer,
    emline_gvel_mask_nii_6585 integer,
    emline_gvel_mask_sii_6718 integer,
    emline_gvel_mask_sii_6732 integer,
    emline_gvel_mask_oii_3727 integer,
    emline_gvel_mask_oii_3729 integer,
    emline_gvel_mask_heps_3971 integer,
    emline_gvel_mask_hdel_4102 integer,
    emline_gvel_mask_hgam_4341 integer,
    emline_gvel_mask_heii_4687 integer,
    emline_gvel_mask_hei_5877 integer,
    emline_gvel_mask_siii_8831 integer,
    emline_gvel_mask_siii_9071 integer,
    emline_gvel_mask_siii_9533 integer,
    emline_gsigma_oiid_3728 real,
    emline_gsigma_hb_4862 real,
    emline_gsigma_oiii_4960 real,
    emline_gsigma_oiii_5008 real,
    emline_gsigma_oi_6302 real,
    emline_gsigma_oi_6365 real,
    emline_gsigma_nii_6549 real,
    emline_gsigma_ha_6564 real,
    emline_gsigma_nii_6585 real,
    emline_gsigma_sii_6718 real,
    emline_gsigma_sii_6732 real,
    emline_gsigma_oii_3727 real,
    emline_gsigma_oii_3729 real,
    emline_gsigma_heps_3971 real,
    emline_gsigma_hdel_4102 real,
    emline_gsigma_hgam_4341 real,
    emline_gsigma_heii_4687 real,
    emline_gsigma_hei_5877 real,
    emline_gsigma_siii_8831 real,
    emline_gsigma_siii_9071 real,
    emline_gsigma_siii_9533 real,
    emline_gsigma_ivar_oiid_3728 double precision,
    emline_gsigma_ivar_hb_4862 double precision,
    emline_gsigma_ivar_oiii_4960 double precision,
    emline_gsigma_ivar_oiii_5008 double precision,
    emline_gsigma_ivar_oi_6302 double precision,
    emline_gsigma_ivar_oi_6365 double precision,
    emline_gsigma_ivar_nii_6549 double precision,
    emline_gsigma_ivar_ha_6564 double precision,
    emline_gsigma_ivar_nii_6585 double precision,
    emline_gsigma_ivar_sii_6718 double precision,
    emline_gsigma_ivar_sii_6732 double precision,
    emline_gsigma_ivar_oii_3727 double precision,
    emline_gsigma_ivar_oii_3729 double precision,
    emline_gsigma_ivar_heps_3971 double precision,
    emline_gsigma_ivar_hdel_4102 double precision,
    emline_gsigma_ivar_hgam_4341 double precision,
    emline_gsigma_ivar_heii_4687 double precision,
    emline_gsigma_ivar_hei_5877 double precision,
    emline_gsigma_ivar_siii_8831 double precision,
    emline_gsigma_ivar_siii_9071 double precision,
    emline_gsigma_ivar_siii_9533 double precision,
    emline_gsigma_mask_oiid_3728 integer,
    emline_gsigma_mask_hb_4862 integer,
    emline_gsigma_mask_oiii_4960 integer,
    emline_gsigma_mask_oiii_5008 integer,
    emline_gsigma_mask_oi_6302 integer,
    emline_gsigma_mask_oi_6365 integer,
    emline_gsigma_mask_nii_6549 integer,
    emline_gsigma_mask_ha_6564 integer,
    emline_gsigma_mask_nii_6585 integer,
    emline_gsigma_mask_sii_6718 integer,
    emline_gsigma_mask_sii_6732 integer,
    emline_gsigma_mask_oii_3727 integer,
    emline_gsigma_mask_oii_3729 integer,
    emline_gsigma_mask_heps_3971 integer,
    emline_gsigma_mask_hdel_4102 integer,
    emline_gsigma_mask_hgam_4341 integer,
    emline_gsigma_mask_heii_4687 integer,
    emline_gsigma_mask_hei_5877 integer,
    emline_gsigma_mask_siii_8831 integer,
    emline_gsigma_mask_siii_9071 integer,
    emline_gsigma_mask_siii_9533 integer,
    emline_instsigma_oiid_3728 real,
    emline_instsigma_hb_4862 real,
    emline_instsigma_oiii_4960 real,
    emline_instsigma_oiii_5008 real,
    emline_instsigma_oi_6302 real,
    emline_instsigma_oi_6365 real,
    emline_instsigma_nii_6549 real,
    emline_instsigma_ha_6564 real,
    emline_instsigma_nii_6585 real,
    emline_instsigma_sii_6718 real,
    emline_instsigma_sii_6732 real,
    emline_instsigma_oii_3727 real,
    emline_instsigma_oii_3729 real,
    emline_instsigma_heps_3971 real,
    emline_instsigma_hdel_4102 real,
    emline_instsigma_hgam_4341 real,
    emline_instsigma_heii_4687 real,
    emline_instsigma_hei_5877 real,
    emline_instsigma_siii_8831 real,
    emline_instsigma_siii_9071 real,
    emline_instsigma_siii_9533 real,
    specindex_d4000 real,
    specindex_dn4000 real,
    specindex_ivar_d4000 double precision,
    specindex_ivar_dn4000 double precision,
    specindex_mask_d4000 integer,
    specindex_mask_dn4000 integer,
    specindex_corr_d4000 real,
    specindex_corr_dn4000 real,
    x integer,
    y integer
);


ALTER TABLE c5_cx OWNER TO manga;

SET default_tablespace = manga_ssd;

--
-- Name: c5_cx_ssd; Type: TABLE; Schema: mangadapdb; Owner: manga; Tablespace: manga_ssd
--

CREATE TABLE c5_cx_ssd (
    pk bigint,
    file_pk integer,
    spaxel_index integer,
    binid_pk integer,
    spx_skycoo_on_sky_x real,
    spx_skycoo_on_sky_y real,
    spx_ellcoo_elliptical_radius real,
    spx_ellcoo_elliptical_azimuth real,
    spx_mflux real,
    spx_mflux_ivar double precision,
    spx_snr real,
    binid integer,
    bin_lwskycoo_lum_weighted_on_sky_x real,
    bin_lwskycoo_lum_weighted_on_sky_y real,
    bin_lwellcoo_lum_weighted_elliptical_radius real,
    bin_lwellcoo_lum_weighted_elliptical_azimuth real,
    bin_area real,
    bin_farea real,
    bin_mflux real,
    bin_mflux_ivar double precision,
    bin_mflux_mask integer,
    bin_snr real,
    stellar_vel real,
    stellar_vel_ivar double precision,
    stellar_vel_mask integer,
    stellar_sigma real,
    stellar_sigma_ivar double precision,
    stellar_sigma_mask integer,
    stellar_sigmacorr real,
    stellar_cont_fresid_68th_percentile real,
    stellar_cont_fresid_99th_percentile real,
    stellar_cont_rchi2 real,
    emline_sflux_oiid_3728 real,
    emline_sflux_hb_4862 real,
    emline_sflux_oiii_4960 real,
    emline_sflux_oiii_5008 real,
    emline_sflux_oi_6302 real,
    emline_sflux_oi_6365 real,
    emline_sflux_nii_6549 real,
    emline_sflux_ha_6564 real,
    emline_sflux_nii_6585 real,
    emline_sflux_sii_6718 real,
    emline_sflux_sii_6732 real,
    emline_sflux_oii_3727 real,
    emline_sflux_oii_3729 real,
    emline_sflux_heps_3971 real,
    emline_sflux_hdel_4102 real,
    emline_sflux_hgam_4341 real,
    emline_sflux_heii_4687 real,
    emline_sflux_hei_5877 real,
    emline_sflux_siii_8831 real,
    emline_sflux_siii_9071 real,
    emline_sflux_siii_9533 real,
    emline_sflux_ivar_oiid_3728 double precision,
    emline_sflux_ivar_hb_4862 double precision,
    emline_sflux_ivar_oiii_4960 double precision,
    emline_sflux_ivar_oiii_5008 double precision,
    emline_sflux_ivar_oi_6302 double precision,
    emline_sflux_ivar_oi_6365 double precision,
    emline_sflux_ivar_nii_6549 double precision,
    emline_sflux_ivar_ha_6564 double precision,
    emline_sflux_ivar_nii_6585 double precision,
    emline_sflux_ivar_sii_6718 double precision,
    emline_sflux_ivar_sii_6732 double precision,
    emline_sflux_ivar_oii_3727 double precision,
    emline_sflux_ivar_oii_3729 double precision,
    emline_sflux_ivar_heps_3971 double precision,
    emline_sflux_ivar_hdel_4102 double precision,
    emline_sflux_ivar_hgam_4341 double precision,
    emline_sflux_ivar_heii_4687 double precision,
    emline_sflux_ivar_hei_5877 double precision,
    emline_sflux_ivar_siii_8831 double precision,
    emline_sflux_ivar_siii_9071 double precision,
    emline_sflux_ivar_siii_9533 double precision,
    emline_sflux_mask_oiid_3728 integer,
    emline_sflux_mask_hb_4862 integer,
    emline_sflux_mask_oiii_4960 integer,
    emline_sflux_mask_oiii_5008 integer,
    emline_sflux_mask_oi_6302 integer,
    emline_sflux_mask_oi_6365 integer,
    emline_sflux_mask_nii_6549 integer,
    emline_sflux_mask_ha_6564 integer,
    emline_sflux_mask_nii_6585 integer,
    emline_sflux_mask_sii_6718 integer,
    emline_sflux_mask_sii_6732 integer,
    emline_sflux_mask_oii_3727 integer,
    emline_sflux_mask_oii_3729 integer,
    emline_sflux_mask_heps_3971 integer,
    emline_sflux_mask_hdel_4102 integer,
    emline_sflux_mask_hgam_4341 integer,
    emline_sflux_mask_heii_4687 integer,
    emline_sflux_mask_hei_5877 integer,
    emline_sflux_mask_siii_8831 integer,
    emline_sflux_mask_siii_9071 integer,
    emline_sflux_mask_siii_9533 integer,
    emline_sew_oiid_3728 double precision,
    emline_sew_hb_4862 double precision,
    emline_sew_oiii_4960 double precision,
    emline_sew_oiii_5008 double precision,
    emline_sew_oi_6302 double precision,
    emline_sew_oi_6365 double precision,
    emline_sew_nii_6549 double precision,
    emline_sew_ha_6564 double precision,
    emline_sew_nii_6585 double precision,
    emline_sew_sii_6718 double precision,
    emline_sew_sii_6732 double precision,
    emline_sew_oii_3727 double precision,
    emline_sew_oii_3729 double precision,
    emline_sew_heps_3971 double precision,
    emline_sew_hdel_4102 double precision,
    emline_sew_hgam_4341 double precision,
    emline_sew_heii_4687 double precision,
    emline_sew_hei_5877 double precision,
    emline_sew_siii_8831 double precision,
    emline_sew_siii_9071 double precision,
    emline_sew_siii_9533 double precision,
    emline_sew_ivar_oiid_3728 double precision,
    emline_sew_ivar_hb_4862 double precision,
    emline_sew_ivar_oiii_4960 double precision,
    emline_sew_ivar_oiii_5008 double precision,
    emline_sew_ivar_oi_6302 double precision,
    emline_sew_ivar_oi_6365 double precision,
    emline_sew_ivar_nii_6549 double precision,
    emline_sew_ivar_ha_6564 double precision,
    emline_sew_ivar_nii_6585 double precision,
    emline_sew_ivar_sii_6718 double precision,
    emline_sew_ivar_sii_6732 double precision,
    emline_sew_ivar_oii_3727 double precision,
    emline_sew_ivar_oii_3729 double precision,
    emline_sew_ivar_heps_3971 double precision,
    emline_sew_ivar_hdel_4102 double precision,
    emline_sew_ivar_hgam_4341 double precision,
    emline_sew_ivar_heii_4687 double precision,
    emline_sew_ivar_hei_5877 double precision,
    emline_sew_ivar_siii_8831 double precision,
    emline_sew_ivar_siii_9071 double precision,
    emline_sew_ivar_siii_9533 double precision,
    emline_sew_mask_oiid_3728 integer,
    emline_sew_mask_hb_4862 integer,
    emline_sew_mask_oiii_4960 integer,
    emline_sew_mask_oiii_5008 integer,
    emline_sew_mask_oi_6302 integer,
    emline_sew_mask_oi_6365 integer,
    emline_sew_mask_nii_6549 integer,
    emline_sew_mask_ha_6564 integer,
    emline_sew_mask_nii_6585 integer,
    emline_sew_mask_sii_6718 integer,
    emline_sew_mask_sii_6732 integer,
    emline_sew_mask_oii_3727 integer,
    emline_sew_mask_oii_3729 integer,
    emline_sew_mask_heps_3971 integer,
    emline_sew_mask_hdel_4102 integer,
    emline_sew_mask_hgam_4341 integer,
    emline_sew_mask_heii_4687 integer,
    emline_sew_mask_hei_5877 integer,
    emline_sew_mask_siii_8831 integer,
    emline_sew_mask_siii_9071 integer,
    emline_sew_mask_siii_9533 integer,
    emline_gflux_oiid_3728 real,
    emline_gflux_hb_4862 real,
    emline_gflux_oiii_4960 real,
    emline_gflux_oiii_5008 double precision,
    emline_gflux_oi_6302 real,
    emline_gflux_oi_6365 real,
    emline_gflux_nii_6549 real,
    emline_gflux_ha_6564 double precision,
    emline_gflux_nii_6585 double precision,
    emline_gflux_sii_6718 real,
    emline_gflux_sii_6732 double precision,
    emline_gflux_oii_3727 double precision,
    emline_gflux_oii_3729 real,
    emline_gflux_heps_3971 real,
    emline_gflux_hdel_4102 real,
    emline_gflux_hgam_4341 real,
    emline_gflux_heii_4687 real,
    emline_gflux_hei_5877 real,
    emline_gflux_siii_8831 real,
    emline_gflux_siii_9071 real,
    emline_gflux_siii_9533 real,
    emline_gflux_ivar_oiid_3728 double precision,
    emline_gflux_ivar_hb_4862 double precision,
    emline_gflux_ivar_oiii_4960 double precision,
    emline_gflux_ivar_oiii_5008 double precision,
    emline_gflux_ivar_oi_6302 double precision,
    emline_gflux_ivar_oi_6365 double precision,
    emline_gflux_ivar_nii_6549 double precision,
    emline_gflux_ivar_ha_6564 double precision,
    emline_gflux_ivar_nii_6585 double precision,
    emline_gflux_ivar_sii_6718 double precision,
    emline_gflux_ivar_sii_6732 double precision,
    emline_gflux_ivar_oii_3727 double precision,
    emline_gflux_ivar_oii_3729 double precision,
    emline_gflux_ivar_heps_3971 double precision,
    emline_gflux_ivar_hdel_4102 double precision,
    emline_gflux_ivar_hgam_4341 double precision,
    emline_gflux_ivar_heii_4687 double precision,
    emline_gflux_ivar_hei_5877 double precision,
    emline_gflux_ivar_siii_8831 double precision,
    emline_gflux_ivar_siii_9071 double precision,
    emline_gflux_ivar_siii_9533 double precision,
    emline_gflux_mask_oiid_3728 integer,
    emline_gflux_mask_hb_4862 integer,
    emline_gflux_mask_oiii_4960 integer,
    emline_gflux_mask_oiii_5008 integer,
    emline_gflux_mask_oi_6302 integer,
    emline_gflux_mask_oi_6365 integer,
    emline_gflux_mask_nii_6549 integer,
    emline_gflux_mask_ha_6564 integer,
    emline_gflux_mask_nii_6585 integer,
    emline_gflux_mask_sii_6718 integer,
    emline_gflux_mask_sii_6732 integer,
    emline_gflux_mask_oii_3727 integer,
    emline_gflux_mask_oii_3729 integer,
    emline_gflux_mask_heps_3971 integer,
    emline_gflux_mask_hdel_4102 integer,
    emline_gflux_mask_hgam_4341 integer,
    emline_gflux_mask_heii_4687 integer,
    emline_gflux_mask_hei_5877 integer,
    emline_gflux_mask_siii_8831 integer,
    emline_gflux_mask_siii_9071 integer,
    emline_gflux_mask_siii_9533 integer,
    emline_gvel_oiid_3728 real,
    emline_gvel_hb_4862 real,
    emline_gvel_oiii_4960 real,
    emline_gvel_oiii_5008 real,
    emline_gvel_oi_6302 real,
    emline_gvel_oi_6365 real,
    emline_gvel_nii_6549 real,
    emline_gvel_ha_6564 real,
    emline_gvel_nii_6585 real,
    emline_gvel_sii_6718 real,
    emline_gvel_sii_6732 real,
    emline_gvel_oii_3727 real,
    emline_gvel_oii_3729 real,
    emline_gvel_heps_3971 real,
    emline_gvel_hdel_4102 real,
    emline_gvel_hgam_4341 real,
    emline_gvel_heii_4687 real,
    emline_gvel_hei_5877 real,
    emline_gvel_siii_8831 real,
    emline_gvel_siii_9071 real,
    emline_gvel_siii_9533 real,
    emline_gvel_ivar_oiid_3728 double precision,
    emline_gvel_ivar_hb_4862 double precision,
    emline_gvel_ivar_oiii_4960 double precision,
    emline_gvel_ivar_oiii_5008 double precision,
    emline_gvel_ivar_oi_6302 double precision,
    emline_gvel_ivar_oi_6365 double precision,
    emline_gvel_ivar_nii_6549 double precision,
    emline_gvel_ivar_ha_6564 double precision,
    emline_gvel_ivar_nii_6585 double precision,
    emline_gvel_ivar_sii_6718 double precision,
    emline_gvel_ivar_sii_6732 double precision,
    emline_gvel_ivar_oii_3727 double precision,
    emline_gvel_ivar_oii_3729 double precision,
    emline_gvel_ivar_heps_3971 double precision,
    emline_gvel_ivar_hdel_4102 double precision,
    emline_gvel_ivar_hgam_4341 double precision,
    emline_gvel_ivar_heii_4687 double precision,
    emline_gvel_ivar_hei_5877 double precision,
    emline_gvel_ivar_siii_8831 double precision,
    emline_gvel_ivar_siii_9071 double precision,
    emline_gvel_ivar_siii_9533 double precision,
    emline_gvel_mask_oiid_3728 integer,
    emline_gvel_mask_hb_4862 integer,
    emline_gvel_mask_oiii_4960 integer,
    emline_gvel_mask_oiii_5008 integer,
    emline_gvel_mask_oi_6302 integer,
    emline_gvel_mask_oi_6365 integer,
    emline_gvel_mask_nii_6549 integer,
    emline_gvel_mask_ha_6564 integer,
    emline_gvel_mask_nii_6585 integer,
    emline_gvel_mask_sii_6718 integer,
    emline_gvel_mask_sii_6732 integer,
    emline_gvel_mask_oii_3727 integer,
    emline_gvel_mask_oii_3729 integer,
    emline_gvel_mask_heps_3971 integer,
    emline_gvel_mask_hdel_4102 integer,
    emline_gvel_mask_hgam_4341 integer,
    emline_gvel_mask_heii_4687 integer,
    emline_gvel_mask_hei_5877 integer,
    emline_gvel_mask_siii_8831 integer,
    emline_gvel_mask_siii_9071 integer,
    emline_gvel_mask_siii_9533 integer,
    emline_gsigma_oiid_3728 real,
    emline_gsigma_hb_4862 real,
    emline_gsigma_oiii_4960 real,
    emline_gsigma_oiii_5008 real,
    emline_gsigma_oi_6302 real,
    emline_gsigma_oi_6365 real,
    emline_gsigma_nii_6549 real,
    emline_gsigma_ha_6564 real,
    emline_gsigma_nii_6585 real,
    emline_gsigma_sii_6718 real,
    emline_gsigma_sii_6732 real,
    emline_gsigma_oii_3727 real,
    emline_gsigma_oii_3729 real,
    emline_gsigma_heps_3971 real,
    emline_gsigma_hdel_4102 real,
    emline_gsigma_hgam_4341 real,
    emline_gsigma_heii_4687 real,
    emline_gsigma_hei_5877 real,
    emline_gsigma_siii_8831 real,
    emline_gsigma_siii_9071 real,
    emline_gsigma_siii_9533 real,
    emline_gsigma_ivar_oiid_3728 double precision,
    emline_gsigma_ivar_hb_4862 double precision,
    emline_gsigma_ivar_oiii_4960 double precision,
    emline_gsigma_ivar_oiii_5008 double precision,
    emline_gsigma_ivar_oi_6302 double precision,
    emline_gsigma_ivar_oi_6365 double precision,
    emline_gsigma_ivar_nii_6549 double precision,
    emline_gsigma_ivar_ha_6564 double precision,
    emline_gsigma_ivar_nii_6585 double precision,
    emline_gsigma_ivar_sii_6718 double precision,
    emline_gsigma_ivar_sii_6732 double precision,
    emline_gsigma_ivar_oii_3727 double precision,
    emline_gsigma_ivar_oii_3729 double precision,
    emline_gsigma_ivar_heps_3971 double precision,
    emline_gsigma_ivar_hdel_4102 double precision,
    emline_gsigma_ivar_hgam_4341 double precision,
    emline_gsigma_ivar_heii_4687 double precision,
    emline_gsigma_ivar_hei_5877 double precision,
    emline_gsigma_ivar_siii_8831 double precision,
    emline_gsigma_ivar_siii_9071 double precision,
    emline_gsigma_ivar_siii_9533 double precision,
    emline_gsigma_mask_oiid_3728 integer,
    emline_gsigma_mask_hb_4862 integer,
    emline_gsigma_mask_oiii_4960 integer,
    emline_gsigma_mask_oiii_5008 integer,
    emline_gsigma_mask_oi_6302 integer,
    emline_gsigma_mask_oi_6365 integer,
    emline_gsigma_mask_nii_6549 integer,
    emline_gsigma_mask_ha_6564 integer,
    emline_gsigma_mask_nii_6585 integer,
    emline_gsigma_mask_sii_6718 integer,
    emline_gsigma_mask_sii_6732 integer,
    emline_gsigma_mask_oii_3727 integer,
    emline_gsigma_mask_oii_3729 integer,
    emline_gsigma_mask_heps_3971 integer,
    emline_gsigma_mask_hdel_4102 integer,
    emline_gsigma_mask_hgam_4341 integer,
    emline_gsigma_mask_heii_4687 integer,
    emline_gsigma_mask_hei_5877 integer,
    emline_gsigma_mask_siii_8831 integer,
    emline_gsigma_mask_siii_9071 integer,
    emline_gsigma_mask_siii_9533 integer,
    emline_instsigma_oiid_3728 real,
    emline_instsigma_hb_4862 real,
    emline_instsigma_oiii_4960 real,
    emline_instsigma_oiii_5008 real,
    emline_instsigma_oi_6302 real,
    emline_instsigma_oi_6365 real,
    emline_instsigma_nii_6549 real,
    emline_instsigma_ha_6564 real,
    emline_instsigma_nii_6585 real,
    emline_instsigma_sii_6718 real,
    emline_instsigma_sii_6732 real,
    emline_instsigma_oii_3727 real,
    emline_instsigma_oii_3729 real,
    emline_instsigma_heps_3971 real,
    emline_instsigma_hdel_4102 real,
    emline_instsigma_hgam_4341 real,
    emline_instsigma_heii_4687 real,
    emline_instsigma_hei_5877 real,
    emline_instsigma_siii_8831 real,
    emline_instsigma_siii_9071 real,
    emline_instsigma_siii_9533 real,
    specindex_d4000 real,
    specindex_dn4000 real,
    specindex_ivar_d4000 double precision,
    specindex_ivar_dn4000 double precision,
    specindex_mask_d4000 integer,
    specindex_mask_dn4000 integer,
    specindex_corr_d4000 real,
    specindex_corr_dn4000 real,
    x integer,
    y integer
);


ALTER TABLE c5_cx_ssd OWNER TO manga;

--
-- Name: c5_flat_ssd; Type: TABLE; Schema: mangadapdb; Owner: manga; Tablespace: manga_ssd
--

CREATE TABLE c5_flat_ssd (
    drppipe integer,
    dappipe integer,
    plate integer,
    mangaid text,
    name text,
    plateifu text,
    nsa_pk integer,
    pk bigint,
    file_pk integer,
    spaxel_index integer,
    binid_pk integer,
    spx_skycoo_on_sky_x real,
    spx_skycoo_on_sky_y real,
    spx_ellcoo_elliptical_radius real,
    spx_ellcoo_elliptical_azimuth real,
    spx_mflux real,
    spx_mflux_ivar double precision,
    spx_snr real,
    binid integer,
    bin_lwskycoo_lum_weighted_on_sky_x real,
    bin_lwskycoo_lum_weighted_on_sky_y real,
    bin_lwellcoo_lum_weighted_elliptical_radius real,
    bin_lwellcoo_lum_weighted_elliptical_azimuth real,
    bin_area real,
    bin_farea real,
    bin_mflux real,
    bin_mflux_ivar double precision,
    bin_mflux_mask integer,
    bin_snr real,
    stellar_vel real,
    stellar_vel_ivar double precision,
    stellar_vel_mask integer,
    stellar_sigma real,
    stellar_sigma_ivar double precision,
    stellar_sigma_mask integer,
    stellar_sigmacorr real,
    stellar_cont_fresid_68th_percentile real,
    stellar_cont_fresid_99th_percentile real,
    stellar_cont_rchi2 real,
    emline_sflux_oiid_3728 real,
    emline_sflux_hb_4862 real,
    emline_sflux_oiii_4960 real,
    emline_sflux_oiii_5008 real,
    emline_sflux_oi_6302 real,
    emline_sflux_oi_6365 real,
    emline_sflux_nii_6549 real,
    emline_sflux_ha_6564 real,
    emline_sflux_nii_6585 real,
    emline_sflux_sii_6718 real,
    emline_sflux_sii_6732 real,
    emline_sflux_oii_3727 real,
    emline_sflux_oii_3729 real,
    emline_sflux_heps_3971 real,
    emline_sflux_hdel_4102 real,
    emline_sflux_hgam_4341 real,
    emline_sflux_heii_4687 real,
    emline_sflux_hei_5877 real,
    emline_sflux_siii_8831 real,
    emline_sflux_siii_9071 real,
    emline_sflux_siii_9533 real,
    emline_sflux_ivar_oiid_3728 double precision,
    emline_sflux_ivar_hb_4862 double precision,
    emline_sflux_ivar_oiii_4960 double precision,
    emline_sflux_ivar_oiii_5008 double precision,
    emline_sflux_ivar_oi_6302 double precision,
    emline_sflux_ivar_oi_6365 double precision,
    emline_sflux_ivar_nii_6549 double precision,
    emline_sflux_ivar_ha_6564 double precision,
    emline_sflux_ivar_nii_6585 double precision,
    emline_sflux_ivar_sii_6718 double precision,
    emline_sflux_ivar_sii_6732 double precision,
    emline_sflux_ivar_oii_3727 double precision,
    emline_sflux_ivar_oii_3729 double precision,
    emline_sflux_ivar_heps_3971 double precision,
    emline_sflux_ivar_hdel_4102 double precision,
    emline_sflux_ivar_hgam_4341 double precision,
    emline_sflux_ivar_heii_4687 double precision,
    emline_sflux_ivar_hei_5877 double precision,
    emline_sflux_ivar_siii_8831 double precision,
    emline_sflux_ivar_siii_9071 double precision,
    emline_sflux_ivar_siii_9533 double precision,
    emline_sflux_mask_oiid_3728 integer,
    emline_sflux_mask_hb_4862 integer,
    emline_sflux_mask_oiii_4960 integer,
    emline_sflux_mask_oiii_5008 integer,
    emline_sflux_mask_oi_6302 integer,
    emline_sflux_mask_oi_6365 integer,
    emline_sflux_mask_nii_6549 integer,
    emline_sflux_mask_ha_6564 integer,
    emline_sflux_mask_nii_6585 integer,
    emline_sflux_mask_sii_6718 integer,
    emline_sflux_mask_sii_6732 integer,
    emline_sflux_mask_oii_3727 integer,
    emline_sflux_mask_oii_3729 integer,
    emline_sflux_mask_heps_3971 integer,
    emline_sflux_mask_hdel_4102 integer,
    emline_sflux_mask_hgam_4341 integer,
    emline_sflux_mask_heii_4687 integer,
    emline_sflux_mask_hei_5877 integer,
    emline_sflux_mask_siii_8831 integer,
    emline_sflux_mask_siii_9071 integer,
    emline_sflux_mask_siii_9533 integer,
    emline_sew_oiid_3728 double precision,
    emline_sew_hb_4862 double precision,
    emline_sew_oiii_4960 double precision,
    emline_sew_oiii_5008 double precision,
    emline_sew_oi_6302 double precision,
    emline_sew_oi_6365 double precision,
    emline_sew_nii_6549 double precision,
    emline_sew_ha_6564 double precision,
    emline_sew_nii_6585 double precision,
    emline_sew_sii_6718 double precision,
    emline_sew_sii_6732 double precision,
    emline_sew_oii_3727 double precision,
    emline_sew_oii_3729 double precision,
    emline_sew_heps_3971 double precision,
    emline_sew_hdel_4102 double precision,
    emline_sew_hgam_4341 double precision,
    emline_sew_heii_4687 double precision,
    emline_sew_hei_5877 double precision,
    emline_sew_siii_8831 double precision,
    emline_sew_siii_9071 double precision,
    emline_sew_siii_9533 double precision,
    emline_sew_ivar_oiid_3728 double precision,
    emline_sew_ivar_hb_4862 double precision,
    emline_sew_ivar_oiii_4960 double precision,
    emline_sew_ivar_oiii_5008 double precision,
    emline_sew_ivar_oi_6302 double precision,
    emline_sew_ivar_oi_6365 double precision,
    emline_sew_ivar_nii_6549 double precision,
    emline_sew_ivar_ha_6564 double precision,
    emline_sew_ivar_nii_6585 double precision,
    emline_sew_ivar_sii_6718 double precision,
    emline_sew_ivar_sii_6732 double precision,
    emline_sew_ivar_oii_3727 double precision,
    emline_sew_ivar_oii_3729 double precision,
    emline_sew_ivar_heps_3971 double precision,
    emline_sew_ivar_hdel_4102 double precision,
    emline_sew_ivar_hgam_4341 double precision,
    emline_sew_ivar_heii_4687 double precision,
    emline_sew_ivar_hei_5877 double precision,
    emline_sew_ivar_siii_8831 double precision,
    emline_sew_ivar_siii_9071 double precision,
    emline_sew_ivar_siii_9533 double precision,
    emline_sew_mask_oiid_3728 integer,
    emline_sew_mask_hb_4862 integer,
    emline_sew_mask_oiii_4960 integer,
    emline_sew_mask_oiii_5008 integer,
    emline_sew_mask_oi_6302 integer,
    emline_sew_mask_oi_6365 integer,
    emline_sew_mask_nii_6549 integer,
    emline_sew_mask_ha_6564 integer,
    emline_sew_mask_nii_6585 integer,
    emline_sew_mask_sii_6718 integer,
    emline_sew_mask_sii_6732 integer,
    emline_sew_mask_oii_3727 integer,
    emline_sew_mask_oii_3729 integer,
    emline_sew_mask_heps_3971 integer,
    emline_sew_mask_hdel_4102 integer,
    emline_sew_mask_hgam_4341 integer,
    emline_sew_mask_heii_4687 integer,
    emline_sew_mask_hei_5877 integer,
    emline_sew_mask_siii_8831 integer,
    emline_sew_mask_siii_9071 integer,
    emline_sew_mask_siii_9533 integer,
    emline_gflux_oiid_3728 real,
    emline_gflux_hb_4862 real,
    emline_gflux_oiii_4960 real,
    emline_gflux_oiii_5008 double precision,
    emline_gflux_oi_6302 real,
    emline_gflux_oi_6365 real,
    emline_gflux_nii_6549 real,
    emline_gflux_ha_6564 double precision,
    emline_gflux_nii_6585 double precision,
    emline_gflux_sii_6718 real,
    emline_gflux_sii_6732 double precision,
    emline_gflux_oii_3727 double precision,
    emline_gflux_oii_3729 real,
    emline_gflux_heps_3971 real,
    emline_gflux_hdel_4102 real,
    emline_gflux_hgam_4341 real,
    emline_gflux_heii_4687 real,
    emline_gflux_hei_5877 real,
    emline_gflux_siii_8831 real,
    emline_gflux_siii_9071 real,
    emline_gflux_siii_9533 real,
    emline_gflux_ivar_oiid_3728 double precision,
    emline_gflux_ivar_hb_4862 double precision,
    emline_gflux_ivar_oiii_4960 double precision,
    emline_gflux_ivar_oiii_5008 double precision,
    emline_gflux_ivar_oi_6302 double precision,
    emline_gflux_ivar_oi_6365 double precision,
    emline_gflux_ivar_nii_6549 double precision,
    emline_gflux_ivar_ha_6564 double precision,
    emline_gflux_ivar_nii_6585 double precision,
    emline_gflux_ivar_sii_6718 double precision,
    emline_gflux_ivar_sii_6732 double precision,
    emline_gflux_ivar_oii_3727 double precision,
    emline_gflux_ivar_oii_3729 double precision,
    emline_gflux_ivar_heps_3971 double precision,
    emline_gflux_ivar_hdel_4102 double precision,
    emline_gflux_ivar_hgam_4341 double precision,
    emline_gflux_ivar_heii_4687 double precision,
    emline_gflux_ivar_hei_5877 double precision,
    emline_gflux_ivar_siii_8831 double precision,
    emline_gflux_ivar_siii_9071 double precision,
    emline_gflux_ivar_siii_9533 double precision,
    emline_gflux_mask_oiid_3728 integer,
    emline_gflux_mask_hb_4862 integer,
    emline_gflux_mask_oiii_4960 integer,
    emline_gflux_mask_oiii_5008 integer,
    emline_gflux_mask_oi_6302 integer,
    emline_gflux_mask_oi_6365 integer,
    emline_gflux_mask_nii_6549 integer,
    emline_gflux_mask_ha_6564 integer,
    emline_gflux_mask_nii_6585 integer,
    emline_gflux_mask_sii_6718 integer,
    emline_gflux_mask_sii_6732 integer,
    emline_gflux_mask_oii_3727 integer,
    emline_gflux_mask_oii_3729 integer,
    emline_gflux_mask_heps_3971 integer,
    emline_gflux_mask_hdel_4102 integer,
    emline_gflux_mask_hgam_4341 integer,
    emline_gflux_mask_heii_4687 integer,
    emline_gflux_mask_hei_5877 integer,
    emline_gflux_mask_siii_8831 integer,
    emline_gflux_mask_siii_9071 integer,
    emline_gflux_mask_siii_9533 integer,
    emline_gvel_oiid_3728 real,
    emline_gvel_hb_4862 real,
    emline_gvel_oiii_4960 real,
    emline_gvel_oiii_5008 real,
    emline_gvel_oi_6302 real,
    emline_gvel_oi_6365 real,
    emline_gvel_nii_6549 real,
    emline_gvel_ha_6564 real,
    emline_gvel_nii_6585 real,
    emline_gvel_sii_6718 real,
    emline_gvel_sii_6732 real,
    emline_gvel_oii_3727 real,
    emline_gvel_oii_3729 real,
    emline_gvel_heps_3971 real,
    emline_gvel_hdel_4102 real,
    emline_gvel_hgam_4341 real,
    emline_gvel_heii_4687 real,
    emline_gvel_hei_5877 real,
    emline_gvel_siii_8831 real,
    emline_gvel_siii_9071 real,
    emline_gvel_siii_9533 real,
    emline_gvel_ivar_oiid_3728 double precision,
    emline_gvel_ivar_hb_4862 double precision,
    emline_gvel_ivar_oiii_4960 double precision,
    emline_gvel_ivar_oiii_5008 double precision,
    emline_gvel_ivar_oi_6302 double precision,
    emline_gvel_ivar_oi_6365 double precision,
    emline_gvel_ivar_nii_6549 double precision,
    emline_gvel_ivar_ha_6564 double precision,
    emline_gvel_ivar_nii_6585 double precision,
    emline_gvel_ivar_sii_6718 double precision,
    emline_gvel_ivar_sii_6732 double precision,
    emline_gvel_ivar_oii_3727 double precision,
    emline_gvel_ivar_oii_3729 double precision,
    emline_gvel_ivar_heps_3971 double precision,
    emline_gvel_ivar_hdel_4102 double precision,
    emline_gvel_ivar_hgam_4341 double precision,
    emline_gvel_ivar_heii_4687 double precision,
    emline_gvel_ivar_hei_5877 double precision,
    emline_gvel_ivar_siii_8831 double precision,
    emline_gvel_ivar_siii_9071 double precision,
    emline_gvel_ivar_siii_9533 double precision,
    emline_gvel_mask_oiid_3728 integer,
    emline_gvel_mask_hb_4862 integer,
    emline_gvel_mask_oiii_4960 integer,
    emline_gvel_mask_oiii_5008 integer,
    emline_gvel_mask_oi_6302 integer,
    emline_gvel_mask_oi_6365 integer,
    emline_gvel_mask_nii_6549 integer,
    emline_gvel_mask_ha_6564 integer,
    emline_gvel_mask_nii_6585 integer,
    emline_gvel_mask_sii_6718 integer,
    emline_gvel_mask_sii_6732 integer,
    emline_gvel_mask_oii_3727 integer,
    emline_gvel_mask_oii_3729 integer,
    emline_gvel_mask_heps_3971 integer,
    emline_gvel_mask_hdel_4102 integer,
    emline_gvel_mask_hgam_4341 integer,
    emline_gvel_mask_heii_4687 integer,
    emline_gvel_mask_hei_5877 integer,
    emline_gvel_mask_siii_8831 integer,
    emline_gvel_mask_siii_9071 integer,
    emline_gvel_mask_siii_9533 integer,
    emline_gsigma_oiid_3728 real,
    emline_gsigma_hb_4862 real,
    emline_gsigma_oiii_4960 real,
    emline_gsigma_oiii_5008 real,
    emline_gsigma_oi_6302 real,
    emline_gsigma_oi_6365 real,
    emline_gsigma_nii_6549 real,
    emline_gsigma_ha_6564 real,
    emline_gsigma_nii_6585 real,
    emline_gsigma_sii_6718 real,
    emline_gsigma_sii_6732 real,
    emline_gsigma_oii_3727 real,
    emline_gsigma_oii_3729 real,
    emline_gsigma_heps_3971 real,
    emline_gsigma_hdel_4102 real,
    emline_gsigma_hgam_4341 real,
    emline_gsigma_heii_4687 real,
    emline_gsigma_hei_5877 real,
    emline_gsigma_siii_8831 real,
    emline_gsigma_siii_9071 real,
    emline_gsigma_siii_9533 real,
    emline_gsigma_ivar_oiid_3728 double precision,
    emline_gsigma_ivar_hb_4862 double precision,
    emline_gsigma_ivar_oiii_4960 double precision,
    emline_gsigma_ivar_oiii_5008 double precision,
    emline_gsigma_ivar_oi_6302 double precision,
    emline_gsigma_ivar_oi_6365 double precision,
    emline_gsigma_ivar_nii_6549 double precision,
    emline_gsigma_ivar_ha_6564 double precision,
    emline_gsigma_ivar_nii_6585 double precision,
    emline_gsigma_ivar_sii_6718 double precision,
    emline_gsigma_ivar_sii_6732 double precision,
    emline_gsigma_ivar_oii_3727 double precision,
    emline_gsigma_ivar_oii_3729 double precision,
    emline_gsigma_ivar_heps_3971 double precision,
    emline_gsigma_ivar_hdel_4102 double precision,
    emline_gsigma_ivar_hgam_4341 double precision,
    emline_gsigma_ivar_heii_4687 double precision,
    emline_gsigma_ivar_hei_5877 double precision,
    emline_gsigma_ivar_siii_8831 double precision,
    emline_gsigma_ivar_siii_9071 double precision,
    emline_gsigma_ivar_siii_9533 double precision,
    emline_gsigma_mask_oiid_3728 integer,
    emline_gsigma_mask_hb_4862 integer,
    emline_gsigma_mask_oiii_4960 integer,
    emline_gsigma_mask_oiii_5008 integer,
    emline_gsigma_mask_oi_6302 integer,
    emline_gsigma_mask_oi_6365 integer,
    emline_gsigma_mask_nii_6549 integer,
    emline_gsigma_mask_ha_6564 integer,
    emline_gsigma_mask_nii_6585 integer,
    emline_gsigma_mask_sii_6718 integer,
    emline_gsigma_mask_sii_6732 integer,
    emline_gsigma_mask_oii_3727 integer,
    emline_gsigma_mask_oii_3729 integer,
    emline_gsigma_mask_heps_3971 integer,
    emline_gsigma_mask_hdel_4102 integer,
    emline_gsigma_mask_hgam_4341 integer,
    emline_gsigma_mask_heii_4687 integer,
    emline_gsigma_mask_hei_5877 integer,
    emline_gsigma_mask_siii_8831 integer,
    emline_gsigma_mask_siii_9071 integer,
    emline_gsigma_mask_siii_9533 integer,
    emline_instsigma_oiid_3728 real,
    emline_instsigma_hb_4862 real,
    emline_instsigma_oiii_4960 real,
    emline_instsigma_oiii_5008 real,
    emline_instsigma_oi_6302 real,
    emline_instsigma_oi_6365 real,
    emline_instsigma_nii_6549 real,
    emline_instsigma_ha_6564 real,
    emline_instsigma_nii_6585 real,
    emline_instsigma_sii_6718 real,
    emline_instsigma_sii_6732 real,
    emline_instsigma_oii_3727 real,
    emline_instsigma_oii_3729 real,
    emline_instsigma_heps_3971 real,
    emline_instsigma_hdel_4102 real,
    emline_instsigma_hgam_4341 real,
    emline_instsigma_heii_4687 real,
    emline_instsigma_hei_5877 real,
    emline_instsigma_siii_8831 real,
    emline_instsigma_siii_9071 real,
    emline_instsigma_siii_9533 real,
    specindex_d4000 real,
    specindex_dn4000 real,
    specindex_ivar_d4000 double precision,
    specindex_ivar_dn4000 double precision,
    specindex_mask_d4000 integer,
    specindex_mask_dn4000 integer,
    specindex_corr_d4000 real,
    specindex_corr_dn4000 real,
    x integer,
    y integer
);


ALTER TABLE c5_flat_ssd OWNER TO manga;

--
-- Name: c5_ssd; Type: TABLE; Schema: mangadapdb; Owner: manga; Tablespace: manga_ssd
--

CREATE TABLE c5_ssd (
    pk bigint,
    file_pk integer,
    spaxel_index integer,
    binid_pk integer,
    spx_skycoo_on_sky_x real,
    spx_skycoo_on_sky_y real,
    spx_ellcoo_elliptical_radius real,
    spx_ellcoo_elliptical_azimuth real,
    spx_mflux real,
    spx_mflux_ivar double precision,
    spx_snr real,
    binid integer,
    bin_lwskycoo_lum_weighted_on_sky_x real,
    bin_lwskycoo_lum_weighted_on_sky_y real,
    bin_lwellcoo_lum_weighted_elliptical_radius real,
    bin_lwellcoo_lum_weighted_elliptical_azimuth real,
    bin_area real,
    bin_farea real,
    bin_mflux real,
    bin_mflux_ivar double precision,
    bin_mflux_mask integer,
    bin_snr real,
    stellar_vel real,
    stellar_vel_ivar double precision,
    stellar_vel_mask integer,
    stellar_sigma real,
    stellar_sigma_ivar double precision,
    stellar_sigma_mask integer,
    stellar_sigmacorr real,
    stellar_cont_fresid_68th_percentile real,
    stellar_cont_fresid_99th_percentile real,
    stellar_cont_rchi2 real,
    emline_sflux_oiid_3728 real,
    emline_sflux_hb_4862 real,
    emline_sflux_oiii_4960 real,
    emline_sflux_oiii_5008 real,
    emline_sflux_oi_6302 real,
    emline_sflux_oi_6365 real,
    emline_sflux_nii_6549 real,
    emline_sflux_ha_6564 real,
    emline_sflux_nii_6585 real,
    emline_sflux_sii_6718 real,
    emline_sflux_sii_6732 real,
    emline_sflux_oii_3727 real,
    emline_sflux_oii_3729 real,
    emline_sflux_heps_3971 real,
    emline_sflux_hdel_4102 real,
    emline_sflux_hgam_4341 real,
    emline_sflux_heii_4687 real,
    emline_sflux_hei_5877 real,
    emline_sflux_siii_8831 real,
    emline_sflux_siii_9071 real,
    emline_sflux_siii_9533 real,
    emline_sflux_ivar_oiid_3728 double precision,
    emline_sflux_ivar_hb_4862 double precision,
    emline_sflux_ivar_oiii_4960 double precision,
    emline_sflux_ivar_oiii_5008 double precision,
    emline_sflux_ivar_oi_6302 double precision,
    emline_sflux_ivar_oi_6365 double precision,
    emline_sflux_ivar_nii_6549 double precision,
    emline_sflux_ivar_ha_6564 double precision,
    emline_sflux_ivar_nii_6585 double precision,
    emline_sflux_ivar_sii_6718 double precision,
    emline_sflux_ivar_sii_6732 double precision,
    emline_sflux_ivar_oii_3727 double precision,
    emline_sflux_ivar_oii_3729 double precision,
    emline_sflux_ivar_heps_3971 double precision,
    emline_sflux_ivar_hdel_4102 double precision,
    emline_sflux_ivar_hgam_4341 double precision,
    emline_sflux_ivar_heii_4687 double precision,
    emline_sflux_ivar_hei_5877 double precision,
    emline_sflux_ivar_siii_8831 double precision,
    emline_sflux_ivar_siii_9071 double precision,
    emline_sflux_ivar_siii_9533 double precision,
    emline_sflux_mask_oiid_3728 integer,
    emline_sflux_mask_hb_4862 integer,
    emline_sflux_mask_oiii_4960 integer,
    emline_sflux_mask_oiii_5008 integer,
    emline_sflux_mask_oi_6302 integer,
    emline_sflux_mask_oi_6365 integer,
    emline_sflux_mask_nii_6549 integer,
    emline_sflux_mask_ha_6564 integer,
    emline_sflux_mask_nii_6585 integer,
    emline_sflux_mask_sii_6718 integer,
    emline_sflux_mask_sii_6732 integer,
    emline_sflux_mask_oii_3727 integer,
    emline_sflux_mask_oii_3729 integer,
    emline_sflux_mask_heps_3971 integer,
    emline_sflux_mask_hdel_4102 integer,
    emline_sflux_mask_hgam_4341 integer,
    emline_sflux_mask_heii_4687 integer,
    emline_sflux_mask_hei_5877 integer,
    emline_sflux_mask_siii_8831 integer,
    emline_sflux_mask_siii_9071 integer,
    emline_sflux_mask_siii_9533 integer,
    emline_sew_oiid_3728 double precision,
    emline_sew_hb_4862 double precision,
    emline_sew_oiii_4960 double precision,
    emline_sew_oiii_5008 double precision,
    emline_sew_oi_6302 double precision,
    emline_sew_oi_6365 double precision,
    emline_sew_nii_6549 double precision,
    emline_sew_ha_6564 double precision,
    emline_sew_nii_6585 double precision,
    emline_sew_sii_6718 double precision,
    emline_sew_sii_6732 double precision,
    emline_sew_oii_3727 double precision,
    emline_sew_oii_3729 double precision,
    emline_sew_heps_3971 double precision,
    emline_sew_hdel_4102 double precision,
    emline_sew_hgam_4341 double precision,
    emline_sew_heii_4687 double precision,
    emline_sew_hei_5877 double precision,
    emline_sew_siii_8831 double precision,
    emline_sew_siii_9071 double precision,
    emline_sew_siii_9533 double precision,
    emline_sew_ivar_oiid_3728 double precision,
    emline_sew_ivar_hb_4862 double precision,
    emline_sew_ivar_oiii_4960 double precision,
    emline_sew_ivar_oiii_5008 double precision,
    emline_sew_ivar_oi_6302 double precision,
    emline_sew_ivar_oi_6365 double precision,
    emline_sew_ivar_nii_6549 double precision,
    emline_sew_ivar_ha_6564 double precision,
    emline_sew_ivar_nii_6585 double precision,
    emline_sew_ivar_sii_6718 double precision,
    emline_sew_ivar_sii_6732 double precision,
    emline_sew_ivar_oii_3727 double precision,
    emline_sew_ivar_oii_3729 double precision,
    emline_sew_ivar_heps_3971 double precision,
    emline_sew_ivar_hdel_4102 double precision,
    emline_sew_ivar_hgam_4341 double precision,
    emline_sew_ivar_heii_4687 double precision,
    emline_sew_ivar_hei_5877 double precision,
    emline_sew_ivar_siii_8831 double precision,
    emline_sew_ivar_siii_9071 double precision,
    emline_sew_ivar_siii_9533 double precision,
    emline_sew_mask_oiid_3728 integer,
    emline_sew_mask_hb_4862 integer,
    emline_sew_mask_oiii_4960 integer,
    emline_sew_mask_oiii_5008 integer,
    emline_sew_mask_oi_6302 integer,
    emline_sew_mask_oi_6365 integer,
    emline_sew_mask_nii_6549 integer,
    emline_sew_mask_ha_6564 integer,
    emline_sew_mask_nii_6585 integer,
    emline_sew_mask_sii_6718 integer,
    emline_sew_mask_sii_6732 integer,
    emline_sew_mask_oii_3727 integer,
    emline_sew_mask_oii_3729 integer,
    emline_sew_mask_heps_3971 integer,
    emline_sew_mask_hdel_4102 integer,
    emline_sew_mask_hgam_4341 integer,
    emline_sew_mask_heii_4687 integer,
    emline_sew_mask_hei_5877 integer,
    emline_sew_mask_siii_8831 integer,
    emline_sew_mask_siii_9071 integer,
    emline_sew_mask_siii_9533 integer,
    emline_gflux_oiid_3728 real,
    emline_gflux_hb_4862 real,
    emline_gflux_oiii_4960 real,
    emline_gflux_oiii_5008 double precision,
    emline_gflux_oi_6302 real,
    emline_gflux_oi_6365 real,
    emline_gflux_nii_6549 real,
    emline_gflux_ha_6564 double precision,
    emline_gflux_nii_6585 double precision,
    emline_gflux_sii_6718 real,
    emline_gflux_sii_6732 double precision,
    emline_gflux_oii_3727 double precision,
    emline_gflux_oii_3729 real,
    emline_gflux_heps_3971 real,
    emline_gflux_hdel_4102 real,
    emline_gflux_hgam_4341 real,
    emline_gflux_heii_4687 real,
    emline_gflux_hei_5877 real,
    emline_gflux_siii_8831 real,
    emline_gflux_siii_9071 real,
    emline_gflux_siii_9533 real,
    emline_gflux_ivar_oiid_3728 double precision,
    emline_gflux_ivar_hb_4862 double precision,
    emline_gflux_ivar_oiii_4960 double precision,
    emline_gflux_ivar_oiii_5008 double precision,
    emline_gflux_ivar_oi_6302 double precision,
    emline_gflux_ivar_oi_6365 double precision,
    emline_gflux_ivar_nii_6549 double precision,
    emline_gflux_ivar_ha_6564 double precision,
    emline_gflux_ivar_nii_6585 double precision,
    emline_gflux_ivar_sii_6718 double precision,
    emline_gflux_ivar_sii_6732 double precision,
    emline_gflux_ivar_oii_3727 double precision,
    emline_gflux_ivar_oii_3729 double precision,
    emline_gflux_ivar_heps_3971 double precision,
    emline_gflux_ivar_hdel_4102 double precision,
    emline_gflux_ivar_hgam_4341 double precision,
    emline_gflux_ivar_heii_4687 double precision,
    emline_gflux_ivar_hei_5877 double precision,
    emline_gflux_ivar_siii_8831 double precision,
    emline_gflux_ivar_siii_9071 double precision,
    emline_gflux_ivar_siii_9533 double precision,
    emline_gflux_mask_oiid_3728 integer,
    emline_gflux_mask_hb_4862 integer,
    emline_gflux_mask_oiii_4960 integer,
    emline_gflux_mask_oiii_5008 integer,
    emline_gflux_mask_oi_6302 integer,
    emline_gflux_mask_oi_6365 integer,
    emline_gflux_mask_nii_6549 integer,
    emline_gflux_mask_ha_6564 integer,
    emline_gflux_mask_nii_6585 integer,
    emline_gflux_mask_sii_6718 integer,
    emline_gflux_mask_sii_6732 integer,
    emline_gflux_mask_oii_3727 integer,
    emline_gflux_mask_oii_3729 integer,
    emline_gflux_mask_heps_3971 integer,
    emline_gflux_mask_hdel_4102 integer,
    emline_gflux_mask_hgam_4341 integer,
    emline_gflux_mask_heii_4687 integer,
    emline_gflux_mask_hei_5877 integer,
    emline_gflux_mask_siii_8831 integer,
    emline_gflux_mask_siii_9071 integer,
    emline_gflux_mask_siii_9533 integer,
    emline_gvel_oiid_3728 real,
    emline_gvel_hb_4862 real,
    emline_gvel_oiii_4960 real,
    emline_gvel_oiii_5008 real,
    emline_gvel_oi_6302 real,
    emline_gvel_oi_6365 real,
    emline_gvel_nii_6549 real,
    emline_gvel_ha_6564 real,
    emline_gvel_nii_6585 real,
    emline_gvel_sii_6718 real,
    emline_gvel_sii_6732 real,
    emline_gvel_oii_3727 real,
    emline_gvel_oii_3729 real,
    emline_gvel_heps_3971 real,
    emline_gvel_hdel_4102 real,
    emline_gvel_hgam_4341 real,
    emline_gvel_heii_4687 real,
    emline_gvel_hei_5877 real,
    emline_gvel_siii_8831 real,
    emline_gvel_siii_9071 real,
    emline_gvel_siii_9533 real,
    emline_gvel_ivar_oiid_3728 double precision,
    emline_gvel_ivar_hb_4862 double precision,
    emline_gvel_ivar_oiii_4960 double precision,
    emline_gvel_ivar_oiii_5008 double precision,
    emline_gvel_ivar_oi_6302 double precision,
    emline_gvel_ivar_oi_6365 double precision,
    emline_gvel_ivar_nii_6549 double precision,
    emline_gvel_ivar_ha_6564 double precision,
    emline_gvel_ivar_nii_6585 double precision,
    emline_gvel_ivar_sii_6718 double precision,
    emline_gvel_ivar_sii_6732 double precision,
    emline_gvel_ivar_oii_3727 double precision,
    emline_gvel_ivar_oii_3729 double precision,
    emline_gvel_ivar_heps_3971 double precision,
    emline_gvel_ivar_hdel_4102 double precision,
    emline_gvel_ivar_hgam_4341 double precision,
    emline_gvel_ivar_heii_4687 double precision,
    emline_gvel_ivar_hei_5877 double precision,
    emline_gvel_ivar_siii_8831 double precision,
    emline_gvel_ivar_siii_9071 double precision,
    emline_gvel_ivar_siii_9533 double precision,
    emline_gvel_mask_oiid_3728 integer,
    emline_gvel_mask_hb_4862 integer,
    emline_gvel_mask_oiii_4960 integer,
    emline_gvel_mask_oiii_5008 integer,
    emline_gvel_mask_oi_6302 integer,
    emline_gvel_mask_oi_6365 integer,
    emline_gvel_mask_nii_6549 integer,
    emline_gvel_mask_ha_6564 integer,
    emline_gvel_mask_nii_6585 integer,
    emline_gvel_mask_sii_6718 integer,
    emline_gvel_mask_sii_6732 integer,
    emline_gvel_mask_oii_3727 integer,
    emline_gvel_mask_oii_3729 integer,
    emline_gvel_mask_heps_3971 integer,
    emline_gvel_mask_hdel_4102 integer,
    emline_gvel_mask_hgam_4341 integer,
    emline_gvel_mask_heii_4687 integer,
    emline_gvel_mask_hei_5877 integer,
    emline_gvel_mask_siii_8831 integer,
    emline_gvel_mask_siii_9071 integer,
    emline_gvel_mask_siii_9533 integer,
    emline_gsigma_oiid_3728 real,
    emline_gsigma_hb_4862 real,
    emline_gsigma_oiii_4960 real,
    emline_gsigma_oiii_5008 real,
    emline_gsigma_oi_6302 real,
    emline_gsigma_oi_6365 real,
    emline_gsigma_nii_6549 real,
    emline_gsigma_ha_6564 real,
    emline_gsigma_nii_6585 real,
    emline_gsigma_sii_6718 real,
    emline_gsigma_sii_6732 real,
    emline_gsigma_oii_3727 real,
    emline_gsigma_oii_3729 real,
    emline_gsigma_heps_3971 real,
    emline_gsigma_hdel_4102 real,
    emline_gsigma_hgam_4341 real,
    emline_gsigma_heii_4687 real,
    emline_gsigma_hei_5877 real,
    emline_gsigma_siii_8831 real,
    emline_gsigma_siii_9071 real,
    emline_gsigma_siii_9533 real,
    emline_gsigma_ivar_oiid_3728 double precision,
    emline_gsigma_ivar_hb_4862 double precision,
    emline_gsigma_ivar_oiii_4960 double precision,
    emline_gsigma_ivar_oiii_5008 double precision,
    emline_gsigma_ivar_oi_6302 double precision,
    emline_gsigma_ivar_oi_6365 double precision,
    emline_gsigma_ivar_nii_6549 double precision,
    emline_gsigma_ivar_ha_6564 double precision,
    emline_gsigma_ivar_nii_6585 double precision,
    emline_gsigma_ivar_sii_6718 double precision,
    emline_gsigma_ivar_sii_6732 double precision,
    emline_gsigma_ivar_oii_3727 double precision,
    emline_gsigma_ivar_oii_3729 double precision,
    emline_gsigma_ivar_heps_3971 double precision,
    emline_gsigma_ivar_hdel_4102 double precision,
    emline_gsigma_ivar_hgam_4341 double precision,
    emline_gsigma_ivar_heii_4687 double precision,
    emline_gsigma_ivar_hei_5877 double precision,
    emline_gsigma_ivar_siii_8831 double precision,
    emline_gsigma_ivar_siii_9071 double precision,
    emline_gsigma_ivar_siii_9533 double precision,
    emline_gsigma_mask_oiid_3728 integer,
    emline_gsigma_mask_hb_4862 integer,
    emline_gsigma_mask_oiii_4960 integer,
    emline_gsigma_mask_oiii_5008 integer,
    emline_gsigma_mask_oi_6302 integer,
    emline_gsigma_mask_oi_6365 integer,
    emline_gsigma_mask_nii_6549 integer,
    emline_gsigma_mask_ha_6564 integer,
    emline_gsigma_mask_nii_6585 integer,
    emline_gsigma_mask_sii_6718 integer,
    emline_gsigma_mask_sii_6732 integer,
    emline_gsigma_mask_oii_3727 integer,
    emline_gsigma_mask_oii_3729 integer,
    emline_gsigma_mask_heps_3971 integer,
    emline_gsigma_mask_hdel_4102 integer,
    emline_gsigma_mask_hgam_4341 integer,
    emline_gsigma_mask_heii_4687 integer,
    emline_gsigma_mask_hei_5877 integer,
    emline_gsigma_mask_siii_8831 integer,
    emline_gsigma_mask_siii_9071 integer,
    emline_gsigma_mask_siii_9533 integer,
    emline_instsigma_oiid_3728 real,
    emline_instsigma_hb_4862 real,
    emline_instsigma_oiii_4960 real,
    emline_instsigma_oiii_5008 real,
    emline_instsigma_oi_6302 real,
    emline_instsigma_oi_6365 real,
    emline_instsigma_nii_6549 real,
    emline_instsigma_ha_6564 real,
    emline_instsigma_nii_6585 real,
    emline_instsigma_sii_6718 real,
    emline_instsigma_sii_6732 real,
    emline_instsigma_oii_3727 real,
    emline_instsigma_oii_3729 real,
    emline_instsigma_heps_3971 real,
    emline_instsigma_hdel_4102 real,
    emline_instsigma_hgam_4341 real,
    emline_instsigma_heii_4687 real,
    emline_instsigma_hei_5877 real,
    emline_instsigma_siii_8831 real,
    emline_instsigma_siii_9071 real,
    emline_instsigma_siii_9533 real,
    specindex_d4000 real,
    specindex_dn4000 real,
    specindex_ivar_d4000 double precision,
    specindex_ivar_dn4000 double precision,
    specindex_mask_d4000 integer,
    specindex_mask_dn4000 integer,
    specindex_corr_d4000 real,
    specindex_corr_dn4000 real,
    x integer,
    y integer
);


ALTER TABLE c5_ssd OWNER TO manga;

SET default_tablespace = '';

--
-- Name: cleanspaxelprop; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE cleanspaxelprop (
    pk bigint,
    file_pk integer,
    spaxel_index integer,
    binid_pk integer,
    emline_gflux_oiid_3728 real,
    emline_gflux_hb_4862 real,
    emline_gflux_oiii_4960 real,
    emline_gflux_oiii_5008 real,
    emline_gflux_oi_6302 real,
    emline_gflux_oi_6365 real,
    emline_gflux_nii_6549 real,
    emline_gflux_ha_6564 real,
    emline_gflux_nii_6585 real,
    emline_gflux_sii_6718 real,
    emline_gflux_sii_6732 real,
    emline_gflux_ivar_oiid_3728 double precision,
    emline_gflux_ivar_hb_4862 double precision,
    emline_gflux_ivar_oiii_4960 double precision,
    emline_gflux_ivar_oiii_5008 double precision,
    emline_gflux_ivar_oi_6302 double precision,
    emline_gflux_ivar_oi_6365 double precision,
    emline_gflux_ivar_nii_6549 double precision,
    emline_gflux_ivar_ha_6564 double precision,
    emline_gflux_ivar_nii_6585 double precision,
    emline_gflux_ivar_sii_6718 double precision,
    emline_gflux_ivar_sii_6732 double precision,
    emline_gflux_mask_oiid_3728 integer,
    emline_gflux_mask_hb_4862 integer,
    emline_gflux_mask_oiii_4960 integer,
    emline_gflux_mask_oiii_5008 integer,
    emline_gflux_mask_oi_6302 integer,
    emline_gflux_mask_oi_6365 integer,
    emline_gflux_mask_nii_6549 integer,
    emline_gflux_mask_ha_6564 integer,
    emline_gflux_mask_nii_6585 integer,
    emline_gflux_mask_sii_6718 integer,
    emline_gflux_mask_sii_6732 integer,
    emline_gvel_oiid_3728 real,
    emline_gvel_hb_4862 real,
    emline_gvel_oiii_4960 real,
    emline_gvel_oiii_5008 real,
    emline_gvel_oi_6302 real,
    emline_gvel_oi_6365 real,
    emline_gvel_nii_6549 real,
    emline_gvel_ha_6564 real,
    emline_gvel_nii_6585 real,
    emline_gvel_sii_6718 real,
    emline_gvel_sii_6732 real,
    emline_gvel_ivar_oiid_3728 double precision,
    emline_gvel_ivar_hb_4862 double precision,
    emline_gvel_ivar_oiii_4960 double precision,
    emline_gvel_ivar_oiii_5008 double precision,
    emline_gvel_ivar_oi_6302 double precision,
    emline_gvel_ivar_oi_6365 double precision,
    emline_gvel_ivar_nii_6549 double precision,
    emline_gvel_ivar_ha_6564 double precision,
    emline_gvel_ivar_nii_6585 double precision,
    emline_gvel_ivar_sii_6718 double precision,
    emline_gvel_ivar_sii_6732 double precision,
    emline_gvel_mask_oiid_3728 integer,
    emline_gvel_mask_hb_4862 integer,
    emline_gvel_mask_oiii_4960 integer,
    emline_gvel_mask_oiii_5008 integer,
    emline_gvel_mask_oi_6302 integer,
    emline_gvel_mask_oi_6365 integer,
    emline_gvel_mask_nii_6549 integer,
    emline_gvel_mask_ha_6564 integer,
    emline_gvel_mask_nii_6585 integer,
    emline_gvel_mask_sii_6718 integer,
    emline_gvel_mask_sii_6732 integer,
    emline_gsigma_oiid_3728 real,
    emline_gsigma_hb_4862 real,
    emline_gsigma_oiii_4960 real,
    emline_gsigma_oiii_5008 real,
    emline_gsigma_oi_6302 real,
    emline_gsigma_oi_6365 real,
    emline_gsigma_nii_6549 real,
    emline_gsigma_ha_6564 real,
    emline_gsigma_nii_6585 real,
    emline_gsigma_sii_6718 real,
    emline_gsigma_sii_6732 real,
    emline_gsigma_ivar_oiid_3728 double precision,
    emline_gsigma_ivar_hb_4862 double precision,
    emline_gsigma_ivar_oiii_4960 double precision,
    emline_gsigma_ivar_oiii_5008 double precision,
    emline_gsigma_ivar_oi_6302 double precision,
    emline_gsigma_ivar_oi_6365 double precision,
    emline_gsigma_ivar_nii_6549 double precision,
    emline_gsigma_ivar_ha_6564 double precision,
    emline_gsigma_ivar_nii_6585 double precision,
    emline_gsigma_ivar_sii_6718 double precision,
    emline_gsigma_ivar_sii_6732 double precision,
    emline_gsigma_mask_oiid_3728 integer,
    emline_gsigma_mask_hb_4862 integer,
    emline_gsigma_mask_oiii_4960 integer,
    emline_gsigma_mask_oiii_5008 integer,
    emline_gsigma_mask_oi_6302 integer,
    emline_gsigma_mask_oi_6365 integer,
    emline_gsigma_mask_nii_6549 integer,
    emline_gsigma_mask_ha_6564 integer,
    emline_gsigma_mask_nii_6585 integer,
    emline_gsigma_mask_sii_6718 integer,
    emline_gsigma_mask_sii_6732 integer,
    emline_instsigma_oiid_3728 real,
    emline_instsigma_hb_4862 real,
    emline_instsigma_oiii_4960 real,
    emline_instsigma_oiii_5008 real,
    emline_instsigma_oi_6302 real,
    emline_instsigma_oi_6365 real,
    emline_instsigma_nii_6549 real,
    emline_instsigma_ha_6564 real,
    emline_instsigma_nii_6585 real,
    emline_instsigma_sii_6718 real,
    emline_instsigma_sii_6732 real,
    emline_ew_oiid_3728 real,
    emline_ew_hb_4862 double precision,
    emline_ew_oiii_4960 real,
    emline_ew_oiii_5008 double precision,
    emline_ew_oi_6302 double precision,
    emline_ew_oi_6365 double precision,
    emline_ew_nii_6549 double precision,
    emline_ew_ha_6564 double precision,
    emline_ew_nii_6585 double precision,
    emline_ew_sii_6718 real,
    emline_ew_sii_6732 real,
    emline_ew_ivar_oiid_3728 double precision,
    emline_ew_ivar_hb_4862 double precision,
    emline_ew_ivar_oiii_4960 double precision,
    emline_ew_ivar_oiii_5008 double precision,
    emline_ew_ivar_oi_6302 double precision,
    emline_ew_ivar_oi_6365 double precision,
    emline_ew_ivar_nii_6549 double precision,
    emline_ew_ivar_ha_6564 double precision,
    emline_ew_ivar_nii_6585 double precision,
    emline_ew_ivar_sii_6718 double precision,
    emline_ew_ivar_sii_6732 double precision,
    emline_ew_mask_oiid_3728 integer,
    emline_ew_mask_hb_4862 integer,
    emline_ew_mask_oiii_4960 integer,
    emline_ew_mask_oiii_5008 integer,
    emline_ew_mask_oi_6302 integer,
    emline_ew_mask_oi_6365 integer,
    emline_ew_mask_nii_6549 integer,
    emline_ew_mask_ha_6564 integer,
    emline_ew_mask_nii_6585 integer,
    emline_ew_mask_sii_6718 integer,
    emline_ew_mask_sii_6732 integer,
    emline_sflux_oiid_3728 real,
    emline_sflux_hb_4862 real,
    emline_sflux_oiii_4960 real,
    emline_sflux_oiii_5008 real,
    emline_sflux_oi_6302 real,
    emline_sflux_oi_6365 real,
    emline_sflux_nii_6549 real,
    emline_sflux_ha_6564 real,
    emline_sflux_nii_6585 real,
    emline_sflux_sii_6718 real,
    emline_sflux_sii_6732 real,
    emline_sflux_ivar_oiid_3728 double precision,
    emline_sflux_ivar_hb_4862 double precision,
    emline_sflux_ivar_oiii_4960 double precision,
    emline_sflux_ivar_oiii_5008 double precision,
    emline_sflux_ivar_oi_6302 double precision,
    emline_sflux_ivar_oi_6365 double precision,
    emline_sflux_ivar_nii_6549 double precision,
    emline_sflux_ivar_ha_6564 double precision,
    emline_sflux_ivar_nii_6585 double precision,
    emline_sflux_ivar_sii_6718 double precision,
    emline_sflux_ivar_sii_6732 double precision,
    emline_sflux_mask_oiid_3728 integer,
    emline_sflux_mask_hb_4862 integer,
    emline_sflux_mask_oiii_4960 integer,
    emline_sflux_mask_oiii_5008 integer,
    emline_sflux_mask_oi_6302 integer,
    emline_sflux_mask_oi_6365 integer,
    emline_sflux_mask_nii_6549 integer,
    emline_sflux_mask_ha_6564 integer,
    emline_sflux_mask_nii_6585 integer,
    emline_sflux_mask_sii_6718 integer,
    emline_sflux_mask_sii_6732 integer,
    stellar_vel real,
    stellar_vel_ivar double precision,
    stellar_vel_mask integer,
    stellar_sigma real,
    stellar_sigma_ivar double precision,
    stellar_sigma_mask integer,
    specindex_d4000 real,
    specindex_caii0p39 real,
    specindex_hdeltaa real,
    specindex_cn1 real,
    specindex_cn2 real,
    specindex_ca4227 real,
    specindex_hgammaa real,
    specindex_fe4668 real,
    specindex_hb real,
    specindex_mgb real,
    specindex_fe5270 real,
    specindex_fe5335 real,
    specindex_fe5406 real,
    specindex_nad real,
    specindex_tio1 real,
    specindex_tio2 real,
    specindex_nai0p82 real,
    specindex_caii0p86a real,
    specindex_caii0p86b real,
    specindex_caii0p86c real,
    specindex_mgi0p88 real,
    specindex_tio0p89 real,
    specindex_feh0p99 real,
    specindex_ivar_d4000 double precision,
    specindex_ivar_caii0p39 double precision,
    specindex_ivar_hdeltaa double precision,
    specindex_ivar_cn1 double precision,
    specindex_ivar_cn2 double precision,
    specindex_ivar_ca4227 double precision,
    specindex_ivar_hgammaa double precision,
    specindex_ivar_fe4668 double precision,
    specindex_ivar_hb double precision,
    specindex_ivar_mgb double precision,
    specindex_ivar_fe5270 double precision,
    specindex_ivar_fe5335 double precision,
    specindex_ivar_fe5406 double precision,
    specindex_ivar_nad double precision,
    specindex_ivar_tio1 double precision,
    specindex_ivar_tio2 double precision,
    specindex_ivar_nai0p82 double precision,
    specindex_ivar_caii0p86a double precision,
    specindex_ivar_caii0p86b double precision,
    specindex_ivar_caii0p86c double precision,
    specindex_ivar_mgi0p88 double precision,
    specindex_ivar_tio0p89 double precision,
    specindex_ivar_feh0p99 double precision,
    specindex_mask_d4000 integer,
    specindex_mask_caii0p39 integer,
    specindex_mask_hdeltaa integer,
    specindex_mask_cn1 integer,
    specindex_mask_cn2 integer,
    specindex_mask_ca4227 integer,
    specindex_mask_hgammaa integer,
    specindex_mask_fe4668 integer,
    specindex_mask_hb integer,
    specindex_mask_mgb integer,
    specindex_mask_fe5270 integer,
    specindex_mask_fe5335 integer,
    specindex_mask_fe5406 integer,
    specindex_mask_nad integer,
    specindex_mask_tio1 integer,
    specindex_mask_tio2 integer,
    specindex_mask_nai0p82 integer,
    specindex_mask_caii0p86a integer,
    specindex_mask_caii0p86b integer,
    specindex_mask_caii0p86c integer,
    specindex_mask_mgi0p88 integer,
    specindex_mask_tio0p89 integer,
    specindex_mask_feh0p99 integer,
    binid integer,
    x integer,
    y integer
);


ALTER TABLE cleanspaxelprop OWNER TO manga;

--
-- Name: cleanspaxelprop5; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE cleanspaxelprop5 (
    pk bigint,
    file_pk integer,
    spaxel_index integer,
    binid_pk integer,
    spx_skycoo_on_sky_x real,
    spx_skycoo_on_sky_y real,
    spx_ellcoo_elliptical_radius real,
    spx_ellcoo_elliptical_azimuth real,
    spx_mflux real,
    spx_mflux_ivar double precision,
    spx_snr real,
    binid integer,
    bin_lwskycoo_lum_weighted_on_sky_x real,
    bin_lwskycoo_lum_weighted_on_sky_y real,
    bin_lwellcoo_lum_weighted_elliptical_radius real,
    bin_lwellcoo_lum_weighted_elliptical_azimuth real,
    bin_area real,
    bin_farea real,
    bin_mflux real,
    bin_mflux_ivar double precision,
    bin_mflux_mask integer,
    bin_snr real,
    stellar_vel real,
    stellar_vel_ivar double precision,
    stellar_vel_mask integer,
    stellar_sigma real,
    stellar_sigma_ivar double precision,
    stellar_sigma_mask integer,
    stellar_sigmacorr real,
    stellar_cont_fresid_68th_percentile real,
    stellar_cont_fresid_99th_percentile real,
    stellar_cont_rchi2 real,
    emline_sflux_oiid_3728 real,
    emline_sflux_hb_4862 real,
    emline_sflux_oiii_4960 real,
    emline_sflux_oiii_5008 real,
    emline_sflux_oi_6302 real,
    emline_sflux_oi_6365 real,
    emline_sflux_nii_6549 real,
    emline_sflux_ha_6564 real,
    emline_sflux_nii_6585 real,
    emline_sflux_sii_6718 real,
    emline_sflux_sii_6732 real,
    emline_sflux_oii_3727 real,
    emline_sflux_oii_3729 real,
    emline_sflux_heps_3971 real,
    emline_sflux_hdel_4102 real,
    emline_sflux_hgam_4341 real,
    emline_sflux_heii_4687 real,
    emline_sflux_hei_5877 real,
    emline_sflux_siii_8831 real,
    emline_sflux_siii_9071 real,
    emline_sflux_siii_9533 real,
    emline_sflux_ivar_oiid_3728 double precision,
    emline_sflux_ivar_hb_4862 double precision,
    emline_sflux_ivar_oiii_4960 double precision,
    emline_sflux_ivar_oiii_5008 double precision,
    emline_sflux_ivar_oi_6302 double precision,
    emline_sflux_ivar_oi_6365 double precision,
    emline_sflux_ivar_nii_6549 double precision,
    emline_sflux_ivar_ha_6564 double precision,
    emline_sflux_ivar_nii_6585 double precision,
    emline_sflux_ivar_sii_6718 double precision,
    emline_sflux_ivar_sii_6732 double precision,
    emline_sflux_ivar_oii_3727 double precision,
    emline_sflux_ivar_oii_3729 double precision,
    emline_sflux_ivar_heps_3971 double precision,
    emline_sflux_ivar_hdel_4102 double precision,
    emline_sflux_ivar_hgam_4341 double precision,
    emline_sflux_ivar_heii_4687 double precision,
    emline_sflux_ivar_hei_5877 double precision,
    emline_sflux_ivar_siii_8831 double precision,
    emline_sflux_ivar_siii_9071 double precision,
    emline_sflux_ivar_siii_9533 double precision,
    emline_sflux_mask_oiid_3728 integer,
    emline_sflux_mask_hb_4862 integer,
    emline_sflux_mask_oiii_4960 integer,
    emline_sflux_mask_oiii_5008 integer,
    emline_sflux_mask_oi_6302 integer,
    emline_sflux_mask_oi_6365 integer,
    emline_sflux_mask_nii_6549 integer,
    emline_sflux_mask_ha_6564 integer,
    emline_sflux_mask_nii_6585 integer,
    emline_sflux_mask_sii_6718 integer,
    emline_sflux_mask_sii_6732 integer,
    emline_sflux_mask_oii_3727 integer,
    emline_sflux_mask_oii_3729 integer,
    emline_sflux_mask_heps_3971 integer,
    emline_sflux_mask_hdel_4102 integer,
    emline_sflux_mask_hgam_4341 integer,
    emline_sflux_mask_heii_4687 integer,
    emline_sflux_mask_hei_5877 integer,
    emline_sflux_mask_siii_8831 integer,
    emline_sflux_mask_siii_9071 integer,
    emline_sflux_mask_siii_9533 integer,
    emline_sew_oiid_3728 double precision,
    emline_sew_hb_4862 double precision,
    emline_sew_oiii_4960 double precision,
    emline_sew_oiii_5008 double precision,
    emline_sew_oi_6302 double precision,
    emline_sew_oi_6365 double precision,
    emline_sew_nii_6549 double precision,
    emline_sew_ha_6564 double precision,
    emline_sew_nii_6585 double precision,
    emline_sew_sii_6718 double precision,
    emline_sew_sii_6732 double precision,
    emline_sew_oii_3727 double precision,
    emline_sew_oii_3729 double precision,
    emline_sew_heps_3971 double precision,
    emline_sew_hdel_4102 double precision,
    emline_sew_hgam_4341 double precision,
    emline_sew_heii_4687 double precision,
    emline_sew_hei_5877 double precision,
    emline_sew_siii_8831 double precision,
    emline_sew_siii_9071 double precision,
    emline_sew_siii_9533 double precision,
    emline_sew_ivar_oiid_3728 double precision,
    emline_sew_ivar_hb_4862 double precision,
    emline_sew_ivar_oiii_4960 double precision,
    emline_sew_ivar_oiii_5008 double precision,
    emline_sew_ivar_oi_6302 double precision,
    emline_sew_ivar_oi_6365 double precision,
    emline_sew_ivar_nii_6549 double precision,
    emline_sew_ivar_ha_6564 double precision,
    emline_sew_ivar_nii_6585 double precision,
    emline_sew_ivar_sii_6718 double precision,
    emline_sew_ivar_sii_6732 double precision,
    emline_sew_ivar_oii_3727 double precision,
    emline_sew_ivar_oii_3729 double precision,
    emline_sew_ivar_heps_3971 double precision,
    emline_sew_ivar_hdel_4102 double precision,
    emline_sew_ivar_hgam_4341 double precision,
    emline_sew_ivar_heii_4687 double precision,
    emline_sew_ivar_hei_5877 double precision,
    emline_sew_ivar_siii_8831 double precision,
    emline_sew_ivar_siii_9071 double precision,
    emline_sew_ivar_siii_9533 double precision,
    emline_sew_mask_oiid_3728 integer,
    emline_sew_mask_hb_4862 integer,
    emline_sew_mask_oiii_4960 integer,
    emline_sew_mask_oiii_5008 integer,
    emline_sew_mask_oi_6302 integer,
    emline_sew_mask_oi_6365 integer,
    emline_sew_mask_nii_6549 integer,
    emline_sew_mask_ha_6564 integer,
    emline_sew_mask_nii_6585 integer,
    emline_sew_mask_sii_6718 integer,
    emline_sew_mask_sii_6732 integer,
    emline_sew_mask_oii_3727 integer,
    emline_sew_mask_oii_3729 integer,
    emline_sew_mask_heps_3971 integer,
    emline_sew_mask_hdel_4102 integer,
    emline_sew_mask_hgam_4341 integer,
    emline_sew_mask_heii_4687 integer,
    emline_sew_mask_hei_5877 integer,
    emline_sew_mask_siii_8831 integer,
    emline_sew_mask_siii_9071 integer,
    emline_sew_mask_siii_9533 integer,
    emline_gflux_oiid_3728 real,
    emline_gflux_hb_4862 real,
    emline_gflux_oiii_4960 real,
    emline_gflux_oiii_5008 double precision,
    emline_gflux_oi_6302 real,
    emline_gflux_oi_6365 real,
    emline_gflux_nii_6549 real,
    emline_gflux_ha_6564 double precision,
    emline_gflux_nii_6585 double precision,
    emline_gflux_sii_6718 real,
    emline_gflux_sii_6732 double precision,
    emline_gflux_oii_3727 double precision,
    emline_gflux_oii_3729 real,
    emline_gflux_heps_3971 real,
    emline_gflux_hdel_4102 real,
    emline_gflux_hgam_4341 real,
    emline_gflux_heii_4687 real,
    emline_gflux_hei_5877 real,
    emline_gflux_siii_8831 real,
    emline_gflux_siii_9071 real,
    emline_gflux_siii_9533 real,
    emline_gflux_ivar_oiid_3728 double precision,
    emline_gflux_ivar_hb_4862 double precision,
    emline_gflux_ivar_oiii_4960 double precision,
    emline_gflux_ivar_oiii_5008 double precision,
    emline_gflux_ivar_oi_6302 double precision,
    emline_gflux_ivar_oi_6365 double precision,
    emline_gflux_ivar_nii_6549 double precision,
    emline_gflux_ivar_ha_6564 double precision,
    emline_gflux_ivar_nii_6585 double precision,
    emline_gflux_ivar_sii_6718 double precision,
    emline_gflux_ivar_sii_6732 double precision,
    emline_gflux_ivar_oii_3727 double precision,
    emline_gflux_ivar_oii_3729 double precision,
    emline_gflux_ivar_heps_3971 double precision,
    emline_gflux_ivar_hdel_4102 double precision,
    emline_gflux_ivar_hgam_4341 double precision,
    emline_gflux_ivar_heii_4687 double precision,
    emline_gflux_ivar_hei_5877 double precision,
    emline_gflux_ivar_siii_8831 double precision,
    emline_gflux_ivar_siii_9071 double precision,
    emline_gflux_ivar_siii_9533 double precision,
    emline_gflux_mask_oiid_3728 integer,
    emline_gflux_mask_hb_4862 integer,
    emline_gflux_mask_oiii_4960 integer,
    emline_gflux_mask_oiii_5008 integer,
    emline_gflux_mask_oi_6302 integer,
    emline_gflux_mask_oi_6365 integer,
    emline_gflux_mask_nii_6549 integer,
    emline_gflux_mask_ha_6564 integer,
    emline_gflux_mask_nii_6585 integer,
    emline_gflux_mask_sii_6718 integer,
    emline_gflux_mask_sii_6732 integer,
    emline_gflux_mask_oii_3727 integer,
    emline_gflux_mask_oii_3729 integer,
    emline_gflux_mask_heps_3971 integer,
    emline_gflux_mask_hdel_4102 integer,
    emline_gflux_mask_hgam_4341 integer,
    emline_gflux_mask_heii_4687 integer,
    emline_gflux_mask_hei_5877 integer,
    emline_gflux_mask_siii_8831 integer,
    emline_gflux_mask_siii_9071 integer,
    emline_gflux_mask_siii_9533 integer,
    emline_gvel_oiid_3728 real,
    emline_gvel_hb_4862 real,
    emline_gvel_oiii_4960 real,
    emline_gvel_oiii_5008 real,
    emline_gvel_oi_6302 real,
    emline_gvel_oi_6365 real,
    emline_gvel_nii_6549 real,
    emline_gvel_ha_6564 real,
    emline_gvel_nii_6585 real,
    emline_gvel_sii_6718 real,
    emline_gvel_sii_6732 real,
    emline_gvel_oii_3727 real,
    emline_gvel_oii_3729 real,
    emline_gvel_heps_3971 real,
    emline_gvel_hdel_4102 real,
    emline_gvel_hgam_4341 real,
    emline_gvel_heii_4687 real,
    emline_gvel_hei_5877 real,
    emline_gvel_siii_8831 real,
    emline_gvel_siii_9071 real,
    emline_gvel_siii_9533 real,
    emline_gvel_ivar_oiid_3728 double precision,
    emline_gvel_ivar_hb_4862 double precision,
    emline_gvel_ivar_oiii_4960 double precision,
    emline_gvel_ivar_oiii_5008 double precision,
    emline_gvel_ivar_oi_6302 double precision,
    emline_gvel_ivar_oi_6365 double precision,
    emline_gvel_ivar_nii_6549 double precision,
    emline_gvel_ivar_ha_6564 double precision,
    emline_gvel_ivar_nii_6585 double precision,
    emline_gvel_ivar_sii_6718 double precision,
    emline_gvel_ivar_sii_6732 double precision,
    emline_gvel_ivar_oii_3727 double precision,
    emline_gvel_ivar_oii_3729 double precision,
    emline_gvel_ivar_heps_3971 double precision,
    emline_gvel_ivar_hdel_4102 double precision,
    emline_gvel_ivar_hgam_4341 double precision,
    emline_gvel_ivar_heii_4687 double precision,
    emline_gvel_ivar_hei_5877 double precision,
    emline_gvel_ivar_siii_8831 double precision,
    emline_gvel_ivar_siii_9071 double precision,
    emline_gvel_ivar_siii_9533 double precision,
    emline_gvel_mask_oiid_3728 integer,
    emline_gvel_mask_hb_4862 integer,
    emline_gvel_mask_oiii_4960 integer,
    emline_gvel_mask_oiii_5008 integer,
    emline_gvel_mask_oi_6302 integer,
    emline_gvel_mask_oi_6365 integer,
    emline_gvel_mask_nii_6549 integer,
    emline_gvel_mask_ha_6564 integer,
    emline_gvel_mask_nii_6585 integer,
    emline_gvel_mask_sii_6718 integer,
    emline_gvel_mask_sii_6732 integer,
    emline_gvel_mask_oii_3727 integer,
    emline_gvel_mask_oii_3729 integer,
    emline_gvel_mask_heps_3971 integer,
    emline_gvel_mask_hdel_4102 integer,
    emline_gvel_mask_hgam_4341 integer,
    emline_gvel_mask_heii_4687 integer,
    emline_gvel_mask_hei_5877 integer,
    emline_gvel_mask_siii_8831 integer,
    emline_gvel_mask_siii_9071 integer,
    emline_gvel_mask_siii_9533 integer,
    emline_gsigma_oiid_3728 real,
    emline_gsigma_hb_4862 real,
    emline_gsigma_oiii_4960 real,
    emline_gsigma_oiii_5008 real,
    emline_gsigma_oi_6302 real,
    emline_gsigma_oi_6365 real,
    emline_gsigma_nii_6549 real,
    emline_gsigma_ha_6564 real,
    emline_gsigma_nii_6585 real,
    emline_gsigma_sii_6718 real,
    emline_gsigma_sii_6732 real,
    emline_gsigma_oii_3727 real,
    emline_gsigma_oii_3729 real,
    emline_gsigma_heps_3971 real,
    emline_gsigma_hdel_4102 real,
    emline_gsigma_hgam_4341 real,
    emline_gsigma_heii_4687 real,
    emline_gsigma_hei_5877 real,
    emline_gsigma_siii_8831 real,
    emline_gsigma_siii_9071 real,
    emline_gsigma_siii_9533 real,
    emline_gsigma_ivar_oiid_3728 double precision,
    emline_gsigma_ivar_hb_4862 double precision,
    emline_gsigma_ivar_oiii_4960 double precision,
    emline_gsigma_ivar_oiii_5008 double precision,
    emline_gsigma_ivar_oi_6302 double precision,
    emline_gsigma_ivar_oi_6365 double precision,
    emline_gsigma_ivar_nii_6549 double precision,
    emline_gsigma_ivar_ha_6564 double precision,
    emline_gsigma_ivar_nii_6585 double precision,
    emline_gsigma_ivar_sii_6718 double precision,
    emline_gsigma_ivar_sii_6732 double precision,
    emline_gsigma_ivar_oii_3727 double precision,
    emline_gsigma_ivar_oii_3729 double precision,
    emline_gsigma_ivar_heps_3971 double precision,
    emline_gsigma_ivar_hdel_4102 double precision,
    emline_gsigma_ivar_hgam_4341 double precision,
    emline_gsigma_ivar_heii_4687 double precision,
    emline_gsigma_ivar_hei_5877 double precision,
    emline_gsigma_ivar_siii_8831 double precision,
    emline_gsigma_ivar_siii_9071 double precision,
    emline_gsigma_ivar_siii_9533 double precision,
    emline_gsigma_mask_oiid_3728 integer,
    emline_gsigma_mask_hb_4862 integer,
    emline_gsigma_mask_oiii_4960 integer,
    emline_gsigma_mask_oiii_5008 integer,
    emline_gsigma_mask_oi_6302 integer,
    emline_gsigma_mask_oi_6365 integer,
    emline_gsigma_mask_nii_6549 integer,
    emline_gsigma_mask_ha_6564 integer,
    emline_gsigma_mask_nii_6585 integer,
    emline_gsigma_mask_sii_6718 integer,
    emline_gsigma_mask_sii_6732 integer,
    emline_gsigma_mask_oii_3727 integer,
    emline_gsigma_mask_oii_3729 integer,
    emline_gsigma_mask_heps_3971 integer,
    emline_gsigma_mask_hdel_4102 integer,
    emline_gsigma_mask_hgam_4341 integer,
    emline_gsigma_mask_heii_4687 integer,
    emline_gsigma_mask_hei_5877 integer,
    emline_gsigma_mask_siii_8831 integer,
    emline_gsigma_mask_siii_9071 integer,
    emline_gsigma_mask_siii_9533 integer,
    emline_instsigma_oiid_3728 real,
    emline_instsigma_hb_4862 real,
    emline_instsigma_oiii_4960 real,
    emline_instsigma_oiii_5008 real,
    emline_instsigma_oi_6302 real,
    emline_instsigma_oi_6365 real,
    emline_instsigma_nii_6549 real,
    emline_instsigma_ha_6564 real,
    emline_instsigma_nii_6585 real,
    emline_instsigma_sii_6718 real,
    emline_instsigma_sii_6732 real,
    emline_instsigma_oii_3727 real,
    emline_instsigma_oii_3729 real,
    emline_instsigma_heps_3971 real,
    emline_instsigma_hdel_4102 real,
    emline_instsigma_hgam_4341 real,
    emline_instsigma_heii_4687 real,
    emline_instsigma_hei_5877 real,
    emline_instsigma_siii_8831 real,
    emline_instsigma_siii_9071 real,
    emline_instsigma_siii_9533 real,
    specindex_d4000 real,
    specindex_dn4000 real,
    specindex_ivar_d4000 double precision,
    specindex_ivar_dn4000 double precision,
    specindex_mask_d4000 integer,
    specindex_mask_dn4000 integer,
    specindex_corr_d4000 real,
    specindex_corr_dn4000 real,
    x integer,
    y integer
);


ALTER TABLE cleanspaxelprop5 OWNER TO manga;

--
-- Name: cleanspaxelprop_old; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE cleanspaxelprop_old (
    pk bigint,
    file_pk integer,
    spaxel_index integer,
    binid_pk integer,
    emline_gflux_oiid_3728 real,
    emline_gflux_hb_4862 real,
    emline_gflux_oiii_4960 real,
    emline_gflux_oiii_5008 real,
    emline_gflux_oi_6302 real,
    emline_gflux_oi_6365 real,
    emline_gflux_nii_6549 real,
    emline_gflux_ha_6564 real,
    emline_gflux_nii_6585 real,
    emline_gflux_sii_6718 real,
    emline_gflux_sii_6732 real,
    emline_gflux_ivar_oiid_3728 double precision,
    emline_gflux_ivar_hb_4862 double precision,
    emline_gflux_ivar_oiii_4960 double precision,
    emline_gflux_ivar_oiii_5008 double precision,
    emline_gflux_ivar_oi_6302 double precision,
    emline_gflux_ivar_oi_6365 double precision,
    emline_gflux_ivar_nii_6549 double precision,
    emline_gflux_ivar_ha_6564 double precision,
    emline_gflux_ivar_nii_6585 double precision,
    emline_gflux_ivar_sii_6718 double precision,
    emline_gflux_ivar_sii_6732 double precision,
    emline_gflux_mask_oiid_3728 integer,
    emline_gflux_mask_hb_4862 integer,
    emline_gflux_mask_oiii_4960 integer,
    emline_gflux_mask_oiii_5008 integer,
    emline_gflux_mask_oi_6302 integer,
    emline_gflux_mask_oi_6365 integer,
    emline_gflux_mask_nii_6549 integer,
    emline_gflux_mask_ha_6564 integer,
    emline_gflux_mask_nii_6585 integer,
    emline_gflux_mask_sii_6718 integer,
    emline_gflux_mask_sii_6732 integer,
    emline_gvel_oiid_3728 real,
    emline_gvel_hb_4862 real,
    emline_gvel_oiii_4960 real,
    emline_gvel_oiii_5008 real,
    emline_gvel_oi_6302 real,
    emline_gvel_oi_6365 real,
    emline_gvel_nii_6549 real,
    emline_gvel_ha_6564 real,
    emline_gvel_nii_6585 real,
    emline_gvel_sii_6718 real,
    emline_gvel_sii_6732 real,
    emline_gvel_ivar_oiid_3728 double precision,
    emline_gvel_ivar_hb_4862 double precision,
    emline_gvel_ivar_oiii_4960 double precision,
    emline_gvel_ivar_oiii_5008 double precision,
    emline_gvel_ivar_oi_6302 double precision,
    emline_gvel_ivar_oi_6365 double precision,
    emline_gvel_ivar_nii_6549 double precision,
    emline_gvel_ivar_ha_6564 double precision,
    emline_gvel_ivar_nii_6585 double precision,
    emline_gvel_ivar_sii_6718 double precision,
    emline_gvel_ivar_sii_6732 double precision,
    emline_gvel_mask_oiid_3728 integer,
    emline_gvel_mask_hb_4862 integer,
    emline_gvel_mask_oiii_4960 integer,
    emline_gvel_mask_oiii_5008 integer,
    emline_gvel_mask_oi_6302 integer,
    emline_gvel_mask_oi_6365 integer,
    emline_gvel_mask_nii_6549 integer,
    emline_gvel_mask_ha_6564 integer,
    emline_gvel_mask_nii_6585 integer,
    emline_gvel_mask_sii_6718 integer,
    emline_gvel_mask_sii_6732 integer,
    emline_gsigma_oiid_3728 real,
    emline_gsigma_hb_4862 real,
    emline_gsigma_oiii_4960 real,
    emline_gsigma_oiii_5008 real,
    emline_gsigma_oi_6302 real,
    emline_gsigma_oi_6365 real,
    emline_gsigma_nii_6549 real,
    emline_gsigma_ha_6564 real,
    emline_gsigma_nii_6585 real,
    emline_gsigma_sii_6718 real,
    emline_gsigma_sii_6732 real,
    emline_gsigma_ivar_oiid_3728 double precision,
    emline_gsigma_ivar_hb_4862 double precision,
    emline_gsigma_ivar_oiii_4960 double precision,
    emline_gsigma_ivar_oiii_5008 double precision,
    emline_gsigma_ivar_oi_6302 double precision,
    emline_gsigma_ivar_oi_6365 double precision,
    emline_gsigma_ivar_nii_6549 double precision,
    emline_gsigma_ivar_ha_6564 double precision,
    emline_gsigma_ivar_nii_6585 double precision,
    emline_gsigma_ivar_sii_6718 double precision,
    emline_gsigma_ivar_sii_6732 double precision,
    emline_gsigma_mask_oiid_3728 integer,
    emline_gsigma_mask_hb_4862 integer,
    emline_gsigma_mask_oiii_4960 integer,
    emline_gsigma_mask_oiii_5008 integer,
    emline_gsigma_mask_oi_6302 integer,
    emline_gsigma_mask_oi_6365 integer,
    emline_gsigma_mask_nii_6549 integer,
    emline_gsigma_mask_ha_6564 integer,
    emline_gsigma_mask_nii_6585 integer,
    emline_gsigma_mask_sii_6718 integer,
    emline_gsigma_mask_sii_6732 integer,
    emline_instsigma_oiid_3728 real,
    emline_instsigma_hb_4862 real,
    emline_instsigma_oiii_4960 real,
    emline_instsigma_oiii_5008 real,
    emline_instsigma_oi_6302 real,
    emline_instsigma_oi_6365 real,
    emline_instsigma_nii_6549 real,
    emline_instsigma_ha_6564 real,
    emline_instsigma_nii_6585 real,
    emline_instsigma_sii_6718 real,
    emline_instsigma_sii_6732 real,
    emline_ew_oiid_3728 real,
    emline_ew_hb_4862 double precision,
    emline_ew_oiii_4960 real,
    emline_ew_oiii_5008 double precision,
    emline_ew_oi_6302 double precision,
    emline_ew_oi_6365 double precision,
    emline_ew_nii_6549 double precision,
    emline_ew_ha_6564 double precision,
    emline_ew_nii_6585 double precision,
    emline_ew_sii_6718 real,
    emline_ew_sii_6732 real,
    emline_ew_ivar_oiid_3728 double precision,
    emline_ew_ivar_hb_4862 double precision,
    emline_ew_ivar_oiii_4960 double precision,
    emline_ew_ivar_oiii_5008 double precision,
    emline_ew_ivar_oi_6302 double precision,
    emline_ew_ivar_oi_6365 double precision,
    emline_ew_ivar_nii_6549 double precision,
    emline_ew_ivar_ha_6564 double precision,
    emline_ew_ivar_nii_6585 double precision,
    emline_ew_ivar_sii_6718 double precision,
    emline_ew_ivar_sii_6732 double precision,
    emline_ew_mask_oiid_3728 integer,
    emline_ew_mask_hb_4862 integer,
    emline_ew_mask_oiii_4960 integer,
    emline_ew_mask_oiii_5008 integer,
    emline_ew_mask_oi_6302 integer,
    emline_ew_mask_oi_6365 integer,
    emline_ew_mask_nii_6549 integer,
    emline_ew_mask_ha_6564 integer,
    emline_ew_mask_nii_6585 integer,
    emline_ew_mask_sii_6718 integer,
    emline_ew_mask_sii_6732 integer,
    emline_sflux_oiid_3728 real,
    emline_sflux_hb_4862 real,
    emline_sflux_oiii_4960 real,
    emline_sflux_oiii_5008 real,
    emline_sflux_oi_6302 real,
    emline_sflux_oi_6365 real,
    emline_sflux_nii_6549 real,
    emline_sflux_ha_6564 real,
    emline_sflux_nii_6585 real,
    emline_sflux_sii_6718 real,
    emline_sflux_sii_6732 real,
    emline_sflux_ivar_oiid_3728 double precision,
    emline_sflux_ivar_hb_4862 double precision,
    emline_sflux_ivar_oiii_4960 double precision,
    emline_sflux_ivar_oiii_5008 double precision,
    emline_sflux_ivar_oi_6302 double precision,
    emline_sflux_ivar_oi_6365 double precision,
    emline_sflux_ivar_nii_6549 double precision,
    emline_sflux_ivar_ha_6564 double precision,
    emline_sflux_ivar_nii_6585 double precision,
    emline_sflux_ivar_sii_6718 double precision,
    emline_sflux_ivar_sii_6732 double precision,
    emline_sflux_mask_oiid_3728 integer,
    emline_sflux_mask_hb_4862 integer,
    emline_sflux_mask_oiii_4960 integer,
    emline_sflux_mask_oiii_5008 integer,
    emline_sflux_mask_oi_6302 integer,
    emline_sflux_mask_oi_6365 integer,
    emline_sflux_mask_nii_6549 integer,
    emline_sflux_mask_ha_6564 integer,
    emline_sflux_mask_nii_6585 integer,
    emline_sflux_mask_sii_6718 integer,
    emline_sflux_mask_sii_6732 integer,
    stellar_vel real,
    stellar_vel_ivar double precision,
    stellar_vel_mask integer,
    stellar_sigma real,
    stellar_sigma_ivar double precision,
    stellar_sigma_mask integer,
    specindex_d4000 real,
    specindex_caii0p39 real,
    specindex_hdeltaa real,
    specindex_cn1 real,
    specindex_cn2 real,
    specindex_ca4227 real,
    specindex_hgammaa real,
    specindex_fe4668 real,
    specindex_hb real,
    specindex_mgb real,
    specindex_fe5270 real,
    specindex_fe5335 real,
    specindex_fe5406 real,
    specindex_nad real,
    specindex_tio1 real,
    specindex_tio2 real,
    specindex_nai0p82 real,
    specindex_caii0p86a real,
    specindex_caii0p86b real,
    specindex_caii0p86c real,
    specindex_mgi0p88 real,
    specindex_tio0p89 real,
    specindex_feh0p99 real,
    specindex_ivar_d4000 double precision,
    specindex_ivar_caii0p39 double precision,
    specindex_ivar_hdeltaa double precision,
    specindex_ivar_cn1 double precision,
    specindex_ivar_cn2 double precision,
    specindex_ivar_ca4227 double precision,
    specindex_ivar_hgammaa double precision,
    specindex_ivar_fe4668 double precision,
    specindex_ivar_hb double precision,
    specindex_ivar_mgb double precision,
    specindex_ivar_fe5270 double precision,
    specindex_ivar_fe5335 double precision,
    specindex_ivar_fe5406 double precision,
    specindex_ivar_nad double precision,
    specindex_ivar_tio1 double precision,
    specindex_ivar_tio2 double precision,
    specindex_ivar_nai0p82 double precision,
    specindex_ivar_caii0p86a double precision,
    specindex_ivar_caii0p86b double precision,
    specindex_ivar_caii0p86c double precision,
    specindex_ivar_mgi0p88 double precision,
    specindex_ivar_tio0p89 double precision,
    specindex_ivar_feh0p99 double precision,
    specindex_mask_d4000 integer,
    specindex_mask_caii0p39 integer,
    specindex_mask_hdeltaa integer,
    specindex_mask_cn1 integer,
    specindex_mask_cn2 integer,
    specindex_mask_ca4227 integer,
    specindex_mask_hgammaa integer,
    specindex_mask_fe4668 integer,
    specindex_mask_hb integer,
    specindex_mask_mgb integer,
    specindex_mask_fe5270 integer,
    specindex_mask_fe5335 integer,
    specindex_mask_fe5406 integer,
    specindex_mask_nad integer,
    specindex_mask_tio1 integer,
    specindex_mask_tio2 integer,
    specindex_mask_nai0p82 integer,
    specindex_mask_caii0p86a integer,
    specindex_mask_caii0p86b integer,
    specindex_mask_caii0p86c integer,
    specindex_mask_mgi0p88 integer,
    specindex_mask_tio0p89 integer,
    specindex_mask_feh0p99 integer,
    binid integer,
    x integer,
    y integer
);


ALTER TABLE cleanspaxelprop_old OWNER TO manga;

--
-- Name: current_default; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE current_default (
    pk integer NOT NULL,
    filename text,
    filepath text,
    file_pk integer
);


ALTER TABLE current_default OWNER TO manga;

--
-- Name: current_default_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE current_default_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE current_default_pk_seq OWNER TO manga;

--
-- Name: current_default_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE current_default_pk_seq OWNED BY current_default.pk;


--
-- Name: executionplan; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE executionplan (
    pk integer NOT NULL,
    id integer,
    comments text
);


ALTER TABLE executionplan OWNER TO manga;

--
-- Name: executionplan_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE executionplan_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE executionplan_pk_seq OWNER TO manga;

--
-- Name: executionplan_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE executionplan_pk_seq OWNED BY executionplan.pk;


--
-- Name: extcol; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE extcol (
    pk integer NOT NULL,
    name text
);


ALTER TABLE extcol OWNER TO manga;

--
-- Name: extcol_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE extcol_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE extcol_pk_seq OWNER TO manga;

--
-- Name: extcol_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE extcol_pk_seq OWNED BY extcol.pk;


--
-- Name: extname; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE extname (
    pk integer NOT NULL,
    name text
);


ALTER TABLE extname OWNER TO manga;

--
-- Name: extname_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE extname_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE extname_pk_seq OWNER TO manga;

--
-- Name: extname_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE extname_pk_seq OWNED BY extname.pk;


--
-- Name: exttype; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE exttype (
    pk integer NOT NULL,
    name text
);


ALTER TABLE exttype OWNER TO manga;

--
-- Name: exttype_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE exttype_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exttype_pk_seq OWNER TO manga;

--
-- Name: exttype_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE exttype_pk_seq OWNED BY exttype.pk;


--
-- Name: file; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE file (
    pk integer NOT NULL,
    filename text,
    filepath text,
    num_ext integer,
    filetype_pk integer,
    structure_pk integer,
    cube_pk integer,
    pipeline_info_pk integer
);


ALTER TABLE file OWNER TO manga;

--
-- Name: file_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE file_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE file_pk_seq OWNER TO manga;

--
-- Name: file_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE file_pk_seq OWNED BY file.pk;


--
-- Name: filetype; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE filetype (
    pk integer NOT NULL,
    value text
);


ALTER TABLE filetype OWNER TO manga;

--
-- Name: filetype_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE filetype_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE filetype_pk_seq OWNER TO manga;

--
-- Name: filetype_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE filetype_pk_seq OWNED BY filetype.pk;


--
-- Name: flattabletest; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE flattabletest (
    drppipe integer,
    dappipe integer,
    plate integer,
    mangaid text,
    name text,
    plateifu text,
    nsa_pk integer,
    pk bigint NOT NULL,
    file_pk integer,
    spaxel_index integer,
    binid_pk integer,
    spx_skycoo_on_sky_x real,
    spx_skycoo_on_sky_y real,
    spx_ellcoo_elliptical_radius real,
    spx_ellcoo_elliptical_azimuth real,
    spx_mflux real,
    spx_mflux_ivar double precision,
    spx_snr real,
    binid integer,
    bin_lwskycoo_lum_weighted_on_sky_x real,
    bin_lwskycoo_lum_weighted_on_sky_y real,
    bin_lwellcoo_lum_weighted_elliptical_radius real,
    bin_lwellcoo_lum_weighted_elliptical_azimuth real,
    bin_area real,
    bin_farea real,
    bin_mflux real,
    bin_mflux_ivar double precision,
    bin_mflux_mask integer,
    bin_snr real,
    stellar_vel real,
    stellar_vel_ivar double precision,
    stellar_vel_mask integer,
    stellar_sigma real,
    stellar_sigma_ivar double precision,
    stellar_sigma_mask integer,
    stellar_sigmacorr real,
    stellar_cont_fresid_68th_percentile real,
    stellar_cont_fresid_99th_percentile real,
    stellar_cont_rchi2 real,
    emline_sflux_oiid_3728 real,
    emline_sflux_hb_4862 real,
    emline_sflux_oiii_4960 real,
    emline_sflux_oiii_5008 real,
    emline_sflux_oi_6302 real,
    emline_sflux_oi_6365 real,
    emline_sflux_nii_6549 real,
    emline_sflux_ha_6564 real,
    emline_sflux_nii_6585 real,
    emline_sflux_sii_6718 real,
    emline_sflux_sii_6732 real,
    emline_sflux_oii_3727 real,
    emline_sflux_oii_3729 real,
    emline_sflux_heps_3971 real,
    emline_sflux_hdel_4102 real,
    emline_sflux_hgam_4341 real,
    emline_sflux_heii_4687 real,
    emline_sflux_hei_5877 real,
    emline_sflux_siii_8831 real,
    emline_sflux_siii_9071 real,
    emline_sflux_siii_9533 real,
    emline_sflux_ivar_oiid_3728 double precision,
    emline_sflux_ivar_hb_4862 double precision,
    emline_sflux_ivar_oiii_4960 double precision,
    emline_sflux_ivar_oiii_5008 double precision,
    emline_sflux_ivar_oi_6302 double precision,
    emline_sflux_ivar_oi_6365 double precision,
    emline_sflux_ivar_nii_6549 double precision,
    emline_sflux_ivar_ha_6564 double precision,
    emline_sflux_ivar_nii_6585 double precision,
    emline_sflux_ivar_sii_6718 double precision,
    emline_sflux_ivar_sii_6732 double precision,
    emline_sflux_ivar_oii_3727 double precision,
    emline_sflux_ivar_oii_3729 double precision,
    emline_sflux_ivar_heps_3971 double precision,
    emline_sflux_ivar_hdel_4102 double precision,
    emline_sflux_ivar_hgam_4341 double precision,
    emline_sflux_ivar_heii_4687 double precision,
    emline_sflux_ivar_hei_5877 double precision,
    emline_sflux_ivar_siii_8831 double precision,
    emline_sflux_ivar_siii_9071 double precision,
    emline_sflux_ivar_siii_9533 double precision,
    emline_sflux_mask_oiid_3728 integer,
    emline_sflux_mask_hb_4862 integer,
    emline_sflux_mask_oiii_4960 integer,
    emline_sflux_mask_oiii_5008 integer,
    emline_sflux_mask_oi_6302 integer,
    emline_sflux_mask_oi_6365 integer,
    emline_sflux_mask_nii_6549 integer,
    emline_sflux_mask_ha_6564 integer,
    emline_sflux_mask_nii_6585 integer,
    emline_sflux_mask_sii_6718 integer,
    emline_sflux_mask_sii_6732 integer,
    emline_sflux_mask_oii_3727 integer,
    emline_sflux_mask_oii_3729 integer,
    emline_sflux_mask_heps_3971 integer,
    emline_sflux_mask_hdel_4102 integer,
    emline_sflux_mask_hgam_4341 integer,
    emline_sflux_mask_heii_4687 integer,
    emline_sflux_mask_hei_5877 integer,
    emline_sflux_mask_siii_8831 integer,
    emline_sflux_mask_siii_9071 integer,
    emline_sflux_mask_siii_9533 integer,
    emline_sew_oiid_3728 double precision,
    emline_sew_hb_4862 double precision,
    emline_sew_oiii_4960 double precision,
    emline_sew_oiii_5008 double precision,
    emline_sew_oi_6302 double precision,
    emline_sew_oi_6365 double precision,
    emline_sew_nii_6549 double precision,
    emline_sew_ha_6564 double precision,
    emline_sew_nii_6585 double precision,
    emline_sew_sii_6718 double precision,
    emline_sew_sii_6732 double precision,
    emline_sew_oii_3727 double precision,
    emline_sew_oii_3729 double precision,
    emline_sew_heps_3971 double precision,
    emline_sew_hdel_4102 double precision,
    emline_sew_hgam_4341 double precision,
    emline_sew_heii_4687 double precision,
    emline_sew_hei_5877 double precision,
    emline_sew_siii_8831 double precision,
    emline_sew_siii_9071 double precision,
    emline_sew_siii_9533 double precision,
    emline_sew_ivar_oiid_3728 double precision,
    emline_sew_ivar_hb_4862 double precision,
    emline_sew_ivar_oiii_4960 double precision,
    emline_sew_ivar_oiii_5008 double precision,
    emline_sew_ivar_oi_6302 double precision,
    emline_sew_ivar_oi_6365 double precision,
    emline_sew_ivar_nii_6549 double precision,
    emline_sew_ivar_ha_6564 double precision,
    emline_sew_ivar_nii_6585 double precision,
    emline_sew_ivar_sii_6718 double precision,
    emline_sew_ivar_sii_6732 double precision,
    emline_sew_ivar_oii_3727 double precision,
    emline_sew_ivar_oii_3729 double precision,
    emline_sew_ivar_heps_3971 double precision,
    emline_sew_ivar_hdel_4102 double precision,
    emline_sew_ivar_hgam_4341 double precision,
    emline_sew_ivar_heii_4687 double precision,
    emline_sew_ivar_hei_5877 double precision,
    emline_sew_ivar_siii_8831 double precision,
    emline_sew_ivar_siii_9071 double precision,
    emline_sew_ivar_siii_9533 double precision,
    emline_sew_mask_oiid_3728 integer,
    emline_sew_mask_hb_4862 integer,
    emline_sew_mask_oiii_4960 integer,
    emline_sew_mask_oiii_5008 integer,
    emline_sew_mask_oi_6302 integer,
    emline_sew_mask_oi_6365 integer,
    emline_sew_mask_nii_6549 integer,
    emline_sew_mask_ha_6564 integer,
    emline_sew_mask_nii_6585 integer,
    emline_sew_mask_sii_6718 integer,
    emline_sew_mask_sii_6732 integer,
    emline_sew_mask_oii_3727 integer,
    emline_sew_mask_oii_3729 integer,
    emline_sew_mask_heps_3971 integer,
    emline_sew_mask_hdel_4102 integer,
    emline_sew_mask_hgam_4341 integer,
    emline_sew_mask_heii_4687 integer,
    emline_sew_mask_hei_5877 integer,
    emline_sew_mask_siii_8831 integer,
    emline_sew_mask_siii_9071 integer,
    emline_sew_mask_siii_9533 integer,
    emline_gflux_oiid_3728 real,
    emline_gflux_hb_4862 real,
    emline_gflux_oiii_4960 real,
    emline_gflux_oiii_5008 double precision,
    emline_gflux_oi_6302 real,
    emline_gflux_oi_6365 real,
    emline_gflux_nii_6549 real,
    emline_gflux_ha_6564 double precision,
    emline_gflux_nii_6585 double precision,
    emline_gflux_sii_6718 real,
    emline_gflux_sii_6732 double precision,
    emline_gflux_oii_3727 double precision,
    emline_gflux_oii_3729 real,
    emline_gflux_heps_3971 real,
    emline_gflux_hdel_4102 real,
    emline_gflux_hgam_4341 real,
    emline_gflux_heii_4687 real,
    emline_gflux_hei_5877 real,
    emline_gflux_siii_8831 real,
    emline_gflux_siii_9071 real,
    emline_gflux_siii_9533 real,
    emline_gflux_ivar_oiid_3728 double precision,
    emline_gflux_ivar_hb_4862 double precision,
    emline_gflux_ivar_oiii_4960 double precision,
    emline_gflux_ivar_oiii_5008 double precision,
    emline_gflux_ivar_oi_6302 double precision,
    emline_gflux_ivar_oi_6365 double precision,
    emline_gflux_ivar_nii_6549 double precision,
    emline_gflux_ivar_ha_6564 double precision,
    emline_gflux_ivar_nii_6585 double precision,
    emline_gflux_ivar_sii_6718 double precision,
    emline_gflux_ivar_sii_6732 double precision,
    emline_gflux_ivar_oii_3727 double precision,
    emline_gflux_ivar_oii_3729 double precision,
    emline_gflux_ivar_heps_3971 double precision,
    emline_gflux_ivar_hdel_4102 double precision,
    emline_gflux_ivar_hgam_4341 double precision,
    emline_gflux_ivar_heii_4687 double precision,
    emline_gflux_ivar_hei_5877 double precision,
    emline_gflux_ivar_siii_8831 double precision,
    emline_gflux_ivar_siii_9071 double precision,
    emline_gflux_ivar_siii_9533 double precision,
    emline_gflux_mask_oiid_3728 integer,
    emline_gflux_mask_hb_4862 integer,
    emline_gflux_mask_oiii_4960 integer,
    emline_gflux_mask_oiii_5008 integer,
    emline_gflux_mask_oi_6302 integer,
    emline_gflux_mask_oi_6365 integer,
    emline_gflux_mask_nii_6549 integer,
    emline_gflux_mask_ha_6564 integer,
    emline_gflux_mask_nii_6585 integer,
    emline_gflux_mask_sii_6718 integer,
    emline_gflux_mask_sii_6732 integer,
    emline_gflux_mask_oii_3727 integer,
    emline_gflux_mask_oii_3729 integer,
    emline_gflux_mask_heps_3971 integer,
    emline_gflux_mask_hdel_4102 integer,
    emline_gflux_mask_hgam_4341 integer,
    emline_gflux_mask_heii_4687 integer,
    emline_gflux_mask_hei_5877 integer,
    emline_gflux_mask_siii_8831 integer,
    emline_gflux_mask_siii_9071 integer,
    emline_gflux_mask_siii_9533 integer,
    emline_gvel_oiid_3728 real,
    emline_gvel_hb_4862 real,
    emline_gvel_oiii_4960 real,
    emline_gvel_oiii_5008 real,
    emline_gvel_oi_6302 real,
    emline_gvel_oi_6365 real,
    emline_gvel_nii_6549 real,
    emline_gvel_ha_6564 real,
    emline_gvel_nii_6585 real,
    emline_gvel_sii_6718 real,
    emline_gvel_sii_6732 real,
    emline_gvel_oii_3727 real,
    emline_gvel_oii_3729 real,
    emline_gvel_heps_3971 real,
    emline_gvel_hdel_4102 real,
    emline_gvel_hgam_4341 real,
    emline_gvel_heii_4687 real,
    emline_gvel_hei_5877 real,
    emline_gvel_siii_8831 real,
    emline_gvel_siii_9071 real,
    emline_gvel_siii_9533 real,
    emline_gvel_ivar_oiid_3728 double precision,
    emline_gvel_ivar_hb_4862 double precision,
    emline_gvel_ivar_oiii_4960 double precision,
    emline_gvel_ivar_oiii_5008 double precision,
    emline_gvel_ivar_oi_6302 double precision,
    emline_gvel_ivar_oi_6365 double precision,
    emline_gvel_ivar_nii_6549 double precision,
    emline_gvel_ivar_ha_6564 double precision,
    emline_gvel_ivar_nii_6585 double precision,
    emline_gvel_ivar_sii_6718 double precision,
    emline_gvel_ivar_sii_6732 double precision,
    emline_gvel_ivar_oii_3727 double precision,
    emline_gvel_ivar_oii_3729 double precision,
    emline_gvel_ivar_heps_3971 double precision,
    emline_gvel_ivar_hdel_4102 double precision,
    emline_gvel_ivar_hgam_4341 double precision,
    emline_gvel_ivar_heii_4687 double precision,
    emline_gvel_ivar_hei_5877 double precision,
    emline_gvel_ivar_siii_8831 double precision,
    emline_gvel_ivar_siii_9071 double precision,
    emline_gvel_ivar_siii_9533 double precision,
    emline_gvel_mask_oiid_3728 integer,
    emline_gvel_mask_hb_4862 integer,
    emline_gvel_mask_oiii_4960 integer,
    emline_gvel_mask_oiii_5008 integer,
    emline_gvel_mask_oi_6302 integer,
    emline_gvel_mask_oi_6365 integer,
    emline_gvel_mask_nii_6549 integer,
    emline_gvel_mask_ha_6564 integer,
    emline_gvel_mask_nii_6585 integer,
    emline_gvel_mask_sii_6718 integer,
    emline_gvel_mask_sii_6732 integer,
    emline_gvel_mask_oii_3727 integer,
    emline_gvel_mask_oii_3729 integer,
    emline_gvel_mask_heps_3971 integer,
    emline_gvel_mask_hdel_4102 integer,
    emline_gvel_mask_hgam_4341 integer,
    emline_gvel_mask_heii_4687 integer,
    emline_gvel_mask_hei_5877 integer,
    emline_gvel_mask_siii_8831 integer,
    emline_gvel_mask_siii_9071 integer,
    emline_gvel_mask_siii_9533 integer,
    emline_gsigma_oiid_3728 real,
    emline_gsigma_hb_4862 real,
    emline_gsigma_oiii_4960 real,
    emline_gsigma_oiii_5008 real,
    emline_gsigma_oi_6302 real,
    emline_gsigma_oi_6365 real,
    emline_gsigma_nii_6549 real,
    emline_gsigma_ha_6564 real,
    emline_gsigma_nii_6585 real,
    emline_gsigma_sii_6718 real,
    emline_gsigma_sii_6732 real,
    emline_gsigma_oii_3727 real,
    emline_gsigma_oii_3729 real,
    emline_gsigma_heps_3971 real,
    emline_gsigma_hdel_4102 real,
    emline_gsigma_hgam_4341 real,
    emline_gsigma_heii_4687 real,
    emline_gsigma_hei_5877 real,
    emline_gsigma_siii_8831 real,
    emline_gsigma_siii_9071 real,
    emline_gsigma_siii_9533 real,
    emline_gsigma_ivar_oiid_3728 double precision,
    emline_gsigma_ivar_hb_4862 double precision,
    emline_gsigma_ivar_oiii_4960 double precision,
    emline_gsigma_ivar_oiii_5008 double precision,
    emline_gsigma_ivar_oi_6302 double precision,
    emline_gsigma_ivar_oi_6365 double precision,
    emline_gsigma_ivar_nii_6549 double precision,
    emline_gsigma_ivar_ha_6564 double precision,
    emline_gsigma_ivar_nii_6585 double precision,
    emline_gsigma_ivar_sii_6718 double precision,
    emline_gsigma_ivar_sii_6732 double precision,
    emline_gsigma_ivar_oii_3727 double precision,
    emline_gsigma_ivar_oii_3729 double precision,
    emline_gsigma_ivar_heps_3971 double precision,
    emline_gsigma_ivar_hdel_4102 double precision,
    emline_gsigma_ivar_hgam_4341 double precision,
    emline_gsigma_ivar_heii_4687 double precision,
    emline_gsigma_ivar_hei_5877 double precision,
    emline_gsigma_ivar_siii_8831 double precision,
    emline_gsigma_ivar_siii_9071 double precision,
    emline_gsigma_ivar_siii_9533 double precision,
    emline_gsigma_mask_oiid_3728 integer,
    emline_gsigma_mask_hb_4862 integer,
    emline_gsigma_mask_oiii_4960 integer,
    emline_gsigma_mask_oiii_5008 integer,
    emline_gsigma_mask_oi_6302 integer,
    emline_gsigma_mask_oi_6365 integer,
    emline_gsigma_mask_nii_6549 integer,
    emline_gsigma_mask_ha_6564 integer,
    emline_gsigma_mask_nii_6585 integer,
    emline_gsigma_mask_sii_6718 integer,
    emline_gsigma_mask_sii_6732 integer,
    emline_gsigma_mask_oii_3727 integer,
    emline_gsigma_mask_oii_3729 integer,
    emline_gsigma_mask_heps_3971 integer,
    emline_gsigma_mask_hdel_4102 integer,
    emline_gsigma_mask_hgam_4341 integer,
    emline_gsigma_mask_heii_4687 integer,
    emline_gsigma_mask_hei_5877 integer,
    emline_gsigma_mask_siii_8831 integer,
    emline_gsigma_mask_siii_9071 integer,
    emline_gsigma_mask_siii_9533 integer,
    emline_instsigma_oiid_3728 real,
    emline_instsigma_hb_4862 real,
    emline_instsigma_oiii_4960 real,
    emline_instsigma_oiii_5008 real,
    emline_instsigma_oi_6302 real,
    emline_instsigma_oi_6365 real,
    emline_instsigma_nii_6549 real,
    emline_instsigma_ha_6564 real,
    emline_instsigma_nii_6585 real,
    emline_instsigma_sii_6718 real,
    emline_instsigma_sii_6732 real,
    emline_instsigma_oii_3727 real,
    emline_instsigma_oii_3729 real,
    emline_instsigma_heps_3971 real,
    emline_instsigma_hdel_4102 real,
    emline_instsigma_hgam_4341 real,
    emline_instsigma_heii_4687 real,
    emline_instsigma_hei_5877 real,
    emline_instsigma_siii_8831 real,
    emline_instsigma_siii_9071 real,
    emline_instsigma_siii_9533 real,
    specindex_d4000 real,
    specindex_dn4000 real,
    specindex_ivar_d4000 double precision,
    specindex_ivar_dn4000 double precision,
    specindex_mask_d4000 integer,
    specindex_mask_dn4000 integer,
    specindex_corr_d4000 real,
    specindex_corr_dn4000 real,
    x integer,
    y integer
);


ALTER TABLE flattabletest OWNER TO manga;

--
-- Name: hdu; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE hdu (
    pk integer NOT NULL,
    extname_pk integer,
    exttype_pk integer,
    extno integer,
    file_pk integer
);


ALTER TABLE hdu OWNER TO manga;

--
-- Name: hdu_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE hdu_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hdu_pk_seq OWNER TO manga;

--
-- Name: hdu_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE hdu_pk_seq OWNED BY hdu.pk;


--
-- Name: hdu_to_extcol; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE hdu_to_extcol (
    pk integer NOT NULL,
    hdu_pk integer,
    extcol_pk integer
);


ALTER TABLE hdu_to_extcol OWNER TO manga;

--
-- Name: hdu_to_extcol_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE hdu_to_extcol_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hdu_to_extcol_pk_seq OWNER TO manga;

--
-- Name: hdu_to_extcol_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE hdu_to_extcol_pk_seq OWNED BY hdu_to_extcol.pk;


--
-- Name: hdu_to_header_value; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE hdu_to_header_value (
    pk integer NOT NULL,
    hdu_pk integer,
    header_value_pk integer
);


ALTER TABLE hdu_to_header_value OWNER TO manga;

--
-- Name: hdu_to_header_value_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE hdu_to_header_value_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hdu_to_header_value_pk_seq OWNER TO manga;

--
-- Name: hdu_to_header_value_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE hdu_to_header_value_pk_seq OWNED BY hdu_to_header_value.pk;


--
-- Name: header_keyword; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE header_keyword (
    pk integer NOT NULL,
    name text
);


ALTER TABLE header_keyword OWNER TO manga;

--
-- Name: header_keyword_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE header_keyword_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE header_keyword_pk_seq OWNER TO manga;

--
-- Name: header_keyword_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE header_keyword_pk_seq OWNED BY header_keyword.pk;


--
-- Name: header_value; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE header_value (
    pk integer NOT NULL,
    value text,
    index integer,
    comment text,
    header_keyword_pk integer
);


ALTER TABLE header_value OWNER TO manga;

--
-- Name: header_value_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE header_value_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE header_value_pk_seq OWNER TO manga;

--
-- Name: header_value_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE header_value_pk_seq OWNED BY header_value.pk;


--
-- Name: spaxelprop5; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE spaxelprop5 (
    pk bigint NOT NULL,
    file_pk integer,
    spaxel_index integer,
    binid_pk integer,
    spx_skycoo_on_sky_x real,
    spx_skycoo_on_sky_y real,
    spx_ellcoo_elliptical_radius real,
    spx_ellcoo_elliptical_azimuth real,
    spx_mflux real,
    spx_mflux_ivar double precision,
    spx_snr real,
    binid integer,
    bin_lwskycoo_lum_weighted_on_sky_x real,
    bin_lwskycoo_lum_weighted_on_sky_y real,
    bin_lwellcoo_lum_weighted_elliptical_radius real,
    bin_lwellcoo_lum_weighted_elliptical_azimuth real,
    bin_area real,
    bin_farea real,
    bin_mflux real,
    bin_mflux_ivar double precision,
    bin_mflux_mask integer,
    bin_snr real,
    stellar_vel real,
    stellar_vel_ivar double precision,
    stellar_vel_mask integer,
    stellar_sigma real,
    stellar_sigma_ivar double precision,
    stellar_sigma_mask integer,
    stellar_sigmacorr real,
    stellar_cont_fresid_68th_percentile real,
    stellar_cont_fresid_99th_percentile real,
    stellar_cont_rchi2 real,
    emline_sflux_oiid_3728 real,
    emline_sflux_hb_4862 real,
    emline_sflux_oiii_4960 real,
    emline_sflux_oiii_5008 real,
    emline_sflux_oi_6302 real,
    emline_sflux_oi_6365 real,
    emline_sflux_nii_6549 real,
    emline_sflux_ha_6564 real,
    emline_sflux_nii_6585 real,
    emline_sflux_sii_6718 real,
    emline_sflux_sii_6732 real,
    emline_sflux_oii_3727 real,
    emline_sflux_oii_3729 real,
    emline_sflux_heps_3971 real,
    emline_sflux_hdel_4102 real,
    emline_sflux_hgam_4341 real,
    emline_sflux_heii_4687 real,
    emline_sflux_hei_5877 real,
    emline_sflux_siii_8831 real,
    emline_sflux_siii_9071 real,
    emline_sflux_siii_9533 real,
    emline_sflux_ivar_oiid_3728 double precision,
    emline_sflux_ivar_hb_4862 double precision,
    emline_sflux_ivar_oiii_4960 double precision,
    emline_sflux_ivar_oiii_5008 double precision,
    emline_sflux_ivar_oi_6302 double precision,
    emline_sflux_ivar_oi_6365 double precision,
    emline_sflux_ivar_nii_6549 double precision,
    emline_sflux_ivar_ha_6564 double precision,
    emline_sflux_ivar_nii_6585 double precision,
    emline_sflux_ivar_sii_6718 double precision,
    emline_sflux_ivar_sii_6732 double precision,
    emline_sflux_ivar_oii_3727 double precision,
    emline_sflux_ivar_oii_3729 double precision,
    emline_sflux_ivar_heps_3971 double precision,
    emline_sflux_ivar_hdel_4102 double precision,
    emline_sflux_ivar_hgam_4341 double precision,
    emline_sflux_ivar_heii_4687 double precision,
    emline_sflux_ivar_hei_5877 double precision,
    emline_sflux_ivar_siii_8831 double precision,
    emline_sflux_ivar_siii_9071 double precision,
    emline_sflux_ivar_siii_9533 double precision,
    emline_sflux_mask_oiid_3728 integer,
    emline_sflux_mask_hb_4862 integer,
    emline_sflux_mask_oiii_4960 integer,
    emline_sflux_mask_oiii_5008 integer,
    emline_sflux_mask_oi_6302 integer,
    emline_sflux_mask_oi_6365 integer,
    emline_sflux_mask_nii_6549 integer,
    emline_sflux_mask_ha_6564 integer,
    emline_sflux_mask_nii_6585 integer,
    emline_sflux_mask_sii_6718 integer,
    emline_sflux_mask_sii_6732 integer,
    emline_sflux_mask_oii_3727 integer,
    emline_sflux_mask_oii_3729 integer,
    emline_sflux_mask_heps_3971 integer,
    emline_sflux_mask_hdel_4102 integer,
    emline_sflux_mask_hgam_4341 integer,
    emline_sflux_mask_heii_4687 integer,
    emline_sflux_mask_hei_5877 integer,
    emline_sflux_mask_siii_8831 integer,
    emline_sflux_mask_siii_9071 integer,
    emline_sflux_mask_siii_9533 integer,
    emline_sew_oiid_3728 double precision,
    emline_sew_hb_4862 double precision,
    emline_sew_oiii_4960 double precision,
    emline_sew_oiii_5008 double precision,
    emline_sew_oi_6302 double precision,
    emline_sew_oi_6365 double precision,
    emline_sew_nii_6549 double precision,
    emline_sew_ha_6564 double precision,
    emline_sew_nii_6585 double precision,
    emline_sew_sii_6718 double precision,
    emline_sew_sii_6732 double precision,
    emline_sew_oii_3727 double precision,
    emline_sew_oii_3729 double precision,
    emline_sew_heps_3971 double precision,
    emline_sew_hdel_4102 double precision,
    emline_sew_hgam_4341 double precision,
    emline_sew_heii_4687 double precision,
    emline_sew_hei_5877 double precision,
    emline_sew_siii_8831 double precision,
    emline_sew_siii_9071 double precision,
    emline_sew_siii_9533 double precision,
    emline_sew_ivar_oiid_3728 double precision,
    emline_sew_ivar_hb_4862 double precision,
    emline_sew_ivar_oiii_4960 double precision,
    emline_sew_ivar_oiii_5008 double precision,
    emline_sew_ivar_oi_6302 double precision,
    emline_sew_ivar_oi_6365 double precision,
    emline_sew_ivar_nii_6549 double precision,
    emline_sew_ivar_ha_6564 double precision,
    emline_sew_ivar_nii_6585 double precision,
    emline_sew_ivar_sii_6718 double precision,
    emline_sew_ivar_sii_6732 double precision,
    emline_sew_ivar_oii_3727 double precision,
    emline_sew_ivar_oii_3729 double precision,
    emline_sew_ivar_heps_3971 double precision,
    emline_sew_ivar_hdel_4102 double precision,
    emline_sew_ivar_hgam_4341 double precision,
    emline_sew_ivar_heii_4687 double precision,
    emline_sew_ivar_hei_5877 double precision,
    emline_sew_ivar_siii_8831 double precision,
    emline_sew_ivar_siii_9071 double precision,
    emline_sew_ivar_siii_9533 double precision,
    emline_sew_mask_oiid_3728 integer,
    emline_sew_mask_hb_4862 integer,
    emline_sew_mask_oiii_4960 integer,
    emline_sew_mask_oiii_5008 integer,
    emline_sew_mask_oi_6302 integer,
    emline_sew_mask_oi_6365 integer,
    emline_sew_mask_nii_6549 integer,
    emline_sew_mask_ha_6564 integer,
    emline_sew_mask_nii_6585 integer,
    emline_sew_mask_sii_6718 integer,
    emline_sew_mask_sii_6732 integer,
    emline_sew_mask_oii_3727 integer,
    emline_sew_mask_oii_3729 integer,
    emline_sew_mask_heps_3971 integer,
    emline_sew_mask_hdel_4102 integer,
    emline_sew_mask_hgam_4341 integer,
    emline_sew_mask_heii_4687 integer,
    emline_sew_mask_hei_5877 integer,
    emline_sew_mask_siii_8831 integer,
    emline_sew_mask_siii_9071 integer,
    emline_sew_mask_siii_9533 integer,
    emline_gflux_oiid_3728 real,
    emline_gflux_hb_4862 real,
    emline_gflux_oiii_4960 real,
    emline_gflux_oiii_5008 double precision,
    emline_gflux_oi_6302 real,
    emline_gflux_oi_6365 real,
    emline_gflux_nii_6549 real,
    emline_gflux_ha_6564 double precision,
    emline_gflux_nii_6585 double precision,
    emline_gflux_sii_6718 real,
    emline_gflux_sii_6732 double precision,
    emline_gflux_oii_3727 double precision,
    emline_gflux_oii_3729 real,
    emline_gflux_heps_3971 real,
    emline_gflux_hdel_4102 real,
    emline_gflux_hgam_4341 real,
    emline_gflux_heii_4687 real,
    emline_gflux_hei_5877 real,
    emline_gflux_siii_8831 real,
    emline_gflux_siii_9071 real,
    emline_gflux_siii_9533 real,
    emline_gflux_ivar_oiid_3728 double precision,
    emline_gflux_ivar_hb_4862 double precision,
    emline_gflux_ivar_oiii_4960 double precision,
    emline_gflux_ivar_oiii_5008 double precision,
    emline_gflux_ivar_oi_6302 double precision,
    emline_gflux_ivar_oi_6365 double precision,
    emline_gflux_ivar_nii_6549 double precision,
    emline_gflux_ivar_ha_6564 double precision,
    emline_gflux_ivar_nii_6585 double precision,
    emline_gflux_ivar_sii_6718 double precision,
    emline_gflux_ivar_sii_6732 double precision,
    emline_gflux_ivar_oii_3727 double precision,
    emline_gflux_ivar_oii_3729 double precision,
    emline_gflux_ivar_heps_3971 double precision,
    emline_gflux_ivar_hdel_4102 double precision,
    emline_gflux_ivar_hgam_4341 double precision,
    emline_gflux_ivar_heii_4687 double precision,
    emline_gflux_ivar_hei_5877 double precision,
    emline_gflux_ivar_siii_8831 double precision,
    emline_gflux_ivar_siii_9071 double precision,
    emline_gflux_ivar_siii_9533 double precision,
    emline_gflux_mask_oiid_3728 integer,
    emline_gflux_mask_hb_4862 integer,
    emline_gflux_mask_oiii_4960 integer,
    emline_gflux_mask_oiii_5008 integer,
    emline_gflux_mask_oi_6302 integer,
    emline_gflux_mask_oi_6365 integer,
    emline_gflux_mask_nii_6549 integer,
    emline_gflux_mask_ha_6564 integer,
    emline_gflux_mask_nii_6585 integer,
    emline_gflux_mask_sii_6718 integer,
    emline_gflux_mask_sii_6732 integer,
    emline_gflux_mask_oii_3727 integer,
    emline_gflux_mask_oii_3729 integer,
    emline_gflux_mask_heps_3971 integer,
    emline_gflux_mask_hdel_4102 integer,
    emline_gflux_mask_hgam_4341 integer,
    emline_gflux_mask_heii_4687 integer,
    emline_gflux_mask_hei_5877 integer,
    emline_gflux_mask_siii_8831 integer,
    emline_gflux_mask_siii_9071 integer,
    emline_gflux_mask_siii_9533 integer,
    emline_gvel_oiid_3728 real,
    emline_gvel_hb_4862 real,
    emline_gvel_oiii_4960 real,
    emline_gvel_oiii_5008 real,
    emline_gvel_oi_6302 real,
    emline_gvel_oi_6365 real,
    emline_gvel_nii_6549 real,
    emline_gvel_ha_6564 real,
    emline_gvel_nii_6585 real,
    emline_gvel_sii_6718 real,
    emline_gvel_sii_6732 real,
    emline_gvel_oii_3727 real,
    emline_gvel_oii_3729 real,
    emline_gvel_heps_3971 real,
    emline_gvel_hdel_4102 real,
    emline_gvel_hgam_4341 real,
    emline_gvel_heii_4687 real,
    emline_gvel_hei_5877 real,
    emline_gvel_siii_8831 real,
    emline_gvel_siii_9071 real,
    emline_gvel_siii_9533 real,
    emline_gvel_ivar_oiid_3728 double precision,
    emline_gvel_ivar_hb_4862 double precision,
    emline_gvel_ivar_oiii_4960 double precision,
    emline_gvel_ivar_oiii_5008 double precision,
    emline_gvel_ivar_oi_6302 double precision,
    emline_gvel_ivar_oi_6365 double precision,
    emline_gvel_ivar_nii_6549 double precision,
    emline_gvel_ivar_ha_6564 double precision,
    emline_gvel_ivar_nii_6585 double precision,
    emline_gvel_ivar_sii_6718 double precision,
    emline_gvel_ivar_sii_6732 double precision,
    emline_gvel_ivar_oii_3727 double precision,
    emline_gvel_ivar_oii_3729 double precision,
    emline_gvel_ivar_heps_3971 double precision,
    emline_gvel_ivar_hdel_4102 double precision,
    emline_gvel_ivar_hgam_4341 double precision,
    emline_gvel_ivar_heii_4687 double precision,
    emline_gvel_ivar_hei_5877 double precision,
    emline_gvel_ivar_siii_8831 double precision,
    emline_gvel_ivar_siii_9071 double precision,
    emline_gvel_ivar_siii_9533 double precision,
    emline_gvel_mask_oiid_3728 integer,
    emline_gvel_mask_hb_4862 integer,
    emline_gvel_mask_oiii_4960 integer,
    emline_gvel_mask_oiii_5008 integer,
    emline_gvel_mask_oi_6302 integer,
    emline_gvel_mask_oi_6365 integer,
    emline_gvel_mask_nii_6549 integer,
    emline_gvel_mask_ha_6564 integer,
    emline_gvel_mask_nii_6585 integer,
    emline_gvel_mask_sii_6718 integer,
    emline_gvel_mask_sii_6732 integer,
    emline_gvel_mask_oii_3727 integer,
    emline_gvel_mask_oii_3729 integer,
    emline_gvel_mask_heps_3971 integer,
    emline_gvel_mask_hdel_4102 integer,
    emline_gvel_mask_hgam_4341 integer,
    emline_gvel_mask_heii_4687 integer,
    emline_gvel_mask_hei_5877 integer,
    emline_gvel_mask_siii_8831 integer,
    emline_gvel_mask_siii_9071 integer,
    emline_gvel_mask_siii_9533 integer,
    emline_gsigma_oiid_3728 real,
    emline_gsigma_hb_4862 real,
    emline_gsigma_oiii_4960 real,
    emline_gsigma_oiii_5008 real,
    emline_gsigma_oi_6302 real,
    emline_gsigma_oi_6365 real,
    emline_gsigma_nii_6549 real,
    emline_gsigma_ha_6564 real,
    emline_gsigma_nii_6585 real,
    emline_gsigma_sii_6718 real,
    emline_gsigma_sii_6732 real,
    emline_gsigma_oii_3727 real,
    emline_gsigma_oii_3729 real,
    emline_gsigma_heps_3971 real,
    emline_gsigma_hdel_4102 real,
    emline_gsigma_hgam_4341 real,
    emline_gsigma_heii_4687 real,
    emline_gsigma_hei_5877 real,
    emline_gsigma_siii_8831 real,
    emline_gsigma_siii_9071 real,
    emline_gsigma_siii_9533 real,
    emline_gsigma_ivar_oiid_3728 double precision,
    emline_gsigma_ivar_hb_4862 double precision,
    emline_gsigma_ivar_oiii_4960 double precision,
    emline_gsigma_ivar_oiii_5008 double precision,
    emline_gsigma_ivar_oi_6302 double precision,
    emline_gsigma_ivar_oi_6365 double precision,
    emline_gsigma_ivar_nii_6549 double precision,
    emline_gsigma_ivar_ha_6564 double precision,
    emline_gsigma_ivar_nii_6585 double precision,
    emline_gsigma_ivar_sii_6718 double precision,
    emline_gsigma_ivar_sii_6732 double precision,
    emline_gsigma_ivar_oii_3727 double precision,
    emline_gsigma_ivar_oii_3729 double precision,
    emline_gsigma_ivar_heps_3971 double precision,
    emline_gsigma_ivar_hdel_4102 double precision,
    emline_gsigma_ivar_hgam_4341 double precision,
    emline_gsigma_ivar_heii_4687 double precision,
    emline_gsigma_ivar_hei_5877 double precision,
    emline_gsigma_ivar_siii_8831 double precision,
    emline_gsigma_ivar_siii_9071 double precision,
    emline_gsigma_ivar_siii_9533 double precision,
    emline_gsigma_mask_oiid_3728 integer,
    emline_gsigma_mask_hb_4862 integer,
    emline_gsigma_mask_oiii_4960 integer,
    emline_gsigma_mask_oiii_5008 integer,
    emline_gsigma_mask_oi_6302 integer,
    emline_gsigma_mask_oi_6365 integer,
    emline_gsigma_mask_nii_6549 integer,
    emline_gsigma_mask_ha_6564 integer,
    emline_gsigma_mask_nii_6585 integer,
    emline_gsigma_mask_sii_6718 integer,
    emline_gsigma_mask_sii_6732 integer,
    emline_gsigma_mask_oii_3727 integer,
    emline_gsigma_mask_oii_3729 integer,
    emline_gsigma_mask_heps_3971 integer,
    emline_gsigma_mask_hdel_4102 integer,
    emline_gsigma_mask_hgam_4341 integer,
    emline_gsigma_mask_heii_4687 integer,
    emline_gsigma_mask_hei_5877 integer,
    emline_gsigma_mask_siii_8831 integer,
    emline_gsigma_mask_siii_9071 integer,
    emline_gsigma_mask_siii_9533 integer,
    emline_instsigma_oiid_3728 real,
    emline_instsigma_hb_4862 real,
    emline_instsigma_oiii_4960 real,
    emline_instsigma_oiii_5008 real,
    emline_instsigma_oi_6302 real,
    emline_instsigma_oi_6365 real,
    emline_instsigma_nii_6549 real,
    emline_instsigma_ha_6564 real,
    emline_instsigma_nii_6585 real,
    emline_instsigma_sii_6718 real,
    emline_instsigma_sii_6732 real,
    emline_instsigma_oii_3727 real,
    emline_instsigma_oii_3729 real,
    emline_instsigma_heps_3971 real,
    emline_instsigma_hdel_4102 real,
    emline_instsigma_hgam_4341 real,
    emline_instsigma_heii_4687 real,
    emline_instsigma_hei_5877 real,
    emline_instsigma_siii_8831 real,
    emline_instsigma_siii_9071 real,
    emline_instsigma_siii_9533 real,
    specindex_d4000 real,
    specindex_dn4000 real,
    specindex_ivar_d4000 double precision,
    specindex_ivar_dn4000 double precision,
    specindex_mask_d4000 integer,
    specindex_mask_dn4000 integer,
    specindex_corr_d4000 real,
    specindex_corr_dn4000 real,
    x integer,
    y integer
)
WITH (autovacuum_enabled='false');


ALTER TABLE spaxelprop5 OWNER TO manga;

--
-- Name: junk5_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE junk5_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE junk5_pk_seq OWNER TO manga;

--
-- Name: junk5_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE junk5_pk_seq OWNED BY spaxelprop5.pk;


--
-- Name: spaxelprop; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE spaxelprop (
    pk bigint NOT NULL,
    file_pk integer,
    spaxel_index integer,
    binid_pk integer,
    emline_gflux_oiid_3728 real,
    emline_gflux_hb_4862 real,
    emline_gflux_oiii_4960 real,
    emline_gflux_oiii_5008 real,
    emline_gflux_oi_6302 real,
    emline_gflux_oi_6365 real,
    emline_gflux_nii_6549 real,
    emline_gflux_ha_6564 real,
    emline_gflux_nii_6585 real,
    emline_gflux_sii_6718 real,
    emline_gflux_sii_6732 real,
    emline_gflux_ivar_oiid_3728 double precision,
    emline_gflux_ivar_hb_4862 double precision,
    emline_gflux_ivar_oiii_4960 double precision,
    emline_gflux_ivar_oiii_5008 double precision,
    emline_gflux_ivar_oi_6302 double precision,
    emline_gflux_ivar_oi_6365 double precision,
    emline_gflux_ivar_nii_6549 double precision,
    emline_gflux_ivar_ha_6564 double precision,
    emline_gflux_ivar_nii_6585 double precision,
    emline_gflux_ivar_sii_6718 double precision,
    emline_gflux_ivar_sii_6732 double precision,
    emline_gflux_mask_oiid_3728 integer,
    emline_gflux_mask_hb_4862 integer,
    emline_gflux_mask_oiii_4960 integer,
    emline_gflux_mask_oiii_5008 integer,
    emline_gflux_mask_oi_6302 integer,
    emline_gflux_mask_oi_6365 integer,
    emline_gflux_mask_nii_6549 integer,
    emline_gflux_mask_ha_6564 integer,
    emline_gflux_mask_nii_6585 integer,
    emline_gflux_mask_sii_6718 integer,
    emline_gflux_mask_sii_6732 integer,
    emline_gvel_oiid_3728 real,
    emline_gvel_hb_4862 real,
    emline_gvel_oiii_4960 real,
    emline_gvel_oiii_5008 real,
    emline_gvel_oi_6302 real,
    emline_gvel_oi_6365 real,
    emline_gvel_nii_6549 real,
    emline_gvel_ha_6564 real,
    emline_gvel_nii_6585 real,
    emline_gvel_sii_6718 real,
    emline_gvel_sii_6732 real,
    emline_gvel_ivar_oiid_3728 double precision,
    emline_gvel_ivar_hb_4862 double precision,
    emline_gvel_ivar_oiii_4960 double precision,
    emline_gvel_ivar_oiii_5008 double precision,
    emline_gvel_ivar_oi_6302 double precision,
    emline_gvel_ivar_oi_6365 double precision,
    emline_gvel_ivar_nii_6549 double precision,
    emline_gvel_ivar_ha_6564 double precision,
    emline_gvel_ivar_nii_6585 double precision,
    emline_gvel_ivar_sii_6718 double precision,
    emline_gvel_ivar_sii_6732 double precision,
    emline_gvel_mask_oiid_3728 integer,
    emline_gvel_mask_hb_4862 integer,
    emline_gvel_mask_oiii_4960 integer,
    emline_gvel_mask_oiii_5008 integer,
    emline_gvel_mask_oi_6302 integer,
    emline_gvel_mask_oi_6365 integer,
    emline_gvel_mask_nii_6549 integer,
    emline_gvel_mask_ha_6564 integer,
    emline_gvel_mask_nii_6585 integer,
    emline_gvel_mask_sii_6718 integer,
    emline_gvel_mask_sii_6732 integer,
    emline_gsigma_oiid_3728 real,
    emline_gsigma_hb_4862 real,
    emline_gsigma_oiii_4960 real,
    emline_gsigma_oiii_5008 real,
    emline_gsigma_oi_6302 real,
    emline_gsigma_oi_6365 real,
    emline_gsigma_nii_6549 real,
    emline_gsigma_ha_6564 real,
    emline_gsigma_nii_6585 real,
    emline_gsigma_sii_6718 real,
    emline_gsigma_sii_6732 real,
    emline_gsigma_ivar_oiid_3728 double precision,
    emline_gsigma_ivar_hb_4862 double precision,
    emline_gsigma_ivar_oiii_4960 double precision,
    emline_gsigma_ivar_oiii_5008 double precision,
    emline_gsigma_ivar_oi_6302 double precision,
    emline_gsigma_ivar_oi_6365 double precision,
    emline_gsigma_ivar_nii_6549 double precision,
    emline_gsigma_ivar_ha_6564 double precision,
    emline_gsigma_ivar_nii_6585 double precision,
    emline_gsigma_ivar_sii_6718 double precision,
    emline_gsigma_ivar_sii_6732 double precision,
    emline_gsigma_mask_oiid_3728 integer,
    emline_gsigma_mask_hb_4862 integer,
    emline_gsigma_mask_oiii_4960 integer,
    emline_gsigma_mask_oiii_5008 integer,
    emline_gsigma_mask_oi_6302 integer,
    emline_gsigma_mask_oi_6365 integer,
    emline_gsigma_mask_nii_6549 integer,
    emline_gsigma_mask_ha_6564 integer,
    emline_gsigma_mask_nii_6585 integer,
    emline_gsigma_mask_sii_6718 integer,
    emline_gsigma_mask_sii_6732 integer,
    emline_instsigma_oiid_3728 real,
    emline_instsigma_hb_4862 real,
    emline_instsigma_oiii_4960 real,
    emline_instsigma_oiii_5008 real,
    emline_instsigma_oi_6302 real,
    emline_instsigma_oi_6365 real,
    emline_instsigma_nii_6549 real,
    emline_instsigma_ha_6564 real,
    emline_instsigma_nii_6585 real,
    emline_instsigma_sii_6718 real,
    emline_instsigma_sii_6732 real,
    emline_ew_oiid_3728 real,
    emline_ew_hb_4862 double precision,
    emline_ew_oiii_4960 real,
    emline_ew_oiii_5008 double precision,
    emline_ew_oi_6302 double precision,
    emline_ew_oi_6365 double precision,
    emline_ew_nii_6549 double precision,
    emline_ew_ha_6564 double precision,
    emline_ew_nii_6585 double precision,
    emline_ew_sii_6718 real,
    emline_ew_sii_6732 real,
    emline_ew_ivar_oiid_3728 double precision,
    emline_ew_ivar_hb_4862 double precision,
    emline_ew_ivar_oiii_4960 double precision,
    emline_ew_ivar_oiii_5008 double precision,
    emline_ew_ivar_oi_6302 double precision,
    emline_ew_ivar_oi_6365 double precision,
    emline_ew_ivar_nii_6549 double precision,
    emline_ew_ivar_ha_6564 double precision,
    emline_ew_ivar_nii_6585 double precision,
    emline_ew_ivar_sii_6718 double precision,
    emline_ew_ivar_sii_6732 double precision,
    emline_ew_mask_oiid_3728 integer,
    emline_ew_mask_hb_4862 integer,
    emline_ew_mask_oiii_4960 integer,
    emline_ew_mask_oiii_5008 integer,
    emline_ew_mask_oi_6302 integer,
    emline_ew_mask_oi_6365 integer,
    emline_ew_mask_nii_6549 integer,
    emline_ew_mask_ha_6564 integer,
    emline_ew_mask_nii_6585 integer,
    emline_ew_mask_sii_6718 integer,
    emline_ew_mask_sii_6732 integer,
    emline_sflux_oiid_3728 real,
    emline_sflux_hb_4862 real,
    emline_sflux_oiii_4960 real,
    emline_sflux_oiii_5008 real,
    emline_sflux_oi_6302 real,
    emline_sflux_oi_6365 real,
    emline_sflux_nii_6549 real,
    emline_sflux_ha_6564 real,
    emline_sflux_nii_6585 real,
    emline_sflux_sii_6718 real,
    emline_sflux_sii_6732 real,
    emline_sflux_ivar_oiid_3728 double precision,
    emline_sflux_ivar_hb_4862 double precision,
    emline_sflux_ivar_oiii_4960 double precision,
    emline_sflux_ivar_oiii_5008 double precision,
    emline_sflux_ivar_oi_6302 double precision,
    emline_sflux_ivar_oi_6365 double precision,
    emline_sflux_ivar_nii_6549 double precision,
    emline_sflux_ivar_ha_6564 double precision,
    emline_sflux_ivar_nii_6585 double precision,
    emline_sflux_ivar_sii_6718 double precision,
    emline_sflux_ivar_sii_6732 double precision,
    emline_sflux_mask_oiid_3728 integer,
    emline_sflux_mask_hb_4862 integer,
    emline_sflux_mask_oiii_4960 integer,
    emline_sflux_mask_oiii_5008 integer,
    emline_sflux_mask_oi_6302 integer,
    emline_sflux_mask_oi_6365 integer,
    emline_sflux_mask_nii_6549 integer,
    emline_sflux_mask_ha_6564 integer,
    emline_sflux_mask_nii_6585 integer,
    emline_sflux_mask_sii_6718 integer,
    emline_sflux_mask_sii_6732 integer,
    stellar_vel real,
    stellar_vel_ivar double precision,
    stellar_vel_mask integer,
    stellar_sigma real,
    stellar_sigma_ivar double precision,
    stellar_sigma_mask integer,
    specindex_d4000 real,
    specindex_caii0p39 real,
    specindex_hdeltaa real,
    specindex_cn1 real,
    specindex_cn2 real,
    specindex_ca4227 real,
    specindex_hgammaa real,
    specindex_fe4668 real,
    specindex_hb real,
    specindex_mgb real,
    specindex_fe5270 real,
    specindex_fe5335 real,
    specindex_fe5406 real,
    specindex_nad real,
    specindex_tio1 real,
    specindex_tio2 real,
    specindex_nai0p82 real,
    specindex_caii0p86a real,
    specindex_caii0p86b real,
    specindex_caii0p86c real,
    specindex_mgi0p88 real,
    specindex_tio0p89 real,
    specindex_feh0p99 real,
    specindex_ivar_d4000 double precision,
    specindex_ivar_caii0p39 double precision,
    specindex_ivar_hdeltaa double precision,
    specindex_ivar_cn1 double precision,
    specindex_ivar_cn2 double precision,
    specindex_ivar_ca4227 double precision,
    specindex_ivar_hgammaa double precision,
    specindex_ivar_fe4668 double precision,
    specindex_ivar_hb double precision,
    specindex_ivar_mgb double precision,
    specindex_ivar_fe5270 double precision,
    specindex_ivar_fe5335 double precision,
    specindex_ivar_fe5406 double precision,
    specindex_ivar_nad double precision,
    specindex_ivar_tio1 double precision,
    specindex_ivar_tio2 double precision,
    specindex_ivar_nai0p82 double precision,
    specindex_ivar_caii0p86a double precision,
    specindex_ivar_caii0p86b double precision,
    specindex_ivar_caii0p86c double precision,
    specindex_ivar_mgi0p88 double precision,
    specindex_ivar_tio0p89 double precision,
    specindex_ivar_feh0p99 double precision,
    specindex_mask_d4000 integer,
    specindex_mask_caii0p39 integer,
    specindex_mask_hdeltaa integer,
    specindex_mask_cn1 integer,
    specindex_mask_cn2 integer,
    specindex_mask_ca4227 integer,
    specindex_mask_hgammaa integer,
    specindex_mask_fe4668 integer,
    specindex_mask_hb integer,
    specindex_mask_mgb integer,
    specindex_mask_fe5270 integer,
    specindex_mask_fe5335 integer,
    specindex_mask_fe5406 integer,
    specindex_mask_nad integer,
    specindex_mask_tio1 integer,
    specindex_mask_tio2 integer,
    specindex_mask_nai0p82 integer,
    specindex_mask_caii0p86a integer,
    specindex_mask_caii0p86b integer,
    specindex_mask_caii0p86c integer,
    specindex_mask_mgi0p88 integer,
    specindex_mask_tio0p89 integer,
    specindex_mask_feh0p99 integer,
    binid integer,
    x integer,
    y integer
);


ALTER TABLE spaxelprop OWNER TO manga;

--
-- Name: junk_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE junk_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE junk_pk_seq OWNER TO manga;

--
-- Name: junk_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE junk_pk_seq OWNED BY spaxelprop.pk;


--
-- Name: modelcube; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE modelcube (
    pk integer NOT NULL,
    file_pk integer
);


ALTER TABLE modelcube OWNER TO manga;

--
-- Name: modelcube_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE modelcube_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE modelcube_pk_seq OWNER TO manga;

--
-- Name: modelcube_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE modelcube_pk_seq OWNED BY modelcube.pk;


--
-- Name: modelspaxel; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE modelspaxel (
    pk integer NOT NULL,
    flux real[],
    ivar real[],
    mask integer[],
    model real[],
    emline double precision[],
    emline_base real[],
    emline_mask integer[],
    x integer,
    y integer,
    modelcube_pk integer
);


ALTER TABLE modelspaxel OWNER TO manga;

--
-- Name: modelspaxel_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE modelspaxel_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE modelspaxel_pk_seq OWNER TO manga;

--
-- Name: modelspaxel_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE modelspaxel_pk_seq OWNED BY modelspaxel.pk;


--
-- Name: redcorr; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE redcorr (
    pk integer NOT NULL,
    value numeric[],
    modelcube_pk integer
);


ALTER TABLE redcorr OWNER TO manga;

--
-- Name: redcorr_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE redcorr_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE redcorr_pk_seq OWNER TO manga;

--
-- Name: redcorr_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE redcorr_pk_seq OWNED BY redcorr.pk;


--
-- Name: spaxelprop_xy_null; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE spaxelprop_xy_null (
    pk bigint,
    spaxel_index integer,
    file_pk integer,
    x integer,
    y integer
);


ALTER TABLE spaxelprop_xy_null OWNER TO manga;

--
-- Name: spaxelprop_xy_temp_001; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE spaxelprop_xy_temp_001 (
    spaxelprop_pk integer,
    x integer,
    y integer
);


ALTER TABLE spaxelprop_xy_temp_001 OWNER TO manga;

--
-- Name: structure; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE structure (
    pk integer NOT NULL,
    binmode_pk integer,
    bintype_pk integer,
    template_kin_pk integer,
    template_pop_pk integer,
    executionplan_pk integer
);


ALTER TABLE structure OWNER TO manga;

--
-- Name: structure_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE structure_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE structure_pk_seq OWNER TO manga;

--
-- Name: structure_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE structure_pk_seq OWNED BY structure.pk;


--
-- Name: template; Type: TABLE; Schema: mangadapdb; Owner: manga
--

CREATE TABLE template (
    pk integer NOT NULL,
    name text,
    id integer
);


ALTER TABLE template OWNER TO manga;

--
-- Name: template_pk_seq; Type: SEQUENCE; Schema: mangadapdb; Owner: manga
--

CREATE SEQUENCE template_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE template_pk_seq OWNER TO manga;

--
-- Name: template_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadapdb; Owner: manga
--

ALTER SEQUENCE template_pk_seq OWNED BY template.pk;


SET search_path = mangadatadb, pg_catalog;

--
-- Name: cart; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE cart (
    pk integer NOT NULL,
    id integer
);


ALTER TABLE cart OWNER TO manga;

--
-- Name: cart_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE cart_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cart_pk_seq OWNER TO manga;

--
-- Name: cart_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE cart_pk_seq OWNED BY cart.pk;


--
-- Name: cart_to_cube; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE cart_to_cube (
    pk integer NOT NULL,
    cube_pk integer,
    cart_pk integer
);


ALTER TABLE cart_to_cube OWNER TO manga;

--
-- Name: cart_to_cube_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE cart_to_cube_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cart_to_cube_pk_seq OWNER TO manga;

--
-- Name: cart_to_cube_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE cart_to_cube_pk_seq OWNED BY cart_to_cube.pk;


--
-- Name: cube; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE cube (
    pk integer NOT NULL,
    plate integer,
    mangaid text,
    designid integer,
    pipeline_info_pk integer,
    wavelength_pk integer,
    ifudesign_pk integer,
    specres real[],
    xfocal real,
    yfocal real,
    ra double precision,
    "dec" double precision,
    manga_target_pk integer,
    cube_shape_pk integer
);


ALTER TABLE cube OWNER TO manga;

--
-- Name: cube_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE cube_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cube_pk_seq OWNER TO manga;

--
-- Name: cube_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE cube_pk_seq OWNED BY cube.pk;


--
-- Name: cube_shape; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE cube_shape (
    pk integer NOT NULL,
    size integer,
    total integer,
    indices integer[]
);


ALTER TABLE cube_shape OWNER TO manga;

--
-- Name: cube_shape_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE cube_shape_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cube_shape_pk_seq OWNER TO manga;

--
-- Name: cube_shape_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE cube_shape_pk_seq OWNED BY cube_shape.pk;


--
-- Name: fiber_type; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE fiber_type (
    pk integer NOT NULL,
    label text
);


ALTER TABLE fiber_type OWNER TO manga;

--
-- Name: fiber_type_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE fiber_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE fiber_type_pk_seq OWNER TO manga;

--
-- Name: fiber_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE fiber_type_pk_seq OWNED BY fiber_type.pk;


--
-- Name: fibers; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE fibers (
    pk integer NOT NULL,
    fiberid integer,
    specfibid integer,
    fnum integer,
    ring integer,
    dist_mm real,
    xpmm real,
    ypmm real,
    fiber_type_pk integer,
    target_type_pk integer,
    ifudesign_pk integer
);


ALTER TABLE fibers OWNER TO manga;

--
-- Name: fibers_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE fibers_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE fibers_pk_seq OWNER TO manga;

--
-- Name: fibers_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE fibers_pk_seq OWNED BY fibers.pk;


--
-- Name: fits_header_keyword; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE fits_header_keyword (
    pk integer NOT NULL,
    label text
);


ALTER TABLE fits_header_keyword OWNER TO manga;

--
-- Name: fits_header_keyword_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE fits_header_keyword_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE fits_header_keyword_pk_seq OWNER TO manga;

--
-- Name: fits_header_keyword_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE fits_header_keyword_pk_seq OWNED BY fits_header_keyword.pk;


--
-- Name: fits_header_value; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE fits_header_value (
    pk integer NOT NULL,
    value text,
    index integer,
    comment text,
    fits_header_keyword_pk integer,
    cube_pk integer
);


ALTER TABLE fits_header_value OWNER TO manga;

--
-- Name: fits_header_value_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE fits_header_value_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE fits_header_value_pk_seq OWNER TO manga;

--
-- Name: fits_header_value_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE fits_header_value_pk_seq OWNED BY fits_header_value.pk;


--
-- Name: ifu_to_block; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE ifu_to_block (
    pk integer NOT NULL,
    ifudesign_pk integer,
    slitblock_pk integer
);


ALTER TABLE ifu_to_block OWNER TO manga;

--
-- Name: ifu_to_block_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE ifu_to_block_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ifu_to_block_pk_seq OWNER TO manga;

--
-- Name: ifu_to_block_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE ifu_to_block_pk_seq OWNED BY ifu_to_block.pk;


--
-- Name: ifudesign; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE ifudesign (
    pk integer NOT NULL,
    name text,
    nfiber integer,
    nsky integer,
    nblocks integer,
    specid integer,
    maxring integer
);


ALTER TABLE ifudesign OWNER TO manga;

--
-- Name: ifudesign_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE ifudesign_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ifudesign_pk_seq OWNER TO manga;

--
-- Name: ifudesign_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE ifudesign_pk_seq OWNED BY ifudesign.pk;


--
-- Name: pipeline_completion_status; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE pipeline_completion_status (
    pk integer NOT NULL,
    label text
);


ALTER TABLE pipeline_completion_status OWNER TO manga;

--
-- Name: pipeline_completion_status_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE pipeline_completion_status_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pipeline_completion_status_pk_seq OWNER TO manga;

--
-- Name: pipeline_completion_status_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE pipeline_completion_status_pk_seq OWNED BY pipeline_completion_status.pk;


--
-- Name: pipeline_info; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE pipeline_info (
    pk integer NOT NULL,
    pipeline_name_pk integer,
    pipeline_stage_pk integer,
    pipeline_version_pk integer,
    pipeline_completion_status_pk integer
);


ALTER TABLE pipeline_info OWNER TO manga;

--
-- Name: pipeline_info_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE pipeline_info_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pipeline_info_pk_seq OWNER TO manga;

--
-- Name: pipeline_info_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE pipeline_info_pk_seq OWNED BY pipeline_info.pk;


--
-- Name: pipeline_name; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE pipeline_name (
    pk integer NOT NULL,
    label text
);


ALTER TABLE pipeline_name OWNER TO manga;

--
-- Name: pipeline_name_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE pipeline_name_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pipeline_name_pk_seq OWNER TO manga;

--
-- Name: pipeline_name_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE pipeline_name_pk_seq OWNED BY pipeline_name.pk;


--
-- Name: pipeline_stage; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE pipeline_stage (
    pk integer NOT NULL,
    label text
);


ALTER TABLE pipeline_stage OWNER TO manga;

--
-- Name: pipeline_stage_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE pipeline_stage_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pipeline_stage_pk_seq OWNER TO manga;

--
-- Name: pipeline_stage_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE pipeline_stage_pk_seq OWNED BY pipeline_stage.pk;


--
-- Name: pipeline_version; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE pipeline_version (
    pk integer NOT NULL,
    version text
);


ALTER TABLE pipeline_version OWNER TO manga;

--
-- Name: pipeline_version_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE pipeline_version_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pipeline_version_pk_seq OWNER TO manga;

--
-- Name: pipeline_version_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE pipeline_version_pk_seq OWNED BY pipeline_version.pk;


--
-- Name: rssfiber; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE rssfiber (
    pk integer NOT NULL,
    flux real[],
    ivar real[],
    mask integer[],
    xpos real[],
    ypos real[],
    exposure_no integer,
    mjd integer,
    exposure_pk integer,
    cube_pk integer,
    fibers_pk integer
);


ALTER TABLE rssfiber OWNER TO manga;

--
-- Name: rssfiber_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE rssfiber_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rssfiber_pk_seq OWNER TO manga;

--
-- Name: rssfiber_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE rssfiber_pk_seq OWNED BY rssfiber.pk;


--
-- Name: sample; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE sample (
    pk integer NOT NULL,
    manga_tileid integer,
    ifu_ra double precision,
    ifu_dec double precision,
    target_ra double precision,
    target_dec double precision,
    iauname text,
    ifudesignsize integer,
    ifutargetsize integer,
    ifudesignwrongsize integer,
    field integer,
    run integer,
    nsa_redshift real,
    nsa_zdist real,
    nsa_absmag_f real,
    nsa_absmag_n real,
    nsa_absmag_u real,
    nsa_absmag_g real,
    nsa_absmag_r real,
    nsa_absmag_i real,
    nsa_absmag_z real,
    nsa_mstar real,
    nsa_vdisp real,
    nsa_inclination real,
    nsa_petro_th50 real,
    nsa_petroflux_f real,
    nsa_petroflux_n real,
    nsa_petroflux_u real,
    nsa_petroflux_g real,
    nsa_petroflux_r real,
    nsa_petroflux_i real,
    nsa_petroflux_z real,
    nsa_petroflux_ivar_f real,
    nsa_petroflux_ivar_n real,
    nsa_petroflux_ivar_u real,
    nsa_petroflux_ivar_g real,
    nsa_petroflux_ivar_r real,
    nsa_petroflux_ivar_i real,
    nsa_petroflux_ivar_z real,
    nsa_sersic_ba real,
    nsa_sersic_n real,
    nsa_sersic_phi real,
    nsa_sersic_th50 real,
    nsa_sersicflux_f real,
    nsa_sersicflux_n real,
    nsa_sersicflux_u real,
    nsa_sersicflux_g real,
    nsa_sersicflux_r real,
    nsa_sersicflux_i real,
    nsa_sersicflux_z real,
    nsa_sersicflux_ivar_f real,
    nsa_sersicflux_ivar_n real,
    nsa_sersicflux_ivar_u real,
    nsa_sersicflux_ivar_g real,
    nsa_sersicflux_ivar_r real,
    nsa_sersicflux_ivar_i real,
    nsa_sersicflux_ivar_z real,
    cube_pk integer,
    nsa_version text,
    nsa_id bigint,
    nsa_id100 bigint,
    nsa_ba real,
    nsa_phi real,
    nsa_mstar_el real,
    nsa_petro_th50_el real,
    nsa_extinction_f real,
    nsa_extinction_n real,
    nsa_extinction_u real,
    nsa_extinction_g real,
    nsa_extinction_r real,
    nsa_extinction_i real,
    nsa_extinction_z real,
    nsa_amivar_el_f real,
    nsa_amivar_el_n real,
    nsa_amivar_el_u real,
    nsa_amivar_el_g real,
    nsa_amivar_el_r real,
    nsa_amivar_el_i real,
    nsa_amivar_el_z real,
    nsa_petroflux_el_f real,
    nsa_petroflux_el_n real,
    nsa_petroflux_el_u real,
    nsa_petroflux_el_g real,
    nsa_petroflux_el_r real,
    nsa_petroflux_el_i real,
    nsa_petroflux_el_z real,
    nsa_petroflux_el_ivar_f real,
    nsa_petroflux_el_ivar_n real,
    nsa_petroflux_el_ivar_u real,
    nsa_petroflux_el_ivar_g real,
    nsa_petroflux_el_ivar_r real,
    nsa_petroflux_el_ivar_i real,
    nsa_petroflux_el_ivar_z real,
    nsa_absmag_el_f real,
    nsa_absmag_el_n real,
    nsa_absmag_el_u real,
    nsa_absmag_el_g real,
    nsa_absmag_el_r real,
    nsa_absmag_el_i real,
    nsa_absmag_el_z real
);


ALTER TABLE sample OWNER TO manga;

--
-- Name: sample_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE sample_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sample_pk_seq OWNER TO manga;

--
-- Name: sample_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE sample_pk_seq OWNED BY sample.pk;


--
-- Name: slitblock; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE slitblock (
    pk integer NOT NULL,
    blockid integer,
    specblockid integer,
    nfiber integer
);


ALTER TABLE slitblock OWNER TO manga;

--
-- Name: slitblock_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE slitblock_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE slitblock_pk_seq OWNER TO manga;

--
-- Name: slitblock_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE slitblock_pk_seq OWNED BY slitblock.pk;


--
-- Name: spaxel; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE spaxel (
    pk integer NOT NULL,
    flux real[],
    ivar real[],
    mask integer[],
    cube_pk integer,
    x integer,
    y integer
);


ALTER TABLE spaxel OWNER TO manga;

--
-- Name: spaxel_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE spaxel_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spaxel_pk_seq OWNER TO manga;

--
-- Name: spaxel_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE spaxel_pk_seq OWNED BY spaxel.pk;


--
-- Name: target_type; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE target_type (
    pk integer NOT NULL,
    label text
);


ALTER TABLE target_type OWNER TO manga;

--
-- Name: target_type_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE target_type_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE target_type_pk_seq OWNER TO manga;

--
-- Name: target_type_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE target_type_pk_seq OWNED BY target_type.pk;


--
-- Name: test_rssfiber; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE test_rssfiber (
    pk integer NOT NULL,
    flux json,
    cube_pk integer
);


ALTER TABLE test_rssfiber OWNER TO manga;

--
-- Name: test_rssfiber_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE test_rssfiber_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_rssfiber_pk_seq OWNER TO manga;

--
-- Name: test_rssfiber_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE test_rssfiber_pk_seq OWNED BY test_rssfiber.pk;


--
-- Name: test_spaxel; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE test_spaxel (
    pk integer NOT NULL,
    flux real[],
    ivar real[],
    mask integer[],
    cube_pk integer,
    flux_json json
);


ALTER TABLE test_spaxel OWNER TO manga;

--
-- Name: test_spaxel_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE test_spaxel_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_spaxel_pk_seq OWNER TO manga;

--
-- Name: test_spaxel_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE test_spaxel_pk_seq OWNED BY test_spaxel.pk;


--
-- Name: wavelength; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE wavelength (
    pk integer NOT NULL,
    wavelength real[],
    bintype text
);


ALTER TABLE wavelength OWNER TO manga;

--
-- Name: wavelength_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE wavelength_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE wavelength_pk_seq OWNER TO manga;

--
-- Name: wavelength_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE wavelength_pk_seq OWNED BY wavelength.pk;


--
-- Name: wcs; Type: TABLE; Schema: mangadatadb; Owner: manga
--

CREATE TABLE wcs (
    pk integer NOT NULL,
    cube_pk integer,
    ctype3 text,
    crpix3 integer,
    crval3 numeric,
    cd3_3 numeric,
    cunit3 text,
    crpix1 numeric,
    crpix2 numeric,
    crval1 numeric,
    crval2 numeric,
    cd1_1 numeric,
    cd2_2 numeric,
    ctype1 text,
    ctype2 text,
    cunit1 text,
    cunit2 text,
    hduclass text,
    hduclas1 text,
    hduclas2 text,
    errdata text,
    qualdata text,
    extname text,
    naxis1 integer,
    naxis2 integer,
    naxis3 integer
);


ALTER TABLE wcs OWNER TO manga;

--
-- Name: wcs_pk_seq; Type: SEQUENCE; Schema: mangadatadb; Owner: manga
--

CREATE SEQUENCE wcs_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE wcs_pk_seq OWNER TO manga;

--
-- Name: wcs_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangadatadb; Owner: manga
--

ALTER SEQUENCE wcs_pk_seq OWNED BY wcs.pk;


SET search_path = mangasampledb, pg_catalog;

--
-- Name: anime; Type: TABLE; Schema: mangasampledb; Owner: manga
--

CREATE TABLE anime (
    pk integer NOT NULL,
    anime text
);


ALTER TABLE anime OWNER TO manga;

--
-- Name: anime_pk_seq; Type: SEQUENCE; Schema: mangasampledb; Owner: manga
--

CREATE SEQUENCE anime_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE anime_pk_seq OWNER TO manga;

--
-- Name: anime_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangasampledb; Owner: manga
--

ALTER SEQUENCE anime_pk_seq OWNED BY anime.pk;


--
-- Name: catalogue; Type: TABLE; Schema: mangasampledb; Owner: manga
--

CREATE TABLE catalogue (
    pk integer NOT NULL,
    catalogue_name text NOT NULL,
    version text NOT NULL,
    match_description text,
    matched boolean
);


ALTER TABLE catalogue OWNER TO manga;

--
-- Name: catalogue_pk_seq; Type: SEQUENCE; Schema: mangasampledb; Owner: manga
--

CREATE SEQUENCE catalogue_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE catalogue_pk_seq OWNER TO manga;

--
-- Name: catalogue_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangasampledb; Owner: manga
--

ALTER SEQUENCE catalogue_pk_seq OWNED BY catalogue.pk;


--
-- Name: character; Type: TABLE; Schema: mangasampledb; Owner: manga
--

CREATE TABLE "character" (
    pk integer NOT NULL,
    name text,
    picture bytea,
    anime_pk integer,
    manga_target_pk integer
);


ALTER TABLE "character" OWNER TO manga;

--
-- Name: character_pk_seq; Type: SEQUENCE; Schema: mangasampledb; Owner: manga
--

CREATE SEQUENCE character_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE character_pk_seq OWNER TO manga;

--
-- Name: character_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangasampledb; Owner: manga
--

ALTER SEQUENCE character_pk_seq OWNED BY "character".pk;


--
-- Name: current_catalogue; Type: TABLE; Schema: mangasampledb; Owner: manga
--

CREATE TABLE current_catalogue (
    pk integer NOT NULL,
    catalogue_pk smallint NOT NULL
);


ALTER TABLE current_catalogue OWNER TO manga;

--
-- Name: current_catalogue_pk_seq; Type: SEQUENCE; Schema: mangasampledb; Owner: manga
--

CREATE SEQUENCE current_catalogue_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE current_catalogue_pk_seq OWNER TO manga;

--
-- Name: current_catalogue_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangasampledb; Owner: manga
--

ALTER SEQUENCE current_catalogue_pk_seq OWNED BY current_catalogue.pk;


--
-- Name: manga_target; Type: TABLE; Schema: mangasampledb; Owner: manga
--

CREATE TABLE manga_target (
    pk integer NOT NULL,
    mangaid text NOT NULL
);


ALTER TABLE manga_target OWNER TO manga;

--
-- Name: manga_target_pk_seq; Type: SEQUENCE; Schema: mangasampledb; Owner: manga
--

CREATE SEQUENCE manga_target_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE manga_target_pk_seq OWNER TO manga;

--
-- Name: manga_target_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangasampledb; Owner: manga
--

ALTER SEQUENCE manga_target_pk_seq OWNED BY manga_target.pk;


--
-- Name: manga_target_to_manga_target; Type: TABLE; Schema: mangasampledb; Owner: manga
--

CREATE TABLE manga_target_to_manga_target (
    pk integer NOT NULL,
    manga_target1_pk integer,
    manga_target2_pk integer
);


ALTER TABLE manga_target_to_manga_target OWNER TO manga;

--
-- Name: manga_target_to_manga_target_pk_seq; Type: SEQUENCE; Schema: mangasampledb; Owner: manga
--

CREATE SEQUENCE manga_target_to_manga_target_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE manga_target_to_manga_target_pk_seq OWNER TO manga;

--
-- Name: manga_target_to_manga_target_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangasampledb; Owner: manga
--

ALTER SEQUENCE manga_target_to_manga_target_pk_seq OWNED BY manga_target_to_manga_target.pk;


--
-- Name: manga_target_to_nsa; Type: TABLE; Schema: mangasampledb; Owner: manga
--

CREATE TABLE manga_target_to_nsa (
    pk integer NOT NULL,
    manga_target_pk integer,
    nsa_pk integer
);


ALTER TABLE manga_target_to_nsa OWNER TO manga;

--
-- Name: manga_target_to_nsa_pk_seq; Type: SEQUENCE; Schema: mangasampledb; Owner: manga
--

CREATE SEQUENCE manga_target_to_nsa_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE manga_target_to_nsa_pk_seq OWNER TO manga;

--
-- Name: manga_target_to_nsa_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangasampledb; Owner: manga
--

ALTER SEQUENCE manga_target_to_nsa_pk_seq OWNED BY manga_target_to_nsa.pk;


--
-- Name: nsa; Type: TABLE; Schema: mangasampledb; Owner: manga
--

CREATE TABLE nsa (
    pk integer NOT NULL,
    iauname character varying,
    subdir character varying,
    ra double precision,
    "dec" double precision,
    isdss integer,
    ined integer,
    isixdf integer,
    ialfalfa integer,
    izcat integer,
    itwodf integer,
    mag double precision,
    z double precision,
    zsrc character varying,
    size double precision,
    run integer,
    camcol smallint,
    field integer,
    rerun character varying,
    xpos double precision,
    ypos double precision,
    nsaid integer,
    zdist double precision,
    sersic_nmgy double precision[],
    sersic_nmgy_ivar double precision[],
    sersic_ok integer,
    sersic_rnmgy double precision[],
    sersic_absmag double precision[],
    sersic_amivar double precision[],
    extinction double precision[],
    sersic_kcorrect double precision[],
    sersic_kcoeff double precision[],
    sersic_mtol double precision[],
    sersic_b300 double precision,
    sersic_b1000 double precision,
    sersic_mets double precision,
    sersic_mass double precision,
    xcen double precision,
    ycen double precision,
    nprof smallint[],
    profmean double precision[],
    profmean_ivar double precision[],
    qstokes double precision[],
    ustokes double precision[],
    bastokes double precision[],
    phistokes double precision[],
    petroflux double precision[],
    petroflux_ivar double precision[],
    fiberflux double precision[],
    fiberflux_ivar double precision[],
    ba50 double precision,
    phi50 double precision,
    ba90 double precision,
    phi90 double precision,
    sersicflux double precision[],
    sersicflux_ivar double precision[],
    sersic_n double precision,
    sersic_ba double precision,
    sersic_phi double precision,
    asymmetry double precision[],
    clumpy double precision[],
    dflags integer[],
    aid integer,
    pid integer,
    dversion character varying,
    proftheta double precision[],
    petrotheta double precision,
    petroth50 double precision,
    petroth90 double precision,
    sersic_th50 double precision,
    plate integer,
    fiberid integer,
    mjd integer,
    racat double precision,
    deccat double precision,
    zsdssline double precision,
    survey character varying,
    programname character varying,
    platequality character varying,
    tile integer,
    plug_ra double precision,
    plug_dec double precision,
    petro_ba_el double precision,
    petro_phi_el double precision,
    petrotheta_el double precision,
    petroflux_el double precision[],
    petroflux_ivar_el double precision[],
    petroth50_el double precision[],
    petroth90_el double precision[],
    petro_nmgy_el double precision[],
    petro_nmgy_ivar_el double precision[],
    petro_ok_el integer,
    petro_rnmgy_el double precision[],
    petro_absmag_el double precision[],
    petro_amivar_el double precision[],
    petro_kcorrect_el double precision[],
    petro_kcoeff_el double precision[],
    petro_mass_el double precision,
    petro_mtol_el double precision[],
    petro_b300_el double precision,
    petro_b1000_el double precision,
    petro_mets_el double precision,
    in_dr7_lss double precision,
    catalogue_pk smallint
);


ALTER TABLE nsa OWNER TO manga;

--
-- Name: nsa_pk_seq; Type: SEQUENCE; Schema: mangasampledb; Owner: manga
--

CREATE SEQUENCE nsa_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE nsa_pk_seq OWNER TO manga;

--
-- Name: nsa_pk_seq; Type: SEQUENCE OWNED BY; Schema: mangasampledb; Owner: manga
--

ALTER SEQUENCE nsa_pk_seq OWNED BY nsa.pk;


SET default_tablespace = manga_ssd;

--
-- Name: nsa_ssd; Type: TABLE; Schema: mangasampledb; Owner: manga; Tablespace: manga_ssd
--

CREATE TABLE nsa_ssd (
    pk integer NOT NULL,
    iauname character varying,
    subdir character varying,
    ra double precision,
    "dec" double precision,
    isdss integer,
    ined integer,
    isixdf integer,
    ialfalfa integer,
    izcat integer,
    itwodf integer,
    mag double precision,
    z double precision,
    zsrc character varying,
    size double precision,
    run integer,
    camcol smallint,
    field integer,
    rerun character varying,
    xpos double precision,
    ypos double precision,
    nsaid integer,
    zdist double precision,
    sersic_nmgy double precision[],
    sersic_nmgy_ivar double precision[],
    sersic_ok integer,
    sersic_rnmgy double precision[],
    sersic_absmag double precision[],
    sersic_amivar double precision[],
    extinction double precision[],
    sersic_kcorrect double precision[],
    sersic_kcoeff double precision[],
    sersic_mtol double precision[],
    sersic_b300 double precision,
    sersic_b1000 double precision,
    sersic_mets double precision,
    sersic_mass double precision,
    xcen double precision,
    ycen double precision,
    nprof smallint[],
    profmean double precision[],
    profmean_ivar double precision[],
    qstokes double precision[],
    ustokes double precision[],
    bastokes double precision[],
    phistokes double precision[],
    petroflux double precision[],
    petroflux_ivar double precision[],
    fiberflux double precision[],
    fiberflux_ivar double precision[],
    ba50 double precision,
    phi50 double precision,
    ba90 double precision,
    phi90 double precision,
    sersicflux double precision[],
    sersicflux_ivar double precision[],
    sersic_n double precision,
    sersic_ba double precision,
    sersic_phi double precision,
    asymmetry double precision[],
    clumpy double precision[],
    dflags integer[],
    aid integer,
    pid integer,
    dversion character varying,
    proftheta double precision[],
    petrotheta double precision,
    petroth50 double precision,
    petroth90 double precision,
    sersic_th50 double precision,
    plate integer,
    fiberid integer,
    mjd integer,
    racat double precision,
    deccat double precision,
    zsdssline double precision,
    survey character varying,
    programname character varying,
    platequality character varying,
    tile integer,
    plug_ra double precision,
    plug_dec double precision,
    petro_ba_el double precision,
    petro_phi_el double precision,
    petrotheta_el double precision,
    petroflux_el double precision[],
    petroflux_ivar_el double precision[],
    petroth50_el double precision[],
    petroth90_el double precision[],
    petro_nmgy_el double precision[],
    petro_nmgy_ivar_el double precision[],
    petro_ok_el integer,
    petro_rnmgy_el double precision[],
    petro_absmag_el double precision[],
    petro_amivar_el double precision[],
    petro_kcorrect_el double precision[],
    petro_kcoeff_el double precision[],
    petro_mass_el double precision,
    petro_mtol_el double precision[],
    petro_b300_el double precision,
    petro_b1000_el double precision,
    petro_mets_el double precision,
    in_dr7_lss double precision,
    catalogue_pk smallint
);


ALTER TABLE nsa_ssd OWNER TO manga;

SET search_path = platelist, pg_catalog;

SET default_tablespace = '';

--
-- Name: currentmjd; Type: TABLE; Schema: platelist; Owner: manga
--

CREATE TABLE currentmjd (
    pk integer NOT NULL,
    mjd integer,
    modified timestamp without time zone
);


ALTER TABLE currentmjd OWNER TO manga;

--
-- Name: currentmjd_pk_seq; Type: SEQUENCE; Schema: platelist; Owner: manga
--

CREATE SEQUENCE currentmjd_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE currentmjd_pk_seq OWNER TO manga;

--
-- Name: currentmjd_pk_seq; Type: SEQUENCE OWNED BY; Schema: platelist; Owner: manga
--

ALTER SEQUENCE currentmjd_pk_seq OWNED BY currentmjd.pk;


--
-- Name: doiexist; Type: TABLE; Schema: platelist; Owner: manga
--

CREATE TABLE doiexist (
    pk integer NOT NULL,
    label text
);


ALTER TABLE doiexist OWNER TO manga;

--
-- Name: doiexist_pk_seq; Type: SEQUENCE; Schema: platelist; Owner: manga
--

CREATE SEQUENCE doiexist_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE doiexist_pk_seq OWNER TO manga;

--
-- Name: doiexist_pk_seq; Type: SEQUENCE OWNED BY; Schema: platelist; Owner: manga
--

ALTER SEQUENCE doiexist_pk_seq OWNED BY doiexist.pk;


--
-- Name: pl2dto3d; Type: TABLE; Schema: platelist; Owner: manga
--

CREATE TABLE pl2dto3d (
    pk integer NOT NULL,
    platelist2d_pk integer,
    platelist3d_pk integer
);


ALTER TABLE pl2dto3d OWNER TO manga;

--
-- Name: pl2dto3d_pk_seq; Type: SEQUENCE; Schema: platelist; Owner: manga
--

CREATE SEQUENCE pl2dto3d_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pl2dto3d_pk_seq OWNER TO manga;

--
-- Name: pl2dto3d_pk_seq; Type: SEQUENCE OWNED BY; Schema: platelist; Owner: manga
--

ALTER SEQUENCE pl2dto3d_pk_seq OWNED BY pl2dto3d.pk;


--
-- Name: platelist2d; Type: TABLE; Schema: platelist; Owner: manga
--

CREATE TABLE platelist2d (
    pk integer NOT NULL,
    plate integer,
    mjd integer,
    apocomp text,
    status2d text,
    status3d text,
    drp2qual integer,
    type text,
    complete text,
    nscigood integer,
    nscibad integer,
    versdrp2 text,
    verscore text,
    versutil text,
    versprim text,
    cartid integer,
    mapname text,
    survey text,
    platetyp text,
    srvymode text,
    radeg double precision,
    decdeg double precision,
    nexp integer,
    totalexptime real,
    taibeg double precision,
    taiend double precision,
    airmass double precision,
    seeing double precision,
    transpar double precision,
    badifu text,
    b1sn2 double precision,
    r1sn2 double precision,
    b2sn2 double precision,
    r2sn2 double precision,
    b1pstat double precision,
    r1pstat double precision,
    b2pstat double precision,
    r2pstat double precision,
    hrangbeg double precision,
    hrangend double precision,
    airmsbeg double precision,
    airmsend double precision,
    programname text,
    chunk text,
    epoch real,
    isbright text,
    created timestamp without time zone,
    modified timestamp without time zone
);


ALTER TABLE platelist2d OWNER TO manga;

--
-- Name: platelist2d_pk_seq; Type: SEQUENCE; Schema: platelist; Owner: manga
--

CREATE SEQUENCE platelist2d_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE platelist2d_pk_seq OWNER TO manga;

--
-- Name: platelist2d_pk_seq; Type: SEQUENCE OWNED BY; Schema: platelist; Owner: manga
--

ALTER SEQUENCE platelist2d_pk_seq OWNED BY platelist2d.pk;


--
-- Name: platelist3d; Type: TABLE; Schema: platelist; Owner: manga
--

CREATE TABLE platelist3d (
    pk integer NOT NULL,
    plate integer,
    ifudsgn text,
    plateifu text,
    mangaid text,
    status3d text,
    versdrp3 text,
    verscore text,
    versutil text,
    versprim text,
    objra double precision,
    objdec double precision,
    ifura double precision,
    ifudec double precision,
    nexp integer,
    exptime double precision,
    drp3qual integer,
    bluesn2 double precision,
    redsn2 double precision,
    airmsmin double precision,
    airmsmed double precision,
    airmsmax double precision,
    seemin double precision,
    seemed double precision,
    seemax double precision,
    transmin double precision,
    transmed double precision,
    transmax double precision,
    mjdmin integer,
    mjdmed integer,
    mjdmax integer,
    mjdred integer,
    datered text,
    harname text,
    frlplug integer,
    cartid text,
    cenra double precision,
    cendec double precision,
    gfwhm double precision,
    rfwhm double precision,
    ifwhm double precision,
    zfwhm double precision,
    image text,
    srvymode text,
    mngtarg1 integer,
    mngtarg2 integer,
    mngtarg3 text,
    ifuglat double precision,
    ifuglon double precision,
    versdrp2 text,
    ebvgal double precision,
    catidnum integer,
    platetyp text,
    designid integer,
    plttarg text,
    isbright text,
    created timestamp without time zone,
    modified timestamp without time zone
);


ALTER TABLE platelist3d OWNER TO manga;

--
-- Name: platelist3d_pk_seq; Type: SEQUENCE; Schema: platelist; Owner: manga
--

CREATE SEQUENCE platelist3d_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE platelist3d_pk_seq OWNER TO manga;

--
-- Name: platelist3d_pk_seq; Type: SEQUENCE OWNED BY; Schema: platelist; Owner: manga
--

ALTER SEQUENCE platelist3d_pk_seq OWNED BY platelist3d.pk;


SET search_path = mangaauxdb, pg_catalog;

--
-- Name: cube_header pk; Type: DEFAULT; Schema: mangaauxdb; Owner: manga
--

ALTER TABLE ONLY cube_header ALTER COLUMN pk SET DEFAULT nextval('cube_header_pk_seq'::regclass);


--
-- Name: maskbit pk; Type: DEFAULT; Schema: mangaauxdb; Owner: manga
--

ALTER TABLE ONLY maskbit ALTER COLUMN pk SET DEFAULT nextval('maskbit_pk_seq'::regclass);


--
-- Name: maskbit_labels pk; Type: DEFAULT; Schema: mangaauxdb; Owner: manga
--

ALTER TABLE ONLY maskbit_labels ALTER COLUMN pk SET DEFAULT nextval('maskbit_labels_pk_seq'::regclass);


SET search_path = mangadapdb, pg_catalog;

--
-- Name: binmode pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY binmode ALTER COLUMN pk SET DEFAULT nextval('binmode_pk_seq'::regclass);


--
-- Name: bintype pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY bintype ALTER COLUMN pk SET DEFAULT nextval('bintype_pk_seq'::regclass);


--
-- Name: current_default pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY current_default ALTER COLUMN pk SET DEFAULT nextval('current_default_pk_seq'::regclass);


--
-- Name: executionplan pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY executionplan ALTER COLUMN pk SET DEFAULT nextval('executionplan_pk_seq'::regclass);


--
-- Name: extcol pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY extcol ALTER COLUMN pk SET DEFAULT nextval('extcol_pk_seq'::regclass);


--
-- Name: extname pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY extname ALTER COLUMN pk SET DEFAULT nextval('extname_pk_seq'::regclass);


--
-- Name: exttype pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY exttype ALTER COLUMN pk SET DEFAULT nextval('exttype_pk_seq'::regclass);


--
-- Name: file pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY file ALTER COLUMN pk SET DEFAULT nextval('file_pk_seq'::regclass);


--
-- Name: filetype pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY filetype ALTER COLUMN pk SET DEFAULT nextval('filetype_pk_seq'::regclass);


--
-- Name: hdu pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY hdu ALTER COLUMN pk SET DEFAULT nextval('hdu_pk_seq'::regclass);


--
-- Name: hdu_to_extcol pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY hdu_to_extcol ALTER COLUMN pk SET DEFAULT nextval('hdu_to_extcol_pk_seq'::regclass);


--
-- Name: hdu_to_header_value pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY hdu_to_header_value ALTER COLUMN pk SET DEFAULT nextval('hdu_to_header_value_pk_seq'::regclass);


--
-- Name: header_keyword pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY header_keyword ALTER COLUMN pk SET DEFAULT nextval('header_keyword_pk_seq'::regclass);


--
-- Name: header_value pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY header_value ALTER COLUMN pk SET DEFAULT nextval('header_value_pk_seq'::regclass);


--
-- Name: modelcube pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY modelcube ALTER COLUMN pk SET DEFAULT nextval('modelcube_pk_seq'::regclass);


--
-- Name: modelspaxel pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY modelspaxel ALTER COLUMN pk SET DEFAULT nextval('modelspaxel_pk_seq'::regclass);


--
-- Name: redcorr pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY redcorr ALTER COLUMN pk SET DEFAULT nextval('redcorr_pk_seq'::regclass);


--
-- Name: spaxelprop pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY spaxelprop ALTER COLUMN pk SET DEFAULT nextval('junk_pk_seq'::regclass);


--
-- Name: spaxelprop5 pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY spaxelprop5 ALTER COLUMN pk SET DEFAULT nextval('junk5_pk_seq'::regclass);


--
-- Name: structure pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY structure ALTER COLUMN pk SET DEFAULT nextval('structure_pk_seq'::regclass);


--
-- Name: template pk; Type: DEFAULT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY template ALTER COLUMN pk SET DEFAULT nextval('template_pk_seq'::regclass);


SET search_path = mangadatadb, pg_catalog;

--
-- Name: cart pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cart ALTER COLUMN pk SET DEFAULT nextval('cart_pk_seq'::regclass);


--
-- Name: cart_to_cube pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cart_to_cube ALTER COLUMN pk SET DEFAULT nextval('cart_to_cube_pk_seq'::regclass);


--
-- Name: cube pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cube ALTER COLUMN pk SET DEFAULT nextval('cube_pk_seq'::regclass);


--
-- Name: cube_shape pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cube_shape ALTER COLUMN pk SET DEFAULT nextval('cube_shape_pk_seq'::regclass);


--
-- Name: fiber_type pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY fiber_type ALTER COLUMN pk SET DEFAULT nextval('fiber_type_pk_seq'::regclass);


--
-- Name: fibers pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY fibers ALTER COLUMN pk SET DEFAULT nextval('fibers_pk_seq'::regclass);


--
-- Name: fits_header_keyword pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY fits_header_keyword ALTER COLUMN pk SET DEFAULT nextval('fits_header_keyword_pk_seq'::regclass);


--
-- Name: fits_header_value pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY fits_header_value ALTER COLUMN pk SET DEFAULT nextval('fits_header_value_pk_seq'::regclass);


--
-- Name: ifu_to_block pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY ifu_to_block ALTER COLUMN pk SET DEFAULT nextval('ifu_to_block_pk_seq'::regclass);


--
-- Name: ifudesign pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY ifudesign ALTER COLUMN pk SET DEFAULT nextval('ifudesign_pk_seq'::regclass);


--
-- Name: pipeline_completion_status pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY pipeline_completion_status ALTER COLUMN pk SET DEFAULT nextval('pipeline_completion_status_pk_seq'::regclass);


--
-- Name: pipeline_info pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY pipeline_info ALTER COLUMN pk SET DEFAULT nextval('pipeline_info_pk_seq'::regclass);


--
-- Name: pipeline_name pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY pipeline_name ALTER COLUMN pk SET DEFAULT nextval('pipeline_name_pk_seq'::regclass);


--
-- Name: pipeline_stage pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY pipeline_stage ALTER COLUMN pk SET DEFAULT nextval('pipeline_stage_pk_seq'::regclass);


--
-- Name: pipeline_version pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY pipeline_version ALTER COLUMN pk SET DEFAULT nextval('pipeline_version_pk_seq'::regclass);


--
-- Name: rssfiber pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY rssfiber ALTER COLUMN pk SET DEFAULT nextval('rssfiber_pk_seq'::regclass);


--
-- Name: sample pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY sample ALTER COLUMN pk SET DEFAULT nextval('sample_pk_seq'::regclass);


--
-- Name: slitblock pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY slitblock ALTER COLUMN pk SET DEFAULT nextval('slitblock_pk_seq'::regclass);


--
-- Name: spaxel pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY spaxel ALTER COLUMN pk SET DEFAULT nextval('spaxel_pk_seq'::regclass);


--
-- Name: target_type pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY target_type ALTER COLUMN pk SET DEFAULT nextval('target_type_pk_seq'::regclass);


--
-- Name: test_rssfiber pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY test_rssfiber ALTER COLUMN pk SET DEFAULT nextval('test_rssfiber_pk_seq'::regclass);


--
-- Name: test_spaxel pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY test_spaxel ALTER COLUMN pk SET DEFAULT nextval('test_spaxel_pk_seq'::regclass);


--
-- Name: wavelength pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY wavelength ALTER COLUMN pk SET DEFAULT nextval('wavelength_pk_seq'::regclass);


--
-- Name: wcs pk; Type: DEFAULT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY wcs ALTER COLUMN pk SET DEFAULT nextval('wcs_pk_seq'::regclass);


SET search_path = mangasampledb, pg_catalog;

--
-- Name: anime pk; Type: DEFAULT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY anime ALTER COLUMN pk SET DEFAULT nextval('anime_pk_seq'::regclass);


--
-- Name: catalogue pk; Type: DEFAULT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY catalogue ALTER COLUMN pk SET DEFAULT nextval('catalogue_pk_seq'::regclass);


--
-- Name: character pk; Type: DEFAULT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY "character" ALTER COLUMN pk SET DEFAULT nextval('character_pk_seq'::regclass);


--
-- Name: current_catalogue pk; Type: DEFAULT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY current_catalogue ALTER COLUMN pk SET DEFAULT nextval('current_catalogue_pk_seq'::regclass);


--
-- Name: manga_target pk; Type: DEFAULT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY manga_target ALTER COLUMN pk SET DEFAULT nextval('manga_target_pk_seq'::regclass);


--
-- Name: manga_target_to_manga_target pk; Type: DEFAULT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY manga_target_to_manga_target ALTER COLUMN pk SET DEFAULT nextval('manga_target_to_manga_target_pk_seq'::regclass);


--
-- Name: manga_target_to_nsa pk; Type: DEFAULT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY manga_target_to_nsa ALTER COLUMN pk SET DEFAULT nextval('manga_target_to_nsa_pk_seq'::regclass);


--
-- Name: nsa pk; Type: DEFAULT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY nsa ALTER COLUMN pk SET DEFAULT nextval('nsa_pk_seq'::regclass);


SET search_path = platelist, pg_catalog;

--
-- Name: currentmjd pk; Type: DEFAULT; Schema: platelist; Owner: manga
--

ALTER TABLE ONLY currentmjd ALTER COLUMN pk SET DEFAULT nextval('currentmjd_pk_seq'::regclass);


--
-- Name: doiexist pk; Type: DEFAULT; Schema: platelist; Owner: manga
--

ALTER TABLE ONLY doiexist ALTER COLUMN pk SET DEFAULT nextval('doiexist_pk_seq'::regclass);


--
-- Name: pl2dto3d pk; Type: DEFAULT; Schema: platelist; Owner: manga
--

ALTER TABLE ONLY pl2dto3d ALTER COLUMN pk SET DEFAULT nextval('pl2dto3d_pk_seq'::regclass);


--
-- Name: platelist2d pk; Type: DEFAULT; Schema: platelist; Owner: manga
--

ALTER TABLE ONLY platelist2d ALTER COLUMN pk SET DEFAULT nextval('platelist2d_pk_seq'::regclass);


--
-- Name: platelist3d pk; Type: DEFAULT; Schema: platelist; Owner: manga
--

ALTER TABLE ONLY platelist3d ALTER COLUMN pk SET DEFAULT nextval('platelist3d_pk_seq'::regclass);


SET search_path = mangaauxdb, pg_catalog;

--
-- Name: cube_header cube_header_pkey; Type: CONSTRAINT; Schema: mangaauxdb; Owner: manga
--

ALTER TABLE ONLY cube_header
    ADD CONSTRAINT cube_header_pkey PRIMARY KEY (pk);


--
-- Name: maskbit_labels maskbit_labels_pkey; Type: CONSTRAINT; Schema: mangaauxdb; Owner: manga
--

ALTER TABLE ONLY maskbit_labels
    ADD CONSTRAINT maskbit_labels_pkey PRIMARY KEY (pk);


--
-- Name: maskbit maskbit_pkey; Type: CONSTRAINT; Schema: mangaauxdb; Owner: manga
--

ALTER TABLE ONLY maskbit
    ADD CONSTRAINT maskbit_pkey PRIMARY KEY (pk);


SET search_path = mangadapdb, pg_catalog;

--
-- Name: binid binid_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY binid
    ADD CONSTRAINT binid_pkey PRIMARY KEY (pk);


--
-- Name: binmode binmode_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY binmode
    ADD CONSTRAINT binmode_pkey PRIMARY KEY (pk);


--
-- Name: bintype bintype_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY bintype
    ADD CONSTRAINT bintype_pkey PRIMARY KEY (pk);


--
-- Name: current_default current_default_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY current_default
    ADD CONSTRAINT current_default_pkey PRIMARY KEY (pk);


--
-- Name: executionplan executionplan_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY executionplan
    ADD CONSTRAINT executionplan_pkey PRIMARY KEY (pk);


--
-- Name: extcol extcol_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY extcol
    ADD CONSTRAINT extcol_pkey PRIMARY KEY (pk);


--
-- Name: extname extname_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY extname
    ADD CONSTRAINT extname_pkey PRIMARY KEY (pk);


--
-- Name: exttype exttype_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY exttype
    ADD CONSTRAINT exttype_pkey PRIMARY KEY (pk);


--
-- Name: file file_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY file
    ADD CONSTRAINT file_pkey PRIMARY KEY (pk);


--
-- Name: filetype filetype_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY filetype
    ADD CONSTRAINT filetype_pkey PRIMARY KEY (pk);


--
-- Name: flattabletest flattabletest_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY flattabletest
    ADD CONSTRAINT flattabletest_pkey PRIMARY KEY (pk);


--
-- Name: hdu hdu_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY hdu
    ADD CONSTRAINT hdu_pkey PRIMARY KEY (pk);


--
-- Name: hdu_to_extcol hdu_to_extcol_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY hdu_to_extcol
    ADD CONSTRAINT hdu_to_extcol_pkey PRIMARY KEY (pk);


--
-- Name: hdu_to_header_value hdu_to_header_value_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY hdu_to_header_value
    ADD CONSTRAINT hdu_to_header_value_pkey PRIMARY KEY (pk);


--
-- Name: header_keyword header_keyword_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY header_keyword
    ADD CONSTRAINT header_keyword_pkey PRIMARY KEY (pk);


--
-- Name: header_value header_value_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY header_value
    ADD CONSTRAINT header_value_pkey PRIMARY KEY (pk);


--
-- Name: spaxelprop5 junk5_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY spaxelprop5
    ADD CONSTRAINT junk5_pkey PRIMARY KEY (pk);


--
-- Name: spaxelprop junk_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY spaxelprop
    ADD CONSTRAINT junk_pkey PRIMARY KEY (pk);


--
-- Name: modelcube modelcube_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY modelcube
    ADD CONSTRAINT modelcube_pkey PRIMARY KEY (pk);


--
-- Name: modelspaxel modelspaxel_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY modelspaxel
    ADD CONSTRAINT modelspaxel_pkey PRIMARY KEY (pk);


--
-- Name: redcorr redcorr_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY redcorr
    ADD CONSTRAINT redcorr_pkey PRIMARY KEY (pk);


--
-- Name: structure structure_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY structure
    ADD CONSTRAINT structure_pkey PRIMARY KEY (pk);


--
-- Name: template template_pkey; Type: CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY template
    ADD CONSTRAINT template_pkey PRIMARY KEY (pk);


SET search_path = mangadatadb, pg_catalog;

--
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (pk);


--
-- Name: cart_to_cube cart_to_cube_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cart_to_cube
    ADD CONSTRAINT cart_to_cube_pkey PRIMARY KEY (pk);


--
-- Name: cube cube_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cube
    ADD CONSTRAINT cube_pkey PRIMARY KEY (pk);


--
-- Name: cube_shape cube_shape_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cube_shape
    ADD CONSTRAINT cube_shape_pkey PRIMARY KEY (pk);


--
-- Name: fiber_type fiber_type_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY fiber_type
    ADD CONSTRAINT fiber_type_pkey PRIMARY KEY (pk);


--
-- Name: fibers fibers_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY fibers
    ADD CONSTRAINT fibers_pkey PRIMARY KEY (pk);


--
-- Name: fits_header_keyword fits_header_keyword_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY fits_header_keyword
    ADD CONSTRAINT fits_header_keyword_pkey PRIMARY KEY (pk);


--
-- Name: fits_header_value fits_header_value_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY fits_header_value
    ADD CONSTRAINT fits_header_value_pkey PRIMARY KEY (pk);


--
-- Name: ifu_to_block ifu_to_block_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY ifu_to_block
    ADD CONSTRAINT ifu_to_block_pkey PRIMARY KEY (pk);


--
-- Name: ifudesign ifudesign_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY ifudesign
    ADD CONSTRAINT ifudesign_pkey PRIMARY KEY (pk);


--
-- Name: pipeline_completion_status pipeline_completion_status_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY pipeline_completion_status
    ADD CONSTRAINT pipeline_completion_status_pkey PRIMARY KEY (pk);


--
-- Name: pipeline_info pipeline_info_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY pipeline_info
    ADD CONSTRAINT pipeline_info_pkey PRIMARY KEY (pk);


--
-- Name: pipeline_name pipeline_name_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY pipeline_name
    ADD CONSTRAINT pipeline_name_pkey PRIMARY KEY (pk);


--
-- Name: pipeline_stage pipeline_stage_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY pipeline_stage
    ADD CONSTRAINT pipeline_stage_pkey PRIMARY KEY (pk);


--
-- Name: pipeline_version pipeline_version_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY pipeline_version
    ADD CONSTRAINT pipeline_version_pkey PRIMARY KEY (pk);


--
-- Name: rssfiber rssfiber_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY rssfiber
    ADD CONSTRAINT rssfiber_pkey PRIMARY KEY (pk);


--
-- Name: sample sample_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_pkey PRIMARY KEY (pk);


--
-- Name: slitblock slitblock_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY slitblock
    ADD CONSTRAINT slitblock_pkey PRIMARY KEY (pk);


--
-- Name: spaxel spaxel_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY spaxel
    ADD CONSTRAINT spaxel_pkey PRIMARY KEY (pk);


--
-- Name: target_type target_type_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY target_type
    ADD CONSTRAINT target_type_pkey PRIMARY KEY (pk);


--
-- Name: test_rssfiber test_rssfiber_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY test_rssfiber
    ADD CONSTRAINT test_rssfiber_pkey PRIMARY KEY (pk);


--
-- Name: test_spaxel test_spaxel_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY test_spaxel
    ADD CONSTRAINT test_spaxel_pkey PRIMARY KEY (pk);


--
-- Name: wavelength wavelength_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY wavelength
    ADD CONSTRAINT wavelength_pkey PRIMARY KEY (pk);


--
-- Name: wcs wcs_pkey; Type: CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY wcs
    ADD CONSTRAINT wcs_pkey PRIMARY KEY (pk);


SET search_path = mangasampledb, pg_catalog;

--
-- Name: anime anime_pkey; Type: CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY anime
    ADD CONSTRAINT anime_pkey PRIMARY KEY (pk);


--
-- Name: catalogue catalogue_pkey; Type: CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY catalogue
    ADD CONSTRAINT catalogue_pkey PRIMARY KEY (pk);


--
-- Name: character character_pkey; Type: CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY "character"
    ADD CONSTRAINT character_pkey PRIMARY KEY (pk);


--
-- Name: current_catalogue current_catalogue_pkey; Type: CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY current_catalogue
    ADD CONSTRAINT current_catalogue_pkey PRIMARY KEY (pk);


--
-- Name: manga_target manga_target_pkey; Type: CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY manga_target
    ADD CONSTRAINT manga_target_pkey PRIMARY KEY (pk);


--
-- Name: manga_target_to_manga_target manga_target_to_manga_target_pkey; Type: CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY manga_target_to_manga_target
    ADD CONSTRAINT manga_target_to_manga_target_pkey PRIMARY KEY (pk);


--
-- Name: manga_target_to_nsa manga_target_to_nsa_pkey; Type: CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY manga_target_to_nsa
    ADD CONSTRAINT manga_target_to_nsa_pkey PRIMARY KEY (pk);


--
-- Name: nsa nsa_pkey; Type: CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY nsa
    ADD CONSTRAINT nsa_pkey PRIMARY KEY (pk);


--
-- Name: nsa_ssd nsa_ssd_pkey; Type: CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY nsa_ssd
    ADD CONSTRAINT nsa_ssd_pkey PRIMARY KEY (pk);


SET search_path = platelist, pg_catalog;

--
-- Name: currentmjd currentmjd_pkey; Type: CONSTRAINT; Schema: platelist; Owner: manga
--

ALTER TABLE ONLY currentmjd
    ADD CONSTRAINT currentmjd_pkey PRIMARY KEY (pk);


--
-- Name: doiexist doiexist_pkey; Type: CONSTRAINT; Schema: platelist; Owner: manga
--

ALTER TABLE ONLY doiexist
    ADD CONSTRAINT doiexist_pkey PRIMARY KEY (pk);


--
-- Name: pl2dto3d pl2dto3d_pkey; Type: CONSTRAINT; Schema: platelist; Owner: manga
--

ALTER TABLE ONLY pl2dto3d
    ADD CONSTRAINT pl2dto3d_pkey PRIMARY KEY (pk);


--
-- Name: platelist2d platelist2d_pkey; Type: CONSTRAINT; Schema: platelist; Owner: manga
--

ALTER TABLE ONLY platelist2d
    ADD CONSTRAINT platelist2d_pkey PRIMARY KEY (pk);


--
-- Name: platelist3d platelist3d_pkey; Type: CONSTRAINT; Schema: platelist; Owner: manga
--

ALTER TABLE ONLY platelist3d
    ADD CONSTRAINT platelist3d_pkey PRIMARY KEY (pk);


SET search_path = mangadapdb, pg_catalog;

--
-- Name: binid5_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX binid5_idx ON spaxelprop5 USING btree (binid);


--
-- Name: binid_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX binid_idx ON spaxelprop USING btree (binid);


--
-- Name: binid_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX binid_pk_idx ON spaxelprop USING btree (binid_pk);


--
-- Name: clean_binid5_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_binid5_pk_idx ON cleanspaxelprop5 USING btree (binid);


--
-- Name: clean_binid_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_binid_idx ON cleanspaxelprop USING btree (binid);


--
-- Name: clean_d40005_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_d40005_idx ON cleanspaxelprop5 USING btree (specindex_d4000);


--
-- Name: clean_emline5_gflux_ha_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline5_gflux_ha_idx ON cleanspaxelprop5 USING btree (emline_gflux_ha_6564);


--
-- Name: clean_emline5_gflux_hb_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline5_gflux_hb_idx ON cleanspaxelprop5 USING btree (emline_gflux_hb_4862);


--
-- Name: clean_emline5_gflux_nii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline5_gflux_nii_idx ON cleanspaxelprop5 USING btree (emline_gflux_nii_6585);


--
-- Name: clean_emline5_gflux_oii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline5_gflux_oii_idx ON cleanspaxelprop5 USING btree (emline_gflux_oiid_3728);


--
-- Name: clean_emline5_gflux_oiii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline5_gflux_oiii_idx ON cleanspaxelprop5 USING btree (emline_gflux_oiii_5008);


--
-- Name: clean_emline5_gflux_sii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline5_gflux_sii_idx ON cleanspaxelprop5 USING btree (emline_gflux_sii_6718);


--
-- Name: clean_emline_ew_ha_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline_ew_ha_idx ON cleanspaxelprop USING btree (emline_ew_ha_6564);


--
-- Name: clean_emline_gflux_ha_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline_gflux_ha_idx ON cleanspaxelprop USING btree (emline_gflux_ha_6564);


--
-- Name: clean_emline_gflux_hb_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline_gflux_hb_idx ON cleanspaxelprop_old USING btree (emline_gflux_hb_4862);


--
-- Name: clean_emline_gflux_mask_ha_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline_gflux_mask_ha_idx ON cleanspaxelprop USING btree (emline_gflux_mask_ha_6564);


--
-- Name: clean_emline_gflux_nii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline_gflux_nii_idx ON cleanspaxelprop_old USING btree (emline_gflux_nii_6585);


--
-- Name: clean_emline_gflux_oii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline_gflux_oii_idx ON cleanspaxelprop_old USING btree (emline_gflux_oiid_3728);


--
-- Name: clean_emline_gflux_oiii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline_gflux_oiii_idx ON cleanspaxelprop_old USING btree (emline_gflux_oiii_5008);


--
-- Name: clean_emline_gflux_sii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline_gflux_sii_idx ON cleanspaxelprop_old USING btree (emline_gflux_sii_6718);


--
-- Name: clean_emline_ha_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_emline_ha_idx ON cleanspaxelprop_old USING btree (emline_gflux_ha_6564);


--
-- Name: clean_file5_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_file5_pk_idx ON cleanspaxelprop5 USING btree (file_pk);


--
-- Name: clean_file_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_file_pk_idx ON cleanspaxelprop USING btree (file_pk);


--
-- Name: clean_spaxel5_index_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_spaxel5_index_idx ON cleanspaxelprop5 USING btree (spaxel_index);


--
-- Name: clean_spaxel_index_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_spaxel_index_idx ON cleanspaxelprop USING btree (spaxel_index);


--
-- Name: clean_specindex_d4000_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_specindex_d4000_idx ON cleanspaxelprop USING btree (specindex_d4000);


--
-- Name: clean_specindex_mask_d4000_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_specindex_mask_d4000_idx ON cleanspaxelprop USING btree (specindex_mask_d4000);


--
-- Name: clean_stellar_vel_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_stellar_vel_idx ON cleanspaxelprop USING btree (stellar_vel);


--
-- Name: clean_stellar_vel_mask_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_stellar_vel_mask_idx ON cleanspaxelprop USING btree (stellar_vel_mask);


--
-- Name: clean_stvel5_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX clean_stvel5_idx ON cleanspaxelprop5 USING btree (stellar_vel);


--
-- Name: cube_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX cube_pk_idx ON file USING btree (cube_pk);


--
-- Name: cx_c5_cx_ssd_file_pk; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX cx_c5_cx_ssd_file_pk ON c5_cx_ssd USING btree (file_pk) WITH (fillfactor='100');


--
-- Name: cx_c5_flat_ssd_file_pk; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX cx_c5_flat_ssd_file_pk ON c5_flat_ssd USING btree (file_pk) WITH (fillfactor='100');


--
-- Name: cx_c5_ssd_file_pk; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX cx_c5_ssd_file_pk ON c5_ssd USING btree (file_pk) WITH (fillfactor='100');


--
-- Name: cx_file_pk; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX cx_file_pk ON c5_cx USING btree (file_pk) WITH (fillfactor='100');

ALTER TABLE c5_cx CLUSTER ON cx_file_pk;


--
-- Name: emline5_gflux_ha_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX emline5_gflux_ha_idx ON spaxelprop5 USING btree (emline_gflux_ha_6564);


--
-- Name: emline5_gflux_hb_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX emline5_gflux_hb_idx ON spaxelprop5 USING btree (emline_gflux_hb_4862);


--
-- Name: emline5_gflux_nii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX emline5_gflux_nii_idx ON spaxelprop5 USING btree (emline_gflux_nii_6585);


--
-- Name: emline5_gflux_oii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX emline5_gflux_oii_idx ON spaxelprop5 USING btree (emline_gflux_oiid_3728);


--
-- Name: emline5_gflux_oiii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX emline5_gflux_oiii_idx ON spaxelprop5 USING btree (emline_gflux_oiii_5008);


--
-- Name: emline5_gflux_sii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX emline5_gflux_sii_idx ON spaxelprop5 USING btree (emline_gflux_sii_6718);


--
-- Name: emline_gflux_ha_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX emline_gflux_ha_idx ON spaxelprop USING btree (emline_gflux_ha_6564);


--
-- Name: emline_gflux_hb_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX emline_gflux_hb_idx ON spaxelprop USING btree (emline_gflux_hb_4862);


--
-- Name: emline_gflux_nii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX emline_gflux_nii_idx ON spaxelprop USING btree (emline_gflux_nii_6585);


--
-- Name: emline_gflux_oii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX emline_gflux_oii_idx ON spaxelprop USING btree (emline_gflux_oiid_3728);


--
-- Name: emline_gflux_oiii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX emline_gflux_oiii_idx ON spaxelprop USING btree (emline_gflux_oiii_5008);


--
-- Name: emline_gflux_sii_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX emline_gflux_sii_idx ON spaxelprop USING btree (emline_gflux_sii_6718);


--
-- Name: extname_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX extname_pk_idx ON hdu USING btree (extname_pk);


--
-- Name: exttype_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX exttype_pk_idx ON hdu USING btree (exttype_pk);


--
-- Name: file5_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX file5_pk_idx ON spaxelprop5 USING btree (file_pk);


--
-- Name: file_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX file_pk_idx ON hdu USING btree (file_pk);


--
-- Name: flat_binid_ix; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX flat_binid_ix ON flattabletest USING btree (binid);


--
-- Name: flat_dappipe_ix; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX flat_dappipe_ix ON flattabletest USING btree (dappipe);


--
-- Name: flat_drppipe_ix; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX flat_drppipe_ix ON flattabletest USING btree (drppipe);


--
-- Name: flat_emline_gflux_ha_6564_ix; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX flat_emline_gflux_ha_6564_ix ON flattabletest USING btree (emline_gflux_ha_6564);


--
-- Name: flat_emline_sew_ha_6564_ix; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX flat_emline_sew_ha_6564_ix ON flattabletest USING btree (emline_sew_ha_6564);


--
-- Name: flat_name_ix; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX flat_name_ix ON flattabletest USING btree (name);


--
-- Name: flat_nsa_pk_ix; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX flat_nsa_pk_ix ON flattabletest USING btree (nsa_pk);


--
-- Name: flat_plate_ix; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX flat_plate_ix ON flattabletest USING btree (plate);


--
-- Name: flat_plateifu_ix; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX flat_plateifu_ix ON flattabletest USING btree (plateifu);


--
-- Name: hdu_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX hdu_pk_idx ON hdu_to_header_value USING btree (hdu_pk);


--
-- Name: header_keyword_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX header_keyword_pk_idx ON header_value USING btree (header_keyword_pk);


--
-- Name: header_value_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX header_value_pk_idx ON hdu_to_header_value USING btree (header_value_pk);


--
-- Name: id_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX id_idx ON binid USING btree (id);


--
-- Name: ix_binid; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_binid ON c5_cx USING btree (binid) WITH (fillfactor='100');


--
-- Name: ix_c5_cx_ssd_binid; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_cx_ssd_binid ON c5_cx_ssd USING btree (binid) WITH (fillfactor='100');


--
-- Name: ix_c5_cx_ssd_emline_gflux_ha_6564; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_cx_ssd_emline_gflux_ha_6564 ON c5_cx_ssd USING btree (emline_gflux_ha_6564) WITH (fillfactor='100');


--
-- Name: ix_c5_cx_ssd_emline_gflux_hb_4862; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_cx_ssd_emline_gflux_hb_4862 ON c5_cx_ssd USING btree (emline_gflux_hb_4862) WITH (fillfactor='100');


--
-- Name: ix_c5_cx_ssd_emline_gflux_nii_6585; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_cx_ssd_emline_gflux_nii_6585 ON c5_cx_ssd USING btree (emline_gflux_nii_6585) WITH (fillfactor='100');


--
-- Name: ix_c5_cx_ssd_emline_gflux_oiid_3728; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_cx_ssd_emline_gflux_oiid_3728 ON c5_cx_ssd USING btree (emline_gflux_oiid_3728) WITH (fillfactor='100');


--
-- Name: ix_c5_cx_ssd_emline_gflux_oiii_5008; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_cx_ssd_emline_gflux_oiii_5008 ON c5_cx_ssd USING btree (emline_gflux_oiii_5008) WITH (fillfactor='100');


--
-- Name: ix_c5_cx_ssd_emline_gflux_sii_6718; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_cx_ssd_emline_gflux_sii_6718 ON c5_cx_ssd USING btree (emline_gflux_sii_6718) WITH (fillfactor='100');


--
-- Name: ix_c5_cx_ssd_spaxel_index; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_cx_ssd_spaxel_index ON c5_cx_ssd USING btree (spaxel_index) WITH (fillfactor='100');


--
-- Name: ix_c5_cx_ssd_specindex_d4000; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_cx_ssd_specindex_d4000 ON c5_cx_ssd USING btree (specindex_d4000) WITH (fillfactor='100');


--
-- Name: ix_c5_cx_ssd_stellar_vel; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_cx_ssd_stellar_vel ON c5_cx_ssd USING btree (stellar_vel) WITH (fillfactor='100');


--
-- Name: ix_c5_flat_ssd_binid; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_flat_ssd_binid ON c5_flat_ssd USING btree (binid) WITH (fillfactor='100');


--
-- Name: ix_c5_flat_ssd_emline_gflux_ha_6564; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_flat_ssd_emline_gflux_ha_6564 ON c5_flat_ssd USING btree (emline_gflux_ha_6564) WITH (fillfactor='100');


--
-- Name: ix_c5_flat_ssd_emline_gflux_hb_4862; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_flat_ssd_emline_gflux_hb_4862 ON c5_flat_ssd USING btree (emline_gflux_hb_4862) WITH (fillfactor='100');


--
-- Name: ix_c5_flat_ssd_emline_gflux_nii_6585; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_flat_ssd_emline_gflux_nii_6585 ON c5_flat_ssd USING btree (emline_gflux_nii_6585) WITH (fillfactor='100');


--
-- Name: ix_c5_flat_ssd_emline_gflux_oiid_3728; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_flat_ssd_emline_gflux_oiid_3728 ON c5_flat_ssd USING btree (emline_gflux_oiid_3728) WITH (fillfactor='100');


--
-- Name: ix_c5_flat_ssd_emline_gflux_oiii_5008; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_flat_ssd_emline_gflux_oiii_5008 ON c5_flat_ssd USING btree (emline_gflux_oiii_5008) WITH (fillfactor='100');


--
-- Name: ix_c5_flat_ssd_emline_gflux_sii_6718; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_flat_ssd_emline_gflux_sii_6718 ON c5_flat_ssd USING btree (emline_gflux_sii_6718) WITH (fillfactor='100');


--
-- Name: ix_c5_flat_ssd_spaxel_index; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_flat_ssd_spaxel_index ON c5_flat_ssd USING btree (spaxel_index) WITH (fillfactor='100');


--
-- Name: ix_c5_flat_ssd_specindex_d4000; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_flat_ssd_specindex_d4000 ON c5_flat_ssd USING btree (specindex_d4000) WITH (fillfactor='100');


--
-- Name: ix_c5_flat_ssd_stellar_vel; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_flat_ssd_stellar_vel ON c5_flat_ssd USING btree (stellar_vel) WITH (fillfactor='100');


--
-- Name: ix_c5_ssd_binid; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_ssd_binid ON c5_ssd USING btree (binid) WITH (fillfactor='100');


--
-- Name: ix_c5_ssd_emline_gflux_ha_6564; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_ssd_emline_gflux_ha_6564 ON c5_ssd USING btree (emline_gflux_ha_6564) WITH (fillfactor='100');


--
-- Name: ix_c5_ssd_emline_gflux_hb_4862; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_ssd_emline_gflux_hb_4862 ON c5_ssd USING btree (emline_gflux_hb_4862) WITH (fillfactor='100');


--
-- Name: ix_c5_ssd_emline_gflux_nii_6585; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_ssd_emline_gflux_nii_6585 ON c5_ssd USING btree (emline_gflux_nii_6585) WITH (fillfactor='100');


--
-- Name: ix_c5_ssd_emline_gflux_oiid_3728; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_ssd_emline_gflux_oiid_3728 ON c5_ssd USING btree (emline_gflux_oiid_3728) WITH (fillfactor='100');


--
-- Name: ix_c5_ssd_emline_gflux_oiii_5008; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_ssd_emline_gflux_oiii_5008 ON c5_ssd USING btree (emline_gflux_oiii_5008) WITH (fillfactor='100');


--
-- Name: ix_c5_ssd_emline_gflux_sii_6718; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_ssd_emline_gflux_sii_6718 ON c5_ssd USING btree (emline_gflux_sii_6718) WITH (fillfactor='100');


--
-- Name: ix_c5_ssd_spaxel_index; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_ssd_spaxel_index ON c5_ssd USING btree (spaxel_index) WITH (fillfactor='100');


--
-- Name: ix_c5_ssd_specindex_d4000; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_ssd_specindex_d4000 ON c5_ssd USING btree (specindex_d4000) WITH (fillfactor='100');


--
-- Name: ix_c5_ssd_stellar_vel; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_c5_ssd_stellar_vel ON c5_ssd USING btree (stellar_vel) WITH (fillfactor='100');


--
-- Name: ix_emline_gflux_ha_6564; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_emline_gflux_ha_6564 ON c5_cx USING btree (emline_gflux_ha_6564) WITH (fillfactor='100');


--
-- Name: ix_emline_gflux_hb_4862; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_emline_gflux_hb_4862 ON c5_cx USING btree (emline_gflux_hb_4862) WITH (fillfactor='100');


--
-- Name: ix_emline_gflux_nii_6585; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_emline_gflux_nii_6585 ON c5_cx USING btree (emline_gflux_nii_6585) WITH (fillfactor='100');


--
-- Name: ix_emline_gflux_oiid_3728; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_emline_gflux_oiid_3728 ON c5_cx USING btree (emline_gflux_oiid_3728) WITH (fillfactor='100');


--
-- Name: ix_emline_gflux_oiii_5008; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_emline_gflux_oiii_5008 ON c5_cx USING btree (emline_gflux_oiii_5008) WITH (fillfactor='100');


--
-- Name: ix_emline_gflux_sii_6718; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_emline_gflux_sii_6718 ON c5_cx USING btree (emline_gflux_sii_6718) WITH (fillfactor='100');


--
-- Name: ix_spaxel_index; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_spaxel_index ON c5_cx USING btree (spaxel_index) WITH (fillfactor='100');


--
-- Name: ix_specindex_d4000; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_specindex_d4000 ON c5_cx USING btree (specindex_d4000) WITH (fillfactor='100');


--
-- Name: ix_stellar_vel; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ix_stellar_vel ON c5_cx USING btree (stellar_vel) WITH (fillfactor='100');


--
-- Name: mc_file_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX mc_file_pk_idx ON modelcube USING btree (file_pk);


--
-- Name: mc_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX mc_pk_idx ON modelspaxel USING btree (modelcube_pk);


--
-- Name: ms_x_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ms_x_idx ON modelspaxel USING btree (x);


--
-- Name: ms_y_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX ms_y_idx ON modelspaxel USING btree (y);


--
-- Name: pipeline_info_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX pipeline_info_pk_idx ON file USING btree (pipeline_info_pk);


--
-- Name: sp_file_pk_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX sp_file_pk_idx ON spaxelprop USING btree (file_pk);


--
-- Name: spaxel5_index_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX spaxel5_index_idx ON spaxelprop5 USING btree (spaxel_index);


--
-- Name: spaxel_index_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX spaxel_index_idx ON spaxelprop USING btree (spaxel_index);


--
-- Name: specindex_mask_d4000_idx; Type: INDEX; Schema: mangadapdb; Owner: manga
--

CREATE INDEX specindex_mask_d4000_idx ON spaxelprop USING btree (specindex_mask_d4000);


SET search_path = mangadatadb, pg_catalog;

--
-- Name: cube_shape_pk_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX cube_shape_pk_idx ON cube USING btree (cube_shape_pk);


--
-- Name: fibers_pk_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX fibers_pk_idx ON rssfiber USING btree (fibers_pk);


--
-- Name: fits_header_keyword_pk_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX fits_header_keyword_pk_idx ON fits_header_value USING btree (fits_header_keyword_pk);


--
-- Name: fitshead_cube_pk_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX fitshead_cube_pk_idx ON fits_header_value USING btree (cube_pk);


--
-- Name: ifudesign_pk_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX ifudesign_pk_idx ON cube USING btree (ifudesign_pk);


--
-- Name: manga_target_pk_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX manga_target_pk_idx ON cube USING btree (manga_target_pk);


--
-- Name: pipeline_version_pk_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX pipeline_version_pk_idx ON pipeline_info USING btree (pipeline_version_pk);


--
-- Name: pipelineinfo_pk_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX pipelineinfo_pk_idx ON cube USING btree (pipeline_info_pk);


--
-- Name: rssfib_cube_pk_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX rssfib_cube_pk_idx ON rssfiber USING btree (cube_pk);


--
-- Name: spax_x_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX spax_x_idx ON spaxel USING btree (x);


--
-- Name: spax_y_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX spax_y_idx ON spaxel USING btree (y);


--
-- Name: spaxel_cube_pk_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX spaxel_cube_pk_idx ON spaxel USING btree (cube_pk);


--
-- Name: test_spaxel_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX test_spaxel_idx ON test_spaxel USING gin (flux, ivar, mask);


--
-- Name: wave_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX wave_idx ON wavelength USING gin (wavelength);


--
-- Name: wavelength_pk_idx; Type: INDEX; Schema: mangadatadb; Owner: manga
--

CREATE INDEX wavelength_pk_idx ON cube USING btree (wavelength_pk);


SET search_path = mangasampledb, pg_catalog;

--
-- Name: ix_nsa_sersic_mass_idx; Type: INDEX; Schema: mangasampledb; Owner: manga
--

CREATE INDEX ix_nsa_sersic_mass_idx ON nsa_ssd USING btree (sersic_mass) WITH (fillfactor='100');


--
-- Name: ix_nsa_sersic_n_idx; Type: INDEX; Schema: mangasampledb; Owner: manga
--

CREATE INDEX ix_nsa_sersic_n_idx ON nsa_ssd USING btree (sersic_n);


--
-- Name: ix_nsa_z_idx; Type: INDEX; Schema: mangasampledb; Owner: manga
--

CREATE INDEX ix_nsa_z_idx ON nsa_ssd USING btree (z);


--
-- Name: nsa_sersic_mass_idx; Type: INDEX; Schema: mangasampledb; Owner: manga
--

CREATE INDEX nsa_sersic_mass_idx ON nsa USING btree (sersic_mass);


--
-- Name: nsa_sersic_n_idx; Type: INDEX; Schema: mangasampledb; Owner: manga
--

CREATE INDEX nsa_sersic_n_idx ON nsa USING btree (sersic_n);


--
-- Name: nsa_z_idx; Type: INDEX; Schema: mangasampledb; Owner: manga
--

CREATE INDEX nsa_z_idx ON nsa USING btree (z);


SET search_path = mangaauxdb, pg_catalog;

--
-- Name: cube_header cube_fk; Type: FK CONSTRAINT; Schema: mangaauxdb; Owner: manga
--

ALTER TABLE ONLY cube_header
    ADD CONSTRAINT cube_fk FOREIGN KEY (cube_pk) REFERENCES mangadatadb.cube(pk) ON UPDATE CASCADE ON DELETE CASCADE;


SET search_path = mangadapdb, pg_catalog;

--
-- Name: cleanspaxelprop5 binid_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY cleanspaxelprop5
    ADD CONSTRAINT binid_fk FOREIGN KEY (binid_pk) REFERENCES binid(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cleanspaxelprop binid_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY cleanspaxelprop
    ADD CONSTRAINT binid_fk FOREIGN KEY (binid_pk) REFERENCES binid(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spaxelprop5 binid_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY spaxelprop5
    ADD CONSTRAINT binid_fk FOREIGN KEY (binid_pk) REFERENCES binid(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spaxelprop binid_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY spaxelprop
    ADD CONSTRAINT binid_fk FOREIGN KEY (binid_pk) REFERENCES binid(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: structure binmode_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY structure
    ADD CONSTRAINT binmode_fk FOREIGN KEY (binmode_pk) REFERENCES binmode(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: structure bintype_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY structure
    ADD CONSTRAINT bintype_fk FOREIGN KEY (bintype_pk) REFERENCES bintype(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: file cube_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY file
    ADD CONSTRAINT cube_fk FOREIGN KEY (cube_pk) REFERENCES mangadatadb.cube(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: structure executionplan_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY structure
    ADD CONSTRAINT executionplan_fk FOREIGN KEY (executionplan_pk) REFERENCES executionplan(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hdu_to_extcol extcol_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY hdu_to_extcol
    ADD CONSTRAINT extcol_fk FOREIGN KEY (extcol_pk) REFERENCES extcol(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hdu extname_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY hdu
    ADD CONSTRAINT extname_fk FOREIGN KEY (extname_pk) REFERENCES extname(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hdu exttype_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY hdu
    ADD CONSTRAINT exttype_fk FOREIGN KEY (exttype_pk) REFERENCES exttype(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: current_default file_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY current_default
    ADD CONSTRAINT file_fk FOREIGN KEY (file_pk) REFERENCES file(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: modelcube file_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY modelcube
    ADD CONSTRAINT file_fk FOREIGN KEY (file_pk) REFERENCES file(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hdu file_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY hdu
    ADD CONSTRAINT file_fk FOREIGN KEY (file_pk) REFERENCES file(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cleanspaxelprop5 file_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY cleanspaxelprop5
    ADD CONSTRAINT file_fk FOREIGN KEY (file_pk) REFERENCES file(pk);


--
-- Name: cleanspaxelprop file_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY cleanspaxelprop
    ADD CONSTRAINT file_fk FOREIGN KEY (file_pk) REFERENCES file(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cleanspaxelprop_old file_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY cleanspaxelprop_old
    ADD CONSTRAINT file_fk FOREIGN KEY (file_pk) REFERENCES file(pk);


--
-- Name: spaxelprop5 file_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY spaxelprop5
    ADD CONSTRAINT file_fk FOREIGN KEY (file_pk) REFERENCES file(pk);


--
-- Name: spaxelprop file_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY spaxelprop
    ADD CONSTRAINT file_fk FOREIGN KEY (file_pk) REFERENCES file(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: file filetype_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY file
    ADD CONSTRAINT filetype_fk FOREIGN KEY (filetype_pk) REFERENCES filetype(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hdu_to_extcol hdu_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY hdu_to_extcol
    ADD CONSTRAINT hdu_fk FOREIGN KEY (hdu_pk) REFERENCES hdu(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hdu_to_header_value hdu_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY hdu_to_header_value
    ADD CONSTRAINT hdu_fk FOREIGN KEY (hdu_pk) REFERENCES hdu(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: header_value header_keyword_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY header_value
    ADD CONSTRAINT header_keyword_fk FOREIGN KEY (header_keyword_pk) REFERENCES header_keyword(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hdu_to_header_value header_value_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY hdu_to_header_value
    ADD CONSTRAINT header_value_fk FOREIGN KEY (header_value_pk) REFERENCES header_value(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: redcorr modelcube_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY redcorr
    ADD CONSTRAINT modelcube_fk FOREIGN KEY (modelcube_pk) REFERENCES modelcube(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: modelspaxel modelcube_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY modelspaxel
    ADD CONSTRAINT modelcube_fk FOREIGN KEY (modelcube_pk) REFERENCES modelcube(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: file pipeline_info_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY file
    ADD CONSTRAINT pipeline_info_fk FOREIGN KEY (pipeline_info_pk) REFERENCES mangadatadb.pipeline_info(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: file structure_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY file
    ADD CONSTRAINT structure_fk FOREIGN KEY (structure_pk) REFERENCES structure(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: structure template_kin_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY structure
    ADD CONSTRAINT template_kin_fk FOREIGN KEY (template_kin_pk) REFERENCES template(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: structure template_pop_fk; Type: FK CONSTRAINT; Schema: mangadapdb; Owner: manga
--

ALTER TABLE ONLY structure
    ADD CONSTRAINT template_pop_fk FOREIGN KEY (template_pop_pk) REFERENCES template(pk) ON UPDATE CASCADE ON DELETE CASCADE;


SET search_path = mangadatadb, pg_catalog;

--
-- Name: cart_to_cube cart_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cart_to_cube
    ADD CONSTRAINT cart_fk FOREIGN KEY (cart_pk) REFERENCES cart(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fits_header_value cube_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY fits_header_value
    ADD CONSTRAINT cube_fk FOREIGN KEY (cube_pk) REFERENCES cube(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sample cube_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT cube_fk FOREIGN KEY (cube_pk) REFERENCES cube(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: test_rssfiber cube_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY test_rssfiber
    ADD CONSTRAINT cube_fk FOREIGN KEY (cube_pk) REFERENCES cube(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cart_to_cube cube_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cart_to_cube
    ADD CONSTRAINT cube_fk FOREIGN KEY (cube_pk) REFERENCES cube(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: test_spaxel cube_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY test_spaxel
    ADD CONSTRAINT cube_fk FOREIGN KEY (cube_pk) REFERENCES cube(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wcs cube_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY wcs
    ADD CONSTRAINT cube_fk FOREIGN KEY (cube_pk) REFERENCES cube(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: rssfiber cube_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY rssfiber
    ADD CONSTRAINT cube_fk FOREIGN KEY (cube_pk) REFERENCES cube(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spaxel cube_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY spaxel
    ADD CONSTRAINT cube_fk FOREIGN KEY (cube_pk) REFERENCES cube(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cube cube_shape_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cube
    ADD CONSTRAINT cube_shape_fk FOREIGN KEY (cube_shape_pk) REFERENCES cube_shape(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fibers fiber_type_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY fibers
    ADD CONSTRAINT fiber_type_fk FOREIGN KEY (fiber_type_pk) REFERENCES fiber_type(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: rssfiber fibers_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY rssfiber
    ADD CONSTRAINT fibers_fk FOREIGN KEY (fibers_pk) REFERENCES fibers(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fits_header_value fits_header_keyword_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY fits_header_value
    ADD CONSTRAINT fits_header_keyword_fk FOREIGN KEY (fits_header_keyword_pk) REFERENCES fits_header_keyword(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cube ifudesign_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cube
    ADD CONSTRAINT ifudesign_fk FOREIGN KEY (ifudesign_pk) REFERENCES ifudesign(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ifu_to_block ifudesign_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY ifu_to_block
    ADD CONSTRAINT ifudesign_fk FOREIGN KEY (ifudesign_pk) REFERENCES ifudesign(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fibers ifudesign_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY fibers
    ADD CONSTRAINT ifudesign_fk FOREIGN KEY (ifudesign_pk) REFERENCES ifudesign(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cube manga_target_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cube
    ADD CONSTRAINT manga_target_fk FOREIGN KEY (manga_target_pk) REFERENCES mangasampledb.manga_target(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pipeline_info pipeline_completion_status_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY pipeline_info
    ADD CONSTRAINT pipeline_completion_status_fk FOREIGN KEY (pipeline_completion_status_pk) REFERENCES pipeline_completion_status(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cube pipeline_info_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cube
    ADD CONSTRAINT pipeline_info_fk FOREIGN KEY (pipeline_info_pk) REFERENCES pipeline_info(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pipeline_info pipeline_name_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY pipeline_info
    ADD CONSTRAINT pipeline_name_fk FOREIGN KEY (pipeline_name_pk) REFERENCES pipeline_name(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pipeline_info pipeline_stage_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY pipeline_info
    ADD CONSTRAINT pipeline_stage_fk FOREIGN KEY (pipeline_stage_pk) REFERENCES pipeline_stage(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pipeline_info pipeline_version_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY pipeline_info
    ADD CONSTRAINT pipeline_version_fk FOREIGN KEY (pipeline_version_pk) REFERENCES pipeline_version(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ifu_to_block slitblock_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY ifu_to_block
    ADD CONSTRAINT slitblock_fk FOREIGN KEY (slitblock_pk) REFERENCES slitblock(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fibers target_type_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY fibers
    ADD CONSTRAINT target_type_fk FOREIGN KEY (target_type_pk) REFERENCES target_type(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cube wavelength_fk; Type: FK CONSTRAINT; Schema: mangadatadb; Owner: manga
--

ALTER TABLE ONLY cube
    ADD CONSTRAINT wavelength_fk FOREIGN KEY (wavelength_pk) REFERENCES wavelength(pk) ON UPDATE CASCADE ON DELETE CASCADE;


SET search_path = mangasampledb, pg_catalog;

--
-- Name: character anime_fk; Type: FK CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY "character"
    ADD CONSTRAINT anime_fk FOREIGN KEY (anime_pk) REFERENCES anime(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: current_catalogue catalogue_fk; Type: FK CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY current_catalogue
    ADD CONSTRAINT catalogue_fk FOREIGN KEY (catalogue_pk) REFERENCES catalogue(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: manga_target_to_manga_target manga_target1_fk; Type: FK CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY manga_target_to_manga_target
    ADD CONSTRAINT manga_target1_fk FOREIGN KEY (manga_target1_pk) REFERENCES manga_target(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: manga_target_to_manga_target manga_target2_fk; Type: FK CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY manga_target_to_manga_target
    ADD CONSTRAINT manga_target2_fk FOREIGN KEY (manga_target2_pk) REFERENCES manga_target(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: character manga_target_fk; Type: FK CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY "character"
    ADD CONSTRAINT manga_target_fk FOREIGN KEY (manga_target_pk) REFERENCES manga_target(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: manga_target_to_nsa manga_target_to_nsa_manga_target_pk_fkey; Type: FK CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY manga_target_to_nsa
    ADD CONSTRAINT manga_target_to_nsa_manga_target_pk_fkey FOREIGN KEY (manga_target_pk) REFERENCES manga_target(pk);


--
-- Name: manga_target_to_nsa manga_target_to_nsa_nsa_pk_fkey; Type: FK CONSTRAINT; Schema: mangasampledb; Owner: manga
--

ALTER TABLE ONLY manga_target_to_nsa
    ADD CONSTRAINT manga_target_to_nsa_nsa_pk_fkey FOREIGN KEY (nsa_pk) REFERENCES nsa(pk);


SET search_path = platelist, pg_catalog;

--
-- Name: pl2dto3d platelist2d_fk; Type: FK CONSTRAINT; Schema: platelist; Owner: manga
--

ALTER TABLE ONLY pl2dto3d
    ADD CONSTRAINT platelist2d_fk FOREIGN KEY (platelist2d_pk) REFERENCES platelist2d(pk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

