-- A small fixture that exercises a variety of TOC entry kinds:
--   * two schemas
--   * two tables with data
--   * an index
--   * a view (no data rows, no COPY statement)
-- The goal is a compact TOC we can snapshot/inspect in tests.

CREATE SCHEMA shop;
CREATE SCHEMA ops;

CREATE TABLE shop.products (
    id    integer PRIMARY KEY,
    name  text    NOT NULL,
    price numeric(10, 2)
);

CREATE INDEX products_name_idx ON shop.products (name);

CREATE TABLE ops.audit_log (
    id      integer PRIMARY KEY,
    action  text NOT NULL
);

CREATE VIEW shop.cheap_products AS
    SELECT id, name FROM shop.products WHERE price < 10;

COPY shop.products (id, name, price) FROM stdin;
1	widget	9.99
2	gadget	19.99
3	gizmo	4.50
\.

COPY ops.audit_log (id, action) FROM stdin;
1	login
2	logout
\.
