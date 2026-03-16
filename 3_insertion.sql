USE projet_beyblade;

INSERT INTO generation VALUES
('GEN1','Original Series','2000-01-01','2003-12-31'),
('GEN2','Metal Fight','2008-01-01','2012-12-31'),
('GEN3','Beyblade Burst','2015-01-01','2023-12-31'),
('GEN4','Beyblade X','2023-01-01',NULL);

INSERT INTO market VALUES
('USA','United States','USD'),
('JPN','Japan','JPY'),
('FRA','France','EUR'),
('GBR','United Kingdom','GBP'),
('CAN','Canada','CAD');

INSERT INTO part_category VALUES
('Attack'),
('Defense'),
('Stamina'),
('Balance');

INSERT INTO distributor VALUES
('DIST001','Hasbro North America'),
('DIST002','Takara Tomy Distribution'),
('DIST003','Hasbro Europe'),
('DIST004','Asia Toy Network');

INSERT INTO retail_partner VALUES
('Amazon','E-commerce'),
('Walmart','Mass Retail'),
('ToysRUs','Specialty'),
('Target','Mass Retail');

INSERT INTO product_line VALUES
('Starter','GEN3'),
('Booster','GEN3'),
('Stadium Set','GEN3'),
('Launcher Set','GEN3'),
('Accessory','GEN3');

INSERT INTO product VALUES
('BB001','Valtryek V2','Top','8+','Attack','Starter'),
('BB002','Spryzen S2','Top','8+','Balance','Starter'),
('BB003','Roktavor R2','Top','8+','Defense','Starter'),
('BB004','Kerbeus K2','Top','8+','Defense','Booster'),
('BB005','Xcalibur X2','Top','8+','Attack','Booster'),
('BB006','Beyblade Burst Stadium','Stadium','8+','Balance','Stadium Set'),
('BB007','String Launcher','Launcher','8+','Balance','Launcher Set'),
('BB008','Grip Launcher','Accessory','8+','Balance','Accessory');

INSERT INTO packaging VALUES
('BB001','1234567890123','Top+Launcher'),
('BB002','1234567890124','Top+Launcher'),
('BB003','1234567890125','Top+Launcher'),
('BB004','1234567890126','Single Top'),
('BB005','1234567890127','Single Top'),
('BB006','1234567890128','Stadium Set'),
('BB007','1234567890129','Launcher Set'),
('BB008','1234567890130','Accessory Pack');

INSERT INTO part VALUES
('P001','Valtryek Layer','Layer','Plastic',12.5,'Attack'),
('P002','Spryzen Layer','Layer','Plastic',11.8,'Balance'),
('P003','Roktavor Layer','Layer','Plastic',13.2,'Defense'),
('P004','Forge Disc D01','Forge Disc','Metal',20.5,'Balance'),
('P005','Forge Disc D02','Forge Disc','Metal',19.8,'Attack'),
('P006','Driver A01','Driver','Rubber',8.2,'Attack'),
('P007','Driver S01','Driver','Plastic',7.8,'Stamina'),
('P008','Driver B01','Driver','Plastic',8.0,'Balance');

INSERT INTO product_part VALUES
('BB001','P001'),
('BB001','P004'),
('BB001','P006'),

('BB002','P002'),
('BB002','P004'),
('BB002','P008'),

('BB003','P003'),
('BB003','P004'),
('BB003','P007'),

('BB004','P003'),
('BB004','P005'),
('BB004','P007'),

('BB005','P001'),
('BB005','P005'),
('BB005','P006');

INSERT INTO distribution_contract VALUES
('CON001','DIST001','2022-01-01','2026-12-31','FOB'),
('CON002','DIST002','2022-01-01','2026-12-31','FOB'),
('CON003','DIST003','2022-01-01','2026-12-31','CIF');

INSERT INTO contract_coverage VALUES
('CON001','DIST001','USA'),
('CON001','DIST001','CAN'),
('CON002','DIST002','JPN'),
('CON003','DIST003','FRA'),
('CON003','DIST003','GBR');

INSERT INTO retail_partner_market VALUES
('Amazon','USA'),
('Amazon','FRA'),
('Amazon','GBR'),
('Walmart','USA'),
('Target','USA'),
('ToysRUs','CAN');

INSERT INTO market_product_release VALUES
('BB001','USA','2017-03-01','confirmed'),
('BB001','FRA','2017-05-01','confirmed'),
('BB002','USA','2017-04-01','confirmed'),
('BB003','USA','2017-06-01','confirmed'),
('BB004','JPN','2017-07-01','confirmed'),
('BB005','USA','2018-01-01','confirmed');

INSERT INTO price_msrp VALUES
('BB001','USA',9.99),
('BB001','FRA',10.99),
('BB002','USA',9.99),
('BB003','USA',9.99),
('BB004','JPN',1200),
('BB005','USA',8.99);

INSERT INTO price_wholesale VALUES
('CON001','BB001',4.20),
('CON001','BB002',4.10),
('CON001','BB003',4.00),
('CON002','BB004',450),
('CON001','BB005',3.80);

INSERT INTO warehouse VALUES
('WH_USA_01','USA'),
('WH_EU_01','FRA'),
('WH_JPN_01','JPN');

INSERT INTO stock VALUES
('WH_USA_01','BB001',500),
('WH_USA_01','BB002',400),
('WH_USA_01','BB003',350),
('WH_EU_01','BB001',200),
('WH_EU_01','BB002',150),
('WH_JPN_01','BB004',600);

INSERT INTO stock_movement
(warehouse_code,internal_product_code,movement_date,movement_type,qty_delta)
VALUES
('WH_USA_01','BB001','2024-01-10','received',500),
('WH_USA_01','BB002','2024-01-11','received',400),
('WH_USA_01','BB003','2024-01-12','received',350),
('WH_EU_01','BB001','2024-01-15','received',200),
('WH_JPN_01','BB004','2024-01-16','received',600),
('WH_USA_01','BB001','2024-02-01','shipped',-50),
('WH_USA_01','BB002','2024-02-02','shipped',-30);
