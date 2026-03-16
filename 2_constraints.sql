USE projet_beyblade;

ALTER TABLE generation
ADD CONSTRAINT chk_generation_dates
CHECK (end_date IS NULL OR end_date >= start_date);

ALTER TABLE market
ADD CONSTRAINT chk_market_code_format
CHECK (market_code REGEXP '^[A-Z]{3}$');

ALTER TABLE market
ADD CONSTRAINT chk_currency_code_format
CHECK (currency_code REGEXP '^[A-Z]{3}$');

ALTER TABLE product
ADD CONSTRAINT chk_product_category
CHECK (product_category IN ('Top', 'Launcher', 'Stadium', 'Accessory'));

ALTER TABLE product
ADD CONSTRAINT chk_age_grade
CHECK (age_grade IN ('6+', '8+', '10+', '12+', '14+'));

ALTER TABLE product
ADD CONSTRAINT chk_marketing_type
CHECK (marketing_type IN ('Attack', 'Defense', 'Stamina', 'Balance', 'Support'));

ALTER TABLE packaging
ADD CONSTRAINT chk_barcode_format
CHECK (barcode REGEXP '^[0-9]{8,14}$');

ALTER TABLE packaging
ADD CONSTRAINT chk_packaging_configuration
CHECK (
    packaging_configuration IN (
        'Single Top',
        'Top+Launcher',
        'Stadium Set',
        'Gift Set',
        'Booster',
        'Launcher Set',
        'Accessory Pack'
    )
);

ALTER TABLE part
ADD CONSTRAINT chk_part_weight
CHECK (part_weight_g IS NULL OR part_weight_g > 0);

ALTER TABLE part
ADD CONSTRAINT chk_part_material
CHECK (
    part_material IS NULL OR
    part_material IN ('Plastic', 'Metal', 'Rubber', 'Composite', 'Foam')
);

ALTER TABLE part
ADD CONSTRAINT chk_part_system_type
CHECK (
    part_system_type IN (
        'Layer',
        'Energy Chip',
        'Forge Disc',
        'Driver',
        'Blade',
        'Ratchet',
        'Bit'
    )
);

ALTER TABLE distribution_contract
ADD CONSTRAINT chk_contract_dates
CHECK (end_date >= start_date);

ALTER TABLE distribution_contract
ADD CONSTRAINT chk_incoterms
CHECK (
    incoterms IN (
        'EXW', 'FCA', 'CPT', 'CIP',
        'DAP', 'DPU', 'DDP',
        'FAS', 'FOB', 'CFR', 'CIF'
    )
);

ALTER TABLE market_product_release
ADD CONSTRAINT chk_release_status
CHECK (release_status IN ('planned', 'confirmed', 'delayed', 'cancelled'));

ALTER TABLE price_msrp
ADD CONSTRAINT chk_msrp_positive
CHECK (msrp_amount >= 0);

ALTER TABLE price_wholesale
ADD CONSTRAINT chk_wholesale_positive
CHECK (wholesale_unit_price >= 0);

-- Optional business logic:
-- wholesale price should not be absurdly high
ALTER TABLE price_wholesale
ADD CONSTRAINT chk_wholesale_reasonable
CHECK (wholesale_unit_price <= 99999.99);

ALTER TABLE price_msrp
ADD CONSTRAINT chk_msrp_reasonable
CHECK (msrp_amount <= 99999.99);

-- =========================================================
-- 8. RETAIL PARTNER CONSTRAINTS
-- =========================================================

ALTER TABLE retail_partner
ADD CONSTRAINT chk_retail_channel
CHECK (
    channel IN (
        'Mass Retail',
        'Specialty',
        'E-commerce',
        'Marketplace'
    )
);

-- =========================================================
-- 9. WAREHOUSE / STOCK CONSTRAINTS
-- =========================================================

ALTER TABLE warehouse
ADD CONSTRAINT chk_warehouse_country_code
CHECK (warehouse_country_code REGEXP '^[A-Z]{3}$');

ALTER TABLE stock
ADD CONSTRAINT chk_stock_non_negative
CHECK (on_hand_qty >= 0);

ALTER TABLE stock_movement
ADD CONSTRAINT chk_movement_type
CHECK (movement_type IN ('received', 'shipped', 'adjusted'));

ALTER TABLE stock_movement
ADD CONSTRAINT chk_qty_delta_not_zero
CHECK (qty_delta <> 0);



ALTER TABLE generation
ADD CONSTRAINT uq_generation_name
UNIQUE (generation_name);

ALTER TABLE distributor
ADD CONSTRAINT uq_distributor_name
UNIQUE (distributor_name);

ALTER TABLE market
ADD CONSTRAINT uq_market_name
UNIQUE (market_name);

ALTER TABLE part
ADD CONSTRAINT uq_part_name
UNIQUE (part_name);

ALTER TABLE packaging
ADD CONSTRAINT uq_barcode
UNIQUE (barcode);

