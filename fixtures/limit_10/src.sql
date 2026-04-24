--
-- PostgreSQL database dump
--

-- Dumped from database version 17.9 (Debian 17.9-1.pgdg13+1)
-- Dumped by pg_dump version 17.9 (Debian 17.9-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: disclosure; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA disclosure;


--
-- Name: btree_gin; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;


--
-- Name: EXTENSION btree_gin; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


CREATE SCHEMA IF NOT EXISTS disclosure;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: fec_fitem_sched_a; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a (
    cmte_id character varying(9),
    cmte_nm character varying(200),
    contbr_id character varying(9),
    contbr_nm character varying(200),
    contbr_nm_first character varying(38),
    contbr_m_nm character varying(20),
    contbr_nm_last character varying(38),
    contbr_prefix character varying(10),
    contbr_suffix character varying(10),
    contbr_st1 character varying(34),
    contbr_st2 character varying(34),
    contbr_city character varying(30),
    contbr_st character varying(2),
    contbr_zip character varying(9),
    entity_tp character varying(3),
    entity_tp_desc character varying(50),
    contbr_employer character varying(38),
    contbr_occupation character varying(38),
    election_tp character varying(5),
    fec_election_tp_desc character varying(20),
    fec_election_yr character varying(4),
    election_tp_desc character varying(20),
    contb_aggregate_ytd numeric(14,2),
    contb_receipt_dt timestamp without time zone,
    contb_receipt_amt numeric(14,2),
    receipt_tp character varying(3),
    receipt_tp_desc character varying(90),
    receipt_desc character varying(100),
    memo_cd character varying(1),
    memo_cd_desc character varying(50),
    memo_text character varying(100),
    cand_id character varying(9),
    cand_nm character varying(90),
    cand_nm_first character varying(38),
    cand_m_nm character varying(20),
    cand_nm_last character varying(38),
    cand_prefix character varying(10),
    cand_suffix character varying(10),
    cand_office character varying(1),
    cand_office_desc character varying(20),
    cand_office_st character varying(2),
    cand_office_st_desc character varying(20),
    cand_office_district character varying(2),
    conduit_cmte_id character varying(9),
    conduit_cmte_nm character varying(200),
    conduit_cmte_st1 character varying(34),
    conduit_cmte_st2 character varying(34),
    conduit_cmte_city character varying(30),
    conduit_cmte_st character varying(2),
    conduit_cmte_zip character varying(9),
    donor_cmte_nm character varying(200),
    national_cmte_nonfed_acct character varying(9),
    increased_limit character varying(1),
    action_cd character varying(1),
    action_cd_desc character varying(15),
    tran_id character varying(32),
    back_ref_tran_id character varying(32),
    back_ref_sched_nm character varying(8),
    schedule_type character varying(8),
    schedule_type_desc character varying(90),
    line_num character varying(12),
    image_num character varying(18),
    file_num numeric(7,0),
    link_id numeric(19,0),
    orig_sub_id numeric(19,0),
    sub_id numeric(19,0) NOT NULL,
    filing_form character varying(8) NOT NULL,
    rpt_tp character varying(3),
    rpt_yr numeric(4,0),
    two_year_transaction_period numeric(4,0),
    pdf_url text,
    contributor_name_text tsvector,
    contributor_employer_text tsvector,
    contributor_occupation_text tsvector,
    is_individual boolean,
    clean_contbr_id character varying(9),
    pg_date timestamp without time zone DEFAULT now(),
    line_number_label text,
    cmte_tp character varying(1),
    org_tp character varying(1),
    cmte_dsgn character varying(1)
);


--
-- Name: fec_fitem_sched_a_1975_1976; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_1975_1976 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(1975)::numeric, (1976)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_1977_1978; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_1977_1978 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(1977)::numeric, (1978)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_1979_1980; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_1979_1980 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(1979)::numeric, (1980)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_1981_1982; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_1981_1982 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(1981)::numeric, (1982)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_1983_1984; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_1983_1984 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(1983)::numeric, (1984)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_1985_1986; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_1985_1986 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(1985)::numeric, (1986)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_1987_1988; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_1987_1988 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(1987)::numeric, (1988)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_1989_1990; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_1989_1990 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(1989)::numeric, (1990)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_1991_1992; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_1991_1992 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(1991)::numeric, (1992)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_1993_1994; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_1993_1994 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(1993)::numeric, (1994)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_1995_1996; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_1995_1996 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(1995)::numeric, (1996)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_1997_1998; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_1997_1998 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(1997)::numeric, (1998)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_1999_2000; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_1999_2000 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(1999)::numeric, (2000)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_2001_2002; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_2001_2002 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(2001)::numeric, (2002)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_2003_2004; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_2003_2004 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(2003)::numeric, (2004)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_2005_2006; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_2005_2006 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(2005)::numeric, (2006)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_2007_2008; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_2007_2008 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(2007)::numeric, (2008)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_2009_2010; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_2009_2010 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(2009)::numeric, (2010)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_2011_2012; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_2011_2012 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(2011)::numeric, (2012)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_2013_2014; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_2013_2014 (
    CONSTRAINT check_election_cycle CHECK ((two_year_transaction_period = ANY (ARRAY[(2013)::numeric, (2014)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_2015_2016; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_2015_2016 (
    CONSTRAINT check_two_year_transaction_period CHECK ((two_year_transaction_period = ANY (ARRAY[(2015)::numeric, (2016)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_2017_2018; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_2017_2018 (
    CONSTRAINT check_two_year_transaction_period CHECK ((two_year_transaction_period = ANY (ARRAY[(2017)::numeric, (2018)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_2019_2020; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_2019_2020 (
    CONSTRAINT check_two_year_transaction_period CHECK ((two_year_transaction_period = ANY (ARRAY[(2019)::numeric, (2020)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_2021_2022; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_2021_2022 (
    CONSTRAINT check_two_year_transaction_period CHECK ((two_year_transaction_period = ANY (ARRAY[(2021)::numeric, (2022)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_2023_2024; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_2023_2024 (
    CONSTRAINT check_two_year_transaction_period CHECK ((two_year_transaction_period = ANY (ARRAY[(2023)::numeric, (2024)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_2025_2026; Type: TABLE; Schema: disclosure; Owner: -
--

CREATE TABLE disclosure.fec_fitem_sched_a_2025_2026 (
    CONSTRAINT check_two_year_transaction_period CHECK ((two_year_transaction_period = ANY (ARRAY[(2025)::numeric, (2026)::numeric])))
)
INHERITS (disclosure.fec_fitem_sched_a);


--
-- Name: fec_fitem_sched_a_1975_1976 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1975_1976 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_1977_1978 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1977_1978 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_1979_1980 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1979_1980 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_1981_1982 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1981_1982 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_1983_1984 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1983_1984 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_1985_1986 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1985_1986 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_1987_1988 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1987_1988 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_1989_1990 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1989_1990 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_1991_1992 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1991_1992 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_1993_1994 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1993_1994 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_1995_1996 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1995_1996 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_1997_1998 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1997_1998 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_1999_2000 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1999_2000 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_2001_2002 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2001_2002 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_2003_2004 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2003_2004 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_2005_2006 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2005_2006 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_2007_2008 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2007_2008 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_2009_2010 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2009_2010 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_2011_2012 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2011_2012 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_2013_2014 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2013_2014 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_2015_2016 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2015_2016 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_2017_2018 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2017_2018 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_2019_2020 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2019_2020 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_2021_2022 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2021_2022 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_2023_2024 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2023_2024 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Name: fec_fitem_sched_a_2025_2026 pg_date; Type: DEFAULT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2025_2026 ALTER COLUMN pg_date SET DEFAULT now();


--
-- Data for Name: fec_fitem_sched_a; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
\.


--
-- Data for Name: fec_fitem_sched_a_1975_1976; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_1975_1976 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00018655	VICTORY '78 COMMITTEE (AKA VICTORY '76 COMMITTEE)	\N	VAN NAMEE, JOANNE J.	 JOANNE J.	\N	VAN NAMEE	\N	\N	\N	\N	ARLINGTON	VA	22202	\N	\N	HOUSE WIFE	\N	\N	\N	\N	\N	\N	1975-12-01 00:00:00	200.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77011231581	\N	3032920021022191372	\N	3061920110000003820	F3	YE	1975	1976	http://docquery.fec.gov/cgi-bin/fecimg/?77011231581	'j':4 'joanne':3 'namee':2 'van':1	'house':1 'wife':2	\N	t	\N	2017-06-07 19:33:11.820456	\N	H		P
C00018655	VICTORY '78 COMMITTEE (AKA VICTORY '76 COMMITTEE)	\N	LOISELLE, LEO M.	LEO M.	\N	LOISELLE	\N	\N	\N	\N	EAST HOLDEN	ME	04429	\N	\N	CPA	\N	\N	\N	\N	\N	\N	1975-11-25 00:00:00	200.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77011231581	\N	3032920021022191372	\N	3061920110000003821	F3	YE	1975	1976	http://docquery.fec.gov/cgi-bin/fecimg/?77011231581	'leo':2 'loiselle':1 'm':3	'cpa':1	\N	t	\N	2017-06-07 19:33:11.820456	\N	H		P
C00018655	VICTORY '78 COMMITTEE (AKA VICTORY '76 COMMITTEE)	\N	SARGENT, JAMES G.	JAMES G.	\N	SARGENT	\N	\N	\N	\N	STILLWATER	ME	04489	\N	\N	H.E. SARGENT CO.	\N	\N	\N	\N	\N	\N	1975-12-18 00:00:00	200.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77011231581	\N	3032920021022191372	\N	3061920110000003824	F3	YE	1975	1976	http://docquery.fec.gov/cgi-bin/fecimg/?77011231581	'g':3 'james':2 'sargent':1	'co':4 'e':2 'h':1 'sargent':3	\N	t	\N	2017-06-07 19:33:11.820456	\N	H		P
C00018655	VICTORY '78 COMMITTEE (AKA VICTORY '76 COMMITTEE)	\N	SARGENT, HERBERT E.	HERBERT E.	\N	SARGENT	\N	\N	\N	\N	STILLWATER	ME	04489	\N	\N	H. E. SARGENT CO.	\N	\N	\N	\N	\N	\N	1975-12-18 00:00:00	200.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	78011231581	\N	3032920021022191372	\N	3061920110000003825	F3	YE	1975	1976	http://docquery.fec.gov/cgi-bin/fecimg/?78011231581	'e':3 'herbert':2 'sargent':1	'co':4 'e':2 'h':1 'sargent':3	\N	t	\N	2017-06-07 19:33:11.820456	\N	H		P
C00018655	VICTORY '78 COMMITTEE (AKA VICTORY '76 COMMITTEE)	\N	PUTNAM, ROGER A.	ROGER A.	\N	PUTNAM	\N	\N	\N	\N	PORTLAND	ME	04112	\N	\N	ATTORNEY	\N	\N	\N	\N	\N	\N	1975-12-29 00:00:00	200.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77011231581	\N	3032920021022191372	\N	3061920110000003826	F3	YE	1975	1976	http://docquery.fec.gov/cgi-bin/fecimg/?77011231581	'a':3 'putnam':1 'roger':2	'attorney':1	\N	t	\N	2017-06-07 19:33:11.820456	\N	H		P
C00018655	VICTORY '78 COMMITTEE (AKA VICTORY '76 COMMITTEE)	\N	POOLER, CHARLES J.	CHARLES J.	\N	POOLER	\N	\N	\N	\N	BREWER	ME	04411	\N	\N	VILLAGE GREEN MOTEL	\N	\N	\N	\N	\N	\N	1975-12-30 00:00:00	200.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77011231582	\N	3032920021022191372	\N	3061920110000003827	F3	YE	1975	1976	http://docquery.fec.gov/cgi-bin/fecimg/?77011231582	'charles':2 'j':3 'pooler':1	'green':2 'motel':3 'village':1	\N	t	\N	2017-06-07 19:33:11.820456	\N	H		P
C00018655	VICTORY '78 COMMITTEE (AKA VICTORY '76 COMMITTEE)	\N	KOLDYKE, MARTIN J. M/M	MARTIN J. M/M	\N	KOLDYKE	\N	\N	\N	\N	KENILWORTH	IL	00000	\N	\N	FRONTENAC CO.	\N	\N	\N	\N	\N	\N	1975-11-14 00:00:00	200.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77011231584	\N	3032920021022191372	\N	3061920110000003830	F3	YE	1975	1976	http://docquery.fec.gov/cgi-bin/fecimg/?77011231584	'j':3 'koldyke':1 'm':4,5 'martin':2	'co':2 'frontenac':1	\N	t	\N	2017-06-07 19:33:11.820456	\N	H		P
C00018655	VICTORY '78 COMMITTEE (AKA VICTORY '76 COMMITTEE)	\N	BARTLETT, WILLIAM N.	WILLIAM N.	\N	BARTLETT	\N	\N	\N	\N	WICHITA	KS	67201	\N	\N	RETIRED	\N	\N	\N	\N	\N	\N	1975-11-07 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77011231581	\N	3032920021022191372	\N	3061920110000003822	F3	YE	1975	1976	http://docquery.fec.gov/cgi-bin/fecimg/?77011231581	'bartlett':1 'n':3 'william':2	'retired':1	\N	t	\N	2017-06-07 19:33:11.820456	\N	H		P
C00018655	VICTORY '78 COMMITTEE (AKA VICTORY '76 COMMITTEE)	\N	FREEMAN, GAYLORD	GAYLORD	\N	FREEMAN	\N	\N	\N	\N	CHICAGO	IL	00000	\N	\N	THE FIRST NATL BK OF CHICAGO	\N	\N	\N	\N	\N	\N	1975-11-14 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77011231584	\N	3032920021022191372	\N	3061920110000003829	F3	YE	1975	1976	http://docquery.fec.gov/cgi-bin/fecimg/?77011231584	'freeman':1 'gaylord':2	'bk':4 'chicago':6 'first':2 'natl':3 'of':5 'the':1	\N	t	\N	2017-06-07 19:33:11.820456	\N	H		P
C00018655	VICTORY '78 COMMITTEE (AKA VICTORY '76 COMMITTEE)	\N	DRICK, JOHN E.	JOHN E.	\N	DRICK	\N	\N	\N	\N	WILMETTE	IL	00000	\N	\N	RETIRED	\N	\N	\N	\N	\N	\N	1975-11-14 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77011231584	\N	3032920021022191372	\N	3061920110000003834	F3	YE	1975	1976	http://docquery.fec.gov/cgi-bin/fecimg/?77011231584	'drick':1 'e':3 'john':2	'retired':1	\N	t	\N	2017-06-07 19:33:11.820456	\N	H		P
\.


--
-- Data for Name: fec_fitem_sched_a_1977_1978; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_1977_1978 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C30002562	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0.00	\N	\N	\N	\N	\N	\N	\N	\N	1140597	201610170300107758	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	F92	\N	\N	3050320110005778130	\N	2013020171369072314	F3	30P	1978	1978	\N		\N	\N	f	\N	2017-06-07 19:43:18.888355	\N	\N	\N	\N
C30001978	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0.00	\N	\N	\N	\N	\N	\N	\N	\N	1294358	201811280300248307	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	F92	\N	\N	3050320110005778130	\N	2120420181620447063	F3	30P	1978	1978	\N		\N	\N	f	\N	2018-12-05 03:41:02.943	\N	\N	\N	\N
C30001978	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0.00	\N	\N	\N	\N	\N	\N	\N	\N	1294359	201811280300248314	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	F92	\N	\N	3050320110005778130	\N	2120420181620447064	F3	30P	1978	1978	\N		\N	\N	f	\N	2018-12-05 03:41:02.943	\N	\N	\N	\N
C30001978	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0.00	\N	\N	\N	\N	\N	\N	\N	\N	1294360	201811280300248321	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	F92	\N	\N	3050320110005778130	\N	2120420181620447065	F3	30P	1978	1978	\N		\N	\N	f	\N	2018-12-05 03:41:02.944	\N	\N	\N	\N
C00000828	FRIENDS OF ED JONES	C00039479	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1976-12-30 00:00:00	500.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	CONTRIBUTION RECVD FROM REG FILER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77011222756	\N	3032920021022090033	\N	3061920110000064145	F3	Q1	1977	1978	http://docquery.fec.gov/cgi-bin/fecimg/?77011222756	'c00039479':1	\N	\N	f	C00039479	2017-06-07 19:43:18.888355	\N	H		P
C00017368	RISENHOOVER FOR CONGRESS COMMITTEE	C00038612	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1976-01-17 00:00:00	125.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	CONTRIBUTION RECVD FROM REG FILER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77011212677	\N	3032920021022093153	\N	3061920110000018198	F3	Q1	1977	1978	http://docquery.fec.gov/cgi-bin/fecimg/?77011212677	'c00038612':1	\N	\N	f	C00038612	2017-06-07 19:43:18.888355	\N	H		P
C00017368	RISENHOOVER FOR CONGRESS COMMITTEE	\N	DAVIS, DON C.	DON C.	\N	DAVIS	\N	\N	\N	\N	LAWTON	OK	00000	\N	\N	SELF-EMPLOYED	\N	\N	\N	\N	\N	\N	1976-01-07 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77011212677	\N	3032920021022093153	\N	3061920110000021130	F3	Q1	1977	1978	http://docquery.fec.gov/cgi-bin/fecimg/?77011212677	'c':3 'davis':1 'don':2	'employed':2 'self':1	\N	t	\N	2017-06-07 19:43:18.888355	\N	H		P
C00019166	WATKINS FOR CONGRESS COMMITTEE	\N	HATHCOTE, DONALD E.	DONALD E.	\N	HATHCOTE	\N	\N	\N	\N	ADA	OK	74820	\N	\N	PROFESSIONAL HOMEBUILDERS, INC.	\N	\N	\N	\N	\N	\N	1975-03-17 00:00:00	130.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77011221160	\N	3032920021022093457	\N	3061920110000027153	F3	Q1	1977	1978	http://docquery.fec.gov/cgi-bin/fecimg/?77011221160	'donald':2 'e':3 'hathcote':1	'homebuilders':2 'inc':3 'professional':1	\N	t	\N	2017-06-07 19:43:18.888355	\N	H		P
C00044677	ORRIN G. HATCH COMMITTEE FOR THE SENATE	C00002881	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1976-12-14 00:00:00	1000.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	CONTRIBUTION RECVD FROM REG FILER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77020024227	\N	3032920021022096745	\N	3061920110000036173	F3	Q1	1977	1978	http://docquery.fec.gov/cgi-bin/fecimg/?77020024227	'c00002881':1	\N	\N	f	C00002881	2017-06-07 19:43:18.888355	\N	S		A
C00044677	ORRIN G. HATCH COMMITTEE FOR THE SENATE	C00000422	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1976-12-17 00:00:00	5000.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	CONTRIBUTION RECVD FROM REG FILER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	77020024227	\N	3032920021022096745	\N	3061920110000036174	F3	Q1	1977	1978	http://docquery.fec.gov/cgi-bin/fecimg/?77020024227	'c00000422':1	\N	\N	f	C00000422	2017-06-07 19:43:18.888355	\N	S		A
\.


--
-- Data for Name: fec_fitem_sched_a_1979_1980; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_1979_1980 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00115766	\N	\N	TENNEY, BOYD	BOYD	\N	TENNEY	\N	\N	\N	\N	PRESCOTT	AZ	86301	\N	\N	RANCHER	\N	\N	\N	\N	\N	\N	1978-10-09 00:00:00	400.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	79031412410	\N	3032920021022591397	\N	3061920110000505433	F3X	TER	1979	1980	http://docquery.fec.gov/cgi-bin/fecimg/?79031412410	'boyd':2 'tenney':1	'rancher':1	\N	t	\N	2017-06-07 19:53:49.321364	\N	\N	\N	\N
C00115766	\N	\N	ARIZ LIFE INS COS FO,	\N	\N	\N	\N	\N	\N	\N	PHOENIX	AZ	85004	\N	\N	\N	\N	\N	\N	\N	\N	\N	1978-10-25 00:00:00	100.00	18U	CONTRIBUTION RECEIVED FROM UNREGISTERED COMMI	CONTRIBUTION RECVD FROM UNREG.	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	79031412412	\N	3032920021022591397	\N	3061920110000505450	F3X	TER	1979	1980	http://docquery.fec.gov/cgi-bin/fecimg/?79031412412	'ariz':1 'cos':4 'fo':5 'ins':3 'life':2	\N	\N	f	\N	2017-06-07 19:53:49.321364	\N	\N	\N	\N
C00115766	\N	\N	AMIGOS POL ACTION CO,	\N	\N	\N	\N	\N	\N	\N	PHOENIX	AZ	85002	\N	\N	\N	\N	\N	\N	\N	\N	\N	1978-10-25 00:00:00	500.00	18U	CONTRIBUTION RECEIVED FROM UNREGISTERED COMMI	CONTRIBUTION RECVD FROM UNREG.	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	79031412412	\N	3032920021022591397	\N	3061920110000505451	F3X	TER	1979	1980	http://docquery.fec.gov/cgi-bin/fecimg/?79031412412	'action':3 'amigos':1 'co':4 'pol':2	\N	\N	f	\N	2017-06-07 19:53:49.321364	\N	\N	\N	\N
C00115766	\N	\N	REPUBLIC LEGIST CAMP,	\N	\N	\N	\N	\N	\N	\N	PHOENIX	AZ	85033	\N	\N	\N	\N	\N	\N	\N	\N	\N	1978-11-02 00:00:00	941.00	18U	CONTRIBUTION RECEIVED FROM UNREGISTERED COMMI	CONTRIBUTION RECVD FROM UNREG.	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	79031412412	\N	3032920021022591397	\N	3061920110000505446	F3X	TER	1979	1980	http://docquery.fec.gov/cgi-bin/fecimg/?79031412412	'camp':3 'legist':2 'republic':1	\N	\N	f	\N	2017-06-07 19:53:49.321364	\N	\N	\N	\N
C00010389	CITIZENS COMMITTEE FOR A. B. WON PAT	C00088591	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1980-11-05 00:00:00	100.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	CONTRIBUTION RECVD FROM REG FILER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	80011953956	\N	3032920021022193539	\N	3061920110000791990	F3	30G	1980	1980	http://docquery.fec.gov/cgi-bin/fecimg/?80011953956	'c00088591':1	\N	\N	f	C00088591	2017-06-07 19:53:49.321364	\N	H		P
C00015552	BEEF-PAC (BEEF POLITICAL ACTION COMMITTEE OF TEXAS CATTLE FEEDERS ASSOCIATION)	\N	HUNT, N B	N B	\N	HUNT	\N	\N	\N	\N	DALLAS	TX	75202	\N	\N	RANCHER-FEEDER	\N	\N	\N	\N	\N	\N	1979-12-20 00:00:00	200.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	80031440796	\N	3032920021022598093	\N	3061920110000552575	F3X	YE	1979	1980	http://docquery.fec.gov/cgi-bin/fecimg/?80031440796	'b':3 'hunt':1 'n':2	'feeder':2 'rancher':1	\N	t	\N	2017-06-07 19:53:49.321364	\N	Q	T	U
C00017087	NEAL FOR CONGRESS COMMITTEE	C00094870	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1978-10-07 00:00:00	12.00	15Z	IN-KIND CONTRIBUTION RECEIVED FROM REGISTERED	IN-KIND CONTR RECVD FROM REG. FILER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	79011682665	\N	3032920021022194525	\N	3061920110000549899	F3	Q3	1979	1980	http://docquery.fec.gov/cgi-bin/fecimg/?79011682665	'c00094870':1	\N	\N	f	C00094870	2017-06-07 19:53:49.321364	\N	H		P
C00017087	NEAL FOR CONGRESS COMMITTEE	C00094870	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1978-10-02 00:00:00	26.00	15Z	IN-KIND CONTRIBUTION RECEIVED FROM REGISTERED	IN-KIND CONTR RECVD FROM REG. FILER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	79011682665	\N	3032920021022194525	\N	3061920110000557254	F3	Q3	1979	1980	http://docquery.fec.gov/cgi-bin/fecimg/?79011682665	'c00094870':1	\N	\N	f	C00094870	2017-06-07 19:53:49.321364	\N	H		P
C00036665	KING FOR CONGRESS  [MO/06]	\N	MASSOP, WILLIAM F	WILLIAM F	\N	MASSOP	\N	\N	\N	\N	INDEPENDENCE	MO	64053	\N	\N	BANK PRESIDENT	\N	\N	\N	\N	\N	\N	1978-01-16 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	79011601858	\N	3032920021022196101	\N	3061920110000533646	F3	TER	1979	1980	http://docquery.fec.gov/cgi-bin/fecimg/?79011601858	'f':3 'massop':1 'william':2	'bank':1 'president':2	\N	t	\N	2017-06-07 19:53:49.321364	\N	H		A
C00037903	GEARHART FOR CONGRESS	C00042010	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1978-08-08 00:00:00	250.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	CONTRIBUTION RECVD FROM REG FILER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	78011491770	\N	3032920021022196298	\N	3061920110000370088	F3	Q1	1979	1980	http://docquery.fec.gov/cgi-bin/fecimg/?78011491770	'c00042010':1	\N	\N	f	C00042010	2017-06-07 19:53:49.321364	\N	H		A
\.


--
-- Data for Name: fec_fitem_sched_a_1981_1982; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_1981_1982 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00152058	FONDSE FOR CONGRESS COMMITTEE	\N	FLUETSCH, FOSTER	FOSTER	\N	FLUETSCH	\N	\N	\N	\N	STOCKTON	CA	95204	\N	\N	STATE SAVINGS & LOAN	\N	\N	\N	\N	\N	\N	1982-07-15 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	82012350781	\N	3032920021022080260	\N	3061920110000953208	F3	Q3	1982	1982	http://docquery.fec.gov/cgi-bin/fecimg/?82012350781	'fluetsch':1 'foster':2	'loan':3 'savings':2 'state':1	\N	t	\N	2017-06-07 20:04:29.145243	\N	H		P
C00139915	BILL NELSON CAMPAIGN COMMITTEE 1982	C00114108	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1980-12-22 00:00:00	500.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	CONTRIBUTION RECVD FROM REG FILER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	81012042208	\N	3032920021022074322	\N	3061920110000839227	F3	MY	1981	1982	http://docquery.fec.gov/cgi-bin/fecimg/?81012042208	'c00114108':1	\N	\N	f	C00114108	2017-06-07 20:04:29.145243	\N	H		P
C00153494	CHANDLER FOR CONGRESS	\N	TODD, MARY	MARY	\N	TODD	\N	\N	\N	\N	CLOVIS	NM	88101	\N	\N	HOUSEWIFE	\N	\N	\N	\N	\N	\N	1982-04-19 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	82012162202	\N	3032920021022080968	\N	3061920110000956130	F3	12P	1982	1982	http://docquery.fec.gov/cgi-bin/fecimg/?82012162202	'mary':2 'todd':1	'housewife':1	\N	t	\N	2017-06-07 20:04:29.145243	\N	H		P
C00153494	CHANDLER FOR CONGRESS	\N	WADE, CHARLES	CHARLES	\N	WADE	\N	\N	\N	\N	CLOVIS	NM	88101	\N	\N	SELF-EMPLOYED	\N	\N	\N	\N	\N	\N	1982-07-26 00:00:00	750.00	16G	LOAN FROM INDIVIDUAL	LOAN FROM INDIVIDUAL	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	82012301058	\N	3032920021022080972	\N	3061920110000956132	F3	Q3	1982	1982	http://docquery.fec.gov/cgi-bin/fecimg/?82012301058	'charles':2 'wade':1	'employed':2 'self':1	\N	f	\N	2017-06-07 20:04:29.145243	\N	H		P
C00153494	CHANDLER FOR CONGRESS	\N	BEAN, RICHARD	RICHARD	\N	BEAN	\N	\N	\N	\N	ROSWELL	NM	88201	\N	\N	SELF-EMPLOYED	\N	\N	\N	\N	\N	\N	1982-09-27 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	82012301058	\N	3032920021022080972	\N	3061920110000956133	F3	Q3	1982	1982	http://docquery.fec.gov/cgi-bin/fecimg/?82012301058	'bean':1 'richard':2	'employed':2 'self':1	\N	t	\N	2017-06-07 20:04:29.145243	\N	H		P
C00129007	REAGAN FOR PRESIDENT GENERAL ELECTION COMMITTEE 1980 (AKA REAGAN BUSH COMMITTEE)	C00136911	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1980-10-20 00:00:00	10000.00	18G	TRANSFER IN AFFILIATED	TRANSFER IN AFFILIATED	\N	\N	\N	*********	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	81031764605	\N	3032920021022241807	\N	3061920110000852348	F3P	Q1	1981	1982	http://docquery.fec.gov/cgi-bin/fecimg/?81031764605	'c00136911':1	\N	\N	f	C00136911	2017-06-07 20:04:29.145243	\N	P		P
C00149286	SUPPORTERS OF STEVE DART	\N	WHITE, GILBERT	GILBERT	\N	WHITE	\N	\N	\N	\N	E LANSING	MI	48823	\N	\N	STUDENT	\N	\N	\N	\N	\N	\N	1982-02-15 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	82012144439	\N	3032920021022078667	\N	3061920110000964121	F3	Q1	1982	1982	http://docquery.fec.gov/cgi-bin/fecimg/?82012144439	'gilbert':2 'white':1	'student':1	\N	t	\N	2017-06-07 20:04:29.145243	\N	H		P
C00149286	SUPPORTERS OF STEVE DART	H2MI06018	DART, STEPHEN H	STEPHEN H	\N	DART	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1982-02-01 00:00:00	200.00	15C	CONTRIBUTION FROM CANDIDATE	CONTRIBUTION FROM CANDIDATE	\N	\N	\N	H2MI06018	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	82012144441	\N	3032920021022078667	\N	3061920110000964118	F3	Q1	1982	1982	http://docquery.fec.gov/cgi-bin/fecimg/?82012144441	'dart':1 'h':3 'h2mi06018':4 'stephen':2	\N	\N	f	H2MI06018	2017-06-07 20:04:29.145243	\N	H		P
C00063743	CLAUDE PEPPER CAMPAIGN COMMITTEE	C00002881	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1980-02-06 00:00:00	500.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	CONTRIBUTION RECVD FROM REG FILER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	81012004940	\N	3032920021022068195	\N	3061920110000837252	F3	Q1	1981	1982	http://docquery.fec.gov/cgi-bin/fecimg/?81012004940	'c00002881':1	\N	\N	f	C00002881	2017-06-07 20:04:29.145243	\N	H		P
C00063743	CLAUDE PEPPER CAMPAIGN COMMITTEE	C00027144	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1980-03-24 00:00:00	200.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	CONTRIBUTION RECVD FROM REG FILER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	81012004940	\N	3032920021022068195	\N	3061920110000837257	F3	Q1	1981	1982	http://docquery.fec.gov/cgi-bin/fecimg/?81012004940	'c00027144':1	\N	\N	f	C00027144	2017-06-07 20:04:29.145243	\N	H		P
\.


--
-- Data for Name: fec_fitem_sched_a_1983_1984; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_1983_1984 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00167080	KYLE FOR PRESIDENT '84	\N	KYLE, EDITH LUPVEAL	EDITH LUPVEAL	\N	KYLE	\N	\N	\N	\N	CHINO	CA	91710	\N	\N	\N	\N	\N	\N	\N	\N	\N	1981-01-21 00:00:00	5000.00	16G	LOAN FROM INDIVIDUAL	LOAN FROM INDIVIDUAL	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	83032163809	\N	3032920021022242367	\N	3061920110001136843	F3P	Q3	1983	1984	http://docquery.fec.gov/cgi-bin/fecimg/?83032163809	'edith':2 'kyle':1 'lupveal':3	\N	\N	f	\N	2017-06-07 20:14:50.792288	\N	P		P
C00167726	SCHLUSSEL, LIFTON, SIMON, RANDS, KAUFMAN, GALVIN & JACKIER, POLITICAL COMMITTEE	\N	LIFTON, DONALD B	DONALD B	\N	LIFTON	\N	\N	\N	\N	HUNTINGTON WOODS	MI	48070	\N	\N	SCHLUSSEL, LIFTON, ET AL	\N	\N	\N	\N	\N	\N	1981-05-12 00:00:00	975.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	84032991761	\N	3032920021022506840	\N	3061920110001128731	F3X	YE	1983	1984	http://docquery.fec.gov/cgi-bin/fecimg/?84032991761	'b':3 'donald':2 'lifton':1	'al':4 'et':3 'lifton':2 'schlussel':1	\N	t	\N	2017-06-07 20:14:50.792288	\N	N		U
C00085373	K MART CORPORATION NON PARTISAN POLITICAL SUPPORT COMMITTEE	\N	DEWAR, ROBERT E	ROBERT E	\N	DEWAR	\N	\N	\N	\N	BLOOMFIELD HILLS	MI	48013	\N	\N	K MART CORPORATION	\N	\N	\N	\N	\N	\N	1983-07-25 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	84032915471	\N	3032920021022482679	\N	3061920110001063969	F3X	YE	1983	1984	http://docquery.fec.gov/cgi-bin/fecimg/?84032915471	'dewar':1 'e':3 'robert':2	'corporation':3 'k':1 'mart':2	\N	t	\N	2017-06-07 20:14:50.792288	\N	Q	C	U
C00086090	DAVID PRYOR FOR U.S. SENATE COMMITTEE	\N	CAMPBELL, ALLEN F	ALLEN F	\N	CAMPBELL	\N	\N	\N	\N	DALLAS	TX	75205	\N	\N	A F CAMPBELL & CO	\N	\N	\N	\N	\N	\N	1980-12-27 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	84020032897	\N	3032920021022136347	\N	3061920110001073331	F3	YE	1983	1984	http://docquery.fec.gov/cgi-bin/fecimg/?84020032897	'allen':2 'campbell':1 'f':3	'a':1 'campbell':3 'co':4 'f':2	\N	t	\N	2017-06-07 20:14:50.792288	\N	S		P
C00143123	GUS SAVAGE FOR CONGRESS '82	\N	PYE, KING	KING	\N	PYE	\N	\N	\N	\N	CHICAGO	IL	60617	\N	\N	COLLINS CERTIFIED	\N	\N	\N	\N	\N	\N	1981-10-31 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	84012554435	\N	3032920021022143015	\N	3061920110001082058	F3	TER	1983	1984	http://docquery.fec.gov/cgi-bin/fecimg/?84012554435	'king':2 'pye':1	'certified':2 'collins':1	\N	t	\N	2017-06-07 20:14:50.792288	\N	H		A
C00143123	GUS SAVAGE FOR CONGRESS '82	\N	BINGHAM, AL	AL	\N	BINGHAM	\N	\N	\N	\N	CHICAGO	IL	60628	\N	\N	BULKMATIC TRANSPORT CO	\N	\N	\N	\N	\N	\N	1981-10-23 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	84012554435	\N	3032920021022143015	\N	3061920110001082059	F3	TER	1983	1984	http://docquery.fec.gov/cgi-bin/fecimg/?84012554435	'al':2 'bingham':1	'bulkmatic':1 'co':3 'transport':2	\N	t	\N	2017-06-07 20:14:50.792288	\N	H		A
C00143651	HOME INTERIORS AND GIFTS POLITICAL ACTION COMMITTEE	\N	REICHERT, VIVIAN C	VIVIAN C	\N	REICHERT	\N	\N	\N	\N	COLLINSVILLE	IL	62234	\N	\N	HOME INTERIORS & GIFTS, INC	\N	\N	\N	\N	\N	\N	1984-03-06 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	84033141151	\N	3032920021022541017	\N	3061920110001179221	F3X	Q1	1984	1984	http://docquery.fec.gov/cgi-bin/fecimg/?84033141151	'c':3 'reichert':1 'vivian':2	'gifts':3 'home':1 'inc':4 'interiors':2	\N	t	\N	2017-06-07 20:14:50.792288	\N	N	C	U
C00186221	BOB QUINN FOR CONGRESS COMMITTEE	\N	FREEMAN, RONALD M	RONALD M	\N	FREEMAN	\N	\N	\N	\N	NEW YORK	NY	10028	\N	\N	SALOMON BROTHERS INC	\N	\N	\N	\N	\N	\N	1981-08-22 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	84012674275	\N	3032920021022139898	\N	3061920110001269676	F3	12P	1984	1984	http://docquery.fec.gov/cgi-bin/fecimg/?84012674275	'freeman':1 'm':3 'ronald':2	'brothers':2 'inc':3 'salomon':1	\N	t	\N	2017-06-07 20:14:50.792288	\N	H		P
C00110346	SOCIETY OF AMERICAN WOOD PRESERVERS INC WOOD PRESERVING POLITICAL ACTION COMMITTEE	\N	STORER, JACK	JACK	\N	STORER	\N	\N	\N	\N	MADISON	WI	53704	\N	\N	OSMOSE WOOD PRESERVING CO	\N	\N	\N	\N	\N	\N	1983-09-22 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	83032844433	\N	3032920021022479813	\N	3061920110001101632	F3X	Q3	1983	1984	http://docquery.fec.gov/cgi-bin/fecimg/?83032844433	'jack':2 'storer':1	'co':4 'osmose':1 'preserving':3 'wood':2	\N	t	\N	2017-06-07 20:14:50.792288	\N	Q	T	U
C00173914	MARC-PAC	\N	DRUMMON, E A	E A	\N	DRUMMON	\N	\N	\N	\N	JASPER	AL	35501	\N	\N	DRUMMOND COAL CO	\N	\N	\N	\N	\N	\N	1984-10-19 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	84033520019	\N	3032920021022531003	\N	3061920110001306041	F3X	30G	1984	1984	http://docquery.fec.gov/cgi-bin/fecimg/?84033520019	'a':3 'drummon':1 'e':2	'co':3 'coal':2 'drummond':1	\N	t	\N	2017-06-07 20:14:50.792288	\N	N	T	U
\.


--
-- Data for Name: fec_fitem_sched_a_1985_1986; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_1985_1986 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00194530	KEN KRAMER - 86	\N	FLANAGAN, URSULA R	URSULA R	\N	FLANAGAN	\N	\N	\N	\N	DENVER	CO	80210	\N	\N	MONTALDON MARINA SQUARE	\N	\N	\N	\N	\N	\N	1986-09-03 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	86020230087	\N	3032920021022214998	\N	3061920110001546285	F3	Q3	1986	1986	http://docquery.fec.gov/cgi-bin/fecimg/?86020230087	'flanagan':1 'r':3 'ursula':2	'marina':2 'montaldon':1 'square':3		t	\N	2020-01-10 03:37:11.093	\N	S	\N	P
C00000810	REPUBLICAN CONGRESSIONAL BOOSTERS CLUB	\N	DYETT, JOHN H MR	JOHN H MR	\N	DYETT	\N	\N	\N	\N	HOBE SOUND	FL	33455	\N	\N	\N	\N	\N	\N	\N	\N	\N	1986-03-31 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	86034101479	\N	3032920021022563554	\N	3061920110001522467	F3X	M4	1986	1986	http://docquery.fec.gov/cgi-bin/fecimg/?86034101479	'dyett':1 'h':3 'john':2 'mr':4	\N	\N	t	\N	2017-06-07 20:25:17.530952	\N	Q	M	U
C00000935	DEMOCRATIC CONGRESSIONAL CAMPAIGN COMMITTEE INC	C00156166	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1986-12-10 00:00:00	2500.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	CONTRIBUTION RECVD FROM REG FILER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	87013300687	\N	3032920021022611103	\N	3061920110001523439	F3X	YE	1986	1986	http://docquery.fec.gov/cgi-bin/fecimg/?87013300687	'c00156166':1	\N	\N	f	C00156166	2017-06-07 20:25:17.530952	\N	Y		U
C00000935	DEMOCRATIC CONGRESSIONAL CAMPAIGN COMMITTEE INC	C00017830	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1986-10-16 00:00:00	2492.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	CONTRIBUTION RECVD FROM REG FILER	\N	\N	\N	H6WI07033	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	86013244695	\N	3032920021022611460	\N	3061920110001522429	F3X	30G	1986	1986	http://docquery.fec.gov/cgi-bin/fecimg/?86013244695	'c00017830':1	\N	\N	f	C00017830	2017-06-07 20:25:17.530952	\N	Y		U
C00000935	DEMOCRATIC CONGRESSIONAL CAMPAIGN COMMITTEE INC	C00143438	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1986-10-29 00:00:00	604.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	CONTRIBUTION RECVD FROM REG FILER	\N	\N	\N	H0ND00036	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	86013244696	\N	3032920021022611460	\N	3061920110001522441	F3X	30G	1986	1986	http://docquery.fec.gov/cgi-bin/fecimg/?86013244696	'c00143438':1	\N	\N	f	C00143438	2017-06-07 20:25:17.530952	\N	Y		U
C00000984	UNITED STATES TELEPHONE ASS'N PAC (FORMERLY-UNITED STATESINDEPENDENT TELEPHONE ASS'N PAC	\N	BARNES, FRANK S	FRANK S	\N	BARNES	\N	\N	\N	\N	ROCK HILL	SC	29730	\N	\N	ROCK HILL TELEPHONE COMPANY	\N	\N	\N	\N	\N	\N	1986-08-28 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	86034315422	\N	3032920021022615200	\N	3061920110001526215	F3X	M9	1986	1986	http://docquery.fec.gov/cgi-bin/fecimg/?86034315422	'barnes':1 'frank':2 's':3	'company':4 'hill':2 'rock':1 'telephone':3	\N	t	\N	2017-06-07 20:25:17.530952	\N	Q	T	U
C00001016	CARPENTERS' LEGISLATIVE IMPROVEMENT COMMITTEE	\N	GIANGRANDE, ARTHUR	ARTHUR	\N	GIANGRANDE	\N	\N	\N	\N	BROOKLYN	NY	11223	\N	\N	N Y CITY DC	\N	\N	\N	\N	\N	\N	1986-01-09 00:00:00	541.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	86034030057	\N	3032920021022559502	\N	3061920110001526221	F3X	M2	1986	1986	http://docquery.fec.gov/cgi-bin/fecimg/?86034030057	'arthur':2 'giangrande':1	'city':3 'dc':4 'n':1 'y':2	\N	t	\N	2017-06-07 20:25:17.530952	\N	Q	L	U
C00186916	CALIFORNIA BERGLAND FOR PRESIDENT	C00170266	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1985-09-04 00:00:00	600.00	18G	TRANSFER IN AFFILIATED	TRANSFER IN AFFILIATED	\N	\N	\N	P40000846	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	85033340135	\N	3032920021022243920	\N	3061920110001352439	F3P	Q3	1985	1986	http://docquery.fec.gov/cgi-bin/fecimg/?85033340135	'c00170266':1	\N	\N	f	C00170266	2017-06-07 20:25:17.530952	\N	P		A
C00002931	NATIONAL REPUBLICAN CONGRESSIONAL COMMITTEE CONTRIBUTIONS	\N	CUBALESKI, VASA MR	VASA MR	\N	CUBALESKI	\N	\N	\N	\N	LOS ANGELES	CA	90027	\N	\N	\N	\N	\N	\N	\N	\N	\N	1986-09-22 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	86013160606	\N	3032920021022585386	\N	3061920110001516354	F3X	Q3	1986	1986	http://docquery.fec.gov/cgi-bin/fecimg/?86013160606	'cubaleski':1 'mr':3 'vasa':2	\N	\N	t	\N	2017-06-07 20:25:17.530952	\N	Y		U
C00002931	NATIONAL REPUBLICAN CONGRESSIONAL COMMITTEE CONTRIBUTIONS	\N	RUSSELL, FRED J MR	FRED J MR	\N	RUSSELL	\N	\N	\N	\N	LOS ANGELES	CA	90054	\N	\N	\N	\N	\N	\N	\N	\N	\N	1986-09-26 00:00:00	2500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	86013160609	\N	3032920021022585386	\N	3061920110001516358	F3X	Q3	1986	1986	http://docquery.fec.gov/cgi-bin/fecimg/?86013160609	'fred':2 'j':3 'mr':4 'russell':1	\N	\N	t	\N	2017-06-07 20:25:17.530952	\N	Y		U
\.


--
-- Data for Name: fec_fitem_sched_a_1987_1988; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_1987_1988 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00222620	FIRST DISTRICT DELEGATES FOR DOLE	\N	TERHES, JOYCE LYONS	JOYCE LYONS	\N	TERHES	\N	\N	\N	\N	PRINCE FREDERICK	MD	\N	\N	\N	PRINCE FREDERICK CTR	\N	\N	\N	\N	\N	\N	1988-02-15 00:00:00	700.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	88035143697	\N	3032920021022245249	\N	3061920110001996074	F3P	M3	1988	1988	http://docquery.fec.gov/cgi-bin/fecimg/?88035143697	'joyce':2 'lyons':3 'terhes':1	'ctr':3 'frederick':2 'prince':1	\N	t	\N	2017-06-07 20:35:43.763727	\N	D		U
C00222273	DOLE DELEGATE TEAM	\N	HERMANN, SYLVIA B	SYLVIA B	\N	HERMANN	\N	\N	\N	\N	BETHESDA	MD	20816	\N	\N	RETIRED	\N	\N	\N	\N	\N	\N	1988-01-20 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	88035064916	\N	3032920021022245157	\N	3061920110001956863	F3P	M2	1988	1988	http://docquery.fec.gov/cgi-bin/fecimg/?88035064916	'b':3 'hermann':1 'sylvia':2	'retired':1	\N	t	\N	2017-06-07 20:35:43.763727	\N	D		U
C00222273	DOLE DELEGATE TEAM	\N	GANNON, EDWARD J	EDWARD J	\N	GANNON	\N	\N	\N	\N	BETHESDA	MD	20816	\N	\N	SELF-EMPLOYED	\N	\N	\N	\N	\N	\N	1988-01-21 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	88035064916	\N	3032920021022245157	\N	3061920110001956862	F3P	M2	1988	1988	http://docquery.fec.gov/cgi-bin/fecimg/?88035064916	'edward':2 'gannon':1 'j':3	'employed':2 'self':1	\N	t	\N	2017-06-07 20:35:43.763727	\N	D		U
C00226308	9TH CONGRESSIONAL DOLE DELEGATE SLATE	\N	GIDWITZ, RONALD MR	RONALD MR	\N	GIDWITZ	\N	\N	\N	\N	CHICAGO	IL	60610	\N	\N	HELENE CURTIS INC	\N	\N	\N	\N	\N	\N	1988-04-14 00:00:00	532.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	88035272982	\N	3050320110005778161	\N	3061920110002022457	F3P	TER	1988	1988	http://docquery.fec.gov/cgi-bin/fecimg/?88035272982	'gidwitz':1 'mr':3 'ronald':2	'curtis':2 'helene':1 'inc':3	\N	t	\N	2017-06-07 20:35:43.763727	\N	D		U
C00000935	DEMOCRATIC CONGRESSIONAL CAMPAIGN COMMITTEE INC	\N	STEPHENS, J T MR	J T MR	\N	STEPHENS	\N	\N	\N	\N	LITTLE ROCK	AR	72201	\N	\N	STEPHENS INC	\N	\N	\N	\N	\N	\N	1987-03-20 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	87013330517	\N	3032920021022617100	\N	3061920110001597597	F3X	M4	1987	1988	http://docquery.fec.gov/cgi-bin/fecimg/?87013330517	'j':2 'mr':4 'stephens':1 't':3	'inc':2 'stephens':1		t	\N	2020-01-10 03:37:22.031	\N	Y	\N	U
C00000182	DEMOCRATIC CONGRESSIONAL DINNER COMMITTEE	\N	DICKEY, M JANE	M JANE	\N	DICKEY	\N	\N	\N	\N	LITTLE ROCK	AR	72207	\N	\N	ROSE LAW FIRM	\N	\N	\N	\N	\N	\N	1987-05-14 00:00:00	1500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	87034710476	\N	3032920021022625766	\N	3061920110001599617	F3X	M6	1987	1988	http://docquery.fec.gov/cgi-bin/fecimg/?87034710476	'dickey':1 'jane':3 'm':2	'firm':3 'law':2 'rose':1		t	\N	2020-01-10 03:37:22.032	\N	Y	\N	J
C00000182	DEMOCRATIC CONGRESSIONAL DINNER COMMITTEE	\N	FOSTER, VINCENT JR	VINCENT JR	\N	FOSTER	\N	\N	\N	\N	\N	\N	\N	\N	\N	ROSE LAW FIRM	\N	\N	\N	\N	\N	\N	1987-05-14 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	87034710476	\N	3032920021022625766	\N	3061920110001599619	F3X	M6	1987	1988	http://docquery.fec.gov/cgi-bin/fecimg/?87034710476	'foster':1 'jr':3 'vincent':2	'firm':3 'law':2 'rose':1		t	\N	2020-01-10 03:37:22.032	\N	Y	\N	J
C00205716	NATIONAL SECURITY POLITICAL ACTION COMMITTEE	\N	TAFT, RUTH C MRS	RUTH C MRS	\N	TAFT	\N	\N	\N	\N	ARCADIA	CA	91006	\N	\N	RETIRED	\N	\N	\N	\N	\N	\N	1985-02-16 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	88035151905	\N	3032920021022633354	\N	3061920110001997446	F3X	M3	1988	1988	http://docquery.fec.gov/cgi-bin/fecimg/?88035151905	'c':3 'mrs':4 'ruth':2 'taft':1	'retired':1	\N	t	\N	2017-06-07 20:35:43.763727	\N	Q	M	U
C00223248	BELLOTTI POLITICAL ACTION COMMITTEE	\N	KOVACS, HILDA	HILDA	\N	KOVACS	\N	\N	\N	\N	NEWTON	MA	02158	\N	\N	RETIRED	\N	\N	\N	\N	\N	\N	1985-10-04 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	88035193948	\N	3032920021022667690	\N	3061920110001973291	F3X	Q1	1988	1988	http://docquery.fec.gov/cgi-bin/fecimg/?88035193948	'hilda':2 'kovacs':1	'retired':1	\N	t	\N	2017-06-07 20:35:43.763727	\N	N	M	U
C00213017	BABBITT FOR PRESIDENT COMMITTEE	\N	CARLOS, SERGIO MR	SERGIO MR	\N	CARLOS	\N	\N	\N	\N	PHOENIX	AZ	85008	\N	\N	VALLEY NATIONAL BANK	\N	\N	\N	\N	\N	\N	1985-03-05 00:00:00	750.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	87034254940	\N	3032920021022246600	\N	3061920110001602660	F3P	Q1	1987	1988	http://docquery.fec.gov/cgi-bin/fecimg/?87034254940	'carlos':1 'mr':3 'sergio':2	'bank':3 'national':2 'valley':1	\N	t	\N	2017-06-07 20:35:43.763727	\N	P		P
\.


--
-- Data for Name: fec_fitem_sched_a_1989_1990; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_1989_1990 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00244335	CITIZENS FOR ELEANOR HOLMES NORTON	\N	FRIEDMAN, PAUL L	PAUL L	\N	FRIEDMAN	\N	\N	\N	\N	WASHINGTON	DC	20007	\N	\N	LO	\N	\N	\N	\N	\N	\N	1990-08-20 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	90014070384	\N	3032920021022023638	\N	3061920110002354064	F3	12P	1990	1990	http://docquery.fec.gov/cgi-bin/fecimg/?90014070384	'friedman':1 'l':3 'paul':2	'lo':1		t	\N	2020-01-10 03:37:32.594	\N	H	\N	P
C00139139	DEMOCRATS FOR THE 90'S	C00002766	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1987-09-12 00:00:00	2000.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	CONTRIBUTION RECVD FROM REG FILER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	90036233299	\N	3032920021022683678	\N	3061920110002182838	F3X	YE	1989	1990	http://docquery.fec.gov/cgi-bin/fecimg/?90036233299	'c00002766':1	\N	\N	f	C00002766	2017-06-07 20:46:21.796794	\N	Q	M	U
C00243543	BLACKWELL FOR CONGRESS COMMITTEE	\N	HARRISON, ROBERT S	ROBERT S	\N	HARRISON	\N	\N	\N	\N	LOVELAND	OH	45140	\N	\N	BALDWIN PIANO & ORGAN CO	\N	\N	\N	\N	\N	\N	1980-08-01 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	90014122479	\N	3032920021022029055	\N	3061920110002442314	F3	Q3	1990	1990	http://docquery.fec.gov/cgi-bin/fecimg/?90014122479	'harrison':1 'robert':2 's':3	'baldwin':1 'co':4 'organ':3 'piano':2	\N	t	\N	2017-06-07 20:46:21.796794	\N	H		P
C00229286	KEEP HOPE ALIVE POLITICAL ACTION COMMITTEE	\N	ELAM, CLARA C	CLARA C	\N	ELAM	\N	\N	\N	\N	NASHVILLE	TN	37207	\N	\N	\N	\N	\N	\N	\N	\N	\N	1987-12-26 00:00:00	200.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	90036262090	\N	3032920021022284045	\N	3061920110002174402	F3X	YE	1989	1990	http://docquery.fec.gov/cgi-bin/fecimg/?90036262090	'c':3 'clara':2 'elam':1	\N	\N	t	\N	2017-06-07 20:46:21.796794	\N	Q	M	U
C00245415	BURRIS TO CONGRESS	\N	STERN, CORDELL K	CORDELL K	\N	STERN	\N	\N	\N	\N	BELFRY	MT	59008	\N	\N	\N	\N	\N	\N	\N	\N	\N	1980-02-14 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	90013983214	\N	3032920021022021931	\N	3061920110002287697	F3	12P	1990	1990	http://docquery.fec.gov/cgi-bin/fecimg/?90013983214	'cordell':2 'k':3 'stern':1	\N	\N	t	\N	2017-06-07 20:46:21.796794	\N	H		P
C00238097	CARLSON FOR CONGRESS COMMITTEE	\N	CARLSON, JIM	JIM	\N	CARLSON	\N	\N	\N	\N	JULESBURG	CO	80737	\N	\N	FARMER	\N	\N	\N	\N	\N	\N	1987-08-03 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	90013911599	\N	3032920021022019570	\N	3061920110002259661	F3	YE	1989	1990	http://docquery.fec.gov/cgi-bin/fecimg/?90013911599	'carlson':1 'jim':2	'farmer':1	\N	t	\N	2017-06-07 20:46:21.796794	\N	H		P
C00238097	CARLSON FOR CONGRESS COMMITTEE	\N	CARLSON, CG	CG	\N	CARLSON	\N	\N	\N	\N	JULESBURG	CO	80737	\N	\N	FARMER	\N	\N	\N	\N	\N	\N	1987-08-03 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	90013911599	\N	3032920021022019570	\N	3061920110002259662	F3	YE	1989	1990	http://docquery.fec.gov/cgi-bin/fecimg/?90013911599	'carlson':1 'cg':2	'farmer':1	\N	t	\N	2017-06-07 20:46:21.796794	\N	H		P
C00214510	FRIENDS OF SAM BEARD FOR THE U S SENATE	\N	BERGER, MILES	MILES	\N	BERGER	\N	\N	\N	\N	NEWARK	NJ	07102	\N	\N	BURGER HOTELS CORPORATION	\N	\N	\N	\N	\N	\N	1987-06-29 00:00:00	-1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	89020042373	\N	3032920021022238138	\N	3061920110002044591	F3	MY	1989	1990	http://docquery.fec.gov/cgi-bin/fecimg/?89020042373	'berger':1 'miles':2	'burger':1 'corporation':3 'hotels':2	\N	t	\N	2017-06-07 20:46:21.796794	\N	S		P
C00239129	KENTUCKIANS FOR BROCK	\N	WOOLUMS, JOE	JOE	\N	WOOLUMS	\N	\N	\N	\N	FRANKFORT	KY	40601	\N	\N	STATE GOVERNMENT	\N	\N	\N	\N	\N	\N	1987-12-05 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	90020052896	\N	3032920021022019469	\N	3061920110002256841	F3	YE	1989	1990	http://docquery.fec.gov/cgi-bin/fecimg/?90020052896	'joe':2 'woolums':1	'government':2 'state':1	\N	t	\N	2017-06-07 20:46:21.796794	\N	S		P
C00239715	JOHN W HALLOCK JR CAMPAIGN COMMITTEE	H0IL16093	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1983-12-02 00:00:00	200.00	15C	CONTRIBUTION FROM CANDIDATE	CONTRIBUTION FROM CANDIDATE	\N	\N	\N	H0IL16093	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	89013860751	\N	3032920021022239941	\N	3061920110002141164	F3	TER	1989	1990	http://docquery.fec.gov/cgi-bin/fecimg/?89013860751	'h0il16093':1	\N	\N	f	H0IL16093	2017-06-07 20:46:21.796794	\N	H		A
\.


--
-- Data for Name: fec_fitem_sched_a_1991_1992; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_1991_1992 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00250381	ABRAMS '92	\N	NIMETZ, MATTHEW	MATTHEW	\N	NIMETZ	\N	\N	\N	\N	NEW YORK	NY	10019	\N	\N	PAUL, WEISS, RIFKIND, WHARTON ET AL	\N	\N	\N	\N	\N	\N	1991-12-04 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	92020042978	\N	3032920021022045618	\N	3061920110002628665	F3	YE	1991	1992	http://docquery.fec.gov/cgi-bin/fecimg/?92020042978	'matthew':2 'nimetz':1	'al':6 'et':5 'paul':1 'rifkind':3 'weiss':2 'wharton':4		t	\N	2020-01-10 03:37:42.89	\N	S	\N	P
C00214221	JACK KEMP FOR PRESIDENT	\N	BLECHMAN, GILBERT	GILBERT	\N	BLECHMAN	\N	\N	\N	\N	LINCOLNWOOD	IL	60646	\N	\N	CAMEO CONTAINER CORPOR	\N	\N	\N	\N	\N	\N	1991-06-18 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	91036632898	\N	3032920021022247261	\N	3061920110002685755	F3P	Q2	1991	1992	http://docquery.fec.gov/cgi-bin/fecimg/?91036632898	'blechman':1 'gilbert':2	'cameo':1 'container':2 'corpor':3		t	\N	2020-01-10 03:37:42.891	\N	P	\N	P
C00155713	BAYPAC	\N	ANDERSON, DOUG	DOUG	\N	ANDERSON	\N	\N	\N	\N	TAMPA	FL	\N	\N	\N	AIR CONDITIONING CONT.	\N	\N	\N	\N	\N	\N	1991-03-15 00:00:00	300.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	91037023268	\N	3032920021022290281	\N	3061920110002701223	F3X	MY	1991	1992	http://docquery.fec.gov/cgi-bin/fecimg/?91037023268	'anderson':1 'doug':2	'air':1 'conditioning':2 'cont':3		t	\N	2020-01-10 03:37:42.892	\N	Q	M	U
C00258715	LYNN YEAKEL FOR SENATE	\N	JORDAN, KATHRYN	KATHRYN	\N	JORDAN	\N	\N	\N	\N	PALO ALTO	CA	94301	\N	\N	MAVERICK	\N	\N	\N	\N	\N	\N	1992-09-21 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	92020214307	\N	3032920021022059163	\N	3061920110002898434	F3	Q3	1992	1992	http://docquery.fec.gov/cgi-bin/fecimg/?92020214307	'jordan':1 'kathryn':2	'maverick':1		t	\N	2020-01-10 03:37:42.892	\N	S	\N	P
C00082792	ELI LILLY AND COMPANY POLITICAL ACTION COMMITTEE	\N	DOUGHERTY, OREN E	OREN E	\N	DOUGHERTY	\N	\N	\N	\N	DALLAS	TX	75234	\N	\N	ELI LILLY & CO	\N	\N	\N	\N	\N	\N	1992-02-13 00:00:00	240.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	92037423305	\N	3032920021022303881	\N	3061920110002989480	F3X	M3	1992	1992	http://docquery.fec.gov/cgi-bin/fecimg/?92037423305	'dougherty':1 'e':3 'oren':2	'co':3 'eli':1 'lilly':2	\N	t	\N	2017-06-07 18:15:01.307891	\N	Q	C	U
C00082792	ELI LILLY AND COMPANY POLITICAL ACTION COMMITTEE	\N	FULK, J ANN	J ANN	\N	FULK	\N	\N	\N	\N	CARMEL	IN	46032	\N	\N	ELI LILLY & CO	\N	\N	\N	\N	\N	\N	1992-02-13 00:00:00	225.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	92037423306	\N	3032920021022303881	\N	3061920110002989485	F3X	M3	1992	1992	http://docquery.fec.gov/cgi-bin/fecimg/?92037423306	'ann':3 'fulk':1 'j':2	'co':3 'eli':1 'lilly':2	\N	t	\N	2017-06-07 18:15:01.307891	\N	Q	C	U
C00085316	CIGNA CORPORATION POLITICAL ACTION COMMITTEE	\N	FOWLER, CALEB L	CALEB L	\N	FOWLER	\N	\N	\N	\N	BERWYN	PA	19312	\N	\N	INA	\N	\N	\N	\N	\N	\N	1992-02-12 00:00:00	225.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	92037430470	\N	3032920021022304130	\N	3061920110002979943	F3X	M3	1992	1992	http://docquery.fec.gov/cgi-bin/fecimg/?92037430470	'caleb':2 'fowler':1 'l':3	'ina':1	\N	t	\N	2017-06-07 18:15:01.307891	\N	Q	C	U
C00250951	TSONGAS COMMITTEE INC	\N	RIGBY, WILLIAM J	WILLIAM J	\N	RIGBY	\N	\N	\N	\N	NAPERVILLE	IL	60563	\N	\N	\N	\N	\N	\N	\N	\N	\N	1992-02-27 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	92037395630	\N	3032920021022248520	\N	3061920110002979962	F3P	M3	1992	1992	http://docquery.fec.gov/cgi-bin/fecimg/?92037395630	'j':3 'rigby':1 'william':2	\N	\N	t	\N	2017-06-07 18:15:01.307891	\N	P		P
C00250951	TSONGAS COMMITTEE INC	\N	RUSSELL, CAROL C	CAROL C	\N	RUSSELL	\N	\N	\N	\N	SCITUATE	MA	02066	\N	\N	\N	\N	\N	\N	\N	\N	\N	1992-02-23 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	92037395635	\N	3032920021022248520	\N	3061920110002980972	F3P	M3	1992	1992	http://docquery.fec.gov/cgi-bin/fecimg/?92037395635	'c':3 'carol':2 'russell':1	\N	\N	t	\N	2017-06-07 18:15:01.307891	\N	P		P
C00104851	U.S. TOBACCO EXECUTIVES, ADMINISTRATORS AND MANAGERS POLITICAL ACTION COMMITTEE(USTEAMPAC)	\N	KAISER, ALAN	ALAN	\N	KAISER	\N	\N	\N	\N	MT KISCO	NY	10549	\N	\N	UST INC	\N	\N	\N	\N	\N	\N	1992-02-18 00:00:00	1500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	92037432817	\N	3032920021022304293	\N	3061920110002980755	F3X	M3	1992	1992	http://docquery.fec.gov/cgi-bin/fecimg/?92037432817	'alan':2 'kaiser':1	'inc':2 'ust':1	\N	t	\N	2017-06-07 18:15:01.307891	\N	Q	C	U
\.


--
-- Data for Name: fec_fitem_sched_a_1993_1994; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_1993_1994 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00136457	NEW HAMPSHIRE REPUBLICAN STATE COMMITTEE	\N	NEWMAN, EDWARD	EDWARD	\N	NEWMAN	\N	\N	\N	\N	WINDHAM	NH	03087	\N	\N	SELF-EMPLOYED	\N	\N	\N	\N	\N	\N	1993-10-01 00:00:00	300.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	94038783852	\N	3032920021022432000	\N	3061920110003479257	F3X	YE	1993	1994	http://docquery.fec.gov/cgi-bin/fecimg/?94038783852	'edward':2 'newman':1	'employed':2 'self':1		t	\N	2020-01-10 03:37:53.999	\N	Y	\N	U
C00078105	CONGRESSMAN KILDEE COMMITTEE	\N	METZGER, GARY	GARY	\N	METZGER	\N	\N	\N	\N	FLINT	MI	48505	\N	\N	THERMAL SYSTEMS INC	\N	\N	\N	\N	\N	\N	1993-04-16 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	93015000777	\N	3032920021022115900	\N	3061920110003577982	F3	MY	1993	1994	http://docquery.fec.gov/cgi-bin/fecimg/?93015000777	'gary':2 'metzger':1	'inc':3 'systems':2 'thermal':1		t	\N	2020-01-10 03:37:54	\N	H	\N	P
C00279273	KAY BAILEY HUTCHISON FOR SENATE COMMITTEE	\N	WALL, DONALD	DONALD	\N	WALL	\N	\N	\N	\N	PARIS	TX	75460	\N	\N	WALL CONCRETE PIPE CO INC	\N	\N	\N	\N	\N	\N	1993-05-14 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	93020051138	\N	3032920021022112757	\N	3061920110003614038	F3	12R	1993	1994	http://docquery.fec.gov/cgi-bin/fecimg/?93020051138	'donald':2 'wall':1	'co':4 'concrete':2 'inc':5 'pipe':3 'wall':1		t	\N	2020-01-10 03:37:54.001	\N	S	\N	P
C00279273	KAY BAILEY HUTCHISON FOR SENATE COMMITTEE	\N	BROWN, JACK P	JACK P	\N	BROWN	\N	\N	\N	\N	DALLAS	TX	75205	\N	\N	RETIRED	\N	\N	\N	\N	\N	\N	1993-05-14 00:00:00	300.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	93020051139	\N	3032920021022112757	\N	3061920110003614043	F3	12R	1993	1994	http://docquery.fec.gov/cgi-bin/fecimg/?93020051139	'brown':1 'jack':2 'p':3	'retired':1		t	\N	2020-01-10 03:37:54.002	\N	S	\N	P
C00279273	KAY BAILEY HUTCHISON FOR SENATE COMMITTEE	\N	BRYAN, F L MR	F L MR	\N	BRYAN	\N	\N	\N	\N	HOUSTON	TX	77024	\N	\N	RETIRED	\N	\N	\N	\N	\N	\N	1993-05-14 00:00:00	300.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	93020051139	\N	3032920021022112757	\N	3061920110003614044	F3	12R	1993	1994	http://docquery.fec.gov/cgi-bin/fecimg/?93020051139	'bryan':1 'f':2 'l':3 'mr':4	'retired':1		t	\N	2020-01-10 03:37:54.003	\N	S	\N	P
C00288761	MARTINI FOR CONGRESS	\N	CHERTOFF, MICHAEL	MICHAEL	\N	CHERTOFF	\N	\N	\N	\N	NEW YORK	NJ	\N	\N	\N	LATHAM & WATKINS	\N	\N	\N	\N	\N	\N	1994-10-18 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	94015514458	\N	3032920021022124640	\N	3061920110003820560	F3	12G	1994	1994	http://docquery.fec.gov/cgi-bin/fecimg/?94015514458	'chertoff':1 'michael':2	'latham':1 'watkins':2	\N	t	\N	2017-06-07 18:41:11.522147	\N	H		P
C00282939	RICH SYBERT FOR CONGRESS COMMITTEE	\N	HOFF, JOHN S	JOHN S	\N	HOFF	\N	\N	\N	\N	WASHINGTON	DC	20007	\N	\N	SWIDLER & BERLIN	\N	\N	\N	\N	\N	\N	1994-07-29 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	94015433458	\N	3032920021022130033	\N	3061920110003771243	F3	Q3	1994	1994	http://docquery.fec.gov/cgi-bin/fecimg/?94015433458	'hoff':1 'john':2 's':3	'berlin':2 'swidler':1	\N	t	\N	2017-06-07 18:41:11.522147	\N	H		P
C00282939	RICH SYBERT FOR CONGRESS COMMITTEE	\N	LAVI, DONALD	DONALD	\N	LAVI	\N	\N	\N	\N	AGOURA HILLS	CA	91301	\N	\N	SANFORD C BERNSTEIN & CO	\N	\N	\N	\N	\N	\N	1994-09-09 00:00:00	300.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	94015433459	\N	3032920021022130033	\N	3061920110003771250	F3	Q3	1994	1994	http://docquery.fec.gov/cgi-bin/fecimg/?94015433459	'donald':2 'lavi':1	'bernstein':3 'c':2 'co':4 'sanford':1	\N	t	\N	2017-06-07 18:41:11.522147	\N	H		P
C00282939	RICH SYBERT FOR CONGRESS COMMITTEE	\N	HEWITSON, LUCINDA M	LUCINDA M	\N	HEWITSON	\N	\N	\N	\N	AGOURA	CA	91301	\N	\N	HOMEMAKER	\N	\N	\N	\N	\N	\N	1994-09-30 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	94015433457	\N	3032920021022130033	\N	3061920110003771238	F3	Q3	1994	1994	http://docquery.fec.gov/cgi-bin/fecimg/?94015433457	'hewitson':1 'lucinda':2 'm':3	'homemaker':1	\N	t	\N	2017-06-07 18:41:11.522147	\N	H		P
C00224170	L F PAYNE FOR CONGRESS	\N	HOOD, H M	H M	\N	HOOD	\N	\N	\N	\N	DANVILLE	VA	24541	\N	\N	GOODYEAR TIRE AND RUBBER	\N	\N	\N	\N	\N	\N	1994-08-10 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	94015432817	\N	3032920021022125013	\N	3061920110003801231	F3	Q3	1994	1994	http://docquery.fec.gov/cgi-bin/fecimg/?94015432817	'h':2 'hood':1 'm':3	'and':3 'goodyear':1 'rubber':4 'tire':2	\N	t	\N	2017-06-07 18:41:11.522147	\N	H		P
\.


--
-- Data for Name: fec_fitem_sched_a_1995_1996; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_1995_1996 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00003418	REPUBLICAN NATIONAL COMMITTEE - RNC	\N	HALLORAN, MICHAEL	MICHAEL	\N	HALLORAN	\N	\N	\N	\N	ORINDA	CA	94563	\N	\N	BANK AMERICA NT & SA	\N	\N	\N	\N	\N	\N	1995-10-25 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	95030072962	\N	3040120021023088969	\N	3061920110004314878	F3X	M11	1995	1996	http://docquery.fec.gov/cgi-bin/fecimg/?95030072962	'halloran':1 'michael':2	'america':2 'bank':1 'nt':3 'sa':4		t	\N	2020-01-10 03:38:06.528	\N	Y	\N	U
C00300566	SANTORUM 2000	\N	BUNTING, THOMAS 3RD	THOMAS 3RD	\N	BUNTING	\N	\N	\N	\N	FORT WASHINGTON	PA	19034	\N	\N	TAIT WELLER & BAKER	\N	\N	\N	\N	\N	\N	1995-11-30 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	96020053458	\N	3040120021023043003	\N	3061920110004422167	F3	YE	1995	1996	http://docquery.fec.gov/cgi-bin/fecimg/?96020053458	'3rd':3 'bunting':1 'thomas':2	'baker':3 'tait':1 'weller':2		t	\N	2020-01-10 03:38:06.528	\N	S	\N	P
C00300608	DOLE FOR PRESIDENT INC	\N	PLANK, RAYMOND	RAYMOND	\N	PLANK	\N	\N	\N	\N	CLEARMONT	WY	82835	\N	\N	APACHE CORPORATION	\N	\N	\N	\N	\N	\N	1995-03-28 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	95039724357	\N	3040120021023059003	\N	3061920110004498841	F3P	Q1	1995	1996	http://docquery.fec.gov/cgi-bin/fecimg/?95039724357	'plank':1 'raymond':2	'apache':1 'corporation':2		t	\N	2020-01-10 03:38:06.529	\N	P	\N	A
C00300608	DOLE FOR PRESIDENT INC	\N	BADER, MICHAEL H	MICHAEL H	\N	BADER	\N	\N	\N	\N	BETHESDA	MD	20816	\N	\N	HALEY, BADER & POTTS	\N	\N	\N	\N	\N	\N	1995-06-22 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	95039832206	\N	3040120021023059331	\N	3061920110004532846	F3P	Q2	1995	1996	http://docquery.fec.gov/cgi-bin/fecimg/?95039832206	'bader':1 'h':3 'michael':2	'bader':2 'haley':1 'potts':3		t	\N	2020-01-10 03:38:06.529	\N	P	\N	A
C00102764	AMERICAN CHIROPRACTIC ASSOCIATION POLITICAL ACTION COMMITTEE	\N	CASTILLO, GREGORY S	GREGORY S	\N	CASTILLO	\N	\N	\N	\N	PITTSBURG	CA	94565	\N	\N	CHIROPRACTOR	\N	\N	\N	\N	\N	\N	1995-06-28 00:00:00	225.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	95039871674	\N	3040120021023062197	\N	3061920110004660038	F3X	M7	1995	1996	http://docquery.fec.gov/cgi-bin/fecimg/?95039871674	'castillo':1 'gregory':2 's':3	'chiropractor':1	\N	t	\N	2017-06-07 18:53:06.345564	\N	Q	T	U
C00111633	SAM GEJDENSON RE-ELECTION COMMITTEE	\N	HIRSCHHORN, ERIC L	ERIC L	\N	HIRSCHHORN	\N	\N	\N	\N	CHEVY CHASE	MD	20815	\N	\N	WINSTON & STRAWN	\N	\N	\N	\N	\N	\N	1995-03-29 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	95015804160	\N	3040120021023032098	\N	3061920110004629492	F3	MY	1995	1996	http://docquery.fec.gov/cgi-bin/fecimg/?95015804160	'eric':2 'hirschhorn':1 'l':3	'strawn':2 'winston':1	\N	t	\N	2017-06-07 18:53:06.345564	\N	H		P
C00114439	WASHINGTON STATE DEMOCRATIC CENTRAL COMMITTEE	\N	ERICSSON, LOWELL H	LOWELL H	\N	ERICSSON	\N	\N	\N	\N	MERCER ISLAND	WA	\N	\N	\N	SENIOR RESEARCH SCIENTIST UNIVER	\N	\N	\N	\N	\N	\N	1995-02-24 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	95039891067	\N	3040120021023095212	\N	3061920110004629465	F3X	MY	1995	1996	http://docquery.fec.gov/cgi-bin/fecimg/?95039891067	'ericsson':1 'h':3 'lowell':2	'research':2 'scientist':3 'senior':1 'univer':4	\N	t	\N	2017-06-07 18:53:06.345564	\N	Y		U
C00301978	PETE WILSON FOR PRESIDENT COMMITTEE INC	\N	BESSON, MARIE JOSE	MARIE JOSE	\N	BESSON	\N	\N	\N	\N	DEVON	PA	19333	\N	\N	\N	\N	\N	\N	\N	\N	\N	1995-06-30 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	95030022882	\N	3040120021023059201	\N	3061920110004685643	F3P	Q2	1995	1996	http://docquery.fec.gov/cgi-bin/fecimg/?95030022882	'besson':1 'jose':3 'marie':2	\N	\N	t	\N	2017-06-07 18:53:06.345564	\N	P		P
C00302265	CLINTON/GORE '96 PRIMARY COMMITTEE INC	\N	SANGER, MARY BRYNA	MARY BRYNA	\N	SANGER	\N	\N	\N	\N	NEW YORK	NY	10022	\N	\N	NEW SCHOOL FOR SOCIAL RESEARCH	\N	\N	\N	\N	\N	\N	1995-11-06 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	96030510817	\N	3040120021023059432	\N	3061920110004652805	F3P	YE	1995	1996	http://docquery.fec.gov/cgi-bin/fecimg/?96030510817	'bryna':3 'mary':2 'sanger':1	'for':3 'new':1 'research':5 'school':2 'social':4	\N	t	\N	2017-06-07 18:53:06.345564	\N	P		A
C00126219	FRIENDS OF SCHUMER	\N	GUND, AGNES	AGNES	\N	GUND	\N	\N	\N	\N	NEW YORK	NY	10021	\N	\N	MUSEUM OF MODERN ART	\N	\N	\N	\N	\N	\N	1995-05-04 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	95015782906	\N	3040120021023050119	\N	3061920110004629466	F3	MY	1995	1996	http://docquery.fec.gov/cgi-bin/fecimg/?95015782906	'agnes':2 'gund':1	'art':4 'modern':3 'museum':1 'of':2	\N	t	\N	2017-06-07 18:53:06.345564	\N	H		P
\.


--
-- Data for Name: fec_fitem_sched_a_1997_1998; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_1997_1998 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00010983	JOHNSON & JOHNSON EMPLOYEES' GOOD GOVERNMENT FUND	\N	CROCE, ROBERT W	ROBERT W	\N	CROCE	\N	\N	\N	\N	BRIDGEWATER	NJ	08807	\N	\N	J&J CORPORATE	\N	\N	\N	\N	\N	\N	1997-03-31 00:00:00	384.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	97031982569	\N	3040320021023249480	\N	3061920110005577572	F3X	M4	1997	1998	http://docquery.fec.gov/cgi-bin/fecimg/?97031982569	'croce':1 'robert':2 'w':3	'corporate':3 'j':1,2		t	\N	2020-01-10 03:38:22.91	\N	Q	C	U
C00010983	JOHNSON & JOHNSON EMPLOYEES' GOOD GOVERNMENT FUND	\N	GORRIE, THOMAS M	THOMAS M	\N	GORRIE	\N	\N	\N	\N	PENNINGTON	NJ	08534	\N	\N	J&J CORPORATE	\N	\N	\N	\N	\N	\N	1997-03-31 00:00:00	200.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	97031982569	\N	3040320021023249480	\N	3061920110005577573	F3X	M4	1997	1998	http://docquery.fec.gov/cgi-bin/fecimg/?97031982569	'gorrie':1 'm':3 'thomas':2	'corporate':3 'j':1,2		t	\N	2020-01-10 03:38:22.91	\N	Q	C	U
C00010983	JOHNSON & JOHNSON EMPLOYEES' GOOD GOVERNMENT FUND	\N	TATTLE, PETER T	PETER T	\N	TATTLE	\N	\N	\N	\N	PRINCETON	NJ	08540	\N	\N	J&J CORPORATE	\N	\N	\N	\N	\N	\N	1997-03-31 00:00:00	384.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	97031982571	\N	3040320021023249480	\N	3061920110005577574	F3X	M4	1997	1998	http://docquery.fec.gov/cgi-bin/fecimg/?97031982571	'peter':2 't':3 'tattle':1	'corporate':3 'j':1,2		t	\N	2020-01-10 03:38:22.911	\N	Q	C	U
C00197152	CITIZENS FOR BUNNING	\N	PRAJAPATI, DATTATRAYA S. DR.	DATTATRAYA S. DR.	\N	PRAJAPATI	\N	\N	\N	\N	OWENSBORO	KY	42301	\N	\N	MEDICAL DOCTOR	\N	\N	\N	\N	\N	\N	1997-05-13 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	97020070398	\N	3040320021023230699	\N	3061920110005593625	F3	MY	1997	1998	http://docquery.fec.gov/cgi-bin/fecimg/?97020070398	'dattatraya':2 'dr':4 'prajapati':1 's':3	'doctor':2 'medical':1		t	\N	2020-01-10 03:38:22.911	\N	S	\N	P
C00285932	TOM DAVIS FOR CONGRESS	\N	KESSLER, RICHARD S	RICHARD S	\N	KESSLER	\N	\N	\N	\N	ANNANDALE	VA	22003	\N	\N	K&A INC	\N	\N	\N	\N	\N	\N	1997-06-26 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	97032250127	\N	3040320021023231072	\N	3061920110005660037	F3	MY	1997	1998	http://docquery.fec.gov/cgi-bin/fecimg/?97032250127	'kessler':1 'richard':2 's':3	'a':2 'inc':3 'k':1		t	\N	2020-01-10 03:38:22.912	\N	H	\N	P
C00331439	MARK UDALL FOR CONGRESS	\N	PRATT, VERA	VERA	\N	PRATT	\N	\N	\N	\N	WASHINGTON	DC	20016	\N	\N	\N	\N	\N	\N	\N	\N	\N	1998-10-23 00:00:00	350.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	98034072141	\N	3040320021023217167	\N	3061920110006504884	F3	30G	1998	1998	http://docquery.fec.gov/cgi-bin/fecimg/?98034072141	'pratt':1 'vera':2	\N	\N	t	\N	2017-06-07 19:04:45.421637	\N	H		P
C00279398	COVERDELL GOOD GOVERNMENT COMMITTEE;THE	\N	WRIGHT, ROBERT E	ROBERT E	\N	WRIGHT	\N	\N	\N	\N	SYLACAUGA	AL	35150	\N	\N	BOBWRIGHT CORPORATION	\N	\N	\N	\N	\N	\N	1998-08-07 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	98020230211	\N	3040320021023215344	\N	3061920110006440867	F3	Q3	1998	1998	http://docquery.fec.gov/cgi-bin/fecimg/?98020230211	'e':3 'robert':2 'wright':1	'bobwright':1 'corporation':2	\N	t	\N	2017-06-07 19:04:45.421637	\N	S		P
C00285114	KEN BENTSEN FOR CONGRESS COMMITTEE	\N	ATTWELL, J EVANS	J EVANS	\N	ATTWELL	\N	\N	\N	\N	HOUSTON	TX	77002	\N	\N	VINSON & ELKINS	\N	\N	\N	\N	\N	\N	1998-09-21 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	98033643213	\N	3040320021023212312	\N	3061920110006429120	F3	Q3	1998	1998	http://docquery.fec.gov/cgi-bin/fecimg/?98033643213	'attwell':1 'evans':3 'j':2	'elkins':2 'vinson':1	\N	t	\N	2017-06-07 19:04:45.421637	\N	H		P
C00285114	KEN BENTSEN FOR CONGRESS COMMITTEE	\N	GOCHMAN, ARTHUR	ARTHUR	\N	GOCHMAN	\N	\N	\N	\N	KATY	TX	77449	\N	\N	ACADEMY CORP	\N	\N	\N	\N	\N	\N	1998-07-29 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	98033643214	\N	3040320021023212312	\N	3061920110006429126	F3	Q3	1998	1998	http://docquery.fec.gov/cgi-bin/fecimg/?98033643214	'arthur':2 'gochman':1	'academy':1 'corp':2	\N	t	\N	2017-06-07 19:04:45.421637	\N	H		P
C00335018	DELBERT HOSEMANN FOR CONGRESS COMMITTEE	\N	TAYLOR, ROWAN	ROWAN	\N	TAYLOR	\N	\N	\N	\N	JACKSON	MS	39216	\N	\N	ALSTON & JONES	\N	\N	\N	\N	\N	\N	1998-08-26 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	98033621160	\N	3040320021023212992	\N	3061920110006424552	F3	Q3	1998	1998	http://docquery.fec.gov/cgi-bin/fecimg/?98033621160	'rowan':2 'taylor':1	'alston':1 'jones':2	\N	t	\N	2017-06-07 19:04:45.421637	\N	H		P
\.


--
-- Data for Name: fec_fitem_sched_a_1999_2000; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_1999_2000 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00003418	REPUBLICAN NATIONAL COMMITTEE - RNC	\N	LAPPIN, DAVID L	DAVID L	\N	LAPPIN	\N	\N	\N	\N	BALLWIN	MO	63021	\N	\N	TRANSCONTINENTAL ADVIS	\N	\N	\N	\N	\N	\N	2000-12-19 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21036831784	\N	3040720021023421545	3061920110008045186	1050320130013870345	F3X	YE	2000	2000	http://docquery.fec.gov/cgi-bin/fecimg/?21036831784	'david':2 'l':3 'lappin':1	'advis':2 'transcontinental':1		t	\N	2020-01-10 03:40:01.933	\N	Y	\N	U
C00003418	REPUBLICAN NATIONAL COMMITTEE - RNC	\N	KRUEGER, MARJORIE C	MARJORIE C	\N	KRUEGER	\N	\N	\N	\N	CONCORD	CA	94518	\N	\N	RETIRED	\N	\N	\N	\N	\N	\N	2000-11-28 00:00:00	200.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21036831749	\N	3040720021023421545	3061920110008044882	1050320130013870641	F3X	YE	2000	2000	http://docquery.fec.gov/cgi-bin/fecimg/?21036831749	'c':3 'krueger':1 'marjorie':2	'retired':1		t	\N	2020-01-10 03:40:01.934	\N	Y	\N	U
C00003418	REPUBLICAN NATIONAL COMMITTEE - RNC	\N	KRUEGER, MARJORIE C	MARJORIE C	\N	KRUEGER	\N	\N	\N	\N	CONCORD	CA	94518	\N	\N	RETIRED	\N	\N	\N	\N	\N	\N	2000-12-08 00:00:00	200.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21036831749	\N	3040720021023421545	3061920110008044883	1050320130013870642	F3X	YE	2000	2000	http://docquery.fec.gov/cgi-bin/fecimg/?21036831749	'c':3 'krueger':1 'marjorie':2	'retired':1		t	\N	2020-01-10 03:40:01.934	\N	Y	\N	U
C00193433	EMILY'S LIST	\N	HOMER, ANNA	ANNA	\N	HOMER	\N	\N	\N	\N	GAINESVILLE	TX	76240	\N	\N	RETIRED	\N	\N	\N	\N	\N	\N	1999-06-11 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	99034592116	\N	3040720021023452362	\N	3061920110006940117	F3X	M7	1999	2000	http://docquery.fec.gov/cgi-bin/fecimg/?99034592116	'anna':2 'homer':1	'retired':1	\N	t	\N	2017-06-07 19:16:10.506881	\N	Q		U
C00003418	REPUBLICAN NATIONAL COMMITTEE - RNC	\N	KRUEGER, MARJORIE C	MARJORIE C	\N	KRUEGER	\N	\N	\N	\N	CONCORD	CA	94518	\N	\N	RETIRED	\N	\N	\N	\N	\N	\N	2000-12-26 00:00:00	300.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21036831749	\N	3040720021023421545	3061920110008044884	1050320130013870643	F3X	YE	2000	2000	http://docquery.fec.gov/cgi-bin/fecimg/?21036831749	'c':3 'krueger':1 'marjorie':2	'retired':1		t	\N	2020-01-10 03:40:01.935	\N	Y	\N	U
C00003418	REPUBLICAN NATIONAL COMMITTEE - RNC	\N	KRUEGER, MARJORIE C	MARJORIE C	\N	KRUEGER	\N	\N	\N	\N	CONCORD	CA	94518	\N	\N	RETIRED	\N	\N	\N	\N	\N	\N	2000-12-26 00:00:00	300.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21036831749	\N	3040720021023421545	3061920110008044885	1050320130013870644	F3X	YE	2000	2000	http://docquery.fec.gov/cgi-bin/fecimg/?21036831749	'c':3 'krueger':1 'marjorie':2	'retired':1		t	\N	2020-01-10 03:40:01.936	\N	Y	\N	U
C00308536	FRIENDS OF ERROL FLYNN	\N	SHERWOOD, DONALD	DONALD	\N	SHERWOOD	\N	\N	\N	\N	TUNKHANNOCK	\N	\N	\N	\N	UNITED STATES OF AMERICA	\N	\N	\N	\N	\N	\N	1999-06-25 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	99034744929	\N	3040720021023388479	\N	3061920110006843869	F3	MY	1999	2000	http://docquery.fec.gov/cgi-bin/fecimg/?99034744929	'donald':2 'sherwood':1	'america':4 'of':3 'states':2 'united':1	\N	t	\N	2017-06-07 19:16:10.506881	\N	H		P
C00308718	CROSS TIMBERS OIL COMPANY FED PAC	\N	MCDONALD, FRANK	FRANK	\N	MCDONALD	\N	\N	\N	\N	FORT WORTH	TX	76102	\N	\N	CROSS TIMBERS OIL COMPANY	\N	\N	\N	\N	\N	\N	1999-03-22 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	99034444174	\N	3040720021023429814	\N	3061920110007210699	F3X	M4	1999	2000	http://docquery.fec.gov/cgi-bin/fecimg/?99034444174	'frank':2 'mcdonald':1	'company':4 'cross':1 'oil':3 'timbers':2	\N	t	\N	2017-06-07 19:16:10.506881	\N	Q	C	U
C00309120	AMERICAN TRANS AIR INC PAC; AMTRAN INC PAC	\N	MOORE, LOUIS W	LOUIS W	\N	MOORE	\N	\N	\N	\N	MOORESVILLE	IN	46158	\N	\N	AMERICAN TRANS AIR	\N	\N	\N	\N	\N	\N	1999-03-05 00:00:00	200.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	99034424964	\N	3040720021023427246	\N	3061920110007209836	F3X	Q1	1999	2000	http://docquery.fec.gov/cgi-bin/fecimg/?99034424964	'louis':2 'moore':1 'w':3	'air':3 'american':1 'trans':2	\N	t	\N	2017-06-07 19:16:10.506881	\N	N	C	U
C00341792	SECOND DISTRICT PAC	\N	PERKINS, JACK	JACK	\N	PERKINS	\N	\N	\N	\N	HOLLANDALE	MS	38748	\N	\N	CON-FISH	\N	\N	\N	\N	\N	\N	2000-10-13 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	20036364080	\N	3040720021023403892	\N	3061920110008224796	F3X	12G	2000	2000	http://docquery.fec.gov/cgi-bin/fecimg/?20036364080	'jack':2 'perkins':1	'con':1 'fish':2	\N	t	\N	2017-06-07 19:16:10.506881	\N	N		U
\.


--
-- Data for Name: fec_fitem_sched_a_2001_2002; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_2001_2002 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00366948	STEPHEN F LYNCH FOR CONGRESS COMMITTEE	\N	CARROLL JR., JOHN J.	 JOHN J.	\N	CARROLL JR.	\N	\N	\N	\N	WINCHESTER	MA	01890	\N	\N	MEEHAN & BOYLE/ATTORNEY	\N	\N	\N	\N	\N	\N	2001-09-06 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21990501473	\N	3041220021023564189	\N	3061920110008148295	F3	12G	2001	2002	http://docquery.fec.gov/cgi-bin/fecimg/?21990501473	'carroll':1 'j':4 'john':3 'jr':2	'attorney':3 'boyle':2 'meehan':1		t	\N	2020-01-10 03:51:31.077	\N	H	\N	P
C00193433	EMILY'S LIST	\N	ADLER, ELAINE MS.	ELAINE MS.	\N	ADLER	\N	\N	\N	\N	FRANKLIN LAKES	NJ	07417	\N	\N	MYRON MFG. CORP.	\N	\N	\N	\N	\N	\N	2001-01-29 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21990037482	\N	3041220021023573176	\N	3061920110008167655	F3X	M2	2001	2002	http://docquery.fec.gov/cgi-bin/fecimg/?21990037482	'adler':1 'elaine':2 'ms':3	'corp':3 'mfg':2 'myron':1		t	\N	2020-01-10 03:51:31.231	\N	Q		U
C00311159	NATIONAL HARDWOOD LUMBER ASSOCIATION PAC INC	\N	TERPSTRA, B. GRACE MRS.	B. GRACE MRS.	\N	TERPSTRA	\N	\N	\N	\N	WASHINGTON	DC	20036	\N	\N	TEPSTRA ASSOCIATES/PRINCIPAL	\N	\N	\N	\N	\N	\N	2001-01-05 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21990045726	\N	3041220021023573609	\N	3061920110008150785	F3X	M2	2001	2002	http://docquery.fec.gov/cgi-bin/fecimg/?21990045726	'b':2 'grace':3 'mrs':4 'terpstra':1	'associates':2 'principal':3 'tepstra':1		t	\N	2020-01-10 03:51:31.078	\N	Q	T	U
C00193383	ARKANSAS BEST CORPORATION POLITICAL ACTION COMMITTEE	\N	PRESTON, RICHARD MR.	RICHARD MR.	\N	PRESTON	\N	\N	\N	\N	VAN BUREN	AR	72956	\N	\N	ABF FREIGHT SYSTEM INC./DIRECTOR	\N	\N	\N	\N	\N	\N	2001-02-07 00:00:00	700.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21990045821	\N	3041220021023573618	\N	3061920110008150802	F3X	M3	2001	2002	http://docquery.fec.gov/cgi-bin/fecimg/?21990045821	'mr':3 'preston':1 'richard':2	'abf':1 'director':5 'freight':2 'inc':4 'system':3		t	\N	2020-01-10 03:51:31.078	\N	Q	C	U
C00193433	EMILY'S LIST	\N	ARONSON, NANCY MS.	NANCY MS.	\N	ARONSON	\N	\N	\N	\N	NEW ORLEANS	LA	70118	\N	\N	INSTITUTE OF MENTAL HYGIENE	\N	\N	\N	\N	\N	\N	2001-01-31 00:00:00	250.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21990037489	\N	3041220021023573176	\N	3061920110008167676	F3X	M2	2001	2002	http://docquery.fec.gov/cgi-bin/fecimg/?21990037489	'aronson':1 'ms':3 'nancy':2	'hygiene':4 'institute':1 'mental':3 'of':2		t	\N	2020-01-10 03:51:31.231	\N	Q		U
C00193433	EMILY'S LIST	\N	DINWIDDIE, JILL MS.	JILL MS.	\N	DINWIDDIE	\N	\N	\N	\N	ORINDA	CA	94563	\N	\N	BELVEDERE PARTNERS	\N	\N	\N	\N	\N	\N	2001-01-25 00:00:00	1000.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21990037556	\N	3041220021023573176	\N	3061920110008167701	F3X	M2	2001	2002	http://docquery.fec.gov/cgi-bin/fecimg/?21990037556	'dinwiddie':1 'jill':2 'ms':3	'belvedere':1 'partners':2		t	\N	2020-01-10 03:51:31.231	\N	Q		U
C00193433	EMILY'S LIST	\N	DUTTON, LISA MS.	LISA MS.	\N	DUTTON	\N	\N	\N	\N	PACIFIC PALISADES	CA	90272	\N	\N	DETERMIND PRODUCTIONS INC.	\N	\N	\N	\N	\N	\N	2001-01-26 00:00:00	500.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21990037560	\N	3041220021023573176	\N	3061920110008167714	F3X	M2	2001	2002	http://docquery.fec.gov/cgi-bin/fecimg/?21990037560	'dutton':1 'lisa':2 'ms':3	'determind':1 'inc':3 'productions':2		t	\N	2020-01-10 03:51:31.231	\N	Q		U
C00193631	FARM CREDIT COUNCIL POLITICAL ACTION COMMITTEE	\N	ADAMS, FRED M. MR.	FRED M. MR.	\N	ADAMS	\N	\N	\N	\N	READYVILLE	TN	37149	\N	\N	AGRIBANK/DIRECTOR	\N	\N	\N	\N	\N	\N	2001-02-01 00:00:00	300.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21990051955	\N	3041220021023573877	\N	3061920110008150879	F3X	M3	2001	2002	http://docquery.fec.gov/cgi-bin/fecimg/?21990051955	'adams':1 'fred':2 'm':3 'mr':4	'agribank':1 'director':2		t	\N	2020-01-10 03:51:31.079	\N	Q	T	U
C00193631	FARM CREDIT COUNCIL POLITICAL ACTION COMMITTEE	\N	CAVALETTO, MICHAEL J. MR.	MICHAEL J. MR.	\N	CAVALETTO	\N	\N	\N	\N	NIPOMO	CA	93444	\N	\N	CENTRAL COAST FARM CREDIT/DIRECTOR	\N	\N	\N	\N	\N	\N	2001-02-28 00:00:00	300.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21990051955	\N	3041220021023573877	\N	3061920110008150884	F3X	M3	2001	2002	http://docquery.fec.gov/cgi-bin/fecimg/?21990051955	'cavaletto':1 'j':3 'michael':2 'mr':4	'central':1 'coast':2 'credit':4 'director':5 'farm':3		t	\N	2020-01-10 03:51:31.08	\N	Q	T	U
C00193631	FARM CREDIT COUNCIL POLITICAL ACTION COMMITTEE	\N	RITTER, GILBERT E. MR.	GILBERT E. MR.	\N	RITTER	\N	\N	\N	\N	SAGINAW	MI	48601	\N	\N	GREENSTONE FCS/DIRECTOR	\N	\N	\N	\N	\N	\N	2001-02-09 00:00:00	300.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	21990051957	\N	3041220021023573877	\N	3061920110008150896	F3X	M3	2001	2002	http://docquery.fec.gov/cgi-bin/fecimg/?21990051957	'e':3 'gilbert':2 'mr':4 'ritter':1	'director':3 'fcs':2 'greenstone':1		t	\N	2020-01-10 03:51:31.081	\N	Q	T	U
\.


--
-- Data for Name: fec_fitem_sched_a_2003_2004; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_2003_2004 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00379727	\N	\N	COOPER, PETER	\N	\N	\N	\N	\N	133 STATE AVENUE	\N	EMMAUS	PA	18049	IND	INDIVIDUAL	OWNER	LEXUS OF LEIGH VALLEY	P2006	PRIMARY	2006	\N	1000.00	2004-12-20 00:00:00	1000.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	C19	\N	\N	SA	ITEMIZED RECEIPTS	11AI	26980108583	202353	4021520061064204688	\N	4021520061064240029	F3	YE	2004	2004	http://docquery.fec.gov/cgi-bin/fecimg/?26980108583	'cooper':1 'peter':2	'owner':1	'leigh':3 'lexus':1 'of':2 'valley':4	t	\N	2020-01-10 03:53:19.086	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00379727	\N	\N	ELLENBOGEN, HENRY	\N	\N	\N	\N	\N	9801 COLLINS AVENUE	\N	BAL HARBOUR	FL	33154	IND	INDIVIDUAL	INVESTMENT ANALYST	T. ROWE PRICE	P2006	PRIMARY	2006	\N	500.00	2004-12-15 00:00:00	500.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	C20	\N	\N	SA	ITEMIZED RECEIPTS	11AI	26980108583	202353	4021520061064204688	\N	4021520061064240030	F3	YE	2004	2004	http://docquery.fec.gov/cgi-bin/fecimg/?26980108583	'ellenbogen':1 'henry':2	'analyst':2 'investment':1	'price':3 'rowe':2 't':1	t	\N	2020-01-10 03:53:19.086	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00379727	\N	\N	ELLENBOGEN, LINDSAY	\N	\N	\N	\N	\N	9801 COLLINS AVENUE	\N	BAL HARBOUR	FL	33154	IND	INDIVIDUAL	DIRECTOR OF PUBLIC AFFAIRS	NOVA SOUTHEASTERN UNIVERSITY	P2006	PRIMARY	2006	\N	500.00	2004-12-15 00:00:00	500.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	C21	\N	\N	SA	ITEMIZED RECEIPTS	11AI	26980108583	202353	4021520061064204688	\N	4021520061064240031	F3	YE	2004	2004	http://docquery.fec.gov/cgi-bin/fecimg/?26980108583	'ellenbogen':1 'lindsay':2	'affairs':4 'director':1 'of':2 'public':3	'nova':1 'southeastern':2 'university':3	t	\N	2020-01-10 03:53:19.086	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00379727	\N	\N	KAPLAN, RICK	\N	\N	\N	\N	\N	6018 ANNAPOLIS	\N	HOUSTON	TX	77005	IND	INDIVIDUAL	PORTFOLIO MANAGER	LEGACY ASSET MANAGEMENT	P2006	PRIMARY	2006	\N	1000.00	2004-12-18 00:00:00	1000.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	C22	\N	\N	SA	ITEMIZED RECEIPTS	11AI	26980108584	202353	4021520061064204688	\N	4021520061064240032	F3	YE	2004	2004	http://docquery.fec.gov/cgi-bin/fecimg/?26980108584	'kaplan':1 'rick':2	'manager':2 'portfolio':1	'asset':2 'legacy':1 'management':3	t	\N	2020-01-10 03:53:19.087	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00398636	\N	H4CA19076	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2004-08-24 00:00:00	200.00	15C	CONTRIBUTION FROM CANDIDATE	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	\N	\N	24038661049	\N	1120920040000206091	\N	1122820040000208740	F3	30G	2004	2004	http://docquery.fec.gov/cgi-bin/fecimg/?24038661049	'h4ca19076':1	\N	\N	f	H4CA19076	2017-06-01 21:15:37.32543	\N	H		P
C00390120	\N	\N	PRUTSMAN, ERIC D	ERIC D	\N	PRUTSMAN	\N	\N	\N	\N	TALLAHASSEE	FL	32309	\N	\N	\N	PRUTSMAN & STAHL PA	\N	\N	\N	\N	\N	2004-01-12 00:00:00	500.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	24020320192	\N	1043020040000158506	\N	2051220041038360209	F3	Q1	2004	2004	http://docquery.fec.gov/cgi-bin/fecimg/?24020320192	'd':3 'eric':2 'prutsman':1	\N	'pa':3 'prutsman':1 'stahl':2	t	\N	2017-06-01 21:15:37.32543	\N	S		P
C00401224	\N	\N	GONCAROVS, CHARLOTTE	CHARLOTTE	\N	GONCAROVS	\N	\N	2406 KIPLING ST	\N	HOUSTON	TN	77098	IND	INDIVIDUAL	CHUCK L INC	WAITRESS	G2004	GENERAL	2004	\N	26.25	2004-10-12 00:00:00	5.00	\N	\N	EARMARK CONTRIBUTION	\N	\N	EARMARK TO: SCHRADER FOR CONGRESS	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11A1_24274	\N	\N	SA	ITEMIZED RECEIPTS	11AI	24971853529	144392	4102020041043787725	\N	4102920041044515891	F3X	12G	2004	2004	http://docquery.fec.gov/cgi-bin/fecimg/?24971853529	'charlotte':2 'goncarovs':1	'chuck':1 'inc':3 'l':2	'waitress':1	t	\N	2017-06-01 21:15:37.32543	Contributions From Individuals/Persons Other Than Political Committees	N		U
C00390369	\N	S4WI00124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2004-02-22 00:00:00	95.00	15C	CONTRIBUTION FROM CANDIDATE	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	24020253349	\N	1042320040000156572	\N	2050520041038172990	F3	Q1	2004	2004	http://docquery.fec.gov/cgi-bin/fecimg/?24020253349	's4wi00124':1	\N	\N	f	S4WI00124	2017-06-01 21:15:37.32543	\N	S		P
C00390369	\N	\N	TREDINNICK, KIM	KIM	\N	TREDINNICK	\N	\N	\N	\N	DE FOREST	WI	53532	\N	\N	\N	VIRCHOW KRAUSE	\N	\N	\N	\N	\N	2004-03-17 00:00:00	250.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	24020253328	\N	1042320040000156572	\N	2050520041038172935	F3	Q1	2004	2004	http://docquery.fec.gov/cgi-bin/fecimg/?24020253328	'kim':2 'tredinnick':1	\N	'krause':2 'virchow':1	t	\N	2017-06-01 21:15:37.32543	\N	S		P
C00390369	\N	\N	VAN DYKE, POLLY	\N	\N	\N	\N	\N	\N	\N	MILWAUKEE	WI	53217	\N	\N	\N	HOMEMAKER	\N	\N	\N	\N	\N	2004-03-15 00:00:00	250.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	\N	24020253331	\N	1042320040000156572	\N	2050520041038172942	F3	Q1	2004	2004	http://docquery.fec.gov/cgi-bin/fecimg/?24020253331	'dyke':2 'polly':3 'van':1	\N	'homemaker':1	t	\N	2017-06-01 21:15:37.32543	\N	S		P
\.


--
-- Data for Name: fec_fitem_sched_a_2005_2006; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_2005_2006 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00409409	\N	\N	ALTON, HOWARD	\N	\N	\N	\N	\N	P.O. BOX 619	\N	WAYZATA	MN	55391	IND	INDIVIDUAL	SELF	ATTORNEY	P2006	PRIMARY	2006	\N	1500.00	2005-12-18 00:00:00	500.00	15	CONTRIBUTION	DONATION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	26980142567	203427	1022720060000296588	4022020061064385223	1070820110007095789	F3	YE	2005	2006	http://docquery.fec.gov/cgi-bin/fecimg/?26980142567	'alton':1 'howard':2	'self':1	'attorney':1	t	\N	2020-01-10 03:54:45.458	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00409409	\N	\N	BARNETT, JOHN	\N	\N	\N	\N	\N	1716 JAMES CT	\N	N MANKATO	MN	56003	IND	INDIVIDUAL	RETIRED	RETIRED	P2006	PRIMARY	2006	\N	300.00	2005-12-27 00:00:00	50.00	\N	\N	DONATION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	26980142567	203427	1022720060000296588	4022020061064385224	1070820110007095790	F3	YE	2005	2006	http://docquery.fec.gov/cgi-bin/fecimg/?26980142567	'barnett':1 'john':2	'retired':1	'retired':1	t	\N	2020-01-10 03:54:45.459	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00409409	\N	\N	BELL, FORD	\N	\N	\N	\N	\N	522 HARRINGTON RD	\N	WAYZATA	MN	55391	IND	INDIVIDUAL	MINNEAPOLIS HEART INST FOUNDAT	PRESIDENT	P2006	PRIMARY	2006	\N	550.00	2005-11-12 00:00:00	300.00	15	CONTRIBUTION	DONATION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	26980142567	203427	1022720060000296588	4022020061064385225	1070820110007095791	F3	YE	2005	2006	http://docquery.fec.gov/cgi-bin/fecimg/?26980142567	'bell':1 'ford':2	'foundat':4 'heart':2 'inst':3 'minneapolis':1	'president':1	t	\N	2020-01-10 03:54:45.46	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00409409	\N	\N	BORRUD, ALETA A	\N	\N	\N	\N	\N	2411 MERRIHILLS DR SW	\N	ROCHESTER	MN	55902	IND	INDIVIDUAL	MAYO CLINIC	PHYSICIAN	P2006	PRIMARY	2006	\N	250.00	2005-10-26 00:00:00	250.00	15	CONTRIBUTION	DONATION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	26980142568	203427	1022720060000296588	4022020061064385226	1070820110007095792	F3	YE	2005	2006	http://docquery.fec.gov/cgi-bin/fecimg/?26980142568	'a':3 'aleta':2 'borrud':1	'clinic':2 'mayo':1	'physician':1	t	\N	2020-01-10 03:54:45.461	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00409409	\N	\N	BROWN, JOSEPH	\N	\N	\N	\N	\N	27667 MOWER FREEBORN RD	\N	AUSTIN	MN	55912	IND	INDIVIDUAL	AUSTIN HIGH SCHOOL	PRINCIPAL	P2006	PRIMARY	2006	\N	700.00	2005-11-11 00:00:00	100.00	\N	\N	DONATION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	26980142568	203427	1022720060000296588	4022020061064385227	1070820110007095793	F3	YE	2005	2006	http://docquery.fec.gov/cgi-bin/fecimg/?26980142568	'brown':1 'joseph':2	'austin':1 'high':2 'school':3	'principal':1	t	\N	2020-01-10 03:54:45.462	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00409409	\N	\N	DEFAUW, RUSSELL A	\N	\N	\N	\N	\N	13030 FLORIDA CT	\N	APPLE VALLEY	MN	55124	IND	INDIVIDUAL	PERFORMANCE OFFICE PAPER	PRESIDENT	P2006	PRIMARY	2006	\N	400.00	2005-12-25 00:00:00	200.00	15	CONTRIBUTION	DONATION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	26980142568	203427	1022720060000296588	4022020061064385228	1070820110007095794	F3	YE	2005	2006	http://docquery.fec.gov/cgi-bin/fecimg/?26980142568	'a':3 'defauw':1 'russell':2	'office':2 'paper':3 'performance':1	'president':1	t	\N	2020-01-10 03:54:45.463	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00409409	\N	\N	DEHARPPORTE, RONALD	\N	\N	\N	\N	\N	7021 WESTON CIRCLE	\N	MINNEAPOLIS	MN	55439	IND	INDIVIDUAL	RETIRED	RETIRED	P2006	PRIMARY	2006	\N	1000.00	2005-11-18 00:00:00	500.00	15	CONTRIBUTION	DONATION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	26980142569	203427	1022720060000296588	4022020061064385229	1070820110007095795	F3	YE	2005	2006	http://docquery.fec.gov/cgi-bin/fecimg/?26980142569	'deharpporte':1 'ronald':2	'retired':1	'retired':1	t	\N	2020-01-10 03:54:45.463	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00409409	\N	\N	DORAN, KELLY J	\N	\N	\N	\N	\N	11527 WELTERS WAY	\N	EDEN PRAIRIE	MN	55347	IND	INDIVIDUAL	SELF	REAL ESTATE DEVELOPER	P2006	PRIMARY	2006	\N	2100.00	2005-11-11 00:00:00	2100.00	15	CONTRIBUTION	DONATION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	26980142569	203427	1022720060000296588	4022020061064385230	1070820110007095796	F3	YE	2005	2006	http://docquery.fec.gov/cgi-bin/fecimg/?26980142569	'doran':1 'j':3 'kelly':2	'self':1	'developer':3 'estate':2 'real':1	t	\N	2020-01-10 03:54:45.464	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00409409	\N	\N	EGGENBERGER, TIM	\N	\N	\N	\N	\N	8 BELA VISTA COURT	\N	MANKATO	MN	56001	IND	INDIVIDUAL	BEST EFFORT	SALES	P2006	PRIMARY	2006	\N	275.00	2005-11-21 00:00:00	25.00	\N	\N	DONATION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	26980142569	203427	1022720060000296588	4022020061064385231	1070820110007095797	F3	YE	2005	2006	http://docquery.fec.gov/cgi-bin/fecimg/?26980142569	'eggenberger':1 'tim':2	'best':1 'effort':2	'sales':1	t	\N	2020-01-10 03:54:45.464	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00235036	\N	\N	PROVIS, JAMES	JAMES	\N	PROVIS	\N	\N	1400 AMERICAN LANE	TOWER 1, FLOOR 13	SCHAUMBURG	IL	60196	IND	INDIVIDUAL	ZURICH NORTH AMERICA	PORTFOLIO PROJECT TECHNICAL DIRECTO	\N	\N	\N	\N	237.50	2006-10-15 00:00:00	12.50	\N	\N	BI-WEEKLY PAYROLL DEDUCTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	1164998801068	\N	\N	SA	ITEMIZED RECEIPTS	11AI	10930566500	461378	4041520101125183856	\N	4042820101125838574	F3X	30G	2006	2006	http://docquery.fec.gov/cgi-bin/fecimg/?10930566500	'james':2 'provis':1	'america':3 'north':2 'zurich':1	'directo':4 'portfolio':1 'project':2 'technical':3	t	\N	2017-06-01 21:54:54.430635	Contributions From Individuals/Persons Other Than Political Committees	Q	C	U
\.


--
-- Data for Name: fec_fitem_sched_a_2007_2008; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_2007_2008 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00193433	\N	\N	\N	\N	\N	\N	\N	\N	22351 CHERRY HILL ST	\N	DEARBORN	MI	48124	IND	INDIVIDUAL	HENRY FORD COMMUNITY COLLEGE	INSTRUCTOR	\N	\N	\N	\N	0.00	2008-10-15 00:00:00	15.00	\N	\N	KAY HAGAN CONTRIBUTIONS	X	\N	MEMO	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	2494681	\N	\N	SA	ITEMIZED RECEIPTS	11AI	29932152674	403128	4021120091107373427	\N	4031120091110433711	F3X	12G	2008	2008	http://docquery.fec.gov/cgi-bin/fecimg/?29932152674		'college':4 'community':3 'ford':2 'henry':1	'instructor':1	t	\N	2017-06-01 19:37:11.67827	Contributions From Individuals/Persons Other Than Political Committees	Q		U
C00193433	\N	\N	KLAIMITZ, LENI MS.	LENI MS.	\N	KLAIMITZ	\N	\N	367 LOCUST AVENUE	\N	RYE	NY	10580	IND	INDIVIDUAL	SELF	ATTORNEY	\N	\N	\N	\N	0.00	2008-09-25 00:00:00	50.00	\N	\N	KAY HAGAN CONTRIBUTIONS	X	\N	MEMO	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	2473390	\N	\N	SA	ITEMIZED RECEIPTS	11AI	29933614779	415592	4042920091114302988	\N	4042920091114370569	F3X	M10	2008	2008	http://docquery.fec.gov/cgi-bin/fecimg/?29933614779	'klaimitz':1 'leni':2 'ms':3	'self':1	'attorney':1	t	\N	2017-06-01 19:37:11.67827	Contributions From Individuals/Persons Other Than Political Committees	Q		U
C00112896	\N	\N	WEBSTER, JAMES T	JAMES T	\N	WEBSTER	\N	\N	17727 SKYLINE ARBOR	\N	HOUSTON	TX	770941271	IND	INDIVIDUAL	CONOCOPHILLIPS COMPANY	MGR NGL	\N	\N	\N	\N	368.70	\N	73.74	\N	\N	\N	\N	\N	P/R DEDUCTION ($73.74 SEMI-MONTHLY)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	PR576257810926	\N	\N	SA	ITEMIZED RECEIPTS	11AI	27930838690	291681	4062020071078002024	\N	4062820071078203769	F3X	M6	2007	2008	http://docquery.fec.gov/cgi-bin/fecimg/?27930838690	'james':2 't':3 'webster':1	'company':2 'conocophillips':1	'mgr':1 'ngl':2	t	\N	2017-06-01 19:37:11.67827	Contributions From Individuals/Persons Other Than Political Committees	Q	C	U
C00140855	\N	\N	OSVATH, STEPHEN P	STEPHEN P	\N	OSVATH	\N	\N	2777 MATTHEW LANE	\N	MEDINA	OH	442560000	IND	INDIVIDUAL	FIRSTENERGY	DIR, REAL TIME SYSTEMS SU	\N	\N	\N	\N	400.00	\N	80.00	\N	\N	\N	\N	\N	P/R DEDUCTION ($40.00 WEEKLY)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	PR1084296810786	\N	\N	SA	ITEMIZED RECEIPTS	11AI	27930831418	291502	4062020071078001862	\N	4062620071078150115	F3X	M6	2007	2008	http://docquery.fec.gov/cgi-bin/fecimg/?27930831418	'osvath':1 'p':3 'stephen':2	'firstenergy':1	'dir':1 'real':2 'su':5 'systems':4 'time':3	t	\N	2017-06-01 19:37:11.67827	Contributions From Individuals/Persons Other Than Political Committees	Q	C	U
C00073155	\N	\N	BROWN, SCOTT J	SCOTT J	\N	BROWN	\N	\N	12996 MARINER COURT	\N	MC CORDSVILLE	IN	460559657	IND	INDIVIDUAL	KEYBANK NATIONAL ASSOCIATION	DISTRICT PRESIDENT II	\N	\N	\N	\N	207.70	\N	41.54	\N	\N	\N	\N	\N	P/R DEDUCTION ($20.77 BI-WEEKLY)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	PR5823791123	\N	\N	SA	ITEMIZED RECEIPTS	11AI	27930812186	290922	4061520071077967968	\N	4061520071077978208	F3X	M6	2007	2008	http://docquery.fec.gov/cgi-bin/fecimg/?27930812186	'brown':1 'j':3 'scott':2	'association':3 'keybank':1 'national':2	'district':1 'ii':3 'president':2	t	\N	2017-06-01 19:37:11.67827	Contributions From Individuals/Persons Other Than Political Committees	Q	C	U
C00078451	\N	\N	ENGEL, DEVON	DEVON	\N	ENGEL	\N	\N	7400 E. GAINEY CLUB DR. #225	\N	SCOTTSDALE	AZ	85258	IND	INDIVIDUAL	C4 SYSTEMS INC.	VP & GENERAL COUNSEL	\N	\N	\N	\N	250.00	\N	50.00	\N	\N	\N	\N	\N	P/R DEDUCTION ($25.00 BI-WEEKLY)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	PR1039178310863	\N	\N	SA	ITEMIZED RECEIPTS	11AI	27930764011	290418	4061120071077712713	\N	4061120071077751152	F3X	M6	2007	2008	http://docquery.fec.gov/cgi-bin/fecimg/?27930764011	'devon':2 'engel':1	'c4':1 'inc':3 'systems':2	'counsel':3 'general':2 'vp':1	t	\N	2017-06-01 19:37:11.67827	Contributions From Individuals/Persons Other Than Political Committees	Q	C	U
C00096156	\N	\N	CARLSON, IRENE A MS.	IRENE A MS.	\N	CARLSON	\N	\N	2015 EWING AVENUE SOUTH	\N	MINNEAPOLIS	MN	554163626	IND	INDIVIDUAL	HONEYWELL INTERNATIONAL	ASSISTANT GENERAL COUNSEL	\N	\N	\N	\N	550.00	\N	100.00	\N	\N	\N	\N	\N	P/R DEDUCTION ($50.00 BI-WEEKLY)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	PR1279456517063	\N	\N	SA	ITEMIZED RECEIPTS	11AI	27930813730	291039	4061820071077983281	\N	4061920071077994408	F3X	M6	2007	2008	http://docquery.fec.gov/cgi-bin/fecimg/?27930813730	'a':3 'carlson':1 'irene':2 'ms':4	'honeywell':1 'international':2	'assistant':1 'counsel':3 'general':2	t	\N	2017-06-01 19:37:11.67827	Contributions From Individuals/Persons Other Than Political Committees	Q	C	U
C00229203	\N	\N	TWYMAN, MICHELE E	MICHELE E	\N	TWYMAN	\N	\N	2378 APPLE RIDGE CIRCLE	\N	MANASQUAN	NJ	08736	IND	INDIVIDUAL	FEDERAL INSURANCE COMPANY	SR VICE PRESIDENT	\N	\N	\N	\N	250.00	\N	50.00	\N	\N	\N	\N	\N	P/R DEDUCTION ($25.00 SEMI-MONTHLY)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	PR1132087110879	\N	\N	SA	ITEMIZED RECEIPTS	11AI	27990154220	291017	4061820071077983241	\N	4061820071077988549	F3X	M6	2007	2008	http://docquery.fec.gov/cgi-bin/fecimg/?27990154220	'e':3 'michele':2 'twyman':1	'company':3 'federal':1 'insurance':2	'president':3 'sr':1 'vice':2	t	\N	2017-06-01 19:37:11.67827	Contributions From Individuals/Persons Other Than Political Committees	Q	C	U
C00238725	\N	\N	HUBBARD, JASON S MR.	JASON S MR.	\N	HUBBARD	\N	\N	1167 THORNBERRY COURT	\N	FLORENCE	KY	410427814	IND	INDIVIDUAL	FEDERAL AVIATION ADMINISTRATION	AIR TRAFFIC CONTROLLER	\N	\N	\N	\N	250.00	\N	100.00	\N	\N	\N	\N	\N	P/R DEDUCTION ($50.00 BI-WEEKLY)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	PR912073316653	\N	\N	SA	ITEMIZED RECEIPTS	11AI	27930351567	281838	4032020071075929096	\N	4032620071076122513	F3X	M3	2007	2008	http://docquery.fec.gov/cgi-bin/fecimg/?27930351567	'hubbard':1 'jason':2 'mr':4 's':3	'administration':3 'aviation':2 'federal':1	'air':1 'controller':3 'traffic':2	t	\N	2017-06-01 19:37:11.67827	Contributions From Individuals/Persons Other Than Political Committees	Q	L	U
C00251876	\N	\N	NELSON, KATRINA B. MS	KATRINA B. MS	\N	NELSON	\N	\N	16 GOVERNOR GLEN CT.	\N	SUNSET	SC	296851417	IND	INDIVIDUAL	AMGEN INC.	MANAGER	\N	\N	\N	\N	308.11	\N	56.92	\N	\N	\N	\N	\N	P/R DEDUCTION ($28.46 BI-WEEKLY)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	PR774467814048	\N	\N	SA	ITEMIZED RECEIPTS	11AI	28931938677	345770	4062020081090997635	\N	4070120081091618991	F3X	M6	2008	2008	http://docquery.fec.gov/cgi-bin/fecimg/?28931938677	'b':3 'katrina':2 'ms':4 'nelson':1	'amgen':1 'inc':2	'manager':1	t	\N	2017-06-01 19:37:11.67827	Contributions From Individuals/Persons Other Than Political Committees	Q	C	U
\.


--
-- Data for Name: fec_fitem_sched_a_2009_2010; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_2009_2010 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00447748	\N	\N	FOX, LISELOTTE M.	LISELOTTE M.	\N	FOX	\N	\N	26 BRENTMOOR PARK	\N	ST. LOUIS	MO	63105	IND	INDIVIDUAL	N/A	HOMEMAKER	G2008	GENERAL	2008	\N	200.00	2009-01-21 00:00:00	200.00	15	CONTRIBUTION	REATTRIBUTE: FROM JEFFREY FOX -DEBT RET.	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI.12121	\N	\N	SA	ITEMIZED RECEIPTS	11AI	29991951287	413184	4041520091113761469	\N	4042320091114136386	F3	Q1	2009	2010	http://docquery.fec.gov/cgi-bin/fecimg/?29991951287	'fox':1 'liselotte':2 'm':3	'a':2 'n':1	'homemaker':1	t	\N	2017-06-01 18:17:25.750289	Contributions From Individuals/Persons Other Than Political Committees	H		A
C00109546	\N	\N	SEILER, PAUL D	PAUL D	\N	SEILER	\N	\N	ONE VALERO PLACE	\N	SAN ANTONIO	TX	78249	IND	INDIVIDUAL	VALERO SERVICES, INC.	STAFF RELIABILITY ENGINEE	\N	\N	\N	\N	203.52	2009-04-30 00:00:00	25.44	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	INC.A.169778	\N	\N	SA	ITEMIZED RECEIPTS	11AI	29992109228	417413	4051620091114899805	\N	4051920091114931679	F3X	M5	2009	2010	http://docquery.fec.gov/cgi-bin/fecimg/?29992109228	'd':3 'paul':2 'seiler':1	'inc':3 'services':2 'valero':1	'enginee':3 'reliability':2 'staff':1	t	\N	2017-06-01 18:17:25.750289	Contributions From Individuals/Persons Other Than Political Committees	Q	C	B
C00009936	\N	\N	SANDERSON, VERNON MR.	VERNON MR.	\N	SANDERSON	\N	\N	112 SUNIMER LANE, APT 4	\N	SPARTA	WI	546561061	IND	INDIVIDUAL	DEPARTMENT OF ARMY	TRAINING INSTRUCTOR	\N	\N	\N	\N	340.00	2009-08-31 00:00:00	40.00	\N	\N	\N	\N	\N	P/R DEDUCTION ($20.00 BI-WEEKLY)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	PR569991022825	\N	\N	SA	ITEMIZED RECEIPTS	11AI	29992800170	432529	4091820091118182012	\N	4092920091118589200	F3X	M9	2009	2010	http://docquery.fec.gov/cgi-bin/fecimg/?29992800170	'mr':3 'sanderson':1 'vernon':2	'army':3 'department':1 'of':2	'instructor':2 'training':1	t	\N	2017-06-01 18:17:25.750289	Contributions From Individuals/Persons Other Than Political Committees	Q	L	U
C00040535	\N	\N	KING, MARIANNE	MARIANNE	\N	KING	\N	\N	WORLD FINANCIAL CENTER	200 VESEY ST.	NEW YORK	NY	10285	IND	INDIVIDUAL	AMEX TRAVEL RELATED SERVICES	VP-GLOBAL SECURITY OPS	\N	\N	\N	\N	346.14	2009-08-28 00:00:00	19.23	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	A2009-4181717	\N	\N	SA	ITEMIZED RECEIPTS	11AI	29934526838	432625	4091820091118182105	\N	4092920091118602058	F3X	M9	2009	2010	http://docquery.fec.gov/cgi-bin/fecimg/?29934526838	'king':1 'marianne':2	'amex':1 'related':3 'services':4 'travel':2	'global':2 'ops':4 'security':3 'vp':1	t	\N	2017-06-01 18:17:25.750289	Contributions From Individuals/Persons Other Than Political Committees	Q	C	B
C00195891	\N	C00195891	GREGORY, HEIDI	HEIDI	\N	GREGORY	\N	\N	99 GARNSEY ROAD	\N	PITTSFORD	NY	14534	IND	INDIVIDUAL	\N	\N	\N	\N	\N	\N	2.00	2009-01-01 00:00:00	2.00	\N	\N	\N	X	\N	MEMO	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	29030113729	429379	1092120090001064043	2081720091117482478	1092120090001064098	F3X	MY	2009	2010	http://docquery.fec.gov/cgi-bin/fecimg/?29030113729	'gregory':1 'heidi':2	\N	\N	t	\N	2017-06-01 18:17:25.750289	Contributions From Individuals/Persons Other Than Political Committees	Q		U
C00197228	\N	\N	STEINMEYER, HEATHER	HEATHER	\N	STEINMEYER	\N	\N	1958 NORTH SHEFFIELD	\N	CHICAGO	IL	606144291	IND	INDIVIDUAL	THE WELLPOINT COMPANIES, INC.	COUNSEL EXECUTIVE SENIOR	\N	\N	\N	\N	272.92	2009-04-17 00:00:00	34.89	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	041409-1523	\N	\N	SA	ITEMIZED RECEIPTS	11AI	29933751067	417233	4051420091114873312	\N	4051520091114892491	F3X	M5	2009	2010	http://docquery.fec.gov/cgi-bin/fecimg/?29933751067	'heather':2 'steinmeyer':1	'companies':3 'inc':4 'the':1 'wellpoint':2	'counsel':1 'executive':2 'senior':3	t	\N	2017-06-01 18:17:25.750289	Contributions From Individuals/Persons Other Than Political Committees	Q	C	B
C00235739	\N	\N	DEVINE, MICHAEL E	MICHAEL E	\N	DEVINE	\N	\N	15409 LANDING CREEK LN	\N	ROANOKE	TX	762623348	IND	INDIVIDUAL	BNSF CORPORATION	DIR ECONOMIC DEVELOPMENT	\N	\N	\N	\N	825.28	2009-08-20 00:00:00	51.58	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	A2009-4146592	\N	\N	SA	ITEMIZED RECEIPTS	11AI	29934525386	432614	4091820091118182094	\N	4092920091118597240	F3X	M9	2009	2010	http://docquery.fec.gov/cgi-bin/fecimg/?29934525386	'devine':1 'e':3 'michael':2	'bnsf':1 'corporation':2	'development':3 'dir':1 'economic':2	t	\N	2017-06-01 18:17:25.750289	Contributions From Individuals/Persons Other Than Political Committees	Q	C	B
C00142711	\N	\N	DAVIS, JO	JO	\N	DAVIS	\N	\N	512 N. MCCLURG CT.	710	CHICAGO	IL	60611	IND	INDIVIDUAL	BOEING	VP-EXECUTIVE COMMUNICATIONS	\N	\N	\N	\N	986.00	2009-08-20 00:00:00	58.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	2009082100001241	\N	\N	SA	ITEMIZED RECEIPTS	11AI	29992822172	432753	4091820091118182229	\N	4092920091118632881	F3X	M9	2009	2010	http://docquery.fec.gov/cgi-bin/fecimg/?29992822172	'davis':1 'jo':2	'boeing':1	'communications':3 'executive':2 'vp':1	t	\N	2017-06-01 18:17:25.750289	Contributions From Individuals/Persons Other Than Political Committees	Q	C	B
C00271007	\N	\N	REYNOLDS, DAVID T.	DAVID T.	\N	REYNOLDS	\N	\N	1100 CHESTNUT ST	\N	DEERFIELD	IL	60015	IND	INDIVIDUAL	HUMANA, INC.	MARKET VP, PRACTICE LEADER	\N	\N	\N	\N	297.50	2009-08-21 00:00:00	17.66	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	20090825-662-14-47	\N	\N	SA	ITEMIZED RECEIPTS	11AI	29992802236	432561	4091820091118182042	\N	4092920091118591185	F3X	M9	2009	2010	http://docquery.fec.gov/cgi-bin/fecimg/?29992802236	'david':2 'reynolds':1 't':3	'humana':1 'inc':2	'leader':4 'market':1 'practice':3 'vp':2	t	\N	2017-06-01 18:17:25.750289	Contributions From Individuals/Persons Other Than Political Committees	Q	C	B
C00003418	\N	\N	BOWLING, MICHAEL MR.	MICHAEL MR.	\N	BOWLING	\N	\N	7908 JESSIES WAY	APARTMENT 301	HAMILTON	OH	450117720	IND	INDIVIDUAL	MOUNTAIN TORP A. WASTE QUJ CO.	SALES/ MANAGEMENT	\N	\N	\N	\N	270.00	2009-06-09 00:00:00	50.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	2009M07L11AI05667	\N	\N	SA	ITEMIZED RECEIPTS	11AI	10990095188	446058	4012120101122557399	\N	4012120101122567655	F3X	M7	2009	2010	http://docquery.fec.gov/cgi-bin/fecimg/?10990095188	'bowling':1 'michael':2 'mr':3	'a':3 'co':6 'mountain':1 'quj':5 'torp':2 'waste':4	'management':2 'sales':1	t	\N	2017-06-01 18:17:25.750289	Contributions From Individuals/Persons Other Than Political Committees	Y		U
\.


--
-- Data for Name: fec_fitem_sched_a_2011_2012; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_2011_2012 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00496331	\N	\N	GUSTAFSON, LOREN J	LOREN	J	GUSTAFSON	\N	\N	837 12TH AVE	\N	HELENA	MT	59601	IND	INDIVIDUAL	OUR REDEEMER LUTHERAN CHURCH	RELIGOUS LEADER	\N	\N	\N	\N	100.00	2012-08-16 00:00:00	100.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	C165	\N	\N	SA	ITEMIZED RECEIPTS	11AI	12954384284	817345	4101520121167231251	\N	4102620121168590814	F3X	Q3	2012	2012	http://docquery.fec.gov/cgi-bin/fecimg/?12954384284	'gustafson':1 'j':3 'loren':2	'church':4 'lutheran':3 'our':1 'redeemer':2	'leader':2 'religous':1	t	\N	2017-05-31 16:34:24.288921	Contributions From Individuals/Persons Other Than Political Committees	N		J
C00498980	\N	\N	BEACH, DAN	DAN	\N	BEACH	\N	\N	8717 WYTHMERE LN	\N	ORLANDO	FL	328352514	IND	INDIVIDUAL	SELF	DESIGNER	G2012	GENERAL	2012	\N	750.00	2012-09-20 00:00:00	100.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	C4469992	\N	\N	SA	ITEMIZED RECEIPTS	11AI	12972652951	818259	4101620121167309541	\N	4102220121167743230	F3	Q3	2012	2012	http://docquery.fec.gov/cgi-bin/fecimg/?12972652951	'beach':1 'dan':2	'self':1	'designer':1	t	\N	2017-05-31 16:34:24.288921	Contributions From Individuals/Persons Other Than Political Committees	H		P
C00509356	\N	\N	EVELYN, ROBERT MR.	ROBERT	\N	EVELYN	MR.	\N	117 EAGLE LANDING DRIVE	\N	BELTON	TX	76513	IND	INDIVIDUAL	MMC CORP	PRESIDENT	\N	\N	\N	\N	400.00	2012-04-13 00:00:00	50.00	\N	\N	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	C	CHANGE	SA11AI.4408	\N	\N	SA	ITEMIZED RECEIPTS	11AI	12972570485	817617	4101520121167231406	\N	4103120121168887372	F3X	Q2	2012	2012	http://docquery.fec.gov/cgi-bin/fecimg/?12972570485	'evelyn':1 'mr':3 'robert':2	'corp':2 'mmc':1	'president':1	t	\N	2017-05-31 16:34:24.288921	Contributions From Individuals/Persons Other Than Political Committees	Q	C	U
C00401224	\N	\N	SUSS, ALYCE	ALYCE	\N	SUSS	\N	\N	1183 ALTA MESA	\N	MORAGA	CA	94556	IND	INDIVIDUAL	NONE	NOT EMPLOYED	\N	\N	\N	\N	1.67	2012-08-12 00:00:00	1.67	\N	\N	EARMARK	\N	\N	EARMARKED FOR FRIENDS OF MAZIE HIRONO (C00420760)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI_6589886	\N	\N	SA	ITEMIZED RECEIPTS	11AI	12953545307	811524	4092220121164818754	\N	4100520121166469892	F3X	M9	2012	2012	http://docquery.fec.gov/cgi-bin/fecimg/?12953545307	'alyce':2 'suss':1	'none':1	'employed':2 'not':1	t	\N	2017-05-31 16:34:24.288921	Contributions From Individuals/Persons Other Than Political Committees	W		U
C00401224	\N	\N	BRABANK, KEVIN	KEVIN	\N	BRABANK	\N	\N	509 N SULLIVAN RD	\N	SPOKANE VALLEY	WA	99037	IND	INDIVIDUAL	BOROUGE PRIVATE LIMITED	SUPPLY CHAIN PROFESSIONAL	\N	\N	\N	\N	50.00	2012-08-17 00:00:00	10.00	\N	\N	EARMARK	\N	\N	EARMARKED FOR DEMOCRACY FOR AMERICA (C00370007)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI_6662947	\N	\N	SA	ITEMIZED RECEIPTS	11AI	12953423319	811524	4092220121164818754	\N	4100520121166103927	F3X	M9	2012	2012	http://docquery.fec.gov/cgi-bin/fecimg/?12953423319	'brabank':1 'kevin':2	'borouge':1 'limited':3 'private':2	'chain':2 'professional':3 'supply':1	t	\N	2017-05-31 16:34:24.288921	Contributions From Individuals/Persons Other Than Political Committees	W		U
C00401224	\N	\N	CLEE, SUZANNE	SUZANNE	\N	CLEE	\N	\N	7520 CRITTENDEN ST.	\N	PHILADELPHIA	PA	19119	IND	INDIVIDUAL	LENOX CORP	DESIGNER	\N	\N	\N	\N	1.71	2012-08-22 00:00:00	1.71	\N	\N	EARMARK	\N	\N	EARMARKED FOR FRIENDS OF MAZIE HIRONO (C00420760)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI_6719534	\N	\N	SA	ITEMIZED RECEIPTS	11AI	12953433658	811524	4092220121164818754	\N	4100520121166134946	F3X	M9	2012	2012	http://docquery.fec.gov/cgi-bin/fecimg/?12953433658	'clee':1 'suzanne':2	'corp':2 'lenox':1	'designer':1	t	\N	2017-05-31 16:34:24.288921	Contributions From Individuals/Persons Other Than Political Committees	W		U
C00401224	\N	\N	BERGER, STEPHANIE	STEPHANIE	\N	BERGER	\N	\N	2012 W. SAINT PAUL #205	\N	CHICAGO	IL	00000	IND	INDIVIDUAL	SELF EMPLOYED	INDEPENDENT INTERNET MARKETING CONSULT	\N	\N	\N	\N	5.00	2012-08-31 00:00:00	5.00	\N	\N	EARMARK	\N	\N	EARMARKED FOR ELIZABETH FOR MA, INC. (C00500843)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI_6939397	\N	\N	SA	ITEMIZED RECEIPTS	11AI	12953419082	811524	4092220121164818754	\N	4100520121166091218	F3X	M9	2012	2012	http://docquery.fec.gov/cgi-bin/fecimg/?12953419082	'berger':1 'stephanie':2	'employed':2 'self':1	'consult':4 'independent':1 'internet':2 'marketing':3	t	\N	2017-05-31 16:34:24.288921	Contributions From Individuals/Persons Other Than Political Committees	W		U
C00401224	\N	\N	GARZA, ALICIA	ALICIA	\N	GARZA	\N	\N	6517 N. 22ND ST	\N	MCALLEN	TX	78504	IND	INDIVIDUAL	CASEMANAGEMENT SOLUTIONS	MEDICAL CASE MANAGER	G2012	GENERAL	2012	\N	106.00	2012-10-31 00:00:00	15.00	\N	\N	EARMARK	\N	\N	EARMARKED FOR DEMOCRATIC CONGRESSIONAL CAMPAIGN COMMITTEE (C00000935)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI_9699084	\N	\N	SA	ITEMIZED RECEIPTS	11AI	12963134020	841241	4121220121174555632	\N	4021220131181538580	F3X	30G	2012	2012	http://docquery.fec.gov/cgi-bin/fecimg/?12963134020	'alicia':2 'garza':1	'casemanagement':1 'solutions':2	'case':2 'manager':3 'medical':1	t	\N	2017-05-31 16:34:24.288921	Contributions From Individuals/Persons Other Than Political Committees	W		U
C00401224	\N	\N	MARLER, SHEILA	SHEILA	\N	MARLER	\N	\N	10905 S. 215TH AVE.	\N	BUCKEYE	AZ	85326	IND	INDIVIDUAL	SELF	POTTER/WRITER	\N	\N	\N	\N	16.00	2012-08-22 00:00:00	15.00	\N	\N	EARMARK	\N	\N	EARMARKED FOR KUSTER FOR CONGRESS (C00462861)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI_6741431	\N	\N	SA	ITEMIZED RECEIPTS	11AI	12953496499	811524	4092220121164818754	\N	4100520121166323469	F3X	M9	2012	2012	http://docquery.fec.gov/cgi-bin/fecimg/?12953496499	'marler':1 'sheila':2	'self':1	'potter':1 'writer':2	t	\N	2017-05-31 16:34:24.288921	Contributions From Individuals/Persons Other Than Political Committees	W		U
C00401224	\N	\N	MARIN, CAROL	CAROL	\N	MARIN	\N	\N	1 IRVING PLACE APT PPHA	\N	NEW YORK	NY	10003	IND	INDIVIDUAL	NONE	NOT EMPLOYED	\N	\N	\N	\N	5.00	2012-08-29 00:00:00	5.00	\N	\N	CONTRIBUTION TO ACT BLUE	\N	\N	CONTRIBUTION TO ACTBLUE	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI_6863262	\N	\N	SA	ITEMIZED RECEIPTS	11AI	12953496306	811524	4092220121164818754	\N	4100520121166322890	F3X	M9	2012	2012	http://docquery.fec.gov/cgi-bin/fecimg/?12953496306	'carol':2 'marin':1	'none':1	'employed':2 'not':1	t	\N	2017-05-31 16:34:24.288921	Contributions From Individuals/Persons Other Than Political Committees	W		U
\.


--
-- Data for Name: fec_fitem_sched_a_2013_2014; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_2013_2014 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00024372	\N	\N	ALLEN, CHARLES F.	CHARLES	F.	ALLEN	\N	\N	11 BAYONNE COURT	\N	LITTLE ROCK	AR	72223	IND	INDIVIDUAL	N/A	NOT EMPLOYED	P	PRIMARY	\N	\N	875.00	2013-05-15 00:00:00	875.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	C	CHANGE	11AI-000025904	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201804309111737645	1228214	4043020181530616268	\N	4050120181533370662	F3X	M6	2013	2014	http://docquery.fec.gov/cgi-bin/fecimg/?201804309111737645	'allen':1 'charles':2 'f':3	'a':2 'n':1	'employed':2 'not':1	t	\N	2018-05-02 02:40:11.88	Contributions From Individuals/Persons Other Than Political Committees	Y		U
C00024372	\N	\N	ALLEN, ANNE	ANNE	\N	ALLEN	\N	\N	11 BAYONNE COURT	\N	LITTLE ROCK	AR	72223	IND	INDIVIDUAL	N/A	NOT EMPLOYED	P	PRIMARY	\N	\N	875.00	2013-05-15 00:00:00	875.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	C	CHANGE	11AI-000025905	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201804309111737646	1228214	4043020181530616268	\N	4050120181533370663	F3X	M6	2013	2014	http://docquery.fec.gov/cgi-bin/fecimg/?201804309111737646	'allen':1 'anne':2	'a':2 'n':1	'employed':2 'not':1	t	\N	2018-05-02 02:40:11.88	Contributions From Individuals/Persons Other Than Political Committees	Y		U
C00024372	\N	\N	JOYCE, SHERRY A.	SHERRY	A.	JOYCE	\N	\N	\N	\N	\N	\N	\N	IND	INDIVIDUAL	\N	\N	P	PRIMARY	\N	\N	250.00	2013-05-28 00:00:00	250.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	C	CHANGE	11AI-000025914	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201804309111737650	1228214	4043020181530616268	\N	4050120181533370676	F3X	M6	2013	2014	http://docquery.fec.gov/cgi-bin/fecimg/?201804309111737650	'a':3 'joyce':1 'sherry':2	\N	\N	t	\N	2018-05-02 02:40:11.887	Contributions From Individuals/Persons Other Than Political Committees	Y		U
C00024372	\N	\N	BAKER, JIM	JIM	\N	BAKER	\N	\N	2521 ROBINSON AVENUE	\N	CONWAY	AR	720344948	IND	INDIVIDUAL	NATIONAL BANK OF ARK	BANKER	\N	\N	\N	\N	210.00	2013-06-26 00:00:00	60.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	11AI-000026002	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201805029111745295	1228539	4050220181533393535	\N	4050220181533455080	F3X	M7	2013	2014	http://docquery.fec.gov/cgi-bin/fecimg/?201805029111745295	'baker':1 'jim':2	'ark':4 'bank':2 'national':1 'of':3	'banker':1	t	\N	2018-05-03 02:42:40.782	Contributions From Individuals/Persons Other Than Political Committees	Y		U
C00024372	\N	\N	SCHULTZ, SAM MR.	SAM	\N	SCHULTZ	\N	MR.	1106 GOLD COURSE DR	\N	SEARCY	AR	721434568	IND	INDIVIDUAL	\N	\N	\N	\N	\N	\N	190.00	2013-06-28 00:00:00	190.00	\N	\N	\N	X	\N	AR PARTY VICTORY FUND	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	C	CHANGE	11AI-000026076	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201805029111745300	1228539	4050220181533393535	\N	4050220181533455096	F3X	M7	2013	2014	http://docquery.fec.gov/cgi-bin/fecimg/?201805029111745300	'mr':3 'sam':2 'schultz':1	\N	\N	t	\N	2018-05-03 02:42:40.786	Contributions From Individuals/Persons Other Than Political Committees	Y		U
C00024372	\N	\N	MCINTOSH, BEVERLY M.	BEVERLY	M.	MCINTOSH	\N	\N	12615 ST. CHARLES BLVD	\N	LITTLE ROCK	AR	72211	IND	INDIVIDUAL	N/A	NOT EMPLOYED	P	PRIMARY	\N	\N	481.50	2013-10-30 00:00:00	62.50	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	C	CHANGE	11AI-000026186	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201805029111745903	1228571	4050220181533393548	\N	4050220181533455180	F3X	M11	2013	2014	http://docquery.fec.gov/cgi-bin/fecimg/?201805029111745903	'beverly':2 'm':3 'mcintosh':1	'a':2 'n':1	'employed':2 'not':1	t	\N	2018-05-03 02:42:40.809	Contributions From Individuals/Persons Other Than Political Committees	Y		U
C00000935	\N	\N	COLYER, CLIFF	CLIFF	\N	COLYER	\N	\N	1700 MEADOWLARK WAY	\N	ROSEVILLE	CA	95661	IND	INDIVIDUAL	SELF-EMPLOYED	BUILDER	\N	\N	\N	\N	550.00	2014-07-25 00:00:00	100.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	C13741607	\N	\N	SA	ITEMIZED RECEIPTS	11AI	14970695803	947180	4082120141220982937	\N	4082520141221129600	F3X	M8	2014	2014	http://docquery.fec.gov/cgi-bin/fecimg/?14970695803	'cliff':2 'colyer':1	'employed':2 'self':1	'builder':1	t	\N	2017-05-31 17:34:02.953375	Contributions From Individuals/Persons Other Than Political Committees	Y		U
C00000885	\N	\N	ARLEQUIN, EDWIN	EDWIN	\N	ARLEQUIN	\N	\N	696 LEE STREET	\N	PERTH AMBOY	NJ	088612429	IND	INDIVIDUAL	IUPAT	CRAFTSMAN	\N	\N	\N	\N	309.28	2013-08-06 00:00:00	2.18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	36328215	\N	\N	SA	ITEMIZED RECEIPTS	11AI	13941611906	888605	4092020131197207777	\N	4092520131197318529	F3X	M9	2013	2014	http://docquery.fec.gov/cgi-bin/fecimg/?13941611906	'arlequin':1 'edwin':2	'iupat':1	'craftsman':1	t	\N	2017-05-31 17:34:02.953375	Contributions From Individuals/Persons Other Than Political Committees	Q	L	B
C00024372	\N	C00420919	PEAK PAC	\N	\N	\N	\N	\N	PO BOX 48004	\N	DENVER	CO	48004	PAC	POLITICAL ACTION COMMITTEE	\N	\N	P	PRIMARY	\N	\N	5000.00	2013-12-12 00:00:00	5000.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	PEAK PAC	\N	\N	N	NO CHANGE	11C-000026213	\N	\N	SA	ITEMIZED RECEIPTS	11C	201805049111755774	1229142	4050420181536577683	\N	4050420181536612473	F3X	YE	2013	2014	http://docquery.fec.gov/cgi-bin/fecimg/?201805049111755774	'c00420919':3 'pac':2 'peak':1	\N	\N	f	C00420919	2018-05-05 02:41:36.49	Contributions From Other Political Committees	Y		U
C00024372	\N	\N	FREDERICK LOVE CAMPAIGN	\N	\N	\N	\N	\N	PO BOX 4963	\N	LITTLE ROCK	AR	72214	CCM	CAMPAIGN COMMITTEE	\N	\N	\N	\N	\N	\N	200.00	2014-02-27 00:00:00	100.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	00	\N	\N	\N	\N	\N	\N	\N	FREDERICK LOVE CAMPAIGN	\N	\N	N	NO CHANGE	11C-000026295	\N	\N	SA	ITEMIZED RECEIPTS	11C	201805079111991862	1229515	4050720181539868784	\N	4050720181539898431	F3X	M3	2014	2014	http://docquery.fec.gov/cgi-bin/fecimg/?201805079111991862	'campaign':3 'frederick':1 'love':2	\N	\N	f	\N	2018-05-08 02:40:49.127	Contributions From Other Political Committees	Y		U
\.


--
-- Data for Name: fec_fitem_sched_a_2015_2016; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_2015_2016 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00560847	\N	\N	ACT BLUE	\N	\N	\N	\N	\N	P.O. BOX 441146	\N	SOMERVILLE,	MA	02144	ORG	ORGANIZATION	\N	\N	G2016	GENERAL	2016	\N	1215.68	2016-04-03 00:00:00	12.51	\N	\N	11 DONATIONS	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	SA11AI.6150	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201907159150855769	1340302	4071520191659541104	\N	4071620191659587170	F3	Q2	2016	2016	http://docquery.fec.gov/cgi-bin/fecimg/?201907159150855769	'act':1 'blue':2	\N	\N	t	\N	2019-07-17 03:41:32.806	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00560847	\N	\N	ACT BLUE	\N	\N	\N	\N	\N	P.O. BOX 441146	\N	SOMERVILLE,	MA	02144	ORG	ORGANIZATION	\N	\N	G2016	GENERAL	2016	\N	1283.49	2016-04-10 00:00:00	67.81	\N	\N	32 /DONORS CONTRIBUTED A TOTAL OF $67.81	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	SA11AI.6598	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201907159150855769	1340302	4071520191659541104	\N	4071620191659587172	F3	Q2	2016	2016	http://docquery.fec.gov/cgi-bin/fecimg/?201907159150855769	'act':1 'blue':2	\N	\N	t	\N	2019-07-17 03:41:32.807	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00560847	\N	\N	ACT BLUE	\N	\N	\N	\N	\N	P.O. BOX 441146	\N	SOMERVILLE,	MA	02144	ORG	ORGANIZATION	\N	\N	G2016	GENERAL	2016	\N	1318.53	2016-04-17 00:00:00	35.04	\N	\N	23 DONORS CONTRIBUTED A TOTAL OF $35.04	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	SA11AI.6217	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201907159150855769	1340302	4071520191659541104	\N	4071620191659587174	F3	Q2	2016	2016	http://docquery.fec.gov/cgi-bin/fecimg/?201907159150855769	'act':1 'blue':2	\N	\N	t	\N	2019-07-17 03:41:32.808	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00035451	\N	\N	WILLIAMS, ARTHUR J III	ARTHUR	J	WILLIAMS	\N	III	972 THOUSAND OAKS BEND NW	\N	KENNESAW	GA	301522896	IND	INDIVIDUAL	DELTA AIR LINES	AIRLINE PILOT	P	PRIMARY	\N	\N	500.34	2015-12-21 00:00:00	249.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	13786699	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201601199004526067	1040773	4011920161260655734	\N	4012020161260698973	F3X	YE	2015	2016	http://docquery.fec.gov/cgi-bin/fecimg/?201601199004526067	'arthur':2 'iii':4 'j':3 'williams':1	'air':2 'delta':1 'lines':3	'airline':1 'pilot':2	t	\N	2017-05-31 13:27:14.31838	Contributions From Individuals/Persons Other Than Political Committees	Q	L	B
C00548420	\N	\N	BURCHETT, VERA M. MRS	VERA	M.	BURCHETT	MRS	\N	1819 BIRCHWOOD STREET	\N	AURORA	NE	688181410	IND	INDIVIDUAL	RETIRED	RETIRED	\N	\N	\N	\N	424.00	2015-01-07 00:00:00	106.00	10	NON-FEDERAL RECEIPT FROM PERSONS	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	SA11.148320	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201601149004489920	1039724	4011420161260574338	\N	4011420161260598973	F3X	MY	2015	2016	http://docquery.fec.gov/cgi-bin/fecimg/?201601149004489920	'burchett':1 'm':3 'mrs':4 'vera':2	'retired':1	'retired':1	t	\N	2017-05-31 13:27:14.31838	Contributions From Individuals/Persons Other Than Political Committees	O		U
C00582221	\N	C00401224	SALAZAR, GERM?N	GERM?N	\N	SALAZAR	\N	\N	9448 N 80TH PL	\N	SCOTTSDALE	AZ	852581733	IND	INDIVIDUAL	AMERIFIRST FINANCIAL, INC.	ATTORNEY	P2016	PRIMARY	2016	\N	250.00	2015-12-21 00:00:00	250.00	15E	EARMARKED CONTRIBUTION	\N	\N	\N	* EARMARKED CONTRIBUTION: SEE BELOW	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	VR09SEN58Z4	VR09SEN58Z4E	SA11AI	SA	ITEMIZED RECEIPTS	11AI	201601269004610962	1042417	4012620161260874262	\N	4012620161260888431	F3	YE	2015	2016	http://docquery.fec.gov/cgi-bin/fecimg/?201601269004610962	'c00401224':4 'germ':2 'n':3 'salazar':1	'amerifirst':1 'financial':2 'inc':3	'attorney':1	t	C00401224	2017-05-31 13:27:14.31838	Contributions From Individuals/Persons Other Than Political Committees	H		P
C00479873	\N	\N	JOLLEY, AMY	AMY	\N	JOLLEY	\N	\N	18 BRYWOOD PL	\N	THE WOODLANDS	TX	77382	IND	INDIVIDUAL	NOBLE ENERGY, INC.	VICE PRESIDENT - TAX	\N	\N	\N	\N	1300.00	2015-08-07 00:00:00	50.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	A630607FD3E24D2C9BEE	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201601099004445874	1038664	4010920161260460950	\N	4011120161260465546	F3X	YE	2015	2016	http://docquery.fec.gov/cgi-bin/fecimg/?201601099004445874	'amy':2 'jolley':1	'energy':2 'inc':3 'noble':1	'president':2 'tax':3 'vice':1	t	\N	2017-05-31 13:27:14.31838	Contributions From Individuals/Persons Other Than Political Committees	Q	C	B
C00233361	\N	\N	KRICK, KEVIN MR.	KEVIN	\N	KRICK	MR.	\N	236 MARINDA DRIVE	\N	FAIRFAX	CA	949301106	IND	INDIVIDUAL	MATSON	DIRECTOR	\N	\N	\N	\N	360.00	2015-12-01 00:00:00	20.00	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	109-4951-C	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201601179004512542	1040323	4011820161260655001	\N	4011920161260664259	F3X	YE	2015	2016	http://docquery.fec.gov/cgi-bin/fecimg/?201601179004512542	'kevin':2 'krick':1 'mr':3	'matson':1	'director':1	t	\N	2017-05-31 13:27:14.31838	Contributions From Individuals/Persons Other Than Political Committees	Y		U
C00162818	\N	\N	KEEBLER, DANIEL	DANIEL	\N	KEEBLER	\N	\N	1719 SPRING GARDEN STREET	\N	PHILADELPHIA	PA	191303915	IND	INDIVIDUAL	ELECTRICIANS LOCAL 98	ENGINEER	P	PRIMARY	\N	\N	1406.30	2015-10-26 00:00:00	202.26	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	AC401FE38095B4953B6E	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201601259004582673	1041918	4012520161260810632	\N	4012520161260852103	F3X	YE	2015	2016	http://docquery.fec.gov/cgi-bin/fecimg/?201601259004582673	'daniel':2 'keebler':1	'98':3 'electricians':1 'local':2	'engineer':1	t	\N	2017-05-31 13:27:14.31838	Contributions From Individuals/Persons Other Than Political Committees	Q	L	U
C00227546	\N	\N	BASILICO, JAMES S. III	JAMES	S.	BASILICO	\N	III	25 SUMMERHILL AVE	\N	JACKSON	NJ	085274366	IND	INDIVIDUAL	MICROSOFT	ACCT TECH STRATEGIST	\N	\N	\N	\N	240.00	2015-12-31 00:00:00	10.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	201512246382-458	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201601299004738656	1044609	4012920161261115083	\N	4012920161261256574	F3X	YE	2015	2016	http://docquery.fec.gov/cgi-bin/fecimg/?201601299004738656	'basilico':1 'iii':4 'james':2 's':3	'microsoft':1	'acct':1 'strategist':3 'tech':2	t	\N	2017-05-31 13:27:14.31838	Contributions From Individuals/Persons Other Than Political Committees	Q	C	B
\.


--
-- Data for Name: fec_fitem_sched_a_2017_2018; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_2017_2018 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00658450	\N	\N	ASSYRIAN AMERICAN CIVIC CLUB OF CHICAGO	\N	\N	\N	\N	\N	PO BOX 59446	\N	CHICAGO	IL	60659	\N	\N	\N	\N	P2018	PRIMARY	2018	\N	500.00	2017-12-31 00:00:00	500.00	\N	\N	\N	\N	\N	IN-KIND	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201901290300257921	1313111	1012920190037429019	\N	2021020191638927573	F3	YE	2017	2018	http://docquery.fec.gov/cgi-bin/fecimg/?201901290300257921	'american':2 'assyrian':1 'chicago':6 'civic':3 'club':4 'of':5	\N	\N	f	\N	2019-07-19 03:41:58.2	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00658450	\N	\N	BUTROS, HORMIS	HORMIS	\N	BUTROS	\N	\N	700 AMBLESIDE RD	\N	DES PLAINES	IL	60016	IND	INDIVIDUAL	SHOW ME SOLUTIONS, INC.	COMPUTER ENGINEER & SOFTWARE DEVELOPM	P2018	PRIMARY	2018	\N	1000.00	2017-12-25 00:00:00	1000.00	15	CONTRIBUTION	\N	\N	\N	IN-KIND - WEB DESIGN	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201901290300257921	1313111	1012920190037429019	\N	2021020191638927574	F3	YE	2017	2018	http://docquery.fec.gov/cgi-bin/fecimg/?201901290300257921	'butros':1 'hormis':2	'inc':4 'me':2 'show':1 'solutions':3	'computer':1 'developm':4 'engineer':2 'software':3	t	\N	2019-07-19 03:41:58.201	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00658450	\N	\N	DOOMAN, FREDERICK	FREDERICK	\N	DOOMAN	\N	\N	18410 KESWICK STREET UNIT 3	UNIT 3	RESEDA	CA	91335	IND	INDIVIDUAL	ASSYRIAN REALITY TV	FILM PRODUCER	P2018	PRIMARY	2018	\N	1500.00	2017-12-25 00:00:00	1500.00	15	CONTRIBUTION	\N	\N	\N	IN-KIND - VIDEO PRODUCTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201901290300257921	1313111	1012920190037429019	\N	2021020191638927575	F3	YE	2017	2018	http://docquery.fec.gov/cgi-bin/fecimg/?201901290300257921	'dooman':1 'frederick':2	'assyrian':1 'reality':2 'tv':3	'film':1 'producer':2	t	\N	2019-07-19 03:41:58.202	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00658450	\N	\N	FRYE, EDEN	EDEN	\N	FRYE	\N	\N	15 TOWER HILL RD	\N	BRIMFIELD	MA	01010	IND	INDIVIDUAL	RETIRED	RETIRED	P2018	PRIMARY	2018	\N	500.00	2017-12-17 00:00:00	500.00	15	CONTRIBUTION	\N	\N	\N	EDEN FRYE	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201901290300257922	1313111	1012920190037429019	\N	2021020191638927576	F3	YE	2017	2018	http://docquery.fec.gov/cgi-bin/fecimg/?201901290300257922	'eden':2 'frye':1	'retired':1	'retired':1	t	\N	2019-07-19 03:41:58.203	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00658450	\N	\N	HAJI, FLORA	FLORA	\N	HAJI	\N	\N	20 CUMBERLAND DR	\N	SCHAMBURG	IL	60194	IND	INDIVIDUAL	CHARLES SCHWAB	BUSINESS ANALYST	P2018	PRIMARY	2018	\N	1000.00	2017-11-09 00:00:00	1000.00	15	CONTRIBUTION	\N	\N	\N	FLORA HAJI	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201901290300257922	1313111	1012920190037429019	\N	2021020191638927577	F3	YE	2017	2018	http://docquery.fec.gov/cgi-bin/fecimg/?201901290300257922	'flora':2 'haji':1	'charles':1 'schwab':2	'analyst':2 'business':1	t	\N	2019-07-19 03:41:58.204	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00658450	\N	\N	JOHN, MARINO J JR	MARINO	J	JOHN	\N	JR	10427 HASKELL AVE	\N	GRANADA HILLS	CA	91344	IND	INDIVIDUAL	RETIRED	FILMMAKER/RADIO HOST	P2018	PRIMARY	2018	\N	500.00	2017-12-15 00:00:00	500.00	15	CONTRIBUTION	\N	\N	\N	IN KIND - VOICE OVER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201901290300257922	1313111	1012920190037429019	\N	2021020191638927578	F3	YE	2017	2018	http://docquery.fec.gov/cgi-bin/fecimg/?201901290300257922	'j':3 'john':1 'jr':4 'marino':2	'retired':1	'filmmaker':1 'host':3 'radio':2	t	\N	2019-07-19 03:41:58.205	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00658450	\N	\N	JONES, JACKIE	JACKIE	\N	JONES	\N	\N	PO BOX 145	\N	OXFORD	MA	38655	IND	INDIVIDUAL	TRUTH PR	MEDIA PR	P2018	PRIMARY	2018	\N	500.00	2017-12-22 00:00:00	500.00	15	CONTRIBUTION	\N	\N	\N	IN-KIND - MEDIA PR	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201901290300257923	1313111	1012920190037429019	\N	2021020191638927579	F3	YE	2017	2018	http://docquery.fec.gov/cgi-bin/fecimg/?201901290300257923	'jackie':2 'jones':1	'pr':2 'truth':1	'media':1 'pr':2	t	\N	2019-07-19 03:41:58.206	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00658450	\N	\N	LAZZAR, TONY S	TONY	S	LAZZAR	\N	\N	8432 WEST BETTY TERRACE	\N	NILES	IL	60714	IND	INDIVIDUAL	TONY LAZZAR INSURANCE AGENCY	INSURANCE AGENT	P2018	PRIMARY	2018	\N	1000.00	2017-12-31 00:00:00	1000.00	15	CONTRIBUTION	\N	\N	\N	IN-KIND	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201901290300257923	1313111	1012920190037429019	\N	2021020191638927580	F3	YE	2017	2018	http://docquery.fec.gov/cgi-bin/fecimg/?201901290300257923	'lazzar':1 's':3 'tony':2	'agency':4 'insurance':3 'lazzar':2 'tony':1	'agent':2 'insurance':1	t	\N	2019-07-19 03:41:58.207	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00658450	\N	\N	MARAGOLUF, GEORGE	GEORGE	\N	MARAGOLUF	\N	\N	8445 LURLINE AVE	\N	WINNETKA	CA	91306	IND	INDIVIDUAL	ASSYRIA TODAY NETWORK	PRODUCER	P2018	PRIMARY	2018	\N	1300.00	2017-12-29 00:00:00	1300.00	15	CONTRIBUTION	\N	\N	\N	IN-KIND VEDIO PRODUCER	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201901290300257923	1313111	1012920190037429019	\N	2021020191638927581	F3	YE	2017	2018	http://docquery.fec.gov/cgi-bin/fecimg/?201901290300257923	'george':2 'maragoluf':1	'assyria':1 'network':3 'today':2	'producer':1	t	\N	2019-07-19 03:41:58.208	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
C00658450	\N	\N	MCINTOSH, WILLIAM GERARD	WILLIAM	GERARD	MCINTOSH	\N	\N	4415 SW 88TH AVENUE	\N	MIAMI	FL	33165	IND	INDIVIDUAL	OCASOMEDIA	DIRECTOR	P2018	PRIMARY	2018	\N	450.00	2017-12-05 00:00:00	450.00	15	CONTRIBUTION	\N	\N	\N	IN-KIND - DIRECTOR	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	\N	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201901290300257924	1313111	1012920190037429019	\N	2021020191638927582	F3	YE	2017	2018	http://docquery.fec.gov/cgi-bin/fecimg/?201901290300257924	'gerard':3 'mcintosh':1 'william':2	'ocasomedia':1	'director':1	t	\N	2019-07-19 03:41:58.209	Contributions From Individuals/Persons Other Than Political Committees	H	\N	P
\.


--
-- Data for Name: fec_fitem_sched_a_2019_2020; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_2019_2020 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00692319	\N	C00401224	STEWART, TRAVIS	TRAVIS	\N	STEWART	\N	\N	11808 OTSEGO ST	\N	VALLEY VILLAGE	CA	916073223	IND	INDIVIDUAL	THE DRAVIS AGENCY	OWNER	P	PRIMARY	\N	\N	900.00	2019-05-28 00:00:00	100.00	15E	EARMARKED CONTRIBUTION	\N	\N	\N	* EARMARKED CONTRIBUTION: SEE BELOW	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	VVC4BKXQ0K1	VVC4BKXQ0K1E	SA11AI	SA	ITEMIZED RECEIPTS	11AI	201907269151676208	1344083	4072620191661328249	\N	4080120191662667940	F3X	MY	2019	2020	http://docquery.fec.gov/cgi-bin/fecimg/?201907269151676208	'c00401224':3 'stewart':1 'travis':2	'agency':3 'dravis':2 'the':1	'owner':1	t	C00401224	2019-08-02 04:10:59.278	Contributions From Individuals/Persons Other Than Political Committees	W		U
C00692319	\N	C00401224	ACTBLUE	\N	\N	\N	\N	\N	PO BOX 441146	\N	WEST SOMERVILLE	MA	021440031	PAC	POLITICAL ACTION COMMITTEE	\N	CONDUIT TOTAL LISTED IN AGG. FIELD	\N	\N	\N	\N	333613.24	2019-05-31 00:00:00	100.00	\N	\N	\N	X	\N	NOTE: ABOVE CONTRIBUTION EARMARKED THROUGH THIS ORGANIZATION.	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ACTBLUE	\N	\N	A	ADD	VVC4BKXQ0K1E	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201907269151676208	1344083	4072620191661328249	\N	4080120191662667941	F3X	MY	2019	2020	http://docquery.fec.gov/cgi-bin/fecimg/?201907269151676208	'actblue':1 'c00401224':2		'agg':5 'conduit':1 'field':6 'in':4 'listed':3 'total':2	f	C00401224	2019-08-02 04:10:59.278	Contributions From Individuals/Persons Other Than Political Committees	W		U
C00692319	\N	C00401224	STEWART, TRAVIS	TRAVIS	\N	STEWART	\N	\N	11808 OTSEGO ST	\N	VALLEY VILLAGE	CA	916073223	IND	INDIVIDUAL	THE DRAVIS AGENCY	OWNER	P	PRIMARY	\N	\N	900.00	2019-06-28 00:00:00	100.00	15E	EARMARKED CONTRIBUTION	\N	\N	\N	* EARMARKED CONTRIBUTION: SEE BELOW	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	VVC4BN927A3	VVC4BN927A3E	SA11AI	SA	ITEMIZED RECEIPTS	11AI	201907269151676209	1344083	4072620191661328249	\N	4080120191662667942	F3X	MY	2019	2020	http://docquery.fec.gov/cgi-bin/fecimg/?201907269151676209	'c00401224':3 'stewart':1 'travis':2	'agency':3 'dravis':2 'the':1	'owner':1	t	C00401224	2019-08-02 04:10:59.278	Contributions From Individuals/Persons Other Than Political Committees	W		U
C00692319	\N	C00401224	ACTBLUE	\N	\N	\N	\N	\N	PO BOX 441146	\N	WEST SOMERVILLE	MA	021440031	PAC	POLITICAL ACTION COMMITTEE	\N	CONDUIT TOTAL LISTED IN AGG. FIELD	\N	\N	\N	\N	333613.24	2019-06-30 00:00:00	100.00	\N	\N	\N	X	\N	NOTE: ABOVE CONTRIBUTION EARMARKED THROUGH THIS ORGANIZATION.	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ACTBLUE	\N	\N	A	ADD	VVC4BN927A3E	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201907269151676209	1344083	4072620191661328249	\N	4080120191662667943	F3X	MY	2019	2020	http://docquery.fec.gov/cgi-bin/fecimg/?201907269151676209	'actblue':1 'c00401224':2		'agg':5 'conduit':1 'field':6 'in':4 'listed':3 'total':2	f	C00401224	2019-08-02 04:10:59.278	Contributions From Individuals/Persons Other Than Political Committees	W		U
C00692319	\N	C00401224	SULSAR, KIMBERLY	KIMBERLY	\N	SULSAR	\N	\N	2500 WINGED FOOT RD	\N	BRENTWOOD	CA	945134628	IND	INDIVIDUAL	IRAHETA BROS	VP OF OPERATIONS	P	PRIMARY	\N	\N	548.34	2019-01-20 00:00:00	50.00	15E	EARMARKED CONTRIBUTION	\N	\N	\N	* EARMARKED CONTRIBUTION: SEE BELOW	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	VVC4BHPSSV9	VVC4BHPSSV9E	SA11AI	SA	ITEMIZED RECEIPTS	11AI	201907269151676209	1344083	4072620191661328249	\N	4080120191662667944	F3X	MY	2019	2020	http://docquery.fec.gov/cgi-bin/fecimg/?201907269151676209	'c00401224':3 'kimberly':2 'sulsar':1	'bros':2 'iraheta':1	'of':2 'operations':3 'vp':1	t	C00401224	2019-08-02 04:10:59.278	Contributions From Individuals/Persons Other Than Political Committees	W		U
C00638478	\N	\N	STEVENS, RICHARD	RICHARD	\N	STEVENS	\N	\N	22011 BIRDS EYE DR	\N	DIAMOND BAR	CA	917653902	IND	INDIVIDUAL	NOT EMPLOYED	NOT EMPLOYED	P2018	PRIMARY	2018	\N	219.98	2019-01-25 00:00:00	-50.00	15	CONTRIBUTION	\N	\N	\N	CHECK LOST	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	3703278	\N	\N	SA	ITEMIZED RECEIPTS	11AI	201901289144040158	1307800	4012820191636898705	\N	4021220191639267645	F3	TER	2019	2020	http://docquery.fec.gov/cgi-bin/fecimg/?201901289144040158	'richard':2 'stevens':1	'employed':2 'not':1	'employed':2 'not':1	t	\N	2019-02-13 04:57:34.185	Contributions From Individuals/Persons Other Than Political Committees	H		P
C00638478	\N	\N	JANOWICZ, PHILIP	PHILIP	\N	JANOWICZ	\N	\N	19 SYCAMORE LN	\N	BUENA PARK	CA	906211685	CAN	CANDIDATE	FRIENDS OF PHIL JANOWICZ	CANDIDATE	P2018	PRIMARY	2018	\N	181104.03	2019-01-28 00:00:00	33000.00	15C	CONTRIBUTION FROM CANDIDATE	\N	\N	\N	CONVERTING PRIMARY LOAN TO CONTRIBUTION	H8CA39133	JANOWICZ, PHILIP	PHILIP	\N	JANOWICZ	\N	\N	H	HOUSE	CA	CALIFORNIA	39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	3703296	\N	\N	SA	ITEMIZED RECEIPTS	11D	201901289144040160	1307800	4012820191636898705	\N	4021220191639267649	F3	TER	2019	2020	http://docquery.fec.gov/cgi-bin/fecimg/?201901289144040160	'janowicz':1 'philip':2	'friends':1 'janowicz':4 'of':2 'phil':3	'candidate':1	f	\N	2019-02-13 04:57:34.19	Contributions From the Candidate	H		P
C00638478	\N	\N	JANOWICZ, PHILIP	PHILIP	\N	JANOWICZ	\N	\N	19 SYCAMORE LN	\N	BUENA PARK	CA	906211685	CAN	CANDIDATE	FRIENDS OF PHIL JANOWICZ	CANDIDATE	P2018	PRIMARY	2018	\N	181104.03	2019-01-28 00:00:00	35000.00	15C	CONTRIBUTION FROM CANDIDATE	\N	\N	\N	CONVERTING PRIMARY LOAN TO CONTRIBUTION	H8CA39133	JANOWICZ, PHILIP	PHILIP	\N	JANOWICZ	\N	\N	H	HOUSE	CA	CALIFORNIA	39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	3703295	\N	\N	SA	ITEMIZED RECEIPTS	11D	201901289144040159	1307800	4012820191636898705	\N	4021220191639267648	F3	TER	2019	2020	http://docquery.fec.gov/cgi-bin/fecimg/?201901289144040159	'janowicz':1 'philip':2	'friends':1 'janowicz':4 'of':2 'phil':3	'candidate':1	f	\N	2019-02-13 04:57:34.189	Contributions From the Candidate	H		P
C00638478	\N	\N	JANOWICZ, PHILIP	PHILIP	\N	JANOWICZ	\N	\N	19 SYCAMORE LN	\N	BUENA PARK	CA	906211685	CAN	CANDIDATE	FRIENDS OF PHIL JANOWICZ	CANDIDATE	P2018	PRIMARY	2018	\N	181104.03	2019-01-28 00:00:00	50000.00	15C	CONTRIBUTION FROM CANDIDATE	\N	\N	\N	CONVERTING PRIMARY LOAN TO CONTRIBUTION	H8CA39133	JANOWICZ, PHILIP	PHILIP	\N	JANOWICZ	\N	\N	H	HOUSE	CA	CALIFORNIA	39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	3703294	\N	\N	SA	ITEMIZED RECEIPTS	11D	201901289144040159	1307800	4012820191636898705	\N	4021220191639267647	F3	TER	2019	2020	http://docquery.fec.gov/cgi-bin/fecimg/?201901289144040159	'janowicz':1 'philip':2	'friends':1 'janowicz':4 'of':2 'phil':3	'candidate':1	f	\N	2019-02-13 04:57:34.188	Contributions From the Candidate	H		P
C00638478	\N	\N	JANOWICZ, PHILIP	PHILIP	\N	JANOWICZ	\N	\N	19 SYCAMORE LN	\N	BUENA PARK	CA	906211685	CAN	CANDIDATE	FRIENDS OF PHIL JANOWICZ	CANDIDATE	P2018	PRIMARY	2018	\N	181104.03	2019-01-28 00:00:00	59816.95	15C	CONTRIBUTION FROM CANDIDATE	\N	\N	\N	CONVERTING PRIMARY LOAN TO CONTRIBUTION	H8CA39133	JANOWICZ, PHILIP	PHILIP	\N	JANOWICZ	\N	\N	H	HOUSE	CA	CALIFORNIA	39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	3703293	\N	\N	SA	ITEMIZED RECEIPTS	11D	201901289144040159	1307800	4012820191636898705	\N	4021220191639267646	F3	TER	2019	2020	http://docquery.fec.gov/cgi-bin/fecimg/?201901289144040159	'janowicz':1 'philip':2	'friends':1 'janowicz':4 'of':2 'phil':3	'candidate':1	f	\N	2019-02-13 04:57:34.186	Contributions From the Candidate	H		P
\.


--
-- Data for Name: fec_fitem_sched_a_2021_2022; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_2021_2022 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00762229	\N	C00401224	CAREY, JAMES	JAMES	\N	CAREY	\N	\N	614 LOVEVILLE RD	APT E3H	HOCKESSIN	DE	197071618	IND	INDIVIDUAL	NOT EMPLOYED	NOT EMPLOYED	P	PRIMARY	\N	\N	500.00	2021-01-02 00:00:00	500.00	15E	EARMARKED CONTRIBUTION	\N	\N	\N	* EARMARKED CONTRIBUTION: SEE BELOW	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	28601729	28601729E	SA11AI	SA	ITEMIZED RECEIPTS	11AI	202101119398332326	1486476	4011120212068200200	\N	4011120212068257656	F3X	TER	2021	2022	https://docquery.fec.gov/cgi-bin/fecimg/?202101119398332326	'c00401224':3 'carey':1 'james':2	'employed':2 'not':1	'employed':2 'not':1	t	C00401224	2021-01-12 05:12:44.136	Contributions From Individuals/Persons Other Than Political Committees	N	\N	J
C00762229	\N	C00401224	ACTBLUE	\N	\N	\N	\N	\N	PO BOX 441146	\N	WEST SOMERVILLE	MA	021440031	PAC	POLITICAL ACTION COMMITTEE	\N	CONDUIT TOTAL LISTED IN AGG. FIELD	\N	\N	\N	\N	2744.05	2021-01-03 00:00:00	500.00	\N	\N	\N	X	\N	NOTE: ABOVE CONTRIBUTION EARMARKED THROUGH THIS ORGANIZATION.	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ACTBLUE	\N	\N	A	ADD	28601729E	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202101119398332326	1486476	4011120212068200200	\N	4011120212068257657	F3X	TER	2021	2022	https://docquery.fec.gov/cgi-bin/fecimg/?202101119398332326	'actblue':1 'c00401224':2		'agg':5 'conduit':1 'field':6 'in':4 'listed':3 'total':2	f	C00401224	2021-01-12 05:12:44.138	Contributions From Individuals/Persons Other Than Political Committees	N	\N	J
C00762229	\N	C00401224	OBICI, SILVANA	SILVANA	\N	OBICI	\N	\N	2602 EVE ANN DR	\N	PORT JEFFERSON STATION	NY	117764286	IND	INDIVIDUAL	STONY BROOK	PHYSICIAN	P	PRIMARY	\N	\N	250.00	2021-01-04 00:00:00	250.00	15E	EARMARKED CONTRIBUTION	\N	\N	\N	* EARMARKED CONTRIBUTION: SEE BELOW	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	28601863	28601863E	SA11AI	SA	ITEMIZED RECEIPTS	11AI	202101119398332326	1486476	4011120212068200200	\N	4011120212068257658	F3X	TER	2021	2022	https://docquery.fec.gov/cgi-bin/fecimg/?202101119398332326	'c00401224':3 'obici':1 'silvana':2	'brook':2 'stony':1	'physician':1	t	C00401224	2021-01-12 05:12:44.139	Contributions From Individuals/Persons Other Than Political Committees	N	\N	J
C00762229	\N	C00401224	ACTBLUE	\N	\N	\N	\N	\N	PO BOX 441146	\N	WEST SOMERVILLE	MA	021440031	PAC	POLITICAL ACTION COMMITTEE	\N	CONDUIT TOTAL LISTED IN AGG. FIELD	\N	\N	\N	\N	2744.05	2021-01-04 00:00:00	250.00	\N	\N	\N	X	\N	NOTE: ABOVE CONTRIBUTION EARMARKED THROUGH THIS ORGANIZATION.	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ACTBLUE	\N	\N	A	ADD	28601863E	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202101119398332327	1486476	4011120212068200200	\N	4011120212068257659	F3X	TER	2021	2022	https://docquery.fec.gov/cgi-bin/fecimg/?202101119398332327	'actblue':1 'c00401224':2		'agg':5 'conduit':1 'field':6 'in':4 'listed':3 'total':2	f	C00401224	2021-01-12 05:12:44.14	Contributions From Individuals/Persons Other Than Political Committees	N	\N	J
C00762229	\N	\N	ACTBLUE TECHNICAL SERVICES	\N	\N	\N	\N	\N	366 SUMMER ST	\N	SOMERVILLE	MA	021443132	ORG	ORGANIZATION	\N	\N	\N	\N	\N	\N	223.40	2021-01-04 00:00:00	223.40	\N	\N	\N	\N	\N	SERVICE FEE REFUND	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	28612710	\N	\N	SA	ITEMIZED RECEIPTS	15	202101119398332328	1486476	4011120212068200200	\N	4011120212068257660	F3X	TER	2021	2022	https://docquery.fec.gov/cgi-bin/fecimg/?202101119398332328	'actblue':1 'services':3 'technical':2			f	\N	2021-01-12 05:12:44.141	Offsets To Operating Expenditures 	N	\N	J
C00762229	\N	\N	ACTBLUE TECHNICAL SERVICES	\N	\N	\N	\N	\N	366 SUMMER ST	\N	SOMERVILLE	MA	021443132	ORG	ORGANIZATION	\N	\N	\N	\N	\N	\N	232.46	2021-01-08 00:00:00	9.06	\N	\N	\N	\N	\N	SERVICE FEE REFUND	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	28612625	\N	\N	SA	ITEMIZED RECEIPTS	15	202101119398332328	1486476	4011120212068200200	\N	4011120212068257661	F3X	TER	2021	2022	https://docquery.fec.gov/cgi-bin/fecimg/?202101119398332328	'actblue':1 'services':3 'technical':2			f	\N	2021-01-12 05:12:44.142	Offsets To Operating Expenditures 	N	\N	J
C00755959	\N	\N	PENNINGTON, CRAIG	CRAIG	\N	PENNINGTON	\N	\N	16635 SE SUNRIDGE LN	\N	MILWAUKIE	OR	97267	IND	INDIVIDUAL	COHERENT SYSTEMS	SOFTWARE DEVELOPER	P	PRIMARY	\N	\N	4040.00	2020-12-01 00:00:00	200.00	15	CONTRIBUTION	TRANSFER FROM PERSONAL ACCOUNT	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI.4153	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202101189405154256	1488610	4011920212093790154	\N	4011920212093805100	F3X	TER	2021	2022	https://docquery.fec.gov/cgi-bin/fecimg/?202101189405154256	'craig':2 'pennington':1	'coherent':1 'systems':2	'developer':2 'software':1	t	\N	2021-01-20 04:11:22.728	Contributions From Individuals/Persons Other Than Political Committees	V	\N	U
C00739177	\N	\N	ROTH, RICHARD	RICHARD	\N	ROTH	\N	\N	29 LEE ROAD	\N	SOUTH DEERFIELD	MA	01373	IND	INDIVIDUAL	SELF-EMPLOYED	ATTORNEY (RETIRED)	G2020	GENERAL	2020	\N	2000.00	2021-01-02 00:00:00	1000.00	15	CONTRIBUTION	2020 GENERAL DEBT RETIREMENT CONTRIBUTION EARMARKED THROUGH WINRED	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI.9976	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202101189405153211	1488559	4011820212093766186	\N	4012020212093845032	F3	TER	2021	2022	https://docquery.fec.gov/cgi-bin/fecimg/?202101189405153211	'richard':2 'roth':1	'employed':2 'self':1	'attorney':1 'retired':2	t	\N	2021-01-21 05:41:44.96	Contributions From Individuals/Persons Other Than Political Committees	S	\N	P
C00401224	\N	\N	DELIA, MILLINGTON	MILLINGTON	\N	DELIA	\N	\N	21BARNEY RD	\N	BRACKNEY	PA	18812	IND	INDIVIDUAL	NOT EMPLOYED	NOT EMPLOYED	\N	\N	\N	\N	75.00	2021-09-12 00:00:00	5.00	\N	\N	EARMARK	\N	\N	EARMARKED FOR VAL DEMINGS FOR US SENATE (C00590489)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\r	\N	A	ADD	SA11AI_407478191	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202205149503970545	1594564	4051620221486556094	\N	4061520221507094940	F3X	YE	2021	2022	https://docquery.fec.gov/cgi-bin/fecimg/?202205149503970545	'delia':1 'millington':2	'employed':2 'not':1	'employed':2 'not':1	t	\N	2022-06-17 08:24:25.579	Contributions From Individuals/Persons Other Than Political Committees	V	\N	U
C00401224	\N	\N	PIERCEY, JOAN	JOAN	\N	PIERCEY	\N	\N	1917 STONINGTON PL	\N	LAS VEGAS	NV	891082487	IND	INDIVIDUAL	NOT EMPLOYED	NOT EMPLOYED	\N	\N	\N	\N	25.00	2021-09-12 00:00:00	5.00	\N	\N	EARMARK	\N	\N	EARMARKED FOR CATHERINE CORTEZ MASTO FOR SENATE (C00575548)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\r	\N	A	ADD	SA11AI_407478192	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202205149506558301	1594564	4051620221486556094	\N	4061520221507094941	F3X	YE	2021	2022	https://docquery.fec.gov/cgi-bin/fecimg/?202205149506558301	'joan':2 'piercey':1	'employed':2 'not':1	'employed':2 'not':1	t	\N	2022-06-17 08:24:25.579	Contributions From Individuals/Persons Other Than Political Committees	V	\N	U
\.


--
-- Data for Name: fec_fitem_sched_a_2023_2024; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_2023_2024 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00794438	\N	\N	THE NEW MEDIA FIRM, INC.	\N	\N	\N	\N	\N	1730 RHODE ISLAND AVE NW	STE 213	WASHINGTON	DC	200363118	ORG	ORGANIZATION	\N	\N	P2022	PRIMARY	2022	\N	4553.74	2023-01-09 00:00:00	18.20	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	6027041	\N	\N	SA	ITEMIZED RECEIPTS	14	202302079578188618	1687878	4020820231723363011	\N	4020820231723427767	F3	TER	2023	2024	https://docquery.fec.gov/cgi-bin/fecimg/?202302079578188618	'firm':4 'inc':5 'media':3 'new':2 'the':1			f	\N	2023-02-09 04:24:18	Offsets to Operating Expenditures	H		P
C00872127	\N	\N	AMERICAN PROSPERITY ALLIANCE	\N	\N	\N	\N	\N	1900 CAMPUS COMMONS DR.	SUITE 100	RESTON	VA	20191	ORG	ORGANIZATION	\N	\N	P	PRIMARY	\N	\N	15000.00	2024-03-11 00:00:00	15000.00	10	NON-FEDERAL RECEIPT FROM PERSONS	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI.4100	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202404159632846945	1775645	4041520241895755116	\N	4050620241921723657	F3X	Q1	2024	2024	https://docquery.fec.gov/cgi-bin/fecimg/?202404159632846945	'alliance':3 'american':1 'prosperity':2			t	\N	2024-05-07 04:06:24	Contributions From Individuals/Persons Other Than Political Committees	O		U
C00728311	\N	\N	WASHBURN, AMY IRENE MS.	AMY IRENE MS.	\N	WASHBURN	\N	\N	2921 S. 17TH STREET	\N	SHEBOYGAN	WI	53081	CAN	CANDIDATE	NONE	RETIRED ATTORNEY	P2024	PRIMARY	2024	\N	290.00	2024-05-06 00:00:00	90.00	16C	LOANS RECEIVED FROM THE CANDIDATE	LOAN	\N	\N	\N	H0WI06194	WASHBURN, AMY IRENE MS.	AMY IRENE MS.	\N	WASHBURN	\N	\N	H	HOUSE	WI	WISCONSIN	06	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	SA13A.4401	\N	\N	SA	ITEMIZED RECEIPTS	13A	202407309665760191	1806973	4073020241980448023	\N	4073020241981088909	F3	Q2	2024	2024	https://docquery.fec.gov/cgi-bin/fecimg/?202407309665760191	'amy':2 'irene':3 'ms':4 'washburn':1	'none':1	'attorney':2 'retired':1	f	\N	2024-07-31 04:06:20	Loans Received from the Candidate	H		P
C00728311	\N	\N	THE WATERS	\N	\N	\N	\N	\N	1393 WASHINGTON AVE	\N	OSHKOSH	WI	54901	ORG	ORGANIZATION	\N	\N	P2024	PRIMARY	2024	\N	500.00	2024-02-13 00:00:00	500.00	\N	\N	REFUND OF SECURITY DEPOSIT FOR FUNDRAISING EVENT	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA15.4271	\N	\N	SA	ITEMIZED RECEIPTS	15	202404159627817206	1773701	4041520241895746518	\N	4042420241911293046	F3	Q1	2024	2024	https://docquery.fec.gov/cgi-bin/fecimg/?202404159627817206	'the':1 'waters':2			f	\N	2024-04-25 04:07:04	Total Amount of Other Receipts	H		P
C00728311	\N	\N	WASHBURN, AMY IRENE MS.	AMY IRENE MS.	\N	WASHBURN	\N	\N	2921 S. 17TH STREET	\N	SHEBOYGAN	WI	53081	CAN	CANDIDATE	NONE	RETIRED ATTORNEY	P2024	PRIMARY	2024	\N	1290.00	2024-05-15 00:00:00	1000.00	16C	LOANS RECEIVED FROM THE CANDIDATE	LOAN	\N	\N	\N	H0WI06194	WASHBURN, AMY IRENE MS.	AMY IRENE MS.	\N	WASHBURN	\N	\N	H	HOUSE	WI	WISCONSIN	06	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	N	NO CHANGE	SA13A.4403	\N	\N	SA	ITEMIZED RECEIPTS	13A	202407309665760191	1806973	4073020241980448023	\N	4073020241981088910	F3	Q2	2024	2024	https://docquery.fec.gov/cgi-bin/fecimg/?202407309665760191	'amy':2 'irene':3 'ms':4 'washburn':1	'none':1	'attorney':2 'retired':1	f	\N	2024-07-31 04:06:20	Loans Received from the Candidate	H		P
C00806752	\N	\N	STEEL, DIANE	DIANE	\N	STEEL	\N	\N	829 MCAFEE CT.	\N	LAS VEGAS	NV	89110	CAN	CANDIDATE	NONE	RETIRED	P2022	PRIMARY	2022	\N	7709.08	2022-06-30 00:00:00	7709.08	15	CONTRIBUTION	CONTRIBUTION	\N	\N	\N	\N	STEEL, DIANE	DIANE	\N	STEEL	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI.4337	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202211189546828121	1661961	4111820221630246001	\N	4120820221633698139	F3	TER	2023	2024	https://docquery.fec.gov/cgi-bin/fecimg/?202211189546828121	'diane':2 'steel':1	'none':1	'retired':1	t	\N	2022-12-09 04:04:55	Contributions From Individuals/Persons Other Than Political Committees	H		P
C00806752	\N	\N	LAUB, BILL	BILL	\N	LAUB	\N	\N	1000 RANCHO CIRCLE	\N	LAS VEGAS	NV	89107	IND	INDIVIDUAL	NONE	RETIRED	P2022	PRIMARY	2022	\N	480.30	2022-04-11 00:00:00	480.30	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI.4326	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202211189546828120	1661961	4111820221630246001	\N	4120820221633698138	F3	TER	2023	2024	https://docquery.fec.gov/cgi-bin/fecimg/?202211189546828120	'bill':2 'laub':1	'none':1	'retired':1	t	\N	2022-12-09 04:04:55	Contributions From Individuals/Persons Other Than Political Committees	H		P
C00806752	\N	\N	JENNIFER HENRY	\N	\N	\N	\N	\N	250 WHITLY AVE.	\N	LAS VEGAS	NV	89148	ORG	ORGANIZATION	\N	\N	P2022	PRIMARY	2022	\N	350.00	2022-04-10 00:00:00	350.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI.4282	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202211189546828120	1661961	4111820221630246001	\N	4120820221633698137	F3	TER	2023	2024	https://docquery.fec.gov/cgi-bin/fecimg/?202211189546828120	'henry':2 'jennifer':1			t	\N	2022-12-09 04:04:55	Contributions From Individuals/Persons Other Than Political Committees	H		P
C00806752	\N	\N	AURELIA ARNOLD ROBERTS	\N	\N	\N	\N	\N	711 RANCHO CIRCLE	\N	LAS VEGAS	NV	89107	ORG	ORGANIZATION	\N	\N	P2022	PRIMARY	2022	\N	580.00	2022-04-05 00:00:00	580.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI.4276	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202211189546828120	1661961	4111820221630246001	\N	4120820221633698136	F3	TER	2023	2024	https://docquery.fec.gov/cgi-bin/fecimg/?202211189546828120	'arnold':2 'aurelia':1 'roberts':3			t	\N	2022-12-09 04:04:55	Contributions From Individuals/Persons Other Than Political Committees	H		P
C00325993	\N	\N	ALABAMA DEPARTMENT OF REVENUE	\N	\N	\N	\N	\N	PO BOX 327430	\N	MONTGOMERY	AL	36132	ORG	ORGANIZATION	\N	\N	\N	\N	\N	\N	644.85	2023-08-25 00:00:00	644.85	\N	\N	REFUND OVERPAYMENT OF TAXES	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	A8891100230284671B14	\N	\N	SA	ITEMIZED RECEIPTS	15	202309199597118292	1725922	4091920231802391252	\N	4092020231802523007	F3X	M9	2023	2024	https://docquery.fec.gov/cgi-bin/fecimg/?202309199597118292	'alabama':1 'department':2 'of':3 'revenue':4			f	\N	2023-09-21 04:06:17	Offsets To Operating Expenditures 	Q		D
\.


--
-- Data for Name: fec_fitem_sched_a_2025_2026; Type: TABLE DATA; Schema: disclosure; Owner: -
--

COPY disclosure.fec_fitem_sched_a_2025_2026 (cmte_id, cmte_nm, contbr_id, contbr_nm, contbr_nm_first, contbr_m_nm, contbr_nm_last, contbr_prefix, contbr_suffix, contbr_st1, contbr_st2, contbr_city, contbr_st, contbr_zip, entity_tp, entity_tp_desc, contbr_employer, contbr_occupation, election_tp, fec_election_tp_desc, fec_election_yr, election_tp_desc, contb_aggregate_ytd, contb_receipt_dt, contb_receipt_amt, receipt_tp, receipt_tp_desc, receipt_desc, memo_cd, memo_cd_desc, memo_text, cand_id, cand_nm, cand_nm_first, cand_m_nm, cand_nm_last, cand_prefix, cand_suffix, cand_office, cand_office_desc, cand_office_st, cand_office_st_desc, cand_office_district, conduit_cmte_id, conduit_cmte_nm, conduit_cmte_st1, conduit_cmte_st2, conduit_cmte_city, conduit_cmte_st, conduit_cmte_zip, donor_cmte_nm, national_cmte_nonfed_acct, increased_limit, action_cd, action_cd_desc, tran_id, back_ref_tran_id, back_ref_sched_nm, schedule_type, schedule_type_desc, line_num, image_num, file_num, link_id, orig_sub_id, sub_id, filing_form, rpt_tp, rpt_yr, two_year_transaction_period, pdf_url, contributor_name_text, contributor_employer_text, contributor_occupation_text, is_individual, clean_contbr_id, pg_date, line_number_label, cmte_tp, org_tp, cmte_dsgn) FROM stdin;
C00859249	\N	\N	REGISTRAR RECORDS / COUNTY CLERK VENTURA COUNTY	\N	\N	\N	\N	\N	800 SOUTH VICTORIA AVE	\N	VENTURA	CA	93009	ORG	ORGANIZATION	\N	\N	P2024	PRIMARY	2024	\N	4529.12	2024-04-26 00:00:00	4529.12	\N	\N	REFUND OF CANDIDATE STATEMENT FEES	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA14.4212	\N	\N	SA	ITEMIZED RECEIPTS	14	202407249665720091	1805730	4072420241978639007	\N	4080620242011102787	F3	TER	2025	2026	https://docquery.fec.gov/cgi-bin/fecimg/?202407249665720091	'clerk':4 'county':3,6 'records':2 'registrar':1 'ventura':5			f	\N	2024-08-07 04:14:31	Offsets to Operating Expenditures	H		P
C00785634	\N	\N	CHAI, AMY FOGELSTROM DR AMY	AMY FOGELSTROM DR	AMY	CHAI	\N	\N	144 BLUE HILLS ROAD	\N	NORTH HAVEN	CT	06473	CAN	CANDIDATE	STATE OF CT	MEDICAL DIRECTOR	P2028	PRIMARY	2028	\N	700.00	2025-01-07 00:00:00	700.00	15C	CONTRIBUTION FROM CANDIDATE	COVER EXPENSES	\N	\N	\N	H2CT03102	CHAI, AMY FOGELSTROM DR AMY	AMY FOGELSTROM DR	AMY	CHAI	\N	\N	H	HOUSE	CT	CONNECTICUT	03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11D.4109	\N	\N	SA	ITEMIZED RECEIPTS	11D	202504149755350357	1886284	4041520251184156064	\N	4042120251185599079	F3	Q1	2025	2026	https://docquery.fec.gov/cgi-bin/fecimg/?202504149755350357	'amy':2,5 'chai':1 'dr':4 'fogelstrom':3	'ct':3 'of':2 'state':1	'director':2 'medical':1	f	\N	2025-04-22 04:07:31	Contributions From the Candidate	H		P
C00003590	\N	\N	PERRY, LARRY	LARRY	\N	PERRY	\N	\N	318 N. HICKORY	\N	PINE BLUFF	AR	716013322	IND	INDIVIDUAL	EVERGREEN PACKAGING	LABORER	P	PRIMARY	\N	\N	220.00	2025-04-02 00:00:00	40.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	A3B533E7F256746EA8CA	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202505159761323023	1892377	4051520251202504121	\N	4051620251202910001	F3X	M5	2025	2026	https://docquery.fec.gov/cgi-bin/fecimg/?202505159761323023	'larry':2 'perry':1	'evergreen':1 'packaging':2	'laborer':1	t	\N	2025-05-17 04:08:30	Contributions From Individuals/Persons Other Than Political Committees	Q	L	B
C00003590	\N	\N	HUFFTY, TREY C	TREY	C	HUFFTY	\N	\N	10937 DOGWOOD FORREST DR	\N	PINE BLUFF	AR	716038793	IND	INDIVIDUAL	EVERGREEN PACKAGING	LABORER	P	PRIMARY	\N	\N	220.00	2025-04-02 00:00:00	40.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	A06946870622A4840B7C	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202505159761323023	1892377	4051520251202504121	\N	4051620251202910002	F3X	M5	2025	2026	https://docquery.fec.gov/cgi-bin/fecimg/?202505159761323023	'c':3 'huffty':1 'trey':2	'evergreen':1 'packaging':2	'laborer':1	t	\N	2025-05-17 04:08:30	Contributions From Individuals/Persons Other Than Political Committees	Q	L	B
C00003590	\N	\N	MARSHALL, TAMILA MITCHELL	TAMILA	MITCHELL	MARSHALL	\N	\N	409 EAST 34TH AVE	\N	PINE BLUFF	AR	716017011	IND	INDIVIDUAL	EVERGREEN PACKAGING	LABORER	P	PRIMARY	\N	\N	240.00	2025-04-02 00:00:00	40.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	A6ECE3B8D3BD7417FA9B	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202505159761323023	1892377	4051520251202504121	\N	4051620251202910003	F3X	M5	2025	2026	https://docquery.fec.gov/cgi-bin/fecimg/?202505159761323023	'marshall':1 'mitchell':3 'tamila':2	'evergreen':1 'packaging':2	'laborer':1	t	\N	2025-05-17 04:08:30	Contributions From Individuals/Persons Other Than Political Committees	Q	L	B
C00003590	\N	\N	WOMACK, JUSTIN T	JUSTIN	T	WOMACK	\N	\N	1700 HIGHWAY 63	\N	RISON	AR	716658978	IND	INDIVIDUAL	EVERGREEN PACKAGING	LABORER	P	PRIMARY	\N	\N	220.00	2025-04-02 00:00:00	40.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	AD808AB3D47714D7E9A3	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202505159761323024	1892377	4051520251202504121	\N	4051620251202910004	F3X	M5	2025	2026	https://docquery.fec.gov/cgi-bin/fecimg/?202505159761323024	'justin':2 't':3 'womack':1	'evergreen':1 'packaging':2	'laborer':1	t	\N	2025-05-17 04:08:30	Contributions From Individuals/Persons Other Than Political Committees	Q	L	B
C00788992	\N	\N	FERENBACH, CARL	CARL	\N	FERENBACH	\N	\N	2 COMMONWEALTH AVE	# PH5	BOSTON	MA	021163134	IND	INDIVIDUAL	NONE	RETIRED	P	PRIMARY	\N	\N	5000.00	2025-02-19 00:00:00	5000.00	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	18761590	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202503129754144309	1880162	4031220251179930066	\N	4031220251179994229	F3X	M3	2025	2026	https://docquery.fec.gov/cgi-bin/fecimg/?202503129754144309	'carl':2 'ferenbach':1	'none':1	'retired':1	t	\N	2025-03-13 04:09:44	Contributions From Individuals/Persons Other Than Political Committees	Q	M	U
C00024752	\N	\N	PAAL, VICTORIA	VICTORIA	\N	PAAL	\N	\N	555 12TH STREET	\N	OAKLAND	CA	94607	IND	INDIVIDUAL	MATSON	LEGAL	P	PRIMARY	\N	\N	336.66	2025-04-29 00:00:00	78.08	15	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	SA11AI.34876	\N	\N	SA	ITEMIZED RECEIPTS	11AI	202505299761728422	1894189	4052920251204308031	\N	4053020251204331325	F3X	M5	2025	2026	https://docquery.fec.gov/cgi-bin/fecimg/?202505299761728422	'paal':1 'victoria':2	'matson':1	'legal':1	t	\N	2025-05-31 04:07:02	Contributions From Individuals/Persons Other Than Political Committees	Q	C	U
C00780866	\N	\N	WINRED	\N	\N	\N	\N	\N	PO BOX 9891	\N	ARLINGTON	VA	222191891	COM	OTHER COMMITTEE	\N	\N	O2025	\N	2025	ANNUAL	2080.54	2025-03-24 00:00:00	25.00	\N	\N	CONDUIT MEMO TOTAL	X	\N	EARMARK NON-DIRECTED	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	ADD	AFCCA0D269BAD4093968	AD4F4AE9C348048DEA14	SA11AI	SA	ITEMIZED RECEIPTS	11AI	202504149755331685	1886143	4041420251183970196	\N	4041520251184234028	F3X	Q1	2025	2026	https://docquery.fec.gov/cgi-bin/fecimg/?202504149755331685	'winred':1			f	\N	2025-04-16 04:31:48	Contributions From Individuals/Persons Other Than Political Committees	N		J
C00480228	\N	C00848093	NEW YORK LIFE INSURANCE COMPANY POLITICAL ACTION COMMITTEE	\N	\N	\N	\N	\N	51 MADISON AVENUE	ROOM 1109	NEW YORK	NY	100101603	PAC	POLITICAL ACTION COMMITTEE	\N	\N	P	PRIMARY	\N	PRIMARY	5000.00	2025-03-21 00:00:00	5000.00	18K	CONTRIBUTION RECEIVED FROM REGISTERED FILER	CONTRIBUTION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	NEW YORK LIFE INSURANCE COMPANY POLITICAL ACTION COMMITTEE	\N	\N	A	ADD	SA11C.105387	\N	\N	SA	ITEMIZED RECEIPTS	11C	202504209756290292	1889653	4042020251185482097	\N	4042420251186616490	F3X	M4	2025	2026	https://docquery.fec.gov/cgi-bin/fecimg/?202504209756290292	'action':7 'c00848093':9 'committee':8 'company':5 'insurance':4 'life':3 'new':1 'political':6 'york':2			f	C00848093	2025-05-17 04:08:30	Contributions From Other Political Committees	Q		D
\.


--
-- Name: fec_fitem_sched_a_1975_1976 fec_fitem_sched_a_1975_1976_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1975_1976
    ADD CONSTRAINT fec_fitem_sched_a_1975_1976_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_1977_1978 fec_fitem_sched_a_1977_1978_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1977_1978
    ADD CONSTRAINT fec_fitem_sched_a_1977_1978_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_1979_1980 fec_fitem_sched_a_1979_1980_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1979_1980
    ADD CONSTRAINT fec_fitem_sched_a_1979_1980_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_1981_1982 fec_fitem_sched_a_1981_1982_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1981_1982
    ADD CONSTRAINT fec_fitem_sched_a_1981_1982_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_1983_1984 fec_fitem_sched_a_1983_1984_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1983_1984
    ADD CONSTRAINT fec_fitem_sched_a_1983_1984_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_1985_1986 fec_fitem_sched_a_1985_1986_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1985_1986
    ADD CONSTRAINT fec_fitem_sched_a_1985_1986_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_1987_1988 fec_fitem_sched_a_1987_1988_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1987_1988
    ADD CONSTRAINT fec_fitem_sched_a_1987_1988_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_1989_1990 fec_fitem_sched_a_1989_1990_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1989_1990
    ADD CONSTRAINT fec_fitem_sched_a_1989_1990_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_1991_1992 fec_fitem_sched_a_1991_1992_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1991_1992
    ADD CONSTRAINT fec_fitem_sched_a_1991_1992_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_1993_1994 fec_fitem_sched_a_1993_1994_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1993_1994
    ADD CONSTRAINT fec_fitem_sched_a_1993_1994_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_1995_1996 fec_fitem_sched_a_1995_1996_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1995_1996
    ADD CONSTRAINT fec_fitem_sched_a_1995_1996_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_1997_1998 fec_fitem_sched_a_1997_1998_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1997_1998
    ADD CONSTRAINT fec_fitem_sched_a_1997_1998_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_1999_2000 fec_fitem_sched_a_1999_2000_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_1999_2000
    ADD CONSTRAINT fec_fitem_sched_a_1999_2000_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_2001_2002 fec_fitem_sched_a_2001_2002_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2001_2002
    ADD CONSTRAINT fec_fitem_sched_a_2001_2002_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_2003_2004 fec_fitem_sched_a_2003_2004_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2003_2004
    ADD CONSTRAINT fec_fitem_sched_a_2003_2004_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_2005_2006 fec_fitem_sched_a_2005_2006_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2005_2006
    ADD CONSTRAINT fec_fitem_sched_a_2005_2006_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_2007_2008 fec_fitem_sched_a_2007_2008_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2007_2008
    ADD CONSTRAINT fec_fitem_sched_a_2007_2008_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_2009_2010 fec_fitem_sched_a_2009_2010_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2009_2010
    ADD CONSTRAINT fec_fitem_sched_a_2009_2010_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_2011_2012 fec_fitem_sched_a_2011_2012_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2011_2012
    ADD CONSTRAINT fec_fitem_sched_a_2011_2012_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_2013_2014 fec_fitem_sched_a_2013_2014_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2013_2014
    ADD CONSTRAINT fec_fitem_sched_a_2013_2014_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_2015_2016 fec_fitem_sched_a_2015_2016_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2015_2016
    ADD CONSTRAINT fec_fitem_sched_a_2015_2016_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_2017_2018 fec_fitem_sched_a_2017_2018_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2017_2018
    ADD CONSTRAINT fec_fitem_sched_a_2017_2018_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_2019_2020 fec_fitem_sched_a_2019_2020_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2019_2020
    ADD CONSTRAINT fec_fitem_sched_a_2019_2020_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_2021_2022 fec_fitem_sched_a_2021_2022_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2021_2022
    ADD CONSTRAINT fec_fitem_sched_a_2021_2022_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_2023_2024 fec_fitem_sched_a_2023_2024_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2023_2024
    ADD CONSTRAINT fec_fitem_sched_a_2023_2024_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a_2025_2026 fec_fitem_sched_a_2025_2026_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a_2025_2026
    ADD CONSTRAINT fec_fitem_sched_a_2025_2026_pkey PRIMARY KEY (sub_id);


--
-- Name: fec_fitem_sched_a fec_fitem_sched_a_pkey; Type: CONSTRAINT; Schema: disclosure; Owner: -
--

ALTER TABLE ONLY disclosure.fec_fitem_sched_a
    ADD CONSTRAINT fec_fitem_sched_a_pkey PRIMARY KEY (sub_id);
