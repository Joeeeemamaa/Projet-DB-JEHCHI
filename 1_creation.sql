DROP DATABASE IF EXISTS projet_beyblade;
CREATE DATABASE projet_beyblade;
USE projet_beyblade;


CREATE TABLE generation (
    generation_code      VARCHAR(10)  NOT NULL,
    generation_name      VARCHAR(60)  NOT NULL,
    start_date           DATE         NOT NULL,
    end_date             DATE         NULL,
    PRIMARY KEY (generation_code)
) ENGINE=InnoDB;

CREATE TABLE market (
    market_code          CHAR(3)      NOT NULL,
    market_name          VARCHAR(60)  NOT NULL,
    currency_code        CHAR(3)      NOT NULL,
    PRIMARY KEY (market_code)
) ENGINE=InnoDB;

CREATE TABLE part_category (
    part_category_name   VARCHAR(15)  NOT NULL,
    PRIMARY KEY (part_category_name)
) ENGINE=InnoDB;

CREATE TABLE distributor (
    distributor_legal_id VARCHAR(20)  NOT NULL,
    distributor_name     VARCHAR(80)  NOT NULL,
    PRIMARY KEY (distributor_legal_id)
) ENGINE=InnoDB;

CREATE TABLE retail_partner (
    retail_partner_name  VARCHAR(80)  NOT NULL,
    channel              VARCHAR(20)  NOT NULL,
    PRIMARY KEY (retail_partner_name)
) ENGINE=InnoDB;


CREATE TABLE product_line (
    product_line_name    VARCHAR(40)  NOT NULL,
    generation_code      VARCHAR(10)  NOT NULL,
    PRIMARY KEY (product_line_name),
    CONSTRAINT fk_product_line_generation
        FOREIGN KEY (generation_code)
        REFERENCES generation(generation_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE product (
    internal_product_code    VARCHAR(20)  NOT NULL,
    product_commercial_name  VARCHAR(80)  NOT NULL,
    product_category         VARCHAR(20)  NOT NULL,
    age_grade                VARCHAR(5)   NOT NULL,
    marketing_type           VARCHAR(15)  NOT NULL,
    product_line_name        VARCHAR(40)  NOT NULL,
    PRIMARY KEY (internal_product_code),
    CONSTRAINT fk_product_product_line
        FOREIGN KEY (product_line_name)
        REFERENCES product_line(product_line_name)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE packaging (
    internal_product_code     VARCHAR(20)  NOT NULL,
    barcode                   VARCHAR(14)  NOT NULL,
    packaging_configuration   VARCHAR(30)  NOT NULL,
    PRIMARY KEY (internal_product_code, barcode),
    CONSTRAINT fk_packaging_product
        FOREIGN KEY (internal_product_code)
        REFERENCES product(internal_product_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE part (
    part_code              VARCHAR(20)  NOT NULL,
    part_name              VARCHAR(60)  NOT NULL,
    part_system_type       VARCHAR(25)  NOT NULL,
    part_material          VARCHAR(20)  NULL,
    part_weight_g          DECIMAL(5,1) NULL,
    part_category_name     VARCHAR(15)  NOT NULL,
    PRIMARY KEY (part_code),
    CONSTRAINT fk_part_category
        FOREIGN KEY (part_category_name)
        REFERENCES part_category(part_category_name)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE product_part (
    internal_product_code  VARCHAR(20) NOT NULL,
    part_code              VARCHAR(20) NOT NULL,
    PRIMARY KEY (internal_product_code, part_code),
    CONSTRAINT fk_product_part_product
        FOREIGN KEY (internal_product_code)
        REFERENCES product(internal_product_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_product_part_part
        FOREIGN KEY (part_code)
        REFERENCES part(part_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE distribution_contract (
    contract_reference     VARCHAR(25) NOT NULL,
    distributor_legal_id   VARCHAR(20) NOT NULL,
    start_date             DATE        NOT NULL,
    end_date               DATE        NOT NULL,
    incoterms              VARCHAR(10) NOT NULL,
    PRIMARY KEY (contract_reference),
    UNIQUE KEY uq_contract_distributor (contract_reference, distributor_legal_id),
    CONSTRAINT fk_contract_distributor
        FOREIGN KEY (distributor_legal_id)
        REFERENCES distributor(distributor_legal_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE contract_coverage (
    contract_reference     VARCHAR(25) NOT NULL,
    distributor_legal_id   VARCHAR(20) NOT NULL,
    market_code            CHAR(3)     NOT NULL,
    PRIMARY KEY (contract_reference, distributor_legal_id, market_code),
    CONSTRAINT fk_coverage_contract_distributor
        FOREIGN KEY (contract_reference, distributor_legal_id)
        REFERENCES distribution_contract(contract_reference, distributor_legal_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_coverage_market
        FOREIGN KEY (market_code)
        REFERENCES market(market_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- Retail partner operates in one or more markets
CREATE TABLE retail_partner_market (
    retail_partner_name    VARCHAR(80) NOT NULL,
    market_code            CHAR(3)     NOT NULL,
    PRIMARY KEY (retail_partner_name, market_code),
    CONSTRAINT fk_rpm_partner
        FOREIGN KEY (retail_partner_name)
        REFERENCES retail_partner(retail_partner_name)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_rpm_market
        FOREIGN KEY (market_code)
        REFERENCES market(market_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE market_product_release (
    internal_product_code  VARCHAR(20) NOT NULL,
    market_code            CHAR(3)     NOT NULL,
    release_date           DATE        NOT NULL,
    release_status         VARCHAR(12) NOT NULL,
    PRIMARY KEY (internal_product_code, market_code),
    CONSTRAINT fk_release_product
        FOREIGN KEY (internal_product_code)
        REFERENCES product(internal_product_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_release_market
        FOREIGN KEY (market_code)
        REFERENCES market(market_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE price_msrp (
    internal_product_code  VARCHAR(20)  NOT NULL,
    market_code            CHAR(3)      NOT NULL,
    msrp_amount            DECIMAL(9,2) NOT NULL,
    PRIMARY KEY (internal_product_code, market_code),
    CONSTRAINT fk_msrp_product
        FOREIGN KEY (internal_product_code)
        REFERENCES product(internal_product_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_msrp_market
        FOREIGN KEY (market_code)
        REFERENCES market(market_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE price_wholesale (
    contract_reference      VARCHAR(25)  NOT NULL,
    internal_product_code   VARCHAR(20)  NOT NULL,
    wholesale_unit_price    DECIMAL(9,2) NOT NULL,
    PRIMARY KEY (contract_reference, internal_product_code),
    CONSTRAINT fk_wholesale_contract
        FOREIGN KEY (contract_reference)
        REFERENCES distribution_contract(contract_reference)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_wholesale_product
        FOREIGN KEY (internal_product_code)
        REFERENCES product(internal_product_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;



CREATE TABLE warehouse (
    warehouse_code           VARCHAR(10) NOT NULL,
    warehouse_country_code   CHAR(3)     NOT NULL,
    PRIMARY KEY (warehouse_code),
    CONSTRAINT fk_warehouse_market
        FOREIGN KEY (warehouse_country_code)
        REFERENCES market(market_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE stock (
    warehouse_code           VARCHAR(10) NOT NULL,
    internal_product_code    VARCHAR(20) NOT NULL,
    on_hand_qty              INT         NOT NULL,
    PRIMARY KEY (warehouse_code, internal_product_code),
    CONSTRAINT fk_stock_warehouse
        FOREIGN KEY (warehouse_code)
        REFERENCES warehouse(warehouse_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_stock_product
        FOREIGN KEY (internal_product_code)
        REFERENCES product(internal_product_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE stock_movement (
    movement_id              INT AUTO_INCREMENT NOT NULL,
    warehouse_code           VARCHAR(10)        NOT NULL,
    internal_product_code    VARCHAR(20)        NOT NULL,
    movement_date            DATETIME           NOT NULL,
    movement_type            VARCHAR(10)        NOT NULL,
    qty_delta                INT                NOT NULL,
    PRIMARY KEY (movement_id),
    CONSTRAINT fk_stock_movement_stock
        FOREIGN KEY (warehouse_code, internal_product_code)
        REFERENCES stock(warehouse_code, internal_product_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;



CREATE INDEX idx_product_generation_line
    ON product(product_line_name);

CREATE INDEX idx_packaging_barcode
    ON packaging(barcode);

CREATE INDEX idx_part_category
    ON part(part_category_name);

CREATE INDEX idx_contract_distributor
    ON distribution_contract(distributor_legal_id);

CREATE INDEX idx_release_market
    ON market_product_release(market_code);

CREATE INDEX idx_msrp_market
    ON price_msrp(market_code);

CREATE INDEX idx_wholesale_product
    ON price_wholesale(internal_product_code);

CREATE INDEX idx_warehouse_market
    ON warehouse(warehouse_country_code);

CREATE INDEX idx_stock_product
    ON stock(internal_product_code);

CREATE INDEX idx_stock_movement_date
    ON stock_movement(movement_date);

