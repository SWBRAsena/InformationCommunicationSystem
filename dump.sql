--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2 (Debian 12.2-2.pgdg100+1)
-- Dumped by pg_dump version 13.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


--
-- Name: asbinary(public.geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.asbinary(public.geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_asBinary';


ALTER FUNCTION public.asbinary(public.geometry) OWNER TO postgres;

--
-- Name: asbinary(public.geometry, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.asbinary(public.geometry, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_asBinary';


ALTER FUNCTION public.asbinary(public.geometry, text) OWNER TO postgres;

--
-- Name: astext(public.geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.astext(public.geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_asText';


ALTER FUNCTION public.astext(public.geometry) OWNER TO postgres;

--
-- Name: estimated_extent(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.estimated_extent(text, text) RETURNS public.box2d
    LANGUAGE c IMMUTABLE STRICT SECURITY DEFINER
    AS '$libdir/postgis-3', 'geometry_estimated_extent';


ALTER FUNCTION public.estimated_extent(text, text) OWNER TO postgres;

--
-- Name: estimated_extent(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.estimated_extent(text, text, text) RETURNS public.box2d
    LANGUAGE c IMMUTABLE STRICT SECURITY DEFINER
    AS '$libdir/postgis-3', 'geometry_estimated_extent';


ALTER FUNCTION public.estimated_extent(text, text, text) OWNER TO postgres;

--
-- Name: geomfromtext(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.geomfromtext(text) RETURNS public.geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_GeomFromText($1)$_$;


ALTER FUNCTION public.geomfromtext(text) OWNER TO postgres;

--
-- Name: geomfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.geomfromtext(text, integer) RETURNS public.geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_GeomFromText($1, $2)$_$;


ALTER FUNCTION public.geomfromtext(text, integer) OWNER TO postgres;

--
-- Name: ndims(public.geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ndims(public.geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_ndims';


ALTER FUNCTION public.ndims(public.geometry) OWNER TO postgres;

--
-- Name: setsrid(public.geometry, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.setsrid(public.geometry, integer) RETURNS public.geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_set_srid';


ALTER FUNCTION public.setsrid(public.geometry, integer) OWNER TO postgres;

--
-- Name: srid(public.geometry); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.srid(public.geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-3', 'LWGEOM_get_srid';


ALTER FUNCTION public.srid(public.geometry) OWNER TO postgres;

--
-- Name: st_asbinary(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.st_asbinary(text) RETURNS bytea
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsBinary($1::geometry);$_$;


ALTER FUNCTION public.st_asbinary(text) OWNER TO postgres;

--
-- Name: st_astext(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.st_astext(bytea) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsText($1::geometry);$_$;


ALTER FUNCTION public.st_astext(bytea) OWNER TO postgres;

--
-- Name: gist_geometry_ops; Type: OPERATOR FAMILY; Schema: public; Owner: postgres
--

CREATE OPERATOR FAMILY public.gist_geometry_ops USING gist;


ALTER OPERATOR FAMILY public.gist_geometry_ops USING gist OWNER TO postgres;

--
-- Name: gist_geometry_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS public.gist_geometry_ops
    FOR TYPE public.geometry USING gist FAMILY public.gist_geometry_ops AS
    STORAGE public.box2df ,
    OPERATOR 1 public.<<(public.geometry,public.geometry) ,
    OPERATOR 2 public.&<(public.geometry,public.geometry) ,
    OPERATOR 3 public.&&(public.geometry,public.geometry) ,
    OPERATOR 4 public.&>(public.geometry,public.geometry) ,
    OPERATOR 5 public.>>(public.geometry,public.geometry) ,
    OPERATOR 6 public.~=(public.geometry,public.geometry) ,
    OPERATOR 7 public.~(public.geometry,public.geometry) ,
    OPERATOR 8 public.@(public.geometry,public.geometry) ,
    OPERATOR 9 public.&<|(public.geometry,public.geometry) ,
    OPERATOR 10 public.<<|(public.geometry,public.geometry) ,
    OPERATOR 11 public.|>>(public.geometry,public.geometry) ,
    OPERATOR 12 public.|&>(public.geometry,public.geometry) ,
    OPERATOR 13 public.<->(public.geometry,public.geometry) FOR ORDER BY pg_catalog.float_ops ,
    OPERATOR 14 public.<#>(public.geometry,public.geometry) FOR ORDER BY pg_catalog.float_ops ,
    FUNCTION 1 (public.geometry, public.geometry) public.geometry_gist_consistent_2d(internal,public.geometry,integer) ,
    FUNCTION 2 (public.geometry, public.geometry) public.geometry_gist_union_2d(bytea,internal) ,
    FUNCTION 3 (public.geometry, public.geometry) public.geometry_gist_compress_2d(internal) ,
    FUNCTION 4 (public.geometry, public.geometry) public.geometry_gist_decompress_2d(internal) ,
    FUNCTION 5 (public.geometry, public.geometry) public.geometry_gist_penalty_2d(internal,internal,internal) ,
    FUNCTION 6 (public.geometry, public.geometry) public.geometry_gist_picksplit_2d(internal,internal) ,
    FUNCTION 7 (public.geometry, public.geometry) public.geometry_gist_same_2d(public.geometry,public.geometry,internal) ,
    FUNCTION 8 (public.geometry, public.geometry) public.geometry_gist_distance_2d(internal,public.geometry,integer);


ALTER OPERATOR CLASS public.gist_geometry_ops USING gist OWNER TO postgres;

--
-- Name: ap_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.ap_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ap_id_seq OWNER TO docker;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ap_table; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.ap_table (
    id integer DEFAULT nextval('public.ap_id_seq'::regclass) NOT NULL,
    ap_name character varying,
    ap_floor integer,
    ap_x double precision,
    ap_y double precision,
    ap_y_floor double precision,
    ap_y_height double precision
);


ALTER TABLE public.ap_table OWNER TO docker;

--
-- Name: ics_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.ics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ics_id_seq OWNER TO docker;

--
-- Name: ics_table; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.ics_table (
    location_floor integer NOT NULL,
    location character varying NOT NULL,
    ave_dbm double precision,
    med_dbm double precision,
    center_freq_mhz integer NOT NULL,
    counts_per_100 integer,
    ap_name character varying NOT NULL,
    location_x double precision,
    location_y double precision,
    location_y_floor double precision,
    location_y_height double precision,
    ap_floor integer,
    ap_x double precision,
    ap_y double precision,
    ap_y_floor double precision,
    ap_y_height double precision
);


ALTER TABLE public.ics_table OWNER TO docker;

--
-- Name: location_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.location_id_seq OWNER TO docker;

--
-- Name: location_table; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.location_table (
    id integer DEFAULT nextval('public.location_id_seq'::regclass) NOT NULL,
    location_floor integer,
    building character varying,
    location character varying,
    location_x double precision,
    location_y double precision,
    location_y_floor double precision,
    location_y_height double precision
);


ALTER TABLE public.location_table OWNER TO docker;

--
-- Name: measured_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.measured_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.measured_id_seq OWNER TO docker;

--
-- Name: measured_table; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.measured_table (
    id integer DEFAULT nextval('public.measured_id_seq'::regclass) NOT NULL,
    location_floor integer,
    location character varying,
    ave_dbm double precision,
    med_dbm double precision,
    center_freq_mhz integer,
    counts_per_100 integer,
    ap_name character varying
);


ALTER TABLE public.measured_table OWNER TO docker;

--
-- Data for Name: ap_table; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.ap_table (id, ap_name, ap_floor, ap_x, ap_y, ap_y_floor, ap_y_height) FROM stdin;
1	AP-C-1F-01	1	15.4	0	0	2.5
2	AP-C-2F-01	2	25.1	0	3.6	6.1
3	AP-C-2F-02	2	13.5	0	3.6	6.1
4	AP-C-2F-03	2	26	-5.6	3.6	6.1
5	AP-C-3F-01	3	-1.9	-11.2	7.2	9.7
6	AP-C-3F-02	3	30.1	0	7.2	9.7
7	AP-C-3F-03	3	20.8	0	7.2	9.7
8	AP-C-3F-04	3	9.1	0	7.2	9.7
9	AP-C-4F-01	4	-1.9	-11.2	10.8	13.3
10	AP-C-4F-02	4	30.1	0	10.8	13.3
11	AP-C-4F-03	4	20.8	0	10.8	13.3
12	AP-C-4F-04	4	9.2	0	10.8	13.3
13	AP-C-5F-01	5	-1.9	-11.2	14.4	16.9
14	AP-C-5F-02	5	32.2	0	14.4	16.9
15	AP-C-5F-03	5	23	0	14.4	16.9
16	AP-C-5F-04	5	9.1	0	14.4	16.9
17	AP-C-6F-01	6	-1.9	-11.2	18	20.5
18	AP-C-6F-02	6	31.8	0	18	20.5
19	AP-C-6F-03	6	22.9	0	18	20.5
20	AP-C-6F-04	6	9.2	0	18	20.5
21	AP-C1-1F-01	1	32.4	22.2	0	2.5
22	AP-C1-1F-02	1	34	25.5	0	2.5
23	AP-C1-2F-01	2	33.6	20.6	3.6	6.1
24	AP-C1-2F-02	2	43.6	30.3	3.6	6.1
25	AP-C1-2F-03	2	30	23.2	3.6	6.1
26	AP-C1-3F-01	3	31.5	15.8	7.2	9.7
27	AP-C1-3F-02	3	34	23.2	7.2	9.7
28	AP-C1-3F-03	3	27.4	26.4	7.2	9.7
29	AP-C1-4F-01	4	36.3	18.3	10.8	13.3
30	AP-C1-4F-02	4	31.8	21.8	10.8	13.3
31	AP-C2-1F-01	1	0	22.7	0	2.5
32	AP-C2-1F-02	1	0	29.8	0	2.5
33	AP-C2-1F-03	1	0	41.7	0	2.5
34	AP-C2-2F-01	2	0	19.1	3.6	6.1
35	AP-C2-2F-02	2	0	29.9	3.6	6.1
36	AP-C2-2F-03	2	0	44.1	3.6	6.1
37	AP-C2-3F-01	3	0	15.6	7.2	9.7
38	AP-C2-3F-02	3	0	30.7	7.2	9.7
39	AP-C2-3F-03	3	0	44.2	7.2	9.7
40	AP-C2-4F-01	4	0	22.6	10.8	13.3
41	AP-C2-4F-02	4	0	30	10.8	13.3
42	AP-C2-4F-03	4	0	41.7	10.8	13.3
43	AP-C2-5F-01	5	0	22.3	14.4	16.9
44	AP-C2-5F-02	5	0	30	14.4	16.9
45	AP-C2-5F-03	5	0	41.7	14.4	16.9
46	AP-C2-6F-01	6	0	22.3	18	20.5
47	AP-C2-6F-02	6	0	30	18	20.5
48	AP-C2-6F-03	6	0	41.2	18	20.5
49	AP-C3-1F-01	1	25.8	56	0	2.5
50	AP-C3-1F-02	1	12.9	56	0	2.5
51	AP-C3-2F-01	2	25.9	56	3.6	6.1
52	AP-C3-2F-02	2	15.2	56	3.6	6.1
53	AP-C3-2F-03	2	4	56	3.6	6.1
54	AP-C3-3F-01	3	25.7	56	7.2	9.7
55	AP-C3-3F-02	3	13.6	56	7.2	9.7
56	AP-C3-3F-03	3	4.6	56	7.2	9.7
57	AP-C3-4F-01	4	24.5	56	10.8	13.3
58	AP-C3-4F-02	4	10	56	10.8	13.3
59	AP-C3-5F-01	5	25.6	56	14.4	16.9
60	AP-C3-5F-02	5	9.5	56	14.4	16.9
61	AP-C3-6F-01	6	24.4	56	18	20.5
62	AP-C3-6F-02	6	10	56	18	20.5
63	AP-C-1F-01	1	15.4	0	0	2.5
64	AP-C-2F-01	2	25.1	0	3.6	6.1
65	AP-C-2F-02	2	13.5	0	3.6	6.1
66	AP-C-2F-03	2	26	-5.6	3.6	6.1
67	AP-C-3F-01	3	-1.9	-11.2	7.2	9.7
68	AP-C-3F-02	3	30.1	0	7.2	9.7
69	AP-C-3F-03	3	20.8	0	7.2	9.7
70	AP-C-3F-04	3	9.1	0	7.2	9.7
71	AP-C-4F-01	4	-1.9	-11.2	10.8	13.3
72	AP-C-4F-02	4	30.1	0	10.8	13.3
73	AP-C-4F-03	4	20.8	0	10.8	13.3
74	AP-C-4F-04	4	9.2	0	10.8	13.3
75	AP-C-5F-01	5	-1.9	-11.2	14.4	16.9
76	AP-C-5F-02	5	32.2	0	14.4	16.9
77	AP-C-5F-03	5	23	0	14.4	16.9
78	AP-C-5F-04	5	9.1	0	14.4	16.9
79	AP-C-6F-01	6	-1.9	-11.2	18	20.5
80	AP-C-6F-02	6	31.8	0	18	20.5
81	AP-C-6F-03	6	22.9	0	18	20.5
82	AP-C-6F-04	6	9.2	0	18	20.5
83	AP-C1-1F-01	1	32.4	22.2	0	2.5
84	AP-C1-1F-02	1	34	25.5	0	2.5
85	AP-C1-2F-01	2	33.6	20.6	3.6	6.1
86	AP-C1-2F-02	2	43.6	30.3	3.6	6.1
87	AP-C1-2F-03	2	30	23.2	3.6	6.1
88	AP-C1-3F-01	3	31.5	15.8	7.2	9.7
89	AP-C1-3F-02	3	34	23.2	7.2	9.7
90	AP-C1-3F-03	3	27.4	26.4	7.2	9.7
91	AP-C1-4F-01	4	36.3	18.3	10.8	13.3
92	AP-C1-4F-02	4	31.8	21.8	10.8	13.3
93	AP-C2-1F-01	1	0	22.7	0	2.5
94	AP-C2-1F-02	1	0	29.8	0	2.5
95	AP-C2-1F-03	1	0	41.7	0	2.5
96	AP-C2-2F-01	2	0	19.1	3.6	6.1
97	AP-C2-2F-02	2	0	29.9	3.6	6.1
98	AP-C2-2F-03	2	0	44.1	3.6	6.1
99	AP-C2-3F-01	3	0	15.6	7.2	9.7
100	AP-C2-3F-02	3	0	30.7	7.2	9.7
101	AP-C2-3F-03	3	0	44.2	7.2	9.7
102	AP-C2-4F-01	4	0	22.6	10.8	13.3
103	AP-C2-4F-02	4	0	30	10.8	13.3
104	AP-C2-4F-03	4	0	41.7	10.8	13.3
105	AP-C2-5F-01	5	0	22.3	14.4	16.9
106	AP-C2-5F-02	5	0	30	14.4	16.9
107	AP-C2-5F-03	5	0	41.7	14.4	16.9
108	AP-C2-6F-01	6	0	22.3	18	20.5
109	AP-C2-6F-02	6	0	30	18	20.5
110	AP-C2-6F-03	6	0	41.2	18	20.5
111	AP-C3-1F-01	1	25.8	56	0	2.5
112	AP-C3-1F-02	1	12.9	56	0	2.5
113	AP-C3-2F-01	2	25.9	56	3.6	6.1
114	AP-C3-2F-02	2	15.2	56	3.6	6.1
115	AP-C3-2F-03	2	4	56	3.6	6.1
116	AP-C3-3F-01	3	25.7	56	7.2	9.7
117	AP-C3-3F-02	3	13.6	56	7.2	9.7
118	AP-C3-3F-03	3	4.6	56	7.2	9.7
119	AP-C3-4F-01	4	24.5	56	10.8	13.3
120	AP-C3-4F-02	4	10	56	10.8	13.3
121	AP-C3-5F-01	5	25.6	56	14.4	16.9
122	AP-C3-5F-02	5	9.5	56	14.4	16.9
123	AP-C3-6F-01	6	24.4	56	18	20.5
124	AP-C3-6F-02	6	10	56	18	20.5
\.


--
-- Data for Name: ics_table; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.ics_table (location_floor, location, ave_dbm, med_dbm, center_freq_mhz, counts_per_100, ap_name, location_x, location_y, location_y_floor, location_y_height, ap_floor, ap_x, ap_y, ap_y_floor, ap_y_height) FROM stdin;
3	b	-79	-79	2437	2	AP-C-1F-01	30	0	7.2	8.2	1	15.4	0	0	2.5
3	k	-80.6	-80	2437	35	AP-C-1F-01	12	0	7.2	8.2	1	15.4	0	0	2.5
3	j	-75.04545455	-76	2437	22	AP-C-1F-01	14	0	7.2	8.2	1	15.4	0	0	2.5
3	i	-89.26582278	-89	5180	79	AP-C-1F-01	16	0	7.2	8.2	1	15.4	0	0	2.5
3	i	-69.88888889	-70	2437	63	AP-C-1F-01	16	0	7.2	8.2	1	15.4	0	0	2.5
3	h	-89.64864865	-90	5180	37	AP-C-1F-01	18	0	7.2	8.2	1	15.4	0	0	2.5
3	h	-62.37209302	-62	2437	86	AP-C-1F-01	18	0	7.2	8.2	1	15.4	0	0	2.5
3	g	-77.2	-77	2437	35	AP-C-1F-01	20	0	7.2	8.2	1	15.4	0	0	2.5
3	f	-72	-72	2437	21	AP-C-1F-01	22	0	7.2	8.2	1	15.4	0	0	2.5
3	d	-80	-80	2437	21	AP-C-1F-01	26	0	7.2	8.2	1	15.4	0	0	2.5
3	l	-81.4	-81	2437	35	AP-C-1F-01	10	0	7.2	8.2	1	15.4	0	0	2.5
4	h	-86	-86	2437	7	AP-C-1F-01	18	0	10.8	11.8	1	15.4	0	0	2.5
4	g	-88	-88	2437	14	AP-C-1F-01	20	0	10.8	11.8	1	15.4	0	0	2.5
4	f	-88	-88	2437	7	AP-C-1F-01	22	0	10.8	11.8	1	15.4	0	0	2.5
4	e	-85.44444444	-85	2437	9	AP-C-1F-01	24	0	10.8	11.8	1	15.4	0	0	2.5
3	a	-87.7311828	-88	5180	93	AP-C-2F-01	32	0	7.2	8.2	2	25.1	0	3.6	6.1
3	a	-62.71111111	-62	2437	45	AP-C-2F-01	32	0	7.2	8.2	2	25.1	0	3.6	6.1
3	b	-69.18987342	-67	2437	79	AP-C-2F-01	30	0	7.2	8.2	2	25.1	0	3.6	6.1
3	k	-79.63636364	-79	2437	44	AP-C-2F-01	12	0	7.2	8.2	2	25.1	0	3.6	6.1
3	j	-90	-90	5180	7	AP-C-2F-01	14	0	7.2	8.2	2	25.1	0	3.6	6.1
3	j	-78.08695652	-78	2437	23	AP-C-2F-01	14	0	7.2	8.2	2	25.1	0	3.6	6.1
3	i	-92	-92	5180	7	AP-C-2F-01	16	0	7.2	8.2	2	25.1	0	3.6	6.1
3	i	-78.25	-78	2437	28	AP-C-2F-01	16	0	7.2	8.2	2	25.1	0	3.6	6.1
3	h	-88.42857143	-89	5180	49	AP-C-2F-01	18	0	7.2	8.2	2	25.1	0	3.6	6.1
3	h	-69.64705882	-70	2437	51	AP-C-2F-01	18	0	7.2	8.2	2	25.1	0	3.6	6.1
3	g	-86.33333333	-86.5	5180	42	AP-C-2F-01	20	0	7.2	8.2	2	25.1	0	3.6	6.1
3	g	-66.61538462	-66	2437	91	AP-C-2F-01	20	0	7.2	8.2	2	25.1	0	3.6	6.1
3	f	-86.33333333	-86	5180	21	AP-C-2F-01	22	0	7.2	8.2	2	25.1	0	3.6	6.1
3	f	-62.34883721	-62	2437	86	AP-C-2F-01	22	0	7.2	8.2	2	25.1	0	3.6	6.1
3	e	-70	-70	5180	100	AP-C-2F-01	24	0	7.2	8.2	2	25.1	0	3.6	6.1
3	e	-63.63	-63	2437	100	AP-C-2F-01	24	0	7.2	8.2	2	25.1	0	3.6	6.1
3	d	-74.05376344	-74	5180	93	AP-C-2F-01	26	0	7.2	8.2	2	25.1	0	3.6	6.1
3	d	-56.02702703	-57	2437	37	AP-C-2F-01	26	0	7.2	8.2	2	25.1	0	3.6	6.1
3	c	-80.1744186	-80	5180	86	AP-C-2F-01	28	0	7.2	8.2	2	25.1	0	3.6	6.1
3	c	-66.53846154	-67	2437	65	AP-C-2F-01	28	0	7.2	8.2	2	25.1	0	3.6	6.1
3	b	-85.94029851	-86	5180	67	AP-C-2F-01	30	0	7.2	8.2	2	25.1	0	3.6	6.1
3	p	-89	-89	2437	7	AP-C-2F-01	2	0	7.2	8.2	2	25.1	0	3.6	6.1
3	o	-84.5	-84.5	2437	14	AP-C-2F-01	4	0	7.2	8.2	2	25.1	0	3.6	6.1
3	l	-86.3125	-85	2437	32	AP-C-2F-01	10	0	7.2	8.2	2	25.1	0	3.6	6.1
4	b	-73.5	-74	2437	28	AP-C-2F-01	30	0	10.8	11.8	2	25.1	0	3.6	6.1
4	i	-83	-83	2437	7	AP-C-2F-01	16	0	10.8	11.8	2	25.1	0	3.6	6.1
4	h	-82	-82	2437	7	AP-C-2F-01	18	0	10.8	11.8	2	25.1	0	3.6	6.1
4	g	-79.57142857	-80	2437	49	AP-C-2F-01	20	0	10.8	11.8	2	25.1	0	3.6	6.1
4	f	-82.83783784	-83	2437	37	AP-C-2F-01	22	0	10.8	11.8	2	25.1	0	3.6	6.1
4	e	-70.82352941	-71	2437	51	AP-C-2F-01	24	0	10.8	11.8	2	25.1	0	3.6	6.1
4	d	-79.6875	-80	2437	16	AP-C-2F-01	26	0	10.8	11.8	2	25.1	0	3.6	6.1
4	c	-76.75	-76.5	2437	28	AP-C-2F-01	28	0	10.8	11.8	2	25.1	0	3.6	6.1
3	a	-76	-76	2437	7	AP-C-2F-02	32	0	7.2	8.2	2	13.5	0	3.6	6.1
3	b	-83.875	-84	2437	56	AP-C-2F-02	30	0	7.2	8.2	2	13.5	0	3.6	6.1
3	j	-71.07526882	-71	5180	93	AP-C-2F-02	14	0	7.2	8.2	2	13.5	0	3.6	6.1
3	j	-51.83544304	-51	2437	79	AP-C-2F-02	14	0	7.2	8.2	2	13.5	0	3.6	6.1
3	i	-79.38636364	-80	5180	44	AP-C-2F-02	16	0	7.2	8.2	2	13.5	0	3.6	6.1
3	i	-60.38461538	-60	2437	91	AP-C-2F-02	16	0	7.2	8.2	2	13.5	0	3.6	6.1
3	h	-79.77777778	-80	5180	63	AP-C-2F-02	18	0	7.2	8.2	2	13.5	0	3.6	6.1
3	h	-61.35714286	-60.5	2437	98	AP-C-2F-02	18	0	7.2	8.2	2	13.5	0	3.6	6.1
3	g	-82.84615385	-83	5180	65	AP-C-2F-02	20	0	7.2	8.2	2	13.5	0	3.6	6.1
3	g	-73.93548387	-74	2437	93	AP-C-2F-02	20	0	7.2	8.2	2	13.5	0	3.6	6.1
3	f	-87.23333333	-88	5180	30	AP-C-2F-02	22	0	7.2	8.2	2	13.5	0	3.6	6.1
3	f	-68.64615385	-69	2437	65	AP-C-2F-02	22	0	7.2	8.2	2	13.5	0	3.6	6.1
3	e	-76.42857143	-76	2437	49	AP-C-2F-02	24	0	7.2	8.2	2	13.5	0	3.6	6.1
3	d	-92	-92	5180	7	AP-C-2F-02	26	0	7.2	8.2	2	13.5	0	3.6	6.1
3	d	-71.76666667	-71	2437	30	AP-C-2F-02	26	0	7.2	8.2	2	13.5	0	3.6	6.1
3	c	-79	-80	2437	21	AP-C-2F-02	28	0	7.2	8.2	2	13.5	0	3.6	6.1
3	r	-70.19318182	-70	2437	88	AP-C-2F-02	0	2	7.2	8.2	2	13.5	0	3.6	6.1
3	q	-89.4	-89	5180	65	AP-C-2F-02	0	0	7.2	8.2	2	13.5	0	3.6	6.1
3	q	-77.70212766	-78	2437	47	AP-C-2F-02	0	0	7.2	8.2	2	13.5	0	3.6	6.1
3	p	-81.8	-82	2437	35	AP-C-2F-02	2	0	7.2	8.2	2	13.5	0	3.6	6.1
3	o	-92	-92	5180	7	AP-C-2F-02	4	0	7.2	8.2	2	13.5	0	3.6	6.1
3	o	-81.57142857	-81	2437	49	AP-C-2F-02	4	0	7.2	8.2	2	13.5	0	3.6	6.1
3	n	-90.83333333	-91	5180	72	AP-C-2F-02	6	0	7.2	8.2	2	13.5	0	3.6	6.1
3	n	-71.3442623	-69	2437	61	AP-C-2F-02	6	0	7.2	8.2	2	13.5	0	3.6	6.1
3	m	-86.89230769	-87	5180	65	AP-C-2F-02	8	0	7.2	8.2	2	13.5	0	3.6	6.1
3	m	-67.48837209	-67	2437	86	AP-C-2F-02	8	0	7.2	8.2	2	13.5	0	3.6	6.1
3	l	-82.18666667	-82	5180	75	AP-C-2F-02	10	0	7.2	8.2	2	13.5	0	3.6	6.1
3	l	-61.97849462	-62	2437	93	AP-C-2F-02	10	0	7.2	8.2	2	13.5	0	3.6	6.1
3	k	-70.09	-70	5180	100	AP-C-2F-02	12	0	7.2	8.2	2	13.5	0	3.6	6.1
3	k	-47.70833333	-48	2437	72	AP-C-2F-02	12	0	7.2	8.2	2	13.5	0	3.6	6.1
4	l	-70.04545455	-70	2437	44	AP-C-2F-02	10	0	10.8	11.8	2	13.5	0	3.6	6.1
4	k	-92.2	-93	5180	35	AP-C-2F-02	12	0	10.8	11.8	2	13.5	0	3.6	6.1
4	k	-71.4516129	-71	2437	93	AP-C-2F-02	12	0	10.8	11.8	2	13.5	0	3.6	6.1
4	j	-89.85714286	-90	5180	49	AP-C-2F-02	14	0	10.8	11.8	2	13.5	0	3.6	6.1
4	j	-69.02777778	-69	2437	72	AP-C-2F-02	14	0	10.8	11.8	2	13.5	0	3.6	6.1
4	i	-72	-71	2437	49	AP-C-2F-02	16	0	10.8	11.8	2	13.5	0	3.6	6.1
4	h	-81.08695652	-82	2437	23	AP-C-2F-02	18	0	10.8	11.8	2	13.5	0	3.6	6.1
4	g	-81.66666667	-82	2437	21	AP-C-2F-02	20	0	10.8	11.8	2	13.5	0	3.6	6.1
4	f	-82	-82	2437	7	AP-C-2F-02	22	0	10.8	11.8	2	13.5	0	3.6	6.1
4	o	-86	-86	2437	7	AP-C-2F-02	4	0	10.8	11.8	2	13.5	0	3.6	6.1
4	n	-83	-83	2437	7	AP-C-2F-02	6	0	10.8	11.8	2	13.5	0	3.6	6.1
4	m	-73.28571429	-74	2437	49	AP-C-2F-02	8	0	10.8	11.8	2	13.5	0	3.6	6.1
3	am	-84	-84	2437	7	AP-C-3F-01	0	44	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	ak	-83.08108108	-84	2437	37	AP-C-3F-01	0	40	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	aj	-82.33333333	-83	2437	9	AP-C-3F-01	0	38	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	ai	-79	-79	2437	7	AP-C-3F-01	0	36	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	af	-77.59090909	-78	2437	22	AP-C-3F-01	0	30	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	ae	-77.5	-77.5	2437	14	AP-C-3F-01	0	28	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	ad	-77	-77	2437	14	AP-C-3F-01	0	26	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	ac	-80.83333333	-81	2437	42	AP-C-3F-01	0	24	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	ab	-77.5	-77.5	2437	14	AP-C-3F-01	0	22	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	aa	-77.54166667	-78	2437	24	AP-C-3F-01	0	20	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	b	-82	-82	2437	7	AP-C-3F-01	30	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	as	-90	-90	5180	7	AP-C-3F-01	0	56	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	as	-82	-82	2437	7	AP-C-3F-01	0	56	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	ar	-83.25	-84	2437	28	AP-C-3F-01	0	54	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	aq	-80.86363636	-80	2437	44	AP-C-3F-01	0	52	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	ap	-81.75	-81.5	2437	28	AP-C-3F-01	0	50	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	ao	-77.81081081	-78	2437	37	AP-C-3F-01	0	48	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	an	-84.4	-83	2437	35	AP-C-3F-01	0	46	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	j	-79.06666667	-80	2437	15	AP-C-3F-01	14	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	i	-83	-83	2437	7	AP-C-3F-01	16	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	h	-77	-77	2437	7	AP-C-3F-01	18	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	g	-81.5	-81.5	2437	14	AP-C-3F-01	20	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	f	-78	-78	2437	14	AP-C-3F-01	22	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	d	-85	-85	2437	14	AP-C-3F-01	26	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	c	-81.5	-81.5	2437	14	AP-C-3F-01	28	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	y	-71.70454545	-71	2437	44	AP-C-3F-01	0	16	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	x	-90	-90	5180	7	AP-C-3F-01	0	14	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	x	-68.86075949	-69	2437	79	AP-C-3F-01	0	14	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	w	-69.33333333	-69	2437	30	AP-C-3F-01	0	12	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	v	-75.5	-75.5	2437	14	AP-C-3F-01	0	10	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	u	-87	-87	5180	7	AP-C-3F-01	0	8	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	u	-74	-74	2437	42	AP-C-3F-01	0	8	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	t	-89.36363636	-89	5180	11	AP-C-3F-01	0	6	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	t	-70.61538462	-71	2437	91	AP-C-3F-01	0	6	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	s	-89.30434783	-89	5180	23	AP-C-3F-01	0	4	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	s	-60.84	-61	2437	100	AP-C-3F-01	0	4	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	r	-83.09090909	-85	5180	44	AP-C-3F-01	0	2	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	r	-67.97222222	-68	2437	72	AP-C-3F-01	0	2	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	q	-81.19230769	-80	5180	26	AP-C-3F-01	0	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	q	-69.20454545	-69	2437	44	AP-C-3F-01	0	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	p	-77.41538462	-77	5180	65	AP-C-3F-01	2	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	p	-59.31	-59	2437	100	AP-C-3F-01	2	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	o	-77.3	-77.5	5180	70	AP-C-3F-01	4	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	o	-61.69	-62	2437	100	AP-C-3F-01	4	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	n	-82.06666667	-82	5180	60	AP-C-3F-01	6	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	n	-72.64583333	-72	2437	96	AP-C-3F-01	6	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	m	-84.77777778	-84	5180	72	AP-C-3F-01	8	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	m	-66.45454545	-67	2437	77	AP-C-3F-01	8	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	l	-86.83333333	-88	5180	18	AP-C-3F-01	10	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	l	-67.96923077	-68	2437	65	AP-C-3F-01	10	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	k	-80	-80	2437	7	AP-C-3F-01	12	0	7.2	8.2	3	-1.9	-11.2	7.2	9.7
3	z	-74	-74	2437	14	AP-C-3F-01	0	18	7.2	8.2	3	-1.9	-11.2	7.2	9.7
4	x	-87	-87	2437	7	AP-C-3F-01	0	14	10.8	11.8	3	-1.9	-11.2	7.2	9.7
4	w	-81	-81	2437	7	AP-C-3F-01	0	12	10.8	11.8	3	-1.9	-11.2	7.2	9.7
4	u	-85	-85	2437	14	AP-C-3F-01	0	8	10.8	11.8	3	-1.9	-11.2	7.2	9.7
4	t	-83.4	-84	2437	35	AP-C-3F-01	0	6	10.8	11.8	3	-1.9	-11.2	7.2	9.7
4	s	-87.5	-87.5	2437	14	AP-C-3F-01	0	4	10.8	11.8	3	-1.9	-11.2	7.2	9.7
4	r	-79.79310345	-80	2437	58	AP-C-3F-01	0	2	10.8	11.8	3	-1.9	-11.2	7.2	9.7
4	q	-76.66666667	-78	2437	30	AP-C-3F-01	0	0	10.8	11.8	3	-1.9	-11.2	7.2	9.7
4	p	-76.42857143	-76	2437	49	AP-C-3F-01	2	0	10.8	11.8	3	-1.9	-11.2	7.2	9.7
4	o	-80.44444444	-81	2437	63	AP-C-3F-01	4	0	10.8	11.8	3	-1.9	-11.2	7.2	9.7
4	n	-80.66666667	-80	2437	21	AP-C-3F-01	6	0	10.8	11.8	3	-1.9	-11.2	7.2	9.7
3	a	-58.11	-58	5180	100	AP-C-3F-02	32	0	7.2	8.2	3	30.1	0	7.2	9.7
3	a	-36.45	-36	2437	100	AP-C-3F-02	32	0	7.2	8.2	3	30.1	0	7.2	9.7
3	b	-41.69	-42	2437	100	AP-C-3F-02	30	0	7.2	8.2	3	30.1	0	7.2	9.7
3	j	-76.59459459	-74	5180	37	AP-C-3F-02	14	0	7.2	8.2	3	30.1	0	7.2	9.7
3	j	-74.37209302	-76	2437	43	AP-C-3F-02	14	0	7.2	8.2	3	30.1	0	7.2	9.7
3	i	-74.88888889	-74	5180	72	AP-C-3F-02	16	0	7.2	8.2	3	30.1	0	7.2	9.7
3	i	-66.67241379	-67	2437	58	AP-C-3F-02	16	0	7.2	8.2	3	30.1	0	7.2	9.7
3	h	-71.24050633	-72	5180	79	AP-C-3F-02	18	0	7.2	8.2	3	30.1	0	7.2	9.7
3	h	-67.57142857	-67	2437	49	AP-C-3F-02	18	0	7.2	8.2	3	30.1	0	7.2	9.7
3	g	-71.38372093	-71	5180	86	AP-C-3F-02	20	0	7.2	8.2	3	30.1	0	7.2	9.7
3	g	-64.78481013	-64	2437	79	AP-C-3F-02	20	0	7.2	8.2	3	30.1	0	7.2	9.7
3	f	-67.81818182	-68	5180	77	AP-C-3F-02	22	0	7.2	8.2	3	30.1	0	7.2	9.7
3	f	-57.51162791	-57	2437	86	AP-C-3F-02	22	0	7.2	8.2	3	30.1	0	7.2	9.7
3	e	-66.32258065	-66	5180	93	AP-C-3F-02	24	0	7.2	8.2	3	30.1	0	7.2	9.7
3	e	-53.79	-54	2437	100	AP-C-3F-02	24	0	7.2	8.2	3	30.1	0	7.2	9.7
3	d	-68.63	-68	5180	100	AP-C-3F-02	26	0	7.2	8.2	3	30.1	0	7.2	9.7
3	d	-48.4	-48	2437	100	AP-C-3F-02	26	0	7.2	8.2	3	30.1	0	7.2	9.7
3	c	-53.9	-53	5180	100	AP-C-3F-02	28	0	7.2	8.2	3	30.1	0	7.2	9.7
3	c	-49.47	-49	2437	100	AP-C-3F-02	28	0	7.2	8.2	3	30.1	0	7.2	9.7
3	b	-47.17	-47	5180	100	AP-C-3F-02	30	0	7.2	8.2	3	30.1	0	7.2	9.7
3	r	-80.37974684	-80	5180	79	AP-C-3F-02	0	2	7.2	8.2	3	30.1	0	7.2	9.7
3	r	-83	-83	2437	7	AP-C-3F-02	0	2	7.2	8.2	3	30.1	0	7.2	9.7
3	q	-65.94	-65	5180	100	AP-C-3F-02	0	0	7.2	8.2	3	30.1	0	7.2	9.7
3	q	-67.46511628	-67	2437	86	AP-C-3F-02	0	0	7.2	8.2	3	30.1	0	7.2	9.7
3	p	-86	-86	5180	50	AP-C-3F-02	2	0	7.2	8.2	3	30.1	0	7.2	9.7
3	p	-70.06329114	-70	2437	79	AP-C-3F-02	2	0	7.2	8.2	3	30.1	0	7.2	9.7
3	o	-80.15909091	-80	5180	44	AP-C-3F-02	4	0	7.2	8.2	3	30.1	0	7.2	9.7
3	o	-66.47	-66	2437	100	AP-C-3F-02	4	0	7.2	8.2	3	30.1	0	7.2	9.7
3	n	-80.90277778	-81	5180	72	AP-C-3F-02	6	0	7.2	8.2	3	30.1	0	7.2	9.7
3	n	-79.175	-79	2437	40	AP-C-3F-02	6	0	7.2	8.2	3	30.1	0	7.2	9.7
3	m	-82.125	-82.5	5180	56	AP-C-3F-02	8	0	7.2	8.2	3	30.1	0	7.2	9.7
3	m	-71.79310345	-73	2437	58	AP-C-3F-02	8	0	7.2	8.2	3	30.1	0	7.2	9.7
3	l	-77.79746835	-77	5180	79	AP-C-3F-02	10	0	7.2	8.2	3	30.1	0	7.2	9.7
3	l	-71.91139241	-72	2437	79	AP-C-3F-02	10	0	7.2	8.2	3	30.1	0	7.2	9.7
3	k	-74.16666667	-75	5180	84	AP-C-3F-02	12	0	7.2	8.2	3	30.1	0	7.2	9.7
3	k	-76.375	-75	2437	56	AP-C-3F-02	12	0	7.2	8.2	3	30.1	0	7.2	9.7
4	a	-76.93670886	-77	5180	79	AP-C-3F-02	32	0	10.8	11.8	3	30.1	0	7.2	9.7
4	a	-52.09677419	-52	2437	93	AP-C-3F-02	32	0	10.8	11.8	3	30.1	0	7.2	9.7
4	b	-79.37974684	-79	5180	79	AP-C-3F-02	30	0	10.8	11.8	3	30.1	0	7.2	9.7
4	b	-61.06329114	-60	2437	79	AP-C-3F-02	30	0	10.8	11.8	3	30.1	0	7.2	9.7
4	l	-85	-85	2437	2	AP-C-3F-02	10	0	10.8	11.8	3	30.1	0	7.2	9.7
4	j	-85.25	-85	2437	28	AP-C-3F-02	14	0	10.8	11.8	3	30.1	0	7.2	9.7
4	g	-80.4	-80	2437	35	AP-C-3F-02	20	0	10.8	11.8	3	30.1	0	7.2	9.7
4	f	-89.5	-89.5	5180	14	AP-C-3F-02	22	0	10.8	11.8	3	30.1	0	7.2	9.7
4	f	-76.57142857	-76	2437	49	AP-C-3F-02	22	0	10.8	11.8	3	30.1	0	7.2	9.7
4	e	-87.86153846	-88	5180	65	AP-C-3F-02	24	0	10.8	11.8	3	30.1	0	7.2	9.7
4	e	-79.55555556	-79	2437	63	AP-C-3F-02	24	0	10.8	11.8	3	30.1	0	7.2	9.7
4	d	-81.93103448	-82	5180	58	AP-C-3F-02	26	0	10.8	11.8	3	30.1	0	7.2	9.7
4	d	-69.6	-70	2437	35	AP-C-3F-02	26	0	10.8	11.8	3	30.1	0	7.2	9.7
4	c	-83.31944444	-83	5180	72	AP-C-3F-02	28	0	10.8	11.8	3	30.1	0	7.2	9.7
4	c	-62.46511628	-62	2437	86	AP-C-3F-02	28	0	10.8	11.8	3	30.1	0	7.2	9.7
4	q	-80	-80	2437	7	AP-C-3F-02	0	0	10.8	11.8	3	30.1	0	7.2	9.7
4	p	-85	-85	2437	7	AP-C-3F-02	2	0	10.8	11.8	3	30.1	0	7.2	9.7
3	a	-68.01	-68	5180	100	AP-C-3F-03	32	0	7.2	8.2	3	20.8	0	7.2	9.7
3	a	-61.61	-63	2437	100	AP-C-3F-03	32	0	7.2	8.2	3	20.8	0	7.2	9.7
3	b	-51.38	-51	2437	100	AP-C-3F-03	30	0	7.2	8.2	3	20.8	0	7.2	9.7
3	j	-70.90769231	-70	5180	65	AP-C-3F-03	14	0	7.2	8.2	3	20.8	0	7.2	9.7
3	j	-66.91397849	-68	2437	93	AP-C-3F-03	14	0	7.2	8.2	3	20.8	0	7.2	9.7
3	i	-65.19	-65	5180	100	AP-C-3F-03	16	0	7.2	8.2	3	20.8	0	7.2	9.7
3	i	-57.31	-57	2437	100	AP-C-3F-03	16	0	7.2	8.2	3	20.8	0	7.2	9.7
3	h	-56.95	-56	5180	100	AP-C-3F-03	18	0	7.2	8.2	3	20.8	0	7.2	9.7
3	h	-51.05	-51	2437	100	AP-C-3F-03	18	0	7.2	8.2	3	20.8	0	7.2	9.7
3	g	-52.75268817	-52	5180	93	AP-C-3F-03	20	0	7.2	8.2	3	20.8	0	7.2	9.7
3	g	-36.42	-37	2437	100	AP-C-3F-03	20	0	7.2	8.2	3	20.8	0	7.2	9.7
3	f	-50.23076923	-49	5180	91	AP-C-3F-03	22	0	7.2	8.2	3	20.8	0	7.2	9.7
3	f	-40.69892473	-41	2437	93	AP-C-3F-03	22	0	7.2	8.2	3	20.8	0	7.2	9.7
3	e	-55.37	-56	5180	100	AP-C-3F-03	24	0	7.2	8.2	3	20.8	0	7.2	9.7
3	e	-49.46236559	-50	2437	93	AP-C-3F-03	24	0	7.2	8.2	3	20.8	0	7.2	9.7
3	d	-60.03	-60	5180	100	AP-C-3F-03	26	0	7.2	8.2	3	20.8	0	7.2	9.7
3	d	-53.64516129	-54	2437	93	AP-C-3F-03	26	0	7.2	8.2	3	20.8	0	7.2	9.7
3	c	-58.87777778	-58	5180	90	AP-C-3F-03	28	0	7.2	8.2	3	20.8	0	7.2	9.7
3	c	-48.75	-48	2437	100	AP-C-3F-03	28	0	7.2	8.2	3	20.8	0	7.2	9.7
3	b	-67.47222222	-67	5180	72	AP-C-3F-03	30	0	7.2	8.2	3	20.8	0	7.2	9.7
3	r	-86.1	-86	5180	70	AP-C-3F-03	0	2	7.2	8.2	3	20.8	0	7.2	9.7
3	r	-82.15517241	-83	2437	58	AP-C-3F-03	0	2	7.2	8.2	3	20.8	0	7.2	9.7
3	q	-72.23	-72	5180	100	AP-C-3F-03	0	0	7.2	8.2	3	20.8	0	7.2	9.7
3	q	-67.53763441	-68	2437	93	AP-C-3F-03	0	0	7.2	8.2	3	20.8	0	7.2	9.7
3	p	-84.96923077	-85	5180	65	AP-C-3F-03	2	0	7.2	8.2	3	20.8	0	7.2	9.7
3	p	-78.1744186	-77	2437	86	AP-C-3F-03	2	0	7.2	8.2	3	20.8	0	7.2	9.7
3	o	-82	-82	5180	72	AP-C-3F-03	4	0	7.2	8.2	3	20.8	0	7.2	9.7
3	o	-69.91	-69	2437	100	AP-C-3F-03	4	0	7.2	8.2	3	20.8	0	7.2	9.7
3	n	-80.66666667	-81	5180	6	AP-C-3F-03	6	0	7.2	8.2	3	20.8	0	7.2	9.7
3	n	-76.5	-77.5	2437	42	AP-C-3F-03	6	0	7.2	8.2	3	20.8	0	7.2	9.7
3	m	-76.72727273	-76	5180	77	AP-C-3F-03	8	0	7.2	8.2	3	20.8	0	7.2	9.7
3	m	-75.37974684	-74	2437	79	AP-C-3F-03	8	0	7.2	8.2	3	20.8	0	7.2	9.7
3	l	-78.98734177	-78	5180	79	AP-C-3F-03	10	0	7.2	8.2	3	20.8	0	7.2	9.7
3	l	-61.2688172	-60	2437	93	AP-C-3F-03	10	0	7.2	8.2	3	20.8	0	7.2	9.7
3	k	-71.80645161	-72	5180	93	AP-C-3F-03	12	0	7.2	8.2	3	20.8	0	7.2	9.7
3	k	-64.23255814	-64	2437	86	AP-C-3F-03	12	0	7.2	8.2	3	20.8	0	7.2	9.7
4	a	-79	-79	2437	7	AP-C-3F-03	32	0	10.8	11.8	3	20.8	0	7.2	9.7
4	b	-79.5	-80	2437	42	AP-C-3F-03	30	0	10.8	11.8	3	20.8	0	7.2	9.7
4	k	-92	-92	5180	7	AP-C-3F-03	12	0	10.8	11.8	3	20.8	0	7.2	9.7
4	k	-76.2745098	-77	2437	51	AP-C-3F-03	12	0	10.8	11.8	3	20.8	0	7.2	9.7
4	j	-89.75	-89.5	5180	56	AP-C-3F-03	14	0	10.8	11.8	3	20.8	0	7.2	9.7
4	j	-75	-75	2437	42	AP-C-3F-03	14	0	10.8	11.8	3	20.8	0	7.2	9.7
4	i	-78	-78	5180	14	AP-C-3F-03	16	0	10.8	11.8	3	20.8	0	7.2	9.7
4	i	-64.08860759	-64	2437	79	AP-C-3F-03	16	0	10.8	11.8	3	20.8	0	7.2	9.7
4	h	-79.5	-79.5	5180	42	AP-C-3F-03	18	0	10.8	11.8	3	20.8	0	7.2	9.7
4	h	-66.92405063	-66	2437	79	AP-C-3F-03	18	0	10.8	11.8	3	20.8	0	7.2	9.7
4	g	-65.97	-66	5180	100	AP-C-3F-03	20	0	10.8	11.8	3	20.8	0	7.2	9.7
4	g	-54.65	-54	2437	100	AP-C-3F-03	20	0	10.8	11.8	3	20.8	0	7.2	9.7
4	f	-68.30107527	-68	5180	93	AP-C-3F-03	22	0	10.8	11.8	3	20.8	0	7.2	9.7
4	f	-55.39784946	-56	2437	93	AP-C-3F-03	22	0	10.8	11.8	3	20.8	0	7.2	9.7
4	e	-80.91666667	-81	5180	84	AP-C-3F-03	24	0	10.8	11.8	3	20.8	0	7.2	9.7
4	e	-68.83544304	-68	2437	79	AP-C-3F-03	24	0	10.8	11.8	3	20.8	0	7.2	9.7
4	d	-88	-88	5180	49	AP-C-3F-03	26	0	10.8	11.8	3	20.8	0	7.2	9.7
4	d	-61.74	-61	2437	100	AP-C-3F-03	26	0	10.8	11.8	3	20.8	0	7.2	9.7
4	c	-86.77777778	-86	5180	72	AP-C-3F-03	28	0	10.8	11.8	3	20.8	0	7.2	9.7
4	c	-68.05555556	-68	2437	72	AP-C-3F-03	28	0	10.8	11.8	3	20.8	0	7.2	9.7
4	r	-86.5	-87	2437	42	AP-C-3F-03	0	2	10.8	11.8	3	20.8	0	7.2	9.7
4	q	-78.6	-79	2437	35	AP-C-3F-03	0	0	10.8	11.8	3	20.8	0	7.2	9.7
4	p	-84	-84	2437	7	AP-C-3F-03	2	0	10.8	11.8	3	20.8	0	7.2	9.7
4	n	-81.4	-81	2437	35	AP-C-3F-03	6	0	10.8	11.8	3	20.8	0	7.2	9.7
4	m	-84.5	-84.5	2437	14	AP-C-3F-03	8	0	10.8	11.8	3	20.8	0	7.2	9.7
4	l	-76.8	-76	2437	35	AP-C-3F-03	10	0	10.8	11.8	3	20.8	0	7.2	9.7
3	a	-77.01449275	-76	5180	69	AP-C-3F-04	32	0	7.2	8.2	3	9.1	0	7.2	9.7
3	a	-61.62365591	-62	2437	93	AP-C-3F-04	32	0	7.2	8.2	3	9.1	0	7.2	9.7
3	b	-62.07692308	-61	2437	91	AP-C-3F-04	30	0	7.2	8.2	3	9.1	0	7.2	9.7
3	j	-67.39	-67	5180	100	AP-C-3F-04	14	0	7.2	8.2	3	9.1	0	7.2	9.7
3	j	-47.35	-47.5	2437	100	AP-C-3F-04	14	0	7.2	8.2	3	9.1	0	7.2	9.7
3	i	-66.94186047	-67	5180	86	AP-C-3F-04	16	0	7.2	8.2	3	9.1	0	7.2	9.7
3	i	-47.39	-47	2437	100	AP-C-3F-04	16	0	7.2	8.2	3	9.1	0	7.2	9.7
3	h	-71.41935484	-71	5180	93	AP-C-3F-04	18	0	7.2	8.2	3	9.1	0	7.2	9.7
3	h	-54.59	-54	2437	100	AP-C-3F-04	18	0	7.2	8.2	3	9.1	0	7.2	9.7
3	g	-69.64516129	-70	5180	93	AP-C-3F-04	20	0	7.2	8.2	3	9.1	0	7.2	9.7
3	g	-56.05	-56	2437	100	AP-C-3F-04	20	0	7.2	8.2	3	9.1	0	7.2	9.7
3	f	-74.28571429	-75	5180	49	AP-C-3F-04	22	0	7.2	8.2	3	9.1	0	7.2	9.7
3	f	-56.67741935	-56	2437	93	AP-C-3F-04	22	0	7.2	8.2	3	9.1	0	7.2	9.7
3	e	-71.79	-72	5180	100	AP-C-3F-04	24	0	7.2	8.2	3	9.1	0	7.2	9.7
3	e	-65.64	-66	2437	100	AP-C-3F-04	24	0	7.2	8.2	3	9.1	0	7.2	9.7
3	d	-79.06329114	-79	5180	79	AP-C-3F-04	26	0	7.2	8.2	3	9.1	0	7.2	9.7
3	d	-66.77	-67	2437	100	AP-C-3F-04	26	0	7.2	8.2	3	9.1	0	7.2	9.7
3	c	-72.03	-71	5180	100	AP-C-3F-04	28	0	7.2	8.2	3	9.1	0	7.2	9.7
3	c	-64.63636364	-65	2437	77	AP-C-3F-04	28	0	7.2	8.2	3	9.1	0	7.2	9.7
3	b	-69.37837838	-69	5180	37	AP-C-3F-04	30	0	7.2	8.2	3	9.1	0	7.2	9.7
3	u	-82.2	-83	2437	35	AP-C-3F-04	0	8	7.2	8.2	3	9.1	0	7.2	9.7
3	t	-89.66666667	-89	5180	21	AP-C-3F-04	0	6	7.2	8.2	3	9.1	0	7.2	9.7
3	t	-85.75	-86	2437	28	AP-C-3F-04	0	6	7.2	8.2	3	9.1	0	7.2	9.7
3	s	-87.0625	-88	5180	16	AP-C-3F-04	0	4	7.2	8.2	3	9.1	0	7.2	9.7
3	s	-83	-83	2437	14	AP-C-3F-04	0	4	7.2	8.2	3	9.1	0	7.2	9.7
3	r	-65.52040816	-65	5180	98	AP-C-3F-04	0	2	7.2	8.2	3	9.1	0	7.2	9.7
3	r	-60.38	-60	2437	100	AP-C-3F-04	0	2	7.2	8.2	3	9.1	0	7.2	9.7
3	q	-64.03	-64	5180	100	AP-C-3F-04	0	0	7.2	8.2	3	9.1	0	7.2	9.7
3	q	-57.93548387	-59	2437	93	AP-C-3F-04	0	0	7.2	8.2	3	9.1	0	7.2	9.7
3	p	-72.79	-72	5180	100	AP-C-3F-04	2	0	7.2	8.2	3	9.1	0	7.2	9.7
3	p	-62.68	-62	2437	100	AP-C-3F-04	2	0	7.2	8.2	3	9.1	0	7.2	9.7
3	o	-67.5	-68	5180	100	AP-C-3F-04	4	0	7.2	8.2	3	9.1	0	7.2	9.7
3	o	-55.99	-56	2437	100	AP-C-3F-04	4	0	7.2	8.2	3	9.1	0	7.2	9.7
3	n	-69.38961039	-70	5180	77	AP-C-3F-04	6	0	7.2	8.2	3	9.1	0	7.2	9.7
3	n	-45.26	-45	2437	100	AP-C-3F-04	6	0	7.2	8.2	3	9.1	0	7.2	9.7
3	m	-56.72043011	-57	5180	93	AP-C-3F-04	8	0	7.2	8.2	3	9.1	0	7.2	9.7
3	m	-43.38	-42	2437	100	AP-C-3F-04	8	0	7.2	8.2	3	9.1	0	7.2	9.7
3	l	-51.19	-51	5180	100	AP-C-3F-04	10	0	7.2	8.2	3	9.1	0	7.2	9.7
3	l	-38.79	-38	2437	100	AP-C-3F-04	10	0	7.2	8.2	3	9.1	0	7.2	9.7
3	k	-62.99	-63	5180	100	AP-C-3F-04	12	0	7.2	8.2	3	9.1	0	7.2	9.7
3	k	-49.49	-51	2437	100	AP-C-3F-04	12	0	7.2	8.2	3	9.1	0	7.2	9.7
4	k	-76.07	-76	5180	100	AP-C-3F-04	12	0	10.8	11.8	3	9.1	0	7.2	9.7
4	k	-60.4516129	-60	2437	93	AP-C-3F-04	12	0	10.8	11.8	3	9.1	0	7.2	9.7
4	j	-84.35384615	-84	5180	65	AP-C-3F-04	14	0	10.8	11.8	3	9.1	0	7.2	9.7
4	j	-63.58227848	-64	2437	79	AP-C-3F-04	14	0	10.8	11.8	3	9.1	0	7.2	9.7
4	i	-81.90909091	-82	5180	77	AP-C-3F-04	16	0	10.8	11.8	3	9.1	0	7.2	9.7
4	i	-60.47222222	-60	2437	72	AP-C-3F-04	16	0	10.8	11.8	3	9.1	0	7.2	9.7
4	h	-82.90277778	-83	5180	72	AP-C-3F-04	18	0	10.8	11.8	3	9.1	0	7.2	9.7
4	h	-65.70769231	-66	2437	65	AP-C-3F-04	18	0	10.8	11.8	3	9.1	0	7.2	9.7
4	g	-91.33333333	-90	5180	21	AP-C-3F-04	20	0	10.8	11.8	3	9.1	0	7.2	9.7
4	g	-75.83333333	-76	2437	42	AP-C-3F-04	20	0	10.8	11.8	3	9.1	0	7.2	9.7
4	f	-90	-89.5	5180	28	AP-C-3F-04	22	0	10.8	11.8	3	9.1	0	7.2	9.7
4	f	-79.36666667	-80	2437	30	AP-C-3F-04	22	0	10.8	11.8	3	9.1	0	7.2	9.7
4	e	-75	-75	2437	7	AP-C-3F-04	24	0	10.8	11.8	3	9.1	0	7.2	9.7
4	c	-79	-79	2437	2	AP-C-3F-04	28	0	10.8	11.8	3	9.1	0	7.2	9.7
4	s	-89	-89	2437	7	AP-C-3F-04	0	4	10.8	11.8	3	9.1	0	7.2	9.7
4	r	-89.66666667	-91	5180	21	AP-C-3F-04	0	2	10.8	11.8	3	9.1	0	7.2	9.7
4	r	-77.75862069	-78	2437	58	AP-C-3F-04	0	2	10.8	11.8	3	9.1	0	7.2	9.7
4	q	-84.84482759	-84	5180	58	AP-C-3F-04	0	0	10.8	11.8	3	9.1	0	7.2	9.7
4	q	-73.89230769	-74	2437	65	AP-C-3F-04	0	0	10.8	11.8	3	9.1	0	7.2	9.7
4	p	-88.21	-88	5180	100	AP-C-3F-04	2	0	10.8	11.8	3	9.1	0	7.2	9.7
4	p	-76.05172414	-76	2437	58	AP-C-3F-04	2	0	10.8	11.8	3	9.1	0	7.2	9.7
4	o	-86.8	-86.5	5180	70	AP-C-3F-04	4	0	10.8	11.8	3	9.1	0	7.2	9.7
4	o	-73.52777778	-73	2437	72	AP-C-3F-04	4	0	10.8	11.8	3	9.1	0	7.2	9.7
4	n	-78.88135593	-79	5180	59	AP-C-3F-04	6	0	10.8	11.8	3	9.1	0	7.2	9.7
4	n	-64.25352113	-63	2437	71	AP-C-3F-04	6	0	10.8	11.8	3	9.1	0	7.2	9.7
4	m	-77.47311828	-77	5180	93	AP-C-3F-04	8	0	10.8	11.8	3	9.1	0	7.2	9.7
4	m	-63.5	-64	2437	70	AP-C-3F-04	8	0	10.8	11.8	3	9.1	0	7.2	9.7
4	l	-72.46236559	-72	5180	93	AP-C-3F-04	10	0	10.8	11.8	3	9.1	0	7.2	9.7
4	l	-60.95	-61	2437	100	AP-C-3F-04	10	0	10.8	11.8	3	9.1	0	7.2	9.7
3	q	-78.5	-78.5	2437	14	AP-C-4F-01	0	0	7.2	8.2	4	-1.9	-11.2	10.8	13.3
3	p	-77.5	-77.5	2437	14	AP-C-4F-01	2	0	7.2	8.2	4	-1.9	-11.2	10.8	13.3
3	o	-79	-79	2437	7	AP-C-4F-01	4	0	7.2	8.2	4	-1.9	-11.2	10.8	13.3
3	m	-85	-85	2437	7	AP-C-4F-01	8	0	7.2	8.2	4	-1.9	-11.2	10.8	13.3
3	l	-88	-88	2437	14	AP-C-4F-01	10	0	7.2	8.2	4	-1.9	-11.2	10.8	13.3
3	k	-86	-86	2437	9	AP-C-4F-01	12	0	7.2	8.2	4	-1.9	-11.2	10.8	13.3
4	al	-78	-78	2437	7	AP-C-4F-01	0	42	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	ak	-81.5	-81.5	2437	28	AP-C-4F-01	0	40	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	aj	-82.5625	-82	2437	16	AP-C-4F-01	0	38	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	ah	-79	-79	2437	7	AP-C-4F-01	0	34	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	af	-78	-78	2437	6	AP-C-4F-01	0	30	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	ac	-84	-84	2437	7	AP-C-4F-01	0	24	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	a	-81	-81	5180	7	AP-C-4F-01	32	0	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	a	-65	-65	2437	7	AP-C-4F-01	32	0	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	as	-79.66666667	-79	2437	42	AP-C-4F-01	0	56	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	ar	-87	-87	2437	7	AP-C-4F-01	0	54	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	aq	-86	-86	2437	7	AP-C-4F-01	0	52	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	ap	-86.4	-85	2437	35	AP-C-4F-01	0	50	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	am	-85	-85	2437	7	AP-C-4F-01	0	44	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	k	-83.66666667	-84	2437	21	AP-C-4F-01	12	0	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	z	-80.5	-80.5	2437	14	AP-C-4F-01	0	18	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	y	-76.08333333	-79	2437	12	AP-C-4F-01	0	16	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	x	-76.33333333	-77.5	2437	42	AP-C-4F-01	0	14	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	w	-70.56363636	-72	2437	55	AP-C-4F-01	0	12	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	v	-90.66666667	-90	5180	21	AP-C-4F-01	0	10	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	v	-76.25714286	-77	2437	35	AP-C-4F-01	0	10	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	u	-78.33333333	-78	2437	63	AP-C-4F-01	0	8	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	t	-87	-87	5180	7	AP-C-4F-01	0	6	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	t	-79.33333333	-80	2437	21	AP-C-4F-01	0	6	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	s	-76.97222222	-77	2437	72	AP-C-4F-01	0	4	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	r	-70.92405063	-72	2437	79	AP-C-4F-01	0	2	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	q	-68	-68	2437	100	AP-C-4F-01	0	0	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	p	-66.24	-66	2437	100	AP-C-4F-01	2	0	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	o	-88.0862069	-88	5180	58	AP-C-4F-01	4	0	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	o	-64.32	-65	2437	100	AP-C-4F-01	4	0	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	n	-91.66666667	-92	5180	21	AP-C-4F-01	6	0	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	n	-66.85714286	-66	2437	49	AP-C-4F-01	6	0	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	m	-69.23943662	-69	2437	71	AP-C-4F-01	8	0	10.8	11.8	4	-1.9	-11.2	10.8	13.3
4	l	-80.5	-80.5	2437	14	AP-C-4F-01	10	0	10.8	11.8	4	-1.9	-11.2	10.8	13.3
3	a	-75.33333333	-75	5180	21	AP-C-4F-02	32	0	7.2	8.2	4	30.1	0	10.8	13.3
3	a	-57.45	-58	2437	100	AP-C-4F-02	32	0	7.2	8.2	4	30.1	0	10.8	13.3
3	b	-63.52688172	-62	2437	93	AP-C-4F-02	30	0	7.2	8.2	4	30.1	0	10.8	13.3
3	j	-82.04545455	-82	2437	22	AP-C-4F-02	14	0	7.2	8.2	4	30.1	0	10.8	13.3
3	i	-74.16666667	-73	2437	42	AP-C-4F-02	16	0	7.2	8.2	4	30.1	0	10.8	13.3
3	h	-79.2	-79	2437	35	AP-C-4F-02	18	0	7.2	8.2	4	30.1	0	10.8	13.3
3	g	-71.24615385	-71	2437	65	AP-C-4F-02	20	0	7.2	8.2	4	30.1	0	10.8	13.3
3	f	-92	-92	5180	14	AP-C-4F-02	22	0	7.2	8.2	4	30.1	0	10.8	13.3
3	f	-66.88888889	-66	2437	63	AP-C-4F-02	22	0	7.2	8.2	4	30.1	0	10.8	13.3
3	e	-88.81081081	-88	5180	37	AP-C-4F-02	24	0	7.2	8.2	4	30.1	0	10.8	13.3
3	e	-65.33	-64	2437	100	AP-C-4F-02	24	0	7.2	8.2	4	30.1	0	10.8	13.3
3	d	-86	-86	5180	70	AP-C-4F-02	26	0	7.2	8.2	4	30.1	0	10.8	13.3
3	d	-69.3164557	-69	2437	79	AP-C-4F-02	26	0	7.2	8.2	4	30.1	0	10.8	13.3
3	c	-79.93055556	-80	5180	72	AP-C-4F-02	28	0	7.2	8.2	4	30.1	0	10.8	13.3
3	c	-65.80555556	-66	2437	72	AP-C-4F-02	28	0	7.2	8.2	4	30.1	0	10.8	13.3
3	b	-80.1875	-80	5180	16	AP-C-4F-02	30	0	7.2	8.2	4	30.1	0	10.8	13.3
3	o	-85.5	-85.5	2437	42	AP-C-4F-02	4	0	7.2	8.2	4	30.1	0	10.8	13.3
3	n	-92	-92	2437	7	AP-C-4F-02	6	0	7.2	8.2	4	30.1	0	10.8	13.3
3	m	-87	-87	2437	16	AP-C-4F-02	8	0	7.2	8.2	4	30.1	0	10.8	13.3
3	l	-86	-86	2437	14	AP-C-4F-02	10	0	7.2	8.2	4	30.1	0	10.8	13.3
3	k	-85	-85	2437	7	AP-C-4F-02	12	0	7.2	8.2	4	30.1	0	10.8	13.3
4	a	-62.76923077	-72	5180	13	AP-C-4F-02	32	0	10.8	11.8	4	30.1	0	10.8	13.3
4	a	-38.82795699	-39	2437	93	AP-C-4F-02	32	0	10.8	11.8	4	30.1	0	10.8	13.3
4	b	-49.58	-49	5180	100	AP-C-4F-02	30	0	10.8	11.8	4	30.1	0	10.8	13.3
4	b	-46.23	-46	2437	100	AP-C-4F-02	30	0	10.8	11.8	4	30.1	0	10.8	13.3
4	k	-79.19444444	-78	5180	72	AP-C-4F-02	12	0	10.8	11.8	4	30.1	0	10.8	13.3
4	k	-74.18918919	-73	2437	37	AP-C-4F-02	12	0	10.8	11.8	4	30.1	0	10.8	13.3
4	j	-80.73417722	-81	5180	79	AP-C-4F-02	14	0	10.8	11.8	4	30.1	0	10.8	13.3
4	j	-68.875	-69	2437	56	AP-C-4F-02	14	0	10.8	11.8	4	30.1	0	10.8	13.3
4	i	-73.39784946	-73	5180	93	AP-C-4F-02	16	0	10.8	11.8	4	30.1	0	10.8	13.3
4	i	-69.7	-68	2437	70	AP-C-4F-02	16	0	10.8	11.8	4	30.1	0	10.8	13.3
4	h	-73.26744186	-73	5180	86	AP-C-4F-02	18	0	10.8	11.8	4	30.1	0	10.8	13.3
4	h	-67.97222222	-68	2437	72	AP-C-4F-02	18	0	10.8	11.8	4	30.1	0	10.8	13.3
4	g	-69.19	-70	5180	100	AP-C-4F-02	20	0	10.8	11.8	4	30.1	0	10.8	13.3
4	g	-62	-62	2437	93	AP-C-4F-02	20	0	10.8	11.8	4	30.1	0	10.8	13.3
4	f	-71.96774194	-72	5180	93	AP-C-4F-02	22	0	10.8	11.8	4	30.1	0	10.8	13.3
4	f	-63.23076923	-63	2437	91	AP-C-4F-02	22	0	10.8	11.8	4	30.1	0	10.8	13.3
4	e	-65.96	-65	5180	100	AP-C-4F-02	24	0	10.8	11.8	4	30.1	0	10.8	13.3
4	e	-52.68	-53	2437	100	AP-C-4F-02	24	0	10.8	11.8	4	30.1	0	10.8	13.3
4	d	-64.23	-65	5180	100	AP-C-4F-02	26	0	10.8	11.8	4	30.1	0	10.8	13.3
4	d	-57.8172043	-59	2437	93	AP-C-4F-02	26	0	10.8	11.8	4	30.1	0	10.8	13.3
4	c	-59.12	-59	5180	100	AP-C-4F-02	28	0	10.8	11.8	4	30.1	0	10.8	13.3
4	c	-38.02150538	-39	2437	93	AP-C-4F-02	28	0	10.8	11.8	4	30.1	0	10.8	13.3
4	r	-76.81818182	-78	5180	77	AP-C-4F-02	0	2	10.8	11.8	4	30.1	0	10.8	13.3
4	r	-83.83333333	-83.5	2437	42	AP-C-4F-02	0	2	10.8	11.8	4	30.1	0	10.8	13.3
4	q	-69.65116279	-69	5180	86	AP-C-4F-02	0	0	10.8	11.8	4	30.1	0	10.8	13.3
4	q	-71.35443038	-71	2437	79	AP-C-4F-02	0	0	10.8	11.8	4	30.1	0	10.8	13.3
4	p	-82.05555556	-82	5180	72	AP-C-4F-02	2	0	10.8	11.8	4	30.1	0	10.8	13.3
4	p	-81.25	-83	2437	56	AP-C-4F-02	2	0	10.8	11.8	4	30.1	0	10.8	13.3
4	o	-78.61111111	-78	5180	72	AP-C-4F-02	4	0	10.8	11.8	4	30.1	0	10.8	13.3
4	o	-75.44615385	-76	2437	65	AP-C-4F-02	4	0	10.8	11.8	4	30.1	0	10.8	13.3
4	n	-76.5625	-77	2437	16	AP-C-4F-02	6	0	10.8	11.8	4	30.1	0	10.8	13.3
4	m	-81.53846154	-82	5180	65	AP-C-4F-02	8	0	10.8	11.8	4	30.1	0	10.8	13.3
4	m	-69.29113924	-70	2437	79	AP-C-4F-02	8	0	10.8	11.8	4	30.1	0	10.8	13.3
4	l	-85.46153846	-85	5180	91	AP-C-4F-02	10	0	10.8	11.8	4	30.1	0	10.8	13.3
4	l	-70.07843137	-70	2437	51	AP-C-4F-02	10	0	10.8	11.8	4	30.1	0	10.8	13.3
3	a	-87.86666667	-88	5180	45	AP-C-4F-03	32	0	7.2	8.2	4	20.8	0	10.8	13.3
3	a	-77.33333333	-76	2437	21	AP-C-4F-03	32	0	7.2	8.2	4	20.8	0	10.8	13.3
3	b	-73.29166667	-73	2437	72	AP-C-4F-03	30	0	7.2	8.2	4	20.8	0	10.8	13.3
3	j	-69.875	-69.5	2437	72	AP-C-4F-03	14	0	7.2	8.2	4	20.8	0	10.8	13.3
3	i	-86.46153846	-87	5180	91	AP-C-4F-03	16	0	7.2	8.2	4	20.8	0	10.8	13.3
3	i	-68.57142857	-68	2437	49	AP-C-4F-03	16	0	7.2	8.2	4	20.8	0	10.8	13.3
3	h	-84.72972973	-85	5180	37	AP-C-4F-03	18	0	7.2	8.2	4	20.8	0	10.8	13.3
3	h	-65.37974684	-65	2437	79	AP-C-4F-03	18	0	7.2	8.2	4	20.8	0	10.8	13.3
3	g	-85.2	-86	5180	35	AP-C-4F-03	20	0	7.2	8.2	4	20.8	0	10.8	13.3
3	g	-57.71	-59	2437	100	AP-C-4F-03	20	0	7.2	8.2	4	20.8	0	10.8	13.3
3	f	-74.69620253	-75	5180	79	AP-C-4F-03	22	0	7.2	8.2	4	20.8	0	10.8	13.3
3	f	-61.87209302	-62	2437	86	AP-C-4F-03	22	0	7.2	8.2	4	20.8	0	10.8	13.3
3	e	-85.18055556	-86	5180	72	AP-C-4F-03	24	0	7.2	8.2	4	20.8	0	10.8	13.3
3	e	-65.57142857	-66.5	2437	98	AP-C-4F-03	24	0	7.2	8.2	4	20.8	0	10.8	13.3
3	d	-86.04166667	-85	5180	72	AP-C-4F-03	26	0	7.2	8.2	4	20.8	0	10.8	13.3
3	d	-65.9	-66	2437	100	AP-C-4F-03	26	0	7.2	8.2	4	20.8	0	10.8	13.3
3	c	-85.5	-85	5180	72	AP-C-4F-03	28	0	7.2	8.2	4	20.8	0	10.8	13.3
3	c	-68.96551724	-69	2437	58	AP-C-4F-03	28	0	7.2	8.2	4	20.8	0	10.8	13.3
3	b	-86.84615385	-87	5180	65	AP-C-4F-03	30	0	7.2	8.2	4	20.8	0	10.8	13.3
3	r	-86	-86	2437	7	AP-C-4F-03	0	2	7.2	8.2	4	20.8	0	10.8	13.3
3	o	-82	-82	2437	28	AP-C-4F-03	4	0	7.2	8.2	4	20.8	0	10.8	13.3
3	n	-84.63636364	-85	2437	11	AP-C-4F-03	6	0	7.2	8.2	4	20.8	0	10.8	13.3
3	m	-77.66666667	-77	2437	21	AP-C-4F-03	8	0	7.2	8.2	4	20.8	0	10.8	13.3
3	l	-82.84210526	-81	2437	19	AP-C-4F-03	10	0	7.2	8.2	4	20.8	0	10.8	13.3
3	k	-92	-92	5180	7	AP-C-4F-03	12	0	7.2	8.2	4	20.8	0	10.8	13.3
3	k	-80.27272727	-80	2437	44	AP-C-4F-03	12	0	7.2	8.2	4	20.8	0	10.8	13.3
4	a	-65.36	-65	5180	25	AP-C-4F-03	32	0	10.8	11.8	4	20.8	0	10.8	13.3
4	a	-68.22222222	-65	2437	72	AP-C-4F-03	32	0	10.8	11.8	4	20.8	0	10.8	13.3
4	b	-61.74	-62	5180	100	AP-C-4F-03	30	0	10.8	11.8	4	20.8	0	10.8	13.3
4	b	-57.43010753	-58	2437	93	AP-C-4F-03	30	0	10.8	11.8	4	20.8	0	10.8	13.3
4	k	-73.87	-73	5180	100	AP-C-4F-03	12	0	10.8	11.8	4	20.8	0	10.8	13.3
4	k	-63.8372093	-63	2437	86	AP-C-4F-03	12	0	10.8	11.8	4	20.8	0	10.8	13.3
4	j	-65.39	-65	5180	100	AP-C-4F-03	14	0	10.8	11.8	4	20.8	0	10.8	13.3
4	j	-62.38461538	-63	2437	91	AP-C-4F-03	14	0	10.8	11.8	4	20.8	0	10.8	13.3
4	i	-61.86	-62	5180	100	AP-C-4F-03	16	0	10.8	11.8	4	20.8	0	10.8	13.3
4	i	-56.95	-56	2437	100	AP-C-4F-03	16	0	10.8	11.8	4	20.8	0	10.8	13.3
4	h	-60.03	-60	5180	100	AP-C-4F-03	18	0	10.8	11.8	4	20.8	0	10.8	13.3
4	h	-44.86	-45	2437	100	AP-C-4F-03	18	0	10.8	11.8	4	20.8	0	10.8	13.3
4	g	-51.14	-51	5180	100	AP-C-4F-03	20	0	10.8	11.8	4	20.8	0	10.8	13.3
4	g	-43.72	-43	2437	100	AP-C-4F-03	20	0	10.8	11.8	4	20.8	0	10.8	13.3
4	f	-52.11	-52	5180	100	AP-C-4F-03	22	0	10.8	11.8	4	20.8	0	10.8	13.3
4	f	-38.79	-38	2437	100	AP-C-4F-03	22	0	10.8	11.8	4	20.8	0	10.8	13.3
4	e	-58.75	-58	5180	100	AP-C-4F-03	24	0	10.8	11.8	4	20.8	0	10.8	13.3
4	e	-41.77	-41	2437	100	AP-C-4F-03	24	0	10.8	11.8	4	20.8	0	10.8	13.3
4	d	-58.35	-58	5180	100	AP-C-4F-03	26	0	10.8	11.8	4	20.8	0	10.8	13.3
4	d	-61.37	-62	2437	100	AP-C-4F-03	26	0	10.8	11.8	4	20.8	0	10.8	13.3
4	c	-59.44	-59	5180	100	AP-C-4F-03	28	0	10.8	11.8	4	20.8	0	10.8	13.3
4	c	-61.95698925	-61	2437	93	AP-C-4F-03	28	0	10.8	11.8	4	20.8	0	10.8	13.3
4	s	-85.4375	-85	2437	16	AP-C-4F-03	0	4	10.8	11.8	4	20.8	0	10.8	13.3
4	r	-84.81034483	-84	5180	58	AP-C-4F-03	0	2	10.8	11.8	4	20.8	0	10.8	13.3
4	r	-79.52307692	-81	2437	65	AP-C-4F-03	0	2	10.8	11.8	4	20.8	0	10.8	13.3
4	q	-70.4516129	-70	5180	93	AP-C-4F-03	0	0	10.8	11.8	4	20.8	0	10.8	13.3
4	q	-67.16666667	-67	2437	84	AP-C-4F-03	0	0	10.8	11.8	4	20.8	0	10.8	13.3
4	p	-82.33333333	-82	5180	63	AP-C-4F-03	2	0	10.8	11.8	4	20.8	0	10.8	13.3
4	p	-79.55555556	-81	2437	63	AP-C-4F-03	2	0	10.8	11.8	4	20.8	0	10.8	13.3
4	o	-79.81818182	-79	5180	77	AP-C-4F-03	4	0	10.8	11.8	4	20.8	0	10.8	13.3
4	o	-77.5	-77	2437	70	AP-C-4F-03	4	0	10.8	11.8	4	20.8	0	10.8	13.3
4	n	-79.46428571	-79.5	5180	28	AP-C-4F-03	6	0	10.8	11.8	4	20.8	0	10.8	13.3
4	n	-78.02531646	-78	2437	79	AP-C-4F-03	6	0	10.8	11.8	4	20.8	0	10.8	13.3
4	m	-76.30769231	-77	5180	65	AP-C-4F-03	8	0	10.8	11.8	4	20.8	0	10.8	13.3
4	m	-76.1627907	-78	2437	86	AP-C-4F-03	8	0	10.8	11.8	4	20.8	0	10.8	13.3
4	l	-72.54651163	-72	5180	86	AP-C-4F-03	10	0	10.8	11.8	4	20.8	0	10.8	13.3
4	l	-74.03921569	-75	2437	51	AP-C-4F-03	10	0	10.8	11.8	4	20.8	0	10.8	13.3
3	a	-86	-86	2437	55	AP-C-4F-04	32	0	7.2	8.2	4	9.2	0	10.8	13.3
3	b	-75.4	-75	2437	35	AP-C-4F-04	30	0	7.2	8.2	4	9.2	0	10.8	13.3
3	j	-83.5	-83.5	5180	28	AP-C-4F-04	14	0	7.2	8.2	4	9.2	0	10.8	13.3
3	j	-63.65	-63	2437	100	AP-C-4F-04	14	0	7.2	8.2	4	9.2	0	10.8	13.3
3	i	-85.88235294	-86	5180	51	AP-C-4F-04	16	0	7.2	8.2	4	9.2	0	10.8	13.3
3	i	-67.7311828	-68	2437	93	AP-C-4F-04	16	0	7.2	8.2	4	9.2	0	10.8	13.3
3	h	-73.33	-74	2437	100	AP-C-4F-04	18	0	7.2	8.2	4	9.2	0	10.8	13.3
3	g	-73.07526882	-73	2437	93	AP-C-4F-04	20	0	7.2	8.2	4	9.2	0	10.8	13.3
3	f	-69.62025316	-70	2437	79	AP-C-4F-04	22	0	7.2	8.2	4	9.2	0	10.8	13.3
3	e	-74.58823529	-73	2437	51	AP-C-4F-04	24	0	7.2	8.2	4	9.2	0	10.8	13.3
3	d	-78.5	-78.5	2437	28	AP-C-4F-04	26	0	7.2	8.2	4	9.2	0	10.8	13.3
3	c	-80.5	-80.5	2437	14	AP-C-4F-04	28	0	7.2	8.2	4	9.2	0	10.8	13.3
3	r	-88.68181818	-89	5180	44	AP-C-4F-04	0	2	7.2	8.2	4	9.2	0	10.8	13.3
3	r	-66.53488372	-66	2437	86	AP-C-4F-04	0	2	7.2	8.2	4	9.2	0	10.8	13.3
3	q	-67.41666667	-66	2437	72	AP-C-4F-04	0	0	7.2	8.2	4	9.2	0	10.8	13.3
3	p	-87	-87	5180	7	AP-C-4F-04	2	0	7.2	8.2	4	9.2	0	10.8	13.3
3	p	-66	-66	2437	100	AP-C-4F-04	2	0	7.2	8.2	4	9.2	0	10.8	13.3
3	o	-88.56756757	-89	5180	37	AP-C-4F-04	4	0	7.2	8.2	4	9.2	0	10.8	13.3
3	o	-70.31	-70	2437	100	AP-C-4F-04	4	0	7.2	8.2	4	9.2	0	10.8	13.3
3	n	-85.01162791	-85	5180	86	AP-C-4F-04	6	0	7.2	8.2	4	9.2	0	10.8	13.3
3	n	-67.24731183	-67	2437	93	AP-C-4F-04	6	0	7.2	8.2	4	9.2	0	10.8	13.3
3	m	-77.125	-77	5180	56	AP-C-4F-04	8	0	7.2	8.2	4	9.2	0	10.8	13.3
3	m	-61.59139785	-62	2437	93	AP-C-4F-04	8	0	7.2	8.2	4	9.2	0	10.8	13.3
3	l	-73.52688172	-73	5180	93	AP-C-4F-04	10	0	7.2	8.2	4	9.2	0	10.8	13.3
3	l	-62.7	-63	2437	100	AP-C-4F-04	10	0	7.2	8.2	4	9.2	0	10.8	13.3
3	k	-74.50537634	-74	5180	93	AP-C-4F-04	12	0	7.2	8.2	4	9.2	0	10.8	13.3
3	k	-58.44	-59	2437	100	AP-C-4F-04	12	0	7.2	8.2	4	9.2	0	10.8	13.3
4	a	-75.32911392	-76	5180	79	AP-C-4F-04	32	0	10.8	11.8	4	9.2	0	10.8	13.3
4	a	-69.8	-72	2437	35	AP-C-4F-04	32	0	10.8	11.8	4	9.2	0	10.8	13.3
4	b	-76.56944444	-77	5180	72	AP-C-4F-04	30	0	10.8	11.8	4	9.2	0	10.8	13.3
4	b	-64.36363636	-64	2437	77	AP-C-4F-04	30	0	10.8	11.8	4	9.2	0	10.8	13.3
4	k	-60.07	-60	5180	100	AP-C-4F-04	12	0	10.8	11.8	4	9.2	0	10.8	13.3
4	k	-41.03225806	-40	2437	93	AP-C-4F-04	12	0	10.8	11.8	4	9.2	0	10.8	13.3
4	j	-62.44	-62	5180	100	AP-C-4F-04	14	0	10.8	11.8	4	9.2	0	10.8	13.3
4	j	-48.65	-48	2437	100	AP-C-4F-04	14	0	10.8	11.8	4	9.2	0	10.8	13.3
4	i	-67.31	-67	5180	100	AP-C-4F-04	16	0	10.8	11.8	4	9.2	0	10.8	13.3
4	i	-52.11	-51	2437	100	AP-C-4F-04	16	0	10.8	11.8	4	9.2	0	10.8	13.3
4	h	-67.59	-68	5180	100	AP-C-4F-04	18	0	10.8	11.8	4	9.2	0	10.8	13.3
4	h	-61.74	-61	2437	100	AP-C-4F-04	18	0	10.8	11.8	4	9.2	0	10.8	13.3
4	g	-73.1827957	-73	5180	93	AP-C-4F-04	20	0	10.8	11.8	4	9.2	0	10.8	13.3
4	g	-57.71	-57	2437	100	AP-C-4F-04	20	0	10.8	11.8	4	9.2	0	10.8	13.3
4	f	-71.22	-71	5180	100	AP-C-4F-04	22	0	10.8	11.8	4	9.2	0	10.8	13.3
4	f	-63.6744186	-63	2437	86	AP-C-4F-04	22	0	10.8	11.8	4	9.2	0	10.8	13.3
4	e	-69.54	-70	5180	100	AP-C-4F-04	24	0	10.8	11.8	4	9.2	0	10.8	13.3
4	e	-61.95	-63	2437	100	AP-C-4F-04	24	0	10.8	11.8	4	9.2	0	10.8	13.3
4	d	-76.01388889	-76	5180	72	AP-C-4F-04	26	0	10.8	11.8	4	9.2	0	10.8	13.3
4	d	-61.7	-62	2437	100	AP-C-4F-04	26	0	10.8	11.8	4	9.2	0	10.8	13.3
4	c	-76.91139241	-77	5180	79	AP-C-4F-04	28	0	10.8	11.8	4	9.2	0	10.8	13.3
4	c	-68.78461538	-69	2437	65	AP-C-4F-04	28	0	10.8	11.8	4	9.2	0	10.8	13.3
4	v	-95	-95	5180	7	AP-C-4F-04	0	10	10.8	11.8	4	9.2	0	10.8	13.3
4	u	-90.5	-90.5	5180	42	AP-C-4F-04	0	8	10.8	11.8	4	9.2	0	10.8	13.3
4	t	-90	-90	5180	7	AP-C-4F-04	0	6	10.8	11.8	4	9.2	0	10.8	13.3
4	t	-80.2	-80	2437	35	AP-C-4F-04	0	6	10.8	11.8	4	9.2	0	10.8	13.3
4	s	-86.06666667	-87	5180	30	AP-C-4F-04	0	4	10.8	11.8	4	9.2	0	10.8	13.3
4	s	-83.66666667	-85	2437	21	AP-C-4F-04	0	4	10.8	11.8	4	9.2	0	10.8	13.3
4	r	-63.89	-64	5180	100	AP-C-4F-04	0	2	10.8	11.8	4	9.2	0	10.8	13.3
4	r	-60.05	-60	2437	100	AP-C-4F-04	0	2	10.8	11.8	4	9.2	0	10.8	13.3
4	q	-64.5	-63	5180	62	AP-C-4F-04	0	0	10.8	11.8	4	9.2	0	10.8	13.3
4	q	-57.44	-57	2437	100	AP-C-4F-04	0	0	10.8	11.8	4	9.2	0	10.8	13.3
4	p	-70.89	-70	5180	100	AP-C-4F-04	2	0	10.8	11.8	4	9.2	0	10.8	13.3
4	p	-62.46	-62	2437	100	AP-C-4F-04	2	0	10.8	11.8	4	9.2	0	10.8	13.3
4	o	-69.90322581	-70	5180	93	AP-C-4F-04	4	0	10.8	11.8	4	9.2	0	10.8	13.3
4	o	-66.29	-66	2437	100	AP-C-4F-04	4	0	10.8	11.8	4	9.2	0	10.8	13.3
4	n	-60.07	-60	5180	100	AP-C-4F-04	6	0	10.8	11.8	4	9.2	0	10.8	13.3
4	n	-46.91397849	-47	2437	93	AP-C-4F-04	6	0	10.8	11.8	4	9.2	0	10.8	13.3
4	m	-56.27	-56	5180	100	AP-C-4F-04	8	0	10.8	11.8	4	9.2	0	10.8	13.3
4	m	-40.79	-41	2437	100	AP-C-4F-04	8	0	10.8	11.8	4	9.2	0	10.8	13.3
4	l	-50.37634409	-51	5180	93	AP-C-4F-04	10	0	10.8	11.8	4	9.2	0	10.8	13.3
4	l	-43.14	-43	2437	100	AP-C-4F-04	10	0	10.8	11.8	4	9.2	0	10.8	13.3
4	u	-83	-83	2437	30	AP-C-5F-01	0	8	10.8	11.8	5	-1.9	-11.2	14.4	16.9
4	s	-85.8	-86	2437	35	AP-C-5F-01	0	4	10.8	11.8	5	-1.9	-11.2	14.4	16.9
4	r	-85.5625	-86	2437	16	AP-C-5F-01	0	2	10.8	11.8	5	-1.9	-11.2	14.4	16.9
4	q	-82	-82	2437	7	AP-C-5F-01	0	0	10.8	11.8	5	-1.9	-11.2	14.4	16.9
4	p	-78.44444444	-78	2437	63	AP-C-5F-01	2	0	10.8	11.8	5	-1.9	-11.2	14.4	16.9
4	o	-77.7	-77.5	2437	70	AP-C-5F-01	4	0	10.8	11.8	5	-1.9	-11.2	14.4	16.9
4	n	-82.5	-82.5	2437	14	AP-C-5F-01	6	0	10.8	11.8	5	-1.9	-11.2	14.4	16.9
3	a	-79	-79	2437	55	AP-C-5F-02	32	0	7.2	8.2	5	32.2	0	14.4	16.9
3	b	-88	-88	2437	7	AP-C-5F-02	30	0	7.2	8.2	5	32.2	0	14.4	16.9
3	g	-89	-89	2437	7	AP-C-5F-02	20	0	7.2	8.2	5	32.2	0	14.4	16.9
3	f	-83	-83	2437	7	AP-C-5F-02	22	0	7.2	8.2	5	32.2	0	14.4	16.9
3	d	-86	-86	2437	7	AP-C-5F-02	26	0	7.2	8.2	5	32.2	0	14.4	16.9
3	c	-77.1875	-77	2437	16	AP-C-5F-02	28	0	7.2	8.2	5	32.2	0	14.4	16.9
4	a	-79.41666667	-79	5180	84	AP-C-5F-02	32	0	10.8	11.8	5	32.2	0	14.4	16.9
4	a	-62.56989247	-63	2437	93	AP-C-5F-02	32	0	10.8	11.8	5	32.2	0	14.4	16.9
4	b	-78.84090909	-79	5180	44	AP-C-5F-02	30	0	10.8	11.8	5	32.2	0	14.4	16.9
4	b	-67.82278481	-69	2437	79	AP-C-5F-02	30	0	10.8	11.8	5	32.2	0	14.4	16.9
4	j	-83	-83	2437	14	AP-C-5F-02	14	0	10.8	11.8	5	32.2	0	14.4	16.9
4	i	-79.66666667	-80	2437	21	AP-C-5F-02	16	0	10.8	11.8	5	32.2	0	14.4	16.9
4	h	-75.2	-76	2437	35	AP-C-5F-02	18	0	10.8	11.8	5	32.2	0	14.4	16.9
4	g	-90.83333333	-90.5	5180	42	AP-C-5F-02	20	0	10.8	11.8	5	32.2	0	14.4	16.9
4	g	-71.86111111	-72	2437	72	AP-C-5F-02	20	0	10.8	11.8	5	32.2	0	14.4	16.9
4	f	-89.66666667	-89	5180	42	AP-C-5F-02	22	0	10.8	11.8	5	32.2	0	14.4	16.9
4	f	-77.875	-77	2437	56	AP-C-5F-02	22	0	10.8	11.8	5	32.2	0	14.4	16.9
4	e	-89.25	-89.5	5180	56	AP-C-5F-02	24	0	10.8	11.8	5	32.2	0	14.4	16.9
4	e	-79.23611111	-78	2437	72	AP-C-5F-02	24	0	10.8	11.8	5	32.2	0	14.4	16.9
4	d	-83.53846154	-83	5180	65	AP-C-5F-02	26	0	10.8	11.8	5	32.2	0	14.4	16.9
4	d	-67.13924051	-66	2437	79	AP-C-5F-02	26	0	10.8	11.8	5	32.2	0	14.4	16.9
4	c	-83.41538462	-83	5180	65	AP-C-5F-02	28	0	10.8	11.8	5	32.2	0	14.4	16.9
4	c	-73.14285714	-74	2437	49	AP-C-5F-02	28	0	10.8	11.8	5	32.2	0	14.4	16.9
4	q	-81	-81	2437	7	AP-C-5F-02	0	0	10.8	11.8	5	32.2	0	14.4	16.9
3	a	-79	-79	2437	55	AP-C-5F-03	32	0	7.2	8.2	5	23	0	14.4	16.9
3	b	-73.86206897	-73	2437	58	AP-C-5F-03	30	0	7.2	8.2	5	23	0	14.4	16.9
3	i	-84.5	-84.5	2437	14	AP-C-5F-03	16	0	7.2	8.2	5	23	0	14.4	16.9
3	h	-80	-80	2437	7	AP-C-5F-03	18	0	7.2	8.2	5	23	0	14.4	16.9
3	g	-77	-79	2437	35	AP-C-5F-03	20	0	7.2	8.2	5	23	0	14.4	16.9
3	f	-83	-83	2437	7	AP-C-5F-03	22	0	7.2	8.2	5	23	0	14.4	16.9
3	e	-76.25	-76	2437	28	AP-C-5F-03	24	0	7.2	8.2	5	23	0	14.4	16.9
3	d	-77.28571429	-77	2437	49	AP-C-5F-03	26	0	7.2	8.2	5	23	0	14.4	16.9
3	c	-76.04545455	-77	2437	44	AP-C-5F-03	28	0	7.2	8.2	5	23	0	14.4	16.9
4	a	-82.79310345	-83	5180	58	AP-C-5F-03	32	0	10.8	11.8	5	23	0	14.4	16.9
4	a	-76.75	-76	2437	28	AP-C-5F-03	32	0	10.8	11.8	5	23	0	14.4	16.9
4	b	-65.4	-65	2437	35	AP-C-5F-03	30	0	10.8	11.8	5	23	0	14.4	16.9
4	k	-73.44444444	-73	2437	63	AP-C-5F-03	12	0	10.8	11.8	5	23	0	14.4	16.9
4	j	-78	-78	2437	14	AP-C-5F-03	14	0	10.8	11.8	5	23	0	14.4	16.9
4	i	-89	-89	5180	14	AP-C-5F-03	16	0	10.8	11.8	5	23	0	14.4	16.9
4	i	-69.96078431	-70	2437	51	AP-C-5F-03	16	0	10.8	11.8	5	23	0	14.4	16.9
4	h	-84.63888889	-84	5180	72	AP-C-5F-03	18	0	10.8	11.8	5	23	0	14.4	16.9
4	h	-61	-61	2437	35	AP-C-5F-03	18	0	10.8	11.8	5	23	0	14.4	16.9
4	g	-82.01960784	-81	5180	51	AP-C-5F-03	20	0	10.8	11.8	5	23	0	14.4	16.9
4	g	-66	-64.5	2437	70	AP-C-5F-03	20	0	10.8	11.8	5	23	0	14.4	16.9
4	f	-78.70886076	-79	5180	79	AP-C-5F-03	22	0	10.8	11.8	5	23	0	14.4	16.9
4	f	-64.36363636	-63	2437	77	AP-C-5F-03	22	0	10.8	11.8	5	23	0	14.4	16.9
4	e	-75.58461538	-75	5180	65	AP-C-5F-03	24	0	10.8	11.8	5	23	0	14.4	16.9
4	e	-63.46835443	-63	2437	79	AP-C-5F-03	24	0	10.8	11.8	5	23	0	14.4	16.9
4	d	-80.90697674	-78	5180	86	AP-C-5F-03	26	0	10.8	11.8	5	23	0	14.4	16.9
4	d	-62.22413793	-63	2437	58	AP-C-5F-03	26	0	10.8	11.8	5	23	0	14.4	16.9
4	c	-74.08333333	-73.5	5180	84	AP-C-5F-03	28	0	10.8	11.8	5	23	0	14.4	16.9
4	c	-65.2	-65	2437	35	AP-C-5F-03	28	0	10.8	11.8	5	23	0	14.4	16.9
4	b	-77.43037975	-77	5180	79	AP-C-5F-03	30	0	10.8	11.8	5	23	0	14.4	16.9
4	r	-85	-85	2437	7	AP-C-5F-03	0	2	10.8	11.8	5	23	0	14.4	16.9
4	q	-83.33333333	-84	2437	21	AP-C-5F-03	0	0	10.8	11.8	5	23	0	14.4	16.9
4	m	-83	-83	2437	14	AP-C-5F-03	8	0	10.8	11.8	5	23	0	14.4	16.9
4	l	-78.5	-78.5	2437	14	AP-C-5F-03	10	0	10.8	11.8	5	23	0	14.4	16.9
3	j	-81.04	-81	2437	50	AP-C-5F-04	14	0	7.2	8.2	5	9.1	0	14.4	16.9
3	i	-83	-83	2437	7	AP-C-5F-04	16	0	7.2	8.2	5	9.1	0	14.4	16.9
3	h	-81	-81	2437	14	AP-C-5F-04	18	0	7.2	8.2	5	9.1	0	14.4	16.9
3	e	-82	-82	2437	7	AP-C-5F-04	24	0	7.2	8.2	5	9.1	0	14.4	16.9
3	d	-87.5	-87.5	2437	14	AP-C-5F-04	26	0	7.2	8.2	5	9.1	0	14.4	16.9
3	r	-86	-86	2437	7	AP-C-5F-04	0	2	7.2	8.2	5	9.1	0	14.4	16.9
3	q	-80	-80	2437	14	AP-C-5F-04	0	0	7.2	8.2	5	9.1	0	14.4	16.9
3	p	-77.5	-77.5	2437	14	AP-C-5F-04	2	0	7.2	8.2	5	9.1	0	14.4	16.9
3	o	-80.57142857	-80	2437	49	AP-C-5F-04	4	0	7.2	8.2	5	9.1	0	14.4	16.9
3	n	-80.31944444	-80	2437	72	AP-C-5F-04	6	0	7.2	8.2	5	9.1	0	14.4	16.9
3	m	-84.16666667	-85	2437	42	AP-C-5F-04	8	0	7.2	8.2	5	9.1	0	14.4	16.9
3	l	-75.5625	-75	2437	32	AP-C-5F-04	10	0	7.2	8.2	5	9.1	0	14.4	16.9
3	k	-78	-78	2437	14	AP-C-5F-04	12	0	7.2	8.2	5	9.1	0	14.4	16.9
4	a	-86	-86	2437	7	AP-C-5F-04	32	0	10.8	11.8	5	9.1	0	14.4	16.9
4	b	-82	-82	2437	7	AP-C-5F-04	30	0	10.8	11.8	5	9.1	0	14.4	16.9
4	k	-83.23076923	-83	5180	65	AP-C-5F-04	12	0	10.8	11.8	5	9.1	0	14.4	16.9
4	k	-58.64	-59	2437	100	AP-C-5F-04	12	0	10.8	11.8	5	9.1	0	14.4	16.9
4	j	-82.79310345	-84	5180	58	AP-C-5F-04	14	0	10.8	11.8	5	9.1	0	14.4	16.9
4	j	-61.62	-61	2437	100	AP-C-5F-04	14	0	10.8	11.8	5	9.1	0	14.4	16.9
4	i	-81.72413793	-81	5180	58	AP-C-5F-04	16	0	10.8	11.8	5	9.1	0	14.4	16.9
4	i	-61.63636364	-61	2437	77	AP-C-5F-04	16	0	10.8	11.8	5	9.1	0	14.4	16.9
4	h	-88.06666667	-88	5180	30	AP-C-5F-04	18	0	10.8	11.8	5	9.1	0	14.4	16.9
4	h	-65.26582278	-65	2437	79	AP-C-5F-04	18	0	10.8	11.8	5	9.1	0	14.4	16.9
4	g	-87.33333333	-87	5180	63	AP-C-5F-04	20	0	10.8	11.8	5	9.1	0	14.4	16.9
4	g	-75.60344828	-76	2437	58	AP-C-5F-04	20	0	10.8	11.8	5	9.1	0	14.4	16.9
4	f	-92	-92	5180	7	AP-C-5F-04	22	0	10.8	11.8	5	9.1	0	14.4	16.9
4	f	-76	-76	2437	23	AP-C-5F-04	22	0	10.8	11.8	5	9.1	0	14.4	16.9
4	e	-90	-90	5180	7	AP-C-5F-04	24	0	10.8	11.8	5	9.1	0	14.4	16.9
4	e	-81	-82	2437	21	AP-C-5F-04	24	0	10.8	11.8	5	9.1	0	14.4	16.9
4	d	-77	-77	2437	7	AP-C-5F-04	26	0	10.8	11.8	5	9.1	0	14.4	16.9
4	c	-85	-85	2437	7	AP-C-5F-04	28	0	10.8	11.8	5	9.1	0	14.4	16.9
4	s	-81.66666667	-82	2437	21	AP-C-5F-04	0	4	10.8	11.8	5	9.1	0	14.4	16.9
4	r	-85.13846154	-85	5180	65	AP-C-5F-04	0	2	10.8	11.8	5	9.1	0	14.4	16.9
4	r	-71.07526882	-71	2437	93	AP-C-5F-04	0	2	10.8	11.8	5	9.1	0	14.4	16.9
4	q	-63.05	-62	2437	100	AP-C-5F-04	0	0	10.8	11.8	5	9.1	0	14.4	16.9
4	p	-88.89873418	-88	5180	79	AP-C-5F-04	2	0	10.8	11.8	5	9.1	0	14.4	16.9
4	p	-70.90909091	-71	2437	77	AP-C-5F-04	2	0	10.8	11.8	5	9.1	0	14.4	16.9
4	o	-90	-91	5180	35	AP-C-5F-04	4	0	10.8	11.8	5	9.1	0	14.4	16.9
4	o	-69.26	-69	2437	100	AP-C-5F-04	4	0	10.8	11.8	5	9.1	0	14.4	16.9
4	n	-84.05376344	-83	5180	93	AP-C-5F-04	6	0	10.8	11.8	5	9.1	0	14.4	16.9
4	n	-66.87341772	-67	2437	79	AP-C-5F-04	6	0	10.8	11.8	5	9.1	0	14.4	16.9
4	m	-79.33333333	-78	5180	63	AP-C-5F-04	8	0	10.8	11.8	5	9.1	0	14.4	16.9
4	m	-58.17	-58	2437	100	AP-C-5F-04	8	0	10.8	11.8	5	9.1	0	14.4	16.9
4	l	-76.11827957	-76	5180	93	AP-C-5F-04	10	0	10.8	11.8	5	9.1	0	14.4	16.9
4	l	-62.69892473	-63	2437	93	AP-C-5F-04	10	0	10.8	11.8	5	9.1	0	14.4	16.9
4	a	-75.5	-75.5	2437	70	AP-C-6F-02	32	0	10.8	11.8	6	31.8	0	18	20.5
4	e	-82	-82	2437	7	AP-C-6F-02	24	0	10.8	11.8	6	31.8	0	18	20.5
4	d	-77.33333333	-77	2437	21	AP-C-6F-02	26	0	10.8	11.8	6	31.8	0	18	20.5
4	c	-77	-77	2437	7	AP-C-6F-02	28	0	10.8	11.8	6	31.8	0	18	20.5
4	b	-86	-86	2437	7	AP-C-6F-03	30	0	10.8	11.8	6	22.9	0	18	20.5
4	k	-87.5	-87.5	2437	14	AP-C-6F-03	12	0	10.8	11.8	6	22.9	0	18	20.5
4	g	-83	-83	2437	7	AP-C-6F-03	20	0	10.8	11.8	6	22.9	0	18	20.5
4	f	-74.85714286	-75	2437	49	AP-C-6F-03	22	0	10.8	11.8	6	22.9	0	18	20.5
4	e	-76	-76	2437	7	AP-C-6F-03	24	0	10.8	11.8	6	22.9	0	18	20.5
4	d	-84.5	-84.5	2437	14	AP-C-6F-03	26	0	10.8	11.8	6	22.9	0	18	20.5
4	c	-80	-80	2437	7	AP-C-6F-03	28	0	10.8	11.8	6	22.9	0	18	20.5
3	k	-88.26086957	-88	2437	23	AP-C-6F-04	12	0	7.2	8.2	6	9.2	0	18	20.5
4	k	-76.14285714	-76	2437	49	AP-C-6F-04	12	0	10.8	11.8	6	9.2	0	18	20.5
4	i	-84	-84	2437	7	AP-C-6F-04	16	0	10.8	11.8	6	9.2	0	18	20.5
4	h	-81.53333333	-82	2437	30	AP-C-6F-04	18	0	10.8	11.8	6	9.2	0	18	20.5
4	g	-85	-85	2437	7	AP-C-6F-04	20	0	10.8	11.8	6	9.2	0	18	20.5
4	f	-82	-82	2437	2	AP-C-6F-04	22	0	10.8	11.8	6	9.2	0	18	20.5
4	q	-85.77777778	-86	2437	9	AP-C-6F-04	0	0	10.8	11.8	6	9.2	0	18	20.5
4	p	-81.33333333	-81.5	2437	42	AP-C-6F-04	2	0	10.8	11.8	6	9.2	0	18	20.5
4	n	-77	-77	2437	1	AP-C-6F-04	6	0	10.8	11.8	6	9.2	0	18	20.5
4	m	-76.66666667	-76	2437	42	AP-C-6F-04	8	0	10.8	11.8	6	9.2	0	18	20.5
4	l	-92	-92	5180	14	AP-C-6F-04	10	0	10.8	11.8	6	9.2	0	18	20.5
4	l	-79.68965517	-79	2437	58	AP-C-6F-04	10	0	10.8	11.8	6	9.2	0	18	20.5
3	a	-79	-79	2437	10	AP-C1-2F-01	32	0	7.2	8.2	2	33.6	20.6	3.6	6.1
3	a	-66.83544304	-67	5180	79	AP-C1-3F-01	32	0	7.2	8.2	3	31.5	15.8	7.2	9.7
3	a	-60.21	-60	2437	100	AP-C1-3F-01	32	0	7.2	8.2	3	31.5	15.8	7.2	9.7
3	b	-74.28571429	-75	2437	49	AP-C1-3F-01	30	0	7.2	8.2	3	31.5	15.8	7.2	9.7
3	d	-83	-83	2437	7	AP-C1-3F-01	26	0	7.2	8.2	3	31.5	15.8	7.2	9.7
3	c	-90.19607843	-90	5180	51	AP-C1-3F-01	28	0	7.2	8.2	3	31.5	15.8	7.2	9.7
3	c	-80.66666667	-80	2437	9	AP-C1-3F-01	28	0	7.2	8.2	3	31.5	15.8	7.2	9.7
3	b	-78	-78	5180	21	AP-C1-3F-01	30	0	7.2	8.2	3	31.5	15.8	7.2	9.7
3	ai	-91	-91	5180	2	AP-C1-3F-03	0	36	7.2	8.2	3	27.4	26.4	7.2	9.7
4	a	-90	-90	5180	2	AP-C1-4F-02	32	0	10.8	11.8	4	31.8	21.8	10.8	13.3
4	a	-83	-83	2437	7	AP-C1-4F-02	32	0	10.8	11.8	4	31.8	21.8	10.8	13.3
3	af	-86	-86	2437	7	AP-C2-1F-01	0	30	7.2	8.2	1	0	22.7	0	2.5
3	ae	-77.2173913	-77	2437	23	AP-C2-1F-01	0	28	7.2	8.2	1	0	22.7	0	2.5
3	ad	-84	-84	2437	14	AP-C2-1F-01	0	26	7.2	8.2	1	0	22.7	0	2.5
3	ac	-92	-92	5180	7	AP-C2-1F-01	0	24	7.2	8.2	1	0	22.7	0	2.5
3	ac	-71.23076923	-72	2437	65	AP-C2-1F-01	0	24	7.2	8.2	1	0	22.7	0	2.5
3	ab	-61.40697674	-61	2437	86	AP-C2-1F-01	0	22	7.2	8.2	1	0	22.7	0	2.5
3	aa	-73.19354839	-73	2437	31	AP-C2-1F-01	0	20	7.2	8.2	1	0	22.7	0	2.5
3	y	-65.93670886	-66	2437	79	AP-C2-1F-01	0	16	7.2	8.2	1	0	22.7	0	2.5
3	x	-77.2	-77	2437	35	AP-C2-1F-01	0	14	7.2	8.2	1	0	22.7	0	2.5
3	w	-71.12280702	-72	2437	57	AP-C2-1F-01	0	12	7.2	8.2	1	0	22.7	0	2.5
3	v	-82	-82	2437	7	AP-C2-1F-01	0	10	7.2	8.2	1	0	22.7	0	2.5
3	u	-77.66666667	-77.5	2437	42	AP-C2-1F-01	0	8	7.2	8.2	1	0	22.7	0	2.5
3	t	-84	-84	2437	7	AP-C2-1F-01	0	6	7.2	8.2	1	0	22.7	0	2.5
4	ad	-89.88888889	-91	2437	9	AP-C2-1F-01	0	26	10.8	11.8	1	0	22.7	0	2.5
4	aa	-85.5	-85.5	2437	14	AP-C2-1F-01	0	20	10.8	11.8	1	0	22.7	0	2.5
3	z	-72.75	-72.5	2437	28	AP-C2-1F-01	0	18	7.2	8.2	1	0	22.7	0	2.5
3	aj	-86.33333333	-86	2437	21	AP-C2-1F-02	0	38	7.2	8.2	1	0	29.8	0	2.5
3	ai	-77.77777778	-77	2437	63	AP-C2-1F-02	0	36	7.2	8.2	1	0	29.8	0	2.5
3	ah	-84	-84	2437	21	AP-C2-1F-02	0	34	7.2	8.2	1	0	29.8	0	2.5
3	ag	-80.13636364	-79	2437	44	AP-C2-1F-02	0	32	7.2	8.2	1	0	29.8	0	2.5
3	af	-82.54385965	-84	2437	57	AP-C2-1F-02	0	30	7.2	8.2	1	0	29.8	0	2.5
3	ae	-69.46666667	-69	2437	30	AP-C2-1F-02	0	28	7.2	8.2	1	0	29.8	0	2.5
3	ad	-83.875	-83	2437	16	AP-C2-1F-02	0	26	7.2	8.2	1	0	29.8	0	2.5
3	ac	-82	-82	2437	7	AP-C2-1F-02	0	24	7.2	8.2	1	0	29.8	0	2.5
3	ab	-81	-81	2437	7	AP-C2-1F-02	0	22	7.2	8.2	1	0	29.8	0	2.5
3	aa	-81.46666667	-82	2437	30	AP-C2-1F-02	0	20	7.2	8.2	1	0	29.8	0	2.5
4	ag	-88	-88	2437	7	AP-C2-1F-02	0	32	10.8	11.8	1	0	29.8	0	2.5
3	am	-72.67692308	-73	2437	65	AP-C2-1F-03	0	44	7.2	8.2	1	0	41.7	0	2.5
3	al	-91.625	-91	5180	56	AP-C2-1F-03	0	42	7.2	8.2	1	0	41.7	0	2.5
3	al	-80.5	-80.5	2437	42	AP-C2-1F-03	0	42	7.2	8.2	1	0	41.7	0	2.5
3	ak	-75	-75	2437	35	AP-C2-1F-03	0	40	7.2	8.2	1	0	41.7	0	2.5
3	aj	-71.75	-72	2437	44	AP-C2-1F-03	0	38	7.2	8.2	1	0	41.7	0	2.5
3	ai	-77.75	-78	2437	28	AP-C2-1F-03	0	36	7.2	8.2	1	0	41.7	0	2.5
3	ah	-79.28571429	-80	2437	49	AP-C2-1F-03	0	34	7.2	8.2	1	0	41.7	0	2.5
3	ag	-82	-82	2437	14	AP-C2-1F-03	0	32	7.2	8.2	1	0	41.7	0	2.5
3	af	-85.96551724	-85	2437	29	AP-C2-1F-03	0	30	7.2	8.2	1	0	41.7	0	2.5
3	ae	-86	-86	2437	7	AP-C2-1F-03	0	28	7.2	8.2	1	0	41.7	0	2.5
3	ab	-86	-86	2437	7	AP-C2-1F-03	0	22	7.2	8.2	1	0	41.7	0	2.5
3	ao	-86	-86	2437	7	AP-C2-1F-03	0	48	7.2	8.2	1	0	41.7	0	2.5
3	an	-75.85714286	-76	2437	49	AP-C2-1F-03	0	46	7.2	8.2	1	0	41.7	0	2.5
4	ak	-85	-85	2437	7	AP-C2-1F-03	0	40	10.8	11.8	1	0	41.7	0	2.5
4	am	-87	-87	2437	7	AP-C2-1F-03	0	44	10.8	11.8	1	0	41.7	0	2.5
3	ai	-80	-80	2437	14	AP-C2-2F-01	0	36	7.2	8.2	2	0	19.1	3.6	6.1
3	ah	-77.375	-78	2437	56	AP-C2-2F-01	0	34	7.2	8.2	2	0	19.1	3.6	6.1
3	ag	-80	-81	2437	28	AP-C2-2F-01	0	32	7.2	8.2	2	0	19.1	3.6	6.1
3	af	-72.88888889	-73	2437	72	AP-C2-2F-01	0	30	7.2	8.2	2	0	19.1	3.6	6.1
3	ae	-74.66666667	-75.5	2437	42	AP-C2-2F-01	0	28	7.2	8.2	2	0	19.1	3.6	6.1
3	ad	-87.54545455	-88	5180	77	AP-C2-2F-01	0	26	7.2	8.2	2	0	19.1	3.6	6.1
3	ad	-75.83544304	-76	2437	79	AP-C2-2F-01	0	26	7.2	8.2	2	0	19.1	3.6	6.1
3	ac	-82.86075949	-83	5180	79	AP-C2-2F-01	0	24	7.2	8.2	2	0	19.1	3.6	6.1
3	ac	-61.11	-61	2437	100	AP-C2-2F-01	0	24	7.2	8.2	2	0	19.1	3.6	6.1
3	ab	-78.98611111	-80	5180	72	AP-C2-2F-01	0	22	7.2	8.2	2	0	19.1	3.6	6.1
3	ab	-59.4516129	-60	2437	93	AP-C2-2F-01	0	22	7.2	8.2	2	0	19.1	3.6	6.1
3	aa	-67.7	-67	5180	100	AP-C2-2F-01	0	20	7.2	8.2	2	0	19.1	3.6	6.1
3	aa	-56.56989247	-56	2437	93	AP-C2-2F-01	0	20	7.2	8.2	2	0	19.1	3.6	6.1
3	ap	-88	-88	2437	2	AP-C2-2F-01	0	50	7.2	8.2	2	0	19.1	3.6	6.1
3	an	-87	-87	2437	7	AP-C2-2F-01	0	46	7.2	8.2	2	0	19.1	3.6	6.1
3	y	-75.83333333	-75.5	5180	84	AP-C2-2F-01	0	16	7.2	8.2	2	0	19.1	3.6	6.1
3	y	-52.38	-53	2437	100	AP-C2-2F-01	0	16	7.2	8.2	2	0	19.1	3.6	6.1
3	x	-75.70769231	-75	5180	65	AP-C2-2F-01	0	14	7.2	8.2	2	0	19.1	3.6	6.1
3	x	-63.46236559	-61	2437	93	AP-C2-2F-01	0	14	7.2	8.2	2	0	19.1	3.6	6.1
3	w	-81.04705882	-80	5180	85	AP-C2-2F-01	0	12	7.2	8.2	2	0	19.1	3.6	6.1
3	w	-61.01075269	-61	2437	93	AP-C2-2F-01	0	12	7.2	8.2	2	0	19.1	3.6	6.1
3	v	-83.73255814	-83	5180	86	AP-C2-2F-01	0	10	7.2	8.2	2	0	19.1	3.6	6.1
3	v	-67.58139535	-68	2437	86	AP-C2-2F-01	0	10	7.2	8.2	2	0	19.1	3.6	6.1
3	u	-87.43103448	-88	5180	58	AP-C2-2F-01	0	8	7.2	8.2	2	0	19.1	3.6	6.1
3	u	-68.14	-68	2437	100	AP-C2-2F-01	0	8	7.2	8.2	2	0	19.1	3.6	6.1
3	t	-90.25	-90.5	5180	28	AP-C2-2F-01	0	6	7.2	8.2	2	0	19.1	3.6	6.1
3	t	-77.10465116	-78	2437	86	AP-C2-2F-01	0	6	7.2	8.2	2	0	19.1	3.6	6.1
3	s	-75	-75	2437	91	AP-C2-2F-01	0	4	7.2	8.2	2	0	19.1	3.6	6.1
3	r	-78.76923077	-79	2437	26	AP-C2-2F-01	0	2	7.2	8.2	2	0	19.1	3.6	6.1
3	q	-81.25	-81	2437	28	AP-C2-2F-01	0	0	7.2	8.2	2	0	19.1	3.6	6.1
4	ag	-82	-82	2437	7	AP-C2-2F-01	0	32	10.8	11.8	2	0	19.1	3.6	6.1
4	ae	-78.5	-78.5	2437	14	AP-C2-2F-01	0	28	10.8	11.8	2	0	19.1	3.6	6.1
4	ac	-92.75	-92.5	5180	28	AP-C2-2F-01	0	24	10.8	11.8	2	0	19.1	3.6	6.1
4	ac	-78.33333333	-78	2437	21	AP-C2-2F-01	0	24	10.8	11.8	2	0	19.1	3.6	6.1
4	ab	-76.8	-77	2437	35	AP-C2-2F-01	0	22	10.8	11.8	2	0	19.1	3.6	6.1
4	aa	-89.5	-89.5	5180	14	AP-C2-2F-01	0	20	10.8	11.8	2	0	19.1	3.6	6.1
4	aa	-70.63076923	-70	2437	65	AP-C2-2F-01	0	20	10.8	11.8	2	0	19.1	3.6	6.1
3	z	-66.49	-66	5180	100	AP-C2-2F-01	0	18	7.2	8.2	2	0	19.1	3.6	6.1
3	z	-56.44	-57	2437	100	AP-C2-2F-01	0	18	7.2	8.2	2	0	19.1	3.6	6.1
4	z	-90.5	-90	5180	42	AP-C2-2F-01	0	18	10.8	11.8	2	0	19.1	3.6	6.1
4	z	-67.88607595	-68	2437	79	AP-C2-2F-01	0	18	10.8	11.8	2	0	19.1	3.6	6.1
4	y	-90.56	-90	5180	25	AP-C2-2F-01	0	16	10.8	11.8	2	0	19.1	3.6	6.1
4	y	-74.0625	-74	2437	32	AP-C2-2F-01	0	16	10.8	11.8	2	0	19.1	3.6	6.1
4	x	-92.2	-92	5180	35	AP-C2-2F-01	0	14	10.8	11.8	2	0	19.1	3.6	6.1
4	x	-74.71428571	-74	2437	49	AP-C2-2F-01	0	14	10.8	11.8	2	0	19.1	3.6	6.1
4	w	-80	-80	2437	7	AP-C2-2F-01	0	12	10.8	11.8	2	0	19.1	3.6	6.1
4	v	-80	-80	2437	35	AP-C2-2F-01	0	10	10.8	11.8	2	0	19.1	3.6	6.1
4	u	-83.35294118	-83	2437	51	AP-C2-2F-01	0	8	10.8	11.8	2	0	19.1	3.6	6.1
3	am	-82.33333333	-82	2437	30	AP-C2-2F-02	0	44	7.2	8.2	2	0	29.9	3.6	6.1
3	al	-80.75	-80.5	2437	28	AP-C2-2F-02	0	42	7.2	8.2	2	0	29.9	3.6	6.1
3	ak	-81.31914894	-81	2437	47	AP-C2-2F-02	0	40	7.2	8.2	2	0	29.9	3.6	6.1
3	aj	-90.27272727	-90	5180	44	AP-C2-2F-02	0	38	7.2	8.2	2	0	29.9	3.6	6.1
3	aj	-75.83333333	-75	2437	42	AP-C2-2F-02	0	38	7.2	8.2	2	0	29.9	3.6	6.1
3	ai	-82.16455696	-82	5180	79	AP-C2-2F-02	0	36	7.2	8.2	2	0	29.9	3.6	6.1
3	ai	-68.30107527	-68	2437	93	AP-C2-2F-02	0	36	7.2	8.2	2	0	29.9	3.6	6.1
3	ah	-82.22222222	-83	5180	72	AP-C2-2F-02	0	34	7.2	8.2	2	0	29.9	3.6	6.1
3	ah	-64.03	-64	2437	100	AP-C2-2F-02	0	34	7.2	8.2	2	0	29.9	3.6	6.1
3	ag	-76.29113924	-76	5180	79	AP-C2-2F-02	0	32	7.2	8.2	2	0	29.9	3.6	6.1
3	ag	-59.44	-60	2437	100	AP-C2-2F-02	0	32	7.2	8.2	2	0	29.9	3.6	6.1
3	af	-62.83	-62	2437	100	AP-C2-2F-02	0	30	7.2	8.2	2	0	29.9	3.6	6.1
3	ae	-72.1	-73	5180	100	AP-C2-2F-02	0	28	7.2	8.2	2	0	29.9	3.6	6.1
3	ae	-56.43010753	-56	2437	93	AP-C2-2F-02	0	28	7.2	8.2	2	0	29.9	3.6	6.1
3	ad	-79.5	-78	5180	86	AP-C2-2F-02	0	26	7.2	8.2	2	0	29.9	3.6	6.1
3	ad	-56.68	-57	2437	100	AP-C2-2F-02	0	26	7.2	8.2	2	0	29.9	3.6	6.1
3	ac	-81	-81	5180	15	AP-C2-2F-02	0	24	7.2	8.2	2	0	29.9	3.6	6.1
3	ac	-62.38	-63	2437	100	AP-C2-2F-02	0	24	7.2	8.2	2	0	29.9	3.6	6.1
3	ab	-87.43037975	-87	5180	79	AP-C2-2F-02	0	22	7.2	8.2	2	0	29.9	3.6	6.1
3	ab	-67.33333333	-67	2437	84	AP-C2-2F-02	0	22	7.2	8.2	2	0	29.9	3.6	6.1
3	aa	-88.625	-88.5	5180	56	AP-C2-2F-02	0	20	7.2	8.2	2	0	29.9	3.6	6.1
3	aa	-64.17	-64	2437	100	AP-C2-2F-02	0	20	7.2	8.2	2	0	29.9	3.6	6.1
3	as	-84	-83	2437	21	AP-C2-2F-02	0	56	7.2	8.2	2	0	29.9	3.6	6.1
3	aq	-85.58823529	-86	2437	51	AP-C2-2F-02	0	52	7.2	8.2	2	0	29.9	3.6	6.1
3	ap	-86.5	-87	2437	56	AP-C2-2F-02	0	50	7.2	8.2	2	0	29.9	3.6	6.1
3	ao	-83	-83	2437	7	AP-C2-2F-02	0	48	7.2	8.2	2	0	29.9	3.6	6.1
3	an	-83.05405405	-83	2437	37	AP-C2-2F-02	0	46	7.2	8.2	2	0	29.9	3.6	6.1
3	y	-91.95454545	-92	5180	44	AP-C2-2F-02	0	16	7.2	8.2	2	0	29.9	3.6	6.1
3	y	-70.21538462	-70	2437	65	AP-C2-2F-02	0	16	7.2	8.2	2	0	29.9	3.6	6.1
3	x	-80.42857143	-80	2437	49	AP-C2-2F-02	0	14	7.2	8.2	2	0	29.9	3.6	6.1
3	w	-69.26388889	-69	2437	72	AP-C2-2F-02	0	12	7.2	8.2	2	0	29.9	3.6	6.1
3	v	-77.9	-78	2437	70	AP-C2-2F-02	0	10	7.2	8.2	2	0	29.9	3.6	6.1
3	u	-70.15189873	-70	2437	79	AP-C2-2F-02	0	8	7.2	8.2	2	0	29.9	3.6	6.1
3	t	-80.75	-81	2437	28	AP-C2-2F-02	0	6	7.2	8.2	2	0	29.9	3.6	6.1
3	s	-76.0862069	-76	2437	58	AP-C2-2F-02	0	4	7.2	8.2	2	0	29.9	3.6	6.1
3	r	-77.79310345	-78	2437	58	AP-C2-2F-02	0	2	7.2	8.2	2	0	29.9	3.6	6.1
3	q	-81.66666667	-82	2437	21	AP-C2-2F-02	0	0	7.2	8.2	2	0	29.9	3.6	6.1
4	al	-86	-86	2437	14	AP-C2-2F-02	0	42	10.8	11.8	2	0	29.9	3.6	6.1
4	ak	-86.5	-86.5	2437	14	AP-C2-2F-02	0	40	10.8	11.8	2	0	29.9	3.6	6.1
4	aj	-81.66666667	-81	2437	9	AP-C2-2F-02	0	38	10.8	11.8	2	0	29.9	3.6	6.1
4	ai	-79.66666667	-82	2437	21	AP-C2-2F-02	0	36	10.8	11.8	2	0	29.9	3.6	6.1
4	ah	-90.66666667	-91	5180	21	AP-C2-2F-02	0	34	10.8	11.8	2	0	29.9	3.6	6.1
4	ah	-71.75	-72	2437	28	AP-C2-2F-02	0	34	10.8	11.8	2	0	29.9	3.6	6.1
4	ag	-89.37254902	-90	5180	51	AP-C2-2F-02	0	32	10.8	11.8	2	0	29.9	3.6	6.1
4	ag	-74.79545455	-75	2437	44	AP-C2-2F-02	0	32	10.8	11.8	2	0	29.9	3.6	6.1
4	af	-72.28571429	-72	2437	49	AP-C2-2F-02	0	30	10.8	11.8	2	0	29.9	3.6	6.1
4	ae	-90.11111111	-89	5180	9	AP-C2-2F-02	0	28	10.8	11.8	2	0	29.9	3.6	6.1
4	ae	-75.29113924	-75	2437	79	AP-C2-2F-02	0	28	10.8	11.8	2	0	29.9	3.6	6.1
4	ad	-77.66666667	-78	2437	21	AP-C2-2F-02	0	26	10.8	11.8	2	0	29.9	3.6	6.1
4	ac	-90.5	-90.5	5180	42	AP-C2-2F-02	0	24	10.8	11.8	2	0	29.9	3.6	6.1
4	ac	-82	-82	2437	14	AP-C2-2F-02	0	24	10.8	11.8	2	0	29.9	3.6	6.1
4	ab	-86	-86	2437	7	AP-C2-2F-02	0	22	10.8	11.8	2	0	29.9	3.6	6.1
4	aa	-84	-84.5	2437	28	AP-C2-2F-02	0	20	10.8	11.8	2	0	29.9	3.6	6.1
3	z	-87.45454545	-87	5180	77	AP-C2-2F-02	0	18	7.2	8.2	2	0	29.9	3.6	6.1
3	z	-69.17204301	-69	2437	93	AP-C2-2F-02	0	18	7.2	8.2	2	0	29.9	3.6	6.1
4	am	-84.8627451	-85	2437	51	AP-C2-2F-02	0	44	10.8	11.8	2	0	29.9	3.6	6.1
4	z	-84	-84	2437	7	AP-C2-2F-02	0	18	10.8	11.8	2	0	29.9	3.6	6.1
4	x	-87	-87	2437	7	AP-C2-2F-02	0	14	10.8	11.8	2	0	29.9	3.6	6.1
4	v	-87	-87	2437	7	AP-C2-2F-02	0	10	10.8	11.8	2	0	29.9	3.6	6.1
3	am	-76.77419355	-77	5180	93	AP-C2-2F-03	0	44	7.2	8.2	2	0	44.1	3.6	6.1
3	am	-57.14	-57	2437	100	AP-C2-2F-03	0	44	7.2	8.2	2	0	44.1	3.6	6.1
3	al	-70.59	-71	5180	100	AP-C2-2F-03	0	42	7.2	8.2	2	0	44.1	3.6	6.1
3	al	-49.81	-51	2437	100	AP-C2-2F-03	0	42	7.2	8.2	2	0	44.1	3.6	6.1
3	ak	-77.37078652	-78	5180	89	AP-C2-2F-03	0	40	7.2	8.2	2	0	44.1	3.6	6.1
3	ak	-62.94623656	-63	2437	93	AP-C2-2F-03	0	40	7.2	8.2	2	0	44.1	3.6	6.1
3	aj	-81.35384615	-81	5180	65	AP-C2-2F-03	0	38	7.2	8.2	2	0	44.1	3.6	6.1
3	aj	-63.96774194	-64	2437	93	AP-C2-2F-03	0	38	7.2	8.2	2	0	44.1	3.6	6.1
3	ai	-88.16666667	-87	5180	84	AP-C2-2F-03	0	36	7.2	8.2	2	0	44.1	3.6	6.1
3	ai	-73.75	-74.5	2437	84	AP-C2-2F-03	0	36	7.2	8.2	2	0	44.1	3.6	6.1
3	ah	-85.22222222	-85	5180	63	AP-C2-2F-03	0	34	7.2	8.2	2	0	44.1	3.6	6.1
3	ah	-62.64285714	-63	2437	98	AP-C2-2F-03	0	34	7.2	8.2	2	0	44.1	3.6	6.1
3	ag	-90	-90	5180	7	AP-C2-2F-03	0	32	7.2	8.2	2	0	44.1	3.6	6.1
3	ag	-69.17721519	-69	2437	79	AP-C2-2F-03	0	32	7.2	8.2	2	0	44.1	3.6	6.1
3	af	-70.28	-71	2437	50	AP-C2-2F-03	0	30	7.2	8.2	2	0	44.1	3.6	6.1
3	ae	-90.66666667	-91	5180	21	AP-C2-2F-03	0	28	7.2	8.2	2	0	44.1	3.6	6.1
3	ae	-75.2	-75	2437	35	AP-C2-2F-03	0	28	7.2	8.2	2	0	44.1	3.6	6.1
3	ad	-90.5	-90.5	5180	14	AP-C2-2F-03	0	26	7.2	8.2	2	0	44.1	3.6	6.1
3	ad	-81.85714286	-81	2437	49	AP-C2-2F-03	0	26	7.2	8.2	2	0	44.1	3.6	6.1
3	ac	-72.8	-72	2437	35	AP-C2-2F-03	0	24	7.2	8.2	2	0	44.1	3.6	6.1
3	ab	-78.76666667	-79	2437	30	AP-C2-2F-03	0	22	7.2	8.2	2	0	44.1	3.6	6.1
3	as	-90	-90	5180	35	AP-C2-2F-03	0	56	7.2	8.2	2	0	44.1	3.6	6.1
3	as	-78.86666667	-78	2437	30	AP-C2-2F-03	0	56	7.2	8.2	2	0	44.1	3.6	6.1
3	ar	-91	-91	5180	7	AP-C2-2F-03	0	54	7.2	8.2	2	0	44.1	3.6	6.1
3	ar	-76.60344828	-76	2437	58	AP-C2-2F-03	0	54	7.2	8.2	2	0	44.1	3.6	6.1
3	aq	-91	-91	5180	7	AP-C2-2F-03	0	52	7.2	8.2	2	0	44.1	3.6	6.1
3	aq	-77.44444444	-77	2437	63	AP-C2-2F-03	0	52	7.2	8.2	2	0	44.1	3.6	6.1
3	ap	-89.11111111	-89	5180	63	AP-C2-2F-03	0	50	7.2	8.2	2	0	44.1	3.6	6.1
3	ap	-75.80555556	-76	2437	72	AP-C2-2F-03	0	50	7.2	8.2	2	0	44.1	3.6	6.1
3	ao	-84.45454545	-84	5180	77	AP-C2-2F-03	0	48	7.2	8.2	2	0	44.1	3.6	6.1
3	ao	-63.49	-63	2437	100	AP-C2-2F-03	0	48	7.2	8.2	2	0	44.1	3.6	6.1
3	an	-76.69767442	-77	5180	86	AP-C2-2F-03	0	46	7.2	8.2	2	0	44.1	3.6	6.1
3	an	-61.65591398	-62	2437	93	AP-C2-2F-03	0	46	7.2	8.2	2	0	44.1	3.6	6.1
3	y	-76.5	-77	2437	28	AP-C2-2F-03	0	16	7.2	8.2	2	0	44.1	3.6	6.1
3	x	-77.30434783	-77	2437	23	AP-C2-2F-03	0	14	7.2	8.2	2	0	44.1	3.6	6.1
3	v	-77.078125	-77	2437	64	AP-C2-2F-03	0	10	7.2	8.2	2	0	44.1	3.6	6.1
3	u	-79.63333333	-79	2437	30	AP-C2-2F-03	0	8	7.2	8.2	2	0	44.1	3.6	6.1
3	t	-86	-86	2437	7	AP-C2-2F-03	0	6	7.2	8.2	2	0	44.1	3.6	6.1
3	s	-83	-83	2437	14	AP-C2-2F-03	0	4	7.2	8.2	2	0	44.1	3.6	6.1
3	q	-86	-86	2437	7	AP-C2-2F-03	0	0	7.2	8.2	2	0	44.1	3.6	6.1
4	al	-74.3	-75	2437	30	AP-C2-2F-03	0	42	10.8	11.8	2	0	44.1	3.6	6.1
4	ak	-75.95652174	-75	2437	23	AP-C2-2F-03	0	40	10.8	11.8	2	0	44.1	3.6	6.1
4	aj	-71.04545455	-72	2437	44	AP-C2-2F-03	0	38	10.8	11.8	2	0	44.1	3.6	6.1
4	ai	-79.5	-79.5	2437	14	AP-C2-2F-03	0	36	10.8	11.8	2	0	44.1	3.6	6.1
4	ah	-85.5	-85.5	2437	14	AP-C2-2F-03	0	34	10.8	11.8	2	0	44.1	3.6	6.1
4	ag	-82	-82	2437	7	AP-C2-2F-03	0	32	10.8	11.8	2	0	44.1	3.6	6.1
3	z	-76.77777778	-76	2437	27	AP-C2-2F-03	0	18	7.2	8.2	2	0	44.1	3.6	6.1
4	aq	-83.5	-84.5	2437	28	AP-C2-2F-03	0	52	10.8	11.8	2	0	44.1	3.6	6.1
4	ap	-84.2	-85	2437	35	AP-C2-2F-03	0	50	10.8	11.8	2	0	44.1	3.6	6.1
4	ao	-84	-84	2437	14	AP-C2-2F-03	0	48	10.8	11.8	2	0	44.1	3.6	6.1
4	an	-80.6	-81	2437	35	AP-C2-2F-03	0	46	10.8	11.8	2	0	44.1	3.6	6.1
4	am	-78.5	-78.5	2437	56	AP-C2-2F-03	0	44	10.8	11.8	2	0	44.1	3.6	6.1
3	am	-74.21538462	-74	2437	65	AP-C2-3F-01	0	44	7.2	8.2	3	0	15.6	7.2	9.7
3	al	-84.33333333	-85	5180	42	AP-C2-3F-01	0	42	7.2	8.2	3	0	15.6	7.2	9.7
3	al	-75.12307692	-74	2437	65	AP-C2-3F-01	0	42	7.2	8.2	3	0	15.6	7.2	9.7
3	ak	-86.81538462	-87	5180	65	AP-C2-3F-01	0	40	7.2	8.2	3	0	15.6	7.2	9.7
3	ak	-75.3655914	-76	2437	93	AP-C2-3F-01	0	40	7.2	8.2	3	0	15.6	7.2	9.7
3	aj	-85	-85	5180	63	AP-C2-3F-01	0	38	7.2	8.2	3	0	15.6	7.2	9.7
3	aj	-74.62790698	-75	2437	86	AP-C2-3F-01	0	38	7.2	8.2	3	0	15.6	7.2	9.7
3	ai	-80.38461538	-81	5180	65	AP-C2-3F-01	0	36	7.2	8.2	3	0	15.6	7.2	9.7
3	ai	-77.83333333	-77.5	2437	42	AP-C2-3F-01	0	36	7.2	8.2	3	0	15.6	7.2	9.7
3	ah	-82.77777778	-83	5180	63	AP-C2-3F-01	0	34	7.2	8.2	3	0	15.6	7.2	9.7
3	ah	-75	-77	2437	21	AP-C2-3F-01	0	34	7.2	8.2	3	0	15.6	7.2	9.7
3	ag	-76.625	-76.5	5180	56	AP-C2-3F-01	0	32	7.2	8.2	3	0	15.6	7.2	9.7
3	ag	-68.41666667	-68	2437	84	AP-C2-3F-01	0	32	7.2	8.2	3	0	15.6	7.2	9.7
3	af	-75.24324324	-75	2437	37	AP-C2-3F-01	0	30	7.2	8.2	3	0	15.6	7.2	9.7
3	ae	-77.84313725	-78	5180	51	AP-C2-3F-01	0	28	7.2	8.2	3	0	15.6	7.2	9.7
3	ae	-63.27956989	-63	2437	93	AP-C2-3F-01	0	28	7.2	8.2	3	0	15.6	7.2	9.7
3	ad	-76.65	-77	5180	20	AP-C2-3F-01	0	26	7.2	8.2	3	0	15.6	7.2	9.7
3	ad	-62.84810127	-64	2437	79	AP-C2-3F-01	0	26	7.2	8.2	3	0	15.6	7.2	9.7
3	ac	-63.60465116	-64	2437	86	AP-C2-3F-01	0	24	7.2	8.2	3	0	15.6	7.2	9.7
3	ab	-68.56962025	-68	5180	79	AP-C2-3F-01	0	22	7.2	8.2	3	0	15.6	7.2	9.7
3	ab	-52.28	-53	2437	100	AP-C2-3F-01	0	22	7.2	8.2	3	0	15.6	7.2	9.7
3	aa	-63.05	-63	5180	100	AP-C2-3F-01	0	20	7.2	8.2	3	0	15.6	7.2	9.7
3	aa	-55.55913978	-56	2437	93	AP-C2-3F-01	0	20	7.2	8.2	3	0	15.6	7.2	9.7
3	b	-93	-93	2437	7	AP-C2-3F-01	30	0	7.2	8.2	3	0	15.6	7.2	9.7
3	as	-85.6	-86	5180	35	AP-C2-3F-01	0	56	7.2	8.2	3	0	15.6	7.2	9.7
3	as	-71	-71	2437	63	AP-C2-3F-01	0	56	7.2	8.2	3	0	15.6	7.2	9.7
3	ar	-88.71428571	-89	5180	49	AP-C2-3F-01	0	54	7.2	8.2	3	0	15.6	7.2	9.7
3	ar	-77.71428571	-77	2437	49	AP-C2-3F-01	0	54	7.2	8.2	3	0	15.6	7.2	9.7
3	aq	-88.5	-88.5	5180	14	AP-C2-3F-01	0	52	7.2	8.2	3	0	15.6	7.2	9.7
3	aq	-72.39240506	-73	2437	79	AP-C2-3F-01	0	52	7.2	8.2	3	0	15.6	7.2	9.7
3	ap	-86.93103448	-87	5180	58	AP-C2-3F-01	0	50	7.2	8.2	3	0	15.6	7.2	9.7
3	ap	-73.75	-76	2437	56	AP-C2-3F-01	0	50	7.2	8.2	3	0	15.6	7.2	9.7
3	ao	-85.37931034	-85	5180	58	AP-C2-3F-01	0	48	7.2	8.2	3	0	15.6	7.2	9.7
3	ao	-78.5	-78.5	2437	14	AP-C2-3F-01	0	48	7.2	8.2	3	0	15.6	7.2	9.7
3	an	-73.27272727	-73	2437	77	AP-C2-3F-01	0	46	7.2	8.2	3	0	15.6	7.2	9.7
3	j	-83	-83	2437	7	AP-C2-3F-01	14	0	7.2	8.2	3	0	15.6	7.2	9.7
3	h	-89	-89	2437	7	AP-C2-3F-01	18	0	7.2	8.2	3	0	15.6	7.2	9.7
3	e	-84.5	-84.5	2437	14	AP-C2-3F-01	24	0	7.2	8.2	3	0	15.6	7.2	9.7
3	c	-89	-89	2437	2	AP-C2-3F-01	28	0	7.2	8.2	3	0	15.6	7.2	9.7
3	y	-55.2688172	-55	5180	93	AP-C2-3F-01	0	16	7.2	8.2	3	0	15.6	7.2	9.7
3	y	-38.4	-39	2437	100	AP-C2-3F-01	0	16	7.2	8.2	3	0	15.6	7.2	9.7
3	x	-51.94	-52	5180	100	AP-C2-3F-01	0	14	7.2	8.2	3	0	15.6	7.2	9.7
3	x	-43.92	-43	2437	100	AP-C2-3F-01	0	14	7.2	8.2	3	0	15.6	7.2	9.7
3	w	-51.59	-51	5180	100	AP-C2-3F-01	0	12	7.2	8.2	3	0	15.6	7.2	9.7
3	w	-40.09	-39	2437	100	AP-C2-3F-01	0	12	7.2	8.2	3	0	15.6	7.2	9.7
3	v	-63.4	-63	5180	100	AP-C2-3F-01	0	10	7.2	8.2	3	0	15.6	7.2	9.7
3	v	-51.58	-51.5	2437	100	AP-C2-3F-01	0	10	7.2	8.2	3	0	15.6	7.2	9.7
3	u	-60.51	-60	5180	100	AP-C2-3F-01	0	8	7.2	8.2	3	0	15.6	7.2	9.7
3	u	-47.72	-47	2437	100	AP-C2-3F-01	0	8	7.2	8.2	3	0	15.6	7.2	9.7
3	t	-64.83	-65	5180	100	AP-C2-3F-01	0	6	7.2	8.2	3	0	15.6	7.2	9.7
3	t	-47.22	-47	2437	100	AP-C2-3F-01	0	6	7.2	8.2	3	0	15.6	7.2	9.7
3	s	-65.61403509	-65	5180	57	AP-C2-3F-01	0	4	7.2	8.2	3	0	15.6	7.2	9.7
3	s	-51.20430108	-51	2437	93	AP-C2-3F-01	0	4	7.2	8.2	3	0	15.6	7.2	9.7
3	r	-65.88	-66	5180	100	AP-C2-3F-01	0	2	7.2	8.2	3	0	15.6	7.2	9.7
3	r	-54.66	-54	2437	100	AP-C2-3F-01	0	2	7.2	8.2	3	0	15.6	7.2	9.7
3	q	-66.58064516	-67	5180	93	AP-C2-3F-01	0	0	7.2	8.2	3	0	15.6	7.2	9.7
3	q	-53.77419355	-55	2437	93	AP-C2-3F-01	0	0	7.2	8.2	3	0	15.6	7.2	9.7
3	p	-73.16	-74	5180	100	AP-C2-3F-01	2	0	7.2	8.2	3	0	15.6	7.2	9.7
3	p	-74.47692308	-75	2437	65	AP-C2-3F-01	2	0	7.2	8.2	3	0	15.6	7.2	9.7
3	o	-87.58333333	-88	5180	72	AP-C2-3F-01	4	0	7.2	8.2	3	0	15.6	7.2	9.7
3	o	-73.16666667	-73.5	2437	42	AP-C2-3F-01	4	0	7.2	8.2	3	0	15.6	7.2	9.7
3	n	-90.2962963	-90	5180	54	AP-C2-3F-01	6	0	7.2	8.2	3	0	15.6	7.2	9.7
3	n	-81.75	-81.5	2437	28	AP-C2-3F-01	6	0	7.2	8.2	3	0	15.6	7.2	9.7
3	m	-90.5	-90.5	5180	42	AP-C2-3F-01	8	0	7.2	8.2	3	0	15.6	7.2	9.7
3	m	-80.66666667	-81	2437	21	AP-C2-3F-01	8	0	7.2	8.2	3	0	15.6	7.2	9.7
3	k	-87	-87	2437	7	AP-C2-3F-01	12	0	7.2	8.2	3	0	15.6	7.2	9.7
4	al	-82.25	-82.5	2437	28	AP-C2-3F-01	0	42	10.8	11.8	3	0	15.6	7.2	9.7
4	ak	-83	-83	2437	7	AP-C2-3F-01	0	40	10.8	11.8	3	0	15.6	7.2	9.7
4	aj	-84.33333333	-85	2437	21	AP-C2-3F-01	0	38	10.8	11.8	3	0	15.6	7.2	9.7
4	ai	-82.66666667	-83	2437	21	AP-C2-3F-01	0	36	10.8	11.8	3	0	15.6	7.2	9.7
4	ah	-79.89189189	-80	2437	37	AP-C2-3F-01	0	34	10.8	11.8	3	0	15.6	7.2	9.7
4	ag	-79.20454545	-80	2437	44	AP-C2-3F-01	0	32	10.8	11.8	3	0	15.6	7.2	9.7
4	af	-86	-86	2437	14	AP-C2-3F-01	0	30	10.8	11.8	3	0	15.6	7.2	9.7
4	ae	-78.53846154	-78	2437	65	AP-C2-3F-01	0	28	10.8	11.8	3	0	15.6	7.2	9.7
4	ad	-91	-91	5180	2	AP-C2-3F-01	0	26	10.8	11.8	3	0	15.6	7.2	9.7
4	ad	-79.66666667	-79	2437	21	AP-C2-3F-01	0	26	10.8	11.8	3	0	15.6	7.2	9.7
4	ac	-87.34722222	-87	5180	72	AP-C2-3F-01	0	24	10.8	11.8	3	0	15.6	7.2	9.7
4	ac	-72.16666667	-71	2437	72	AP-C2-3F-01	0	24	10.8	11.8	3	0	15.6	7.2	9.7
4	ab	-88.90909091	-89	5180	77	AP-C2-3F-01	0	22	10.8	11.8	3	0	15.6	7.2	9.7
4	ab	-69.7	-70	2437	70	AP-C2-3F-01	0	22	10.8	11.8	3	0	15.6	7.2	9.7
4	aa	-81.51388889	-82	5180	72	AP-C2-3F-01	0	20	10.8	11.8	3	0	15.6	7.2	9.7
4	aa	-64.45348837	-65	2437	86	AP-C2-3F-01	0	20	10.8	11.8	3	0	15.6	7.2	9.7
3	z	-55.3	-55	5180	100	AP-C2-3F-01	0	18	7.2	8.2	3	0	15.6	7.2	9.7
3	z	-39.2	-38	2437	100	AP-C2-3F-01	0	18	7.2	8.2	3	0	15.6	7.2	9.7
4	as	-86	-87	2437	21	AP-C2-3F-01	0	56	10.8	11.8	3	0	15.6	7.2	9.7
4	an	-84.5	-84.5	2437	14	AP-C2-3F-01	0	46	10.8	11.8	3	0	15.6	7.2	9.7
4	am	-81	-81	2437	7	AP-C2-3F-01	0	44	10.8	11.8	3	0	15.6	7.2	9.7
4	z	-69.4	-69	5180	100	AP-C2-3F-01	0	18	10.8	11.8	3	0	15.6	7.2	9.7
4	z	-50.11	-50	2437	100	AP-C2-3F-01	0	18	10.8	11.8	3	0	15.6	7.2	9.7
4	y	-72.64516129	-73	5180	93	AP-C2-3F-01	0	16	10.8	11.8	3	0	15.6	7.2	9.7
4	y	-59.6344086	-60	2437	93	AP-C2-3F-01	0	16	10.8	11.8	3	0	15.6	7.2	9.7
4	x	-72.82	-73	5180	100	AP-C2-3F-01	0	14	10.8	11.8	3	0	15.6	7.2	9.7
4	x	-58.86046512	-60	2437	86	AP-C2-3F-01	0	14	10.8	11.8	3	0	15.6	7.2	9.7
4	w	-76.27272727	-76	5180	11	AP-C2-3F-01	0	12	10.8	11.8	3	0	15.6	7.2	9.7
4	w	-57.46	-57	2437	100	AP-C2-3F-01	0	12	10.8	11.8	3	0	15.6	7.2	9.7
4	v	-78	-78	5180	28	AP-C2-3F-01	0	10	10.8	11.8	3	0	15.6	7.2	9.7
4	v	-66.70967742	-67	2437	93	AP-C2-3F-01	0	10	10.8	11.8	3	0	15.6	7.2	9.7
4	u	-87.8	-87	5180	35	AP-C2-3F-01	0	8	10.8	11.8	3	0	15.6	7.2	9.7
4	u	-69.11827957	-69	2437	93	AP-C2-3F-01	0	8	10.8	11.8	3	0	15.6	7.2	9.7
4	t	-90.10526316	-90	5180	38	AP-C2-3F-01	0	6	10.8	11.8	3	0	15.6	7.2	9.7
4	t	-73.19	-73	2437	100	AP-C2-3F-01	0	6	10.8	11.8	3	0	15.6	7.2	9.7
4	s	-84.86111111	-86	2437	72	AP-C2-3F-01	0	4	10.8	11.8	3	0	15.6	7.2	9.7
4	r	-89.17241379	-89	5180	58	AP-C2-3F-01	0	2	10.8	11.8	3	0	15.6	7.2	9.7
4	r	-82.125	-82.5	2437	56	AP-C2-3F-01	0	2	10.8	11.8	3	0	15.6	7.2	9.7
4	q	-85	-85	2437	7	AP-C2-3F-01	0	0	10.8	11.8	3	0	15.6	7.2	9.7
4	p	-83.4375	-83	2437	16	AP-C2-3F-01	2	0	10.8	11.8	3	0	15.6	7.2	9.7
3	am	-83.4	-83.5	5180	70	AP-C2-3F-02	0	44	7.2	8.2	3	0	30.7	7.2	9.7
3	am	-64.98924731	-64	2437	93	AP-C2-3F-02	0	44	7.2	8.2	3	0	30.7	7.2	9.7
3	al	-73.37634409	-73	5180	93	AP-C2-3F-02	0	42	7.2	8.2	3	0	30.7	7.2	9.7
3	al	-62.32	-62	2437	100	AP-C2-3F-02	0	42	7.2	8.2	3	0	30.7	7.2	9.7
3	ak	-74.57303371	-74	5180	89	AP-C2-3F-02	0	40	7.2	8.2	3	0	30.7	7.2	9.7
3	ak	-63.87	-64	2437	100	AP-C2-3F-02	0	40	7.2	8.2	3	0	30.7	7.2	9.7
3	aj	-72.22093023	-72	5180	86	AP-C2-3F-02	0	38	7.2	8.2	3	0	30.7	7.2	9.7
3	aj	-56.56	-57	2437	100	AP-C2-3F-02	0	38	7.2	8.2	3	0	30.7	7.2	9.7
3	ai	-64.6	-65	5180	100	AP-C2-3F-02	0	36	7.2	8.2	3	0	30.7	7.2	9.7
3	ai	-56.57	-57	2437	100	AP-C2-3F-02	0	36	7.2	8.2	3	0	30.7	7.2	9.7
3	ah	-64.21	-65	5180	100	AP-C2-3F-02	0	34	7.2	8.2	3	0	30.7	7.2	9.7
3	ah	-42.33	-41	2437	100	AP-C2-3F-02	0	34	7.2	8.2	3	0	30.7	7.2	9.7
3	ag	-57.44	-57	5180	100	AP-C2-3F-02	0	32	7.2	8.2	3	0	30.7	7.2	9.7
3	ag	-40.14	-38	2437	100	AP-C2-3F-02	0	32	7.2	8.2	3	0	30.7	7.2	9.7
3	af	-39.09	-37	2437	100	AP-C2-3F-02	0	30	7.2	8.2	3	0	30.7	7.2	9.7
3	ae	-41.67	-42	2437	100	AP-C2-3F-02	0	28	7.2	8.2	3	0	30.7	7.2	9.7
3	ad	-45.42	-45	2437	100	AP-C2-3F-02	0	26	7.2	8.2	3	0	30.7	7.2	9.7
3	ac	-50.37	-50	2437	100	AP-C2-3F-02	0	24	7.2	8.2	3	0	30.7	7.2	9.7
3	ab	-51.4	-50	2437	100	AP-C2-3F-02	0	22	7.2	8.2	3	0	30.7	7.2	9.7
3	aa	-70.34	-71	5180	100	AP-C2-3F-02	0	20	7.2	8.2	3	0	30.7	7.2	9.7
3	aa	-59.63	-60	2437	100	AP-C2-3F-02	0	20	7.2	8.2	3	0	30.7	7.2	9.7
3	aw	-89.66666667	-90	5180	21	AP-C2-3F-02	8	56	7.2	8.2	3	0	30.7	7.2	9.7
3	aw	-87	-87	2437	7	AP-C2-3F-02	8	56	7.2	8.2	3	0	30.7	7.2	9.7
3	au	-82.33333333	-83	2437	21	AP-C2-3F-02	4	56	7.2	8.2	3	0	30.7	7.2	9.7
3	at	-88.17647059	-89	5180	34	AP-C2-3F-02	2	56	7.2	8.2	3	0	30.7	7.2	9.7
3	as	-69.32	-69	5180	100	AP-C2-3F-02	0	56	7.2	8.2	3	0	30.7	7.2	9.7
3	as	-73.7	-73	2437	70	AP-C2-3F-02	0	56	7.2	8.2	3	0	30.7	7.2	9.7
3	ar	-81.23255814	-80	5180	86	AP-C2-3F-02	0	54	7.2	8.2	3	0	30.7	7.2	9.7
3	ar	-76.14285714	-76	2437	49	AP-C2-3F-02	0	54	7.2	8.2	3	0	30.7	7.2	9.7
3	aq	-84.09230769	-84	5180	65	AP-C2-3F-02	0	52	7.2	8.2	3	0	30.7	7.2	9.7
3	aq	-76.48611111	-76	2437	72	AP-C2-3F-02	0	52	7.2	8.2	3	0	30.7	7.2	9.7
3	ap	-81.16666667	-81.5	5180	84	AP-C2-3F-02	0	50	7.2	8.2	3	0	30.7	7.2	9.7
3	ap	-68.66666667	-69	2437	72	AP-C2-3F-02	0	50	7.2	8.2	3	0	30.7	7.2	9.7
3	ao	-82.45833333	-84	5180	72	AP-C2-3F-02	0	48	7.2	8.2	3	0	30.7	7.2	9.7
3	ao	-66.65	-67	2437	100	AP-C2-3F-02	0	48	7.2	8.2	3	0	30.7	7.2	9.7
3	an	-82.93846154	-83	5180	65	AP-C2-3F-02	0	46	7.2	8.2	3	0	30.7	7.2	9.7
3	an	-70.03488372	-70	2437	86	AP-C2-3F-02	0	46	7.2	8.2	3	0	30.7	7.2	9.7
3	be	-92	-92	5180	3	AP-C2-3F-02	24	56	7.2	8.2	3	0	30.7	7.2	9.7
3	y	-70.35483871	-70	5180	93	AP-C2-3F-02	0	16	7.2	8.2	3	0	30.7	7.2	9.7
3	y	-59.83870968	-60	2437	93	AP-C2-3F-02	0	16	7.2	8.2	3	0	30.7	7.2	9.7
3	x	-73.82795699	-74	5180	93	AP-C2-3F-02	0	14	7.2	8.2	3	0	30.7	7.2	9.7
3	x	-59.84	-60	2437	100	AP-C2-3F-02	0	14	7.2	8.2	3	0	30.7	7.2	9.7
3	w	-72.94	-73.5	5180	100	AP-C2-3F-02	0	12	7.2	8.2	3	0	30.7	7.2	9.7
3	w	-58.75	-59	2437	100	AP-C2-3F-02	0	12	7.2	8.2	3	0	30.7	7.2	9.7
3	v	-75.82795699	-76	5180	93	AP-C2-3F-02	0	10	7.2	8.2	3	0	30.7	7.2	9.7
3	v	-75.7	-76	2437	100	AP-C2-3F-02	0	10	7.2	8.2	3	0	30.7	7.2	9.7
3	u	-81.32911392	-81	5180	79	AP-C2-3F-02	0	8	7.2	8.2	3	0	30.7	7.2	9.7
3	u	-67.84	-67	2437	100	AP-C2-3F-02	0	8	7.2	8.2	3	0	30.7	7.2	9.7
3	t	-76.16666667	-76.5	5180	84	AP-C2-3F-02	0	6	7.2	8.2	3	0	30.7	7.2	9.7
3	t	-60.47	-60	2437	100	AP-C2-3F-02	0	6	7.2	8.2	3	0	30.7	7.2	9.7
3	s	-77.4137931	-77	5180	58	AP-C2-3F-02	0	4	7.2	8.2	3	0	30.7	7.2	9.7
3	s	-62.32	-63	2437	100	AP-C2-3F-02	0	4	7.2	8.2	3	0	30.7	7.2	9.7
3	r	-78.58441558	-78	5180	77	AP-C2-3F-02	0	2	7.2	8.2	3	0	30.7	7.2	9.7
3	r	-63.2688172	-63	2437	93	AP-C2-3F-02	0	2	7.2	8.2	3	0	30.7	7.2	9.7
3	q	-81.39344262	-81	5180	61	AP-C2-3F-02	0	0	7.2	8.2	3	0	30.7	7.2	9.7
3	q	-65.49253731	-67	2437	67	AP-C2-3F-02	0	0	7.2	8.2	3	0	30.7	7.2	9.7
3	p	-90	-90	5180	16	AP-C2-3F-02	2	0	7.2	8.2	3	0	30.7	7.2	9.7
3	o	-91	-91	5180	7	AP-C2-3F-02	4	0	7.2	8.2	3	0	30.7	7.2	9.7
4	al	-91	-91	5180	7	AP-C2-3F-02	0	42	10.8	11.8	3	0	30.7	7.2	9.7
4	al	-73.4	-73	2437	35	AP-C2-3F-02	0	42	10.8	11.8	3	0	30.7	7.2	9.7
4	ak	-90.5	-90.5	5180	14	AP-C2-3F-02	0	40	10.8	11.8	3	0	30.7	7.2	9.7
4	ak	-77.36363636	-78	2437	44	AP-C2-3F-02	0	40	10.8	11.8	3	0	30.7	7.2	9.7
4	aj	-87.36923077	-88	5180	65	AP-C2-3F-02	0	38	10.8	11.8	3	0	30.7	7.2	9.7
4	aj	-75	-76	2437	58	AP-C2-3F-02	0	38	10.8	11.8	3	0	30.7	7.2	9.7
4	ai	-81.41772152	-81	5180	79	AP-C2-3F-02	0	36	10.8	11.8	3	0	30.7	7.2	9.7
4	ai	-69.78	-70	2437	100	AP-C2-3F-02	0	36	10.8	11.8	3	0	30.7	7.2	9.7
4	ah	-75.90909091	-76	5180	77	AP-C2-3F-02	0	34	10.8	11.8	3	0	30.7	7.2	9.7
4	ah	-67.83	-68	2437	100	AP-C2-3F-02	0	34	10.8	11.8	3	0	30.7	7.2	9.7
4	ag	-75.2	-76.5	5180	70	AP-C2-3F-02	0	32	10.8	11.8	3	0	30.7	7.2	9.7
4	ag	-53.6	-53	2437	100	AP-C2-3F-02	0	32	10.8	11.8	3	0	30.7	7.2	9.7
4	af	-66.49	-66	5180	100	AP-C2-3F-02	0	30	10.8	11.8	3	0	30.7	7.2	9.7
4	af	-49.55	-49	2437	100	AP-C2-3F-02	0	30	10.8	11.8	3	0	30.7	7.2	9.7
4	ae	-78.16666667	-78	5180	84	AP-C2-3F-02	0	28	10.8	11.8	3	0	30.7	7.2	9.7
4	ae	-60.56	-60	2437	100	AP-C2-3F-02	0	28	10.8	11.8	3	0	30.7	7.2	9.7
4	ad	-83.5	-83	5180	56	AP-C2-3F-02	0	26	10.8	11.8	3	0	30.7	7.2	9.7
4	ad	-63.84615385	-64	2437	91	AP-C2-3F-02	0	26	10.8	11.8	3	0	30.7	7.2	9.7
4	ac	-80.16666667	-80.5	5180	84	AP-C2-3F-02	0	24	10.8	11.8	3	0	30.7	7.2	9.7
4	ac	-67.90909091	-68	2437	77	AP-C2-3F-02	0	24	10.8	11.8	3	0	30.7	7.2	9.7
4	ab	-88	-88	5180	7	AP-C2-3F-02	0	22	10.8	11.8	3	0	30.7	7.2	9.7
4	ab	-74.89873418	-74	2437	79	AP-C2-3F-02	0	22	10.8	11.8	3	0	30.7	7.2	9.7
4	aa	-87.81818182	-87	5180	77	AP-C2-3F-02	0	20	10.8	11.8	3	0	30.7	7.2	9.7
4	aa	-71.13953488	-70	2437	86	AP-C2-3F-02	0	20	10.8	11.8	3	0	30.7	7.2	9.7
3	z	-67.55	-67	5180	100	AP-C2-3F-02	0	18	7.2	8.2	3	0	30.7	7.2	9.7
3	z	-61.05	-60	2437	100	AP-C2-3F-02	0	18	7.2	8.2	3	0	30.7	7.2	9.7
4	aq	-89	-89	2437	7	AP-C2-3F-02	0	52	10.8	11.8	3	0	30.7	7.2	9.7
4	ao	-80.5	-80.5	2437	14	AP-C2-3F-02	0	48	10.8	11.8	3	0	30.7	7.2	9.7
4	an	-80.28571429	-80	2437	49	AP-C2-3F-02	0	46	10.8	11.8	3	0	30.7	7.2	9.7
4	am	-80	-81	2437	21	AP-C2-3F-02	0	44	10.8	11.8	3	0	30.7	7.2	9.7
4	z	-88.625	-88	5180	56	AP-C2-3F-02	0	18	10.8	11.8	3	0	30.7	7.2	9.7
4	z	-68.76923077	-68	2437	91	AP-C2-3F-02	0	18	10.8	11.8	3	0	30.7	7.2	9.7
4	y	-92	-92	5180	14	AP-C2-3F-02	0	16	10.8	11.8	3	0	30.7	7.2	9.7
4	y	-80.25	-80.5	2437	28	AP-C2-3F-02	0	16	10.8	11.8	3	0	30.7	7.2	9.7
4	x	-90.5	-90.5	5180	14	AP-C2-3F-02	0	14	10.8	11.8	3	0	30.7	7.2	9.7
4	x	-76.75	-76	2437	44	AP-C2-3F-02	0	14	10.8	11.8	3	0	30.7	7.2	9.7
4	w	-91	-91	5180	44	AP-C2-3F-02	0	12	10.8	11.8	3	0	30.7	7.2	9.7
4	w	-81	-81	2437	14	AP-C2-3F-02	0	12	10.8	11.8	3	0	30.7	7.2	9.7
4	v	-83.66666667	-83	2437	21	AP-C2-3F-02	0	10	10.8	11.8	3	0	30.7	7.2	9.7
4	s	-84	-84	2437	7	AP-C2-3F-02	0	4	10.8	11.8	3	0	30.7	7.2	9.7
4	r	-87	-87	2437	7	AP-C2-3F-02	0	2	10.8	11.8	3	0	30.7	7.2	9.7
3	am	-52.4	-52	5180	100	AP-C2-3F-03	0	44	7.2	8.2	3	0	44.2	7.2	9.7
3	am	-41.12	-41	2437	100	AP-C2-3F-03	0	44	7.2	8.2	3	0	44.2	7.2	9.7
3	al	-54	-54	5180	100	AP-C2-3F-03	0	42	7.2	8.2	3	0	44.2	7.2	9.7
3	al	-39.82	-39	2437	100	AP-C2-3F-03	0	42	7.2	8.2	3	0	44.2	7.2	9.7
3	ak	-60.64	-60	5180	100	AP-C2-3F-03	0	40	7.2	8.2	3	0	44.2	7.2	9.7
3	ak	-46.25	-46	2437	100	AP-C2-3F-03	0	40	7.2	8.2	3	0	44.2	7.2	9.7
3	aj	-66.53	-67	5180	100	AP-C2-3F-03	0	38	7.2	8.2	3	0	44.2	7.2	9.7
3	aj	-48.69	-48	2437	100	AP-C2-3F-03	0	38	7.2	8.2	3	0	44.2	7.2	9.7
3	ai	-61	-61	5180	4	AP-C2-3F-03	0	36	7.2	8.2	3	0	44.2	7.2	9.7
3	ai	-53.1	-54	2437	100	AP-C2-3F-03	0	36	7.2	8.2	3	0	44.2	7.2	9.7
3	ah	-63.6	-64	5180	35	AP-C2-3F-03	0	34	7.2	8.2	3	0	44.2	7.2	9.7
3	ah	-60.47	-60	2437	100	AP-C2-3F-03	0	34	7.2	8.2	3	0	44.2	7.2	9.7
3	ag	-67.75531915	-69	5180	94	AP-C2-3F-03	0	32	7.2	8.2	3	0	44.2	7.2	9.7
3	ag	-66.16	-65	2437	100	AP-C2-3F-03	0	32	7.2	8.2	3	0	44.2	7.2	9.7
3	af	-59.01010101	-59	2437	99	AP-C2-3F-03	0	30	7.2	8.2	3	0	44.2	7.2	9.7
3	ae	-57.72	-58	2437	100	AP-C2-3F-03	0	28	7.2	8.2	3	0	44.2	7.2	9.7
3	ad	-63.06	-63	2437	100	AP-C2-3F-03	0	26	7.2	8.2	3	0	44.2	7.2	9.7
3	ac	-63.34	-63	2437	100	AP-C2-3F-03	0	24	7.2	8.2	3	0	44.2	7.2	9.7
3	ab	-64.72307692	-66	2437	65	AP-C2-3F-03	0	22	7.2	8.2	3	0	44.2	7.2	9.7
3	aa	-70.3	-70	5180	100	AP-C2-3F-03	0	20	7.2	8.2	3	0	44.2	7.2	9.7
3	aa	-57.58139535	-57	2437	86	AP-C2-3F-03	0	20	7.2	8.2	3	0	44.2	7.2	9.7
3	ay	-85.22222222	-85	2437	9	AP-C2-3F-03	12	56	7.2	8.2	3	0	44.2	7.2	9.7
3	av	-78	-78	2437	7	AP-C2-3F-03	6	56	7.2	8.2	3	0	44.2	7.2	9.7
3	au	-84.01388889	-83.5	5180	72	AP-C2-3F-03	4	56	7.2	8.2	3	0	44.2	7.2	9.7
3	au	-77.22727273	-77	2437	22	AP-C2-3F-03	4	56	7.2	8.2	3	0	44.2	7.2	9.7
3	at	-85.37974684	-86	5180	79	AP-C2-3F-03	2	56	7.2	8.2	3	0	44.2	7.2	9.7
3	at	-77.5	-77.5	2437	14	AP-C2-3F-03	2	56	7.2	8.2	3	0	44.2	7.2	9.7
3	as	-71.86046512	-71	5180	86	AP-C2-3F-03	0	56	7.2	8.2	3	0	44.2	7.2	9.7
3	as	-61.58064516	-62	2437	93	AP-C2-3F-03	0	56	7.2	8.2	3	0	44.2	7.2	9.7
3	ar	-74.86111111	-75	5180	72	AP-C2-3F-03	0	54	7.2	8.2	3	0	44.2	7.2	9.7
3	ar	-63.02	-63	2437	100	AP-C2-3F-03	0	54	7.2	8.2	3	0	44.2	7.2	9.7
3	aq	-75.24050633	-75	5180	79	AP-C2-3F-03	0	52	7.2	8.2	3	0	44.2	7.2	9.7
3	aq	-60.33	-60	2437	100	AP-C2-3F-03	0	52	7.2	8.2	3	0	44.2	7.2	9.7
3	ap	-70.07526882	-70	5180	93	AP-C2-3F-03	0	50	7.2	8.2	3	0	44.2	7.2	9.7
3	ap	-60.68817204	-60	2437	93	AP-C2-3F-03	0	50	7.2	8.2	3	0	44.2	7.2	9.7
3	ao	-57.8	-57	5180	100	AP-C2-3F-03	0	48	7.2	8.2	3	0	44.2	7.2	9.7
3	ao	-48.1	-48	2437	100	AP-C2-3F-03	0	48	7.2	8.2	3	0	44.2	7.2	9.7
3	an	-57.09	-57	5180	100	AP-C2-3F-03	0	46	7.2	8.2	3	0	44.2	7.2	9.7
3	an	-38.65	-39	2437	100	AP-C2-3F-03	0	46	7.2	8.2	3	0	44.2	7.2	9.7
3	be	-85	-85	2437	7	AP-C2-3F-03	24	56	7.2	8.2	3	0	44.2	7.2	9.7
3	bb	-87.75	-89	2437	12	AP-C2-3F-03	18	56	7.2	8.2	3	0	44.2	7.2	9.7
3	ba	-82.22222222	-82	2437	9	AP-C2-3F-03	16	56	7.2	8.2	3	0	44.2	7.2	9.7
3	y	-73.91860465	-74	5180	86	AP-C2-3F-03	0	16	7.2	8.2	3	0	44.2	7.2	9.7
3	y	-60.3255814	-61	2437	86	AP-C2-3F-03	0	16	7.2	8.2	3	0	44.2	7.2	9.7
3	x	-80.7	-81	5180	10	AP-C2-3F-03	0	14	7.2	8.2	3	0	44.2	7.2	9.7
3	x	-62.79	-63	2437	100	AP-C2-3F-03	0	14	7.2	8.2	3	0	44.2	7.2	9.7
3	w	-79.13846154	-79	5180	65	AP-C2-3F-03	0	12	7.2	8.2	3	0	44.2	7.2	9.7
3	w	-62.82795699	-63	2437	93	AP-C2-3F-03	0	12	7.2	8.2	3	0	44.2	7.2	9.7
3	v	-79.87341772	-80	5180	79	AP-C2-3F-03	0	10	7.2	8.2	3	0	44.2	7.2	9.7
3	v	-70.08333333	-69.5	2437	72	AP-C2-3F-03	0	10	7.2	8.2	3	0	44.2	7.2	9.7
3	u	-84.36363636	-84	5180	77	AP-C2-3F-03	0	8	7.2	8.2	3	0	44.2	7.2	9.7
3	u	-64.91860465	-65	2437	86	AP-C2-3F-03	0	8	7.2	8.2	3	0	44.2	7.2	9.7
3	t	-81.91666667	-82	5180	84	AP-C2-3F-03	0	6	7.2	8.2	3	0	44.2	7.2	9.7
3	t	-63.71428571	-64	2437	98	AP-C2-3F-03	0	6	7.2	8.2	3	0	44.2	7.2	9.7
3	s	-84.83333333	-84.5	5180	84	AP-C2-3F-03	0	4	7.2	8.2	3	0	44.2	7.2	9.7
3	s	-64.05	-64	2437	100	AP-C2-3F-03	0	4	7.2	8.2	3	0	44.2	7.2	9.7
3	r	-69.24418605	-69	2437	86	AP-C2-3F-03	0	2	7.2	8.2	3	0	44.2	7.2	9.7
3	q	-85.73333333	-86	5180	75	AP-C2-3F-03	0	0	7.2	8.2	3	0	44.2	7.2	9.7
3	q	-74.66666667	-75	2437	21	AP-C2-3F-03	0	0	7.2	8.2	3	0	44.2	7.2	9.7
3	p	-86	-86	2437	7	AP-C2-3F-03	2	0	7.2	8.2	3	0	44.2	7.2	9.7
3	o	-90.18461538	-91	5180	65	AP-C2-3F-03	4	0	7.2	8.2	3	0	44.2	7.2	9.7
4	al	-60.46	-60	2437	100	AP-C2-3F-03	0	42	10.8	11.8	3	0	44.2	7.2	9.7
4	ak	-77.61111111	-78	5180	72	AP-C2-3F-03	0	40	10.8	11.8	3	0	44.2	7.2	9.7
4	ak	-56.51	-56	2437	100	AP-C2-3F-03	0	40	10.8	11.8	3	0	44.2	7.2	9.7
4	aj	-76.27848101	-76	5180	79	AP-C2-3F-03	0	38	10.8	11.8	3	0	44.2	7.2	9.7
4	aj	-65.29113924	-65	2437	79	AP-C2-3F-03	0	38	10.8	11.8	3	0	44.2	7.2	9.7
4	ai	-84.59302326	-85	5180	86	AP-C2-3F-03	0	36	10.8	11.8	3	0	44.2	7.2	9.7
4	ai	-71.39240506	-72	2437	79	AP-C2-3F-03	0	36	10.8	11.8	3	0	44.2	7.2	9.7
4	ah	-83.45454545	-83	5180	77	AP-C2-3F-03	0	34	10.8	11.8	3	0	44.2	7.2	9.7
4	ah	-79.18918919	-80	2437	37	AP-C2-3F-03	0	34	10.8	11.8	3	0	44.2	7.2	9.7
4	ag	-85.6	-86	5180	70	AP-C2-3F-03	0	32	10.8	11.8	3	0	44.2	7.2	9.7
4	ag	-73.25	-73	2437	28	AP-C2-3F-03	0	32	10.8	11.8	3	0	44.2	7.2	9.7
4	af	-89.45	-90	5180	20	AP-C2-3F-03	0	30	10.8	11.8	3	0	44.2	7.2	9.7
4	af	-76.20833333	-77	2437	24	AP-C2-3F-03	0	30	10.8	11.8	3	0	44.2	7.2	9.7
4	ae	-91	-91	5180	14	AP-C2-3F-03	0	28	10.8	11.8	3	0	44.2	7.2	9.7
4	ae	-76.5	-76.5	2437	70	AP-C2-3F-03	0	28	10.8	11.8	3	0	44.2	7.2	9.7
4	ad	-82	-82	2437	7	AP-C2-3F-03	0	26	10.8	11.8	3	0	44.2	7.2	9.7
4	ac	-79	-79	2437	7	AP-C2-3F-03	0	24	10.8	11.8	3	0	44.2	7.2	9.7
4	ab	-84	-84	2437	7	AP-C2-3F-03	0	22	10.8	11.8	3	0	44.2	7.2	9.7
4	aa	-83.66666667	-84	2437	21	AP-C2-3F-03	0	20	10.8	11.8	3	0	44.2	7.2	9.7
3	z	-72.04	-71	5180	25	AP-C2-3F-03	0	18	7.2	8.2	3	0	44.2	7.2	9.7
3	z	-58.51612903	-58	2437	93	AP-C2-3F-03	0	18	7.2	8.2	3	0	44.2	7.2	9.7
4	au	-88	-88	2437	14	AP-C2-3F-03	4	56	10.8	11.8	3	0	44.2	7.2	9.7
4	at	-82.5	-82.5	2437	14	AP-C2-3F-03	2	56	10.8	11.8	3	0	44.2	7.2	9.7
4	as	-87.63333333	-87	5180	30	AP-C2-3F-03	0	56	10.8	11.8	3	0	44.2	7.2	9.7
4	as	-74.55172414	-74	2437	58	AP-C2-3F-03	0	56	10.8	11.8	3	0	44.2	7.2	9.7
4	ar	-72.25316456	-73	2437	79	AP-C2-3F-03	0	54	10.8	11.8	3	0	44.2	7.2	9.7
4	aq	-92	-92	5180	14	AP-C2-3F-03	0	52	10.8	11.8	3	0	44.2	7.2	9.7
4	aq	-74.30379747	-74	2437	79	AP-C2-3F-03	0	52	10.8	11.8	3	0	44.2	7.2	9.7
4	ap	-89.01265823	-89	5180	79	AP-C2-3F-03	0	50	10.8	11.8	3	0	44.2	7.2	9.7
4	ap	-73.78	-74	2437	100	AP-C2-3F-03	0	50	10.8	11.8	3	0	44.2	7.2	9.7
4	ao	-83.90322581	-83	5180	93	AP-C2-3F-03	0	48	10.8	11.8	3	0	44.2	7.2	9.7
4	ao	-71.07692308	-71	2437	65	AP-C2-3F-03	0	48	10.8	11.8	3	0	44.2	7.2	9.7
4	an	-77.05063291	-77	5180	79	AP-C2-3F-03	0	46	10.8	11.8	3	0	44.2	7.2	9.7
4	an	-56.52	-57	2437	100	AP-C2-3F-03	0	46	10.8	11.8	3	0	44.2	7.2	9.7
4	am	-76.89534884	-78	5180	86	AP-C2-3F-03	0	44	10.8	11.8	3	0	44.2	7.2	9.7
4	am	-62.07	-62	2437	100	AP-C2-3F-03	0	44	10.8	11.8	3	0	44.2	7.2	9.7
4	al	-72.85714286	-73	5180	98	AP-C2-3F-03	0	42	10.8	11.8	3	0	44.2	7.2	9.7
4	z	-79.5	-79.5	2437	14	AP-C2-3F-03	0	18	10.8	11.8	3	0	44.2	7.2	9.7
4	y	-88	-88	2437	5	AP-C2-3F-03	0	16	10.8	11.8	3	0	44.2	7.2	9.7
4	t	-86	-86	2437	7	AP-C2-3F-03	0	6	10.8	11.8	3	0	44.2	7.2	9.7
3	am	-85.33333333	-85	2437	21	AP-C2-4F-01	0	44	7.2	8.2	4	0	22.6	10.8	13.3
3	al	-85.25	-86.5	2437	28	AP-C2-4F-01	0	42	7.2	8.2	4	0	22.6	10.8	13.3
3	ak	-92	-92	2437	7	AP-C2-4F-01	0	40	7.2	8.2	4	0	22.6	10.8	13.3
3	aj	-78.90277778	-79	2437	72	AP-C2-4F-01	0	38	7.2	8.2	4	0	22.6	10.8	13.3
3	ai	-75.4	-76	2437	35	AP-C2-4F-01	0	36	7.2	8.2	4	0	22.6	10.8	13.3
3	ah	-81	-81.5	2437	42	AP-C2-4F-01	0	34	7.2	8.2	4	0	22.6	10.8	13.3
3	ag	-73.63636364	-74	2437	77	AP-C2-4F-01	0	32	7.2	8.2	4	0	22.6	10.8	13.3
3	af	-62.20430108	-62	2437	93	AP-C2-4F-01	0	30	7.2	8.2	4	0	22.6	10.8	13.3
3	ae	-60.68	-61	2437	100	AP-C2-4F-01	0	28	7.2	8.2	4	0	22.6	10.8	13.3
3	ad	-62.24731183	-62	2437	93	AP-C2-4F-01	0	26	7.2	8.2	4	0	22.6	10.8	13.3
3	ac	-60.34408602	-60	2437	93	AP-C2-4F-01	0	24	7.2	8.2	4	0	22.6	10.8	13.3
3	ab	-57.93	-58	2437	100	AP-C2-4F-01	0	22	7.2	8.2	4	0	22.6	10.8	13.3
3	aa	-77.4	-78	5180	10	AP-C2-4F-01	0	20	7.2	8.2	4	0	22.6	10.8	13.3
3	aa	-55.21	-55	2437	100	AP-C2-4F-01	0	20	7.2	8.2	4	0	22.6	10.8	13.3
3	as	-83.5	-83.5	2437	42	AP-C2-4F-01	0	56	7.2	8.2	4	0	22.6	10.8	13.3
3	aq	-85	-85	2437	7	AP-C2-4F-01	0	52	7.2	8.2	4	0	22.6	10.8	13.3
3	an	-82.8	-82	2437	35	AP-C2-4F-01	0	46	7.2	8.2	4	0	22.6	10.8	13.3
3	y	-60.21	-60	2437	100	AP-C2-4F-01	0	16	7.2	8.2	4	0	22.6	10.8	13.3
3	x	-61.07	-61	2437	100	AP-C2-4F-01	0	14	7.2	8.2	4	0	22.6	10.8	13.3
3	w	-80.27777778	-81	5180	18	AP-C2-4F-01	0	12	7.2	8.2	4	0	22.6	10.8	13.3
3	w	-73.01960784	-72	2437	51	AP-C2-4F-01	0	12	7.2	8.2	4	0	22.6	10.8	13.3
3	v	-90.25	-90.5	5180	28	AP-C2-4F-01	0	10	7.2	8.2	4	0	22.6	10.8	13.3
3	v	-67.61627907	-68	2437	86	AP-C2-4F-01	0	10	7.2	8.2	4	0	22.6	10.8	13.3
3	u	-90	-90	5180	7	AP-C2-4F-01	0	8	7.2	8.2	4	0	22.6	10.8	13.3
3	u	-69.86111111	-70	2437	72	AP-C2-4F-01	0	8	7.2	8.2	4	0	22.6	10.8	13.3
3	t	-74.93442623	-75	2437	61	AP-C2-4F-01	0	6	7.2	8.2	4	0	22.6	10.8	13.3
3	s	-81.125	-81	2437	56	AP-C2-4F-01	0	4	7.2	8.2	4	0	22.6	10.8	13.3
3	r	-72.64150943	-72	2437	53	AP-C2-4F-01	0	2	7.2	8.2	4	0	22.6	10.8	13.3
3	q	-68.34782609	-69	2437	46	AP-C2-4F-01	0	0	7.2	8.2	4	0	22.6	10.8	13.3
4	al	-70.0862069	-70	2437	58	AP-C2-4F-01	0	42	10.8	11.8	4	0	22.6	10.8	13.3
4	ak	-83.41666667	-84	5180	72	AP-C2-4F-01	0	40	10.8	11.8	4	0	22.6	10.8	13.3
4	ak	-70.52941176	-70	2437	51	AP-C2-4F-01	0	40	10.8	11.8	4	0	22.6	10.8	13.3
4	aj	-81.23076923	-82	5180	91	AP-C2-4F-01	0	38	10.8	11.8	4	0	22.6	10.8	13.3
4	aj	-77.3	-76	2437	70	AP-C2-4F-01	0	38	10.8	11.8	4	0	22.6	10.8	13.3
4	ai	-80.93846154	-81	5180	65	AP-C2-4F-01	0	36	10.8	11.8	4	0	22.6	10.8	13.3
4	ai	-78.75	-78.5	2437	28	AP-C2-4F-01	0	36	10.8	11.8	4	0	22.6	10.8	13.3
4	ah	-72.9	-73	5180	70	AP-C2-4F-01	0	34	10.8	11.8	4	0	22.6	10.8	13.3
4	ah	-72.07692308	-70	2437	65	AP-C2-4F-01	0	34	10.8	11.8	4	0	22.6	10.8	13.3
4	ag	-72.31914894	-73	5180	47	AP-C2-4F-01	0	32	10.8	11.8	4	0	22.6	10.8	13.3
4	ag	-65.14	-65	2437	100	AP-C2-4F-01	0	32	10.8	11.8	4	0	22.6	10.8	13.3
4	af	-72.65	-72	5180	100	AP-C2-4F-01	0	30	10.8	11.8	4	0	22.6	10.8	13.3
4	af	-65.13978495	-65	2437	93	AP-C2-4F-01	0	30	10.8	11.8	4	0	22.6	10.8	13.3
4	ae	-69.84	-70	5180	100	AP-C2-4F-01	0	28	10.8	11.8	4	0	22.6	10.8	13.3
4	ae	-60.42	-60	2437	100	AP-C2-4F-01	0	28	10.8	11.8	4	0	22.6	10.8	13.3
4	ad	-63.21	-63	5180	100	AP-C2-4F-01	0	26	10.8	11.8	4	0	22.6	10.8	13.3
4	ad	-58.13978495	-58	2437	93	AP-C2-4F-01	0	26	10.8	11.8	4	0	22.6	10.8	13.3
4	ac	-48.67	-48	5180	100	AP-C2-4F-01	0	24	10.8	11.8	4	0	22.6	10.8	13.3
4	ac	-43.67	-44	2437	100	AP-C2-4F-01	0	24	10.8	11.8	4	0	22.6	10.8	13.3
4	ab	-50.88	-50	5180	100	AP-C2-4F-01	0	22	10.8	11.8	4	0	22.6	10.8	13.3
4	ab	-41.12	-44	2437	100	AP-C2-4F-01	0	22	10.8	11.8	4	0	22.6	10.8	13.3
4	aa	-61	-61	5180	100	AP-C2-4F-01	0	20	10.8	11.8	4	0	22.6	10.8	13.3
4	aa	-48.15	-46	2437	100	AP-C2-4F-01	0	20	10.8	11.8	4	0	22.6	10.8	13.3
4	a	-73	-73	2437	7	AP-C2-4F-01	32	0	10.8	11.8	4	0	22.6	10.8	13.3
3	z	-68.41935484	-67	2437	93	AP-C2-4F-01	0	18	7.2	8.2	4	0	22.6	10.8	13.3
3	y	-85.875	-86	5180	8	AP-C2-4F-01	0	16	7.2	8.2	4	0	22.6	10.8	13.3
4	au	-93	-93	5180	7	AP-C2-4F-01	4	56	10.8	11.8	4	0	22.6	10.8	13.3
4	at	-90	-90	5180	21	AP-C2-4F-01	2	56	10.8	11.8	4	0	22.6	10.8	13.3
4	as	-80.53846154	-81	5180	65	AP-C2-4F-01	0	56	10.8	11.8	4	0	22.6	10.8	13.3
4	as	-76.13513514	-76	2437	37	AP-C2-4F-01	0	56	10.8	11.8	4	0	22.6	10.8	13.3
4	ar	-87.87341772	-88	5180	79	AP-C2-4F-01	0	54	10.8	11.8	4	0	22.6	10.8	13.3
4	ar	-81.33333333	-82	2437	21	AP-C2-4F-01	0	54	10.8	11.8	4	0	22.6	10.8	13.3
4	aq	-83.48387097	-84	5180	93	AP-C2-4F-01	0	52	10.8	11.8	4	0	22.6	10.8	13.3
4	aq	-77.04615385	-77	2437	65	AP-C2-4F-01	0	52	10.8	11.8	4	0	22.6	10.8	13.3
4	ap	-87.5	-87	5180	42	AP-C2-4F-01	0	50	10.8	11.8	4	0	22.6	10.8	13.3
4	ap	-75.49230769	-76	2437	65	AP-C2-4F-01	0	50	10.8	11.8	4	0	22.6	10.8	13.3
4	ao	-84.69444444	-85	5180	72	AP-C2-4F-01	0	48	10.8	11.8	4	0	22.6	10.8	13.3
4	ao	-76	-76	2437	14	AP-C2-4F-01	0	48	10.8	11.8	4	0	22.6	10.8	13.3
4	an	-80	-80	5180	79	AP-C2-4F-01	0	46	10.8	11.8	4	0	22.6	10.8	13.3
4	an	-78.57142857	-79	2437	49	AP-C2-4F-01	0	46	10.8	11.8	4	0	22.6	10.8	13.3
4	am	-83.03076923	-83	5180	65	AP-C2-4F-01	0	44	10.8	11.8	4	0	22.6	10.8	13.3
4	am	-76	-75.5	2437	42	AP-C2-4F-01	0	44	10.8	11.8	4	0	22.6	10.8	13.3
4	al	-82.40277778	-83	5180	72	AP-C2-4F-01	0	42	10.8	11.8	4	0	22.6	10.8	13.3
4	z	-67.09	-66	5180	100	AP-C2-4F-01	0	18	10.8	11.8	4	0	22.6	10.8	13.3
4	z	-53.07	-53	2437	100	AP-C2-4F-01	0	18	10.8	11.8	4	0	22.6	10.8	13.3
4	y	-64.57	-65	5180	100	AP-C2-4F-01	0	16	10.8	11.8	4	0	22.6	10.8	13.3
4	y	-55.65	-56	2437	100	AP-C2-4F-01	0	16	10.8	11.8	4	0	22.6	10.8	13.3
4	x	-65.17	-65	5180	100	AP-C2-4F-01	0	14	10.8	11.8	4	0	22.6	10.8	13.3
4	x	-55.84	-55	2437	100	AP-C2-4F-01	0	14	10.8	11.8	4	0	22.6	10.8	13.3
4	w	-66.42	-66	5180	100	AP-C2-4F-01	0	12	10.8	11.8	4	0	22.6	10.8	13.3
4	w	-63.52	-63	2437	100	AP-C2-4F-01	0	12	10.8	11.8	4	0	22.6	10.8	13.3
4	v	-74.47674419	-75	5180	86	AP-C2-4F-01	0	10	10.8	11.8	4	0	22.6	10.8	13.3
4	v	-69.57	-68	2437	100	AP-C2-4F-01	0	10	10.8	11.8	4	0	22.6	10.8	13.3
4	u	-74.56989247	-74	5180	93	AP-C2-4F-01	0	8	10.8	11.8	4	0	22.6	10.8	13.3
4	u	-64.79	-64	2437	100	AP-C2-4F-01	0	8	10.8	11.8	4	0	22.6	10.8	13.3
4	t	-70.18181818	-70	5180	33	AP-C2-4F-01	0	6	10.8	11.8	4	0	22.6	10.8	13.3
4	t	-66.41	-66	2437	100	AP-C2-4F-01	0	6	10.8	11.8	4	0	22.6	10.8	13.3
4	s	-72.12121212	-71	5180	33	AP-C2-4F-01	0	4	10.8	11.8	4	0	22.6	10.8	13.3
4	s	-70.32758621	-71	2437	58	AP-C2-4F-01	0	4	10.8	11.8	4	0	22.6	10.8	13.3
4	r	-80.87931034	-81	5180	58	AP-C2-4F-01	0	2	10.8	11.8	4	0	22.6	10.8	13.3
4	r	-75.15384615	-76	2437	65	AP-C2-4F-01	0	2	10.8	11.8	4	0	22.6	10.8	13.3
4	q	-73.41772152	-73	2437	79	AP-C2-4F-01	0	0	10.8	11.8	4	0	22.6	10.8	13.3
4	p	-85.72222222	-86	5180	18	AP-C2-4F-01	2	0	10.8	11.8	4	0	22.6	10.8	13.3
4	p	-78	-78	2437	63	AP-C2-4F-01	2	0	10.8	11.8	4	0	22.6	10.8	13.3
4	o	-90.85714286	-91	5180	49	AP-C2-4F-01	4	0	10.8	11.8	4	0	22.6	10.8	13.3
4	o	-87	-87	2437	14	AP-C2-4F-01	4	0	10.8	11.8	4	0	22.6	10.8	13.3
3	am	-78.68055556	-79	2437	72	AP-C2-4F-02	0	44	7.2	8.2	4	0	30	10.8	13.3
3	al	-78.66666667	-78	2437	63	AP-C2-4F-02	0	42	7.2	8.2	4	0	30	10.8	13.3
3	ak	-89.5625	-90	5180	16	AP-C2-4F-02	0	40	7.2	8.2	4	0	30	10.8	13.3
3	ak	-71.53	-72	2437	100	AP-C2-4F-02	0	40	7.2	8.2	4	0	30	10.8	13.3
3	aj	-86.45833333	-86	5180	72	AP-C2-4F-02	0	38	7.2	8.2	4	0	30	10.8	13.3
3	aj	-65.91	-65	2437	100	AP-C2-4F-02	0	38	7.2	8.2	4	0	30	10.8	13.3
3	ai	-61.44	-61	2437	100	AP-C2-4F-02	0	36	7.2	8.2	4	0	30	10.8	13.3
3	ah	-63.94623656	-64	2437	93	AP-C2-4F-02	0	34	7.2	8.2	4	0	30	10.8	13.3
3	ag	-59.51	-59	2437	100	AP-C2-4F-02	0	32	7.2	8.2	4	0	30	10.8	13.3
3	af	-64.33	-64	2437	100	AP-C2-4F-02	0	30	7.2	8.2	4	0	30	10.8	13.3
3	ae	-60.14	-60	2437	100	AP-C2-4F-02	0	28	7.2	8.2	4	0	30	10.8	13.3
3	ad	-63.50537634	-64	2437	93	AP-C2-4F-02	0	26	7.2	8.2	4	0	30	10.8	13.3
3	ac	-75.66666667	-76.5	2437	84	AP-C2-4F-02	0	24	7.2	8.2	4	0	30	10.8	13.3
3	ab	-63.80645161	-63	2437	93	AP-C2-4F-02	0	22	7.2	8.2	4	0	30	10.8	13.3
3	aa	-73.95698925	-74	2437	93	AP-C2-4F-02	0	20	7.2	8.2	4	0	30	10.8	13.3
3	as	-83	-83	2437	7	AP-C2-4F-02	0	56	7.2	8.2	4	0	30	10.8	13.3
3	aq	-85.5	-85.5	2437	14	AP-C2-4F-02	0	52	7.2	8.2	4	0	30	10.8	13.3
3	ao	-76	-76	2437	9	AP-C2-4F-02	0	48	7.2	8.2	4	0	30	10.8	13.3
3	an	-90	-90	5180	7	AP-C2-4F-02	0	46	7.2	8.2	4	0	30	10.8	13.3
3	an	-77	-76	2437	84	AP-C2-4F-02	0	46	7.2	8.2	4	0	30	10.8	13.3
3	y	-71.91666667	-72	2437	72	AP-C2-4F-02	0	16	7.2	8.2	4	0	30	10.8	13.3
3	x	-79.04545455	-79	2437	44	AP-C2-4F-02	0	14	7.2	8.2	4	0	30	10.8	13.3
3	w	-77.17204301	-77	2437	93	AP-C2-4F-02	0	12	7.2	8.2	4	0	30	10.8	13.3
3	v	-91	-91	5180	43	AP-C2-4F-02	0	10	7.2	8.2	4	0	30	10.8	13.3
3	v	-69.37	-69	2437	100	AP-C2-4F-02	0	10	7.2	8.2	4	0	30	10.8	13.3
3	u	-76.19354839	-75	2437	31	AP-C2-4F-02	0	8	7.2	8.2	4	0	30	10.8	13.3
3	t	-82.26923077	-82	2437	26	AP-C2-4F-02	0	6	7.2	8.2	4	0	30	10.8	13.3
3	s	-82	-82	2437	2	AP-C2-4F-02	0	4	7.2	8.2	4	0	30	10.8	13.3
3	r	-86	-86	2437	7	AP-C2-4F-02	0	2	7.2	8.2	4	0	30	10.8	13.3
3	q	-84	-84	2437	14	AP-C2-4F-02	0	0	7.2	8.2	4	0	30	10.8	13.3
4	al	-64.80645161	-65	2437	93	AP-C2-4F-02	0	42	10.8	11.8	4	0	30	10.8	13.3
4	ak	-73.2	-73	5180	70	AP-C2-4F-02	0	40	10.8	11.8	4	0	30	10.8	13.3
4	ak	-54.31	-54	2437	100	AP-C2-4F-02	0	40	10.8	11.8	4	0	30	10.8	13.3
4	aj	-74.75581395	-75	5180	86	AP-C2-4F-02	0	38	10.8	11.8	4	0	30	10.8	13.3
4	aj	-59.47	-59	2437	100	AP-C2-4F-02	0	38	10.8	11.8	4	0	30	10.8	13.3
4	ai	-67.75268817	-66	5180	93	AP-C2-4F-02	0	36	10.8	11.8	4	0	30	10.8	13.3
4	ai	-58.95	-60	2437	100	AP-C2-4F-02	0	36	10.8	11.8	4	0	30	10.8	13.3
4	ah	-65.07	-65	5180	100	AP-C2-4F-02	0	34	10.8	11.8	4	0	30	10.8	13.3
4	ah	-45.21	-45	2437	100	AP-C2-4F-02	0	34	10.8	11.8	4	0	30	10.8	13.3
4	ag	-43.65	-43	2437	100	AP-C2-4F-02	0	32	10.8	11.8	4	0	30	10.8	13.3
4	af	-50.43	-51	5180	100	AP-C2-4F-02	0	30	10.8	11.8	4	0	30	10.8	13.3
4	af	-36.85	-36	2437	100	AP-C2-4F-02	0	30	10.8	11.8	4	0	30	10.8	13.3
4	ae	-58.60215054	-58	5180	93	AP-C2-4F-02	0	28	10.8	11.8	4	0	30	10.8	13.3
4	ae	-48.17	-48	2437	100	AP-C2-4F-02	0	28	10.8	11.8	4	0	30	10.8	13.3
4	ad	-58.82	-59	5180	100	AP-C2-4F-02	0	26	10.8	11.8	4	0	30	10.8	13.3
4	ad	-53.44	-54	2437	100	AP-C2-4F-02	0	26	10.8	11.8	4	0	30	10.8	13.3
4	ac	-64.91	-64	5180	100	AP-C2-4F-02	0	24	10.8	11.8	4	0	30	10.8	13.3
4	ac	-52.67	-53	2437	100	AP-C2-4F-02	0	24	10.8	11.8	4	0	30	10.8	13.3
4	ab	-69.41860465	-68	5180	86	AP-C2-4F-02	0	22	10.8	11.8	4	0	30	10.8	13.3
4	ab	-59.72	-60	2437	100	AP-C2-4F-02	0	22	10.8	11.8	4	0	30	10.8	13.3
4	aa	-72.87096774	-72	5180	93	AP-C2-4F-02	0	20	10.8	11.8	4	0	30	10.8	13.3
4	aa	-57.28	-57	2437	100	AP-C2-4F-02	0	20	10.8	11.8	4	0	30	10.8	13.3
4	a	-72	-72	2437	7	AP-C2-4F-02	32	0	10.8	11.8	4	0	30	10.8	13.3
3	z	-76.93670886	-76	2437	79	AP-C2-4F-02	0	18	7.2	8.2	4	0	30	10.8	13.3
4	aw	-90	-90	5180	7	AP-C2-4F-02	8	56	10.8	11.8	4	0	30	10.8	13.3
4	at	-83.19444444	-83	5180	72	AP-C2-4F-02	2	56	10.8	11.8	4	0	30	10.8	13.3
4	at	-76.56862745	-76	2437	51	AP-C2-4F-02	2	56	10.8	11.8	4	0	30	10.8	13.3
4	as	-66.01	-66	5180	100	AP-C2-4F-02	0	56	10.8	11.8	4	0	30	10.8	13.3
4	as	-65.05813953	-65	2437	86	AP-C2-4F-02	0	56	10.8	11.8	4	0	30	10.8	13.3
4	ar	-81.5	-81	5180	70	AP-C2-4F-02	0	54	10.8	11.8	4	0	30	10.8	13.3
4	ar	-81	-82	2437	21	AP-C2-4F-02	0	54	10.8	11.8	4	0	30	10.8	13.3
4	aq	-82.34722222	-83	5180	72	AP-C2-4F-02	0	52	10.8	11.8	4	0	30	10.8	13.3
4	aq	-81.77777778	-83	2437	63	AP-C2-4F-02	0	52	10.8	11.8	4	0	30	10.8	13.3
4	ap	-80.8172043	-81	5180	93	AP-C2-4F-02	0	50	10.8	11.8	4	0	30	10.8	13.3
4	ap	-76.46236559	-75	2437	93	AP-C2-4F-02	0	50	10.8	11.8	4	0	30	10.8	13.3
4	ao	-74.8255814	-75	5180	86	AP-C2-4F-02	0	48	10.8	11.8	4	0	30	10.8	13.3
4	ao	-71.27777778	-71	2437	72	AP-C2-4F-02	0	48	10.8	11.8	4	0	30	10.8	13.3
4	an	-73.23655914	-74	5180	93	AP-C2-4F-02	0	46	10.8	11.8	4	0	30	10.8	13.3
4	an	-69.3372093	-69	2437	86	AP-C2-4F-02	0	46	10.8	11.8	4	0	30	10.8	13.3
4	am	-76.39534884	-77	5180	86	AP-C2-4F-02	0	44	10.8	11.8	4	0	30	10.8	13.3
4	am	-71.17204301	-72	2437	93	AP-C2-4F-02	0	44	10.8	11.8	4	0	30	10.8	13.3
4	al	-72.63076923	-73	5180	65	AP-C2-4F-02	0	42	10.8	11.8	4	0	30	10.8	13.3
4	bg	-93	-93	5180	7	AP-C2-4F-02	28	56	10.8	11.8	4	0	30	10.8	13.3
4	bf	-92.43478261	-92	5180	23	AP-C2-4F-02	26	56	10.8	11.8	4	0	30	10.8	13.3
4	be	-89.58333333	-89.5	5180	84	AP-C2-4F-02	24	56	10.8	11.8	4	0	30	10.8	13.3
4	bd	-89	-89	5180	7	AP-C2-4F-02	22	56	10.8	11.8	4	0	30	10.8	13.3
4	z	-72.34177215	-72	5180	79	AP-C2-4F-02	0	18	10.8	11.8	4	0	30	10.8	13.3
4	z	-63.05813953	-61	2437	86	AP-C2-4F-02	0	18	10.8	11.8	4	0	30	10.8	13.3
4	y	-72.83544304	-72	5180	79	AP-C2-4F-02	0	16	10.8	11.8	4	0	30	10.8	13.3
4	y	-63.48	-62	2437	100	AP-C2-4F-02	0	16	10.8	11.8	4	0	30	10.8	13.3
4	x	-72.58227848	-72	5180	79	AP-C2-4F-02	0	14	10.8	11.8	4	0	30	10.8	13.3
4	x	-64.25	-65	2437	72	AP-C2-4F-02	0	14	10.8	11.8	4	0	30	10.8	13.3
4	w	-80.58461538	-80	5180	65	AP-C2-4F-02	0	12	10.8	11.8	4	0	30	10.8	13.3
4	w	-76.2688172	-76	2437	93	AP-C2-4F-02	0	12	10.8	11.8	4	0	30	10.8	13.3
4	v	-76.7311828	-77	5180	93	AP-C2-4F-02	0	10	10.8	11.8	4	0	30	10.8	13.3
4	v	-70.74193548	-70	2437	93	AP-C2-4F-02	0	10	10.8	11.8	4	0	30	10.8	13.3
4	u	-79.27848101	-79	5180	79	AP-C2-4F-02	0	8	10.8	11.8	4	0	30	10.8	13.3
4	u	-74.74	-76	2437	100	AP-C2-4F-02	0	8	10.8	11.8	4	0	30	10.8	13.3
4	t	-79.33333333	-80	5180	72	AP-C2-4F-02	0	6	10.8	11.8	4	0	30	10.8	13.3
4	t	-63.48	-64	2437	100	AP-C2-4F-02	0	6	10.8	11.8	4	0	30	10.8	13.3
4	s	-82.7311828	-83	5180	93	AP-C2-4F-02	0	4	10.8	11.8	4	0	30	10.8	13.3
4	s	-68.24731183	-68	2437	93	AP-C2-4F-02	0	4	10.8	11.8	4	0	30	10.8	13.3
4	r	-77.29824561	-76	5180	57	AP-C2-4F-02	0	2	10.8	11.8	4	0	30	10.8	13.3
4	r	-81.3	-81.5	2437	70	AP-C2-4F-02	0	2	10.8	11.8	4	0	30	10.8	13.3
4	q	-79.16666667	-79	2437	42	AP-C2-4F-02	0	0	10.8	11.8	4	0	30	10.8	13.3
4	p	-84.35294118	-83	2437	51	AP-C2-4F-02	2	0	10.8	11.8	4	0	30	10.8	13.3
3	am	-76.18181818	-76	5180	77	AP-C2-4F-03	0	44	7.2	8.2	4	0	41.7	10.8	13.3
3	am	-59.44	-60	2437	100	AP-C2-4F-03	0	44	7.2	8.2	4	0	41.7	10.8	13.3
3	al	-79.27956989	-80	5180	93	AP-C2-4F-03	0	42	7.2	8.2	4	0	41.7	10.8	13.3
3	al	-63.31	-63	2437	100	AP-C2-4F-03	0	42	7.2	8.2	4	0	41.7	10.8	13.3
3	ak	-52.92	-53	2437	100	AP-C2-4F-03	0	40	7.2	8.2	4	0	41.7	10.8	13.3
3	aj	-81.42	-82	5180	50	AP-C2-4F-03	0	38	7.2	8.2	4	0	41.7	10.8	13.3
3	aj	-53.56	-54	2437	100	AP-C2-4F-03	0	38	7.2	8.2	4	0	41.7	10.8	13.3
3	ai	-57.87	-57	2437	100	AP-C2-4F-03	0	36	7.2	8.2	4	0	41.7	10.8	13.3
3	ah	-63.5483871	-64	2437	93	AP-C2-4F-03	0	34	7.2	8.2	4	0	41.7	10.8	13.3
3	ag	-62.83870968	-63	2437	93	AP-C2-4F-03	0	32	7.2	8.2	4	0	41.7	10.8	13.3
3	af	-65.47311828	-65	2437	93	AP-C2-4F-03	0	30	7.2	8.2	4	0	41.7	10.8	13.3
3	ae	-66.66666667	-66	2437	93	AP-C2-4F-03	0	28	7.2	8.2	4	0	41.7	10.8	13.3
3	ad	-69.97468354	-70	2437	79	AP-C2-4F-03	0	26	7.2	8.2	4	0	41.7	10.8	13.3
3	ac	-70.44444444	-70	2437	63	AP-C2-4F-03	0	24	7.2	8.2	4	0	41.7	10.8	13.3
3	ab	-73.44827586	-72	2437	58	AP-C2-4F-03	0	22	7.2	8.2	4	0	41.7	10.8	13.3
3	aa	-81.66666667	-81.5	2437	42	AP-C2-4F-03	0	20	7.2	8.2	4	0	41.7	10.8	13.3
3	as	-87.83333333	-88	5180	42	AP-C2-4F-03	0	56	7.2	8.2	4	0	41.7	10.8	13.3
3	as	-74.76666667	-75	2437	30	AP-C2-4F-03	0	56	7.2	8.2	4	0	41.7	10.8	13.3
3	ar	-76.1	-76	2437	70	AP-C2-4F-03	0	54	7.2	8.2	4	0	41.7	10.8	13.3
3	aq	-79.9137931	-79	2437	58	AP-C2-4F-03	0	52	7.2	8.2	4	0	41.7	10.8	13.3
3	ap	-83.83333333	-83.5	2437	42	AP-C2-4F-03	0	50	7.2	8.2	4	0	41.7	10.8	13.3
3	ao	-89.14285714	-89	5180	49	AP-C2-4F-03	0	48	7.2	8.2	4	0	41.7	10.8	13.3
3	ao	-73.72151899	-74	2437	79	AP-C2-4F-03	0	48	7.2	8.2	4	0	41.7	10.8	13.3
3	an	-84.51111111	-85	5180	45	AP-C2-4F-03	0	46	7.2	8.2	4	0	41.7	10.8	13.3
3	an	-64.6344086	-65	2437	93	AP-C2-4F-03	0	46	7.2	8.2	4	0	41.7	10.8	13.3
3	y	-74.25	-75	2437	28	AP-C2-4F-03	0	16	7.2	8.2	4	0	41.7	10.8	13.3
3	x	-74.06153846	-74	2437	65	AP-C2-4F-03	0	14	7.2	8.2	4	0	41.7	10.8	13.3
3	w	-82.5	-82.5	2437	28	AP-C2-4F-03	0	12	7.2	8.2	4	0	41.7	10.8	13.3
3	u	-80.66666667	-82	2437	15	AP-C2-4F-03	0	8	7.2	8.2	4	0	41.7	10.8	13.3
3	t	-80.82352941	-80	2437	34	AP-C2-4F-03	0	6	7.2	8.2	4	0	41.7	10.8	13.3
3	s	-89	-89	2437	7	AP-C2-4F-03	0	4	7.2	8.2	4	0	41.7	10.8	13.3
3	q	-84	-84	2437	14	AP-C2-4F-03	0	0	7.2	8.2	4	0	41.7	10.8	13.3
4	al	-42.41	-40	2437	100	AP-C2-4F-03	0	42	10.8	11.8	4	0	41.7	10.8	13.3
4	ak	-49.49	-50	5180	100	AP-C2-4F-03	0	40	10.8	11.8	4	0	41.7	10.8	13.3
4	ak	-43.91	-44	2437	100	AP-C2-4F-03	0	40	10.8	11.8	4	0	41.7	10.8	13.3
4	aj	-57.87	-58	5180	100	AP-C2-4F-03	0	38	10.8	11.8	4	0	41.7	10.8	13.3
4	aj	-42.25	-43	2437	100	AP-C2-4F-03	0	38	10.8	11.8	4	0	41.7	10.8	13.3
4	ai	-65.6	-65	5180	100	AP-C2-4F-03	0	36	10.8	11.8	4	0	41.7	10.8	13.3
4	ai	-49.1	-48	2437	100	AP-C2-4F-03	0	36	10.8	11.8	4	0	41.7	10.8	13.3
4	ah	-64.55	-65	5180	100	AP-C2-4F-03	0	34	10.8	11.8	4	0	41.7	10.8	13.3
4	ah	-62.81	-62	2437	100	AP-C2-4F-03	0	34	10.8	11.8	4	0	41.7	10.8	13.3
4	ag	-58.12	-58	2437	100	AP-C2-4F-03	0	32	10.8	11.8	4	0	41.7	10.8	13.3
4	af	-63.42	-64	5180	100	AP-C2-4F-03	0	30	10.8	11.8	4	0	41.7	10.8	13.3
4	af	-61.19	-60	2437	100	AP-C2-4F-03	0	30	10.8	11.8	4	0	41.7	10.8	13.3
4	ae	-73	-73	5180	1	AP-C2-4F-03	0	28	10.8	11.8	4	0	41.7	10.8	13.3
4	ae	-60.77	-60	2437	100	AP-C2-4F-03	0	28	10.8	11.8	4	0	41.7	10.8	13.3
4	ad	-70.67741935	-71	5180	93	AP-C2-4F-03	0	26	10.8	11.8	4	0	41.7	10.8	13.3
4	ad	-62.42	-63	2437	100	AP-C2-4F-03	0	26	10.8	11.8	4	0	41.7	10.8	13.3
4	ac	-75.28571429	-75	5180	98	AP-C2-4F-03	0	24	10.8	11.8	4	0	41.7	10.8	13.3
4	ac	-67.25581395	-66	2437	86	AP-C2-4F-03	0	24	10.8	11.8	4	0	41.7	10.8	13.3
4	ab	-66.95	-67	5180	100	AP-C2-4F-03	0	22	10.8	11.8	4	0	41.7	10.8	13.3
4	ab	-69.35443038	-70	2437	79	AP-C2-4F-03	0	22	10.8	11.8	4	0	41.7	10.8	13.3
4	aa	-76	-76	5180	3	AP-C2-4F-03	0	20	10.8	11.8	4	0	41.7	10.8	13.3
4	aa	-67.22222222	-66	2437	63	AP-C2-4F-03	0	20	10.8	11.8	4	0	41.7	10.8	13.3
4	a	-77	-77	5180	7	AP-C2-4F-03	32	0	10.8	11.8	4	0	41.7	10.8	13.3
3	z	-72.13846154	-72	2437	65	AP-C2-4F-03	0	18	7.2	8.2	4	0	41.7	10.8	13.3
4	aw	-81.7037037	-81	2437	27	AP-C2-4F-03	8	56	10.8	11.8	4	0	41.7	10.8	13.3
4	av	-82.2	-83	2437	35	AP-C2-4F-03	6	56	10.8	11.8	4	0	41.7	10.8	13.3
4	au	-89.61111111	-90	5180	72	AP-C2-4F-03	4	56	10.8	11.8	4	0	41.7	10.8	13.3
4	au	-82.75	-82	2437	28	AP-C2-4F-03	4	56	10.8	11.8	4	0	41.7	10.8	13.3
4	at	-80.08333333	-80	5180	72	AP-C2-4F-03	2	56	10.8	11.8	4	0	41.7	10.8	13.3
4	at	-78.2745098	-78	2437	51	AP-C2-4F-03	2	56	10.8	11.8	4	0	41.7	10.8	13.3
4	as	-72	-72	5180	86	AP-C2-4F-03	0	56	10.8	11.8	4	0	41.7	10.8	13.3
4	as	-61.77906977	-62	2437	86	AP-C2-4F-03	0	56	10.8	11.8	4	0	41.7	10.8	13.3
4	ar	-77.44303797	-79	5180	79	AP-C2-4F-03	0	54	10.8	11.8	4	0	41.7	10.8	13.3
4	ar	-66.64516129	-66	2437	93	AP-C2-4F-03	0	54	10.8	11.8	4	0	41.7	10.8	13.3
4	aq	-75.56976744	-75	5180	86	AP-C2-4F-03	0	52	10.8	11.8	4	0	41.7	10.8	13.3
4	aq	-70.7311828	-70	2437	93	AP-C2-4F-03	0	52	10.8	11.8	4	0	41.7	10.8	13.3
4	ap	-73.48387097	-73	5180	93	AP-C2-4F-03	0	50	10.8	11.8	4	0	41.7	10.8	13.3
4	ap	-70.3655914	-71	2437	93	AP-C2-4F-03	0	50	10.8	11.8	4	0	41.7	10.8	13.3
4	ao	-69.12	-69	5180	100	AP-C2-4F-03	0	48	10.8	11.8	4	0	41.7	10.8	13.3
4	ao	-58.11	-58	2437	100	AP-C2-4F-03	0	48	10.8	11.8	4	0	41.7	10.8	13.3
4	an	-58.93	-59	5180	100	AP-C2-4F-03	0	46	10.8	11.8	4	0	41.7	10.8	13.3
4	an	-53.82	-54	2437	100	AP-C2-4F-03	0	46	10.8	11.8	4	0	41.7	10.8	13.3
4	am	-49.32	-49	5180	100	AP-C2-4F-03	0	44	10.8	11.8	4	0	41.7	10.8	13.3
4	am	-42.7	-43	2437	100	AP-C2-4F-03	0	44	10.8	11.8	4	0	41.7	10.8	13.3
4	al	-53.47	-54	5180	100	AP-C2-4F-03	0	42	10.8	11.8	4	0	41.7	10.8	13.3
4	z	-72.35	-72	5180	100	AP-C2-4F-03	0	18	10.8	11.8	4	0	41.7	10.8	13.3
4	z	-64.92307692	-64	2437	91	AP-C2-4F-03	0	18	10.8	11.8	4	0	41.7	10.8	13.3
4	y	-71.17	-71	5180	100	AP-C2-4F-03	0	16	10.8	11.8	4	0	41.7	10.8	13.3
4	y	-62.95454545	-62	2437	88	AP-C2-4F-03	0	16	10.8	11.8	4	0	41.7	10.8	13.3
4	x	-76.97297297	-77	5180	37	AP-C2-4F-03	0	14	10.8	11.8	4	0	41.7	10.8	13.3
4	x	-68.11111111	-68	2437	72	AP-C2-4F-03	0	14	10.8	11.8	4	0	41.7	10.8	13.3
4	w	-75.13953488	-75	5180	86	AP-C2-4F-03	0	12	10.8	11.8	4	0	41.7	10.8	13.3
4	w	-79	-78	2437	21	AP-C2-4F-03	0	12	10.8	11.8	4	0	41.7	10.8	13.3
4	v	-76.75	-77	5180	28	AP-C2-4F-03	0	10	10.8	11.8	4	0	41.7	10.8	13.3
4	v	-77	-77	2437	14	AP-C2-4F-03	0	10	10.8	11.8	4	0	41.7	10.8	13.3
4	u	-74.7311828	-74	5180	93	AP-C2-4F-03	0	8	10.8	11.8	4	0	41.7	10.8	13.3
4	u	-75.47222222	-76	2437	72	AP-C2-4F-03	0	8	10.8	11.8	4	0	41.7	10.8	13.3
4	t	-73.62365591	-73	5180	93	AP-C2-4F-03	0	6	10.8	11.8	4	0	41.7	10.8	13.3
4	t	-70.41666667	-70.5	2437	84	AP-C2-4F-03	0	6	10.8	11.8	4	0	41.7	10.8	13.3
4	s	-83.16129032	-84	5180	93	AP-C2-4F-03	0	4	10.8	11.8	4	0	41.7	10.8	13.3
4	s	-79.04615385	-80	2437	65	AP-C2-4F-03	0	4	10.8	11.8	4	0	41.7	10.8	13.3
4	r	-79.86666667	-82	2437	30	AP-C2-4F-03	0	2	10.8	11.8	4	0	41.7	10.8	13.3
4	q	-78	-77	2437	21	AP-C2-4F-03	0	0	10.8	11.8	4	0	41.7	10.8	13.3
4	p	-83.33333333	-83	2437	21	AP-C2-4F-03	2	0	10.8	11.8	4	0	41.7	10.8	13.3
4	o	-90.71428571	-91	5180	49	AP-C2-4F-03	4	0	10.8	11.8	4	0	41.7	10.8	13.3
4	m	-93	-93	5180	7	AP-C2-4F-03	8	0	10.8	11.8	4	0	41.7	10.8	13.3
3	af	-84.5	-85	2437	42	AP-C2-5F-01	0	30	7.2	8.2	5	0	22.3	14.4	16.9
3	ae	-79.8	-79	2437	35	AP-C2-5F-01	0	28	7.2	8.2	5	0	22.3	14.4	16.9
3	ad	-71.97727273	-72	2437	44	AP-C2-5F-01	0	26	7.2	8.2	5	0	22.3	14.4	16.9
3	ac	-81.8	-84	2437	35	AP-C2-5F-01	0	24	7.2	8.2	5	0	22.3	14.4	16.9
3	ab	-72.64864865	-74	2437	37	AP-C2-5F-01	0	22	7.2	8.2	5	0	22.3	14.4	16.9
3	aa	-73	-73	2437	35	AP-C2-5F-01	0	20	7.2	8.2	5	0	22.3	14.4	16.9
3	y	-72.97468354	-73	2437	79	AP-C2-5F-01	0	16	7.2	8.2	5	0	22.3	14.4	16.9
3	x	-76.01960784	-76	2437	51	AP-C2-5F-01	0	14	7.2	8.2	5	0	22.3	14.4	16.9
3	w	-75.74418605	-76	2437	43	AP-C2-5F-01	0	12	7.2	8.2	5	0	22.3	14.4	16.9
3	v	-82.56756757	-83	2437	37	AP-C2-5F-01	0	10	7.2	8.2	5	0	22.3	14.4	16.9
4	ak	-86	-86	2437	14	AP-C2-5F-01	0	40	10.8	11.8	5	0	22.3	14.4	16.9
4	aj	-84	-85	2437	21	AP-C2-5F-01	0	38	10.8	11.8	5	0	22.3	14.4	16.9
4	ai	-78	-78	2437	7	AP-C2-5F-01	0	36	10.8	11.8	5	0	22.3	14.4	16.9
4	ah	-90.83333333	-91	5180	42	AP-C2-5F-01	0	34	10.8	11.8	5	0	22.3	14.4	16.9
4	ag	-81.33333333	-80.5	2437	42	AP-C2-5F-01	0	32	10.8	11.8	5	0	22.3	14.4	16.9
4	af	-88	-88	5180	7	AP-C2-5F-01	0	30	10.8	11.8	5	0	22.3	14.4	16.9
4	af	-72.53333333	-73	2437	90	AP-C2-5F-01	0	30	10.8	11.8	5	0	22.3	14.4	16.9
4	ae	-66.74137931	-66	2437	58	AP-C2-5F-01	0	28	10.8	11.8	5	0	22.3	14.4	16.9
4	ad	-82.56896552	-83	5180	58	AP-C2-5F-01	0	26	10.8	11.8	5	0	22.3	14.4	16.9
4	ad	-62.27906977	-61	2437	86	AP-C2-5F-01	0	26	10.8	11.8	5	0	22.3	14.4	16.9
4	ac	-73.95348837	-74	5180	43	AP-C2-5F-01	0	24	10.8	11.8	5	0	22.3	14.4	16.9
4	ac	-62.63636364	-62	2437	77	AP-C2-5F-01	0	24	10.8	11.8	5	0	22.3	14.4	16.9
4	ab	-74.23529412	-74	5180	51	AP-C2-5F-01	0	22	10.8	11.8	5	0	22.3	14.4	16.9
4	ab	-64.36363636	-64	2437	77	AP-C2-5F-01	0	22	10.8	11.8	5	0	22.3	14.4	16.9
4	aa	-73.73417722	-74	2437	79	AP-C2-5F-01	0	20	10.8	11.8	5	0	22.3	14.4	16.9
3	z	-74.27586207	-75	2437	58	AP-C2-5F-01	0	18	7.2	8.2	5	0	22.3	14.4	16.9
4	as	-87.5	-87.5	2437	14	AP-C2-5F-01	0	56	10.8	11.8	5	0	22.3	14.4	16.9
4	aq	-85	-85	2437	7	AP-C2-5F-01	0	52	10.8	11.8	5	0	22.3	14.4	16.9
4	ao	-84	-84	2437	7	AP-C2-5F-01	0	48	10.8	11.8	5	0	22.3	14.4	16.9
4	z	-84.5	-84.5	5180	14	AP-C2-5F-01	0	18	10.8	11.8	5	0	22.3	14.4	16.9
4	z	-59.47	-59	2437	100	AP-C2-5F-01	0	18	10.8	11.8	5	0	22.3	14.4	16.9
4	y	-67.33	-68	2437	100	AP-C2-5F-01	0	16	10.8	11.8	5	0	22.3	14.4	16.9
4	x	-85.56756757	-86	5180	37	AP-C2-5F-01	0	14	10.8	11.8	5	0	22.3	14.4	16.9
4	x	-77.03797468	-77	2437	79	AP-C2-5F-01	0	14	10.8	11.8	5	0	22.3	14.4	16.9
4	w	-88	-88	5180	14	AP-C2-5F-01	0	12	10.8	11.8	5	0	22.3	14.4	16.9
4	w	-70.90909091	-70	2437	77	AP-C2-5F-01	0	12	10.8	11.8	5	0	22.3	14.4	16.9
4	v	-90.58823529	-91	5180	51	AP-C2-5F-01	0	10	10.8	11.8	5	0	22.3	14.4	16.9
4	v	-70.62962963	-71	2437	27	AP-C2-5F-01	0	10	10.8	11.8	5	0	22.3	14.4	16.9
4	u	-89.4	-90	5180	35	AP-C2-5F-01	0	8	10.8	11.8	5	0	22.3	14.4	16.9
4	u	-72.59139785	-72	2437	93	AP-C2-5F-01	0	8	10.8	11.8	5	0	22.3	14.4	16.9
4	t	-82.22222222	-82	2437	63	AP-C2-5F-01	0	6	10.8	11.8	5	0	22.3	14.4	16.9
4	s	-84.5	-86	2437	42	AP-C2-5F-01	0	4	10.8	11.8	5	0	22.3	14.4	16.9
4	r	-86	-86	2437	14	AP-C2-5F-01	0	2	10.8	11.8	5	0	22.3	14.4	16.9
3	am	-81.04545455	-81	2437	44	AP-C2-5F-02	0	44	7.2	8.2	5	0	30	14.4	16.9
3	ak	-82.75	-83	2437	28	AP-C2-5F-02	0	40	7.2	8.2	5	0	30	14.4	16.9
3	aj	-76.25	-77.5	2437	28	AP-C2-5F-02	0	38	7.2	8.2	5	0	30	14.4	16.9
3	ai	-79.51724138	-80	2437	58	AP-C2-5F-02	0	36	7.2	8.2	5	0	30	14.4	16.9
3	ah	-81	-82	2437	49	AP-C2-5F-02	0	34	7.2	8.2	5	0	30	14.4	16.9
3	ag	-76.33333333	-76	2437	21	AP-C2-5F-02	0	32	7.2	8.2	5	0	30	14.4	16.9
3	af	-77.27777778	-77	2437	36	AP-C2-5F-02	0	30	7.2	8.2	5	0	30	14.4	16.9
3	ae	-70.5	-70	2437	56	AP-C2-5F-02	0	28	7.2	8.2	5	0	30	14.4	16.9
3	ad	-75.04615385	-75	2437	65	AP-C2-5F-02	0	26	7.2	8.2	5	0	30	14.4	16.9
3	ac	-64.71428571	-65	2437	49	AP-C2-5F-02	0	24	7.2	8.2	5	0	30	14.4	16.9
3	ab	-80.75675676	-81	2437	37	AP-C2-5F-02	0	22	7.2	8.2	5	0	30	14.4	16.9
3	aa	-79.16216216	-79	2437	37	AP-C2-5F-02	0	20	7.2	8.2	5	0	30	14.4	16.9
3	y	-77	-77	2437	7	AP-C2-5F-02	0	16	7.2	8.2	5	0	30	14.4	16.9
3	x	-83.33333333	-83	2437	21	AP-C2-5F-02	0	14	7.2	8.2	5	0	30	14.4	16.9
3	w	-76.16666667	-77	2437	36	AP-C2-5F-02	0	12	7.2	8.2	5	0	30	14.4	16.9
3	u	-86	-86	2437	2	AP-C2-5F-02	0	8	7.2	8.2	5	0	30	14.4	16.9
4	al	-75.25862069	-74	2437	58	AP-C2-5F-02	0	42	10.8	11.8	5	0	30	14.4	16.9
4	ak	-77.69565217	-78	2437	23	AP-C2-5F-02	0	40	10.8	11.8	5	0	30	14.4	16.9
4	aj	-89.76666667	-90	5180	30	AP-C2-5F-02	0	38	10.8	11.8	5	0	30	14.4	16.9
4	aj	-79.875	-78.5	2437	56	AP-C2-5F-02	0	38	10.8	11.8	5	0	30	14.4	16.9
4	ai	-84.10126582	-83	5180	79	AP-C2-5F-02	0	36	10.8	11.8	5	0	30	14.4	16.9
4	ai	-67.20253165	-67	2437	79	AP-C2-5F-02	0	36	10.8	11.8	5	0	30	14.4	16.9
4	ah	-78.3255814	-78	5180	86	AP-C2-5F-02	0	34	10.8	11.8	5	0	30	14.4	16.9
4	ah	-64.90277778	-66	2437	72	AP-C2-5F-02	0	34	10.8	11.8	5	0	30	14.4	16.9
4	ag	-59.4	-59	2437	100	AP-C2-5F-02	0	32	10.8	11.8	5	0	30	14.4	16.9
4	af	-77.8	-78	5180	20	AP-C2-5F-02	0	30	10.8	11.8	5	0	30	14.4	16.9
4	af	-63.94623656	-64	2437	93	AP-C2-5F-02	0	30	10.8	11.8	5	0	30	14.4	16.9
4	ae	-62.53	-62	2437	100	AP-C2-5F-02	0	28	10.8	11.8	5	0	30	14.4	16.9
4	ad	-80.15384615	-80	5180	91	AP-C2-5F-02	0	26	10.8	11.8	5	0	30	14.4	16.9
4	ad	-63.21505376	-63	2437	93	AP-C2-5F-02	0	26	10.8	11.8	5	0	30	14.4	16.9
4	ac	-65.36363636	-65	2437	77	AP-C2-5F-02	0	24	10.8	11.8	5	0	30	14.4	16.9
4	ab	-81	-81	5180	77	AP-C2-5F-02	0	22	10.8	11.8	5	0	30	14.4	16.9
4	ab	-61.30232558	-60	2437	86	AP-C2-5F-02	0	22	10.8	11.8	5	0	30	14.4	16.9
4	aa	-71.49019608	-72	2437	51	AP-C2-5F-02	0	20	10.8	11.8	5	0	30	14.4	16.9
3	z	-82	-82	2437	7	AP-C2-5F-02	0	18	7.2	8.2	5	0	30	14.4	16.9
4	as	-92.33333333	-92	5180	21	AP-C2-5F-02	0	56	10.8	11.8	5	0	30	14.4	16.9
4	ap	-87	-87	2437	7	AP-C2-5F-02	0	50	10.8	11.8	5	0	30	14.4	16.9
4	an	-83.6	-85	2437	35	AP-C2-5F-02	0	46	10.8	11.8	5	0	30	14.4	16.9
4	am	-81.5	-81	2437	28	AP-C2-5F-02	0	44	10.8	11.8	5	0	30	14.4	16.9
4	al	-88	-88	5180	14	AP-C2-5F-02	0	42	10.8	11.8	5	0	30	14.4	16.9
4	z	-92	-92	5180	14	AP-C2-5F-02	0	18	10.8	11.8	5	0	30	14.4	16.9
4	z	-81.05882353	-81	2437	51	AP-C2-5F-02	0	18	10.8	11.8	5	0	30	14.4	16.9
4	y	-88.66666667	-89	5180	42	AP-C2-5F-02	0	16	10.8	11.8	5	0	30	14.4	16.9
4	y	-77.40740741	-77	2437	54	AP-C2-5F-02	0	16	10.8	11.8	5	0	30	14.4	16.9
4	x	-90.96078431	-91	5180	51	AP-C2-5F-02	0	14	10.8	11.8	5	0	30	14.4	16.9
4	x	-77.56818182	-78	2437	44	AP-C2-5F-02	0	14	10.8	11.8	5	0	30	14.4	16.9
4	w	-79.5	-79.5	2437	14	AP-C2-5F-02	0	12	10.8	11.8	5	0	30	14.4	16.9
4	v	-90.75	-90.5	5180	28	AP-C2-5F-02	0	10	10.8	11.8	5	0	30	14.4	16.9
4	v	-75.2173913	-75	2437	23	AP-C2-5F-02	0	10	10.8	11.8	5	0	30	14.4	16.9
4	u	-78.6	-78	2437	35	AP-C2-5F-02	0	8	10.8	11.8	5	0	30	14.4	16.9
4	t	-82.21568627	-82	2437	51	AP-C2-5F-02	0	6	10.8	11.8	5	0	30	14.4	16.9
4	s	-81.13636364	-81	2437	44	AP-C2-5F-02	0	4	10.8	11.8	5	0	30	14.4	16.9
3	am	-80.75	-81	2437	28	AP-C2-5F-03	0	44	7.2	8.2	5	0	41.7	14.4	16.9
3	al	-73.51388889	-74	2437	72	AP-C2-5F-03	0	42	7.2	8.2	5	0	41.7	14.4	16.9
3	ak	-69.98837209	-69	2437	86	AP-C2-5F-03	0	40	7.2	8.2	5	0	41.7	14.4	16.9
3	aj	-70.08139535	-70	2437	86	AP-C2-5F-03	0	38	7.2	8.2	5	0	41.7	14.4	16.9
3	ai	-76.6	-77	2437	35	AP-C2-5F-03	0	36	7.2	8.2	5	0	41.7	14.4	16.9
3	ah	-70.40909091	-71	2437	44	AP-C2-5F-03	0	34	7.2	8.2	5	0	41.7	14.4	16.9
3	ag	-75.22727273	-75	2437	44	AP-C2-5F-03	0	32	7.2	8.2	5	0	41.7	14.4	16.9
3	af	-81.22222222	-81	2437	63	AP-C2-5F-03	0	30	7.2	8.2	5	0	41.7	14.4	16.9
3	ae	-83.43333333	-84	2437	30	AP-C2-5F-03	0	28	7.2	8.2	5	0	41.7	14.4	16.9
3	ad	-86.41176471	-86	2437	51	AP-C2-5F-03	0	26	7.2	8.2	5	0	41.7	14.4	16.9
3	ac	-84	-83	2437	21	AP-C2-5F-03	0	24	7.2	8.2	5	0	41.7	14.4	16.9
3	ab	-86	-86	2437	7	AP-C2-5F-03	0	22	7.2	8.2	5	0	41.7	14.4	16.9
3	as	-86	-86	2437	7	AP-C2-5F-03	0	56	7.2	8.2	5	0	41.7	14.4	16.9
3	ap	-84.125	-85	2437	16	AP-C2-5F-03	0	50	7.2	8.2	5	0	41.7	14.4	16.9
3	an	-81.5	-82	2437	28	AP-C2-5F-03	0	46	7.2	8.2	5	0	41.7	14.4	16.9
4	al	-62.9	-62	2437	100	AP-C2-5F-03	0	42	10.8	11.8	5	0	41.7	14.4	16.9
4	ak	-73.23655914	-73	5180	93	AP-C2-5F-03	0	40	10.8	11.8	5	0	41.7	14.4	16.9
4	ak	-59.84	-61	2437	100	AP-C2-5F-03	0	40	10.8	11.8	5	0	41.7	14.4	16.9
4	aj	-75.12790698	-76	5180	86	AP-C2-5F-03	0	38	10.8	11.8	5	0	41.7	14.4	16.9
4	aj	-60.51	-61	2437	100	AP-C2-5F-03	0	38	10.8	11.8	5	0	41.7	14.4	16.9
4	ai	-79.52272727	-80	5180	44	AP-C2-5F-03	0	36	10.8	11.8	5	0	41.7	14.4	16.9
4	ai	-66.88172043	-67	2437	93	AP-C2-5F-03	0	36	10.8	11.8	5	0	41.7	14.4	16.9
4	ah	-82.33333333	-83	5180	21	AP-C2-5F-03	0	34	10.8	11.8	5	0	41.7	14.4	16.9
4	ah	-62.70886076	-63	2437	79	AP-C2-5F-03	0	34	10.8	11.8	5	0	41.7	14.4	16.9
4	ag	-69.72307692	-71	2437	65	AP-C2-5F-03	0	32	10.8	11.8	5	0	41.7	14.4	16.9
4	af	-70.9	-71	2437	70	AP-C2-5F-03	0	30	10.8	11.8	5	0	41.7	14.4	16.9
4	ae	-73.36206897	-73	2437	58	AP-C2-5F-03	0	28	10.8	11.8	5	0	41.7	14.4	16.9
4	ad	-83	-83	2437	9	AP-C2-5F-03	0	26	10.8	11.8	5	0	41.7	14.4	16.9
4	ac	-79	-79	2437	7	AP-C2-5F-03	0	24	10.8	11.8	5	0	41.7	14.4	16.9
4	ab	-85	-85	2437	7	AP-C2-5F-03	0	22	10.8	11.8	5	0	41.7	14.4	16.9
4	aa	-82.68627451	-82	2437	51	AP-C2-5F-03	0	20	10.8	11.8	5	0	41.7	14.4	16.9
4	at	-84.25	-84.5	2437	28	AP-C2-5F-03	2	56	10.8	11.8	5	0	41.7	14.4	16.9
4	as	-87.05405405	-87	5180	37	AP-C2-5F-03	0	56	10.8	11.8	5	0	41.7	14.4	16.9
4	as	-80.4	-82	2437	70	AP-C2-5F-03	0	56	10.8	11.8	5	0	41.7	14.4	16.9
4	ar	-84.33333333	-82	2437	21	AP-C2-5F-03	0	54	10.8	11.8	5	0	41.7	14.4	16.9
4	aq	-83	-83.5	2437	28	AP-C2-5F-03	0	52	10.8	11.8	5	0	41.7	14.4	16.9
4	ap	-90.66666667	-90	5180	21	AP-C2-5F-03	0	50	10.8	11.8	5	0	41.7	14.4	16.9
4	ap	-76.28846154	-75	2437	52	AP-C2-5F-03	0	50	10.8	11.8	5	0	41.7	14.4	16.9
4	ao	-87.33333333	-87	5180	42	AP-C2-5F-03	0	48	10.8	11.8	5	0	41.7	14.4	16.9
4	ao	-72.92405063	-74	2437	79	AP-C2-5F-03	0	48	10.8	11.8	5	0	41.7	14.4	16.9
4	an	-78.7311828	-79	5180	93	AP-C2-5F-03	0	46	10.8	11.8	5	0	41.7	14.4	16.9
4	an	-63.08	-62	2437	100	AP-C2-5F-03	0	46	10.8	11.8	5	0	41.7	14.4	16.9
4	am	-82.1827957	-83	5180	93	AP-C2-5F-03	0	44	10.8	11.8	5	0	41.7	14.4	16.9
4	am	-60.12	-60	2437	100	AP-C2-5F-03	0	44	10.8	11.8	5	0	41.7	14.4	16.9
4	al	-74.56976744	-74	5180	86	AP-C2-5F-03	0	42	10.8	11.8	5	0	41.7	14.4	16.9
4	z	-83	-83	2437	7	AP-C2-5F-03	0	18	10.8	11.8	5	0	41.7	14.4	16.9
3	ac	-86	-86	2437	7	AP-C2-6F-01	0	24	7.2	8.2	6	0	22.3	18	20.5
3	aa	-83.53846154	-84	2437	13	AP-C2-6F-01	0	20	7.2	8.2	6	0	22.3	18	20.5
3	y	-82.5	-82.5	2437	14	AP-C2-6F-01	0	16	7.2	8.2	6	0	22.3	18	20.5
3	x	-83	-83	2437	7	AP-C2-6F-01	0	14	7.2	8.2	6	0	22.3	18	20.5
4	ag	-87	-86	2437	21	AP-C2-6F-01	0	32	10.8	11.8	6	0	22.3	18	20.5
4	af	-81.55	-80	2437	20	AP-C2-6F-01	0	30	10.8	11.8	6	0	22.3	18	20.5
4	ae	-88	-88	2437	14	AP-C2-6F-01	0	28	10.8	11.8	6	0	22.3	18	20.5
4	ad	-76.08695652	-76	2437	23	AP-C2-6F-01	0	26	10.8	11.8	6	0	22.3	18	20.5
4	ac	-80.5	-80.5	2437	14	AP-C2-6F-01	0	24	10.8	11.8	6	0	22.3	18	20.5
4	ab	-82.87096774	-83	5180	93	AP-C2-6F-01	0	22	10.8	11.8	6	0	22.3	18	20.5
4	ab	-78.22222222	-78	2437	63	AP-C2-6F-01	0	22	10.8	11.8	6	0	22.3	18	20.5
4	aa	-78.47692308	-79	2437	65	AP-C2-6F-01	0	20	10.8	11.8	6	0	22.3	18	20.5
3	z	-83	-83	2437	7	AP-C2-6F-01	0	18	7.2	8.2	6	0	22.3	18	20.5
4	z	-76.85714286	-78	2437	49	AP-C2-6F-01	0	18	10.8	11.8	6	0	22.3	18	20.5
4	y	-71.34177215	-71	2437	79	AP-C2-6F-01	0	16	10.8	11.8	6	0	22.3	18	20.5
4	x	-81.625	-81	2437	8	AP-C2-6F-01	0	14	10.8	11.8	6	0	22.3	18	20.5
4	w	-80	-80	2437	7	AP-C2-6F-01	0	12	10.8	11.8	6	0	22.3	18	20.5
4	t	-84.5	-84.5	2437	14	AP-C2-6F-01	0	6	10.8	11.8	6	0	22.3	18	20.5
3	ai	-86.25	-86.5	2437	28	AP-C2-6F-02	0	36	7.2	8.2	6	0	30	18	20.5
3	af	-87.68181818	-88	2437	22	AP-C2-6F-02	0	30	7.2	8.2	6	0	30	18	20.5
3	ae	-88	-88	2437	7	AP-C2-6F-02	0	28	7.2	8.2	6	0	30	18	20.5
3	ac	-84.33333333	-84	2437	21	AP-C2-6F-02	0	24	7.2	8.2	6	0	30	18	20.5
4	al	-86.5	-86.5	2437	14	AP-C2-6F-02	0	42	10.8	11.8	6	0	30	18	20.5
4	ak	-81.91304348	-81	2437	23	AP-C2-6F-02	0	40	10.8	11.8	6	0	30	18	20.5
4	aj	-81.33333333	-80	2437	21	AP-C2-6F-02	0	38	10.8	11.8	6	0	30	18	20.5
4	ah	-75.5	-75.5	2437	14	AP-C2-6F-02	0	34	10.8	11.8	6	0	30	18	20.5
4	ag	-75.8	-75	2437	70	AP-C2-6F-02	0	32	10.8	11.8	6	0	30	18	20.5
4	af	-75.75	-75	2437	48	AP-C2-6F-02	0	30	10.8	11.8	6	0	30	18	20.5
4	ae	-80.25	-80.5	2437	28	AP-C2-6F-02	0	28	10.8	11.8	6	0	30	18	20.5
4	ad	-91.46666667	-91	5180	30	AP-C2-6F-02	0	26	10.8	11.8	6	0	30	18	20.5
4	ad	-82.375	-83	2437	16	AP-C2-6F-02	0	26	10.8	11.8	6	0	30	18	20.5
4	ab	-83	-83	2437	7	AP-C2-6F-02	0	22	10.8	11.8	6	0	30	18	20.5
4	aa	-79.9	-80	2437	30	AP-C2-6F-02	0	20	10.8	11.8	6	0	30	18	20.5
4	z	-85	-85	2437	7	AP-C2-6F-02	0	18	10.8	11.8	6	0	30	18	20.5
4	y	-83.5	-83.5	2437	28	AP-C2-6F-02	0	16	10.8	11.8	6	0	30	18	20.5
3	am	-87	-87	2437	28	AP-C2-6F-03	0	44	7.2	8.2	6	0	41.2	18	20.5
3	aj	-81.5	-81.5	2437	14	AP-C2-6F-03	0	38	7.2	8.2	6	0	41.2	18	20.5
3	ai	-86.75	-86.5	2437	28	AP-C2-6F-03	0	36	7.2	8.2	6	0	41.2	18	20.5
3	ag	-86	-86	2437	7	AP-C2-6F-03	0	32	7.2	8.2	6	0	41.2	18	20.5
4	al	-72.01538462	-71	2437	65	AP-C2-6F-03	0	42	10.8	11.8	6	0	41.2	18	20.5
4	ak	-81.5	-81	2437	28	AP-C2-6F-03	0	40	10.8	11.8	6	0	41.2	18	20.5
4	aj	-83.5	-83.5	2437	14	AP-C2-6F-03	0	38	10.8	11.8	6	0	41.2	18	20.5
4	ai	-77.2	-77	2437	35	AP-C2-6F-03	0	36	10.8	11.8	6	0	41.2	18	20.5
4	ah	-79	-79	2437	14	AP-C2-6F-03	0	34	10.8	11.8	6	0	41.2	18	20.5
4	ag	-77.6	-78	2437	35	AP-C2-6F-03	0	32	10.8	11.8	6	0	41.2	18	20.5
4	af	-80	-80	2437	14	AP-C2-6F-03	0	30	10.8	11.8	6	0	41.2	18	20.5
4	ae	-85.33333333	-85	2437	21	AP-C2-6F-03	0	28	10.8	11.8	6	0	41.2	18	20.5
4	ad	-85	-85	2437	7	AP-C2-6F-03	0	26	10.8	11.8	6	0	41.2	18	20.5
4	ac	-81.5	-81.5	2437	14	AP-C2-6F-03	0	24	10.8	11.8	6	0	41.2	18	20.5
4	as	-89	-89	2437	7	AP-C2-6F-03	0	56	10.8	11.8	6	0	41.2	18	20.5
4	ap	-86	-86	2437	7	AP-C2-6F-03	0	50	10.8	11.8	6	0	41.2	18	20.5
4	ao	-88	-88	2437	7	AP-C2-6F-03	0	48	10.8	11.8	6	0	41.2	18	20.5
4	an	-79.5	-79.5	2437	14	AP-C2-6F-03	0	46	10.8	11.8	6	0	41.2	18	20.5
4	am	-92.5	-92.5	5180	14	AP-C2-6F-03	0	44	10.8	11.8	6	0	41.2	18	20.5
4	am	-73.09090909	-73	2437	77	AP-C2-6F-03	0	44	10.8	11.8	6	0	41.2	18	20.5
4	al	-90.75	-90.5	5180	28	AP-C2-6F-03	0	42	10.8	11.8	6	0	41.2	18	20.5
3	az	-87	-87	2437	7	AP-C3-1F-01	14	56	7.2	8.2	1	25.8	56	0	2.5
3	ay	-85.5	-85.5	2437	14	AP-C3-1F-01	12	56	7.2	8.2	1	25.8	56	0	2.5
3	ax	-83	-83	2437	14	AP-C3-1F-01	10	56	7.2	8.2	1	25.8	56	0	2.5
3	aw	-85.5	-85.5	2437	14	AP-C3-1F-01	8	56	7.2	8.2	1	25.8	56	0	2.5
3	bg	-72.33333333	-73	2437	42	AP-C3-1F-01	28	56	7.2	8.2	1	25.8	56	0	2.5
3	bf	-73.49019608	-73	2437	51	AP-C3-1F-01	26	56	7.2	8.2	1	25.8	56	0	2.5
3	be	-91.09090909	-91	5180	55	AP-C3-1F-01	24	56	7.2	8.2	1	25.8	56	0	2.5
3	bd	-78.47727273	-78	2437	44	AP-C3-1F-01	22	56	7.2	8.2	1	25.8	56	0	2.5
3	bc	-77	-77	2437	35	AP-C3-1F-01	20	56	7.2	8.2	1	25.8	56	0	2.5
3	bb	-76.41666667	-76	2437	12	AP-C3-1F-01	18	56	7.2	8.2	1	25.8	56	0	2.5
3	ba	-79.47826087	-79	2437	23	AP-C3-1F-01	16	56	7.2	8.2	1	25.8	56	0	2.5
4	bd	-86.81081081	-87	2437	37	AP-C3-1F-01	22	56	10.8	11.8	1	25.8	56	0	2.5
4	bc	-84.75	-84.5	2437	28	AP-C3-1F-01	20	56	10.8	11.8	1	25.8	56	0	2.5
3	az	-77	-78	2437	21	AP-C3-1F-02	14	56	7.2	8.2	1	12.9	56	0	2.5
3	ay	-90	-89	5180	37	AP-C3-1F-02	12	56	7.2	8.2	1	12.9	56	0	2.5
3	ay	-69.77586207	-71	2437	58	AP-C3-1F-02	12	56	7.2	8.2	1	12.9	56	0	2.5
3	ax	-89.58823529	-89	5180	51	AP-C3-1F-02	10	56	7.2	8.2	1	12.9	56	0	2.5
3	ax	-72.49230769	-72	2437	65	AP-C3-1F-02	10	56	7.2	8.2	1	12.9	56	0	2.5
3	aw	-90.42857143	-90	5180	49	AP-C3-1F-02	8	56	7.2	8.2	1	12.9	56	0	2.5
3	aw	-78	-78	2437	14	AP-C3-1F-02	8	56	7.2	8.2	1	12.9	56	0	2.5
3	av	-66.66666667	-66	2437	63	AP-C3-1F-02	6	56	7.2	8.2	1	12.9	56	0	2.5
3	au	-76	-76	2437	14	AP-C3-1F-02	4	56	7.2	8.2	1	12.9	56	0	2.5
3	at	-82	-82	2437	14	AP-C3-1F-02	2	56	7.2	8.2	1	12.9	56	0	2.5
3	as	-78.6	-79	2437	35	AP-C3-1F-02	0	56	7.2	8.2	1	12.9	56	0	2.5
3	ar	-86.5	-86.5	2437	14	AP-C3-1F-02	0	54	7.2	8.2	1	12.9	56	0	2.5
3	bc	-81	-81	2437	14	AP-C3-1F-02	20	56	7.2	8.2	1	12.9	56	0	2.5
3	bb	-80.57692308	-80	2437	26	AP-C3-1F-02	18	56	7.2	8.2	1	12.9	56	0	2.5
3	ba	-74.61363636	-74	2437	44	AP-C3-1F-02	16	56	7.2	8.2	1	12.9	56	0	2.5
4	az	-81	-81	2437	7	AP-C3-1F-02	14	56	10.8	11.8	1	12.9	56	0	2.5
4	ay	-81	-80.5	2437	28	AP-C3-1F-02	12	56	10.8	11.8	1	12.9	56	0	2.5
4	ax	-85	-85	2437	14	AP-C3-1F-02	10	56	10.8	11.8	1	12.9	56	0	2.5
4	aw	-86.5	-86.5	2437	14	AP-C3-1F-02	8	56	10.8	11.8	1	12.9	56	0	2.5
4	av	-86	-86	2437	42	AP-C3-1F-02	6	56	10.8	11.8	1	12.9	56	0	2.5
3	az	-87.41666667	-87	5180	72	AP-C3-2F-01	14	56	7.2	8.2	2	25.9	56	3.6	6.1
3	az	-67.11827957	-67	2437	93	AP-C3-2F-01	14	56	7.2	8.2	2	25.9	56	3.6	6.1
3	ay	-86.22222222	-86	5180	63	AP-C3-2F-01	12	56	7.2	8.2	2	25.9	56	3.6	6.1
3	ay	-75.12790698	-75	2437	86	AP-C3-2F-01	12	56	7.2	8.2	2	25.9	56	3.6	6.1
3	ax	-77.34722222	-78	2437	72	AP-C3-2F-01	10	56	7.2	8.2	2	25.9	56	3.6	6.1
3	aw	-89.79310345	-90	5180	58	AP-C3-2F-01	8	56	7.2	8.2	2	25.9	56	3.6	6.1
3	aw	-77.375	-77.5	2437	56	AP-C3-2F-01	8	56	7.2	8.2	2	25.9	56	3.6	6.1
3	av	-89	-89	5180	2	AP-C3-2F-01	6	56	7.2	8.2	2	25.9	56	3.6	6.1
3	av	-73.5	-73.5	2437	56	AP-C3-2F-01	6	56	7.2	8.2	2	25.9	56	3.6	6.1
3	au	-77.5	-78	2437	42	AP-C3-2F-01	4	56	7.2	8.2	2	25.9	56	3.6	6.1
3	at	-71.05882353	-71	2437	51	AP-C3-2F-01	2	56	7.2	8.2	2	25.9	56	3.6	6.1
3	as	-78.5	-78.5	2437	14	AP-C3-2F-01	0	56	7.2	8.2	2	25.9	56	3.6	6.1
3	bg	-75.57142857	-76	5180	98	AP-C3-2F-01	28	56	7.2	8.2	2	25.9	56	3.6	6.1
3	bg	-52.26	-52	2437	100	AP-C3-2F-01	28	56	7.2	8.2	2	25.9	56	3.6	6.1
3	bf	-72.8	-73	5180	100	AP-C3-2F-01	26	56	7.2	8.2	2	25.9	56	3.6	6.1
3	bf	-56.32258065	-56	2437	93	AP-C3-2F-01	26	56	7.2	8.2	2	25.9	56	3.6	6.1
3	be	-69.77	-69	5180	100	AP-C3-2F-01	24	56	7.2	8.2	2	25.9	56	3.6	6.1
3	be	-60.59	-61	2437	100	AP-C3-2F-01	24	56	7.2	8.2	2	25.9	56	3.6	6.1
3	bd	-78.23611111	-78	5180	72	AP-C3-2F-01	22	56	7.2	8.2	2	25.9	56	3.6	6.1
3	bd	-56.4	-56	2437	100	AP-C3-2F-01	22	56	7.2	8.2	2	25.9	56	3.6	6.1
3	bc	-79.70689655	-80	5180	58	AP-C3-2F-01	20	56	7.2	8.2	2	25.9	56	3.6	6.1
3	bc	-59.88	-60	2437	100	AP-C3-2F-01	20	56	7.2	8.2	2	25.9	56	3.6	6.1
3	bb	-78.06818182	-78	5180	88	AP-C3-2F-01	18	56	7.2	8.2	2	25.9	56	3.6	6.1
3	bb	-57.92	-58	2437	100	AP-C3-2F-01	18	56	7.2	8.2	2	25.9	56	3.6	6.1
3	ba	-81.31034483	-81	5180	58	AP-C3-2F-01	16	56	7.2	8.2	2	25.9	56	3.6	6.1
3	ba	-71.40506329	-72	2437	79	AP-C3-2F-01	16	56	7.2	8.2	2	25.9	56	3.6	6.1
4	az	-82.375	-82	2437	56	AP-C3-2F-01	14	56	10.8	11.8	2	25.9	56	3.6	6.1
4	ay	-85	-85	2437	7	AP-C3-2F-01	12	56	10.8	11.8	2	25.9	56	3.6	6.1
4	ax	-83.4	-82	2437	30	AP-C3-2F-01	10	56	10.8	11.8	2	25.9	56	3.6	6.1
4	aw	-83	-83	2437	21	AP-C3-2F-01	8	56	10.8	11.8	2	25.9	56	3.6	6.1
4	bg	-90.1	-89	5180	70	AP-C3-2F-01	28	56	10.8	11.8	2	25.9	56	3.6	6.1
4	bg	-73.0862069	-73	2437	58	AP-C3-2F-01	28	56	10.8	11.8	2	25.9	56	3.6	6.1
4	bf	-70.13953488	-70	2437	86	AP-C3-2F-01	26	56	10.8	11.8	2	25.9	56	3.6	6.1
4	be	-89.81818182	-90	5180	77	AP-C3-2F-01	24	56	10.8	11.8	2	25.9	56	3.6	6.1
4	be	-75.97468354	-75	2437	79	AP-C3-2F-01	24	56	10.8	11.8	2	25.9	56	3.6	6.1
4	bd	-89	-89	5180	63	AP-C3-2F-01	22	56	10.8	11.8	2	25.9	56	3.6	6.1
4	bd	-71.27848101	-70	2437	79	AP-C3-2F-01	22	56	10.8	11.8	2	25.9	56	3.6	6.1
4	bc	-91	-91	5180	56	AP-C3-2F-01	20	56	10.8	11.8	2	25.9	56	3.6	6.1
4	bc	-73	-74	2437	72	AP-C3-2F-01	20	56	10.8	11.8	2	25.9	56	3.6	6.1
4	bb	-91.5	-91.5	5180	14	AP-C3-2F-01	18	56	10.8	11.8	2	25.9	56	3.6	6.1
4	bb	-82.85714286	-84	2437	49	AP-C3-2F-01	18	56	10.8	11.8	2	25.9	56	3.6	6.1
4	ba	-83.5	-83.5	2437	42	AP-C3-2F-01	16	56	10.8	11.8	2	25.9	56	3.6	6.1
3	az	-70.97468354	-71	5180	79	AP-C3-2F-02	14	56	7.2	8.2	2	15.2	56	3.6	6.1
3	az	-55.3655914	-55	2437	93	AP-C3-2F-02	14	56	7.2	8.2	2	15.2	56	3.6	6.1
3	ay	-77.83333333	-78	5180	72	AP-C3-2F-02	12	56	7.2	8.2	2	15.2	56	3.6	6.1
3	ay	-53.35	-53	2437	100	AP-C3-2F-02	12	56	7.2	8.2	2	15.2	56	3.6	6.1
3	ax	-81.05555556	-81	5180	72	AP-C3-2F-02	10	56	7.2	8.2	2	15.2	56	3.6	6.1
3	ax	-66.38	-67	2437	100	AP-C3-2F-02	10	56	7.2	8.2	2	15.2	56	3.6	6.1
3	aw	-81.53488372	-81	5180	86	AP-C3-2F-02	8	56	7.2	8.2	2	15.2	56	3.6	6.1
3	aw	-73	-73	2437	100	AP-C3-2F-02	8	56	7.2	8.2	2	15.2	56	3.6	6.1
3	av	-84.39655172	-85	5180	58	AP-C3-2F-02	6	56	7.2	8.2	2	15.2	56	3.6	6.1
3	av	-63.15053763	-63	2437	93	AP-C3-2F-02	6	56	7.2	8.2	2	15.2	56	3.6	6.1
3	au	-92	-92	5180	7	AP-C3-2F-02	4	56	7.2	8.2	2	15.2	56	3.6	6.1
3	au	-75.42	-75	2437	50	AP-C3-2F-02	4	56	7.2	8.2	2	15.2	56	3.6	6.1
3	at	-91	-91	5180	3	AP-C3-2F-02	2	56	7.2	8.2	2	15.2	56	3.6	6.1
3	at	-74.39130435	-75	2437	69	AP-C3-2F-02	2	56	7.2	8.2	2	15.2	56	3.6	6.1
3	as	-71.17241379	-71	2437	58	AP-C3-2F-02	0	56	7.2	8.2	2	15.2	56	3.6	6.1
3	aq	-86.4375	-86	2437	16	AP-C3-2F-02	0	52	7.2	8.2	2	15.2	56	3.6	6.1
3	bg	-90.4	-91	5180	35	AP-C3-2F-02	28	56	7.2	8.2	2	15.2	56	3.6	6.1
3	bg	-79.55555556	-80	2437	63	AP-C3-2F-02	28	56	7.2	8.2	2	15.2	56	3.6	6.1
3	bf	-92.5	-92.5	5180	14	AP-C3-2F-02	26	56	7.2	8.2	2	15.2	56	3.6	6.1
3	bf	-68.12903226	-68	2437	93	AP-C3-2F-02	26	56	7.2	8.2	2	15.2	56	3.6	6.1
3	be	-90.10526316	-91	5180	38	AP-C3-2F-02	24	56	7.2	8.2	2	15.2	56	3.6	6.1
3	be	-75.80821918	-76	2437	73	AP-C3-2F-02	24	56	7.2	8.2	2	15.2	56	3.6	6.1
3	bd	-87.45098039	-87	5180	51	AP-C3-2F-02	22	56	7.2	8.2	2	15.2	56	3.6	6.1
3	bd	-73.73611111	-75	2437	72	AP-C3-2F-02	22	56	7.2	8.2	2	15.2	56	3.6	6.1
3	bc	-81.40860215	-81	5180	93	AP-C3-2F-02	20	56	7.2	8.2	2	15.2	56	3.6	6.1
3	bc	-70.1372549	-70	2437	51	AP-C3-2F-02	20	56	7.2	8.2	2	15.2	56	3.6	6.1
3	bb	-78.68918919	-79	5180	74	AP-C3-2F-02	18	56	7.2	8.2	2	15.2	56	3.6	6.1
3	bb	-60.52688172	-60	2437	93	AP-C3-2F-02	18	56	7.2	8.2	2	15.2	56	3.6	6.1
3	ba	-71.20430108	-71	5180	93	AP-C3-2F-02	16	56	7.2	8.2	2	15.2	56	3.6	6.1
3	ba	-56.64516129	-57	2437	93	AP-C3-2F-02	16	56	7.2	8.2	2	15.2	56	3.6	6.1
4	az	-79.34408602	-79	2437	93	AP-C3-2F-02	14	56	10.8	11.8	2	15.2	56	3.6	6.1
4	ay	-78.75	-78	2437	56	AP-C3-2F-02	12	56	10.8	11.8	2	15.2	56	3.6	6.1
4	ax	-84.5	-84	2437	30	AP-C3-2F-02	10	56	10.8	11.8	2	15.2	56	3.6	6.1
4	aw	-84.25	-85	2437	28	AP-C3-2F-02	8	56	10.8	11.8	2	15.2	56	3.6	6.1
4	av	-83.15384615	-83	2437	65	AP-C3-2F-02	6	56	10.8	11.8	2	15.2	56	3.6	6.1
4	au	-83.16666667	-82.5	2437	42	AP-C3-2F-02	4	56	10.8	11.8	2	15.2	56	3.6	6.1
4	bf	-85.5	-85.5	2437	14	AP-C3-2F-02	26	56	10.8	11.8	2	15.2	56	3.6	6.1
4	be	-85.43478261	-86	2437	23	AP-C3-2F-02	24	56	10.8	11.8	2	15.2	56	3.6	6.1
4	bd	-81	-81	2437	49	AP-C3-2F-02	22	56	10.8	11.8	2	15.2	56	3.6	6.1
4	bc	-80.56962025	-81	2437	79	AP-C3-2F-02	20	56	10.8	11.8	2	15.2	56	3.6	6.1
4	bb	-77.81034483	-77	2437	58	AP-C3-2F-02	18	56	10.8	11.8	2	15.2	56	3.6	6.1
4	ba	-89.16666667	-89	5180	42	AP-C3-2F-02	16	56	10.8	11.8	2	15.2	56	3.6	6.1
4	ba	-77.44444444	-76	2437	63	AP-C3-2F-02	16	56	10.8	11.8	2	15.2	56	3.6	6.1
3	am	-80	-80	2437	56	AP-C3-2F-03	0	44	7.2	8.2	2	4	56	3.6	6.1
3	ak	-81.83783784	-82	2437	37	AP-C3-2F-03	0	40	7.2	8.2	2	4	56	3.6	6.1
3	ai	-86	-86	2437	7	AP-C3-2F-03	0	36	7.2	8.2	2	4	56	3.6	6.1
3	af	-86.75	-87	2437	8	AP-C3-2F-03	0	30	7.2	8.2	2	4	56	3.6	6.1
3	az	-93	-93	5180	7	AP-C3-2F-03	14	56	7.2	8.2	2	4	56	3.6	6.1
3	az	-75.91304348	-78	2437	23	AP-C3-2F-03	14	56	7.2	8.2	2	4	56	3.6	6.1
3	ay	-89	-89	5180	7	AP-C3-2F-03	12	56	7.2	8.2	2	4	56	3.6	6.1
3	ay	-69.13	-70	2437	100	AP-C3-2F-03	12	56	7.2	8.2	2	4	56	3.6	6.1
3	ax	-90	-90	5180	42	AP-C3-2F-03	10	56	7.2	8.2	2	4	56	3.6	6.1
3	ax	-68.52777778	-68	2437	72	AP-C3-2F-03	10	56	7.2	8.2	2	4	56	3.6	6.1
3	aw	-88.51724138	-89	5180	58	AP-C3-2F-03	8	56	7.2	8.2	2	4	56	3.6	6.1
3	aw	-61.05	-60	2437	100	AP-C3-2F-03	8	56	7.2	8.2	2	4	56	3.6	6.1
3	av	-74	-74	5180	77	AP-C3-2F-03	6	56	7.2	8.2	2	4	56	3.6	6.1
3	av	-57.64516129	-57	2437	93	AP-C3-2F-03	6	56	7.2	8.2	2	4	56	3.6	6.1
3	au	-65.61	-65	5180	100	AP-C3-2F-03	4	56	7.2	8.2	2	4	56	3.6	6.1
3	au	-43.83	-44	2437	100	AP-C3-2F-03	4	56	7.2	8.2	2	4	56	3.6	6.1
3	at	-74.75342466	-74	5180	73	AP-C3-2F-03	2	56	7.2	8.2	2	4	56	3.6	6.1
3	at	-50.21	-50	2437	100	AP-C3-2F-03	2	56	7.2	8.2	2	4	56	3.6	6.1
3	as	-81.5	-81	5180	56	AP-C3-2F-03	0	56	7.2	8.2	2	4	56	3.6	6.1
3	as	-57.67	-58	2437	100	AP-C3-2F-03	0	56	7.2	8.2	2	4	56	3.6	6.1
3	ar	-86.75268817	-87	5180	93	AP-C3-2F-03	0	54	7.2	8.2	2	4	56	3.6	6.1
3	ar	-66.93	-67	2437	100	AP-C3-2F-03	0	54	7.2	8.2	2	4	56	3.6	6.1
3	aq	-87.13924051	-87	5180	79	AP-C3-2F-03	0	52	7.2	8.2	2	4	56	3.6	6.1
3	aq	-67.84	-67	2437	100	AP-C3-2F-03	0	52	7.2	8.2	2	4	56	3.6	6.1
3	ap	-66.69892473	-67	2437	93	AP-C3-2F-03	0	50	7.2	8.2	2	4	56	3.6	6.1
3	ao	-83.54901961	-84	2437	51	AP-C3-2F-03	0	48	7.2	8.2	2	4	56	3.6	6.1
3	an	-82.11111111	-82	2437	63	AP-C3-2F-03	0	46	7.2	8.2	2	4	56	3.6	6.1
3	bg	-80.75	-81	2437	28	AP-C3-2F-03	28	56	7.2	8.2	2	4	56	3.6	6.1
3	bd	-80.53333333	-81	2437	30	AP-C3-2F-03	22	56	7.2	8.2	2	4	56	3.6	6.1
3	bc	-85	-85	2437	7	AP-C3-2F-03	20	56	7.2	8.2	2	4	56	3.6	6.1
3	bb	-86	-86	2437	7	AP-C3-2F-03	18	56	7.2	8.2	2	4	56	3.6	6.1
3	ba	-81.33333333	-82	2437	21	AP-C3-2F-03	16	56	7.2	8.2	2	4	56	3.6	6.1
4	az	-89	-89	2437	7	AP-C3-2F-03	14	56	10.8	11.8	2	4	56	3.6	6.1
4	ay	-84	-84	2437	7	AP-C3-2F-03	12	56	10.8	11.8	2	4	56	3.6	6.1
4	ax	-80.25	-80	2437	56	AP-C3-2F-03	10	56	10.8	11.8	2	4	56	3.6	6.1
4	aw	-82.13333333	-80	2437	30	AP-C3-2F-03	8	56	10.8	11.8	2	4	56	3.6	6.1
4	av	-81.04545455	-82	2437	44	AP-C3-2F-03	6	56	10.8	11.8	2	4	56	3.6	6.1
4	au	-93	-93	5180	7	AP-C3-2F-03	4	56	10.8	11.8	2	4	56	3.6	6.1
4	au	-78.44444444	-78	2437	63	AP-C3-2F-03	4	56	10.8	11.8	2	4	56	3.6	6.1
4	at	-69.88888889	-69	2437	63	AP-C3-2F-03	2	56	10.8	11.8	2	4	56	3.6	6.1
4	ar	-76	-76	2437	35	AP-C3-2F-03	0	54	10.8	11.8	2	4	56	3.6	6.1
4	aq	-80.25	-80	2437	28	AP-C3-2F-03	0	52	10.8	11.8	2	4	56	3.6	6.1
4	ap	-85.5	-85.5	2437	28	AP-C3-2F-03	0	50	10.8	11.8	2	4	56	3.6	6.1
4	ba	-86.33333333	-86	2437	21	AP-C3-2F-03	16	56	10.8	11.8	2	4	56	3.6	6.1
3	am	-86	-86	2437	7	AP-C3-3F-01	0	44	7.2	8.2	3	25.7	56	7.2	9.7
3	al	-87.48101266	-87	5180	79	AP-C3-3F-01	0	42	7.2	8.2	3	25.7	56	7.2	9.7
3	al	-85	-84	2437	35	AP-C3-3F-01	0	42	7.2	8.2	3	25.7	56	7.2	9.7
3	ai	-85.66666667	-86	2437	21	AP-C3-3F-01	0	36	7.2	8.2	3	25.7	56	7.2	9.7
3	ah	-87.375	-87	2437	16	AP-C3-3F-01	0	34	7.2	8.2	3	25.7	56	7.2	9.7
3	ag	-86.66666667	-87	2437	21	AP-C3-3F-01	0	32	7.2	8.2	3	25.7	56	7.2	9.7
3	af	-85.18	-86	2437	50	AP-C3-3F-01	0	30	7.2	8.2	3	25.7	56	7.2	9.7
3	az	-70.82	-71	5180	100	AP-C3-3F-01	14	56	7.2	8.2	3	25.7	56	7.2	9.7
3	az	-54.54	-55	2437	100	AP-C3-3F-01	14	56	7.2	8.2	3	25.7	56	7.2	9.7
3	ay	-69.33	-69	5180	100	AP-C3-3F-01	12	56	7.2	8.2	3	25.7	56	7.2	9.7
3	ay	-59.12	-59	2437	100	AP-C3-3F-01	12	56	7.2	8.2	3	25.7	56	7.2	9.7
3	ax	-72.06451613	-71	5180	93	AP-C3-3F-01	10	56	7.2	8.2	3	25.7	56	7.2	9.7
3	ax	-64.88	-65	2437	100	AP-C3-3F-01	10	56	7.2	8.2	3	25.7	56	7.2	9.7
3	aw	-72.05813953	-71	5180	86	AP-C3-3F-01	8	56	7.2	8.2	3	25.7	56	7.2	9.7
3	aw	-60.64285714	-60	2437	98	AP-C3-3F-01	8	56	7.2	8.2	3	25.7	56	7.2	9.7
3	av	-69.52	-70	5180	100	AP-C3-3F-01	6	56	7.2	8.2	3	25.7	56	7.2	9.7
3	av	-62.56	-62	2437	100	AP-C3-3F-01	6	56	7.2	8.2	3	25.7	56	7.2	9.7
3	au	-73.42307692	-73	5180	78	AP-C3-3F-01	4	56	7.2	8.2	3	25.7	56	7.2	9.7
3	au	-70.29487179	-70	2437	78	AP-C3-3F-01	4	56	7.2	8.2	3	25.7	56	7.2	9.7
3	at	-74.52325581	-73	5180	86	AP-C3-3F-01	2	56	7.2	8.2	3	25.7	56	7.2	9.7
3	at	-61.88172043	-62	2437	93	AP-C3-3F-01	2	56	7.2	8.2	3	25.7	56	7.2	9.7
3	as	-72.72727273	-72	5180	77	AP-C3-3F-01	0	56	7.2	8.2	3	25.7	56	7.2	9.7
3	as	-67.46236559	-68	2437	93	AP-C3-3F-01	0	56	7.2	8.2	3	25.7	56	7.2	9.7
3	ar	-84.72727273	-86	5180	77	AP-C3-3F-01	0	54	7.2	8.2	3	25.7	56	7.2	9.7
3	ar	-79.27586207	-80	2437	58	AP-C3-3F-01	0	54	7.2	8.2	3	25.7	56	7.2	9.7
3	aq	-82.94936709	-82	5180	79	AP-C3-3F-01	0	52	7.2	8.2	3	25.7	56	7.2	9.7
3	aq	-71.92307692	-72	2437	91	AP-C3-3F-01	0	52	7.2	8.2	3	25.7	56	7.2	9.7
3	ap	-89.91304348	-91	5180	23	AP-C3-3F-01	0	50	7.2	8.2	3	25.7	56	7.2	9.7
3	ap	-81.16666667	-80	2437	42	AP-C3-3F-01	0	50	7.2	8.2	3	25.7	56	7.2	9.7
3	ao	-85.83544304	-86	5180	79	AP-C3-3F-01	0	48	7.2	8.2	3	25.7	56	7.2	9.7
3	ao	-81	-81	2437	28	AP-C3-3F-01	0	48	7.2	8.2	3	25.7	56	7.2	9.7
3	an	-78.14285714	-78	2437	49	AP-C3-3F-01	0	46	7.2	8.2	3	25.7	56	7.2	9.7
3	bg	-61	-61	5180	100	AP-C3-3F-01	28	56	7.2	8.2	3	25.7	56	7.2	9.7
3	bg	-41.54	-41	2437	100	AP-C3-3F-01	28	56	7.2	8.2	3	25.7	56	7.2	9.7
3	bf	-55.42	-55	5180	100	AP-C3-3F-01	26	56	7.2	8.2	3	25.7	56	7.2	9.7
3	bf	-51.2	-50	2437	100	AP-C3-3F-01	26	56	7.2	8.2	3	25.7	56	7.2	9.7
3	be	-58.7	-58	5180	100	AP-C3-3F-01	24	56	7.2	8.2	3	25.7	56	7.2	9.7
3	be	-40.31	-39	2437	100	AP-C3-3F-01	24	56	7.2	8.2	3	25.7	56	7.2	9.7
3	bd	-57.28	-57	5180	100	AP-C3-3F-01	22	56	7.2	8.2	3	25.7	56	7.2	9.7
3	bd	-42.51	-42	2437	100	AP-C3-3F-01	22	56	7.2	8.2	3	25.7	56	7.2	9.7
3	bc	-64.93	-65	5180	100	AP-C3-3F-01	20	56	7.2	8.2	3	25.7	56	7.2	9.7
3	bc	-43.35	-43	2437	100	AP-C3-3F-01	20	56	7.2	8.2	3	25.7	56	7.2	9.7
3	bb	-67.74	-68	5180	100	AP-C3-3F-01	18	56	7.2	8.2	3	25.7	56	7.2	9.7
3	bb	-46.6	-48	2437	100	AP-C3-3F-01	18	56	7.2	8.2	3	25.7	56	7.2	9.7
3	ba	-64.89	-65	5180	100	AP-C3-3F-01	16	56	7.2	8.2	3	25.7	56	7.2	9.7
3	ba	-50.14	-50	2437	100	AP-C3-3F-01	16	56	7.2	8.2	3	25.7	56	7.2	9.7
3	y	-88	-88	2437	7	AP-C3-3F-01	0	16	7.2	8.2	3	25.7	56	7.2	9.7
3	x	-85.44444444	-85	2437	9	AP-C3-3F-01	0	14	7.2	8.2	3	25.7	56	7.2	9.7
3	s	-87	-87	2437	7	AP-C3-3F-01	0	4	7.2	8.2	3	25.7	56	7.2	9.7
3	r	-88	-88	2437	7	AP-C3-3F-01	0	2	7.2	8.2	3	25.7	56	7.2	9.7
4	az	-87.41666667	-88	5180	72	AP-C3-3F-01	14	56	10.8	11.8	3	25.7	56	7.2	9.7
4	az	-75.36	-76	2437	100	AP-C3-3F-01	14	56	10.8	11.8	3	25.7	56	7.2	9.7
4	ay	-88	-89	5180	56	AP-C3-3F-01	12	56	10.8	11.8	3	25.7	56	7.2	9.7
4	ay	-76.78461538	-77	2437	65	AP-C3-3F-01	12	56	10.8	11.8	3	25.7	56	7.2	9.7
4	ax	-90.5	-90.5	5180	14	AP-C3-3F-01	10	56	10.8	11.8	3	25.7	56	7.2	9.7
4	ax	-70.62790698	-70	2437	86	AP-C3-3F-01	10	56	10.8	11.8	3	25.7	56	7.2	9.7
4	aw	-76.4375	-76	2437	48	AP-C3-3F-01	8	56	10.8	11.8	3	25.7	56	7.2	9.7
4	av	-90.25	-90.5	5180	28	AP-C3-3F-01	6	56	10.8	11.8	3	25.7	56	7.2	9.7
4	av	-78.66666667	-79	2437	30	AP-C3-3F-01	6	56	10.8	11.8	3	25.7	56	7.2	9.7
4	au	-85.83333333	-86	2437	42	AP-C3-3F-01	4	56	10.8	11.8	3	25.7	56	7.2	9.7
4	at	-77.18918919	-78	2437	37	AP-C3-3F-01	2	56	10.8	11.8	3	25.7	56	7.2	9.7
4	as	-84.9	-86	2437	30	AP-C3-3F-01	0	56	10.8	11.8	3	25.7	56	7.2	9.7
4	bg	-73.7311828	-74	5180	93	AP-C3-3F-01	28	56	10.8	11.8	3	25.7	56	7.2	9.7
4	bg	-64.57	-65	2437	100	AP-C3-3F-01	28	56	10.8	11.8	3	25.7	56	7.2	9.7
4	bf	-75.21518987	-76	5180	79	AP-C3-3F-01	26	56	10.8	11.8	3	25.7	56	7.2	9.7
4	bf	-57.76344086	-59	2437	93	AP-C3-3F-01	26	56	10.8	11.8	3	25.7	56	7.2	9.7
4	be	-71.11627907	-71	5180	86	AP-C3-3F-01	24	56	10.8	11.8	3	25.7	56	7.2	9.7
4	be	-49.49	-49	2437	100	AP-C3-3F-01	24	56	10.8	11.8	3	25.7	56	7.2	9.7
4	bd	-80.57142857	-80	5180	49	AP-C3-3F-01	22	56	10.8	11.8	3	25.7	56	7.2	9.7
4	bd	-55.98	-55	2437	100	AP-C3-3F-01	22	56	10.8	11.8	3	25.7	56	7.2	9.7
4	bc	-81.83076923	-82	5180	65	AP-C3-3F-01	20	56	10.8	11.8	3	25.7	56	7.2	9.7
4	bc	-63.43	-64	2437	100	AP-C3-3F-01	20	56	10.8	11.8	3	25.7	56	7.2	9.7
4	bb	-84	-84	5180	86	AP-C3-3F-01	18	56	10.8	11.8	3	25.7	56	7.2	9.7
4	bb	-63.84946237	-64	2437	93	AP-C3-3F-01	18	56	10.8	11.8	3	25.7	56	7.2	9.7
4	ba	-84.47674419	-84	5180	86	AP-C3-3F-01	16	56	10.8	11.8	3	25.7	56	7.2	9.7
4	ba	-61.35	-60	2437	100	AP-C3-3F-01	16	56	10.8	11.8	3	25.7	56	7.2	9.7
3	am	-82	-82	2437	7	AP-C3-3F-02	0	44	7.2	8.2	3	13.6	56	7.2	9.7
3	al	-91.33333333	-91	5180	42	AP-C3-3F-02	0	42	7.2	8.2	3	13.6	56	7.2	9.7
3	al	-82.33333333	-83	2437	21	AP-C3-3F-02	0	42	7.2	8.2	3	13.6	56	7.2	9.7
3	az	-49.86	-50	5180	100	AP-C3-3F-02	14	56	7.2	8.2	3	13.6	56	7.2	9.7
3	az	-43.40860215	-43	2437	93	AP-C3-3F-02	14	56	7.2	8.2	3	13.6	56	7.2	9.7
3	ay	-58.73	-59	5180	100	AP-C3-3F-02	12	56	7.2	8.2	3	13.6	56	7.2	9.7
3	ay	-39.84946237	-40	2437	93	AP-C3-3F-02	12	56	7.2	8.2	3	13.6	56	7.2	9.7
3	ax	-65.1	-66	5180	100	AP-C3-3F-02	10	56	7.2	8.2	3	13.6	56	7.2	9.7
3	ax	-38.79	-38	2437	100	AP-C3-3F-02	10	56	7.2	8.2	3	13.6	56	7.2	9.7
3	aw	-64.86	-65	5180	100	AP-C3-3F-02	8	56	7.2	8.2	3	13.6	56	7.2	9.7
3	aw	-48.96	-49	2437	100	AP-C3-3F-02	8	56	7.2	8.2	3	13.6	56	7.2	9.7
3	av	-70.94623656	-69	5180	93	AP-C3-3F-02	6	56	7.2	8.2	3	13.6	56	7.2	9.7
3	av	-54.78	-54	2437	100	AP-C3-3F-02	6	56	7.2	8.2	3	13.6	56	7.2	9.7
3	au	-70.57	-70.5	5180	100	AP-C3-3F-02	4	56	7.2	8.2	3	13.6	56	7.2	9.7
3	au	-47.43	-47	2437	100	AP-C3-3F-02	4	56	7.2	8.2	3	13.6	56	7.2	9.7
3	at	-66.59	-67	5180	100	AP-C3-3F-02	2	56	7.2	8.2	3	13.6	56	7.2	9.7
3	at	-58.56	-59	2437	100	AP-C3-3F-02	2	56	7.2	8.2	3	13.6	56	7.2	9.7
3	as	-61.47	-61	2437	100	AP-C3-3F-02	0	56	7.2	8.2	3	13.6	56	7.2	9.7
3	ar	-78.63636364	-78	5180	77	AP-C3-3F-02	0	54	7.2	8.2	3	13.6	56	7.2	9.7
3	ar	-70.07142857	-71	2437	98	AP-C3-3F-02	0	54	7.2	8.2	3	13.6	56	7.2	9.7
3	aq	-85.64615385	-86	5180	65	AP-C3-3F-02	0	52	7.2	8.2	3	13.6	56	7.2	9.7
3	aq	-80.6	-80	2437	65	AP-C3-3F-02	0	52	7.2	8.2	3	13.6	56	7.2	9.7
3	ap	-85.24137931	-85	5180	58	AP-C3-3F-02	0	50	7.2	8.2	3	13.6	56	7.2	9.7
3	ap	-80.48275862	-81	2437	58	AP-C3-3F-02	0	50	7.2	8.2	3	13.6	56	7.2	9.7
3	ao	-86.2	-87	5180	65	AP-C3-3F-02	0	48	7.2	8.2	3	13.6	56	7.2	9.7
3	ao	-83.5	-83.5	2437	14	AP-C3-3F-02	0	48	7.2	8.2	3	13.6	56	7.2	9.7
3	an	-79	-78.5	2437	42	AP-C3-3F-02	0	46	7.2	8.2	3	13.6	56	7.2	9.7
3	am	-87.22222222	-88	5180	63	AP-C3-3F-02	0	44	7.2	8.2	3	13.6	56	7.2	9.7
3	bg	-73.3	-73	5180	70	AP-C3-3F-02	28	56	7.2	8.2	3	13.6	56	7.2	9.7
3	bg	-60.87	-60	2437	100	AP-C3-3F-02	28	56	7.2	8.2	3	13.6	56	7.2	9.7
3	bf	-68.01	-68	5180	100	AP-C3-3F-02	26	56	7.2	8.2	3	13.6	56	7.2	9.7
3	bf	-64.51612903	-65	2437	93	AP-C3-3F-02	26	56	7.2	8.2	3	13.6	56	7.2	9.7
3	be	-73.27956989	-73	5180	93	AP-C3-3F-02	24	56	7.2	8.2	3	13.6	56	7.2	9.7
3	be	-62.82795699	-63	2437	93	AP-C3-3F-02	24	56	7.2	8.2	3	13.6	56	7.2	9.7
3	bd	-68.58	-68	5180	100	AP-C3-3F-02	22	56	7.2	8.2	3	13.6	56	7.2	9.7
3	bd	-61.17	-61	2437	100	AP-C3-3F-02	22	56	7.2	8.2	3	13.6	56	7.2	9.7
3	bc	-66.05	-66	5180	100	AP-C3-3F-02	20	56	7.2	8.2	3	13.6	56	7.2	9.7
3	bc	-59	-59	2437	93	AP-C3-3F-02	20	56	7.2	8.2	3	13.6	56	7.2	9.7
3	bb	-66.66	-66	5180	100	AP-C3-3F-02	18	56	7.2	8.2	3	13.6	56	7.2	9.7
3	bb	-55.49	-55	2437	100	AP-C3-3F-02	18	56	7.2	8.2	3	13.6	56	7.2	9.7
3	ba	-61.48	-61	5180	100	AP-C3-3F-02	16	56	7.2	8.2	3	13.6	56	7.2	9.7
3	ba	-53.24	-52	2437	100	AP-C3-3F-02	16	56	7.2	8.2	3	13.6	56	7.2	9.7
4	az	-69.68	-69	5180	100	AP-C3-3F-02	14	56	10.8	11.8	3	13.6	56	7.2	9.7
4	az	-49.8	-50	2437	100	AP-C3-3F-02	14	56	10.8	11.8	3	13.6	56	7.2	9.7
4	ay	-76.20253165	-76	5180	79	AP-C3-3F-02	12	56	10.8	11.8	3	13.6	56	7.2	9.7
4	ay	-52.82	-53	2437	100	AP-C3-3F-02	12	56	10.8	11.8	3	13.6	56	7.2	9.7
4	ax	-84.83076923	-86	5180	65	AP-C3-3F-02	10	56	10.8	11.8	3	13.6	56	7.2	9.7
4	ax	-57.14	-57	2437	100	AP-C3-3F-02	10	56	10.8	11.8	3	13.6	56	7.2	9.7
4	aw	-87.16438356	-88	5180	73	AP-C3-3F-02	8	56	10.8	11.8	3	13.6	56	7.2	9.7
4	aw	-60.8	-61	2437	100	AP-C3-3F-02	8	56	10.8	11.8	3	13.6	56	7.2	9.7
4	av	-87	-86.5	5180	56	AP-C3-3F-02	6	56	10.8	11.8	3	13.6	56	7.2	9.7
4	av	-64.17204301	-64	2437	93	AP-C3-3F-02	6	56	10.8	11.8	3	13.6	56	7.2	9.7
4	au	-88.45098039	-88	5180	51	AP-C3-3F-02	4	56	10.8	11.8	3	13.6	56	7.2	9.7
4	au	-65.59302326	-65	2437	86	AP-C3-3F-02	4	56	10.8	11.8	3	13.6	56	7.2	9.7
4	at	-92	-92	5180	14	AP-C3-3F-02	2	56	10.8	11.8	3	13.6	56	7.2	9.7
4	at	-78.87692308	-79	2437	65	AP-C3-3F-02	2	56	10.8	11.8	3	13.6	56	7.2	9.7
4	as	-83.05405405	-84	2437	37	AP-C3-3F-02	0	56	10.8	11.8	3	13.6	56	7.2	9.7
4	ar	-77.8	-77	2437	35	AP-C3-3F-02	0	54	10.8	11.8	3	13.6	56	7.2	9.7
4	bg	-92	-92	5180	14	AP-C3-3F-02	28	56	10.8	11.8	3	13.6	56	7.2	9.7
4	bg	-79.98275862	-79	2437	58	AP-C3-3F-02	28	56	10.8	11.8	3	13.6	56	7.2	9.7
4	bf	-90	-90	5180	7	AP-C3-3F-02	26	56	10.8	11.8	3	13.6	56	7.2	9.7
4	bf	-81.74137931	-82	2437	58	AP-C3-3F-02	26	56	10.8	11.8	3	13.6	56	7.2	9.7
4	be	-90.66666667	-90	5180	63	AP-C3-3F-02	24	56	10.8	11.8	3	13.6	56	7.2	9.7
4	be	-75.55696203	-75	2437	79	AP-C3-3F-02	24	56	10.8	11.8	3	13.6	56	7.2	9.7
4	bd	-89.83333333	-90	5180	42	AP-C3-3F-02	22	56	10.8	11.8	3	13.6	56	7.2	9.7
4	bd	-73.25581395	-73	2437	86	AP-C3-3F-02	22	56	10.8	11.8	3	13.6	56	7.2	9.7
4	bc	-83.74193548	-84	5180	93	AP-C3-3F-02	20	56	10.8	11.8	3	13.6	56	7.2	9.7
4	bc	-76.76470588	-77	2437	51	AP-C3-3F-02	20	56	10.8	11.8	3	13.6	56	7.2	9.7
4	bb	-85	-85	5180	63	AP-C3-3F-02	18	56	10.8	11.8	3	13.6	56	7.2	9.7
4	bb	-61.13	-62	2437	100	AP-C3-3F-02	18	56	10.8	11.8	3	13.6	56	7.2	9.7
4	ba	-77.61538462	-78	5180	91	AP-C3-3F-02	16	56	10.8	11.8	3	13.6	56	7.2	9.7
4	ba	-60.68	-60	2437	100	AP-C3-3F-02	16	56	10.8	11.8	3	13.6	56	7.2	9.7
3	am	-76.35294118	-76	2437	51	AP-C3-3F-03	0	44	7.2	8.2	3	4.6	56	7.2	9.7
3	al	-84	-84	5180	2	AP-C3-3F-03	0	42	7.2	8.2	3	4.6	56	7.2	9.7
3	al	-66.72307692	-66	2437	65	AP-C3-3F-03	0	42	7.2	8.2	3	4.6	56	7.2	9.7
3	ak	-68.76666667	-69	2437	60	AP-C3-3F-03	0	40	7.2	8.2	3	4.6	56	7.2	9.7
3	aj	-81.16666667	-81.5	2437	42	AP-C3-3F-03	0	38	7.2	8.2	3	4.6	56	7.2	9.7
3	ai	-78.18461538	-78	2437	65	AP-C3-3F-03	0	36	7.2	8.2	3	4.6	56	7.2	9.7
3	ah	-83.8	-83	2437	35	AP-C3-3F-03	0	34	7.2	8.2	3	4.6	56	7.2	9.7
3	ag	-84.5	-84.5	2437	14	AP-C3-3F-03	0	32	7.2	8.2	3	4.6	56	7.2	9.7
3	af	-84.72	-85	2437	25	AP-C3-3F-03	0	30	7.2	8.2	3	4.6	56	7.2	9.7
3	ae	-84.34782609	-84	2437	23	AP-C3-3F-03	0	28	7.2	8.2	3	4.6	56	7.2	9.7
3	ad	-78.9	-80	2437	30	AP-C3-3F-03	0	26	7.2	8.2	3	4.6	56	7.2	9.7
3	ac	-81	-81	2437	14	AP-C3-3F-03	0	24	7.2	8.2	3	4.6	56	7.2	9.7
3	ab	-81.4	-82	2437	35	AP-C3-3F-03	0	22	7.2	8.2	3	4.6	56	7.2	9.7
3	aa	-82	-82	2437	7	AP-C3-3F-03	0	20	7.2	8.2	3	4.6	56	7.2	9.7
3	az	-77.88888889	-78	5180	63	AP-C3-3F-03	14	56	7.2	8.2	3	4.6	56	7.2	9.7
3	az	-58.72	-59	2437	100	AP-C3-3F-03	14	56	7.2	8.2	3	4.6	56	7.2	9.7
3	ay	-73.37634409	-74	5180	93	AP-C3-3F-03	12	56	7.2	8.2	3	4.6	56	7.2	9.7
3	ay	-60.74	-61	2437	100	AP-C3-3F-03	12	56	7.2	8.2	3	4.6	56	7.2	9.7
3	ax	-65.42	-65	5180	100	AP-C3-3F-03	10	56	7.2	8.2	3	4.6	56	7.2	9.7
3	ax	-47.51	-47	2437	100	AP-C3-3F-03	10	56	7.2	8.2	3	4.6	56	7.2	9.7
3	aw	-62.09	-62	5180	100	AP-C3-3F-03	8	56	7.2	8.2	3	4.6	56	7.2	9.7
3	aw	-41.86	-42	2437	100	AP-C3-3F-03	8	56	7.2	8.2	3	4.6	56	7.2	9.7
3	av	-61.14	-61	5180	100	AP-C3-3F-03	6	56	7.2	8.2	3	4.6	56	7.2	9.7
3	av	-46.41	-47	2437	100	AP-C3-3F-03	6	56	7.2	8.2	3	4.6	56	7.2	9.7
3	au	-50.92	-50.5	5180	100	AP-C3-3F-03	4	56	7.2	8.2	3	4.6	56	7.2	9.7
3	au	-40.09	-39	2437	100	AP-C3-3F-03	4	56	7.2	8.2	3	4.6	56	7.2	9.7
3	at	-52.46	-52	5180	100	AP-C3-3F-03	2	56	7.2	8.2	3	4.6	56	7.2	9.7
3	at	-48.23	-48	2437	100	AP-C3-3F-03	2	56	7.2	8.2	3	4.6	56	7.2	9.7
3	as	-44.23	-45	2437	100	AP-C3-3F-03	0	56	7.2	8.2	3	4.6	56	7.2	9.7
3	ar	-65.77	-65	5180	100	AP-C3-3F-03	0	54	7.2	8.2	3	4.6	56	7.2	9.7
3	ar	-47.98	-48	2437	100	AP-C3-3F-03	0	54	7.2	8.2	3	4.6	56	7.2	9.7
3	aq	-73.01	-74	5180	100	AP-C3-3F-03	0	52	7.2	8.2	3	4.6	56	7.2	9.7
3	aq	-57.42	-57	2437	100	AP-C3-3F-03	0	52	7.2	8.2	3	4.6	56	7.2	9.7
3	ap	-74.22093023	-73	5180	86	AP-C3-3F-03	0	50	7.2	8.2	3	4.6	56	7.2	9.7
3	ap	-59.19	-60	2437	100	AP-C3-3F-03	0	50	7.2	8.2	3	4.6	56	7.2	9.7
3	ao	-81	-80.5	5180	56	AP-C3-3F-03	0	48	7.2	8.2	3	4.6	56	7.2	9.7
3	ao	-61.46153846	-61	2437	91	AP-C3-3F-03	0	48	7.2	8.2	3	4.6	56	7.2	9.7
3	an	-71.81818182	-72	2437	77	AP-C3-3F-03	0	46	7.2	8.2	3	4.6	56	7.2	9.7
3	am	-86	-86	5180	14	AP-C3-3F-03	0	44	7.2	8.2	3	4.6	56	7.2	9.7
3	bg	-81.70833333	-82	5180	72	AP-C3-3F-03	28	56	7.2	8.2	3	4.6	56	7.2	9.7
3	bg	-66.6627907	-66	2437	86	AP-C3-3F-03	28	56	7.2	8.2	3	4.6	56	7.2	9.7
3	bf	-76.5	-76	5180	56	AP-C3-3F-03	26	56	7.2	8.2	3	4.6	56	7.2	9.7
3	bf	-65.3255814	-66	2437	86	AP-C3-3F-03	26	56	7.2	8.2	3	4.6	56	7.2	9.7
3	be	-76.5	-77	5180	72	AP-C3-3F-03	24	56	7.2	8.2	3	4.6	56	7.2	9.7
3	be	-69.08602151	-69	2437	93	AP-C3-3F-03	24	56	7.2	8.2	3	4.6	56	7.2	9.7
3	bd	-82.23529412	-83	5180	51	AP-C3-3F-03	22	56	7.2	8.2	3	4.6	56	7.2	9.7
3	bd	-63.96774194	-64	2437	93	AP-C3-3F-03	22	56	7.2	8.2	3	4.6	56	7.2	9.7
3	bc	-79.24418605	-79	5180	86	AP-C3-3F-03	20	56	7.2	8.2	3	4.6	56	7.2	9.7
3	bc	-66.98	-66	2437	100	AP-C3-3F-03	20	56	7.2	8.2	3	4.6	56	7.2	9.7
3	bb	-75.62025316	-76	5180	79	AP-C3-3F-03	18	56	7.2	8.2	3	4.6	56	7.2	9.7
3	bb	-67.99	-67	2437	100	AP-C3-3F-03	18	56	7.2	8.2	3	4.6	56	7.2	9.7
3	ba	-79.375	-80	5180	56	AP-C3-3F-03	16	56	7.2	8.2	3	4.6	56	7.2	9.7
3	ba	-63.72	-63	2437	100	AP-C3-3F-03	16	56	7.2	8.2	3	4.6	56	7.2	9.7
3	y	-81	-81	2437	7	AP-C3-3F-03	0	16	7.2	8.2	3	4.6	56	7.2	9.7
3	x	-79	-79	2437	7	AP-C3-3F-03	0	14	7.2	8.2	3	4.6	56	7.2	9.7
3	w	-81.5	-81.5	2437	14	AP-C3-3F-03	0	12	7.2	8.2	3	4.6	56	7.2	9.7
3	v	-83	-83	2437	7	AP-C3-3F-03	0	10	7.2	8.2	3	4.6	56	7.2	9.7
3	r	-84.5	-84.5	2437	14	AP-C3-3F-03	0	2	7.2	8.2	3	4.6	56	7.2	9.7
3	q	-83	-83	2437	7	AP-C3-3F-03	0	0	7.2	8.2	3	4.6	56	7.2	9.7
3	z	-82.75	-82.5	2437	28	AP-C3-3F-03	0	18	7.2	8.2	3	4.6	56	7.2	9.7
4	az	-72.81034483	-73	2437	58	AP-C3-3F-03	14	56	10.8	11.8	3	4.6	56	7.2	9.7
4	ay	-88.83333333	-90.5	5180	42	AP-C3-3F-03	12	56	10.8	11.8	3	4.6	56	7.2	9.7
4	ay	-74.8	-76	2437	35	AP-C3-3F-03	12	56	10.8	11.8	3	4.6	56	7.2	9.7
4	ax	-83.53846154	-84	5180	65	AP-C3-3F-03	10	56	10.8	11.8	3	4.6	56	7.2	9.7
4	ax	-63.61	-62	2437	100	AP-C3-3F-03	10	56	10.8	11.8	3	4.6	56	7.2	9.7
4	aw	-83.60465116	-84	5180	86	AP-C3-3F-03	8	56	10.8	11.8	3	4.6	56	7.2	9.7
4	aw	-65.39	-66	2437	100	AP-C3-3F-03	8	56	10.8	11.8	3	4.6	56	7.2	9.7
4	av	-73.81	-74	5180	100	AP-C3-3F-03	6	56	10.8	11.8	3	4.6	56	7.2	9.7
4	av	-60.23	-60	2437	100	AP-C3-3F-03	6	56	10.8	11.8	3	4.6	56	7.2	9.7
4	au	-70.69	-71	5180	100	AP-C3-3F-03	4	56	10.8	11.8	3	4.6	56	7.2	9.7
4	au	-56.91	-56	2437	100	AP-C3-3F-03	4	56	10.8	11.8	3	4.6	56	7.2	9.7
4	at	-75.19354839	-75	5180	93	AP-C3-3F-03	2	56	10.8	11.8	3	4.6	56	7.2	9.7
4	at	-59.45	-59	2437	100	AP-C3-3F-03	2	56	10.8	11.8	3	4.6	56	7.2	9.7
4	as	-84.15909091	-84	5180	44	AP-C3-3F-03	0	56	10.8	11.8	3	4.6	56	7.2	9.7
4	as	-69.69444444	-68	2437	72	AP-C3-3F-03	0	56	10.8	11.8	3	4.6	56	7.2	9.7
4	ar	-91.25	-91.5	5180	28	AP-C3-3F-03	0	54	10.8	11.8	3	4.6	56	7.2	9.7
4	ar	-63.09	-63	2437	100	AP-C3-3F-03	0	54	10.8	11.8	3	4.6	56	7.2	9.7
4	aq	-91.5	-91.5	5180	28	AP-C3-3F-03	0	52	10.8	11.8	3	4.6	56	7.2	9.7
4	aq	-82.28571429	-82	2437	49	AP-C3-3F-03	0	52	10.8	11.8	3	4.6	56	7.2	9.7
4	ap	-83	-83	2437	7	AP-C3-3F-03	0	50	10.8	11.8	3	4.6	56	7.2	9.7
4	ao	-81.66666667	-81	2437	21	AP-C3-3F-03	0	48	10.8	11.8	3	4.6	56	7.2	9.7
4	bg	-84	-84	2437	49	AP-C3-3F-03	28	56	10.8	11.8	3	4.6	56	7.2	9.7
4	be	-83.28571429	-83	2437	49	AP-C3-3F-03	24	56	10.8	11.8	3	4.6	56	7.2	9.7
4	bd	-83.28571429	-83	2437	49	AP-C3-3F-03	22	56	10.8	11.8	3	4.6	56	7.2	9.7
4	bc	-81.71428571	-82	2437	49	AP-C3-3F-03	20	56	10.8	11.8	3	4.6	56	7.2	9.7
4	bb	-80.5	-81	2437	28	AP-C3-3F-03	18	56	10.8	11.8	3	4.6	56	7.2	9.7
4	ba	-85.33333333	-85	2437	42	AP-C3-3F-03	16	56	10.8	11.8	3	4.6	56	7.2	9.7
3	az	-89.66666667	-90	5180	30	AP-C3-4F-01	14	56	7.2	8.2	4	24.5	56	10.8	13.3
3	az	-63.83333333	-64	2437	84	AP-C3-4F-01	14	56	7.2	8.2	4	24.5	56	10.8	13.3
3	ay	-91.14285714	-91	5180	49	AP-C3-4F-01	12	56	7.2	8.2	4	24.5	56	10.8	13.3
3	ay	-76.56756757	-77	2437	37	AP-C3-4F-01	12	56	7.2	8.2	4	24.5	56	10.8	13.3
3	ax	-90.47826087	-90	5180	23	AP-C3-4F-01	10	56	7.2	8.2	4	24.5	56	10.8	13.3
3	ax	-75.05172414	-75	2437	58	AP-C3-4F-01	10	56	7.2	8.2	4	24.5	56	10.8	13.3
3	aw	-77.43243243	-77	2437	37	AP-C3-4F-01	8	56	7.2	8.2	4	24.5	56	10.8	13.3
3	av	-74.55555556	-75	2437	72	AP-C3-4F-01	6	56	7.2	8.2	4	24.5	56	10.8	13.3
3	au	-90.5	-90.5	5180	14	AP-C3-4F-01	4	56	7.2	8.2	4	24.5	56	10.8	13.3
3	au	-73.52325581	-73.5	2437	86	AP-C3-4F-01	4	56	7.2	8.2	4	24.5	56	10.8	13.3
3	at	-74.2	-75	2437	35	AP-C3-4F-01	2	56	7.2	8.2	4	24.5	56	10.8	13.3
3	as	-85.33333333	-85	2437	21	AP-C3-4F-01	0	56	7.2	8.2	4	24.5	56	10.8	13.3
3	ar	-88	-88	2437	7	AP-C3-4F-01	0	54	7.2	8.2	4	24.5	56	10.8	13.3
3	bg	-83.25	-84	5180	72	AP-C3-4F-01	28	56	7.2	8.2	4	24.5	56	10.8	13.3
3	bg	-60.21	-60	2437	100	AP-C3-4F-01	28	56	7.2	8.2	4	24.5	56	10.8	13.3
3	bf	-74.69444444	-74	5180	72	AP-C3-4F-01	26	56	7.2	8.2	4	24.5	56	10.8	13.3
3	bf	-58.68	-58	2437	100	AP-C3-4F-01	26	56	7.2	8.2	4	24.5	56	10.8	13.3
3	be	-80.27848101	-81	5180	79	AP-C3-4F-01	24	56	7.2	8.2	4	24.5	56	10.8	13.3
3	be	-52.72	-52	2437	100	AP-C3-4F-01	24	56	7.2	8.2	4	24.5	56	10.8	13.3
3	bd	-78.79	-79	5180	100	AP-C3-4F-01	22	56	7.2	8.2	4	24.5	56	10.8	13.3
3	bd	-58.30107527	-58	2437	93	AP-C3-4F-01	22	56	7.2	8.2	4	24.5	56	10.8	13.3
3	bc	-79	-79	5180	63	AP-C3-4F-01	20	56	7.2	8.2	4	24.5	56	10.8	13.3
3	bc	-72.32258065	-72	2437	93	AP-C3-4F-01	20	56	7.2	8.2	4	24.5	56	10.8	13.3
3	bb	-75.25609756	-75	5180	82	AP-C3-4F-01	18	56	7.2	8.2	4	24.5	56	10.8	13.3
3	bb	-69.60215054	-70	2437	93	AP-C3-4F-01	18	56	7.2	8.2	4	24.5	56	10.8	13.3
3	ba	-83.90769231	-83	5180	65	AP-C3-4F-01	16	56	7.2	8.2	4	24.5	56	10.8	13.3
3	ba	-60.93	-61	2437	100	AP-C3-4F-01	16	56	7.2	8.2	4	24.5	56	10.8	13.3
4	ak	-90.93846154	-91	5180	65	AP-C3-4F-01	0	40	10.8	11.8	4	24.5	56	10.8	13.3
4	aj	-89.11363636	-89	5180	44	AP-C3-4F-01	0	38	10.8	11.8	4	24.5	56	10.8	13.3
4	az	-65.6	-66	5180	100	AP-C3-4F-01	14	56	10.8	11.8	4	24.5	56	10.8	13.3
4	az	-64.68	-64	2437	100	AP-C3-4F-01	14	56	10.8	11.8	4	24.5	56	10.8	13.3
4	ay	-68.26	-67	5180	100	AP-C3-4F-01	12	56	10.8	11.8	4	24.5	56	10.8	13.3
4	ay	-62.47	-62	2437	100	AP-C3-4F-01	12	56	10.8	11.8	4	24.5	56	10.8	13.3
4	ax	-72.7	-73	5180	100	AP-C3-4F-01	10	56	10.8	11.8	4	24.5	56	10.8	13.3
4	ax	-62.12	-62	2437	100	AP-C3-4F-01	10	56	10.8	11.8	4	24.5	56	10.8	13.3
4	aw	-67.49	-68	5180	100	AP-C3-4F-01	8	56	10.8	11.8	4	24.5	56	10.8	13.3
4	aw	-65.51	-65	2437	100	AP-C3-4F-01	8	56	10.8	11.8	4	24.5	56	10.8	13.3
4	av	-70.10465116	-70	5180	86	AP-C3-4F-01	6	56	10.8	11.8	4	24.5	56	10.8	13.3
4	av	-72.55	-74	2437	100	AP-C3-4F-01	6	56	10.8	11.8	4	24.5	56	10.8	13.3
4	au	-67.6	-68	5180	100	AP-C3-4F-01	4	56	10.8	11.8	4	24.5	56	10.8	13.3
4	au	-71.07692308	-72	2437	91	AP-C3-4F-01	4	56	10.8	11.8	4	24.5	56	10.8	13.3
4	at	-77.44086022	-77	5180	93	AP-C3-4F-01	2	56	10.8	11.8	4	24.5	56	10.8	13.3
4	at	-60.27	-60	2437	100	AP-C3-4F-01	2	56	10.8	11.8	4	24.5	56	10.8	13.3
4	as	-69.61445783	-70	5180	83	AP-C3-4F-01	0	56	10.8	11.8	4	24.5	56	10.8	13.3
4	as	-66.51	-66	2437	100	AP-C3-4F-01	0	56	10.8	11.8	4	24.5	56	10.8	13.3
4	ar	-81.26744186	-82	5180	86	AP-C3-4F-01	0	54	10.8	11.8	4	24.5	56	10.8	13.3
4	ar	-71.4137931	-71	2437	58	AP-C3-4F-01	0	54	10.8	11.8	4	24.5	56	10.8	13.3
4	aq	-88.5	-89	5180	72	AP-C3-4F-01	0	52	10.8	11.8	4	24.5	56	10.8	13.3
4	aq	-81.34482759	-81	2437	58	AP-C3-4F-01	0	52	10.8	11.8	4	24.5	56	10.8	13.3
4	ap	-87.63414634	-89	5180	41	AP-C3-4F-01	0	50	10.8	11.8	4	24.5	56	10.8	13.3
4	ap	-84.5	-84.5	2437	14	AP-C3-4F-01	0	50	10.8	11.8	4	24.5	56	10.8	13.3
4	ao	-84.61111111	-84	5180	72	AP-C3-4F-01	0	48	10.8	11.8	4	24.5	56	10.8	13.3
4	ao	-83	-83	2437	7	AP-C3-4F-01	0	48	10.8	11.8	4	24.5	56	10.8	13.3
4	an	-84.65517241	-84	5180	58	AP-C3-4F-01	0	46	10.8	11.8	4	24.5	56	10.8	13.3
4	am	-85.83333333	-86	5180	42	AP-C3-4F-01	0	44	10.8	11.8	4	24.5	56	10.8	13.3
4	al	-90.2	-90	5180	35	AP-C3-4F-01	0	42	10.8	11.8	4	24.5	56	10.8	13.3
4	bg	-62.26	-62	5180	100	AP-C3-4F-01	28	56	10.8	11.8	4	24.5	56	10.8	13.3
4	bg	-48.55	-48	2437	100	AP-C3-4F-01	28	56	10.8	11.8	4	24.5	56	10.8	13.3
4	bf	-56.39	-57	5180	100	AP-C3-4F-01	26	56	10.8	11.8	4	24.5	56	10.8	13.3
4	bf	-49.73	-51	2437	100	AP-C3-4F-01	26	56	10.8	11.8	4	24.5	56	10.8	13.3
4	be	-46.91	-47	5180	100	AP-C3-4F-01	24	56	10.8	11.8	4	24.5	56	10.8	13.3
4	be	-38.37	-38	2437	100	AP-C3-4F-01	24	56	10.8	11.8	4	24.5	56	10.8	13.3
4	bd	-52.77	-53	5180	100	AP-C3-4F-01	22	56	10.8	11.8	4	24.5	56	10.8	13.3
4	bd	-41.22	-41	2437	100	AP-C3-4F-01	22	56	10.8	11.8	4	24.5	56	10.8	13.3
4	bc	-59.26	-58	5180	100	AP-C3-4F-01	20	56	10.8	11.8	4	24.5	56	10.8	13.3
4	bc	-46.29	-45	2437	100	AP-C3-4F-01	20	56	10.8	11.8	4	24.5	56	10.8	13.3
4	bb	-63.05	-62	5180	100	AP-C3-4F-01	18	56	10.8	11.8	4	24.5	56	10.8	13.3
4	bb	-49.36	-49	2437	100	AP-C3-4F-01	18	56	10.8	11.8	4	24.5	56	10.8	13.3
4	ba	-62.78	-63	5180	100	AP-C3-4F-01	16	56	10.8	11.8	4	24.5	56	10.8	13.3
4	ba	-53.35	-53	2437	100	AP-C3-4F-01	16	56	10.8	11.8	4	24.5	56	10.8	13.3
4	z	-90.3	-91	5180	30	AP-C3-4F-01	0	18	10.8	11.8	4	24.5	56	10.8	13.3
3	az	-82.86153846	-83	5180	65	AP-C3-4F-02	14	56	7.2	8.2	4	10	56	10.8	13.3
3	az	-68.5	-68.5	2437	98	AP-C3-4F-02	14	56	7.2	8.2	4	10	56	10.8	13.3
3	ay	-78.6	-78.5	5180	70	AP-C3-4F-02	12	56	7.2	8.2	4	10	56	10.8	13.3
3	ay	-59.6	-60	2437	100	AP-C3-4F-02	12	56	7.2	8.2	4	10	56	10.8	13.3
3	ax	-77.77906977	-78	5180	86	AP-C3-4F-02	10	56	7.2	8.2	4	10	56	10.8	13.3
3	ax	-62.38	-62	2437	100	AP-C3-4F-02	10	56	7.2	8.2	4	10	56	10.8	13.3
3	aw	-75.02325581	-75	5180	86	AP-C3-4F-02	8	56	7.2	8.2	4	10	56	10.8	13.3
3	aw	-52.86	-53	2437	100	AP-C3-4F-02	8	56	7.2	8.2	4	10	56	10.8	13.3
3	av	-73.17	-73	5180	100	AP-C3-4F-02	6	56	7.2	8.2	4	10	56	10.8	13.3
3	av	-59.28	-59	2437	100	AP-C3-4F-02	6	56	7.2	8.2	4	10	56	10.8	13.3
3	au	-83	-83	5180	7	AP-C3-4F-02	4	56	7.2	8.2	4	10	56	10.8	13.3
3	au	-60.16	-60	2437	100	AP-C3-4F-02	4	56	7.2	8.2	4	10	56	10.8	13.3
3	at	-64.05063291	-64	2437	79	AP-C3-4F-02	2	56	7.2	8.2	4	10	56	10.8	13.3
3	as	-68.77419355	-68	2437	93	AP-C3-4F-02	0	56	7.2	8.2	4	10	56	10.8	13.3
3	ar	-74.46835443	-74	2437	79	AP-C3-4F-02	0	54	7.2	8.2	4	10	56	10.8	13.3
3	ap	-83.66666667	-84	2437	42	AP-C3-4F-02	0	50	7.2	8.2	4	10	56	10.8	13.3
3	ao	-83	-83	2437	14	AP-C3-4F-02	0	48	7.2	8.2	4	10	56	10.8	13.3
3	bg	-83.5	-83.5	2437	14	AP-C3-4F-02	28	56	7.2	8.2	4	10	56	10.8	13.3
3	bf	-91.30434783	-92	5180	23	AP-C3-4F-02	26	56	7.2	8.2	4	10	56	10.8	13.3
3	bf	-77.55555556	-77	2437	63	AP-C3-4F-02	26	56	7.2	8.2	4	10	56	10.8	13.3
3	be	-74.34722222	-74	2437	72	AP-C3-4F-02	24	56	7.2	8.2	4	10	56	10.8	13.3
3	bd	-90.66666667	-91	5180	21	AP-C3-4F-02	22	56	7.2	8.2	4	10	56	10.8	13.3
3	bd	-73.23076923	-73	2437	91	AP-C3-4F-02	22	56	7.2	8.2	4	10	56	10.8	13.3
3	bc	-89.03448276	-89	5180	58	AP-C3-4F-02	20	56	7.2	8.2	4	10	56	10.8	13.3
3	bc	-73.79746835	-74	2437	79	AP-C3-4F-02	20	56	7.2	8.2	4	10	56	10.8	13.3
3	bb	-90.53846154	-90	5180	26	AP-C3-4F-02	18	56	7.2	8.2	4	10	56	10.8	13.3
3	bb	-69.77777778	-71	2437	81	AP-C3-4F-02	18	56	7.2	8.2	4	10	56	10.8	13.3
3	ba	-89.33333333	-89	5180	63	AP-C3-4F-02	16	56	7.2	8.2	4	10	56	10.8	13.3
3	ba	-71.59	-71	2437	100	AP-C3-4F-02	16	56	7.2	8.2	4	10	56	10.8	13.3
4	ak	-89	-89	5180	49	AP-C3-4F-02	0	40	10.8	11.8	4	10	56	10.8	13.3
4	aj	-91	-91	5180	9	AP-C3-4F-02	0	38	10.8	11.8	4	10	56	10.8	13.3
4	ai	-92.5	-92.5	5180	14	AP-C3-4F-02	0	36	10.8	11.8	4	10	56	10.8	13.3
4	ah	-90.14285714	-90	5180	49	AP-C3-4F-02	0	34	10.8	11.8	4	10	56	10.8	13.3
4	az	-64.21	-64	5180	100	AP-C3-4F-02	14	56	10.8	11.8	4	10	56	10.8	13.3
4	az	-51.4	-50	2437	100	AP-C3-4F-02	14	56	10.8	11.8	4	10	56	10.8	13.3
4	ay	-62.81	-64	5180	100	AP-C3-4F-02	12	56	10.8	11.8	4	10	56	10.8	13.3
4	ay	-42.05	-42	2437	100	AP-C3-4F-02	12	56	10.8	11.8	4	10	56	10.8	13.3
4	ax	-48.93	-49	5180	100	AP-C3-4F-02	10	56	10.8	11.8	4	10	56	10.8	13.3
4	ax	-37.05	-36	2437	100	AP-C3-4F-02	10	56	10.8	11.8	4	10	56	10.8	13.3
4	aw	-56.17	-56	5180	100	AP-C3-4F-02	8	56	10.8	11.8	4	10	56	10.8	13.3
4	aw	-46.38	-46	2437	100	AP-C3-4F-02	8	56	10.8	11.8	4	10	56	10.8	13.3
4	av	-57.06	-56	5180	100	AP-C3-4F-02	6	56	10.8	11.8	4	10	56	10.8	13.3
4	av	-44.57	-45	2437	100	AP-C3-4F-02	6	56	10.8	11.8	4	10	56	10.8	13.3
4	au	-68.82	-69	5180	100	AP-C3-4F-02	4	56	10.8	11.8	4	10	56	10.8	13.3
4	au	-52.39	-52	2437	100	AP-C3-4F-02	4	56	10.8	11.8	4	10	56	10.8	13.3
4	at	-67.49	-67	5180	100	AP-C3-4F-02	2	56	10.8	11.8	4	10	56	10.8	13.3
4	at	-59.07	-59	2437	100	AP-C3-4F-02	2	56	10.8	11.8	4	10	56	10.8	13.3
4	as	-63.78	-63	2437	100	AP-C3-4F-02	0	56	10.8	11.8	4	10	56	10.8	13.3
4	ar	-74.53164557	-74	5180	79	AP-C3-4F-02	0	54	10.8	11.8	4	10	56	10.8	13.3
4	ar	-63.17204301	-63	2437	93	AP-C3-4F-02	0	54	10.8	11.8	4	10	56	10.8	13.3
4	aq	-73.91397849	-74	5180	93	AP-C3-4F-02	0	52	10.8	11.8	4	10	56	10.8	13.3
4	aq	-74.47311828	-75	2437	93	AP-C3-4F-02	0	52	10.8	11.8	4	10	56	10.8	13.3
4	ap	-78.33333333	-78	5180	93	AP-C3-4F-02	0	50	10.8	11.8	4	10	56	10.8	13.3
4	ap	-78.51923077	-78	2437	52	AP-C3-4F-02	0	50	10.8	11.8	4	10	56	10.8	13.3
4	ao	-84	-84	5180	93	AP-C3-4F-02	0	48	10.8	11.8	4	10	56	10.8	13.3
4	ao	-78.4	-77	2437	35	AP-C3-4F-02	0	48	10.8	11.8	4	10	56	10.8	13.3
4	an	-83.33333333	-83	5180	72	AP-C3-4F-02	0	46	10.8	11.8	4	10	56	10.8	13.3
4	am	-86.93670886	-87	5180	79	AP-C3-4F-02	0	44	10.8	11.8	4	10	56	10.8	13.3
4	al	-87.04651163	-87	5180	86	AP-C3-4F-02	0	42	10.8	11.8	4	10	56	10.8	13.3
4	bg	-67.5483871	-67	5180	93	AP-C3-4F-02	28	56	10.8	11.8	4	10	56	10.8	13.3
4	bg	-69.65	-69	2437	100	AP-C3-4F-02	28	56	10.8	11.8	4	10	56	10.8	13.3
4	bf	-71.02150538	-71	5180	93	AP-C3-4F-02	26	56	10.8	11.8	4	10	56	10.8	13.3
4	bf	-69.64615385	-71	2437	65	AP-C3-4F-02	26	56	10.8	11.8	4	10	56	10.8	13.3
4	be	-74.68	-75	5180	100	AP-C3-4F-02	24	56	10.8	11.8	4	10	56	10.8	13.3
4	be	-62.24418605	-62	2437	86	AP-C3-4F-02	24	56	10.8	11.8	4	10	56	10.8	13.3
4	bd	-69.24	-69	5180	100	AP-C3-4F-02	22	56	10.8	11.8	4	10	56	10.8	13.3
4	bd	-67.05	-66	2437	100	AP-C3-4F-02	22	56	10.8	11.8	4	10	56	10.8	13.3
4	bc	-68.88	-69	5180	100	AP-C3-4F-02	20	56	10.8	11.8	4	10	56	10.8	13.3
4	bc	-64.85	-64	2437	100	AP-C3-4F-02	20	56	10.8	11.8	4	10	56	10.8	13.3
4	bb	-68.04	-68	5180	100	AP-C3-4F-02	18	56	10.8	11.8	4	10	56	10.8	13.3
4	bb	-59.37	-60	2437	100	AP-C3-4F-02	18	56	10.8	11.8	4	10	56	10.8	13.3
4	ba	-65.65	-66	5180	100	AP-C3-4F-02	16	56	10.8	11.8	4	10	56	10.8	13.3
4	ba	-60.28	-60	2437	100	AP-C3-4F-02	16	56	10.8	11.8	4	10	56	10.8	13.3
4	y	-91	-91	5180	7	AP-C3-4F-02	0	16	10.8	11.8	4	10	56	10.8	13.3
3	az	-77.69565217	-78	2437	23	AP-C3-5F-01	14	56	7.2	8.2	5	25.6	56	14.4	16.9
3	ay	-87	-87	2437	35	AP-C3-5F-01	12	56	7.2	8.2	5	25.6	56	14.4	16.9
3	ax	-89	-89	2437	28	AP-C3-5F-01	10	56	7.2	8.2	5	25.6	56	14.4	16.9
3	aw	-88.33333333	-88	2437	21	AP-C3-5F-01	8	56	7.2	8.2	5	25.6	56	14.4	16.9
3	bg	-79.93055556	-80	2437	72	AP-C3-5F-01	28	56	7.2	8.2	5	25.6	56	14.4	16.9
3	bf	-79.73913043	-79	2437	23	AP-C3-5F-01	26	56	7.2	8.2	5	25.6	56	14.4	16.9
3	be	-71.46	-71	2437	100	AP-C3-5F-01	24	56	7.2	8.2	5	25.6	56	14.4	16.9
3	bd	-71.84482759	-71	2437	58	AP-C3-5F-01	22	56	7.2	8.2	5	25.6	56	14.4	16.9
3	bc	-64	-64	2437	84	AP-C3-5F-01	20	56	7.2	8.2	5	25.6	56	14.4	16.9
3	bb	-89	-89	2437	7	AP-C3-5F-01	18	56	7.2	8.2	5	25.6	56	14.4	16.9
3	ba	-79	-79	2437	49	AP-C3-5F-01	16	56	7.2	8.2	5	25.6	56	14.4	16.9
4	az	-90.5	-90.5	5180	28	AP-C3-5F-01	14	56	10.8	11.8	5	25.6	56	14.4	16.9
4	az	-77.17721519	-78	2437	79	AP-C3-5F-01	14	56	10.8	11.8	5	25.6	56	14.4	16.9
4	ay	-89	-89	5180	7	AP-C3-5F-01	12	56	10.8	11.8	5	25.6	56	14.4	16.9
4	ay	-75.74	-76	2437	100	AP-C3-5F-01	12	56	10.8	11.8	5	25.6	56	14.4	16.9
4	ax	-90.5	-90.5	5180	14	AP-C3-5F-01	10	56	10.8	11.8	5	25.6	56	14.4	16.9
4	ax	-83	-83	2437	35	AP-C3-5F-01	10	56	10.8	11.8	5	25.6	56	14.4	16.9
4	aw	-84.33333333	-84	2437	21	AP-C3-5F-01	8	56	10.8	11.8	5	25.6	56	14.4	16.9
4	av	-82.63793103	-83	2437	58	AP-C3-5F-01	6	56	10.8	11.8	5	25.6	56	14.4	16.9
4	au	-80.63888889	-81	2437	72	AP-C3-5F-01	4	56	10.8	11.8	5	25.6	56	14.4	16.9
4	at	-80.5	-79.5	2437	42	AP-C3-5F-01	2	56	10.8	11.8	5	25.6	56	14.4	16.9
4	bg	-79.50632911	-80	5180	79	AP-C3-5F-01	28	56	10.8	11.8	5	25.6	56	14.4	16.9
4	bg	-61.7	-61	2437	100	AP-C3-5F-01	28	56	10.8	11.8	5	25.6	56	14.4	16.9
4	bf	-86.35443038	-86	5180	79	AP-C3-5F-01	26	56	10.8	11.8	5	25.6	56	14.4	16.9
4	bf	-59.02	-60	2437	100	AP-C3-5F-01	26	56	10.8	11.8	5	25.6	56	14.4	16.9
4	be	-74.95698925	-74	5180	93	AP-C3-5F-01	24	56	10.8	11.8	5	25.6	56	14.4	16.9
4	be	-55.26	-55	2437	100	AP-C3-5F-01	24	56	10.8	11.8	5	25.6	56	14.4	16.9
4	bd	-86.11627907	-86	5180	86	AP-C3-5F-01	22	56	10.8	11.8	5	25.6	56	14.4	16.9
4	bd	-60.72	-61	2437	100	AP-C3-5F-01	22	56	10.8	11.8	5	25.6	56	14.4	16.9
4	bc	-81.11111111	-80	5180	72	AP-C3-5F-01	20	56	10.8	11.8	5	25.6	56	14.4	16.9
4	bc	-58.62	-59	2437	100	AP-C3-5F-01	20	56	10.8	11.8	5	25.6	56	14.4	16.9
4	bb	-87.33846154	-88	5180	65	AP-C3-5F-01	18	56	10.8	11.8	5	25.6	56	14.4	16.9
4	bb	-65.46236559	-66	2437	93	AP-C3-5F-01	18	56	10.8	11.8	5	25.6	56	14.4	16.9
4	ba	-89	-89	5180	63	AP-C3-5F-01	16	56	10.8	11.8	5	25.6	56	14.4	16.9
4	ba	-70.09302326	-69	2437	86	AP-C3-5F-01	16	56	10.8	11.8	5	25.6	56	14.4	16.9
3	az	-80	-80	2437	14	AP-C3-5F-02	14	56	7.2	8.2	5	9.5	56	14.4	16.9
3	ay	-76	-76	2437	7	AP-C3-5F-02	12	56	7.2	8.2	5	9.5	56	14.4	16.9
3	ax	-82.6	-82	2437	35	AP-C3-5F-02	10	56	7.2	8.2	5	9.5	56	14.4	16.9
3	aw	-82.5	-82.5	2437	28	AP-C3-5F-02	8	56	7.2	8.2	5	9.5	56	14.4	16.9
3	av	-79.33333333	-80	2437	21	AP-C3-5F-02	6	56	7.2	8.2	5	9.5	56	14.4	16.9
3	au	-77.83333333	-77	2437	42	AP-C3-5F-02	4	56	7.2	8.2	5	9.5	56	14.4	16.9
3	at	-80.5	-80.5	2437	14	AP-C3-5F-02	2	56	7.2	8.2	5	9.5	56	14.4	16.9
3	as	-83	-83	2437	7	AP-C3-5F-02	0	56	7.2	8.2	5	9.5	56	14.4	16.9
3	bg	-88	-88	2437	14	AP-C3-5F-02	28	56	7.2	8.2	5	9.5	56	14.4	16.9
3	bf	-87.5	-87.5	2437	14	AP-C3-5F-02	26	56	7.2	8.2	5	9.5	56	14.4	16.9
3	bb	-87.5	-87.5	2437	10	AP-C3-5F-02	18	56	7.2	8.2	5	9.5	56	14.4	16.9
3	ba	-82.8	-83	2437	35	AP-C3-5F-02	16	56	7.2	8.2	5	9.5	56	14.4	16.9
4	az	-89.5	-89.5	5180	14	AP-C3-5F-02	14	56	10.8	11.8	5	9.5	56	14.4	16.9
4	az	-74.70886076	-76	2437	79	AP-C3-5F-02	14	56	10.8	11.8	5	9.5	56	14.4	16.9
4	ay	-79.17721519	-78	5180	79	AP-C3-5F-02	12	56	10.8	11.8	5	9.5	56	14.4	16.9
4	ay	-63.45348837	-64	2437	86	AP-C3-5F-02	12	56	10.8	11.8	5	9.5	56	14.4	16.9
4	ax	-82.94623656	-82	5180	93	AP-C3-5F-02	10	56	10.8	11.8	5	9.5	56	14.4	16.9
4	ax	-61.5	-61.5	2437	98	AP-C3-5F-02	10	56	10.8	11.8	5	9.5	56	14.4	16.9
4	aw	-75.86153846	-76	5180	65	AP-C3-5F-02	8	56	10.8	11.8	5	9.5	56	14.4	16.9
4	aw	-63.16666667	-63	2437	72	AP-C3-5F-02	8	56	10.8	11.8	5	9.5	56	14.4	16.9
4	av	-79	-79	5180	84	AP-C3-5F-02	6	56	10.8	11.8	5	9.5	56	14.4	16.9
4	av	-61.73611111	-62	2437	72	AP-C3-5F-02	6	56	10.8	11.8	5	9.5	56	14.4	16.9
4	au	-78.875	-79	5180	72	AP-C3-5F-02	4	56	10.8	11.8	5	9.5	56	14.4	16.9
4	au	-69.79746835	-69	2437	79	AP-C3-5F-02	4	56	10.8	11.8	5	9.5	56	14.4	16.9
4	at	-87.5	-87.5	5180	28	AP-C3-5F-02	2	56	10.8	11.8	5	9.5	56	14.4	16.9
4	at	-68.09090909	-68	2437	77	AP-C3-5F-02	2	56	10.8	11.8	5	9.5	56	14.4	16.9
4	as	-79.02325581	-80	2437	86	AP-C3-5F-02	0	56	10.8	11.8	5	9.5	56	14.4	16.9
4	ar	-91.5	-91.5	5180	28	AP-C3-5F-02	0	54	10.8	11.8	5	9.5	56	14.4	16.9
4	ar	-82.25	-82	2437	28	AP-C3-5F-02	0	54	10.8	11.8	5	9.5	56	14.4	16.9
4	aq	-85.83783784	-86	2437	37	AP-C3-5F-02	0	52	10.8	11.8	5	9.5	56	14.4	16.9
4	ao	-86	-86	2437	35	AP-C3-5F-02	0	48	10.8	11.8	5	9.5	56	14.4	16.9
4	bg	-79.37931034	-80	2437	58	AP-C3-5F-02	28	56	10.8	11.8	5	9.5	56	14.4	16.9
4	bf	-81.76666667	-82	2437	30	AP-C3-5F-02	26	56	10.8	11.8	5	9.5	56	14.4	16.9
4	be	-79.68181818	-79	2437	44	AP-C3-5F-02	24	56	10.8	11.8	5	9.5	56	14.4	16.9
4	bd	-91	-91	5180	14	AP-C3-5F-02	22	56	10.8	11.8	5	9.5	56	14.4	16.9
4	bd	-77.36923077	-77	2437	65	AP-C3-5F-02	22	56	10.8	11.8	5	9.5	56	14.4	16.9
4	bc	-95	-95	5180	2	AP-C3-5F-02	20	56	10.8	11.8	5	9.5	56	14.4	16.9
4	bc	-74.42857143	-74	2437	49	AP-C3-5F-02	20	56	10.8	11.8	5	9.5	56	14.4	16.9
4	bb	-90.33333333	-92	5180	21	AP-C3-5F-02	18	56	10.8	11.8	5	9.5	56	14.4	16.9
4	bb	-71.07692308	-71	2437	65	AP-C3-5F-02	18	56	10.8	11.8	5	9.5	56	14.4	16.9
4	ba	-86.7721519	-86	5180	79	AP-C3-5F-02	16	56	10.8	11.8	5	9.5	56	14.4	16.9
4	ba	-67.3	-66	2437	70	AP-C3-5F-02	16	56	10.8	11.8	5	9.5	56	14.4	16.9
\.


--
-- Data for Name: location_table; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.location_table (id, location_floor, building, location, location_x, location_y, location_y_floor, location_y_height) FROM stdin;
1	3	C	a	32	0	7.2	8.2
2	3	C	b	30	0	7.2	8.2
3	3	C	c	28	0	7.2	8.2
4	3	C	d	26	0	7.2	8.2
5	3	C	e	24	0	7.2	8.2
6	3	C	f	22	0	7.2	8.2
7	3	C	g	20	0	7.2	8.2
8	3	C	h	18	0	7.2	8.2
9	3	C	i	16	0	7.2	8.2
10	3	C	j	14	0	7.2	8.2
11	3	C	k	12	0	7.2	8.2
12	3	C	l	10	0	7.2	8.2
13	3	C	m	8	0	7.2	8.2
14	3	C	n	6	0	7.2	8.2
15	3	C	o	4	0	7.2	8.2
16	3	C	p	2	0	7.2	8.2
17	3	C	q	0	0	7.2	8.2
18	3	C2	r	0	2	7.2	8.2
19	3	C2	s	0	4	7.2	8.2
20	3	C2	t	0	6	7.2	8.2
21	3	C2	u	0	8	7.2	8.2
22	3	C2	v	0	10	7.2	8.2
23	3	C2	w	0	12	7.2	8.2
24	3	C2	x	0	14	7.2	8.2
25	3	C2	y	0	16	7.2	8.2
26	3	C2	z	0	18	7.2	8.2
27	3	C2	aa	0	20	7.2	8.2
28	3	C2	ab	0	22	7.2	8.2
29	3	C2	ac	0	24	7.2	8.2
30	3	C2	ad	0	26	7.2	8.2
31	3	C2	ae	0	28	7.2	8.2
32	3	C2	af	0	30	7.2	8.2
33	3	C2	ag	0	32	7.2	8.2
34	3	C2	ah	0	34	7.2	8.2
35	3	C2	ai	0	36	7.2	8.2
36	3	C2	aj	0	38	7.2	8.2
37	3	C2	ak	0	40	7.2	8.2
38	3	C2	al	0	42	7.2	8.2
39	3	C2	am	0	44	7.2	8.2
40	3	C2	an	0	46	7.2	8.2
41	3	C2	ao	0	48	7.2	8.2
42	3	C2	ap	0	50	7.2	8.2
43	3	C2	aq	0	52	7.2	8.2
44	3	C2	ar	0	54	7.2	8.2
45	3	C2	as	0	56	7.2	8.2
46	3	C3	at	2	56	7.2	8.2
47	3	C3	au	4	56	7.2	8.2
48	3	C3	av	6	56	7.2	8.2
49	3	C3	aw	8	56	7.2	8.2
50	3	C3	ax	10	56	7.2	8.2
51	3	C3	ay	12	56	7.2	8.2
52	3	C3	az	14	56	7.2	8.2
53	3	C3	ba	16	56	7.2	8.2
54	3	C3	bb	18	56	7.2	8.2
55	3	C3	bc	20	56	7.2	8.2
56	3	C3	bd	22	56	7.2	8.2
57	3	C3	be	24	56	7.2	8.2
58	3	C3	bf	26	56	7.2	8.2
59	3	C3	bg	28	56	7.2	8.2
60	4	C	a	32	0	10.8	11.8
61	4	C	b	30	0	10.8	11.8
62	4	C	c	28	0	10.8	11.8
63	4	C	d	26	0	10.8	11.8
64	4	C	e	24	0	10.8	11.8
65	4	C	f	22	0	10.8	11.8
66	4	C	g	20	0	10.8	11.8
67	4	C	h	18	0	10.8	11.8
68	4	C	i	16	0	10.8	11.8
69	4	C	j	14	0	10.8	11.8
70	4	C	k	12	0	10.8	11.8
71	4	C	l	10	0	10.8	11.8
72	4	C	m	8	0	10.8	11.8
73	4	C	n	6	0	10.8	11.8
74	4	C	o	4	0	10.8	11.8
75	4	C	p	2	0	10.8	11.8
76	4	C	q	0	0	10.8	11.8
77	4	C2	r	0	2	10.8	11.8
78	4	C2	s	0	4	10.8	11.8
79	4	C2	t	0	6	10.8	11.8
80	4	C2	u	0	8	10.8	11.8
81	4	C2	v	0	10	10.8	11.8
82	4	C2	w	0	12	10.8	11.8
83	4	C2	x	0	14	10.8	11.8
84	4	C2	y	0	16	10.8	11.8
85	4	C2	z	0	18	10.8	11.8
86	4	C2	aa	0	20	10.8	11.8
87	4	C2	ab	0	22	10.8	11.8
88	4	C2	ac	0	24	10.8	11.8
89	4	C2	ad	0	26	10.8	11.8
90	4	C2	ae	0	28	10.8	11.8
91	4	C2	af	0	30	10.8	11.8
92	4	C2	ag	0	32	10.8	11.8
93	4	C2	ah	0	34	10.8	11.8
94	4	C2	ai	0	36	10.8	11.8
95	4	C2	aj	0	38	10.8	11.8
96	4	C2	ak	0	40	10.8	11.8
97	4	C2	al	0	42	10.8	11.8
98	4	C2	am	0	44	10.8	11.8
99	4	C2	an	0	46	10.8	11.8
100	4	C2	ao	0	48	10.8	11.8
101	4	C2	ap	0	50	10.8	11.8
102	4	C2	aq	0	52	10.8	11.8
103	4	C2	ar	0	54	10.8	11.8
104	4	C2	as	0	56	10.8	11.8
105	4	C3	at	2	56	10.8	11.8
106	4	C3	au	4	56	10.8	11.8
107	4	C3	av	6	56	10.8	11.8
108	4	C3	aw	8	56	10.8	11.8
109	4	C3	ax	10	56	10.8	11.8
110	4	C3	ay	12	56	10.8	11.8
111	4	C3	az	14	56	10.8	11.8
112	4	C3	ba	16	56	10.8	11.8
113	4	C3	bb	18	56	10.8	11.8
114	4	C3	bc	20	56	10.8	11.8
115	4	C3	bd	22	56	10.8	11.8
116	4	C3	be	24	56	10.8	11.8
117	4	C3	bf	26	56	10.8	11.8
118	4	C3	bg	28	56	10.8	11.8
\.


--
-- Data for Name: measured_table; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.measured_table (id, location_floor, location, ave_dbm, med_dbm, center_freq_mhz, counts_per_100, ap_name) FROM stdin;
1	3	a	-62.71111111	-62	2437	45	AP-C-2F-01
2	3	a	-76	-76	2437	7	AP-C-2F-02
3	3	a	-36.45	-36	2437	100	AP-C-3F-02
4	3	a	-61.61	-63	2437	100	AP-C-3F-03
5	3	a	-61.62365591	-62	2437	93	AP-C-3F-04
6	3	a	-57.45	-58	2437	100	AP-C-4F-02
7	3	a	-77.33333333	-76	2437	21	AP-C-4F-03
8	3	a	-86	-86	2437	55	AP-C-4F-04
9	3	a	-79	-79	2437	55	AP-C-5F-02
10	3	a	-79	-79	2437	55	AP-C-5F-03
11	3	a	-79	-79	2437	10	AP-C1-2F-01
12	3	a	-60.21	-60	2437	100	AP-C1-3F-01
13	3	a	-87.7311828	-88	5180	93	AP-C-2F-01
14	3	a	-58.11	-58	5180	100	AP-C-3F-02
15	3	a	-68.01	-68	5180	100	AP-C-3F-03
16	3	a	-77.01449275	-76	5180	69	AP-C-3F-04
17	3	a	-75.33333333	-75	5180	21	AP-C-4F-02
18	3	a	-87.86666667	-88	5180	45	AP-C-4F-03
19	3	a	-66.83544304	-67	5180	79	AP-C1-3F-01
20	3	aa	-77.54166667	-78	2437	24	AP-C-3F-01
21	3	aa	-73.19354839	-73	2437	31	AP-C2-1F-01
22	3	aa	-81.46666667	-82	2437	30	AP-C2-1F-02
23	3	aa	-56.56989247	-56	2437	93	AP-C2-2F-01
24	3	aa	-64.17	-64	2437	100	AP-C2-2F-02
25	3	aa	-55.55913978	-56	2437	93	AP-C2-3F-01
26	3	aa	-59.63	-60	2437	100	AP-C2-3F-02
27	3	aa	-57.58139535	-57	2437	86	AP-C2-3F-03
28	3	aa	-55.21	-55	2437	100	AP-C2-4F-01
29	3	aa	-73.95698925	-74	2437	93	AP-C2-4F-02
30	3	aa	-81.66666667	-81.5	2437	42	AP-C2-4F-03
31	3	aa	-73	-73	2437	35	AP-C2-5F-01
32	3	aa	-79.16216216	-79	2437	37	AP-C2-5F-02
33	3	aa	-83.53846154	-84	2437	13	AP-C2-6F-01
34	3	aa	-82	-82	2437	7	AP-C3-3F-03
35	3	aa	-67.7	-67	5180	100	AP-C2-2F-01
36	3	aa	-88.625	-88.5	5180	56	AP-C2-2F-02
37	3	aa	-63.05	-63	5180	100	AP-C2-3F-01
38	3	aa	-70.34	-71	5180	100	AP-C2-3F-02
39	3	aa	-70.3	-70	5180	100	AP-C2-3F-03
40	3	aa	-77.4	-78	5180	10	AP-C2-4F-01
41	3	ab	-77.5	-77.5	2437	14	AP-C-3F-01
42	3	ab	-61.40697674	-61	2437	86	AP-C2-1F-01
43	3	ab	-81	-81	2437	7	AP-C2-1F-02
44	3	ab	-86	-86	2437	7	AP-C2-1F-03
45	3	ab	-59.4516129	-60	2437	93	AP-C2-2F-01
46	3	ab	-67.33333333	-67	2437	84	AP-C2-2F-02
47	3	ab	-78.76666667	-79	2437	30	AP-C2-2F-03
48	3	ab	-52.28	-53	2437	100	AP-C2-3F-01
49	3	ab	-51.4	-50	2437	100	AP-C2-3F-02
50	3	ab	-64.72307692	-66	2437	65	AP-C2-3F-03
51	3	ab	-57.93	-58	2437	100	AP-C2-4F-01
52	3	ab	-63.80645161	-63	2437	93	AP-C2-4F-02
53	3	ab	-73.44827586	-72	2437	58	AP-C2-4F-03
54	3	ab	-72.64864865	-74	2437	37	AP-C2-5F-01
55	3	ab	-80.75675676	-81	2437	37	AP-C2-5F-02
56	3	ab	-86	-86	2437	7	AP-C2-5F-03
57	3	ab	-81.4	-82	2437	35	AP-C3-3F-03
58	3	ab	-78.98611111	-80	5180	72	AP-C2-2F-01
59	3	ab	-87.43037975	-87	5180	79	AP-C2-2F-02
60	3	ab	-68.56962025	-68	5180	79	AP-C2-3F-01
61	3	ac	-80.83333333	-81	2437	42	AP-C-3F-01
62	3	ac	-71.23076923	-72	2437	65	AP-C2-1F-01
63	3	ac	-82	-82	2437	7	AP-C2-1F-02
64	3	ac	-61.11	-61	2437	100	AP-C2-2F-01
65	3	ac	-62.38	-63	2437	100	AP-C2-2F-02
66	3	ac	-72.8	-72	2437	35	AP-C2-2F-03
67	3	ac	-63.60465116	-64	2437	86	AP-C2-3F-01
68	3	ac	-50.37	-50	2437	100	AP-C2-3F-02
69	3	ac	-63.34	-63	2437	100	AP-C2-3F-03
70	3	ac	-60.34408602	-60	2437	93	AP-C2-4F-01
71	3	ac	-75.66666667	-76.5	2437	84	AP-C2-4F-02
72	3	ac	-70.44444444	-70	2437	63	AP-C2-4F-03
73	3	ac	-81.8	-84	2437	35	AP-C2-5F-01
74	3	ac	-64.71428571	-65	2437	49	AP-C2-5F-02
75	3	ac	-84	-83	2437	21	AP-C2-5F-03
76	3	ac	-86	-86	2437	7	AP-C2-6F-01
77	3	ac	-84.33333333	-84	2437	21	AP-C2-6F-02
78	3	ac	-81	-81	2437	14	AP-C3-3F-03
79	3	ac	-92	-92	5180	7	AP-C2-1F-01
80	3	ac	-82.86075949	-83	5180	79	AP-C2-2F-01
81	3	ac	-81	-81	5180	15	AP-C2-2F-02
82	3	ad	-77	-77	2437	14	AP-C-3F-01
83	3	ad	-84	-84	2437	14	AP-C2-1F-01
84	3	ad	-83.875	-83	2437	16	AP-C2-1F-02
85	3	ad	-75.83544304	-76	2437	79	AP-C2-2F-01
86	3	ad	-56.68	-57	2437	100	AP-C2-2F-02
87	3	ad	-81.85714286	-81	2437	49	AP-C2-2F-03
88	3	ad	-62.84810127	-64	2437	79	AP-C2-3F-01
89	3	ad	-45.42	-45	2437	100	AP-C2-3F-02
90	3	ad	-63.06	-63	2437	100	AP-C2-3F-03
91	3	ad	-62.24731183	-62	2437	93	AP-C2-4F-01
92	3	ad	-63.50537634	-64	2437	93	AP-C2-4F-02
93	3	ad	-69.97468354	-70	2437	79	AP-C2-4F-03
94	3	ad	-71.97727273	-72	2437	44	AP-C2-5F-01
95	3	ad	-75.04615385	-75	2437	65	AP-C2-5F-02
96	3	ad	-86.41176471	-86	2437	51	AP-C2-5F-03
97	3	ad	-78.9	-80	2437	30	AP-C3-3F-03
98	3	ad	-87.54545455	-88	5180	77	AP-C2-2F-01
99	3	ad	-79.5	-78	5180	86	AP-C2-2F-02
100	3	ad	-90.5	-90.5	5180	14	AP-C2-2F-03
101	3	ad	-76.65	-77	5180	20	AP-C2-3F-01
102	3	ae	-77.5	-77.5	2437	14	AP-C-3F-01
103	3	ae	-77.2173913	-77	2437	23	AP-C2-1F-01
104	3	ae	-69.46666667	-69	2437	30	AP-C2-1F-02
105	3	ae	-86	-86	2437	7	AP-C2-1F-03
106	3	ae	-74.66666667	-75.5	2437	42	AP-C2-2F-01
107	3	ae	-56.43010753	-56	2437	93	AP-C2-2F-02
108	3	ae	-75.2	-75	2437	35	AP-C2-2F-03
109	3	ae	-63.27956989	-63	2437	93	AP-C2-3F-01
110	3	ae	-41.67	-42	2437	100	AP-C2-3F-02
111	3	ae	-57.72	-58	2437	100	AP-C2-3F-03
112	3	ae	-60.68	-61	2437	100	AP-C2-4F-01
113	3	ae	-60.14	-60	2437	100	AP-C2-4F-02
114	3	ae	-66.66666667	-66	2437	93	AP-C2-4F-03
115	3	ae	-79.8	-79	2437	35	AP-C2-5F-01
116	3	ae	-70.5	-70	2437	56	AP-C2-5F-02
117	3	ae	-83.43333333	-84	2437	30	AP-C2-5F-03
118	3	ae	-88	-88	2437	7	AP-C2-6F-02
119	3	ae	-84.34782609	-84	2437	23	AP-C3-3F-03
120	3	ae	-72.1	-73	5180	100	AP-C2-2F-02
121	3	ae	-90.66666667	-91	5180	21	AP-C2-2F-03
122	3	ae	-77.84313725	-78	5180	51	AP-C2-3F-01
123	3	af	-77.59090909	-78	2437	22	AP-C-3F-01
124	3	af	-86	-86	2437	7	AP-C2-1F-01
125	3	af	-82.54385965	-84	2437	57	AP-C2-1F-02
126	3	af	-85.96551724	-85	2437	29	AP-C2-1F-03
127	3	af	-72.88888889	-73	2437	72	AP-C2-2F-01
128	3	af	-62.83	-62	2437	100	AP-C2-2F-02
129	3	af	-70.28	-71	2437	50	AP-C2-2F-03
130	3	af	-75.24324324	-75	2437	37	AP-C2-3F-01
131	3	af	-39.09	-37	2437	100	AP-C2-3F-02
132	3	af	-59.01010101	-59	2437	99	AP-C2-3F-03
133	3	af	-62.20430108	-62	2437	93	AP-C2-4F-01
134	3	af	-64.33	-64	2437	100	AP-C2-4F-02
135	3	af	-65.47311828	-65	2437	93	AP-C2-4F-03
136	3	af	-84.5	-85	2437	42	AP-C2-5F-01
137	3	af	-77.27777778	-77	2437	36	AP-C2-5F-02
138	3	af	-81.22222222	-81	2437	63	AP-C2-5F-03
139	3	af	-87.68181818	-88	2437	22	AP-C2-6F-02
140	3	af	-86.75	-87	2437	8	AP-C3-2F-03
141	3	af	-85.18	-86	2437	50	AP-C3-3F-01
142	3	af	-84.72	-85	2437	25	AP-C3-3F-03
143	3	ag	-80.13636364	-79	2437	44	AP-C2-1F-02
144	3	ag	-82	-82	2437	14	AP-C2-1F-03
145	3	ag	-80	-81	2437	28	AP-C2-2F-01
146	3	ag	-59.44	-60	2437	100	AP-C2-2F-02
147	3	ag	-69.17721519	-69	2437	79	AP-C2-2F-03
148	3	ag	-68.41666667	-68	2437	84	AP-C2-3F-01
149	3	ag	-40.14	-38	2437	100	AP-C2-3F-02
150	3	ag	-66.16	-65	2437	100	AP-C2-3F-03
151	3	ag	-73.63636364	-74	2437	77	AP-C2-4F-01
152	3	ag	-59.51	-59	2437	100	AP-C2-4F-02
153	3	ag	-62.83870968	-63	2437	93	AP-C2-4F-03
154	3	ag	-76.33333333	-76	2437	21	AP-C2-5F-02
155	3	ag	-75.22727273	-75	2437	44	AP-C2-5F-03
156	3	ag	-86	-86	2437	7	AP-C2-6F-03
157	3	ag	-86.66666667	-87	2437	21	AP-C3-3F-01
158	3	ag	-84.5	-84.5	2437	14	AP-C3-3F-03
159	3	ag	-76.29113924	-76	5180	79	AP-C2-2F-02
160	3	ag	-90	-90	5180	7	AP-C2-2F-03
161	3	ag	-76.625	-76.5	5180	56	AP-C2-3F-01
162	3	ag	-57.44	-57	5180	100	AP-C2-3F-02
163	3	ag	-67.75531915	-69	5180	94	AP-C2-3F-03
164	3	ah	-84	-84	2437	21	AP-C2-1F-02
165	3	ah	-79.28571429	-80	2437	49	AP-C2-1F-03
166	3	ah	-77.375	-78	2437	56	AP-C2-2F-01
167	3	ah	-64.03	-64	2437	100	AP-C2-2F-02
168	3	ah	-62.64285714	-63	2437	98	AP-C2-2F-03
169	3	ah	-75	-77	2437	21	AP-C2-3F-01
170	3	ah	-42.33	-41	2437	100	AP-C2-3F-02
171	3	ah	-60.47	-60	2437	100	AP-C2-3F-03
172	3	ah	-81	-81.5	2437	42	AP-C2-4F-01
173	3	ah	-63.94623656	-64	2437	93	AP-C2-4F-02
174	3	ah	-63.5483871	-64	2437	93	AP-C2-4F-03
175	3	ah	-81	-82	2437	49	AP-C2-5F-02
176	3	ah	-70.40909091	-71	2437	44	AP-C2-5F-03
177	3	ah	-87.375	-87	2437	16	AP-C3-3F-01
178	3	ah	-83.8	-83	2437	35	AP-C3-3F-03
179	3	ah	-82.22222222	-83	5180	72	AP-C2-2F-02
180	3	ah	-85.22222222	-85	5180	63	AP-C2-2F-03
181	3	ah	-82.77777778	-83	5180	63	AP-C2-3F-01
182	3	ah	-64.21	-65	5180	100	AP-C2-3F-02
183	3	ah	-63.6	-64	5180	35	AP-C2-3F-03
184	3	ai	-79	-79	2437	7	AP-C-3F-01
185	3	ai	-77.77777778	-77	2437	63	AP-C2-1F-02
186	3	ai	-77.75	-78	2437	28	AP-C2-1F-03
187	3	ai	-80	-80	2437	14	AP-C2-2F-01
188	3	ai	-68.30107527	-68	2437	93	AP-C2-2F-02
189	3	ai	-73.75	-74.5	2437	84	AP-C2-2F-03
190	3	ai	-77.83333333	-77.5	2437	42	AP-C2-3F-01
191	3	ai	-56.57	-57	2437	100	AP-C2-3F-02
192	3	ai	-53.1	-54	2437	100	AP-C2-3F-03
193	3	ai	-75.4	-76	2437	35	AP-C2-4F-01
194	3	ai	-61.44	-61	2437	100	AP-C2-4F-02
195	3	ai	-57.87	-57	2437	100	AP-C2-4F-03
196	3	ai	-79.51724138	-80	2437	58	AP-C2-5F-02
197	3	ai	-76.6	-77	2437	35	AP-C2-5F-03
198	3	ai	-86.25	-86.5	2437	28	AP-C2-6F-02
199	3	ai	-86.75	-86.5	2437	28	AP-C2-6F-03
200	3	ai	-86	-86	2437	7	AP-C3-2F-03
201	3	ai	-85.66666667	-86	2437	21	AP-C3-3F-01
202	3	ai	-78.18461538	-78	2437	65	AP-C3-3F-03
203	3	ai	-91	-91	5180	2	AP-C1-3F-03
204	3	ai	-82.16455696	-82	5180	79	AP-C2-2F-02
205	3	ai	-88.16666667	-87	5180	84	AP-C2-2F-03
206	3	ai	-80.38461538	-81	5180	65	AP-C2-3F-01
207	3	ai	-64.6	-65	5180	100	AP-C2-3F-02
208	3	ai	-61	-61	5180	4	AP-C2-3F-03
209	3	aj	-82.33333333	-83	2437	9	AP-C-3F-01
210	3	aj	-86.33333333	-86	2437	21	AP-C2-1F-02
211	3	aj	-71.75	-72	2437	44	AP-C2-1F-03
212	3	aj	-75.83333333	-75	2437	42	AP-C2-2F-02
213	3	aj	-63.96774194	-64	2437	93	AP-C2-2F-03
214	3	aj	-74.62790698	-75	2437	86	AP-C2-3F-01
215	3	aj	-56.56	-57	2437	100	AP-C2-3F-02
216	3	aj	-48.69	-48	2437	100	AP-C2-3F-03
217	3	aj	-78.90277778	-79	2437	72	AP-C2-4F-01
218	3	aj	-65.91	-65	2437	100	AP-C2-4F-02
219	3	aj	-53.56	-54	2437	100	AP-C2-4F-03
220	3	aj	-76.25	-77.5	2437	28	AP-C2-5F-02
221	3	aj	-70.08139535	-70	2437	86	AP-C2-5F-03
222	3	aj	-81.5	-81.5	2437	14	AP-C2-6F-03
223	3	aj	-81.16666667	-81.5	2437	42	AP-C3-3F-03
224	3	aj	-90.27272727	-90	5180	44	AP-C2-2F-02
225	3	aj	-81.35384615	-81	5180	65	AP-C2-2F-03
226	3	aj	-85	-85	5180	63	AP-C2-3F-01
227	3	aj	-72.22093023	-72	5180	86	AP-C2-3F-02
228	3	aj	-66.53	-67	5180	100	AP-C2-3F-03
229	3	aj	-86.45833333	-86	5180	72	AP-C2-4F-02
230	3	aj	-81.42	-82	5180	50	AP-C2-4F-03
231	3	ak	-83.08108108	-84	2437	37	AP-C-3F-01
232	3	ak	-75	-75	2437	35	AP-C2-1F-03
233	3	ak	-81.31914894	-81	2437	47	AP-C2-2F-02
234	3	ak	-62.94623656	-63	2437	93	AP-C2-2F-03
235	3	ak	-75.3655914	-76	2437	93	AP-C2-3F-01
236	3	ak	-63.87	-64	2437	100	AP-C2-3F-02
237	3	ak	-46.25	-46	2437	100	AP-C2-3F-03
238	3	ak	-92	-92	2437	7	AP-C2-4F-01
239	3	ak	-71.53	-72	2437	100	AP-C2-4F-02
240	3	ak	-52.92	-53	2437	100	AP-C2-4F-03
241	3	ak	-82.75	-83	2437	28	AP-C2-5F-02
242	3	ak	-69.98837209	-69	2437	86	AP-C2-5F-03
243	3	ak	-81.83783784	-82	2437	37	AP-C3-2F-03
244	3	ak	-68.76666667	-69	2437	60	AP-C3-3F-03
245	3	ak	-77.37078652	-78	5180	89	AP-C2-2F-03
246	3	ak	-86.81538462	-87	5180	65	AP-C2-3F-01
247	3	ak	-74.57303371	-74	5180	89	AP-C2-3F-02
248	3	ak	-60.64	-60	5180	100	AP-C2-3F-03
249	3	ak	-89.5625	-90	5180	16	AP-C2-4F-02
250	3	al	-80.5	-80.5	2437	42	AP-C2-1F-03
251	3	al	-80.75	-80.5	2437	28	AP-C2-2F-02
252	3	al	-49.81	-51	2437	100	AP-C2-2F-03
253	3	al	-75.12307692	-74	2437	65	AP-C2-3F-01
254	3	al	-62.32	-62	2437	100	AP-C2-3F-02
255	3	al	-39.82	-39	2437	100	AP-C2-3F-03
256	3	al	-85.25	-86.5	2437	28	AP-C2-4F-01
257	3	al	-78.66666667	-78	2437	63	AP-C2-4F-02
258	3	al	-63.31	-63	2437	100	AP-C2-4F-03
259	3	al	-73.51388889	-74	2437	72	AP-C2-5F-03
260	3	al	-85	-84	2437	35	AP-C3-3F-01
261	3	al	-82.33333333	-83	2437	21	AP-C3-3F-02
262	3	al	-66.72307692	-66	2437	65	AP-C3-3F-03
263	3	al	-91.625	-91	5180	56	AP-C2-1F-03
264	3	al	-70.59	-71	5180	100	AP-C2-2F-03
265	3	al	-84.33333333	-85	5180	42	AP-C2-3F-01
266	3	al	-73.37634409	-73	5180	93	AP-C2-3F-02
267	3	al	-54	-54	5180	100	AP-C2-3F-03
268	3	al	-79.27956989	-80	5180	93	AP-C2-4F-03
269	3	al	-87.48101266	-87	5180	79	AP-C3-3F-01
270	3	al	-91.33333333	-91	5180	42	AP-C3-3F-02
271	3	al	-84	-84	5180	2	AP-C3-3F-03
272	3	am	-84	-84	2437	7	AP-C-3F-01
273	3	am	-72.67692308	-73	2437	65	AP-C2-1F-03
274	3	am	-82.33333333	-82	2437	30	AP-C2-2F-02
275	3	am	-57.14	-57	2437	100	AP-C2-2F-03
276	3	am	-74.21538462	-74	2437	65	AP-C2-3F-01
277	3	am	-64.98924731	-64	2437	93	AP-C2-3F-02
278	3	am	-41.12	-41	2437	100	AP-C2-3F-03
279	3	am	-85.33333333	-85	2437	21	AP-C2-4F-01
280	3	am	-78.68055556	-79	2437	72	AP-C2-4F-02
281	3	am	-59.44	-60	2437	100	AP-C2-4F-03
282	3	am	-81.04545455	-81	2437	44	AP-C2-5F-02
283	3	am	-80.75	-81	2437	28	AP-C2-5F-03
284	3	am	-87	-87	2437	28	AP-C2-6F-03
285	3	am	-80	-80	2437	56	AP-C3-2F-03
286	3	am	-86	-86	2437	7	AP-C3-3F-01
287	3	am	-82	-82	2437	7	AP-C3-3F-02
288	3	am	-76.35294118	-76	2437	51	AP-C3-3F-03
289	3	am	-76.77419355	-77	5180	93	AP-C2-2F-03
290	3	am	-83.4	-83.5	5180	70	AP-C2-3F-02
291	3	am	-52.4	-52	5180	100	AP-C2-3F-03
292	3	am	-76.18181818	-76	5180	77	AP-C2-4F-03
293	3	am	-87.22222222	-88	5180	63	AP-C3-3F-02
294	3	am	-86	-86	5180	14	AP-C3-3F-03
295	3	an	-84.4	-83	2437	35	AP-C-3F-01
296	3	an	-75.85714286	-76	2437	49	AP-C2-1F-03
297	3	an	-87	-87	2437	7	AP-C2-2F-01
298	3	an	-83.05405405	-83	2437	37	AP-C2-2F-02
299	3	an	-61.65591398	-62	2437	93	AP-C2-2F-03
300	3	an	-73.27272727	-73	2437	77	AP-C2-3F-01
301	3	an	-70.03488372	-70	2437	86	AP-C2-3F-02
302	3	an	-38.65	-39	2437	100	AP-C2-3F-03
303	3	an	-82.8	-82	2437	35	AP-C2-4F-01
304	3	an	-77	-76	2437	84	AP-C2-4F-02
305	3	an	-64.6344086	-65	2437	93	AP-C2-4F-03
306	3	an	-81.5	-82	2437	28	AP-C2-5F-03
307	3	an	-82.11111111	-82	2437	63	AP-C3-2F-03
308	3	an	-78.14285714	-78	2437	49	AP-C3-3F-01
309	3	an	-79	-78.5	2437	42	AP-C3-3F-02
310	3	an	-71.81818182	-72	2437	77	AP-C3-3F-03
311	3	an	-76.69767442	-77	5180	86	AP-C2-2F-03
312	3	an	-82.93846154	-83	5180	65	AP-C2-3F-02
313	3	an	-57.09	-57	5180	100	AP-C2-3F-03
314	3	an	-90	-90	5180	7	AP-C2-4F-02
315	3	an	-84.51111111	-85	5180	45	AP-C2-4F-03
316	3	ao	-77.81081081	-78	2437	37	AP-C-3F-01
317	3	ao	-86	-86	2437	7	AP-C2-1F-03
318	3	ao	-83	-83	2437	7	AP-C2-2F-02
319	3	ao	-63.49	-63	2437	100	AP-C2-2F-03
320	3	ao	-78.5	-78.5	2437	14	AP-C2-3F-01
321	3	ao	-66.65	-67	2437	100	AP-C2-3F-02
322	3	ao	-48.1	-48	2437	100	AP-C2-3F-03
323	3	ao	-76	-76	2437	9	AP-C2-4F-02
324	3	ao	-73.72151899	-74	2437	79	AP-C2-4F-03
325	3	ao	-83.54901961	-84	2437	51	AP-C3-2F-03
326	3	ao	-81	-81	2437	28	AP-C3-3F-01
327	3	ao	-83.5	-83.5	2437	14	AP-C3-3F-02
328	3	ao	-61.46153846	-61	2437	91	AP-C3-3F-03
329	3	ao	-83	-83	2437	14	AP-C3-4F-02
330	3	ao	-84.45454545	-84	5180	77	AP-C2-2F-03
331	3	ao	-85.37931034	-85	5180	58	AP-C2-3F-01
332	3	ao	-82.45833333	-84	5180	72	AP-C2-3F-02
333	3	ao	-57.8	-57	5180	100	AP-C2-3F-03
334	3	ao	-89.14285714	-89	5180	49	AP-C2-4F-03
335	3	ao	-85.83544304	-86	5180	79	AP-C3-3F-01
336	3	ao	-86.2	-87	5180	65	AP-C3-3F-02
337	3	ao	-81	-80.5	5180	56	AP-C3-3F-03
338	3	ap	-81.75	-81.5	2437	28	AP-C-3F-01
339	3	ap	-88	-88	2437	2	AP-C2-2F-01
340	3	ap	-86.5	-87	2437	56	AP-C2-2F-02
341	3	ap	-75.80555556	-76	2437	72	AP-C2-2F-03
342	3	ap	-73.75	-76	2437	56	AP-C2-3F-01
343	3	ap	-68.66666667	-69	2437	72	AP-C2-3F-02
344	3	ap	-60.68817204	-60	2437	93	AP-C2-3F-03
345	3	ap	-83.83333333	-83.5	2437	42	AP-C2-4F-03
346	3	ap	-84.125	-85	2437	16	AP-C2-5F-03
347	3	ap	-66.69892473	-67	2437	93	AP-C3-2F-03
348	3	ap	-81.16666667	-80	2437	42	AP-C3-3F-01
349	3	ap	-80.48275862	-81	2437	58	AP-C3-3F-02
350	3	ap	-59.19	-60	2437	100	AP-C3-3F-03
351	3	ap	-83.66666667	-84	2437	42	AP-C3-4F-02
352	3	ap	-89.11111111	-89	5180	63	AP-C2-2F-03
353	3	ap	-86.93103448	-87	5180	58	AP-C2-3F-01
354	3	ap	-81.16666667	-81.5	5180	84	AP-C2-3F-02
355	3	ap	-70.07526882	-70	5180	93	AP-C2-3F-03
356	3	ap	-89.91304348	-91	5180	23	AP-C3-3F-01
357	3	ap	-85.24137931	-85	5180	58	AP-C3-3F-02
358	3	ap	-74.22093023	-73	5180	86	AP-C3-3F-03
359	3	aq	-80.86363636	-80	2437	44	AP-C-3F-01
360	3	aq	-85.58823529	-86	2437	51	AP-C2-2F-02
361	3	aq	-77.44444444	-77	2437	63	AP-C2-2F-03
362	3	aq	-72.39240506	-73	2437	79	AP-C2-3F-01
363	3	aq	-76.48611111	-76	2437	72	AP-C2-3F-02
364	3	aq	-60.33	-60	2437	100	AP-C2-3F-03
365	3	aq	-85	-85	2437	7	AP-C2-4F-01
366	3	aq	-85.5	-85.5	2437	14	AP-C2-4F-02
367	3	aq	-79.9137931	-79	2437	58	AP-C2-4F-03
368	3	aq	-86.4375	-86	2437	16	AP-C3-2F-02
369	3	aq	-67.84	-67	2437	100	AP-C3-2F-03
370	3	aq	-71.92307692	-72	2437	91	AP-C3-3F-01
371	3	aq	-80.6	-80	2437	65	AP-C3-3F-02
372	3	aq	-57.42	-57	2437	100	AP-C3-3F-03
373	3	aq	-91	-91	5180	7	AP-C2-2F-03
374	3	aq	-88.5	-88.5	5180	14	AP-C2-3F-01
375	3	aq	-84.09230769	-84	5180	65	AP-C2-3F-02
376	3	aq	-75.24050633	-75	5180	79	AP-C2-3F-03
377	3	aq	-87.13924051	-87	5180	79	AP-C3-2F-03
378	3	aq	-82.94936709	-82	5180	79	AP-C3-3F-01
379	3	aq	-85.64615385	-86	5180	65	AP-C3-3F-02
380	3	aq	-73.01	-74	5180	100	AP-C3-3F-03
381	3	ar	-83.25	-84	2437	28	AP-C-3F-01
382	3	ar	-76.60344828	-76	2437	58	AP-C2-2F-03
383	3	ar	-77.71428571	-77	2437	49	AP-C2-3F-01
384	3	ar	-76.14285714	-76	2437	49	AP-C2-3F-02
385	3	ar	-63.02	-63	2437	100	AP-C2-3F-03
386	3	ar	-76.1	-76	2437	70	AP-C2-4F-03
387	3	ar	-86.5	-86.5	2437	14	AP-C3-1F-02
388	3	ar	-66.93	-67	2437	100	AP-C3-2F-03
389	3	ar	-79.27586207	-80	2437	58	AP-C3-3F-01
390	3	ar	-70.07142857	-71	2437	98	AP-C3-3F-02
391	3	ar	-47.98	-48	2437	100	AP-C3-3F-03
392	3	ar	-88	-88	2437	7	AP-C3-4F-01
393	3	ar	-74.46835443	-74	2437	79	AP-C3-4F-02
394	3	ar	-91	-91	5180	7	AP-C2-2F-03
395	3	ar	-88.71428571	-89	5180	49	AP-C2-3F-01
396	3	ar	-81.23255814	-80	5180	86	AP-C2-3F-02
397	3	ar	-74.86111111	-75	5180	72	AP-C2-3F-03
398	3	ar	-86.75268817	-87	5180	93	AP-C3-2F-03
399	3	ar	-84.72727273	-86	5180	77	AP-C3-3F-01
400	3	ar	-78.63636364	-78	5180	77	AP-C3-3F-02
401	3	ar	-65.77	-65	5180	100	AP-C3-3F-03
402	3	as	-82	-82	2437	7	AP-C-3F-01
403	3	as	-84	-83	2437	21	AP-C2-2F-02
404	3	as	-78.86666667	-78	2437	30	AP-C2-2F-03
405	3	as	-71	-71	2437	63	AP-C2-3F-01
406	3	as	-73.7	-73	2437	70	AP-C2-3F-02
407	3	as	-61.58064516	-62	2437	93	AP-C2-3F-03
408	3	as	-83.5	-83.5	2437	42	AP-C2-4F-01
409	3	as	-83	-83	2437	7	AP-C2-4F-02
410	3	as	-74.76666667	-75	2437	30	AP-C2-4F-03
411	3	as	-86	-86	2437	7	AP-C2-5F-03
412	3	as	-78.6	-79	2437	35	AP-C3-1F-02
413	3	as	-78.5	-78.5	2437	14	AP-C3-2F-01
414	3	as	-71.17241379	-71	2437	58	AP-C3-2F-02
415	3	as	-57.67	-58	2437	100	AP-C3-2F-03
416	3	as	-67.46236559	-68	2437	93	AP-C3-3F-01
417	3	as	-61.47	-61	2437	100	AP-C3-3F-02
418	3	as	-44.23	-45	2437	100	AP-C3-3F-03
419	3	as	-85.33333333	-85	2437	21	AP-C3-4F-01
420	3	as	-68.77419355	-68	2437	93	AP-C3-4F-02
421	3	as	-83	-83	2437	7	AP-C3-5F-02
422	3	as	-90	-90	5180	7	AP-C-3F-01
423	3	as	-90	-90	5180	35	AP-C2-2F-03
424	3	as	-85.6	-86	5180	35	AP-C2-3F-01
425	3	as	-69.32	-69	5180	100	AP-C2-3F-02
426	3	as	-71.86046512	-71	5180	86	AP-C2-3F-03
427	3	as	-87.83333333	-88	5180	42	AP-C2-4F-03
428	3	as	-81.5	-81	5180	56	AP-C3-2F-03
429	3	as	-72.72727273	-72	5180	77	AP-C3-3F-01
430	3	at	-77.5	-77.5	2437	14	AP-C2-3F-03
431	3	at	-82	-82	2437	14	AP-C3-1F-02
432	3	at	-71.05882353	-71	2437	51	AP-C3-2F-01
433	3	at	-74.39130435	-75	2437	69	AP-C3-2F-02
434	3	at	-50.21	-50	2437	100	AP-C3-2F-03
435	3	at	-61.88172043	-62	2437	93	AP-C3-3F-01
436	3	at	-58.56	-59	2437	100	AP-C3-3F-02
437	3	at	-48.23	-48	2437	100	AP-C3-3F-03
438	3	at	-74.2	-75	2437	35	AP-C3-4F-01
439	3	at	-64.05063291	-64	2437	79	AP-C3-4F-02
440	3	at	-80.5	-80.5	2437	14	AP-C3-5F-02
441	3	at	-88.17647059	-89	5180	34	AP-C2-3F-02
442	3	at	-85.37974684	-86	5180	79	AP-C2-3F-03
443	3	at	-91	-91	5180	3	AP-C3-2F-02
444	3	at	-74.75342466	-74	5180	73	AP-C3-2F-03
445	3	at	-74.52325581	-73	5180	86	AP-C3-3F-01
446	3	at	-66.59	-67	5180	100	AP-C3-3F-02
447	3	at	-52.46	-52	5180	100	AP-C3-3F-03
448	3	au	-82.33333333	-83	2437	21	AP-C2-3F-02
449	3	au	-77.22727273	-77	2437	22	AP-C2-3F-03
450	3	au	-76	-76	2437	14	AP-C3-1F-02
451	3	au	-77.5	-78	2437	42	AP-C3-2F-01
452	3	au	-75.42	-75	2437	50	AP-C3-2F-02
453	3	au	-43.83	-44	2437	100	AP-C3-2F-03
454	3	au	-70.29487179	-70	2437	78	AP-C3-3F-01
455	3	au	-47.43	-47	2437	100	AP-C3-3F-02
456	3	au	-40.09	-39	2437	100	AP-C3-3F-03
457	3	au	-73.52325581	-73.5	2437	86	AP-C3-4F-01
458	3	au	-60.16	-60	2437	100	AP-C3-4F-02
459	3	au	-77.83333333	-77	2437	42	AP-C3-5F-02
460	3	au	-84.01388889	-83.5	5180	72	AP-C2-3F-03
461	3	au	-92	-92	5180	7	AP-C3-2F-02
462	3	au	-65.61	-65	5180	100	AP-C3-2F-03
463	3	au	-73.42307692	-73	5180	78	AP-C3-3F-01
464	3	au	-70.57	-70.5	5180	100	AP-C3-3F-02
465	3	au	-50.92	-50.5	5180	100	AP-C3-3F-03
466	3	au	-90.5	-90.5	5180	14	AP-C3-4F-01
467	3	au	-83	-83	5180	7	AP-C3-4F-02
468	3	av	-78	-78	2437	7	AP-C2-3F-03
469	3	av	-66.66666667	-66	2437	63	AP-C3-1F-02
470	3	av	-73.5	-73.5	2437	56	AP-C3-2F-01
471	3	av	-63.15053763	-63	2437	93	AP-C3-2F-02
472	3	av	-57.64516129	-57	2437	93	AP-C3-2F-03
473	3	av	-62.56	-62	2437	100	AP-C3-3F-01
474	3	av	-54.78	-54	2437	100	AP-C3-3F-02
475	3	av	-46.41	-47	2437	100	AP-C3-3F-03
476	3	av	-74.55555556	-75	2437	72	AP-C3-4F-01
477	3	av	-59.28	-59	2437	100	AP-C3-4F-02
478	3	av	-79.33333333	-80	2437	21	AP-C3-5F-02
479	3	av	-89	-89	5180	2	AP-C3-2F-01
480	3	av	-84.39655172	-85	5180	58	AP-C3-2F-02
481	3	av	-74	-74	5180	77	AP-C3-2F-03
482	3	av	-69.52	-70	5180	100	AP-C3-3F-01
483	3	av	-70.94623656	-69	5180	93	AP-C3-3F-02
484	3	av	-61.14	-61	5180	100	AP-C3-3F-03
485	3	av	-73.17	-73	5180	100	AP-C3-4F-02
486	3	aw	-87	-87	2437	7	AP-C2-3F-02
487	3	aw	-85.5	-85.5	2437	14	AP-C3-1F-01
488	3	aw	-78	-78	2437	14	AP-C3-1F-02
489	3	aw	-77.375	-77.5	2437	56	AP-C3-2F-01
490	3	aw	-73	-73	2437	100	AP-C3-2F-02
491	3	aw	-61.05	-60	2437	100	AP-C3-2F-03
492	3	aw	-60.64285714	-60	2437	98	AP-C3-3F-01
493	3	aw	-48.96	-49	2437	100	AP-C3-3F-02
494	3	aw	-41.86	-42	2437	100	AP-C3-3F-03
495	3	aw	-77.43243243	-77	2437	37	AP-C3-4F-01
496	3	aw	-52.86	-53	2437	100	AP-C3-4F-02
497	3	aw	-88.33333333	-88	2437	21	AP-C3-5F-01
498	3	aw	-82.5	-82.5	2437	28	AP-C3-5F-02
499	3	aw	-89.66666667	-90	5180	21	AP-C2-3F-02
500	3	aw	-90.42857143	-90	5180	49	AP-C3-1F-02
501	3	aw	-89.79310345	-90	5180	58	AP-C3-2F-01
502	3	aw	-81.53488372	-81	5180	86	AP-C3-2F-02
503	3	aw	-88.51724138	-89	5180	58	AP-C3-2F-03
504	3	aw	-72.05813953	-71	5180	86	AP-C3-3F-01
505	3	aw	-64.86	-65	5180	100	AP-C3-3F-02
506	3	aw	-62.09	-62	5180	100	AP-C3-3F-03
507	3	aw	-75.02325581	-75	5180	86	AP-C3-4F-02
508	3	ax	-83	-83	2437	14	AP-C3-1F-01
509	3	ax	-72.49230769	-72	2437	65	AP-C3-1F-02
510	3	ax	-77.34722222	-78	2437	72	AP-C3-2F-01
511	3	ax	-66.38	-67	2437	100	AP-C3-2F-02
512	3	ax	-68.52777778	-68	2437	72	AP-C3-2F-03
513	3	ax	-64.88	-65	2437	100	AP-C3-3F-01
514	3	ax	-38.79	-38	2437	100	AP-C3-3F-02
515	3	ax	-47.51	-47	2437	100	AP-C3-3F-03
516	3	ax	-75.05172414	-75	2437	58	AP-C3-4F-01
517	3	ax	-62.38	-62	2437	100	AP-C3-4F-02
518	3	ax	-89	-89	2437	28	AP-C3-5F-01
519	3	ax	-82.6	-82	2437	35	AP-C3-5F-02
520	3	ax	-89.58823529	-89	5180	51	AP-C3-1F-02
521	3	ax	-81.05555556	-81	5180	72	AP-C3-2F-02
522	3	ax	-90	-90	5180	42	AP-C3-2F-03
523	3	ax	-72.06451613	-71	5180	93	AP-C3-3F-01
524	3	ax	-65.1	-66	5180	100	AP-C3-3F-02
525	3	ax	-65.42	-65	5180	100	AP-C3-3F-03
526	3	ax	-90.47826087	-90	5180	23	AP-C3-4F-01
527	3	ax	-77.77906977	-78	5180	86	AP-C3-4F-02
528	3	ay	-85.22222222	-85	2437	9	AP-C2-3F-03
529	3	ay	-85.5	-85.5	2437	14	AP-C3-1F-01
530	3	ay	-69.77586207	-71	2437	58	AP-C3-1F-02
531	3	ay	-75.12790698	-75	2437	86	AP-C3-2F-01
532	3	ay	-53.35	-53	2437	100	AP-C3-2F-02
533	3	ay	-69.13	-70	2437	100	AP-C3-2F-03
534	3	ay	-59.12	-59	2437	100	AP-C3-3F-01
535	3	ay	-39.84946237	-40	2437	93	AP-C3-3F-02
536	3	ay	-60.74	-61	2437	100	AP-C3-3F-03
537	3	ay	-76.56756757	-77	2437	37	AP-C3-4F-01
538	3	ay	-59.6	-60	2437	100	AP-C3-4F-02
539	3	ay	-87	-87	2437	35	AP-C3-5F-01
540	3	ay	-76	-76	2437	7	AP-C3-5F-02
541	3	ay	-90	-89	5180	37	AP-C3-1F-02
542	3	ay	-86.22222222	-86	5180	63	AP-C3-2F-01
543	3	ay	-77.83333333	-78	5180	72	AP-C3-2F-02
544	3	ay	-89	-89	5180	7	AP-C3-2F-03
545	3	ay	-69.33	-69	5180	100	AP-C3-3F-01
546	3	ay	-58.73	-59	5180	100	AP-C3-3F-02
547	3	ay	-73.37634409	-74	5180	93	AP-C3-3F-03
548	3	ay	-91.14285714	-91	5180	49	AP-C3-4F-01
549	3	ay	-78.6	-78.5	5180	70	AP-C3-4F-02
550	3	az	-88	-88	2437	7	AP-B2-3F-03
551	3	az	-87	-87	2437	7	AP-C3-1F-01
552	3	az	-77	-78	2437	21	AP-C3-1F-02
553	3	az	-67.11827957	-67	2437	93	AP-C3-2F-01
554	3	az	-55.3655914	-55	2437	93	AP-C3-2F-02
555	3	az	-75.91304348	-78	2437	23	AP-C3-2F-03
556	3	az	-54.54	-55	2437	100	AP-C3-3F-01
557	3	az	-43.40860215	-43	2437	93	AP-C3-3F-02
558	3	az	-58.72	-59	2437	100	AP-C3-3F-03
559	3	az	-63.83333333	-64	2437	84	AP-C3-4F-01
560	3	az	-68.5	-68.5	2437	98	AP-C3-4F-02
561	3	az	-77.69565217	-78	2437	23	AP-C3-5F-01
562	3	az	-80	-80	2437	14	AP-C3-5F-02
563	3	az	-87.41666667	-87	5180	72	AP-C3-2F-01
564	3	az	-70.97468354	-71	5180	79	AP-C3-2F-02
565	3	az	-93	-93	5180	7	AP-C3-2F-03
566	3	az	-70.82	-71	5180	100	AP-C3-3F-01
567	3	az	-49.86	-50	5180	100	AP-C3-3F-02
568	3	az	-77.88888889	-78	5180	63	AP-C3-3F-03
569	3	az	-89.66666667	-90	5180	30	AP-C3-4F-01
570	3	az	-82.86153846	-83	5180	65	AP-C3-4F-02
571	3	b	-79	-79	2437	2	AP-C-1F-01
572	3	b	-69.18987342	-67	2437	79	AP-C-2F-01
573	3	b	-83.875	-84	2437	56	AP-C-2F-02
574	3	b	-82	-82	2437	7	AP-C-3F-01
575	3	b	-41.69	-42	2437	100	AP-C-3F-02
576	3	b	-51.38	-51	2437	100	AP-C-3F-03
577	3	b	-62.07692308	-61	2437	91	AP-C-3F-04
578	3	b	-63.52688172	-62	2437	93	AP-C-4F-02
579	3	b	-73.29166667	-73	2437	72	AP-C-4F-03
580	3	b	-75.4	-75	2437	35	AP-C-4F-04
581	3	b	-88	-88	2437	7	AP-C-5F-02
582	3	b	-73.86206897	-73	2437	58	AP-C-5F-03
583	3	b	-74.28571429	-75	2437	49	AP-C1-3F-01
584	3	b	-93	-93	2437	7	AP-C2-3F-01
585	3	b	-85.94029851	-86	5180	67	AP-C-2F-01
586	3	b	-47.17	-47	5180	100	AP-C-3F-02
587	3	b	-67.47222222	-67	5180	72	AP-C-3F-03
588	3	b	-69.37837838	-69	5180	37	AP-C-3F-04
589	3	b	-80.1875	-80	5180	16	AP-C-4F-02
590	3	b	-86.84615385	-87	5180	65	AP-C-4F-03
591	3	b	-78	-78	5180	21	AP-C1-3F-01
592	3	ba	-82.22222222	-82	2437	9	AP-C2-3F-03
593	3	ba	-79.47826087	-79	2437	23	AP-C3-1F-01
594	3	ba	-74.61363636	-74	2437	44	AP-C3-1F-02
595	3	ba	-71.40506329	-72	2437	79	AP-C3-2F-01
596	3	ba	-56.64516129	-57	2437	93	AP-C3-2F-02
597	3	ba	-81.33333333	-82	2437	21	AP-C3-2F-03
598	3	ba	-50.14	-50	2437	100	AP-C3-3F-01
599	3	ba	-53.24	-52	2437	100	AP-C3-3F-02
600	3	ba	-63.72	-63	2437	100	AP-C3-3F-03
601	3	ba	-60.93	-61	2437	100	AP-C3-4F-01
602	3	ba	-71.59	-71	2437	100	AP-C3-4F-02
603	3	ba	-79	-79	2437	49	AP-C3-5F-01
604	3	ba	-82.8	-83	2437	35	AP-C3-5F-02
605	3	ba	-81.31034483	-81	5180	58	AP-C3-2F-01
606	3	ba	-71.20430108	-71	5180	93	AP-C3-2F-02
607	3	ba	-64.89	-65	5180	100	AP-C3-3F-01
608	3	ba	-61.48	-61	5180	100	AP-C3-3F-02
609	3	ba	-79.375	-80	5180	56	AP-C3-3F-03
610	3	ba	-83.90769231	-83	5180	65	AP-C3-4F-01
611	3	ba	-89.33333333	-89	5180	63	AP-C3-4F-02
612	3	bb	-86	-86	2437	6	AP-B2-3F-03
613	3	bb	-87.75	-89	2437	12	AP-C2-3F-03
614	3	bb	-76.41666667	-76	2437	12	AP-C3-1F-01
615	3	bb	-80.57692308	-80	2437	26	AP-C3-1F-02
616	3	bb	-57.92	-58	2437	100	AP-C3-2F-01
617	3	bb	-60.52688172	-60	2437	93	AP-C3-2F-02
618	3	bb	-86	-86	2437	7	AP-C3-2F-03
619	3	bb	-46.6	-48	2437	100	AP-C3-3F-01
620	3	bb	-55.49	-55	2437	100	AP-C3-3F-02
621	3	bb	-67.99	-67	2437	100	AP-C3-3F-03
622	3	bb	-69.60215054	-70	2437	93	AP-C3-4F-01
623	3	bb	-69.77777778	-71	2437	81	AP-C3-4F-02
624	3	bb	-89	-89	2437	7	AP-C3-5F-01
625	3	bb	-87.5	-87.5	2437	10	AP-C3-5F-02
626	3	bb	-78.06818182	-78	5180	88	AP-C3-2F-01
627	3	bb	-78.68918919	-79	5180	74	AP-C3-2F-02
628	3	bb	-67.74	-68	5180	100	AP-C3-3F-01
629	3	bb	-66.66	-66	5180	100	AP-C3-3F-02
630	3	bb	-75.62025316	-76	5180	79	AP-C3-3F-03
631	3	bb	-75.25609756	-75	5180	82	AP-C3-4F-01
632	3	bb	-90.53846154	-90	5180	26	AP-C3-4F-02
633	3	bc	-77	-77	2437	35	AP-C3-1F-01
634	3	bc	-81	-81	2437	14	AP-C3-1F-02
635	3	bc	-59.88	-60	2437	100	AP-C3-2F-01
636	3	bc	-70.1372549	-70	2437	51	AP-C3-2F-02
637	3	bc	-85	-85	2437	7	AP-C3-2F-03
638	3	bc	-43.35	-43	2437	100	AP-C3-3F-01
639	3	bc	-59	-59	2437	93	AP-C3-3F-02
640	3	bc	-66.98	-66	2437	100	AP-C3-3F-03
641	3	bc	-72.32258065	-72	2437	93	AP-C3-4F-01
642	3	bc	-73.79746835	-74	2437	79	AP-C3-4F-02
643	3	bc	-64	-64	2437	84	AP-C3-5F-01
644	3	bc	-79.70689655	-80	5180	58	AP-C3-2F-01
645	3	bc	-81.40860215	-81	5180	93	AP-C3-2F-02
646	3	bc	-64.93	-65	5180	100	AP-C3-3F-01
647	3	bc	-66.05	-66	5180	100	AP-C3-3F-02
648	3	bc	-79.24418605	-79	5180	86	AP-C3-3F-03
649	3	bc	-79	-79	5180	63	AP-C3-4F-01
650	3	bc	-89.03448276	-89	5180	58	AP-C3-4F-02
651	3	bd	-85.5	-85.5	2437	14	AP-B2-4F-03
652	3	bd	-78.47727273	-78	2437	44	AP-C3-1F-01
653	3	bd	-56.4	-56	2437	100	AP-C3-2F-01
654	3	bd	-73.73611111	-75	2437	72	AP-C3-2F-02
655	3	bd	-80.53333333	-81	2437	30	AP-C3-2F-03
656	3	bd	-42.51	-42	2437	100	AP-C3-3F-01
657	3	bd	-61.17	-61	2437	100	AP-C3-3F-02
658	3	bd	-63.96774194	-64	2437	93	AP-C3-3F-03
659	3	bd	-58.30107527	-58	2437	93	AP-C3-4F-01
660	3	bd	-73.23076923	-73	2437	91	AP-C3-4F-02
661	3	bd	-71.84482759	-71	2437	58	AP-C3-5F-01
662	3	bd	-78.23611111	-78	5180	72	AP-C3-2F-01
663	3	bd	-87.45098039	-87	5180	51	AP-C3-2F-02
664	3	bd	-57.28	-57	5180	100	AP-C3-3F-01
665	3	bd	-68.58	-68	5180	100	AP-C3-3F-02
666	3	bd	-82.23529412	-83	5180	51	AP-C3-3F-03
667	3	bd	-78.79	-79	5180	100	AP-C3-4F-01
668	3	bd	-90.66666667	-91	5180	21	AP-C3-4F-02
669	3	be	-83.5	-83.5	2437	14	AP-B2-3F-03
670	3	be	-85	-85	2437	7	AP-C2-3F-03
671	3	be	-60.59	-61	2437	100	AP-C3-2F-01
672	3	be	-75.80821918	-76	2437	73	AP-C3-2F-02
673	3	be	-40.31	-39	2437	100	AP-C3-3F-01
674	3	be	-62.82795699	-63	2437	93	AP-C3-3F-02
675	3	be	-69.08602151	-69	2437	93	AP-C3-3F-03
676	3	be	-52.72	-52	2437	100	AP-C3-4F-01
677	3	be	-74.34722222	-74	2437	72	AP-C3-4F-02
678	3	be	-71.46	-71	2437	100	AP-C3-5F-01
679	3	be	-92	-92	5180	3	AP-C2-3F-02
680	3	be	-91.09090909	-91	5180	55	AP-C3-1F-01
681	3	be	-69.77	-69	5180	100	AP-C3-2F-01
682	3	be	-90.10526316	-91	5180	38	AP-C3-2F-02
683	3	be	-58.7	-58	5180	100	AP-C3-3F-01
684	3	be	-73.27956989	-73	5180	93	AP-C3-3F-02
685	3	be	-76.5	-77	5180	72	AP-C3-3F-03
686	3	be	-80.27848101	-81	5180	79	AP-C3-4F-01
687	3	bf	-73.49019608	-73	2437	51	AP-C3-1F-01
688	3	bf	-56.32258065	-56	2437	93	AP-C3-2F-01
689	3	bf	-68.12903226	-68	2437	93	AP-C3-2F-02
690	3	bf	-51.2	-50	2437	100	AP-C3-3F-01
691	3	bf	-64.51612903	-65	2437	93	AP-C3-3F-02
692	3	bf	-65.3255814	-66	2437	86	AP-C3-3F-03
693	3	bf	-58.68	-58	2437	100	AP-C3-4F-01
694	3	bf	-77.55555556	-77	2437	63	AP-C3-4F-02
695	3	bf	-79.73913043	-79	2437	23	AP-C3-5F-01
696	3	bf	-87.5	-87.5	2437	14	AP-C3-5F-02
697	3	bf	-72.8	-73	5180	100	AP-C3-2F-01
698	3	bf	-92.5	-92.5	5180	14	AP-C3-2F-02
699	3	bf	-55.42	-55	5180	100	AP-C3-3F-01
700	3	bf	-68.01	-68	5180	100	AP-C3-3F-02
701	3	bf	-76.5	-76	5180	56	AP-C3-3F-03
702	3	bf	-74.69444444	-74	5180	72	AP-C3-4F-01
703	3	bf	-91.30434783	-92	5180	23	AP-C3-4F-02
704	3	bg	-83.5	-83.5	2437	28	AP-B2-3F-03
705	3	bg	-72.33333333	-73	2437	42	AP-C3-1F-01
706	3	bg	-52.26	-52	2437	100	AP-C3-2F-01
707	3	bg	-79.55555556	-80	2437	63	AP-C3-2F-02
708	3	bg	-80.75	-81	2437	28	AP-C3-2F-03
709	3	bg	-41.54	-41	2437	100	AP-C3-3F-01
710	3	bg	-60.87	-60	2437	100	AP-C3-3F-02
711	3	bg	-66.6627907	-66	2437	86	AP-C3-3F-03
712	3	bg	-60.21	-60	2437	100	AP-C3-4F-01
713	3	bg	-83.5	-83.5	2437	14	AP-C3-4F-02
714	3	bg	-79.93055556	-80	2437	72	AP-C3-5F-01
715	3	bg	-88	-88	2437	14	AP-C3-5F-02
716	3	bg	-75.57142857	-76	5180	98	AP-C3-2F-01
717	3	bg	-90.4	-91	5180	35	AP-C3-2F-02
718	3	bg	-61	-61	5180	100	AP-C3-3F-01
719	3	bg	-73.3	-73	5180	70	AP-C3-3F-02
720	3	bg	-81.70833333	-82	5180	72	AP-C3-3F-03
721	3	bg	-83.25	-84	5180	72	AP-C3-4F-01
722	3	c	-66.53846154	-67	2437	65	AP-C-2F-01
723	3	c	-79	-80	2437	21	AP-C-2F-02
724	3	c	-81.5	-81.5	2437	14	AP-C-3F-01
725	3	c	-49.47	-49	2437	100	AP-C-3F-02
726	3	c	-48.75	-48	2437	100	AP-C-3F-03
727	3	c	-64.63636364	-65	2437	77	AP-C-3F-04
728	3	c	-65.80555556	-66	2437	72	AP-C-4F-02
729	3	c	-68.96551724	-69	2437	58	AP-C-4F-03
730	3	c	-80.5	-80.5	2437	14	AP-C-4F-04
731	3	c	-77.1875	-77	2437	16	AP-C-5F-02
732	3	c	-76.04545455	-77	2437	44	AP-C-5F-03
733	3	c	-80.66666667	-80	2437	9	AP-C1-3F-01
734	3	c	-89	-89	2437	2	AP-C2-3F-01
735	3	c	-80.1744186	-80	5180	86	AP-C-2F-01
736	3	c	-53.9	-53	5180	100	AP-C-3F-02
737	3	c	-58.87777778	-58	5180	90	AP-C-3F-03
738	3	c	-72.03	-71	5180	100	AP-C-3F-04
739	3	c	-79.93055556	-80	5180	72	AP-C-4F-02
740	3	c	-85.5	-85	5180	72	AP-C-4F-03
741	3	c	-90.19607843	-90	5180	51	AP-C1-3F-01
742	3	d	-80	-80	2437	21	AP-C-1F-01
743	3	d	-56.02702703	-57	2437	37	AP-C-2F-01
744	3	d	-71.76666667	-71	2437	30	AP-C-2F-02
745	3	d	-85	-85	2437	14	AP-C-3F-01
746	3	d	-48.4	-48	2437	100	AP-C-3F-02
747	3	d	-53.64516129	-54	2437	93	AP-C-3F-03
748	3	d	-66.77	-67	2437	100	AP-C-3F-04
749	3	d	-69.3164557	-69	2437	79	AP-C-4F-02
750	3	d	-65.9	-66	2437	100	AP-C-4F-03
751	3	d	-78.5	-78.5	2437	28	AP-C-4F-04
752	3	d	-86	-86	2437	7	AP-C-5F-02
753	3	d	-77.28571429	-77	2437	49	AP-C-5F-03
754	3	d	-87.5	-87.5	2437	14	AP-C-5F-04
755	3	d	-83	-83	2437	7	AP-C1-3F-01
756	3	d	-74.05376344	-74	5180	93	AP-C-2F-01
757	3	d	-92	-92	5180	7	AP-C-2F-02
758	3	d	-68.63	-68	5180	100	AP-C-3F-02
759	3	d	-60.03	-60	5180	100	AP-C-3F-03
760	3	d	-79.06329114	-79	5180	79	AP-C-3F-04
761	3	d	-86	-86	5180	70	AP-C-4F-02
762	3	d	-86.04166667	-85	5180	72	AP-C-4F-03
763	3	e	-63.63	-63	2437	100	AP-C-2F-01
764	3	e	-76.42857143	-76	2437	49	AP-C-2F-02
765	3	e	-53.79	-54	2437	100	AP-C-3F-02
766	3	e	-49.46236559	-50	2437	93	AP-C-3F-03
767	3	e	-65.64	-66	2437	100	AP-C-3F-04
768	3	e	-65.33	-64	2437	100	AP-C-4F-02
769	3	e	-65.57142857	-66.5	2437	98	AP-C-4F-03
770	3	e	-74.58823529	-73	2437	51	AP-C-4F-04
771	3	e	-76.25	-76	2437	28	AP-C-5F-03
772	3	e	-82	-82	2437	7	AP-C-5F-04
773	3	e	-84.5	-84.5	2437	14	AP-C2-3F-01
774	3	e	-70	-70	5180	100	AP-C-2F-01
775	3	e	-66.32258065	-66	5180	93	AP-C-3F-02
776	3	e	-55.37	-56	5180	100	AP-C-3F-03
777	3	e	-71.79	-72	5180	100	AP-C-3F-04
778	3	e	-88.81081081	-88	5180	37	AP-C-4F-02
779	3	e	-85.18055556	-86	5180	72	AP-C-4F-03
780	3	f	-72	-72	2437	21	AP-C-1F-01
781	3	f	-62.34883721	-62	2437	86	AP-C-2F-01
782	3	f	-68.64615385	-69	2437	65	AP-C-2F-02
783	3	f	-78	-78	2437	14	AP-C-3F-01
784	3	f	-57.51162791	-57	2437	86	AP-C-3F-02
785	3	f	-40.69892473	-41	2437	93	AP-C-3F-03
786	3	f	-56.67741935	-56	2437	93	AP-C-3F-04
787	3	f	-66.88888889	-66	2437	63	AP-C-4F-02
788	3	f	-61.87209302	-62	2437	86	AP-C-4F-03
789	3	f	-69.62025316	-70	2437	79	AP-C-4F-04
790	3	f	-83	-83	2437	7	AP-C-5F-02
791	3	f	-83	-83	2437	7	AP-C-5F-03
792	3	f	-86.33333333	-86	5180	21	AP-C-2F-01
793	3	f	-87.23333333	-88	5180	30	AP-C-2F-02
794	3	f	-67.81818182	-68	5180	77	AP-C-3F-02
795	3	f	-50.23076923	-49	5180	91	AP-C-3F-03
796	3	f	-74.28571429	-75	5180	49	AP-C-3F-04
797	3	f	-92	-92	5180	14	AP-C-4F-02
798	3	f	-74.69620253	-75	5180	79	AP-C-4F-03
799	3	g	-77.2	-77	2437	35	AP-C-1F-01
800	3	g	-66.61538462	-66	2437	91	AP-C-2F-01
801	3	g	-73.93548387	-74	2437	93	AP-C-2F-02
802	3	g	-81.5	-81.5	2437	14	AP-C-3F-01
803	3	g	-64.78481013	-64	2437	79	AP-C-3F-02
804	3	g	-36.42	-37	2437	100	AP-C-3F-03
805	3	g	-56.05	-56	2437	100	AP-C-3F-04
806	3	g	-71.24615385	-71	2437	65	AP-C-4F-02
807	3	g	-57.71	-59	2437	100	AP-C-4F-03
808	3	g	-73.07526882	-73	2437	93	AP-C-4F-04
809	3	g	-89	-89	2437	7	AP-C-5F-02
810	3	g	-77	-79	2437	35	AP-C-5F-03
811	3	g	-86.33333333	-86.5	5180	42	AP-C-2F-01
812	3	g	-82.84615385	-83	5180	65	AP-C-2F-02
813	3	g	-71.38372093	-71	5180	86	AP-C-3F-02
814	3	g	-52.75268817	-52	5180	93	AP-C-3F-03
815	3	g	-69.64516129	-70	5180	93	AP-C-3F-04
816	3	g	-85.2	-86	5180	35	AP-C-4F-03
817	3	h	-62.37209302	-62	2437	86	AP-C-1F-01
818	3	h	-69.64705882	-70	2437	51	AP-C-2F-01
819	3	h	-61.35714286	-60.5	2437	98	AP-C-2F-02
820	3	h	-77	-77	2437	7	AP-C-3F-01
821	3	h	-67.57142857	-67	2437	49	AP-C-3F-02
822	3	h	-51.05	-51	2437	100	AP-C-3F-03
823	3	h	-54.59	-54	2437	100	AP-C-3F-04
824	3	h	-79.2	-79	2437	35	AP-C-4F-02
825	3	h	-65.37974684	-65	2437	79	AP-C-4F-03
826	3	h	-73.33	-74	2437	100	AP-C-4F-04
827	3	h	-80	-80	2437	7	AP-C-5F-03
828	3	h	-81	-81	2437	14	AP-C-5F-04
829	3	h	-89	-89	2437	7	AP-C2-3F-01
830	3	h	-89.64864865	-90	5180	37	AP-C-1F-01
831	3	h	-88.42857143	-89	5180	49	AP-C-2F-01
832	3	h	-79.77777778	-80	5180	63	AP-C-2F-02
833	3	h	-71.24050633	-72	5180	79	AP-C-3F-02
834	3	h	-56.95	-56	5180	100	AP-C-3F-03
835	3	h	-71.41935484	-71	5180	93	AP-C-3F-04
836	3	h	-84.72972973	-85	5180	37	AP-C-4F-03
837	3	i	-69.88888889	-70	2437	63	AP-C-1F-01
838	3	i	-78.25	-78	2437	28	AP-C-2F-01
839	3	i	-60.38461538	-60	2437	91	AP-C-2F-02
840	3	i	-83	-83	2437	7	AP-C-3F-01
841	3	i	-66.67241379	-67	2437	58	AP-C-3F-02
842	3	i	-57.31	-57	2437	100	AP-C-3F-03
843	3	i	-47.39	-47	2437	100	AP-C-3F-04
844	3	i	-74.16666667	-73	2437	42	AP-C-4F-02
845	3	i	-68.57142857	-68	2437	49	AP-C-4F-03
846	3	i	-67.7311828	-68	2437	93	AP-C-4F-04
847	3	i	-84.5	-84.5	2437	14	AP-C-5F-03
848	3	i	-83	-83	2437	7	AP-C-5F-04
849	3	i	-89.26582278	-89	5180	79	AP-C-1F-01
850	3	i	-92	-92	5180	7	AP-C-2F-01
851	3	i	-79.38636364	-80	5180	44	AP-C-2F-02
852	3	i	-74.88888889	-74	5180	72	AP-C-3F-02
853	3	i	-65.19	-65	5180	100	AP-C-3F-03
854	3	i	-66.94186047	-67	5180	86	AP-C-3F-04
855	3	i	-86.46153846	-87	5180	91	AP-C-4F-03
856	3	i	-85.88235294	-86	5180	51	AP-C-4F-04
857	3	j	-75.04545455	-76	2437	22	AP-C-1F-01
858	3	j	-78.08695652	-78	2437	23	AP-C-2F-01
859	3	j	-51.83544304	-51	2437	79	AP-C-2F-02
860	3	j	-79.06666667	-80	2437	15	AP-C-3F-01
861	3	j	-74.37209302	-76	2437	43	AP-C-3F-02
862	3	j	-66.91397849	-68	2437	93	AP-C-3F-03
863	3	j	-47.35	-47.5	2437	100	AP-C-3F-04
864	3	j	-82.04545455	-82	2437	22	AP-C-4F-02
865	3	j	-69.875	-69.5	2437	72	AP-C-4F-03
866	3	j	-63.65	-63	2437	100	AP-C-4F-04
867	3	j	-81.04	-81	2437	50	AP-C-5F-04
868	3	j	-83	-83	2437	7	AP-C2-3F-01
869	3	j	-90	-90	5180	7	AP-C-2F-01
870	3	j	-71.07526882	-71	5180	93	AP-C-2F-02
871	3	j	-76.59459459	-74	5180	37	AP-C-3F-02
872	3	j	-70.90769231	-70	5180	65	AP-C-3F-03
873	3	j	-67.39	-67	5180	100	AP-C-3F-04
874	3	j	-83.5	-83.5	5180	28	AP-C-4F-04
875	3	k	-80.6	-80	2437	35	AP-C-1F-01
876	3	k	-79.63636364	-79	2437	44	AP-C-2F-01
877	3	k	-47.70833333	-48	2437	72	AP-C-2F-02
878	3	k	-80	-80	2437	7	AP-C-3F-01
879	3	k	-76.375	-75	2437	56	AP-C-3F-02
880	3	k	-64.23255814	-64	2437	86	AP-C-3F-03
881	3	k	-49.49	-51	2437	100	AP-C-3F-04
882	3	k	-85	-85	2437	7	AP-C-4F-02
883	3	k	-80.27272727	-80	2437	44	AP-C-4F-03
884	3	k	-58.44	-59	2437	100	AP-C-4F-04
885	3	k	-78	-78	2437	14	AP-C-5F-04
886	3	k	-88.26086957	-88	2437	23	AP-C-6F-04
887	3	k	-87	-87	2437	7	AP-C2-3F-01
888	3	k	-86	-86	2437	9	AP-C-4F-01
889	3	k	-70.09	-70	5180	100	AP-C-2F-02
890	3	k	-74.16666667	-75	5180	84	AP-C-3F-02
891	3	k	-71.80645161	-72	5180	93	AP-C-3F-03
892	3	k	-62.99	-63	5180	100	AP-C-3F-04
893	3	k	-92	-92	5180	7	AP-C-4F-03
894	3	k	-74.50537634	-74	5180	93	AP-C-4F-04
895	3	l	-81.4	-81	2437	35	AP-C-1F-01
896	3	l	-86.3125	-85	2437	32	AP-C-2F-01
897	3	l	-61.97849462	-62	2437	93	AP-C-2F-02
898	3	l	-67.96923077	-68	2437	65	AP-C-3F-01
899	3	l	-71.91139241	-72	2437	79	AP-C-3F-02
900	3	l	-61.2688172	-60	2437	93	AP-C-3F-03
901	3	l	-38.79	-38	2437	100	AP-C-3F-04
902	3	l	-86	-86	2437	14	AP-C-4F-02
903	3	l	-82.84210526	-81	2437	19	AP-C-4F-03
904	3	l	-62.7	-63	2437	100	AP-C-4F-04
905	3	l	-75.5625	-75	2437	32	AP-C-5F-04
906	3	l	-88	-88	2437	14	AP-C-4F-01
907	3	l	-82.18666667	-82	5180	75	AP-C-2F-02
908	3	l	-86.83333333	-88	5180	18	AP-C-3F-01
909	3	l	-77.79746835	-77	5180	79	AP-C-3F-02
910	3	l	-78.98734177	-78	5180	79	AP-C-3F-03
911	3	l	-51.19	-51	5180	100	AP-C-3F-04
912	3	l	-73.52688172	-73	5180	93	AP-C-4F-04
913	3	m	-67.48837209	-67	2437	86	AP-C-2F-02
914	3	m	-66.45454545	-67	2437	77	AP-C-3F-01
915	3	m	-71.79310345	-73	2437	58	AP-C-3F-02
916	3	m	-75.37974684	-74	2437	79	AP-C-3F-03
917	3	m	-43.38	-42	2437	100	AP-C-3F-04
918	3	m	-87	-87	2437	16	AP-C-4F-02
919	3	m	-77.66666667	-77	2437	21	AP-C-4F-03
920	3	m	-61.59139785	-62	2437	93	AP-C-4F-04
921	3	m	-84.16666667	-85	2437	42	AP-C-5F-04
922	3	m	-80.66666667	-81	2437	21	AP-C2-3F-01
923	3	m	-85	-85	2437	7	AP-C-4F-01
924	3	m	-86.89230769	-87	5180	65	AP-C-2F-02
925	3	m	-84.77777778	-84	5180	72	AP-C-3F-01
926	3	m	-82.125	-82.5	5180	56	AP-C-3F-02
927	3	m	-76.72727273	-76	5180	77	AP-C-3F-03
928	3	m	-56.72043011	-57	5180	93	AP-C-3F-04
929	3	m	-77.125	-77	5180	56	AP-C-4F-04
930	3	m	-90.5	-90.5	5180	42	AP-C2-3F-01
931	3	n	-71.3442623	-69	2437	61	AP-C-2F-02
932	3	n	-72.64583333	-72	2437	96	AP-C-3F-01
933	3	n	-79.175	-79	2437	40	AP-C-3F-02
934	3	n	-76.5	-77.5	2437	42	AP-C-3F-03
935	3	n	-45.26	-45	2437	100	AP-C-3F-04
936	3	n	-92	-92	2437	7	AP-C-4F-02
937	3	n	-84.63636364	-85	2437	11	AP-C-4F-03
938	3	n	-67.24731183	-67	2437	93	AP-C-4F-04
939	3	n	-80.31944444	-80	2437	72	AP-C-5F-04
940	3	n	-81.75	-81.5	2437	28	AP-C2-3F-01
941	3	n	-90.83333333	-91	5180	72	AP-C-2F-02
942	3	n	-82.06666667	-82	5180	60	AP-C-3F-01
943	3	n	-80.90277778	-81	5180	72	AP-C-3F-02
944	3	n	-80.66666667	-81	5180	6	AP-C-3F-03
945	3	n	-69.38961039	-70	5180	77	AP-C-3F-04
946	3	n	-85.01162791	-85	5180	86	AP-C-4F-04
947	3	n	-90.2962963	-90	5180	54	AP-C2-3F-01
948	3	o	-84.5	-84.5	2437	14	AP-C-2F-01
949	3	o	-81.57142857	-81	2437	49	AP-C-2F-02
950	3	o	-61.69	-62	2437	100	AP-C-3F-01
951	3	o	-66.47	-66	2437	100	AP-C-3F-02
952	3	o	-69.91	-69	2437	100	AP-C-3F-03
953	3	o	-55.99	-56	2437	100	AP-C-3F-04
954	3	o	-85.5	-85.5	2437	42	AP-C-4F-02
955	3	o	-82	-82	2437	28	AP-C-4F-03
956	3	o	-70.31	-70	2437	100	AP-C-4F-04
957	3	o	-80.57142857	-80	2437	49	AP-C-5F-04
958	3	o	-73.16666667	-73.5	2437	42	AP-C2-3F-01
959	3	o	-79	-79	2437	7	AP-C-4F-01
960	3	o	-92	-92	5180	7	AP-C-2F-02
961	3	o	-77.3	-77.5	5180	70	AP-C-3F-01
962	3	o	-80.15909091	-80	5180	44	AP-C-3F-02
963	3	o	-82	-82	5180	72	AP-C-3F-03
964	3	o	-67.5	-68	5180	100	AP-C-3F-04
965	3	o	-88.56756757	-89	5180	37	AP-C-4F-04
966	3	o	-87.58333333	-88	5180	72	AP-C2-3F-01
967	3	o	-91	-91	5180	7	AP-C2-3F-02
968	3	o	-90.18461538	-91	5180	65	AP-C2-3F-03
969	3	p	-89	-89	2437	7	AP-C-2F-01
970	3	p	-81.8	-82	2437	35	AP-C-2F-02
971	3	p	-59.31	-59	2437	100	AP-C-3F-01
972	3	p	-70.06329114	-70	2437	79	AP-C-3F-02
973	3	p	-78.1744186	-77	2437	86	AP-C-3F-03
974	3	p	-62.68	-62	2437	100	AP-C-3F-04
975	3	p	-66	-66	2437	100	AP-C-4F-04
976	3	p	-77.5	-77.5	2437	14	AP-C-5F-04
977	3	p	-74.47692308	-75	2437	65	AP-C2-3F-01
978	3	p	-86	-86	2437	7	AP-C2-3F-03
979	3	p	-77.5	-77.5	2437	14	AP-C-4F-01
980	3	p	-77.41538462	-77	5180	65	AP-C-3F-01
981	3	p	-86	-86	5180	50	AP-C-3F-02
982	3	p	-84.96923077	-85	5180	65	AP-C-3F-03
983	3	p	-72.79	-72	5180	100	AP-C-3F-04
984	3	p	-87	-87	5180	7	AP-C-4F-04
985	3	p	-73.16	-74	5180	100	AP-C2-3F-01
986	3	p	-90	-90	5180	16	AP-C2-3F-02
987	3	q	-77.70212766	-78	2437	47	AP-C-2F-02
988	3	q	-69.20454545	-69	2437	44	AP-C-3F-01
989	3	q	-67.46511628	-67	2437	86	AP-C-3F-02
990	3	q	-67.53763441	-68	2437	93	AP-C-3F-03
991	3	q	-57.93548387	-59	2437	93	AP-C-3F-04
992	3	q	-67.41666667	-66	2437	72	AP-C-4F-04
993	3	q	-80	-80	2437	14	AP-C-5F-04
994	3	q	-81.25	-81	2437	28	AP-C2-2F-01
995	3	q	-81.66666667	-82	2437	21	AP-C2-2F-02
996	3	q	-86	-86	2437	7	AP-C2-2F-03
997	3	q	-53.77419355	-55	2437	93	AP-C2-3F-01
998	3	q	-65.49253731	-67	2437	67	AP-C2-3F-02
999	3	q	-74.66666667	-75	2437	21	AP-C2-3F-03
1000	3	q	-68.34782609	-69	2437	46	AP-C2-4F-01
1001	3	q	-84	-84	2437	14	AP-C2-4F-02
1002	3	q	-84	-84	2437	14	AP-C2-4F-03
1003	3	q	-83	-83	2437	7	AP-C3-3F-03
1004	3	q	-78.5	-78.5	2437	14	AP-C-4F-01
1005	3	q	-89.4	-89	5180	65	AP-C-2F-02
1006	3	q	-81.19230769	-80	5180	26	AP-C-3F-01
1007	3	q	-65.94	-65	5180	100	AP-C-3F-02
1008	3	q	-72.23	-72	5180	100	AP-C-3F-03
1009	3	q	-64.03	-64	5180	100	AP-C-3F-04
1010	3	q	-66.58064516	-67	5180	93	AP-C2-3F-01
1011	3	q	-81.39344262	-81	5180	61	AP-C2-3F-02
1012	3	q	-85.73333333	-86	5180	75	AP-C2-3F-03
1013	3	r	-70.19318182	-70	2437	88	AP-C-2F-02
1014	3	r	-67.97222222	-68	2437	72	AP-C-3F-01
1015	3	r	-83	-83	2437	7	AP-C-3F-02
1016	3	r	-82.15517241	-83	2437	58	AP-C-3F-03
1017	3	r	-60.38	-60	2437	100	AP-C-3F-04
1018	3	r	-86	-86	2437	7	AP-C-4F-03
1019	3	r	-66.53488372	-66	2437	86	AP-C-4F-04
1020	3	r	-86	-86	2437	7	AP-C-5F-04
1021	3	r	-78.76923077	-79	2437	26	AP-C2-2F-01
1022	3	r	-77.79310345	-78	2437	58	AP-C2-2F-02
1023	3	r	-54.66	-54	2437	100	AP-C2-3F-01
1024	3	r	-63.2688172	-63	2437	93	AP-C2-3F-02
1025	3	r	-69.24418605	-69	2437	86	AP-C2-3F-03
1026	3	r	-72.64150943	-72	2437	53	AP-C2-4F-01
1027	3	r	-86	-86	2437	7	AP-C2-4F-02
1028	3	r	-88	-88	2437	7	AP-C3-3F-01
1029	3	r	-84.5	-84.5	2437	14	AP-C3-3F-03
1030	3	r	-83.09090909	-85	5180	44	AP-C-3F-01
1031	3	r	-80.37974684	-80	5180	79	AP-C-3F-02
1032	3	r	-86.1	-86	5180	70	AP-C-3F-03
1033	3	r	-65.52040816	-65	5180	98	AP-C-3F-04
1034	3	r	-88.68181818	-89	5180	44	AP-C-4F-04
1035	3	r	-65.88	-66	5180	100	AP-C2-3F-01
1036	3	r	-78.58441558	-78	5180	77	AP-C2-3F-02
1037	3	s	-60.84	-61	2437	100	AP-C-3F-01
1038	3	s	-83	-83	2437	14	AP-C-3F-04
1039	3	s	-75	-75	2437	91	AP-C2-2F-01
1040	3	s	-76.0862069	-76	2437	58	AP-C2-2F-02
1041	3	s	-83	-83	2437	14	AP-C2-2F-03
1042	3	s	-51.20430108	-51	2437	93	AP-C2-3F-01
1043	3	s	-62.32	-63	2437	100	AP-C2-3F-02
1044	3	s	-64.05	-64	2437	100	AP-C2-3F-03
1045	3	s	-81.125	-81	2437	56	AP-C2-4F-01
1046	3	s	-82	-82	2437	2	AP-C2-4F-02
1047	3	s	-89	-89	2437	7	AP-C2-4F-03
1048	3	s	-87	-87	2437	7	AP-C3-3F-01
1049	3	s	-89.30434783	-89	5180	23	AP-C-3F-01
1050	3	s	-87.0625	-88	5180	16	AP-C-3F-04
1051	3	s	-65.61403509	-65	5180	57	AP-C2-3F-01
1052	3	s	-77.4137931	-77	5180	58	AP-C2-3F-02
1053	3	s	-84.83333333	-84.5	5180	84	AP-C2-3F-03
1054	3	t	-70.61538462	-71	2437	91	AP-C-3F-01
1055	3	t	-85.75	-86	2437	28	AP-C-3F-04
1056	3	t	-84	-84	2437	7	AP-C2-1F-01
1057	3	t	-77.10465116	-78	2437	86	AP-C2-2F-01
1058	3	t	-80.75	-81	2437	28	AP-C2-2F-02
1059	3	t	-86	-86	2437	7	AP-C2-2F-03
1060	3	t	-47.22	-47	2437	100	AP-C2-3F-01
1061	3	t	-60.47	-60	2437	100	AP-C2-3F-02
1062	3	t	-63.71428571	-64	2437	98	AP-C2-3F-03
1063	3	t	-74.93442623	-75	2437	61	AP-C2-4F-01
1064	3	t	-82.26923077	-82	2437	26	AP-C2-4F-02
1065	3	t	-80.82352941	-80	2437	34	AP-C2-4F-03
1066	3	t	-89.36363636	-89	5180	11	AP-C-3F-01
1067	3	t	-89.66666667	-89	5180	21	AP-C-3F-04
1068	3	t	-90.25	-90.5	5180	28	AP-C2-2F-01
1069	3	t	-64.83	-65	5180	100	AP-C2-3F-01
1070	3	t	-76.16666667	-76.5	5180	84	AP-C2-3F-02
1071	3	t	-81.91666667	-82	5180	84	AP-C2-3F-03
1072	3	u	-74	-74	2437	42	AP-C-3F-01
1073	3	u	-82.2	-83	2437	35	AP-C-3F-04
1074	3	u	-77.66666667	-77.5	2437	42	AP-C2-1F-01
1075	3	u	-68.14	-68	2437	100	AP-C2-2F-01
1076	3	u	-70.15189873	-70	2437	79	AP-C2-2F-02
1077	3	u	-79.63333333	-79	2437	30	AP-C2-2F-03
1078	3	u	-47.72	-47	2437	100	AP-C2-3F-01
1079	3	u	-67.84	-67	2437	100	AP-C2-3F-02
1080	3	u	-64.91860465	-65	2437	86	AP-C2-3F-03
1081	3	u	-69.86111111	-70	2437	72	AP-C2-4F-01
1082	3	u	-76.19354839	-75	2437	31	AP-C2-4F-02
1083	3	u	-80.66666667	-82	2437	15	AP-C2-4F-03
1084	3	u	-86	-86	2437	2	AP-C2-5F-02
1085	3	u	-87	-87	5180	7	AP-C-3F-01
1086	3	u	-87.43103448	-88	5180	58	AP-C2-2F-01
1087	3	u	-60.51	-60	5180	100	AP-C2-3F-01
1088	3	u	-81.32911392	-81	5180	79	AP-C2-3F-02
1089	3	u	-84.36363636	-84	5180	77	AP-C2-3F-03
1090	3	u	-90	-90	5180	7	AP-C2-4F-01
1091	3	v	-75.5	-75.5	2437	14	AP-C-3F-01
1092	3	v	-82	-82	2437	7	AP-C2-1F-01
1093	3	v	-67.58139535	-68	2437	86	AP-C2-2F-01
1094	3	v	-77.9	-78	2437	70	AP-C2-2F-02
1095	3	v	-77.078125	-77	2437	64	AP-C2-2F-03
1096	3	v	-51.58	-51.5	2437	100	AP-C2-3F-01
1097	3	v	-75.7	-76	2437	100	AP-C2-3F-02
1098	3	v	-70.08333333	-69.5	2437	72	AP-C2-3F-03
1099	3	v	-67.61627907	-68	2437	86	AP-C2-4F-01
1100	3	v	-69.37	-69	2437	100	AP-C2-4F-02
1101	3	v	-82.56756757	-83	2437	37	AP-C2-5F-01
1102	3	v	-83	-83	2437	7	AP-C3-3F-03
1103	3	v	-83.73255814	-83	5180	86	AP-C2-2F-01
1104	3	v	-63.4	-63	5180	100	AP-C2-3F-01
1105	3	v	-75.82795699	-76	5180	93	AP-C2-3F-02
1106	3	v	-79.87341772	-80	5180	79	AP-C2-3F-03
1107	3	v	-90.25	-90.5	5180	28	AP-C2-4F-01
1108	3	v	-91	-91	5180	43	AP-C2-4F-02
1109	3	w	-69.33333333	-69	2437	30	AP-C-3F-01
1110	3	w	-71.12280702	-72	2437	57	AP-C2-1F-01
1111	3	w	-61.01075269	-61	2437	93	AP-C2-2F-01
1112	3	w	-69.26388889	-69	2437	72	AP-C2-2F-02
1113	3	w	-40.09	-39	2437	100	AP-C2-3F-01
1114	3	w	-58.75	-59	2437	100	AP-C2-3F-02
1115	3	w	-62.82795699	-63	2437	93	AP-C2-3F-03
1116	3	w	-73.01960784	-72	2437	51	AP-C2-4F-01
1117	3	w	-77.17204301	-77	2437	93	AP-C2-4F-02
1118	3	w	-82.5	-82.5	2437	28	AP-C2-4F-03
1119	3	w	-75.74418605	-76	2437	43	AP-C2-5F-01
1120	3	w	-76.16666667	-77	2437	36	AP-C2-5F-02
1121	3	w	-81.5	-81.5	2437	14	AP-C3-3F-03
1122	3	w	-81.04705882	-80	5180	85	AP-C2-2F-01
1123	3	w	-51.59	-51	5180	100	AP-C2-3F-01
1124	3	w	-72.94	-73.5	5180	100	AP-C2-3F-02
1125	3	w	-79.13846154	-79	5180	65	AP-C2-3F-03
1126	3	w	-80.27777778	-81	5180	18	AP-C2-4F-01
1127	3	x	-68.86075949	-69	2437	79	AP-C-3F-01
1128	3	x	-77.2	-77	2437	35	AP-C2-1F-01
1129	3	x	-63.46236559	-61	2437	93	AP-C2-2F-01
1130	3	x	-80.42857143	-80	2437	49	AP-C2-2F-02
1131	3	x	-77.30434783	-77	2437	23	AP-C2-2F-03
1132	3	x	-43.92	-43	2437	100	AP-C2-3F-01
1133	3	x	-59.84	-60	2437	100	AP-C2-3F-02
1134	3	x	-62.79	-63	2437	100	AP-C2-3F-03
1135	3	x	-61.07	-61	2437	100	AP-C2-4F-01
1136	3	x	-79.04545455	-79	2437	44	AP-C2-4F-02
1137	3	x	-74.06153846	-74	2437	65	AP-C2-4F-03
1138	3	x	-76.01960784	-76	2437	51	AP-C2-5F-01
1139	3	x	-83.33333333	-83	2437	21	AP-C2-5F-02
1140	3	x	-83	-83	2437	7	AP-C2-6F-01
1141	3	x	-85.44444444	-85	2437	9	AP-C3-3F-01
1142	3	x	-79	-79	2437	7	AP-C3-3F-03
1143	3	x	-90	-90	5180	7	AP-C-3F-01
1144	3	x	-75.70769231	-75	5180	65	AP-C2-2F-01
1145	3	x	-51.94	-52	5180	100	AP-C2-3F-01
1146	3	x	-73.82795699	-74	5180	93	AP-C2-3F-02
1147	3	x	-80.7	-81	5180	10	AP-C2-3F-03
1148	3	y	-71.70454545	-71	2437	44	AP-C-3F-01
1149	3	y	-65.93670886	-66	2437	79	AP-C2-1F-01
1150	3	y	-52.38	-53	2437	100	AP-C2-2F-01
1151	3	y	-70.21538462	-70	2437	65	AP-C2-2F-02
1152	3	y	-76.5	-77	2437	28	AP-C2-2F-03
1153	3	y	-38.4	-39	2437	100	AP-C2-3F-01
1154	3	y	-59.83870968	-60	2437	93	AP-C2-3F-02
1155	3	y	-60.3255814	-61	2437	86	AP-C2-3F-03
1156	3	y	-60.21	-60	2437	100	AP-C2-4F-01
1157	3	y	-71.91666667	-72	2437	72	AP-C2-4F-02
1158	3	y	-74.25	-75	2437	28	AP-C2-4F-03
1159	3	y	-72.97468354	-73	2437	79	AP-C2-5F-01
1160	3	y	-77	-77	2437	7	AP-C2-5F-02
1161	3	y	-82.5	-82.5	2437	14	AP-C2-6F-01
1162	3	y	-88	-88	2437	7	AP-C3-3F-01
1163	3	y	-81	-81	2437	7	AP-C3-3F-03
1164	3	y	-75.83333333	-75.5	5180	84	AP-C2-2F-01
1165	3	y	-91.95454545	-92	5180	44	AP-C2-2F-02
1166	3	y	-55.2688172	-55	5180	93	AP-C2-3F-01
1167	3	y	-70.35483871	-70	5180	93	AP-C2-3F-02
1168	3	y	-73.91860465	-74	5180	86	AP-C2-3F-03
1169	3	y	-85.875	-86	5180	8	AP-C2-4F-01
1170	3	z	-74	-74	2437	14	AP-C-3F-01
1171	3	z	-72.75	-72.5	2437	28	AP-C2-1F-01
1172	3	z	-56.44	-57	2437	100	AP-C2-2F-01
1173	3	z	-69.17204301	-69	2437	93	AP-C2-2F-02
1174	3	z	-76.77777778	-76	2437	27	AP-C2-2F-03
1175	3	z	-39.2	-38	2437	100	AP-C2-3F-01
1176	3	z	-61.05	-60	2437	100	AP-C2-3F-02
1177	3	z	-58.51612903	-58	2437	93	AP-C2-3F-03
1178	3	z	-68.41935484	-67	2437	93	AP-C2-4F-01
1179	3	z	-76.93670886	-76	2437	79	AP-C2-4F-02
1180	3	z	-72.13846154	-72	2437	65	AP-C2-4F-03
1181	3	z	-74.27586207	-75	2437	58	AP-C2-5F-01
1182	3	z	-82	-82	2437	7	AP-C2-5F-02
1183	3	z	-83	-83	2437	7	AP-C2-6F-01
1184	3	z	-82.75	-82.5	2437	28	AP-C3-3F-03
1185	3	z	-66.49	-66	5180	100	AP-C2-2F-01
1186	3	z	-87.45454545	-87	5180	77	AP-C2-2F-02
1187	3	z	-55.3	-55	5180	100	AP-C2-3F-01
1188	3	z	-67.55	-67	5180	100	AP-C2-3F-02
1189	3	z	-72.04	-71	5180	25	AP-C2-3F-03
1190	4	a	-52.09677419	-52	2437	93	AP-C-3F-02
1191	4	a	-79	-79	2437	7	AP-C-3F-03
1192	4	a	-38.82795699	-39	2437	93	AP-C-4F-02
1193	4	a	-68.22222222	-65	2437	72	AP-C-4F-03
1194	4	a	-69.8	-72	2437	35	AP-C-4F-04
1195	4	a	-62.56989247	-63	2437	93	AP-C-5F-02
1196	4	a	-76.75	-76	2437	28	AP-C-5F-03
1197	4	a	-86	-86	2437	7	AP-C-5F-04
1198	4	a	-75.5	-75.5	2437	70	AP-C-6F-02
1199	4	a	-83	-83	2437	7	AP-C1-4F-02
1200	4	a	-73	-73	2437	7	AP-C2-4F-01
1201	4	a	-72	-72	2437	7	AP-C2-4F-02
1202	4	a	-65	-65	2437	7	AP-C-4F-01
1203	4	a	-76.93670886	-77	5180	79	AP-C-3F-02
1204	4	a	-62.76923077	-72	5180	13	AP-C-4F-02
1205	4	a	-65.36	-65	5180	25	AP-C-4F-03
1206	4	a	-75.32911392	-76	5180	79	AP-C-4F-04
1207	4	a	-79.41666667	-79	5180	84	AP-C-5F-02
1208	4	a	-82.79310345	-83	5180	58	AP-C-5F-03
1209	4	a	-90	-90	5180	2	AP-C1-4F-02
1210	4	a	-77	-77	5180	7	AP-C2-4F-03
1211	4	a	-81	-81	5180	7	AP-C-4F-01
1212	4	aa	-85.5	-85.5	2437	14	AP-C2-1F-01
1213	4	aa	-70.63076923	-70	2437	65	AP-C2-2F-01
1214	4	aa	-84	-84.5	2437	28	AP-C2-2F-02
1215	4	aa	-64.45348837	-65	2437	86	AP-C2-3F-01
1216	4	aa	-71.13953488	-70	2437	86	AP-C2-3F-02
1217	4	aa	-83.66666667	-84	2437	21	AP-C2-3F-03
1218	4	aa	-48.15	-46	2437	100	AP-C2-4F-01
1219	4	aa	-57.28	-57	2437	100	AP-C2-4F-02
1220	4	aa	-67.22222222	-66	2437	63	AP-C2-4F-03
1221	4	aa	-73.73417722	-74	2437	79	AP-C2-5F-01
1222	4	aa	-71.49019608	-72	2437	51	AP-C2-5F-02
1223	4	aa	-82.68627451	-82	2437	51	AP-C2-5F-03
1224	4	aa	-78.47692308	-79	2437	65	AP-C2-6F-01
1225	4	aa	-79.9	-80	2437	30	AP-C2-6F-02
1226	4	aa	-89.5	-89.5	5180	14	AP-C2-2F-01
1227	4	aa	-81.51388889	-82	5180	72	AP-C2-3F-01
1228	4	aa	-87.81818182	-87	5180	77	AP-C2-3F-02
1229	4	aa	-61	-61	5180	100	AP-C2-4F-01
1230	4	aa	-72.87096774	-72	5180	93	AP-C2-4F-02
1231	4	aa	-76	-76	5180	3	AP-C2-4F-03
1232	4	ab	-76.8	-77	2437	35	AP-C2-2F-01
1233	4	ab	-86	-86	2437	7	AP-C2-2F-02
1234	4	ab	-69.7	-70	2437	70	AP-C2-3F-01
1235	4	ab	-74.89873418	-74	2437	79	AP-C2-3F-02
1236	4	ab	-84	-84	2437	7	AP-C2-3F-03
1237	4	ab	-41.12	-44	2437	100	AP-C2-4F-01
1238	4	ab	-59.72	-60	2437	100	AP-C2-4F-02
1239	4	ab	-69.35443038	-70	2437	79	AP-C2-4F-03
1240	4	ab	-64.36363636	-64	2437	77	AP-C2-5F-01
1241	4	ab	-61.30232558	-60	2437	86	AP-C2-5F-02
1242	4	ab	-85	-85	2437	7	AP-C2-5F-03
1243	4	ab	-78.22222222	-78	2437	63	AP-C2-6F-01
1244	4	ab	-83	-83	2437	7	AP-C2-6F-02
1245	4	ab	-88.90909091	-89	5180	77	AP-C2-3F-01
1246	4	ab	-88	-88	5180	7	AP-C2-3F-02
1247	4	ab	-50.88	-50	5180	100	AP-C2-4F-01
1248	4	ab	-69.41860465	-68	5180	86	AP-C2-4F-02
1249	4	ab	-66.95	-67	5180	100	AP-C2-4F-03
1250	4	ab	-74.23529412	-74	5180	51	AP-C2-5F-01
1251	4	ab	-81	-81	5180	77	AP-C2-5F-02
1252	4	ab	-82.87096774	-83	5180	93	AP-C2-6F-01
1253	4	ac	-78.33333333	-78	2437	21	AP-C2-2F-01
1254	4	ac	-82	-82	2437	14	AP-C2-2F-02
1255	4	ac	-72.16666667	-71	2437	72	AP-C2-3F-01
1256	4	ac	-67.90909091	-68	2437	77	AP-C2-3F-02
1257	4	ac	-79	-79	2437	7	AP-C2-3F-03
1258	4	ac	-43.67	-44	2437	100	AP-C2-4F-01
1259	4	ac	-52.67	-53	2437	100	AP-C2-4F-02
1260	4	ac	-67.25581395	-66	2437	86	AP-C2-4F-03
1261	4	ac	-62.63636364	-62	2437	77	AP-C2-5F-01
1262	4	ac	-65.36363636	-65	2437	77	AP-C2-5F-02
1263	4	ac	-79	-79	2437	7	AP-C2-5F-03
1264	4	ac	-80.5	-80.5	2437	14	AP-C2-6F-01
1265	4	ac	-81.5	-81.5	2437	14	AP-C2-6F-03
1266	4	ac	-84	-84	2437	7	AP-C-4F-01
1267	4	ac	-92.75	-92.5	5180	28	AP-C2-2F-01
1268	4	ac	-90.5	-90.5	5180	42	AP-C2-2F-02
1269	4	ac	-87.34722222	-87	5180	72	AP-C2-3F-01
1270	4	ac	-80.16666667	-80.5	5180	84	AP-C2-3F-02
1271	4	ac	-48.67	-48	5180	100	AP-C2-4F-01
1272	4	ac	-64.91	-64	5180	100	AP-C2-4F-02
1273	4	ac	-75.28571429	-75	5180	98	AP-C2-4F-03
1274	4	ac	-73.95348837	-74	5180	43	AP-C2-5F-01
1275	4	ad	-89.88888889	-91	2437	9	AP-C2-1F-01
1276	4	ad	-77.66666667	-78	2437	21	AP-C2-2F-02
1277	4	ad	-79.66666667	-79	2437	21	AP-C2-3F-01
1278	4	ad	-63.84615385	-64	2437	91	AP-C2-3F-02
1279	4	ad	-82	-82	2437	7	AP-C2-3F-03
1280	4	ad	-58.13978495	-58	2437	93	AP-C2-4F-01
1281	4	ad	-53.44	-54	2437	100	AP-C2-4F-02
1282	4	ad	-62.42	-63	2437	100	AP-C2-4F-03
1283	4	ad	-62.27906977	-61	2437	86	AP-C2-5F-01
1284	4	ad	-63.21505376	-63	2437	93	AP-C2-5F-02
1285	4	ad	-83	-83	2437	9	AP-C2-5F-03
1286	4	ad	-76.08695652	-76	2437	23	AP-C2-6F-01
1287	4	ad	-82.375	-83	2437	16	AP-C2-6F-02
1288	4	ad	-85	-85	2437	7	AP-C2-6F-03
1289	4	ad	-91	-91	5180	2	AP-C2-3F-01
1290	4	ad	-83.5	-83	5180	56	AP-C2-3F-02
1291	4	ad	-63.21	-63	5180	100	AP-C2-4F-01
1292	4	ad	-58.82	-59	5180	100	AP-C2-4F-02
1293	4	ad	-70.67741935	-71	5180	93	AP-C2-4F-03
1294	4	ad	-82.56896552	-83	5180	58	AP-C2-5F-01
1295	4	ad	-80.15384615	-80	5180	91	AP-C2-5F-02
1296	4	ad	-91.46666667	-91	5180	30	AP-C2-6F-02
1297	4	ae	-78.5	-78.5	2437	14	AP-C2-2F-01
1298	4	ae	-75.29113924	-75	2437	79	AP-C2-2F-02
1299	4	ae	-78.53846154	-78	2437	65	AP-C2-3F-01
1300	4	ae	-60.56	-60	2437	100	AP-C2-3F-02
1301	4	ae	-76.5	-76.5	2437	70	AP-C2-3F-03
1302	4	ae	-60.42	-60	2437	100	AP-C2-4F-01
1303	4	ae	-48.17	-48	2437	100	AP-C2-4F-02
1304	4	ae	-60.77	-60	2437	100	AP-C2-4F-03
1305	4	ae	-66.74137931	-66	2437	58	AP-C2-5F-01
1306	4	ae	-62.53	-62	2437	100	AP-C2-5F-02
1307	4	ae	-73.36206897	-73	2437	58	AP-C2-5F-03
1308	4	ae	-88	-88	2437	14	AP-C2-6F-01
1309	4	ae	-80.25	-80.5	2437	28	AP-C2-6F-02
1310	4	ae	-85.33333333	-85	2437	21	AP-C2-6F-03
1311	4	ae	-90.11111111	-89	5180	9	AP-C2-2F-02
1312	4	ae	-78.16666667	-78	5180	84	AP-C2-3F-02
1313	4	ae	-91	-91	5180	14	AP-C2-3F-03
1314	4	ae	-69.84	-70	5180	100	AP-C2-4F-01
1315	4	ae	-58.60215054	-58	5180	93	AP-C2-4F-02
1316	4	ae	-73	-73	5180	1	AP-C2-4F-03
1317	4	af	-72.28571429	-72	2437	49	AP-C2-2F-02
1318	4	af	-86	-86	2437	14	AP-C2-3F-01
1319	4	af	-49.55	-49	2437	100	AP-C2-3F-02
1320	4	af	-76.20833333	-77	2437	24	AP-C2-3F-03
1321	4	af	-65.13978495	-65	2437	93	AP-C2-4F-01
1322	4	af	-36.85	-36	2437	100	AP-C2-4F-02
1323	4	af	-61.19	-60	2437	100	AP-C2-4F-03
1324	4	af	-72.53333333	-73	2437	90	AP-C2-5F-01
1325	4	af	-63.94623656	-64	2437	93	AP-C2-5F-02
1326	4	af	-70.9	-71	2437	70	AP-C2-5F-03
1327	4	af	-81.55	-80	2437	20	AP-C2-6F-01
1328	4	af	-75.75	-75	2437	48	AP-C2-6F-02
1329	4	af	-80	-80	2437	14	AP-C2-6F-03
1330	4	af	-78	-78	2437	6	AP-C-4F-01
1331	4	af	-66.49	-66	5180	100	AP-C2-3F-02
1332	4	af	-89.45	-90	5180	20	AP-C2-3F-03
1333	4	af	-72.65	-72	5180	100	AP-C2-4F-01
1334	4	af	-50.43	-51	5180	100	AP-C2-4F-02
1335	4	af	-63.42	-64	5180	100	AP-C2-4F-03
1336	4	af	-88	-88	5180	7	AP-C2-5F-01
1337	4	af	-77.8	-78	5180	20	AP-C2-5F-02
1338	4	ag	-88	-88	2437	7	AP-C2-1F-02
1339	4	ag	-82	-82	2437	7	AP-C2-2F-01
1340	4	ag	-74.79545455	-75	2437	44	AP-C2-2F-02
1341	4	ag	-82	-82	2437	7	AP-C2-2F-03
1342	4	ag	-79.20454545	-80	2437	44	AP-C2-3F-01
1343	4	ag	-53.6	-53	2437	100	AP-C2-3F-02
1344	4	ag	-73.25	-73	2437	28	AP-C2-3F-03
1345	4	ag	-65.14	-65	2437	100	AP-C2-4F-01
1346	4	ag	-43.65	-43	2437	100	AP-C2-4F-02
1347	4	ag	-58.12	-58	2437	100	AP-C2-4F-03
1348	4	ag	-81.33333333	-80.5	2437	42	AP-C2-5F-01
1349	4	ag	-59.4	-59	2437	100	AP-C2-5F-02
1350	4	ag	-69.72307692	-71	2437	65	AP-C2-5F-03
1351	4	ag	-87	-86	2437	21	AP-C2-6F-01
1352	4	ag	-75.8	-75	2437	70	AP-C2-6F-02
1353	4	ag	-77.6	-78	2437	35	AP-C2-6F-03
1354	4	ag	-89.37254902	-90	5180	51	AP-C2-2F-02
1355	4	ag	-75.2	-76.5	5180	70	AP-C2-3F-02
1356	4	ag	-85.6	-86	5180	70	AP-C2-3F-03
1357	4	ag	-72.31914894	-73	5180	47	AP-C2-4F-01
1358	4	ah	-71.75	-72	2437	28	AP-C2-2F-02
1359	4	ah	-85.5	-85.5	2437	14	AP-C2-2F-03
1360	4	ah	-79.89189189	-80	2437	37	AP-C2-3F-01
1361	4	ah	-67.83	-68	2437	100	AP-C2-3F-02
1362	4	ah	-79.18918919	-80	2437	37	AP-C2-3F-03
1363	4	ah	-72.07692308	-70	2437	65	AP-C2-4F-01
1364	4	ah	-45.21	-45	2437	100	AP-C2-4F-02
1365	4	ah	-62.81	-62	2437	100	AP-C2-4F-03
1366	4	ah	-64.90277778	-66	2437	72	AP-C2-5F-02
1367	4	ah	-62.70886076	-63	2437	79	AP-C2-5F-03
1368	4	ah	-75.5	-75.5	2437	14	AP-C2-6F-02
1369	4	ah	-79	-79	2437	14	AP-C2-6F-03
1370	4	ah	-79	-79	2437	7	AP-C-4F-01
1371	4	ah	-90.66666667	-91	5180	21	AP-C2-2F-02
1372	4	ah	-75.90909091	-76	5180	77	AP-C2-3F-02
1373	4	ah	-83.45454545	-83	5180	77	AP-C2-3F-03
1374	4	ah	-72.9	-73	5180	70	AP-C2-4F-01
1375	4	ah	-65.07	-65	5180	100	AP-C2-4F-02
1376	4	ah	-64.55	-65	5180	100	AP-C2-4F-03
1377	4	ah	-90.83333333	-91	5180	42	AP-C2-5F-01
1378	4	ah	-78.3255814	-78	5180	86	AP-C2-5F-02
1379	4	ah	-82.33333333	-83	5180	21	AP-C2-5F-03
1380	4	ah	-90.14285714	-90	5180	49	AP-C3-4F-02
1381	4	ai	-79.66666667	-82	2437	21	AP-C2-2F-02
1382	4	ai	-79.5	-79.5	2437	14	AP-C2-2F-03
1383	4	ai	-82.66666667	-83	2437	21	AP-C2-3F-01
1384	4	ai	-69.78	-70	2437	100	AP-C2-3F-02
1385	4	ai	-71.39240506	-72	2437	79	AP-C2-3F-03
1386	4	ai	-78.75	-78.5	2437	28	AP-C2-4F-01
1387	4	ai	-58.95	-60	2437	100	AP-C2-4F-02
1388	4	ai	-49.1	-48	2437	100	AP-C2-4F-03
1389	4	ai	-78	-78	2437	7	AP-C2-5F-01
1390	4	ai	-67.20253165	-67	2437	79	AP-C2-5F-02
1391	4	ai	-66.88172043	-67	2437	93	AP-C2-5F-03
1392	4	ai	-77.2	-77	2437	35	AP-C2-6F-03
1393	4	ai	-81.41772152	-81	5180	79	AP-C2-3F-02
1394	4	ai	-84.59302326	-85	5180	86	AP-C2-3F-03
1395	4	ai	-80.93846154	-81	5180	65	AP-C2-4F-01
1396	4	ai	-67.75268817	-66	5180	93	AP-C2-4F-02
1397	4	ai	-65.6	-65	5180	100	AP-C2-4F-03
1398	4	ai	-84.10126582	-83	5180	79	AP-C2-5F-02
1399	4	ai	-79.52272727	-80	5180	44	AP-C2-5F-03
1400	4	ai	-92.5	-92.5	5180	14	AP-C3-4F-02
1401	4	aj	-81.66666667	-81	2437	9	AP-C2-2F-02
1402	4	aj	-71.04545455	-72	2437	44	AP-C2-2F-03
1403	4	aj	-84.33333333	-85	2437	21	AP-C2-3F-01
1404	4	aj	-75	-76	2437	58	AP-C2-3F-02
1405	4	aj	-65.29113924	-65	2437	79	AP-C2-3F-03
1406	4	aj	-77.3	-76	2437	70	AP-C2-4F-01
1407	4	aj	-59.47	-59	2437	100	AP-C2-4F-02
1408	4	aj	-42.25	-43	2437	100	AP-C2-4F-03
1409	4	aj	-84	-85	2437	21	AP-C2-5F-01
1410	4	aj	-79.875	-78.5	2437	56	AP-C2-5F-02
1411	4	aj	-60.51	-61	2437	100	AP-C2-5F-03
1412	4	aj	-81.33333333	-80	2437	21	AP-C2-6F-02
1413	4	aj	-83.5	-83.5	2437	14	AP-C2-6F-03
1414	4	aj	-82.5625	-82	2437	16	AP-C-4F-01
1415	4	aj	-87.36923077	-88	5180	65	AP-C2-3F-02
1416	4	aj	-76.27848101	-76	5180	79	AP-C2-3F-03
1417	4	aj	-81.23076923	-82	5180	91	AP-C2-4F-01
1418	4	aj	-74.75581395	-75	5180	86	AP-C2-4F-02
1419	4	aj	-57.87	-58	5180	100	AP-C2-4F-03
1420	4	aj	-89.76666667	-90	5180	30	AP-C2-5F-02
1421	4	aj	-75.12790698	-76	5180	86	AP-C2-5F-03
1422	4	aj	-89.11363636	-89	5180	44	AP-C3-4F-01
1423	4	aj	-91	-91	5180	9	AP-C3-4F-02
1424	4	ak	-85	-85	2437	7	AP-C2-1F-03
1425	4	ak	-86.5	-86.5	2437	14	AP-C2-2F-02
1426	4	ak	-75.95652174	-75	2437	23	AP-C2-2F-03
1427	4	ak	-83	-83	2437	7	AP-C2-3F-01
1428	4	ak	-77.36363636	-78	2437	44	AP-C2-3F-02
1429	4	ak	-56.51	-56	2437	100	AP-C2-3F-03
1430	4	ak	-70.52941176	-70	2437	51	AP-C2-4F-01
1431	4	ak	-54.31	-54	2437	100	AP-C2-4F-02
1432	4	ak	-43.91	-44	2437	100	AP-C2-4F-03
1433	4	ak	-86	-86	2437	14	AP-C2-5F-01
1434	4	ak	-77.69565217	-78	2437	23	AP-C2-5F-02
1435	4	ak	-59.84	-61	2437	100	AP-C2-5F-03
1436	4	ak	-81.91304348	-81	2437	23	AP-C2-6F-02
1437	4	ak	-81.5	-81	2437	28	AP-C2-6F-03
1438	4	ak	-81.5	-81.5	2437	28	AP-C-4F-01
1439	4	ak	-90.5	-90.5	5180	14	AP-C2-3F-02
1440	4	ak	-77.61111111	-78	5180	72	AP-C2-3F-03
1441	4	ak	-83.41666667	-84	5180	72	AP-C2-4F-01
1442	4	ak	-73.2	-73	5180	70	AP-C2-4F-02
1443	4	ak	-49.49	-50	5180	100	AP-C2-4F-03
1444	4	ak	-73.23655914	-73	5180	93	AP-C2-5F-03
1445	4	ak	-90.93846154	-91	5180	65	AP-C3-4F-01
1446	4	ak	-89	-89	5180	49	AP-C3-4F-02
1447	4	al	-86	-86	2437	14	AP-C2-2F-02
1448	4	al	-74.3	-75	2437	30	AP-C2-2F-03
1449	4	al	-82.25	-82.5	2437	28	AP-C2-3F-01
1450	4	al	-73.4	-73	2437	35	AP-C2-3F-02
1451	4	al	-60.46	-60	2437	100	AP-C2-3F-03
1452	4	al	-70.0862069	-70	2437	58	AP-C2-4F-01
1453	4	al	-64.80645161	-65	2437	93	AP-C2-4F-02
1454	4	al	-42.41	-40	2437	100	AP-C2-4F-03
1455	4	al	-75.25862069	-74	2437	58	AP-C2-5F-02
1456	4	al	-62.9	-62	2437	100	AP-C2-5F-03
1457	4	al	-86.5	-86.5	2437	14	AP-C2-6F-02
1458	4	al	-72.01538462	-71	2437	65	AP-C2-6F-03
1459	4	al	-78	-78	2437	7	AP-C-4F-01
1460	4	al	-91	-91	5180	7	AP-C2-3F-02
1461	4	al	-72.85714286	-73	5180	98	AP-C2-3F-03
1462	4	al	-82.40277778	-83	5180	72	AP-C2-4F-01
1463	4	al	-72.63076923	-73	5180	65	AP-C2-4F-02
1464	4	al	-53.47	-54	5180	100	AP-C2-4F-03
1465	4	al	-88	-88	5180	14	AP-C2-5F-02
1466	4	al	-74.56976744	-74	5180	86	AP-C2-5F-03
1467	4	al	-90.75	-90.5	5180	28	AP-C2-6F-03
1468	4	al	-90.2	-90	5180	35	AP-C3-4F-01
1469	4	al	-87.04651163	-87	5180	86	AP-C3-4F-02
1470	4	am	-87	-87	2437	7	AP-C2-1F-03
1471	4	am	-84.8627451	-85	2437	51	AP-C2-2F-02
1472	4	am	-78.5	-78.5	2437	56	AP-C2-2F-03
1473	4	am	-81	-81	2437	7	AP-C2-3F-01
1474	4	am	-80	-81	2437	21	AP-C2-3F-02
1475	4	am	-62.07	-62	2437	100	AP-C2-3F-03
1476	4	am	-76	-75.5	2437	42	AP-C2-4F-01
1477	4	am	-71.17204301	-72	2437	93	AP-C2-4F-02
1478	4	am	-42.7	-43	2437	100	AP-C2-4F-03
1479	4	am	-81.5	-81	2437	28	AP-C2-5F-02
1480	4	am	-60.12	-60	2437	100	AP-C2-5F-03
1481	4	am	-73.09090909	-73	2437	77	AP-C2-6F-03
1482	4	am	-85	-85	2437	7	AP-C-4F-01
1483	4	am	-76.89534884	-78	5180	86	AP-C2-3F-03
1484	4	am	-83.03076923	-83	5180	65	AP-C2-4F-01
1485	4	am	-76.39534884	-77	5180	86	AP-C2-4F-02
1486	4	am	-49.32	-49	5180	100	AP-C2-4F-03
1487	4	am	-82.1827957	-83	5180	93	AP-C2-5F-03
1488	4	am	-92.5	-92.5	5180	14	AP-C2-6F-03
1489	4	am	-85.83333333	-86	5180	42	AP-C3-4F-01
1490	4	am	-86.93670886	-87	5180	79	AP-C3-4F-02
1491	4	an	-80.6	-81	2437	35	AP-C2-2F-03
1492	4	an	-84.5	-84.5	2437	14	AP-C2-3F-01
1493	4	an	-80.28571429	-80	2437	49	AP-C2-3F-02
1494	4	an	-56.52	-57	2437	100	AP-C2-3F-03
1495	4	an	-78.57142857	-79	2437	49	AP-C2-4F-01
1496	4	an	-69.3372093	-69	2437	86	AP-C2-4F-02
1497	4	an	-53.82	-54	2437	100	AP-C2-4F-03
1498	4	an	-83.6	-85	2437	35	AP-C2-5F-02
1499	4	an	-63.08	-62	2437	100	AP-C2-5F-03
1500	4	an	-79.5	-79.5	2437	14	AP-C2-6F-03
1501	4	an	-77.05063291	-77	5180	79	AP-C2-3F-03
1502	4	an	-80	-80	5180	79	AP-C2-4F-01
1503	4	an	-73.23655914	-74	5180	93	AP-C2-4F-02
1504	4	an	-58.93	-59	5180	100	AP-C2-4F-03
1505	4	an	-78.7311828	-79	5180	93	AP-C2-5F-03
1506	4	an	-84.65517241	-84	5180	58	AP-C3-4F-01
1507	4	an	-83.33333333	-83	5180	72	AP-C3-4F-02
1508	4	ao	-84	-84	2437	14	AP-C2-2F-03
1509	4	ao	-80.5	-80.5	2437	14	AP-C2-3F-02
1510	4	ao	-71.07692308	-71	2437	65	AP-C2-3F-03
1511	4	ao	-76	-76	2437	14	AP-C2-4F-01
1512	4	ao	-71.27777778	-71	2437	72	AP-C2-4F-02
1513	4	ao	-58.11	-58	2437	100	AP-C2-4F-03
1514	4	ao	-84	-84	2437	7	AP-C2-5F-01
1515	4	ao	-72.92405063	-74	2437	79	AP-C2-5F-03
1516	4	ao	-88	-88	2437	7	AP-C2-6F-03
1517	4	ao	-81.66666667	-81	2437	21	AP-C3-3F-03
1518	4	ao	-83	-83	2437	7	AP-C3-4F-01
1519	4	ao	-78.4	-77	2437	35	AP-C3-4F-02
1520	4	ao	-86	-86	2437	35	AP-C3-5F-02
1521	4	ao	-83.90322581	-83	5180	93	AP-C2-3F-03
1522	4	ao	-84.69444444	-85	5180	72	AP-C2-4F-01
1523	4	ao	-74.8255814	-75	5180	86	AP-C2-4F-02
1524	4	ao	-69.12	-69	5180	100	AP-C2-4F-03
1525	4	ao	-87.33333333	-87	5180	42	AP-C2-5F-03
1526	4	ao	-84.61111111	-84	5180	72	AP-C3-4F-01
1527	4	ao	-84	-84	5180	93	AP-C3-4F-02
1528	4	ap	-84.2	-85	2437	35	AP-C2-2F-03
1529	4	ap	-73.78	-74	2437	100	AP-C2-3F-03
1530	4	ap	-75.49230769	-76	2437	65	AP-C2-4F-01
1531	4	ap	-76.46236559	-75	2437	93	AP-C2-4F-02
1532	4	ap	-70.3655914	-71	2437	93	AP-C2-4F-03
1533	4	ap	-87	-87	2437	7	AP-C2-5F-02
1534	4	ap	-76.28846154	-75	2437	52	AP-C2-5F-03
1535	4	ap	-86	-86	2437	7	AP-C2-6F-03
1536	4	ap	-85.5	-85.5	2437	28	AP-C3-2F-03
1537	4	ap	-83	-83	2437	7	AP-C3-3F-03
1538	4	ap	-84.5	-84.5	2437	14	AP-C3-4F-01
1539	4	ap	-78.51923077	-78	2437	52	AP-C3-4F-02
1540	4	ap	-86.4	-85	2437	35	AP-C-4F-01
1541	4	ap	-89.01265823	-89	5180	79	AP-C2-3F-03
1542	4	ap	-87.5	-87	5180	42	AP-C2-4F-01
1543	4	ap	-80.8172043	-81	5180	93	AP-C2-4F-02
1544	4	ap	-73.48387097	-73	5180	93	AP-C2-4F-03
1545	4	ap	-90.66666667	-90	5180	21	AP-C2-5F-03
1546	4	ap	-87.63414634	-89	5180	41	AP-C3-4F-01
1547	4	ap	-78.33333333	-78	5180	93	AP-C3-4F-02
1548	4	aq	-83.5	-84.5	2437	28	AP-C2-2F-03
1549	4	aq	-89	-89	2437	7	AP-C2-3F-02
1550	4	aq	-74.30379747	-74	2437	79	AP-C2-3F-03
1551	4	aq	-77.04615385	-77	2437	65	AP-C2-4F-01
1552	4	aq	-81.77777778	-83	2437	63	AP-C2-4F-02
1553	4	aq	-70.7311828	-70	2437	93	AP-C2-4F-03
1554	4	aq	-85	-85	2437	7	AP-C2-5F-01
1555	4	aq	-83	-83.5	2437	28	AP-C2-5F-03
1556	4	aq	-80.25	-80	2437	28	AP-C3-2F-03
1557	4	aq	-82.28571429	-82	2437	49	AP-C3-3F-03
1558	4	aq	-81.34482759	-81	2437	58	AP-C3-4F-01
1559	4	aq	-74.47311828	-75	2437	93	AP-C3-4F-02
1560	4	aq	-85.83783784	-86	2437	37	AP-C3-5F-02
1561	4	aq	-86	-86	2437	7	AP-C-4F-01
1562	4	aq	-92	-92	5180	14	AP-C2-3F-03
1563	4	aq	-83.48387097	-84	5180	93	AP-C2-4F-01
1564	4	aq	-82.34722222	-83	5180	72	AP-C2-4F-02
1565	4	aq	-75.56976744	-75	5180	86	AP-C2-4F-03
1566	4	aq	-91.5	-91.5	5180	28	AP-C3-3F-03
1567	4	aq	-88.5	-89	5180	72	AP-C3-4F-01
1568	4	aq	-73.91397849	-74	5180	93	AP-C3-4F-02
1569	4	ar	-72.25316456	-73	2437	79	AP-C2-3F-03
1570	4	ar	-81.33333333	-82	2437	21	AP-C2-4F-01
1571	4	ar	-81	-82	2437	21	AP-C2-4F-02
1572	4	ar	-66.64516129	-66	2437	93	AP-C2-4F-03
1573	4	ar	-84.33333333	-82	2437	21	AP-C2-5F-03
1574	4	ar	-76	-76	2437	35	AP-C3-2F-03
1575	4	ar	-77.8	-77	2437	35	AP-C3-3F-02
1576	4	ar	-63.09	-63	2437	100	AP-C3-3F-03
1577	4	ar	-71.4137931	-71	2437	58	AP-C3-4F-01
1578	4	ar	-63.17204301	-63	2437	93	AP-C3-4F-02
1579	4	ar	-82.25	-82	2437	28	AP-C3-5F-02
1580	4	ar	-87	-87	2437	7	AP-C-4F-01
1581	4	ar	-87.87341772	-88	5180	79	AP-C2-4F-01
1582	4	ar	-81.5	-81	5180	70	AP-C2-4F-02
1583	4	ar	-77.44303797	-79	5180	79	AP-C2-4F-03
1584	4	ar	-91.25	-91.5	5180	28	AP-C3-3F-03
1585	4	ar	-81.26744186	-82	5180	86	AP-C3-4F-01
1586	4	ar	-74.53164557	-74	5180	79	AP-C3-4F-02
1587	4	ar	-91.5	-91.5	5180	28	AP-C3-5F-02
1588	4	as	-86	-87	2437	21	AP-C2-3F-01
1589	4	as	-74.55172414	-74	2437	58	AP-C2-3F-03
1590	4	as	-76.13513514	-76	2437	37	AP-C2-4F-01
1591	4	as	-65.05813953	-65	2437	86	AP-C2-4F-02
1592	4	as	-61.77906977	-62	2437	86	AP-C2-4F-03
1593	4	as	-87.5	-87.5	2437	14	AP-C2-5F-01
1594	4	as	-80.4	-82	2437	70	AP-C2-5F-03
1595	4	as	-89	-89	2437	7	AP-C2-6F-03
1596	4	as	-84.9	-86	2437	30	AP-C3-3F-01
1597	4	as	-83.05405405	-84	2437	37	AP-C3-3F-02
1598	4	as	-69.69444444	-68	2437	72	AP-C3-3F-03
1599	4	as	-66.51	-66	2437	100	AP-C3-4F-01
1600	4	as	-63.78	-63	2437	100	AP-C3-4F-02
1601	4	as	-79.02325581	-80	2437	86	AP-C3-5F-02
1602	4	as	-79.66666667	-79	2437	42	AP-C-4F-01
1603	4	as	-87.63333333	-87	5180	30	AP-C2-3F-03
1604	4	as	-80.53846154	-81	5180	65	AP-C2-4F-01
1605	4	as	-66.01	-66	5180	100	AP-C2-4F-02
1606	4	as	-72	-72	5180	86	AP-C2-4F-03
1607	4	as	-92.33333333	-92	5180	21	AP-C2-5F-02
1608	4	as	-87.05405405	-87	5180	37	AP-C2-5F-03
1609	4	as	-84.15909091	-84	5180	44	AP-C3-3F-03
1610	4	as	-69.61445783	-70	5180	83	AP-C3-4F-01
1611	4	at	-82.5	-82.5	2437	14	AP-C2-3F-03
1612	4	at	-76.56862745	-76	2437	51	AP-C2-4F-02
1613	4	at	-78.2745098	-78	2437	51	AP-C2-4F-03
1614	4	at	-84.25	-84.5	2437	28	AP-C2-5F-03
1615	4	at	-69.88888889	-69	2437	63	AP-C3-2F-03
1616	4	at	-77.18918919	-78	2437	37	AP-C3-3F-01
1617	4	at	-78.87692308	-79	2437	65	AP-C3-3F-02
1618	4	at	-59.45	-59	2437	100	AP-C3-3F-03
1619	4	at	-60.27	-60	2437	100	AP-C3-4F-01
1620	4	at	-59.07	-59	2437	100	AP-C3-4F-02
1621	4	at	-80.5	-79.5	2437	42	AP-C3-5F-01
1622	4	at	-68.09090909	-68	2437	77	AP-C3-5F-02
1623	4	at	-90	-90	5180	21	AP-C2-4F-01
1624	4	at	-83.19444444	-83	5180	72	AP-C2-4F-02
1625	4	at	-80.08333333	-80	5180	72	AP-C2-4F-03
1626	4	at	-92	-92	5180	14	AP-C3-3F-02
1627	4	at	-75.19354839	-75	5180	93	AP-C3-3F-03
1628	4	at	-77.44086022	-77	5180	93	AP-C3-4F-01
1629	4	at	-67.49	-67	5180	100	AP-C3-4F-02
1630	4	at	-87.5	-87.5	5180	28	AP-C3-5F-02
1631	4	au	-88	-88	2437	14	AP-C2-3F-03
1632	4	au	-82.75	-82	2437	28	AP-C2-4F-03
1633	4	au	-83.16666667	-82.5	2437	42	AP-C3-2F-02
1634	4	au	-78.44444444	-78	2437	63	AP-C3-2F-03
1635	4	au	-85.83333333	-86	2437	42	AP-C3-3F-01
1636	4	au	-65.59302326	-65	2437	86	AP-C3-3F-02
1637	4	au	-56.91	-56	2437	100	AP-C3-3F-03
1638	4	au	-71.07692308	-72	2437	91	AP-C3-4F-01
1639	4	au	-52.39	-52	2437	100	AP-C3-4F-02
1640	4	au	-80.63888889	-81	2437	72	AP-C3-5F-01
1641	4	au	-69.79746835	-69	2437	79	AP-C3-5F-02
1642	4	au	-93	-93	5180	7	AP-C2-4F-01
1643	4	au	-89.61111111	-90	5180	72	AP-C2-4F-03
1644	4	au	-93	-93	5180	7	AP-C3-2F-03
1645	4	au	-88.45098039	-88	5180	51	AP-C3-3F-02
1646	4	au	-70.69	-71	5180	100	AP-C3-3F-03
1647	4	au	-67.6	-68	5180	100	AP-C3-4F-01
1648	4	au	-68.82	-69	5180	100	AP-C3-4F-02
1649	4	au	-78.875	-79	5180	72	AP-C3-5F-02
1650	4	av	-82.2	-83	2437	35	AP-C2-4F-03
1651	4	av	-86	-86	2437	42	AP-C3-1F-02
1652	4	av	-83.15384615	-83	2437	65	AP-C3-2F-02
1653	4	av	-81.04545455	-82	2437	44	AP-C3-2F-03
1654	4	av	-78.66666667	-79	2437	30	AP-C3-3F-01
1655	4	av	-64.17204301	-64	2437	93	AP-C3-3F-02
1656	4	av	-60.23	-60	2437	100	AP-C3-3F-03
1657	4	av	-72.55	-74	2437	100	AP-C3-4F-01
1658	4	av	-44.57	-45	2437	100	AP-C3-4F-02
1659	4	av	-82.63793103	-83	2437	58	AP-C3-5F-01
1660	4	av	-61.73611111	-62	2437	72	AP-C3-5F-02
1661	4	av	-90.25	-90.5	5180	28	AP-C3-3F-01
1662	4	av	-87	-86.5	5180	56	AP-C3-3F-02
1663	4	av	-73.81	-74	5180	100	AP-C3-3F-03
1664	4	av	-70.10465116	-70	5180	86	AP-C3-4F-01
1665	4	av	-57.06	-56	5180	100	AP-C3-4F-02
1666	4	av	-79	-79	5180	84	AP-C3-5F-02
1667	4	aw	-81.7037037	-81	2437	27	AP-C2-4F-03
1668	4	aw	-86.5	-86.5	2437	14	AP-C3-1F-02
1669	4	aw	-83	-83	2437	21	AP-C3-2F-01
1670	4	aw	-84.25	-85	2437	28	AP-C3-2F-02
1671	4	aw	-82.13333333	-80	2437	30	AP-C3-2F-03
1672	4	aw	-76.4375	-76	2437	48	AP-C3-3F-01
1673	4	aw	-60.8	-61	2437	100	AP-C3-3F-02
1674	4	aw	-65.39	-66	2437	100	AP-C3-3F-03
1675	4	aw	-65.51	-65	2437	100	AP-C3-4F-01
1676	4	aw	-46.38	-46	2437	100	AP-C3-4F-02
1677	4	aw	-84.33333333	-84	2437	21	AP-C3-5F-01
1678	4	aw	-63.16666667	-63	2437	72	AP-C3-5F-02
1679	4	aw	-90	-90	5180	7	AP-C2-4F-02
1680	4	aw	-87.16438356	-88	5180	73	AP-C3-3F-02
1681	4	aw	-83.60465116	-84	5180	86	AP-C3-3F-03
1682	4	aw	-67.49	-68	5180	100	AP-C3-4F-01
1683	4	aw	-56.17	-56	5180	100	AP-C3-4F-02
1684	4	aw	-75.86153846	-76	5180	65	AP-C3-5F-02
1685	4	ax	-85	-85	2437	14	AP-C3-1F-02
1686	4	ax	-83.4	-82	2437	30	AP-C3-2F-01
1687	4	ax	-84.5	-84	2437	30	AP-C3-2F-02
1688	4	ax	-80.25	-80	2437	56	AP-C3-2F-03
1689	4	ax	-70.62790698	-70	2437	86	AP-C3-3F-01
1690	4	ax	-57.14	-57	2437	100	AP-C3-3F-02
1691	4	ax	-63.61	-62	2437	100	AP-C3-3F-03
1692	4	ax	-62.12	-62	2437	100	AP-C3-4F-01
1693	4	ax	-37.05	-36	2437	100	AP-C3-4F-02
1694	4	ax	-83	-83	2437	35	AP-C3-5F-01
1695	4	ax	-61.5	-61.5	2437	98	AP-C3-5F-02
1696	4	ax	-90.5	-90.5	5180	14	AP-C3-3F-01
1697	4	ax	-84.83076923	-86	5180	65	AP-C3-3F-02
1698	4	ax	-83.53846154	-84	5180	65	AP-C3-3F-03
1699	4	ax	-72.7	-73	5180	100	AP-C3-4F-01
1700	4	ax	-48.93	-49	5180	100	AP-C3-4F-02
1701	4	ax	-90.5	-90.5	5180	14	AP-C3-5F-01
1702	4	ax	-82.94623656	-82	5180	93	AP-C3-5F-02
1703	4	ay	-81	-80.5	2437	28	AP-C3-1F-02
1704	4	ay	-85	-85	2437	7	AP-C3-2F-01
1705	4	ay	-78.75	-78	2437	56	AP-C3-2F-02
1706	4	ay	-84	-84	2437	7	AP-C3-2F-03
1707	4	ay	-76.78461538	-77	2437	65	AP-C3-3F-01
1708	4	ay	-52.82	-53	2437	100	AP-C3-3F-02
1709	4	ay	-74.8	-76	2437	35	AP-C3-3F-03
1710	4	ay	-62.47	-62	2437	100	AP-C3-4F-01
1711	4	ay	-42.05	-42	2437	100	AP-C3-4F-02
1712	4	ay	-75.74	-76	2437	100	AP-C3-5F-01
1713	4	ay	-63.45348837	-64	2437	86	AP-C3-5F-02
1714	4	ay	-88	-89	5180	56	AP-C3-3F-01
1715	4	ay	-76.20253165	-76	5180	79	AP-C3-3F-02
1716	4	ay	-88.83333333	-90.5	5180	42	AP-C3-3F-03
1717	4	ay	-68.26	-67	5180	100	AP-C3-4F-01
1718	4	ay	-62.81	-64	5180	100	AP-C3-4F-02
1719	4	ay	-89	-89	5180	7	AP-C3-5F-01
1720	4	ay	-79.17721519	-78	5180	79	AP-C3-5F-02
1721	4	az	-81	-81	2437	7	AP-C3-1F-02
1722	4	az	-82.375	-82	2437	56	AP-C3-2F-01
1723	4	az	-79.34408602	-79	2437	93	AP-C3-2F-02
1724	4	az	-89	-89	2437	7	AP-C3-2F-03
1725	4	az	-75.36	-76	2437	100	AP-C3-3F-01
1726	4	az	-49.8	-50	2437	100	AP-C3-3F-02
1727	4	az	-72.81034483	-73	2437	58	AP-C3-3F-03
1728	4	az	-64.68	-64	2437	100	AP-C3-4F-01
1729	4	az	-51.4	-50	2437	100	AP-C3-4F-02
1730	4	az	-77.17721519	-78	2437	79	AP-C3-5F-01
1731	4	az	-74.70886076	-76	2437	79	AP-C3-5F-02
1732	4	az	-87.41666667	-88	5180	72	AP-C3-3F-01
1733	4	az	-69.68	-69	5180	100	AP-C3-3F-02
1734	4	az	-65.6	-66	5180	100	AP-C3-4F-01
1735	4	az	-64.21	-64	5180	100	AP-C3-4F-02
1736	4	az	-90.5	-90.5	5180	28	AP-C3-5F-01
1737	4	az	-89.5	-89.5	5180	14	AP-C3-5F-02
1738	4	b	-73.5	-74	2437	28	AP-C-2F-01
1739	4	b	-61.06329114	-60	2437	79	AP-C-3F-02
1740	4	b	-79.5	-80	2437	42	AP-C-3F-03
1741	4	b	-46.23	-46	2437	100	AP-C-4F-02
1742	4	b	-57.43010753	-58	2437	93	AP-C-4F-03
1743	4	b	-64.36363636	-64	2437	77	AP-C-4F-04
1744	4	b	-67.82278481	-69	2437	79	AP-C-5F-02
1745	4	b	-65.4	-65	2437	35	AP-C-5F-03
1746	4	b	-82	-82	2437	7	AP-C-5F-04
1747	4	b	-86	-86	2437	7	AP-C-6F-03
1748	4	b	-79.37974684	-79	5180	79	AP-C-3F-02
1749	4	b	-49.58	-49	5180	100	AP-C-4F-02
1750	4	b	-61.74	-62	5180	100	AP-C-4F-03
1751	4	b	-76.56944444	-77	5180	72	AP-C-4F-04
1752	4	b	-78.84090909	-79	5180	44	AP-C-5F-02
1753	4	b	-77.43037975	-77	5180	79	AP-C-5F-03
1754	4	ba	-83.5	-83.5	2437	42	AP-C3-2F-01
1755	4	ba	-77.44444444	-76	2437	63	AP-C3-2F-02
1756	4	ba	-86.33333333	-86	2437	21	AP-C3-2F-03
1757	4	ba	-61.35	-60	2437	100	AP-C3-3F-01
1758	4	ba	-60.68	-60	2437	100	AP-C3-3F-02
1759	4	ba	-85.33333333	-85	2437	42	AP-C3-3F-03
1760	4	ba	-53.35	-53	2437	100	AP-C3-4F-01
1761	4	ba	-60.28	-60	2437	100	AP-C3-4F-02
1762	4	ba	-70.09302326	-69	2437	86	AP-C3-5F-01
1763	4	ba	-67.3	-66	2437	70	AP-C3-5F-02
1764	4	ba	-89.16666667	-89	5180	42	AP-C3-2F-02
1765	4	ba	-84.47674419	-84	5180	86	AP-C3-3F-01
1766	4	ba	-77.61538462	-78	5180	91	AP-C3-3F-02
1767	4	ba	-62.78	-63	5180	100	AP-C3-4F-01
1768	4	ba	-65.65	-66	5180	100	AP-C3-4F-02
1769	4	ba	-89	-89	5180	63	AP-C3-5F-01
1770	4	ba	-86.7721519	-86	5180	79	AP-C3-5F-02
1771	4	bb	-82.85714286	-84	2437	49	AP-C3-2F-01
1772	4	bb	-77.81034483	-77	2437	58	AP-C3-2F-02
1773	4	bb	-63.84946237	-64	2437	93	AP-C3-3F-01
1774	4	bb	-61.13	-62	2437	100	AP-C3-3F-02
1775	4	bb	-80.5	-81	2437	28	AP-C3-3F-03
1776	4	bb	-49.36	-49	2437	100	AP-C3-4F-01
1777	4	bb	-59.37	-60	2437	100	AP-C3-4F-02
1778	4	bb	-65.46236559	-66	2437	93	AP-C3-5F-01
1779	4	bb	-71.07692308	-71	2437	65	AP-C3-5F-02
1780	4	bb	-91.5	-91.5	5180	14	AP-C3-2F-01
1781	4	bb	-84	-84	5180	86	AP-C3-3F-01
1782	4	bb	-85	-85	5180	63	AP-C3-3F-02
1783	4	bb	-63.05	-62	5180	100	AP-C3-4F-01
1784	4	bb	-68.04	-68	5180	100	AP-C3-4F-02
1785	4	bb	-87.33846154	-88	5180	65	AP-C3-5F-01
1786	4	bb	-90.33333333	-92	5180	21	AP-C3-5F-02
1787	4	bc	-84.75	-84.5	2437	28	AP-C3-1F-01
1788	4	bc	-73	-74	2437	72	AP-C3-2F-01
1789	4	bc	-80.56962025	-81	2437	79	AP-C3-2F-02
1790	4	bc	-63.43	-64	2437	100	AP-C3-3F-01
1791	4	bc	-76.76470588	-77	2437	51	AP-C3-3F-02
1792	4	bc	-81.71428571	-82	2437	49	AP-C3-3F-03
1793	4	bc	-46.29	-45	2437	100	AP-C3-4F-01
1794	4	bc	-64.85	-64	2437	100	AP-C3-4F-02
1795	4	bc	-58.62	-59	2437	100	AP-C3-5F-01
1796	4	bc	-74.42857143	-74	2437	49	AP-C3-5F-02
1797	4	bc	-91	-91	5180	56	AP-C3-2F-01
1798	4	bc	-81.83076923	-82	5180	65	AP-C3-3F-01
1799	4	bc	-83.74193548	-84	5180	93	AP-C3-3F-02
1800	4	bc	-59.26	-58	5180	100	AP-C3-4F-01
1801	4	bc	-68.88	-69	5180	100	AP-C3-4F-02
1802	4	bc	-81.11111111	-80	5180	72	AP-C3-5F-01
1803	4	bc	-95	-95	5180	2	AP-C3-5F-02
1804	4	bd	-86.81081081	-87	2437	37	AP-C3-1F-01
1805	4	bd	-71.27848101	-70	2437	79	AP-C3-2F-01
1806	4	bd	-81	-81	2437	49	AP-C3-2F-02
1807	4	bd	-55.98	-55	2437	100	AP-C3-3F-01
1808	4	bd	-73.25581395	-73	2437	86	AP-C3-3F-02
1809	4	bd	-83.28571429	-83	2437	49	AP-C3-3F-03
1810	4	bd	-41.22	-41	2437	100	AP-C3-4F-01
1811	4	bd	-67.05	-66	2437	100	AP-C3-4F-02
1812	4	bd	-60.72	-61	2437	100	AP-C3-5F-01
1813	4	bd	-77.36923077	-77	2437	65	AP-C3-5F-02
1814	4	bd	-89	-89	5180	7	AP-C2-4F-02
1815	4	bd	-89	-89	5180	63	AP-C3-2F-01
1816	4	bd	-80.57142857	-80	5180	49	AP-C3-3F-01
1817	4	bd	-89.83333333	-90	5180	42	AP-C3-3F-02
1818	4	bd	-52.77	-53	5180	100	AP-C3-4F-01
1819	4	bd	-69.24	-69	5180	100	AP-C3-4F-02
1820	4	bd	-86.11627907	-86	5180	86	AP-C3-5F-01
1821	4	bd	-91	-91	5180	14	AP-C3-5F-02
1822	4	be	-85.5	-85.5	2437	14	AP-B2-3F-03
1823	4	be	-75.97468354	-75	2437	79	AP-C3-2F-01
1824	4	be	-85.43478261	-86	2437	23	AP-C3-2F-02
1825	4	be	-49.49	-49	2437	100	AP-C3-3F-01
1826	4	be	-75.55696203	-75	2437	79	AP-C3-3F-02
1827	4	be	-83.28571429	-83	2437	49	AP-C3-3F-03
1828	4	be	-38.37	-38	2437	100	AP-C3-4F-01
1829	4	be	-62.24418605	-62	2437	86	AP-C3-4F-02
1830	4	be	-55.26	-55	2437	100	AP-C3-5F-01
1831	4	be	-79.68181818	-79	2437	44	AP-C3-5F-02
1832	4	be	-89.58333333	-89.5	5180	84	AP-C2-4F-02
1833	4	be	-89.81818182	-90	5180	77	AP-C3-2F-01
1834	4	be	-71.11627907	-71	5180	86	AP-C3-3F-01
1835	4	be	-90.66666667	-90	5180	63	AP-C3-3F-02
1836	4	be	-46.91	-47	5180	100	AP-C3-4F-01
1837	4	be	-74.68	-75	5180	100	AP-C3-4F-02
1838	4	be	-74.95698925	-74	5180	93	AP-C3-5F-01
1839	4	bf	-70.13953488	-70	2437	86	AP-C3-2F-01
1840	4	bf	-85.5	-85.5	2437	14	AP-C3-2F-02
1841	4	bf	-57.76344086	-59	2437	93	AP-C3-3F-01
1842	4	bf	-81.74137931	-82	2437	58	AP-C3-3F-02
1843	4	bf	-49.73	-51	2437	100	AP-C3-4F-01
1844	4	bf	-69.64615385	-71	2437	65	AP-C3-4F-02
1845	4	bf	-59.02	-60	2437	100	AP-C3-5F-01
1846	4	bf	-81.76666667	-82	2437	30	AP-C3-5F-02
1847	4	bf	-92.43478261	-92	5180	23	AP-C2-4F-02
1848	4	bf	-75.21518987	-76	5180	79	AP-C3-3F-01
1849	4	bf	-90	-90	5180	7	AP-C3-3F-02
1850	4	bf	-56.39	-57	5180	100	AP-C3-4F-01
1851	4	bf	-71.02150538	-71	5180	93	AP-C3-4F-02
1852	4	bf	-86.35443038	-86	5180	79	AP-C3-5F-01
1853	4	bg	-73.0862069	-73	2437	58	AP-C3-2F-01
1854	4	bg	-64.57	-65	2437	100	AP-C3-3F-01
1855	4	bg	-79.98275862	-79	2437	58	AP-C3-3F-02
1856	4	bg	-84	-84	2437	49	AP-C3-3F-03
1857	4	bg	-48.55	-48	2437	100	AP-C3-4F-01
1858	4	bg	-69.65	-69	2437	100	AP-C3-4F-02
1859	4	bg	-61.7	-61	2437	100	AP-C3-5F-01
1860	4	bg	-79.37931034	-80	2437	58	AP-C3-5F-02
1861	4	bg	-93	-93	5180	7	AP-C2-4F-02
1862	4	bg	-90.1	-89	5180	70	AP-C3-2F-01
1863	4	bg	-73.7311828	-74	5180	93	AP-C3-3F-01
1864	4	bg	-92	-92	5180	14	AP-C3-3F-02
1865	4	bg	-62.26	-62	5180	100	AP-C3-4F-01
1866	4	bg	-67.5483871	-67	5180	93	AP-C3-4F-02
1867	4	bg	-79.50632911	-80	5180	79	AP-C3-5F-01
1868	4	c	-76.75	-76.5	2437	28	AP-C-2F-01
1869	4	c	-62.46511628	-62	2437	86	AP-C-3F-02
1870	4	c	-68.05555556	-68	2437	72	AP-C-3F-03
1871	4	c	-79	-79	2437	2	AP-C-3F-04
1872	4	c	-38.02150538	-39	2437	93	AP-C-4F-02
1873	4	c	-61.95698925	-61	2437	93	AP-C-4F-03
1874	4	c	-68.78461538	-69	2437	65	AP-C-4F-04
1875	4	c	-73.14285714	-74	2437	49	AP-C-5F-02
1876	4	c	-65.2	-65	2437	35	AP-C-5F-03
1877	4	c	-85	-85	2437	7	AP-C-5F-04
1878	4	c	-77	-77	2437	7	AP-C-6F-02
1879	4	c	-80	-80	2437	7	AP-C-6F-03
1880	4	c	-83.31944444	-83	5180	72	AP-C-3F-02
1881	4	c	-86.77777778	-86	5180	72	AP-C-3F-03
1882	4	c	-59.12	-59	5180	100	AP-C-4F-02
1883	4	c	-59.44	-59	5180	100	AP-C-4F-03
1884	4	c	-76.91139241	-77	5180	79	AP-C-4F-04
1885	4	c	-83.41538462	-83	5180	65	AP-C-5F-02
1886	4	c	-74.08333333	-73.5	5180	84	AP-C-5F-03
1887	4	d	-79.6875	-80	2437	16	AP-C-2F-01
1888	4	d	-69.6	-70	2437	35	AP-C-3F-02
1889	4	d	-61.74	-61	2437	100	AP-C-3F-03
1890	4	d	-57.8172043	-59	2437	93	AP-C-4F-02
1891	4	d	-61.37	-62	2437	100	AP-C-4F-03
1892	4	d	-61.7	-62	2437	100	AP-C-4F-04
1893	4	d	-67.13924051	-66	2437	79	AP-C-5F-02
1894	4	d	-62.22413793	-63	2437	58	AP-C-5F-03
1895	4	d	-77	-77	2437	7	AP-C-5F-04
1896	4	d	-77.33333333	-77	2437	21	AP-C-6F-02
1897	4	d	-84.5	-84.5	2437	14	AP-C-6F-03
1898	4	d	-81.93103448	-82	5180	58	AP-C-3F-02
1899	4	d	-88	-88	5180	49	AP-C-3F-03
1900	4	d	-64.23	-65	5180	100	AP-C-4F-02
1901	4	d	-58.35	-58	5180	100	AP-C-4F-03
1902	4	d	-76.01388889	-76	5180	72	AP-C-4F-04
1903	4	d	-83.53846154	-83	5180	65	AP-C-5F-02
1904	4	d	-80.90697674	-78	5180	86	AP-C-5F-03
1905	4	e	-85.44444444	-85	2437	9	AP-C-1F-01
1906	4	e	-70.82352941	-71	2437	51	AP-C-2F-01
1907	4	e	-79.55555556	-79	2437	63	AP-C-3F-02
1908	4	e	-68.83544304	-68	2437	79	AP-C-3F-03
1909	4	e	-75	-75	2437	7	AP-C-3F-04
1910	4	e	-52.68	-53	2437	100	AP-C-4F-02
1911	4	e	-41.77	-41	2437	100	AP-C-4F-03
1912	4	e	-61.95	-63	2437	100	AP-C-4F-04
1913	4	e	-79.23611111	-78	2437	72	AP-C-5F-02
1914	4	e	-63.46835443	-63	2437	79	AP-C-5F-03
1915	4	e	-81	-82	2437	21	AP-C-5F-04
1916	4	e	-82	-82	2437	7	AP-C-6F-02
1917	4	e	-76	-76	2437	7	AP-C-6F-03
1918	4	e	-87.86153846	-88	5180	65	AP-C-3F-02
1919	4	e	-80.91666667	-81	5180	84	AP-C-3F-03
1920	4	e	-65.96	-65	5180	100	AP-C-4F-02
1921	4	e	-58.75	-58	5180	100	AP-C-4F-03
1922	4	e	-69.54	-70	5180	100	AP-C-4F-04
1923	4	e	-89.25	-89.5	5180	56	AP-C-5F-02
1924	4	e	-75.58461538	-75	5180	65	AP-C-5F-03
1925	4	e	-90	-90	5180	7	AP-C-5F-04
1926	4	f	-88	-88	2437	7	AP-C-1F-01
1927	4	f	-82.83783784	-83	2437	37	AP-C-2F-01
1928	4	f	-82	-82	2437	7	AP-C-2F-02
1929	4	f	-76.57142857	-76	2437	49	AP-C-3F-02
1930	4	f	-55.39784946	-56	2437	93	AP-C-3F-03
1931	4	f	-79.36666667	-80	2437	30	AP-C-3F-04
1932	4	f	-63.23076923	-63	2437	91	AP-C-4F-02
1933	4	f	-38.79	-38	2437	100	AP-C-4F-03
1934	4	f	-63.6744186	-63	2437	86	AP-C-4F-04
1935	4	f	-77.875	-77	2437	56	AP-C-5F-02
1936	4	f	-64.36363636	-63	2437	77	AP-C-5F-03
1937	4	f	-76	-76	2437	23	AP-C-5F-04
1938	4	f	-74.85714286	-75	2437	49	AP-C-6F-03
1939	4	f	-82	-82	2437	2	AP-C-6F-04
1940	4	f	-89.5	-89.5	5180	14	AP-C-3F-02
1941	4	f	-68.30107527	-68	5180	93	AP-C-3F-03
1942	4	f	-90	-89.5	5180	28	AP-C-3F-04
1943	4	f	-71.96774194	-72	5180	93	AP-C-4F-02
1944	4	f	-52.11	-52	5180	100	AP-C-4F-03
1945	4	f	-71.22	-71	5180	100	AP-C-4F-04
1946	4	f	-89.66666667	-89	5180	42	AP-C-5F-02
1947	4	f	-78.70886076	-79	5180	79	AP-C-5F-03
1948	4	f	-92	-92	5180	7	AP-C-5F-04
1949	4	g	-88	-88	2437	14	AP-C-1F-01
1950	4	g	-79.57142857	-80	2437	49	AP-C-2F-01
1951	4	g	-81.66666667	-82	2437	21	AP-C-2F-02
1952	4	g	-80.4	-80	2437	35	AP-C-3F-02
1953	4	g	-54.65	-54	2437	100	AP-C-3F-03
1954	4	g	-75.83333333	-76	2437	42	AP-C-3F-04
1955	4	g	-62	-62	2437	93	AP-C-4F-02
1956	4	g	-43.72	-43	2437	100	AP-C-4F-03
1957	4	g	-57.71	-57	2437	100	AP-C-4F-04
1958	4	g	-71.86111111	-72	2437	72	AP-C-5F-02
1959	4	g	-66	-64.5	2437	70	AP-C-5F-03
1960	4	g	-75.60344828	-76	2437	58	AP-C-5F-04
1961	4	g	-83	-83	2437	7	AP-C-6F-03
1962	4	g	-85	-85	2437	7	AP-C-6F-04
1963	4	g	-65.97	-66	5180	100	AP-C-3F-03
1964	4	g	-91.33333333	-90	5180	21	AP-C-3F-04
1965	4	g	-69.19	-70	5180	100	AP-C-4F-02
1966	4	g	-51.14	-51	5180	100	AP-C-4F-03
1967	4	g	-73.1827957	-73	5180	93	AP-C-4F-04
1968	4	g	-90.83333333	-90.5	5180	42	AP-C-5F-02
1969	4	g	-82.01960784	-81	5180	51	AP-C-5F-03
1970	4	g	-87.33333333	-87	5180	63	AP-C-5F-04
1971	4	h	-86	-86	2437	7	AP-C-1F-01
1972	4	h	-82	-82	2437	7	AP-C-2F-01
1973	4	h	-81.08695652	-82	2437	23	AP-C-2F-02
1974	4	h	-66.92405063	-66	2437	79	AP-C-3F-03
1975	4	h	-65.70769231	-66	2437	65	AP-C-3F-04
1976	4	h	-67.97222222	-68	2437	72	AP-C-4F-02
1977	4	h	-44.86	-45	2437	100	AP-C-4F-03
1978	4	h	-61.74	-61	2437	100	AP-C-4F-04
1979	4	h	-75.2	-76	2437	35	AP-C-5F-02
1980	4	h	-61	-61	2437	35	AP-C-5F-03
1981	4	h	-65.26582278	-65	2437	79	AP-C-5F-04
1982	4	h	-81.53333333	-82	2437	30	AP-C-6F-04
1983	4	h	-79.5	-79.5	5180	42	AP-C-3F-03
1984	4	h	-82.90277778	-83	5180	72	AP-C-3F-04
1985	4	h	-73.26744186	-73	5180	86	AP-C-4F-02
1986	4	h	-60.03	-60	5180	100	AP-C-4F-03
1987	4	h	-67.59	-68	5180	100	AP-C-4F-04
1988	4	h	-84.63888889	-84	5180	72	AP-C-5F-03
1989	4	h	-88.06666667	-88	5180	30	AP-C-5F-04
1990	4	i	-83	-83	2437	7	AP-C-2F-01
1991	4	i	-72	-71	2437	49	AP-C-2F-02
1992	4	i	-64.08860759	-64	2437	79	AP-C-3F-03
1993	4	i	-60.47222222	-60	2437	72	AP-C-3F-04
1994	4	i	-69.7	-68	2437	70	AP-C-4F-02
1995	4	i	-56.95	-56	2437	100	AP-C-4F-03
1996	4	i	-52.11	-51	2437	100	AP-C-4F-04
1997	4	i	-79.66666667	-80	2437	21	AP-C-5F-02
1998	4	i	-69.96078431	-70	2437	51	AP-C-5F-03
1999	4	i	-61.63636364	-61	2437	77	AP-C-5F-04
2000	4	i	-84	-84	2437	7	AP-C-6F-04
2001	4	i	-78	-78	5180	14	AP-C-3F-03
2002	4	i	-81.90909091	-82	5180	77	AP-C-3F-04
2003	4	i	-73.39784946	-73	5180	93	AP-C-4F-02
2004	4	i	-61.86	-62	5180	100	AP-C-4F-03
2005	4	i	-67.31	-67	5180	100	AP-C-4F-04
2006	4	i	-89	-89	5180	14	AP-C-5F-03
2007	4	i	-81.72413793	-81	5180	58	AP-C-5F-04
2008	4	j	-69.02777778	-69	2437	72	AP-C-2F-02
2009	4	j	-85.25	-85	2437	28	AP-C-3F-02
2010	4	j	-75	-75	2437	42	AP-C-3F-03
2011	4	j	-63.58227848	-64	2437	79	AP-C-3F-04
2012	4	j	-68.875	-69	2437	56	AP-C-4F-02
2013	4	j	-62.38461538	-63	2437	91	AP-C-4F-03
2014	4	j	-48.65	-48	2437	100	AP-C-4F-04
2015	4	j	-83	-83	2437	14	AP-C-5F-02
2016	4	j	-78	-78	2437	14	AP-C-5F-03
2017	4	j	-61.62	-61	2437	100	AP-C-5F-04
2018	4	j	-89.85714286	-90	5180	49	AP-C-2F-02
2019	4	j	-89.75	-89.5	5180	56	AP-C-3F-03
2020	4	j	-84.35384615	-84	5180	65	AP-C-3F-04
2021	4	j	-80.73417722	-81	5180	79	AP-C-4F-02
2022	4	j	-65.39	-65	5180	100	AP-C-4F-03
2023	4	j	-62.44	-62	5180	100	AP-C-4F-04
2024	4	j	-82.79310345	-84	5180	58	AP-C-5F-04
2025	4	k	-71.4516129	-71	2437	93	AP-C-2F-02
2026	4	k	-76.2745098	-77	2437	51	AP-C-3F-03
2027	4	k	-60.4516129	-60	2437	93	AP-C-3F-04
2028	4	k	-74.18918919	-73	2437	37	AP-C-4F-02
2029	4	k	-63.8372093	-63	2437	86	AP-C-4F-03
2030	4	k	-41.03225806	-40	2437	93	AP-C-4F-04
2031	4	k	-73.44444444	-73	2437	63	AP-C-5F-03
2032	4	k	-58.64	-59	2437	100	AP-C-5F-04
2033	4	k	-87.5	-87.5	2437	14	AP-C-6F-03
2034	4	k	-76.14285714	-76	2437	49	AP-C-6F-04
2035	4	k	-83.66666667	-84	2437	21	AP-C-4F-01
2036	4	k	-92.2	-93	5180	35	AP-C-2F-02
2037	4	k	-92	-92	5180	7	AP-C-3F-03
2038	4	k	-76.07	-76	5180	100	AP-C-3F-04
2039	4	k	-79.19444444	-78	5180	72	AP-C-4F-02
2040	4	k	-73.87	-73	5180	100	AP-C-4F-03
2041	4	k	-60.07	-60	5180	100	AP-C-4F-04
2042	4	k	-83.23076923	-83	5180	65	AP-C-5F-04
2043	4	l	-70.04545455	-70	2437	44	AP-C-2F-02
2044	4	l	-85	-85	2437	2	AP-C-3F-02
2045	4	l	-76.8	-76	2437	35	AP-C-3F-03
2046	4	l	-60.95	-61	2437	100	AP-C-3F-04
2047	4	l	-70.07843137	-70	2437	51	AP-C-4F-02
2048	4	l	-74.03921569	-75	2437	51	AP-C-4F-03
2049	4	l	-43.14	-43	2437	100	AP-C-4F-04
2050	4	l	-78.5	-78.5	2437	14	AP-C-5F-03
2051	4	l	-62.69892473	-63	2437	93	AP-C-5F-04
2052	4	l	-79.68965517	-79	2437	58	AP-C-6F-04
2053	4	l	-80.5	-80.5	2437	14	AP-C-4F-01
2054	4	l	-72.46236559	-72	5180	93	AP-C-3F-04
2055	4	l	-85.46153846	-85	5180	91	AP-C-4F-02
2056	4	l	-72.54651163	-72	5180	86	AP-C-4F-03
2057	4	l	-50.37634409	-51	5180	93	AP-C-4F-04
2058	4	l	-76.11827957	-76	5180	93	AP-C-5F-04
2059	4	l	-92	-92	5180	14	AP-C-6F-04
2060	4	m	-73.28571429	-74	2437	49	AP-C-2F-02
2061	4	m	-84.5	-84.5	2437	14	AP-C-3F-03
2062	4	m	-63.5	-64	2437	70	AP-C-3F-04
2063	4	m	-69.29113924	-70	2437	79	AP-C-4F-02
2064	4	m	-76.1627907	-78	2437	86	AP-C-4F-03
2065	4	m	-40.79	-41	2437	100	AP-C-4F-04
2066	4	m	-83	-83	2437	14	AP-C-5F-03
2067	4	m	-58.17	-58	2437	100	AP-C-5F-04
2068	4	m	-76.66666667	-76	2437	42	AP-C-6F-04
2069	4	m	-69.23943662	-69	2437	71	AP-C-4F-01
2070	4	m	-77.47311828	-77	5180	93	AP-C-3F-04
2071	4	m	-81.53846154	-82	5180	65	AP-C-4F-02
2072	4	m	-76.30769231	-77	5180	65	AP-C-4F-03
2073	4	m	-56.27	-56	5180	100	AP-C-4F-04
2074	4	m	-79.33333333	-78	5180	63	AP-C-5F-04
2075	4	m	-93	-93	5180	7	AP-C2-4F-03
2076	4	n	-83	-83	2437	7	AP-C-2F-02
2077	4	n	-80.66666667	-80	2437	21	AP-C-3F-01
2078	4	n	-81.4	-81	2437	35	AP-C-3F-03
2079	4	n	-64.25352113	-63	2437	71	AP-C-3F-04
2080	4	n	-76.5625	-77	2437	16	AP-C-4F-02
2081	4	n	-78.02531646	-78	2437	79	AP-C-4F-03
2082	4	n	-46.91397849	-47	2437	93	AP-C-4F-04
2083	4	n	-82.5	-82.5	2437	14	AP-C-5F-01
2084	4	n	-66.87341772	-67	2437	79	AP-C-5F-04
2085	4	n	-77	-77	2437	1	AP-C-6F-04
2086	4	n	-66.85714286	-66	2437	49	AP-C-4F-01
2087	4	n	-78.88135593	-79	5180	59	AP-C-3F-04
2088	4	n	-79.46428571	-79.5	5180	28	AP-C-4F-03
2089	4	n	-60.07	-60	5180	100	AP-C-4F-04
2090	4	n	-84.05376344	-83	5180	93	AP-C-5F-04
2091	4	n	-91.66666667	-92	5180	21	AP-C-4F-01
2092	4	o	-86	-86	2437	7	AP-C-2F-02
2093	4	o	-80.44444444	-81	2437	63	AP-C-3F-01
2094	4	o	-73.52777778	-73	2437	72	AP-C-3F-04
2095	4	o	-75.44615385	-76	2437	65	AP-C-4F-02
2096	4	o	-77.5	-77	2437	70	AP-C-4F-03
2097	4	o	-66.29	-66	2437	100	AP-C-4F-04
2098	4	o	-77.7	-77.5	2437	70	AP-C-5F-01
2099	4	o	-69.26	-69	2437	100	AP-C-5F-04
2100	4	o	-87	-87	2437	14	AP-C2-4F-01
2101	4	o	-64.32	-65	2437	100	AP-C-4F-01
2102	4	o	-86.8	-86.5	5180	70	AP-C-3F-04
2103	4	o	-78.61111111	-78	5180	72	AP-C-4F-02
2104	4	o	-79.81818182	-79	5180	77	AP-C-4F-03
2105	4	o	-69.90322581	-70	5180	93	AP-C-4F-04
2106	4	o	-90	-91	5180	35	AP-C-5F-04
2107	4	o	-90.85714286	-91	5180	49	AP-C2-4F-01
2108	4	o	-90.71428571	-91	5180	49	AP-C2-4F-03
2109	4	o	-88.0862069	-88	5180	58	AP-C-4F-01
2110	4	p	-76.42857143	-76	2437	49	AP-C-3F-01
2111	4	p	-85	-85	2437	7	AP-C-3F-02
2112	4	p	-84	-84	2437	7	AP-C-3F-03
2113	4	p	-76.05172414	-76	2437	58	AP-C-3F-04
2114	4	p	-81.25	-83	2437	56	AP-C-4F-02
2115	4	p	-79.55555556	-81	2437	63	AP-C-4F-03
2116	4	p	-62.46	-62	2437	100	AP-C-4F-04
2117	4	p	-78.44444444	-78	2437	63	AP-C-5F-01
2118	4	p	-70.90909091	-71	2437	77	AP-C-5F-04
2119	4	p	-81.33333333	-81.5	2437	42	AP-C-6F-04
2120	4	p	-83.4375	-83	2437	16	AP-C2-3F-01
2121	4	p	-78	-78	2437	63	AP-C2-4F-01
2122	4	p	-84.35294118	-83	2437	51	AP-C2-4F-02
2123	4	p	-83.33333333	-83	2437	21	AP-C2-4F-03
2124	4	p	-66.24	-66	2437	100	AP-C-4F-01
2125	4	p	-88.21	-88	5180	100	AP-C-3F-04
2126	4	p	-82.05555556	-82	5180	72	AP-C-4F-02
2127	4	p	-82.33333333	-82	5180	63	AP-C-4F-03
2128	4	p	-70.89	-70	5180	100	AP-C-4F-04
2129	4	p	-88.89873418	-88	5180	79	AP-C-5F-04
2130	4	p	-85.72222222	-86	5180	18	AP-C2-4F-01
2131	4	q	-76.66666667	-78	2437	30	AP-C-3F-01
2132	4	q	-80	-80	2437	7	AP-C-3F-02
2133	4	q	-78.6	-79	2437	35	AP-C-3F-03
2134	4	q	-73.89230769	-74	2437	65	AP-C-3F-04
2135	4	q	-71.35443038	-71	2437	79	AP-C-4F-02
2136	4	q	-67.16666667	-67	2437	84	AP-C-4F-03
2137	4	q	-57.44	-57	2437	100	AP-C-4F-04
2138	4	q	-82	-82	2437	7	AP-C-5F-01
2139	4	q	-81	-81	2437	7	AP-C-5F-02
2140	4	q	-83.33333333	-84	2437	21	AP-C-5F-03
2141	4	q	-63.05	-62	2437	100	AP-C-5F-04
2142	4	q	-85.77777778	-86	2437	9	AP-C-6F-04
2143	4	q	-85	-85	2437	7	AP-C2-3F-01
2144	4	q	-73.41772152	-73	2437	79	AP-C2-4F-01
2145	4	q	-79.16666667	-79	2437	42	AP-C2-4F-02
2146	4	q	-78	-77	2437	21	AP-C2-4F-03
2147	4	q	-68	-68	2437	100	AP-C-4F-01
2148	4	q	-84.84482759	-84	5180	58	AP-C-3F-04
2149	4	q	-69.65116279	-69	5180	86	AP-C-4F-02
2150	4	q	-70.4516129	-70	5180	93	AP-C-4F-03
2151	4	q	-64.5	-63	5180	62	AP-C-4F-04
2152	4	r	-79.79310345	-80	2437	58	AP-C-3F-01
2153	4	r	-86.5	-87	2437	42	AP-C-3F-03
2154	4	r	-77.75862069	-78	2437	58	AP-C-3F-04
2155	4	r	-83.83333333	-83.5	2437	42	AP-C-4F-02
2156	4	r	-79.52307692	-81	2437	65	AP-C-4F-03
2157	4	r	-60.05	-60	2437	100	AP-C-4F-04
2158	4	r	-85.5625	-86	2437	16	AP-C-5F-01
2159	4	r	-85	-85	2437	7	AP-C-5F-03
2160	4	r	-71.07526882	-71	2437	93	AP-C-5F-04
2161	4	r	-82.125	-82.5	2437	56	AP-C2-3F-01
2162	4	r	-87	-87	2437	7	AP-C2-3F-02
2163	4	r	-75.15384615	-76	2437	65	AP-C2-4F-01
2164	4	r	-81.3	-81.5	2437	70	AP-C2-4F-02
2165	4	r	-79.86666667	-82	2437	30	AP-C2-4F-03
2166	4	r	-86	-86	2437	14	AP-C2-5F-01
2167	4	r	-70.92405063	-72	2437	79	AP-C-4F-01
2168	4	r	-89.66666667	-91	5180	21	AP-C-3F-04
2169	4	r	-76.81818182	-78	5180	77	AP-C-4F-02
2170	4	r	-84.81034483	-84	5180	58	AP-C-4F-03
2171	4	r	-63.89	-64	5180	100	AP-C-4F-04
2172	4	r	-85.13846154	-85	5180	65	AP-C-5F-04
2173	4	r	-89.17241379	-89	5180	58	AP-C2-3F-01
2174	4	r	-80.87931034	-81	5180	58	AP-C2-4F-01
2175	4	r	-77.29824561	-76	5180	57	AP-C2-4F-02
2176	4	s	-87.5	-87.5	2437	14	AP-C-3F-01
2177	4	s	-89	-89	2437	7	AP-C-3F-04
2178	4	s	-85.4375	-85	2437	16	AP-C-4F-03
2179	4	s	-83.66666667	-85	2437	21	AP-C-4F-04
2180	4	s	-85.8	-86	2437	35	AP-C-5F-01
2181	4	s	-81.66666667	-82	2437	21	AP-C-5F-04
2182	4	s	-84.86111111	-86	2437	72	AP-C2-3F-01
2183	4	s	-84	-84	2437	7	AP-C2-3F-02
2184	4	s	-70.32758621	-71	2437	58	AP-C2-4F-01
2185	4	s	-68.24731183	-68	2437	93	AP-C2-4F-02
2186	4	s	-79.04615385	-80	2437	65	AP-C2-4F-03
2187	4	s	-84.5	-86	2437	42	AP-C2-5F-01
2188	4	s	-81.13636364	-81	2437	44	AP-C2-5F-02
2189	4	s	-76.97222222	-77	2437	72	AP-C-4F-01
2190	4	s	-86.06666667	-87	5180	30	AP-C-4F-04
2191	4	s	-72.12121212	-71	5180	33	AP-C2-4F-01
2192	4	s	-82.7311828	-83	5180	93	AP-C2-4F-02
2193	4	s	-83.16129032	-84	5180	93	AP-C2-4F-03
2194	4	t	-83.4	-84	2437	35	AP-C-3F-01
2195	4	t	-80.2	-80	2437	35	AP-C-4F-04
2196	4	t	-73.19	-73	2437	100	AP-C2-3F-01
2197	4	t	-86	-86	2437	7	AP-C2-3F-03
2198	4	t	-66.41	-66	2437	100	AP-C2-4F-01
2199	4	t	-63.48	-64	2437	100	AP-C2-4F-02
2200	4	t	-70.41666667	-70.5	2437	84	AP-C2-4F-03
2201	4	t	-82.22222222	-82	2437	63	AP-C2-5F-01
2202	4	t	-82.21568627	-82	2437	51	AP-C2-5F-02
2203	4	t	-84.5	-84.5	2437	14	AP-C2-6F-01
2204	4	t	-79.33333333	-80	2437	21	AP-C-4F-01
2205	4	t	-90	-90	5180	7	AP-C-4F-04
2206	4	t	-90.10526316	-90	5180	38	AP-C2-3F-01
2207	4	t	-70.18181818	-70	5180	33	AP-C2-4F-01
2208	4	t	-79.33333333	-80	5180	72	AP-C2-4F-02
2209	4	t	-73.62365591	-73	5180	93	AP-C2-4F-03
2210	4	t	-87	-87	5180	7	AP-C-4F-01
2211	4	u	-85	-85	2437	14	AP-C-3F-01
2212	4	u	-83	-83	2437	30	AP-C-5F-01
2213	4	u	-83.35294118	-83	2437	51	AP-C2-2F-01
2214	4	u	-69.11827957	-69	2437	93	AP-C2-3F-01
2215	4	u	-64.79	-64	2437	100	AP-C2-4F-01
2216	4	u	-74.74	-76	2437	100	AP-C2-4F-02
2217	4	u	-75.47222222	-76	2437	72	AP-C2-4F-03
2218	4	u	-72.59139785	-72	2437	93	AP-C2-5F-01
2219	4	u	-78.6	-78	2437	35	AP-C2-5F-02
2220	4	u	-78.33333333	-78	2437	63	AP-C-4F-01
2221	4	u	-90.5	-90.5	5180	42	AP-C-4F-04
2222	4	u	-87.8	-87	5180	35	AP-C2-3F-01
2223	4	u	-74.56989247	-74	5180	93	AP-C2-4F-01
2224	4	u	-79.27848101	-79	5180	79	AP-C2-4F-02
2225	4	u	-74.7311828	-74	5180	93	AP-C2-4F-03
2226	4	u	-89.4	-90	5180	35	AP-C2-5F-01
2227	4	v	-80	-80	2437	35	AP-C2-2F-01
2228	4	v	-87	-87	2437	7	AP-C2-2F-02
2229	4	v	-66.70967742	-67	2437	93	AP-C2-3F-01
2230	4	v	-83.66666667	-83	2437	21	AP-C2-3F-02
2231	4	v	-69.57	-68	2437	100	AP-C2-4F-01
2232	4	v	-70.74193548	-70	2437	93	AP-C2-4F-02
2233	4	v	-77	-77	2437	14	AP-C2-4F-03
2234	4	v	-70.62962963	-71	2437	27	AP-C2-5F-01
2235	4	v	-75.2173913	-75	2437	23	AP-C2-5F-02
2236	4	v	-76.25714286	-77	2437	35	AP-C-4F-01
2237	4	v	-95	-95	5180	7	AP-C-4F-04
2238	4	v	-78	-78	5180	28	AP-C2-3F-01
2239	4	v	-74.47674419	-75	5180	86	AP-C2-4F-01
2240	4	v	-76.7311828	-77	5180	93	AP-C2-4F-02
2241	4	v	-76.75	-77	5180	28	AP-C2-4F-03
2242	4	v	-90.58823529	-91	5180	51	AP-C2-5F-01
2243	4	v	-90.75	-90.5	5180	28	AP-C2-5F-02
2244	4	v	-90.66666667	-90	5180	21	AP-C-4F-01
2245	4	w	-81	-81	2437	7	AP-C-3F-01
2246	4	w	-80	-80	2437	7	AP-C2-2F-01
2247	4	w	-57.46	-57	2437	100	AP-C2-3F-01
2248	4	w	-81	-81	2437	14	AP-C2-3F-02
2249	4	w	-63.52	-63	2437	100	AP-C2-4F-01
2250	4	w	-76.2688172	-76	2437	93	AP-C2-4F-02
2251	4	w	-79	-78	2437	21	AP-C2-4F-03
2252	4	w	-70.90909091	-70	2437	77	AP-C2-5F-01
2253	4	w	-79.5	-79.5	2437	14	AP-C2-5F-02
2254	4	w	-80	-80	2437	7	AP-C2-6F-01
2255	4	w	-70.56363636	-72	2437	55	AP-C-4F-01
2256	4	w	-76.27272727	-76	5180	11	AP-C2-3F-01
2257	4	w	-91	-91	5180	44	AP-C2-3F-02
2258	4	w	-66.42	-66	5180	100	AP-C2-4F-01
2259	4	w	-80.58461538	-80	5180	65	AP-C2-4F-02
2260	4	w	-75.13953488	-75	5180	86	AP-C2-4F-03
2261	4	w	-88	-88	5180	14	AP-C2-5F-01
2262	4	x	-87	-87	2437	7	AP-C-3F-01
2263	4	x	-74.71428571	-74	2437	49	AP-C2-2F-01
2264	4	x	-87	-87	2437	7	AP-C2-2F-02
2265	4	x	-58.86046512	-60	2437	86	AP-C2-3F-01
2266	4	x	-76.75	-76	2437	44	AP-C2-3F-02
2267	4	x	-55.84	-55	2437	100	AP-C2-4F-01
2268	4	x	-64.25	-65	2437	72	AP-C2-4F-02
2269	4	x	-68.11111111	-68	2437	72	AP-C2-4F-03
2270	4	x	-77.03797468	-77	2437	79	AP-C2-5F-01
2271	4	x	-77.56818182	-78	2437	44	AP-C2-5F-02
2272	4	x	-81.625	-81	2437	8	AP-C2-6F-01
2273	4	x	-76.33333333	-77.5	2437	42	AP-C-4F-01
2274	4	x	-92.2	-92	5180	35	AP-C2-2F-01
2275	4	x	-72.82	-73	5180	100	AP-C2-3F-01
2276	4	x	-90.5	-90.5	5180	14	AP-C2-3F-02
2277	4	x	-65.17	-65	5180	100	AP-C2-4F-01
2278	4	x	-72.58227848	-72	5180	79	AP-C2-4F-02
2279	4	x	-76.97297297	-77	5180	37	AP-C2-4F-03
2280	4	x	-85.56756757	-86	5180	37	AP-C2-5F-01
2281	4	x	-90.96078431	-91	5180	51	AP-C2-5F-02
2282	4	y	-74.0625	-74	2437	32	AP-C2-2F-01
2283	4	y	-59.6344086	-60	2437	93	AP-C2-3F-01
2284	4	y	-80.25	-80.5	2437	28	AP-C2-3F-02
2285	4	y	-88	-88	2437	5	AP-C2-3F-03
2286	4	y	-55.65	-56	2437	100	AP-C2-4F-01
2287	4	y	-63.48	-62	2437	100	AP-C2-4F-02
2288	4	y	-62.95454545	-62	2437	88	AP-C2-4F-03
2289	4	y	-67.33	-68	2437	100	AP-C2-5F-01
2290	4	y	-77.40740741	-77	2437	54	AP-C2-5F-02
2291	4	y	-71.34177215	-71	2437	79	AP-C2-6F-01
2292	4	y	-83.5	-83.5	2437	28	AP-C2-6F-02
2293	4	y	-76.08333333	-79	2437	12	AP-C-4F-01
2294	4	y	-90.56	-90	5180	25	AP-C2-2F-01
2295	4	y	-72.64516129	-73	5180	93	AP-C2-3F-01
2296	4	y	-92	-92	5180	14	AP-C2-3F-02
2297	4	y	-64.57	-65	5180	100	AP-C2-4F-01
2298	4	y	-72.83544304	-72	5180	79	AP-C2-4F-02
2299	4	y	-71.17	-71	5180	100	AP-C2-4F-03
2300	4	y	-88.66666667	-89	5180	42	AP-C2-5F-02
2301	4	y	-91	-91	5180	7	AP-C3-4F-02
2302	4	z	-67.88607595	-68	2437	79	AP-C2-2F-01
2303	4	z	-84	-84	2437	7	AP-C2-2F-02
2304	4	z	-50.11	-50	2437	100	AP-C2-3F-01
2305	4	z	-68.76923077	-68	2437	91	AP-C2-3F-02
2306	4	z	-79.5	-79.5	2437	14	AP-C2-3F-03
2307	4	z	-53.07	-53	2437	100	AP-C2-4F-01
2308	4	z	-63.05813953	-61	2437	86	AP-C2-4F-02
2309	4	z	-64.92307692	-64	2437	91	AP-C2-4F-03
2310	4	z	-59.47	-59	2437	100	AP-C2-5F-01
2311	4	z	-81.05882353	-81	2437	51	AP-C2-5F-02
2312	4	z	-83	-83	2437	7	AP-C2-5F-03
2313	4	z	-76.85714286	-78	2437	49	AP-C2-6F-01
2314	4	z	-85	-85	2437	7	AP-C2-6F-02
2315	4	z	-80.5	-80.5	2437	14	AP-C-4F-01
2316	4	z	-90.5	-90	5180	42	AP-C2-2F-01
2317	4	z	-69.4	-69	5180	100	AP-C2-3F-01
2318	4	z	-88.625	-88	5180	56	AP-C2-3F-02
2319	4	z	-67.09	-66	5180	100	AP-C2-4F-01
2320	4	z	-72.34177215	-72	5180	79	AP-C2-4F-02
2321	4	z	-72.35	-72	5180	100	AP-C2-4F-03
2322	4	z	-84.5	-84.5	5180	14	AP-C2-5F-01
2323	4	z	-92	-92	5180	14	AP-C2-5F-02
2324	4	z	-90.3	-91	5180	30	AP-C3-4F-01
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Name: ap_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.ap_id_seq', 124, true);


--
-- Name: ics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.ics_id_seq', 1, false);


--
-- Name: location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.location_id_seq', 118, true);


--
-- Name: measured_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.measured_id_seq', 2324, true);


--
-- Name: ap_table ap_pkc; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.ap_table
    ADD CONSTRAINT ap_pkc PRIMARY KEY (id);


--
-- Name: ics_table ics_pkc; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.ics_table
    ADD CONSTRAINT ics_pkc PRIMARY KEY (location_floor, location, ap_name, center_freq_mhz);


--
-- Name: location_table location_pkc; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.location_table
    ADD CONSTRAINT location_pkc PRIMARY KEY (id);


--
-- Name: measured_table measured_pkc; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.measured_table
    ADD CONSTRAINT measured_pkc PRIMARY KEY (id);


--
-- Name: TABLE ap_table; Type: ACL; Schema: public; Owner: docker
--

GRANT SELECT ON TABLE public.ap_table TO replicator;


--
-- Name: TABLE ics_table; Type: ACL; Schema: public; Owner: docker
--

GRANT SELECT ON TABLE public.ics_table TO replicator;


--
-- Name: TABLE location_table; Type: ACL; Schema: public; Owner: docker
--

GRANT SELECT ON TABLE public.location_table TO replicator;


--
-- Name: TABLE measured_table; Type: ACL; Schema: public; Owner: docker
--

GRANT SELECT ON TABLE public.measured_table TO replicator;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: docker
--

ALTER DEFAULT PRIVILEGES FOR ROLE docker IN SCHEMA public REVOKE ALL ON TABLES  FROM docker;
ALTER DEFAULT PRIVILEGES FOR ROLE docker IN SCHEMA public GRANT SELECT ON TABLES  TO replicator;


--
-- PostgreSQL database dump complete
--

