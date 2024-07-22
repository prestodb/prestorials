SET SESSION hive.compression_codec='NONE';
SET SESSION query_max_execution_time='12h';
SET SESSION query_max_run_time='12h';

CREATE SCHEMA IF NOT EXISTS hive.tpcds_sf1_parquet_hive
WITH (
    location = 's3a://my-bucket/tpcds-sf1/'
);

USE hive.tpcds_sf1_parquet_hive;

CREATE TABLE IF NOT EXISTS call_center (
    cc_call_center_sk BIGINT,
    cc_call_center_id VARCHAR(16),
    cc_rec_start_date DATE,
    cc_rec_end_date DATE,
    cc_closed_date_sk BIGINT,
    cc_open_date_sk BIGINT,
    cc_name VARCHAR(50),
    cc_class VARCHAR(50),
    cc_employees BIGINT,
    cc_sq_ft BIGINT,
    cc_hours VARCHAR(20),
    cc_manager VARCHAR(40),
    cc_mkt_id BIGINT,
    cc_mkt_class VARCHAR(50),
    cc_mkt_desc VARCHAR(100),
    cc_market_manager VARCHAR(40),
    cc_division BIGINT,
    cc_division_name VARCHAR(50),
    cc_company BIGINT,
    cc_company_name VARCHAR(50),
    cc_street_number VARCHAR(10),
    cc_street_name VARCHAR(60),
    cc_street_type VARCHAR(15),
    cc_suite_number VARCHAR(10),
    cc_city VARCHAR(60),
    cc_county VARCHAR(30),
    cc_state VARCHAR(2),
    cc_zip VARCHAR(10),
    cc_country VARCHAR(20),
    cc_gmt_offset DECIMAL(5,2),
    cc_tax_percentage DECIMAL(5,2)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/call_center/'
);

CREATE TABLE IF NOT EXISTS catalog_page (
    cp_catalog_page_sk BIGINT,
    cp_catalog_page_id VARCHAR(16),
    cp_start_date_sk BIGINT,
    cp_end_date_sk BIGINT,
    cp_department VARCHAR(50),
    cp_catalog_number BIGINT,
    cp_catalog_page_number BIGINT,
    cp_description VARCHAR(100),
    cp_type VARCHAR(100)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/catalog_page/'
);

CREATE TABLE IF NOT EXISTS catalog_returns (
    cr_returned_date_sk BIGINT,
    cr_returned_time_sk BIGINT,
    cr_item_sk BIGINT,
    cr_refunded_customer_sk BIGINT,
    cr_refunded_cdemo_sk BIGINT,
    cr_refunded_hdemo_sk BIGINT,
    cr_refunded_addr_sk BIGINT,
    cr_returning_customer_sk BIGINT,
    cr_returning_cdemo_sk BIGINT,
    cr_returning_hdemo_sk BIGINT,
    cr_returning_addr_sk BIGINT,
    cr_call_center_sk BIGINT,
    cr_catalog_page_sk BIGINT,
    cr_ship_mode_sk BIGINT,
    cr_warehouse_sk BIGINT,
    cr_reason_sk BIGINT,
    cr_order_number BIGINT,
    cr_return_quantity BIGINT,
    cr_return_amount DECIMAL(7,2),
    cr_return_tax DECIMAL(7,2),
    cr_return_amt_inc_tax DECIMAL(7,2),
    cr_fee DECIMAL(7,2),
    cr_return_ship_cost DECIMAL(7,2),
    cr_refunded_cash DECIMAL(7,2),
    cr_reversed_charge DECIMAL(7,2),
    cr_store_credit DECIMAL(7,2),
    cr_net_loss DECIMAL(7,2)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/catalog_returns/'
);

CREATE TABLE IF NOT EXISTS catalog_sales (
    cs_sold_date_sk BIGINT,
    cs_sold_time_sk BIGINT,
    cs_ship_date_sk BIGINT,
    cs_bill_customer_sk BIGINT,
    cs_bill_cdemo_sk BIGINT,
    cs_bill_hdemo_sk BIGINT,
    cs_bill_addr_sk BIGINT,
    cs_ship_customer_sk BIGINT,
    cs_ship_cdemo_sk BIGINT,
    cs_ship_hdemo_sk BIGINT,
    cs_ship_addr_sk BIGINT,
    cs_call_center_sk BIGINT,
    cs_catalog_page_sk BIGINT,
    cs_ship_mode_sk BIGINT,
    cs_warehouse_sk BIGINT,
    cs_item_sk BIGINT,
    cs_promo_sk BIGINT,
    cs_order_number BIGINT,
    cs_quantity BIGINT,
    cs_wholesale_cost DECIMAL(7,2),
    cs_list_price DECIMAL(7,2),
    cs_sales_price DECIMAL(7,2),
    cs_ext_discount_amt DECIMAL(7,2),
    cs_ext_sales_price DECIMAL(7,2),
    cs_ext_wholesale_cost DECIMAL(7,2),
    cs_ext_list_price DECIMAL(7,2),
    cs_ext_tax DECIMAL(7,2),
    cs_coupon_amt DECIMAL(7,2),
    cs_ext_ship_cost DECIMAL(7,2),
    cs_net_paid DECIMAL(7,2),
    cs_net_paid_inc_tax DECIMAL(7,2),
    cs_net_paid_inc_ship DECIMAL(7,2),
    cs_net_paid_inc_ship_tax DECIMAL(7,2),
    cs_net_profit DECIMAL(7,2)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/catalog_sales/'
);

CREATE TABLE IF NOT EXISTS customer (
    c_customer_sk BIGINT,
    c_customer_id VARCHAR(16),
    c_current_cdemo_sk BIGINT,
    c_current_hdemo_sk BIGINT,
    c_current_addr_sk BIGINT,
    c_first_shipto_date_sk BIGINT,
    c_first_sales_date_sk BIGINT,
    c_salutation VARCHAR(10),
    c_first_name VARCHAR(20),
    c_last_name VARCHAR(30),
    c_preferred_cust_flag VARCHAR(1),
    c_birth_day BIGINT,
    c_birth_month BIGINT,
    c_birth_year BIGINT,
    c_birth_country VARCHAR(20),
    c_login VARCHAR(13),
    c_email_address VARCHAR(50),
    c_last_review_date_sk BIGINT
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/customer/'
);

CREATE TABLE IF NOT EXISTS customer_address (
    ca_address_sk BIGINT,
    ca_address_id VARCHAR(16),
    ca_street_number VARCHAR(10),
    ca_street_name VARCHAR(60),
    ca_street_type VARCHAR(15),
    ca_suite_number VARCHAR(10),
    ca_city VARCHAR(60),
    ca_county VARCHAR(30),
    ca_state VARCHAR(2),
    ca_zip VARCHAR(10),
    ca_country VARCHAR(20),
    ca_gmt_offset DECIMAL(5,2),
    ca_location_type VARCHAR(20)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/customer_address/'
);

CREATE TABLE IF NOT EXISTS customer_demographics (
    cd_demo_sk BIGINT,
    cd_gender VARCHAR(1),
    cd_marital_status VARCHAR(1),
    cd_education_status VARCHAR(20),
    cd_purchase_estimate BIGINT,
    cd_credit_rating VARCHAR(10),
    cd_dep_count BIGINT,
    cd_dep_employed_count BIGINT,
    cd_dep_college_count BIGINT
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/customer_demographics/'
);

CREATE TABLE IF NOT EXISTS date_dim (
    d_date_sk BIGINT,
    d_date_id VARCHAR(16),
    d_date DATE,
    d_month_seq BIGINT,
    d_week_seq BIGINT,
    d_quarter_seq BIGINT,
    d_year BIGINT,
    d_dow BIGINT,
    d_moy BIGINT,
    d_dom BIGINT,
    d_qoy BIGINT,
    d_fy_year BIGINT,
    d_fy_quarter_seq BIGINT,
    d_fy_week_seq BIGINT,
    d_day_name VARCHAR(9),
    d_quarter_name VARCHAR(6),
    d_holiday VARCHAR(1),
    d_weekend VARCHAR(1),
    d_following_holiday VARCHAR(1),
    d_first_dom BIGINT,
    d_last_dom BIGINT,
    d_same_day_ly BIGINT,
    d_same_day_lq BIGINT,
    d_current_day VARCHAR(1),
    d_current_week VARCHAR(1),
    d_current_month VARCHAR(1),
    d_current_quarter VARCHAR(1),
    d_current_year VARCHAR(1)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/date_dim/'
);

CREATE TABLE IF NOT EXISTS household_demographics (
    hd_demo_sk BIGINT,
    hd_income_band_sk BIGINT,
    hd_buy_potential VARCHAR(15),
    hd_dep_count BIGINT,
    hd_vehicle_count BIGINT
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/household_demographics/'
);

CREATE TABLE IF NOT EXISTS income_band (
    ib_income_band_sk BIGINT,
    ib_lower_bound BIGINT,
    ib_upper_bound BIGINT
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/income_band/'
);

CREATE TABLE IF NOT EXISTS inventory (
    inv_date_sk BIGINT,
    inv_item_sk BIGINT,
    inv_warehouse_sk BIGINT,
    inv_quantity_on_hand BIGINT
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/inventory/'
);

CREATE TABLE IF NOT EXISTS item (
    i_item_sk BIGINT,
    i_item_id VARCHAR(16),
    i_rec_start_date DATE,
    i_rec_end_date DATE,
    i_item_desc VARCHAR(200),
    i_current_price DECIMAL(7,2),
    i_wholesale_cost DECIMAL(7,2),
    i_brand_id BIGINT,
    i_brand VARCHAR(50),
    i_class_id BIGINT,
    i_class VARCHAR(50),
    i_category_id BIGINT,
    i_category VARCHAR(50),
    i_manufact_id BIGINT,
    i_manufact VARCHAR(50),
    i_size VARCHAR(20),
    i_formulation VARCHAR(20),
    i_color VARCHAR(20),
    i_units VARCHAR(10),
    i_container VARCHAR(10),
    i_manager_id BIGINT,
    i_product_name VARCHAR(50)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/item/'
);

CREATE TABLE IF NOT EXISTS promotion (
    p_promo_sk BIGINT,
    p_promo_id VARCHAR(16),
    p_start_date_sk BIGINT,
    p_end_date_sk BIGINT,
    p_item_sk BIGINT,
    p_cost DECIMAL(15,2),
    p_response_targe BIGINT,
    p_promo_name VARCHAR(50),
    p_channel_dmail VARCHAR(1),
    p_channel_email VARCHAR(1),
    p_channel_catalog VARCHAR(1),
    p_channel_tv VARCHAR(1),
    p_channel_radio VARCHAR(1),
    p_channel_press VARCHAR(1),
    p_channel_event VARCHAR(1),
    p_channel_demo VARCHAR(1),
    p_channel_details VARCHAR(100),
    p_purpose VARCHAR(15),
    p_discount_active VARCHAR(1)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/promotion/'
);

CREATE TABLE IF NOT EXISTS reason (
    r_reason_sk BIGINT,
    r_reason_id VARCHAR(16),
    r_reason_desc VARCHAR(100)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/reason/'
);

CREATE TABLE IF NOT EXISTS ship_mode (
    sm_ship_mode_sk BIGINT,
    sm_ship_mode_id VARCHAR(16),
    sm_type VARCHAR(30),
    sm_code VARCHAR(10),
    sm_carrier VARCHAR(20),
    sm_contract VARCHAR(20)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/ship_mode/'
);

CREATE TABLE IF NOT EXISTS store (
    s_store_sk BIGINT,
    s_store_id VARCHAR(16),
    s_rec_start_date DATE,
    s_rec_end_date DATE,
    s_closed_date_sk BIGINT,
    s_store_name VARCHAR(50),
    s_number_employees BIGINT,
    s_floor_space BIGINT,
    s_hours VARCHAR(20),
    s_manager VARCHAR(40),
    s_market_id BIGINT,
    s_geography_class VARCHAR(100),
    s_market_desc VARCHAR(100),
    s_market_manager VARCHAR(40),
    s_division_id BIGINT,
    s_division_name VARCHAR(50),
    s_company_id BIGINT,
    s_company_name VARCHAR(50),
    s_street_number VARCHAR(10),
    s_street_name VARCHAR(60),
    s_street_type VARCHAR(15),
    s_suite_number VARCHAR(10),
    s_city VARCHAR(60),
    s_county VARCHAR(30),
    s_state VARCHAR(2),
    s_zip VARCHAR(10),
    s_country VARCHAR(20),
    s_gmt_offset DECIMAL(5,2),
    s_tax_precentage DECIMAL(5,2)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/store/'
);

CREATE TABLE IF NOT EXISTS store_returns (
    sr_returned_date_sk BIGINT,
    sr_return_time_sk BIGINT,
    sr_item_sk BIGINT,
    sr_customer_sk BIGINT,
    sr_cdemo_sk BIGINT,
    sr_hdemo_sk BIGINT,
    sr_addr_sk BIGINT,
    sr_store_sk BIGINT,
    sr_reason_sk BIGINT,
    sr_ticket_number BIGINT,
    sr_return_quantity BIGINT,
    sr_return_amt DECIMAL(7,2),
    sr_return_tax DECIMAL(7,2),
    sr_return_amt_inc_tax DECIMAL(7,2),
    sr_fee DECIMAL(7,2),
    sr_return_ship_cost DECIMAL(7,2),
    sr_refunded_cash DECIMAL(7,2),
    sr_reversed_charge DECIMAL(7,2),
    sr_store_credit DECIMAL(7,2),
    sr_net_loss DECIMAL(7,2)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/store_returns/'
);

CREATE TABLE IF NOT EXISTS store_sales (
    ss_sold_date_sk BIGINT,
    ss_sold_time_sk BIGINT,
    ss_item_sk BIGINT,
    ss_customer_sk BIGINT,
    ss_cdemo_sk BIGINT,
    ss_hdemo_sk BIGINT,
    ss_addr_sk BIGINT,
    ss_store_sk BIGINT,
    ss_promo_sk BIGINT,
    ss_ticket_number BIGINT,
    ss_quantity BIGINT,
    ss_wholesale_cost DECIMAL(7,2),
    ss_list_price DECIMAL(7,2),
    ss_sales_price DECIMAL(7,2),
    ss_ext_discount_amt DECIMAL(7,2),
    ss_ext_sales_price DECIMAL(7,2),
    ss_ext_wholesale_cost DECIMAL(7,2),
    ss_ext_list_price DECIMAL(7,2),
    ss_ext_tax DECIMAL(7,2),
    ss_coupon_amt DECIMAL(7,2),
    ss_net_paid DECIMAL(7,2),
    ss_net_paid_inc_tax DECIMAL(7,2),
    ss_net_profit DECIMAL(7,2)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/store_sales/'
);

CREATE TABLE IF NOT EXISTS time_dim (
    t_time_sk BIGINT,
    t_time_id VARCHAR(16),
    t_time BIGINT,
    t_hour BIGINT,
    t_minute BIGINT,
    t_second BIGINT,
    t_am_pm VARCHAR(2),
    t_shift VARCHAR(20),
    t_sub_shift VARCHAR(20),
    t_meal_time VARCHAR(20)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/time_dim/'
);

CREATE TABLE IF NOT EXISTS warehouse (
    w_warehouse_sk BIGINT,
    w_warehouse_id VARCHAR(16),
    w_warehouse_name VARCHAR(20),
    w_warehouse_sq_ft BIGINT,
    w_street_number VARCHAR(10),
    w_street_name VARCHAR(60),
    w_street_type VARCHAR(15),
    w_suite_number VARCHAR(10),
    w_city VARCHAR(60),
    w_county VARCHAR(30),
    w_state VARCHAR(2),
    w_zip VARCHAR(10),
    w_country VARCHAR(20),
    w_gmt_offset DECIMAL(5,2)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/warehouse/'
);

CREATE TABLE IF NOT EXISTS web_page (
    wp_web_page_sk BIGINT,
    wp_web_page_id VARCHAR(16),
    wp_rec_start_date DATE,
    wp_rec_end_date DATE,
    wp_creation_date_sk BIGINT,
    wp_access_date_sk BIGINT,
    wp_autogen_flag VARCHAR(1),
    wp_customer_sk BIGINT,
    wp_url VARCHAR(100),
    wp_type VARCHAR(50),
    wp_char_count BIGINT,
    wp_link_count BIGINT,
    wp_image_count BIGINT,
    wp_max_ad_count BIGINT
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/web_page/'
);

CREATE TABLE IF NOT EXISTS web_returns (
    wr_returned_date_sk BIGINT,
    wr_returned_time_sk BIGINT,
    wr_item_sk BIGINT,
    wr_refunded_customer_sk BIGINT,
    wr_refunded_cdemo_sk BIGINT,
    wr_refunded_hdemo_sk BIGINT,
    wr_refunded_addr_sk BIGINT,
    wr_returning_customer_sk BIGINT,
    wr_returning_cdemo_sk BIGINT,
    wr_returning_hdemo_sk BIGINT,
    wr_returning_addr_sk BIGINT,
    wr_web_page_sk BIGINT,
    wr_reason_sk BIGINT,
    wr_order_number BIGINT,
    wr_return_quantity BIGINT,
    wr_return_amt DECIMAL(7,2),
    wr_return_tax DECIMAL(7,2),
    wr_return_amt_inc_tax DECIMAL(7,2),
    wr_fee DECIMAL(7,2),
    wr_return_ship_cost DECIMAL(7,2),
    wr_refunded_cash DECIMAL(7,2),
    wr_reversed_charge DECIMAL(7,2),
    wr_account_credit DECIMAL(7,2),
    wr_net_loss DECIMAL(7,2)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/web_returns/'
);

CREATE TABLE IF NOT EXISTS web_sales (
    ws_sold_date_sk BIGINT,
    ws_sold_time_sk BIGINT,
    ws_ship_date_sk BIGINT,
    ws_item_sk BIGINT,
    ws_bill_customer_sk BIGINT,
    ws_bill_cdemo_sk BIGINT,
    ws_bill_hdemo_sk BIGINT,
    ws_bill_addr_sk BIGINT,
    ws_ship_customer_sk BIGINT,
    ws_ship_cdemo_sk BIGINT,
    ws_ship_hdemo_sk BIGINT,
    ws_ship_addr_sk BIGINT,
    ws_web_page_sk BIGINT,
    ws_web_site_sk BIGINT,
    ws_ship_mode_sk BIGINT,
    ws_warehouse_sk BIGINT,
    ws_promo_sk BIGINT,
    ws_order_number BIGINT,
    ws_quantity BIGINT,
    ws_wholesale_cost DECIMAL(7,2),
    ws_list_price DECIMAL(7,2),
    ws_sales_price DECIMAL(7,2),
    ws_ext_discount_amt DECIMAL(7,2),
    ws_ext_sales_price DECIMAL(7,2),
    ws_ext_wholesale_cost DECIMAL(7,2),
    ws_ext_list_price DECIMAL(7,2),
    ws_ext_tax DECIMAL(7,2),
    ws_coupon_amt DECIMAL(7,2),
    ws_ext_ship_cost DECIMAL(7,2),
    ws_net_paid DECIMAL(7,2),
    ws_net_paid_inc_tax DECIMAL(7,2),
    ws_net_paid_inc_ship DECIMAL(7,2),
    ws_net_paid_inc_ship_tax DECIMAL(7,2),
    ws_net_profit DECIMAL(7,2)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/web_sales/'
);

CREATE TABLE IF NOT EXISTS web_site (
    web_site_sk BIGINT,
    web_site_id VARCHAR(16),
    web_rec_start_date DATE,
    web_rec_end_date DATE,
    web_name VARCHAR(50),
    web_open_date_sk BIGINT,
    web_close_date_sk BIGINT,
    web_class VARCHAR(50),
    web_manager VARCHAR(40),
    web_mkt_id BIGINT,
    web_mkt_class VARCHAR(50),
    web_mkt_desc VARCHAR(100),
    web_market_manager VARCHAR(40),
    web_company_id BIGINT,
    web_company_name VARCHAR(50),
    web_street_number VARCHAR(10),
    web_street_name VARCHAR(60),
    web_street_type VARCHAR(15),
    web_suite_number VARCHAR(10),
    web_city VARCHAR(60),
    web_county VARCHAR(30),
    web_state VARCHAR(2),
    web_zip VARCHAR(10),
    web_country VARCHAR(20),
    web_gmt_offset DECIMAL(5,2),
    web_tax_percentage DECIMAL(5,2)
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://my-bucket/tpcds-sf1/web_site/'
);

