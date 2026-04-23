CREATE SCHEMA escaping;

CREATE TABLE escaping.values (
    id      integer PRIMARY KEY,
    label   text    NOT NULL,
    payload text
);

-- COPY's text format uses backslash escapes: \t \n \r \\ \N for NULL.
-- psql interprets the escapes when loading, so the rows stored contain the
-- actual control characters (or NULL). pg_dump -Fc will re-emit them as
-- escape sequences in the custom-format data block, which is exactly what we
-- want the test to verify pg_dumpster passes through unchanged.
COPY escaping.values (id, label, payload) FROM stdin;
1	plain	hello world
2	tab	a\tb\tc
3	newline	line1\nline2
4	backslash	path\\to\\file
5	null	\N
6	carriage-return	first\rsecond
7	unicode	café — 日本語
\.
