-- Start the transaction
BEGIN;

-- Dimension Table: DimStore
CREATE TABLE public."DimStore" (
    storeid INTEGER PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL
);

-- Dimension Table: DimDate
CREATE TABLE public."DimDate" (
    dateid INTEGER PRIMARY KEY,                -- Can be a surrogate key or derived from actual date
    day INTEGER NOT NULL,                      -- Day of the month (1–31)
    weekday INTEGER NOT NULL,                  -- 1 = Sunday, ..., 7 = Saturday
    weekdayname VARCHAR(20) NOT NULL,          -- Name of the weekday
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,                    -- Numeric month (1–12)
    monthname VARCHAR(20) NOT NULL,            -- Month name
    quarter INTEGER NOT NULL,                  -- Quarter number (1–4)
    quartername VARCHAR(5) NOT NULL            -- Q1, Q2, etc.
);

-- Fact Table: FactSales
CREATE TABLE public."FactSales" (
    rowid SERIAL PRIMARY KEY,
    storeid INTEGER NOT NULL,
    dateid INTEGER NOT NULL,
    totalsales NUMERIC(10, 2) NOT NULL,

    FOREIGN KEY (storeid) REFERENCES public."DimStore" (storeid),
    FOREIGN KEY (dateid) REFERENCES public."DimDate" (dateid)
);

-- Commit the transaction
COMMIT;
