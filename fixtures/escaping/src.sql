CREATE SCHEMA escaping;

CREATE TABLE escaping.values (
    id      text PRIMARY KEY,
    payload text
);

-- COPY's text format uses backslash escapes: \t \n \r \\ \N for NULL.
-- psql interprets the escapes when loading, so the rows stored contain the
-- actual control characters (or NULL). pg_dump -Fc will re-emit them as
-- escape sequences in the custom-format data block, which is exactly what we
-- want the test to verify pg_dumpster passes through unchanged.
COPY escaping.values (id, payload) FROM stdin;
backslash	path\\to\\file
carriage-return	first\rsecond
newline	line1\nline2
null	\N
plain	hello world
tab	a\tb\tc
unicode	café — 日本語
\.
