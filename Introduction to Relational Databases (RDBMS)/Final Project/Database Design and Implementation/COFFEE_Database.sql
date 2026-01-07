-- Create COFFEE database
CREATE DATABASE COFFEE;

-- Connect to the COFFEE database
\c COFFEE;

-- Begin transaction
BEGIN;

-- Table: sales_transaction
CREATE TABLE IF NOT EXISTS public.sales_transaction
(
    transaction_id integer NOT NULL,
    data date NOT NULL,
    "time" time with time zone NOT NULL,
    sales_outlet integer NOT NULL,
    staff integer NOT NULL,
    customer integer NOT NULL,
    PRIMARY KEY (transaction_id)
);

-- Table: sales_detail
CREATE TABLE IF NOT EXISTS public.sales_detail
(
    sales_detail_id integer NOT NULL,
    transaction_id integer NOT NULL,
    product integer NOT NULL,
    quantity numeric(8) NOT NULL,
    price numeric(8, 2) NOT NULL,
    PRIMARY KEY (sales_detail_id)
);

-- Table: product
CREATE TABLE IF NOT EXISTS public.product
(
    product_id integer NOT NULL,
    product character varying(100) NOT NULL,
    description character varying(300) NOT NULL,
    price numeric(8, 2) NOT NULL,
    product_type_id integer NOT NULL,
    PRIMARY KEY (product_id)
);

-- Table: product_type
CREATE TABLE IF NOT EXISTS public.product_type
(
    product_type_id integer NOT NULL,
    product_character character varying(50) NOT NULL,
    category character varying(100) NOT NULL,
    PRIMARY KEY (product_type_id)
);

-- Foreign Keys
ALTER TABLE IF EXISTS public.sales_detail
    ADD FOREIGN KEY (transaction_id)
    REFERENCES public.sales_transaction (transaction_id)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.sales_detail
    ADD FOREIGN KEY (product)
    REFERENCES public.product (product_id)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.product
    ADD FOREIGN KEY (product_type_id)
    REFERENCES public.product_type (product_type_id)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

-- End transaction
END;
