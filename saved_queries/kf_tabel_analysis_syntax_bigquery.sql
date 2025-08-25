CREATE OR REPLACE TABLE `true-upgrade-470104-p4.kimia_farma_dataset_project.kf_tabel_analysis` AS
SELECT 
    t.transaction_id,
    t.date,
    b.branch_id,
    b.branch_name,
    b.kota,
    b.provinsi,
    b.rating AS rating_cabang,
    t.customer_name,
    t.product_id,
    p.product_name,
    t.price AS actual_price,
    t.discount_percentage,
    CASE
        WHEN t.price <= 50000 THEN 0.10
        WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
        WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
        WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
        ELSE 0.30
    END AS persentase_gross_laba,
    (t.price - (t.price * t.discount_percentage)) AS nett_sales,
    (t.price - (t.price * t.discount_percentage)) *
    CASE
        WHEN t.price <= 50000 THEN 0.10
        WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
        WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
        WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
        ELSE 0.30
    END AS nett_profit,
    t.rating AS rating_transaksi
FROM `true-upgrade-470104-p4.kimia_farma_dataset_project.kf_final_transaction` AS t
JOIN `true-upgrade-470104-p4.kimia_farma_dataset_project.kf_product` AS p
    ON t.product_id = p.product_id
JOIN `true-upgrade-470104-p4.kimia_farma_dataset_project.kf_kantor_cabang` AS b
    ON t.branch_id = b.branch_id;
