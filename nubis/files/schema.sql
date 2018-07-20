 CREATE SCHEMA v_idol;
CREATE SCHEMA v_txtindex;
CREATE SCHEMA autoscale;


CREATE TABLE autoscale.launches
(
    added_by_node varchar(15),
    start_time timestamp,
    end_time timestamp,
    duration_s int,
    reservationid varchar(20),
    ec2_instanceid varchar(20),
    node_address varchar(15),
    node_subnet_cidr varchar(25),
    replace_node_address varchar(15),
    node_public_address varchar(15),
    status varchar(120),
    is_running boolean,
    comment varchar(128)
);


CREATE TABLE autoscale.terminations
(
    queued_by_node varchar(15),
    removed_by_node varchar(15),
    start_time timestamp,
    end_time timestamp,
    duration_s int,
    ec2_instanceid varchar(20),
    node_address varchar(15),
    node_subnet_cidr varchar(25),
    node_public_address varchar(15),
    lifecycle_action_token varchar(128),
    lifecycle_action_asg varchar(128),
    status varchar(128),
    is_running boolean
);


CREATE TABLE autoscale.downNodes
(
    detected_by_node varchar(15),
    trigger_termination_time timestamp,
    node_down_since timestamp,
    ec2_instanceid varchar(20),
    node_address varchar(15),
    node_subnet_cidr varchar(25),
    status varchar(128)
);


CREATE TABLE public.locations
(
    location_id int NOT NULL,
    continent_code varchar(2),
    continent_name varchar(13),
    country_code varchar(2),
    country_name varchar(50),
    region_code varchar(2),
    region_name varchar(50),
    city_name varchar(50),
    latitude float,
    longitude float,
    geohash varchar(6),
    insert_date date
);

ALTER TABLE public.locations ADD CONSTRAINT locations_pk PRIMARY KEY (location_id) DISABLED;

CREATE TABLE public.product_channels
(
    product_channel_id int NOT NULL,
    product_channel varchar(100),
    partner varchar(50)
);

ALTER TABLE public.product_channels ADD CONSTRAINT product_channels_1 PRIMARY KEY (product_channel_id) DISABLED;

CREATE TABLE public.products
(
    product_id int NOT NULL,
    product_guid varchar(36) NOT NULL,
    product_name varchar(20) NOT NULL,
    product_version varchar(30) NOT NULL,
    product_version_major int,
    product_version_minor int,
    product_version_minor_suffix varchar(15),
    product_version_sub_a int,
    product_version_sub_a_suffix varchar(15),
    product_version_sub_b int,
    product_version_sub_b_suffix varchar(15),
    formatted_version_major varchar(7)
);

ALTER TABLE public.products ADD CONSTRAINT products_pk PRIMARY KEY (product_id) DISABLED;

CREATE TABLE public.ffos_dimensional_by_date
(
    _year_quarter varchar(7),
    date varchar(10),
    product varchar(20),
    v_prod_major varchar(7),
    prod_os varchar(50),
    v_prod_os varchar(50),
    continent_code varchar(2),
    cntry_code varchar(2),
    isp_name varchar(100),
    device_type varchar(100),
    tot_request_on_date int
);


CREATE TABLE public.f_bugs_snapshot_v2
(
    id  IDENTITY ,
    es_id varchar(255),
    bug_id varchar(255),
    bug_severity varchar(255),
    bug_status varchar(255),
    bug_version_num varchar(255),
    assigned_to varchar(255),
    component varchar(255),
    created_by varchar(255),
    created_ts timestamp,
    modified_by varchar(255),
    modified_ts timestamp,
    op_sys varchar(255),
    priority varchar(255),
    product varchar(255),
    qa_contact varchar(255),
    reported_by varchar(255),
    reporter varchar(255),
    version varchar(255),
    expires_on varchar(255),
    cf_due_date varchar(255),
    target_milestone varchar(255),
    short_desc varchar(1024),
    bug_status_resolution varchar(1024),
    keywords varchar(1024),
    snapshot_date date
);


CREATE TABLE public.f_bugs_status_resolution
(
    bug_id varchar(255),
    bug_severity varchar(55),
    short_desc varchar(1024),
    bug_status varchar(255),
    bug_status_previous varchar(255),
    status_update varchar(255),
    status_change_update date,
    curr_snapshot_date date
);


CREATE TABLE public.mozilla_staff
(
    employee_id varchar(255),
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(512),
    supervisory_organization varchar(255),
    cost_center varchar(255),
    functional_group varchar(255),
    manager_id varchar(255),
    manager_lastname varchar(255),
    manager_firstname varchar(255),
    is_manager varchar(2),
    hire_date date,
    location varchar(255),
    snapshot_date date
);


CREATE TABLE public.mozilla_staff_plus
(
    employee_id varchar(255),
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(512),
    supervisory_organization varchar(255),
    cost_center varchar(255),
    functional_group varchar(255),
    manager_id varchar(255),
    manager_lastname varchar(255),
    manager_firstname varchar(255),
    manager_email varchar(512),
    is_manager varchar(2),
    hire_date date,
    location varchar(255),
    home_city varchar(255),
    home_country varchar(255),
    home_postal varchar(255),
    desk_number varchar(255),
    snapshot_date date
);


CREATE TABLE public.firefox_download_counts
(
    date varchar(25),
    country_code varchar(25),
    count int,
    ua_family varchar(128),
    ua_major varchar(128),
    os_family varchar(128),
    product_name varchar(1024),
    product_type varchar(1024),
    download_type varchar(128),
    other varchar(1024),
    locale varchar(50)
);


CREATE TABLE public.adi_firefox_by_date_version_country_locale_channel
(
    ping_date date NOT NULL,
    version varchar(20) NOT NULL DEFAULT '',
    country varchar(80) NOT NULL DEFAULT '',
    locale varchar(50) NOT NULL DEFAULT '',
    release_channel varchar(100) NOT NULL DEFAULT '',
    ADI int
);

ALTER TABLE public.adi_firefox_by_date_version_country_locale_channel ADD CONSTRAINT C_PRIMARY PRIMARY KEY (ping_date, country, locale, version, release_channel) DISABLED;

CREATE TABLE public.a_downloads_locale_location_channel
(
    dates_Year int,
    dates_Month int,
    dates_Day_of_month int,
    dates_Date varchar(10),
    download_products_Name varchar(20),
    download_products_Major varchar(7),
    download_products_Version varchar(30),
    request_types_Type varchar(10),
    download_types_Type varchar(10),
    request_result_Result varchar(10),
    locales_Code varchar(15),
    locations_Continent_name varchar(13),
    locations_Country_name varchar(50),
    download_products_rebuild_Name varchar(20),
    download_products_rebuild_Channel varchar(20),
    download_requests_by_day_Total_Requests int,
    download_requests_by_day_fact_count int
);


CREATE TABLE public.releases
(
    is_released boolean,
    version_int int,
    version varchar(7),
    channel varchar(10),
    merge_date date,
    release_date date,
    product varchar(10)
);


CREATE TABLE public.adi_by_region
(
    yr char(4) NOT NULL,
    mnth char(2) NOT NULL,
    region varchar(50) NOT NULL,
    country_code char(2) NOT NULL,
    domain varchar(50) NOT NULL,
    tot_requests int,
    product varchar(20) NOT NULL
);

ALTER TABLE public.adi_by_region ADD CONSTRAINT C_PRIMARY PRIMARY KEY (yr, mnth, region, country_code, domain, product) DISABLED;

CREATE TABLE public.nagios_log_data
(
    event_occurred_at timestamp,
    incident_type varchar(64),
    host varchar(256),
    service varchar(256),
    status varchar(32),
    notify_by varchar(256),
    description varchar(2048),
    filename varchar(255) DEFAULT ''
);


CREATE TABLE public.snippet_count_20151104
(
    date date NOT NULL,
    ua_family varchar(64),
    ua_major int,
    os_family varchar(64),
    country_code char(2),
    snippet_id varchar(64),
    impression_count int,
    locale varchar(100),
    metric varchar(100),
    user_country char(2),
    campaign varchar(255)
)
PARTITION BY (date_part('month', snippet_count_20151104.date));


CREATE TABLE public.snippet_count_fennec_20151104
(
    utc_time varchar(255),
    local_time varchar(255),
    country_code varchar(255),
    country_name varchar(255),
    latitude varchar(255),
    longitude varchar(255),
    city varchar(255),
    domain_name varchar(255),
    org_name varchar(255),
    isp_name varchar(255),
    request_type varchar(255),
    request_url varchar(255),
    http_status_code varchar(255),
    response_size_in_bytes varchar(255),
    referring_url varchar(255),
    ua_family varchar(255),
    ua_major varchar(255),
    ua_minor varchar(255),
    os_family varchar(255),
    os_major varchar(255),
    os_minor varchar(255),
    device_family varchar(255),
    custom_field_1 varchar(255),
    custom_field_2 varchar(255),
    custom_field_3 varchar(255),
    filename varchar(255),
    snippet_id numeric(20,0),
    snippet_impression_date varchar(255)
);


CREATE TABLE public.vertica_backups
(
    backupDate date,
    sizeBytes int,
    node varchar(50),
    status varchar(15),
    snapshotDate date
);


CREATE TABLE public.adi_dimensional_by_date_test
(
    _year_quarter varchar(7),
    bl_date date,
    product varchar(20),
    v_prod_major varchar(7),
    prod_os varchar(50),
    v_prod_os varchar(50),
    channel varchar(100),
    locale varchar(50),
    continent_code varchar(2),
    cntry_code varchar(2),
    tot_requests_on_date int,
    distro_name varchar(100),
    distro_version varchar(100),
    buildid varchar(20)
);


CREATE TABLE public.v4_submissionwise_v5
(
    submission_date date,
    search_provider varchar(255),
    search_count int,
    country varchar(255),
    locale varchar(255),
    distribution_id varchar(255),
    default_provider varchar(255),
    profiles_matching int,
    profile_share float,
    intermediate_source varchar(255)
);


CREATE TABLE public.ut_monthly_rollups_old
(
    month char(7),
    search_provider varchar(255),
    search_count int,
    country varchar(255),
    locale varchar(255),
    distribution_id varchar(255),
    default_provider varchar(255),
    profiles_matching int,
    processed date
);


CREATE TABLE public.ut_monthly_rollups
(
    month date,
    search_provider varchar(255),
    search_count int,
    country varchar(255),
    locale varchar(255),
    distribution_id varchar(255),
    default_provider varchar(255),
    profiles_matching int,
    processed date
);


CREATE TABLE public.v4_submissionwise_v5_test
(
    submission_date date,
    search_provider varchar(255),
    search_count int,
    country varchar(255),
    locale varchar(255),
    distribution_id varchar(255),
    default_provider varchar(255),
    profiles_matching int,
    profile_share float,
    intermediate_source varchar(255)
);


CREATE TABLE public.search_cohort
(
    channel varchar(50),
    geo char(2),
    is_funnelcake boolean,
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active boolean,
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float
);


CREATE TABLE public.fx_desktop_er
(
    activity_date date,
    mau int,
    dau int,
    smooth_dau float,
    er float
);


CREATE TABLE public.fx_desktop_er_by_top_countries
(
    country char(2),
    activity_date date,
    mau int,
    dau int,
    smooth_dau float,
    er float
);


CREATE TABLE public.brain_juicer
(
    month_year date,
    country varchar(80),
    sample_size int,
    brand varchar(50),
    uba_as_io float,
    uba_as_browser float,
    mozilla_bpi float,
    non_profit_cc float,
    opinionated_cc float,
    innovative_cc float,
    inclusive_cc float,
    firefox_bpi float,
    independent float,
    trustworty float,
    non_profit float,
    empowering float,
    aware_health_of_internet float,
    aware_online_priv_sec float,
    aware_open_innovation float,
    aware_decentralization float,
    aware_web_literacy float,
    aware_digital_inclusion float,
    care_online_priv_sec float,
    care_open_innovation float,
    care_decentralization float,
    care_web_literacy float,
    care_inclusion float
);


CREATE TABLE public.statcounter
(
    st_date date,
    browser varchar(100),
    stat float,
    region varchar(75),
    device varchar(50)
);


CREATE TABLE public.v4_monthly
(
    geo varchar(10),
    channel varchar(10),
    os varchar(35),
    v4_date date,
    actives int,
    hours float,
    inactives int,
    new_records int,
    five_of_seven int,
    total_records int,
    crashes int,
    v4_default int,
    google int,
    bing int,
    yahoo int,
    other int
);


CREATE TABLE public.engagement_ratio
(
    day date,
    dau int,
    mau int,
    generated_on date
);


CREATE TABLE public.blocklistDecomposition
(
    bd_date date,
    dayNum int,
    dayOfWeek varchar(25),
    yearFreq float,
    adi float,
    trend float,
    seasonal float,
    weekly float,
    outlier float,
    noise float
);


CREATE TABLE public.fx_adjust_mobile
(
    fx_date date,
    maus float,
    daus float
);


CREATE TABLE public.search_cohort_churn_test
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    is_active varchar(3),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float,
    week_start date
);


CREATE TABLE public.search_cohort_churn_tmp
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    is_active varchar(3),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float,
    week_start date
);


CREATE TABLE public.mysql_status_counters
(
    mysql_host_id int,
    status_date date,
    Aborted_clients int,
    Aborted_connects int,
    Binlog_cache_disk_use int,
    Binlog_cache_use int,
    Binlog_stmt_cache_use int,
    Bytes_received int,
    Bytes_sent int,
    Com_admin_commands int,
    Com_begin int,
    Com_change_db int,
    Com_commit int,
    Com_create_db int,
    Com_create_table int,
    Com_delete int,
    Com_insert int,
    Com_insert_select int,
    Com_replace int,
    Com_replace_select int,
    Com_select int,
    Com_set_option int,
    Com_show_create_table int,
    Com_show_databases int,
    Com_show_engine_status int,
    Com_show_fields int,
    Com_show_grants int,
    Com_show_processlist int,
    Com_show_slave_status int,
    Com_show_status int,
    Com_show_tables int,
    Com_show_variables int,
    Com_truncate int,
    Com_update int,
    Connections int,
    Created_tmp_disk_tables int,
    Created_tmp_tables int,
    Handler_commit int,
    Handler_delete int,
    Handler_external_lock int,
    Handler_prepare int,
    Handler_read_first int,
    Handler_read_key int,
    Handler_read_next int,
    Handler_read_rnd int,
    Handler_read_rnd_next int,
    Handler_update int,
    Handler_write int,
    Innodb_buffer_pool_bytes_data int,
    Innodb_buffer_pool_pages_flushed int,
    Innodb_buffer_pool_read_ahead int,
    Innodb_buffer_pool_read_ahead_evicted int,
    Innodb_buffer_pool_read_requests int,
    Innodb_buffer_pool_reads int,
    Innodb_buffer_pool_write_requests int,
    Innodb_data_fsyncs int,
    Innodb_data_read int,
    Innodb_data_reads int,
    Innodb_data_writes int,
    Innodb_data_written int,
    Innodb_dblwr_pages_written int,
    Innodb_dblwr_writes int,
    Innodb_log_write_requests int,
    Innodb_log_writes int,
    Innodb_os_log_fsyncs int,
    Innodb_os_log_written int,
    Innodb_pages_created int,
    Innodb_pages_read int,
    Innodb_pages_written int,
    Innodb_rows_deleted int,
    Innodb_rows_inserted int,
    Innodb_rows_read int,
    Innodb_rows_updated int,
    Innodb_num_open_files int,
    Innodb_available_undo_logs int,
    Key_read_requests int,
    Key_reads int,
    Key_write_requests int,
    Key_writes int,
    Open_table_definitions int,
    Opened_files int,
    Opened_table_definitions int,
    Opened_tables int,
    Queries int,
    Questions int,
    Select_range int,
    Select_scan int,
    Slow_queries int,
    Sort_rows int,
    Sort_scan int,
    Table_locks_immediate int,
    Table_open_cache_hits int,
    Table_open_cache_misses int,
    Uptime int
);


CREATE TABLE public.mysql_host
(
    id  IDENTITY ,
    name varchar(250)
);

ALTER TABLE public.mysql_host ADD CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED;

CREATE TABLE public.mysql_system
(
    mysql_host_id int,
    system_type varchar(250),
    system_os varchar(250),
    system_os_release varchar(250),
    is_virtual boolean,
    virtualized varchar(250),
    processor varchar(250),
    processor_speed varchar(250),
    processor_model varchar(250),
    memory varchar(250),
    memory_free varchar(250),
    disk_size int
);


CREATE TABLE public.mysql_host_metrics
(
    mysql_host_id int,
    metrics_date date,
    version varchar(250),
    full_text_index boolean,
    geospatial boolean,
    ssl boolean,
    binlog_format varchar(250),
    default_storage_engine varchar(250),
    sql_mode varchar(250)
);


CREATE TABLE public.mysql_database
(
    mysql_host_id int,
    database_date date,
    name varchar(250),
    innodb_tables int,
    myisam_tables int,
    csv_tables int
);


CREATE TABLE public.adjust_ios_monthly
(
    adj_date date,
    daus float,
    waus float,
    maus float
);


CREATE TABLE public.adjust_android_monthly
(
    adj_date date,
    daus float,
    waus float,
    maus float
);


CREATE TABLE public.adjust_focus_monthly
(
    adj_date date,
    daus float,
    waus float,
    maus float,
    installs int
);


CREATE TABLE public.adjust_klar_monthly
(
    adj_date date,
    daus float,
    waus float,
    maus float,
    installs int
);


CREATE TABLE public.sfmc
(
    sf_date timestamp,
    email_program varchar(50),
    first_run_source char(5),
    country varchar(50),
    language char(2),
    metric varchar(50),
    value int
);


CREATE TABLE public.sfmc_emails_sent_html
(
    id int NOT NULL,
    value int
);


CREATE TABLE public.sfmc_emails_sent
(
    id int NOT NULL,
    value int
);


CREATE TABLE public.sfmc_clicks
(
    id int NOT NULL,
    value int
);


CREATE TABLE public.sfmc_bounces
(
    id int NOT NULL,
    value int
);


CREATE TABLE public.sfmc_base
(
    id  IDENTITY ,
    sf_date timestamp,
    email_program varchar(50),
    first_run_source char(5),
    country varchar(50),
    language char(2),
    metric varchar(50),
    value int
);

ALTER TABLE public.sfmc_base ADD CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED;

CREATE TABLE public.sfmc_opens
(
    id int NOT NULL,
    value int
);


CREATE TABLE public.cohort_churn
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active varchar(3),
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float
);


CREATE TABLE public.raw_scvp_okr
(
    id  IDENTITY ,
    update_date date DEFAULT (now())::date,
    accountable_scvp varchar(250),
    okr varchar(250),
    status long varchar(1000),
    score varchar(10),
    metric_start varchar(10),
    current_metric varchar(10),
    target_metric varchar(250),
    cur_month_status varchar(250),
    next_milestone varchar(250),
    status_owner varchar(250),
    data_source varchar(250),
    data_owner varchar(250)
);

ALTER TABLE public.raw_scvp_okr ADD CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED;

CREATE TABLE public.copy_cohort_churn
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active varchar(3),
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float
);


CREATE TABLE public.fx_market_share
(
    fx_date date,
    fx_mkt_share float
);


CREATE TABLE public.sfmc_tmp
(
    sf_date timestamp,
    email_program varchar(50),
    first_run_source char(5),
    country varchar(50),
    language char(2),
    metric varchar(50),
    value int
);


CREATE TABLE public.fx_product_tmp
(
    geo varchar(10),
    channel varchar(10),
    os varchar(35),
    v4_date date,
    actives int,
    hours float,
    inactives int,
    new_records int,
    five_of_seven int,
    total_records int,
    crashes int,
    v4_default int,
    google int,
    bing int,
    yahoo int,
    other int,
    dau int,
    adi int
);


CREATE TABLE public.org_okr_stage
(
    type varchar(50),
    status varchar(10),
    okr varchar(250),
    responsible varchar(250),
    monthly_status varchar(250),
    next_major_milestone varchar(250),
    metric_at_start varchar(10),
    current_metric varchar(10),
    target_metric varchar(10),
    score varchar(10),
    data_source varchar(250),
    data_owner varchar(250),
    mozilla_okr varchar(50),
    org_level_okr varchar(250),
    modified_on varchar(250),
    modified_by varchar(250)
);


CREATE TABLE public.org_okr_group
(
    id  IDENTITY ,
    ts timestamp DEFAULT now(),
    name varchar(255)
);

ALTER TABLE public.org_okr_group ADD CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED;

CREATE TABLE public.org_okr_type
(
    type_id  IDENTITY ,
    group_id int,
    duration varchar(255),
    okr_type varchar(250),
    status varchar(50),
    okr_name varchar(255),
    responsible varchar(255),
    monthly_status varchar(255),
    next_major_milestone varchar(250),
    score varchar(250),
    metric_at_start varchar(10),
    current_metric varchar(10),
    target_metric varchar(10),
    data_source varchar(250),
    data_owner varchar(250),
    modified_on varchar(250),
    modified_by varchar(250)
);

ALTER TABLE public.org_okr_type ADD CONSTRAINT C_PRIMARY PRIMARY KEY (type_id) DISABLED;

CREATE TABLE public.org_okr_keyresult
(
    type_id int,
    duration varchar(255),
    okr_type varchar(250),
    status varchar(50),
    kr_name varchar(255),
    responsible varchar(255),
    monthly_status varchar(255),
    next_major_milestone varchar(250),
    score varchar(250),
    metric_at_start varchar(10),
    current_metric varchar(10),
    target_metric varchar(10),
    data_source varchar(250),
    data_owner varchar(250),
    modified_on varchar(250),
    modified_by varchar(250)
);


CREATE TABLE public.search_cohort_churn
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active varchar(3),
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float,
    week_start date
);


CREATE TABLE public.net_neutrality_petition
(
    ts timestamp,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    locale char(5)
);


CREATE TABLE public.open_data_day
(
    ts timestamp,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    locale char(5)
);


CREATE TABLE public.sf_donation_count
(
    opp_name varchar(20),
    opp_type varchar(50),
    lead_source varchar(50),
    amount float,
    close_date date,
    next_step varchar(50),
    stage varchar(20),
    probability int,
    fiscal_period char(7),
    age float,
    created_date date,
    opp_owner varchar(50),
    owner_role varchar(50),
    account_name varchar(50)
);


CREATE TABLE public.statcounter_monthly
(
    st_date date,
    stat float
);


CREATE TABLE public.tmp_search_cohort_churn
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active varchar(3),
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float,
    week_start date
);


CREATE TABLE public.fhr_rollups_monthly_base
(
    vendor varchar(50),
    name varchar(50),
    channel varchar(50),
    os varchar(50),
    osdetail varchar(50),
    distribution varchar(50),
    locale varchar(50),
    geo varchar(50),
    version varchar(50),
    isstdprofile varchar(50),
    stdchannel varchar(50),
    stdos varchar(50),
    distribtype varchar(50),
    snapshot varchar(50),
    granularity varchar(50),
    timeStart varchar(50),
    timeEnd varchar(50),
    tTotalProfiles int,
    tExistingProfiles int,
    tNewProfiles int,
    tActiveProfiles int,
    tInActiveProfiles int,
    tActiveDays int,
    tTotalSeconds int,
    tActiveSeconds int,
    tNumSessions int,
    tCrashes int,
    tTotalSearch int,
    tGoogleSearch int,
    tYahooSearch int,
    tBingSearch int,
    tOfficialSearch int,
    tIsDefault int,
    tIsActiveProfileDefault int,
    t5outOf7 int,
    tChurned int,
    tHasUP int
);


CREATE TABLE public.fhr_rollups_monthly_base_2015
(
    vendor varchar(50),
    name varchar(50),
    channel varchar(50),
    os varchar(50),
    osdetail varchar(50),
    distribution varchar(50),
    locale varchar(50),
    geo varchar(50),
    version varchar(50),
    isstdprofile varchar(50),
    stdchannel varchar(50),
    stdos varchar(50),
    distribtype varchar(50),
    snapshot varchar(50),
    granularity varchar(50),
    timeStart varchar(50),
    timeEnd varchar(50),
    tTotalProfiles int,
    tExistingProfiles int,
    tNewProfiles int,
    tActiveProfiles int,
    tInActiveProfiles int,
    tActiveDays int,
    tTotalSeconds int,
    tActiveSeconds int,
    tNumSessions int,
    tCrashes int,
    tTotalSearch int,
    tGoogleSearch int,
    tYahooSearch int,
    tBingSearch int,
    tOfficialSearch int,
    tIsDefault int,
    tIsActiveProfileDefault int,
    t5outOf7 int,
    tChurned int,
    tHasUP int
);


CREATE TABLE public.churn_cohort
(
    channel varchar(50),
    country char(2),
    is_funnelcake boolean,
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    week_since_acquisition int,
    is_active boolean,
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float
);


CREATE TABLE public.fx_attribution
(
    profiles_count int,
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250)
);


CREATE TABLE public.copy_adi_dimensional_by_date_s3
(
    _year_quarter varchar(7),
    bl_date date,
    product varchar(20),
    v_prod_major varchar(7),
    prod_os varchar(50),
    v_prod_os varchar(50),
    channel varchar(100),
    locale varchar(50),
    continent_code varchar(2),
    cntry_code varchar(2),
    tot_requests_on_date int,
    distro_name varchar(100),
    distro_version varchar(100),
    buildid varchar(20) DEFAULT ''
);


CREATE TABLE public.snippet_count
(
    date date NOT NULL,
    ua_family varchar(64),
    ua_major int,
    os_family varchar(64),
    country_code char(2),
    snippet_id varchar(64),
    impression_count int,
    locale varchar(100),
    metric varchar(100) DEFAULT '',
    user_country char(2),
    campaign varchar(255)
)
PARTITION BY (date_part('month', snippet_count.date));


CREATE TABLE public.ut_desktop_daily_active_users_extended
(
    day date,
    mau int,
    dau int,
    smooth_dau float
);


CREATE TABLE public.f_bugs_status_changes
(
    bug_id varchar(255),
    bug_severity varchar(255),
    bug_status_current varchar(255),
    bug_status_previous varchar(255),
    bug_version_num varchar(255),
    assigned_to varchar(255),
    component varchar(255),
    created_by varchar(255),
    created_ts timestamp,
    modified_by varchar(255),
    modified_ts timestamp,
    op_sys varchar(255),
    priority varchar(255),
    product varchar(255),
    qa_contact varchar(255),
    reported_by varchar(255),
    reporter varchar(255),
    version varchar(255),
    expires_on varchar(255),
    cf_due_date varchar(255),
    target_milestone varchar(255),
    keywords varchar(1024),
    snapshot_date date,
    load_date date,
    load_source varchar(100)
);


CREATE TABLE public.snippet_count_fennec
(
    utc_time varchar(255),
    local_time varchar(255),
    country_code varchar(255),
    country_name varchar(255),
    latitude varchar(255),
    longitude varchar(255),
    city varchar(255),
    domain_name varchar(255),
    org_name varchar(255),
    isp_name varchar(255),
    request_type varchar(255),
    request_url varchar(255),
    http_status_code varchar(255),
    response_size_in_bytes varchar(255),
    referring_url varchar(255),
    ua_family varchar(255),
    ua_major varchar(255),
    ua_minor varchar(255),
    os_family varchar(255),
    os_major varchar(255),
    os_minor varchar(255),
    device_family varchar(255),
    custom_field_1 varchar(255),
    custom_field_2 varchar(255),
    custom_field_3 varchar(255),
    filename varchar(255),
    snippet_id numeric(20,0),
    snippet_impression_date varchar(255)
);


CREATE TABLE public.user_locales
(
    raw_locale varchar(255),
    normalized_locale varchar(255)
);


CREATE TABLE public.redash_focus_retention
(
    os varchar(10),
    cohort date,
    week date,
    cohort_size int,
    weeK_num int,
    active_users int
);


CREATE TABLE public.mobile_daily_active_users
(
    app varchar(20),
    os varchar(20),
    day date,
    dau int,
    smooth_dau float,
    wau int,
    mau int,
    weekly_engagement numeric(5,2),
    monthly_engagement numeric(5,2)
);


CREATE TABLE public.adjust_fennec_retention_by_os
(
    date date,
    os varchar(10),
    period int,
    retention numeric(5,4)
);


CREATE TABLE public.adjust_ios_daily_active_users
(
    adj_date date,
    daus float,
    waus float,
    maus float
);


CREATE TABLE public.adjust_android_daily_active_users
(
    adj_date date,
    daus float,
    waus float,
    maus float
);


CREATE TABLE public.adjust_focus_daily_active_users
(
    adj_date date,
    daus float,
    waus float,
    maus float,
    installs int
);


CREATE TABLE public.adjust_klar_daily_active_users
(
    adj_date date,
    daus float,
    waus float,
    maus float,
    installs int
);


CREATE TABLE public.sf_donations
(
    opp_name varchar(20),
    amount numeric(18,2),
    contact_id varchar(50)
);


CREATE TABLE public.sf_foundation_signups
(
    contact_id varchar(50),
    signup_date timestamptz
);


CREATE TABLE public.sf_copyright_petition
(
    contact_id varchar(50),
    signed_on_date date
);


CREATE TABLE public.sf_contacts
(
    id varchar(50),
    created_date timestamp,
    email varchar(255),
    email_format varchar(1),
    contact_name varchar(255),
    email_language varchar(10),
    signup_source_url varchar(500),
    confirmation_miti_subscriber boolean,
    sub_apps_and_hacks boolean,
    sub_firefox_and_you boolean,
    sub_firefox_accounts_journey boolean,
    sub_mozilla_foundation boolean,
    sub_miti_subscriber boolean,
    sub_mozilla_leadership_network boolean,
    sub_mozilla_learning_network boolean,
    sub_webmaker boolean,
    sub_mozillians_nda boolean,
    sub_open_innovation_subscriber boolean,
    subscriber boolean,
    sub_test_flight boolean,
    sub_test_pilot boolean,
    sub_view_source_global boolean,
    sub_view_source_namerica boolean,
    double_opt_in boolean,
    unengaged boolean,
    email_opt_out boolean,
    mailing_country varchar(255)
);


CREATE TABLE public.adjust_retention
(
    date date,
    os varchar(10),
    period int,
    retention numeric(5,4),
    app varchar(10)
);


CREATE TABLE public.adjust_daily_active_users
(
    adj_date date,
    os varchar(10),
    daus float,
    waus float,
    maus float,
    installs int,
    app varchar(10)
);


CREATE TABLE public.adjust_retention_test
(
    date date,
    os varchar(10),
    period int,
    retention numeric(5,4),
    app varchar(10)
);


CREATE TABLE public.adjust_daily_active_users_test
(
    adj_date date,
    os varchar(10),
    daus float,
    waus float,
    maus float,
    installs int,
    app varchar(10)
);


CREATE TABLE public.last_updated
(
    name varchar(100) NOT NULL,
    updated_at timestamp,
    updated_by varchar(255)
);

ALTER TABLE public.last_updated ADD CONSTRAINT C_PRIMARY PRIMARY KEY (name) DISABLED;

CREATE TABLE public.ut_desktop_daily_active_users
(
    day date,
    mau int,
    dau int,
    smooth_dau float,
    engagement_ratio numeric(5,2)
);


CREATE TABLE public.opt_dates
(
    date_id int NOT NULL,
    year int,
    month int,
    day_of_year int,
    day_of_month int,
    day_of_week int,
    week_of_year int,
    day_of_week_desc varchar(10),
    day_of_week_short_desc varchar(3),
    month_desc varchar(10),
    month_short_desc varchar(3),
    quarter int,
    is_weekday varchar(1),
    date date
);

ALTER TABLE public.opt_dates ADD CONSTRAINT C_PRIMARY PRIMARY KEY (date_id) DISABLED;

CREATE TABLE public.country_names
(
    code varchar(10),
    country varchar(100)
);


CREATE TABLE public.copy_adi_dimensional_by_date
(
    _year_quarter varchar(7),
    bl_date date,
    product varchar(20),
    v_prod_major varchar(7),
    prod_os varchar(50),
    v_prod_os varchar(50),
    channel varchar(100),
    locale varchar(50),
    continent_code varchar(2),
    cntry_code varchar(2),
    tot_requests_on_date int,
    distro_name varchar(100),
    distro_version varchar(100),
    buildid varchar(20) DEFAULT ''
);


CREATE TABLE public.pocket_mobile_daily_active_users
(
    activity_date date,
    platform varchar(255),
    dau int,
    wau_rolling_7 int,
    mau_rolling_30 int,
    mau_rolling_31 int,
    mau_rolling_28 int,
    app varchar(6)
);


CREATE TABLE public.reviews
(
    ID varchar(80) NOT NULL,
    Store varchar(80) NOT NULL,
    Device varchar(80) NOT NULL,
    Source varchar(80) NOT NULL,
    Country varchar(80),
    "Review Date" date NOT NULL,
    Version float NOT NULL,
    Rating varchar(80),
    "Original Reviews" varchar(4000) NOT NULL,
    "Translated Reviews" varchar(4000) NOT NULL,
    Sentiment varchar(80) NOT NULL,
    Spam int,
    "Verb Phrases" varchar(4000),
    "Noun Phrases" varchar(4000),
    "Clear Filters" varchar(80)
);

ALTER TABLE public.reviews ADD CONSTRAINT C_PRIMARY PRIMARY KEY (ID) DISABLED;

CREATE TABLE public.categorization
(
    ID varchar(80) NOT NULL,
    Feature varchar(80) NOT NULL,
    Component varchar(80) NOT NULL,
    theAction varchar(4000)
);


CREATE TABLE public.key_issue
(
    ID varchar(80) NOT NULL,
    "Key Issue" varchar(80) NOT NULL
);


CREATE PROJECTION autoscale.launches_super /*+basename(launches),createtype(P)*/ 
(
 added_by_node,
 start_time,
 end_time,
 duration_s,
 reservationid,
 ec2_instanceid,
 node_address,
 node_subnet_cidr,
 replace_node_address,
 node_public_address,
 status,
 is_running,
 comment
)
AS
 SELECT launches.added_by_node,
        launches.start_time,
        launches.end_time,
        launches.duration_s,
        launches.reservationid,
        launches.ec2_instanceid,
        launches.node_address,
        launches.node_subnet_cidr,
        launches.replace_node_address,
        launches.node_public_address,
        launches.status,
        launches.is_running,
        launches.comment
 FROM autoscale.launches
 ORDER BY launches.start_time
UNSEGMENTED ALL NODES;

CREATE PROJECTION autoscale.terminations_super /*+basename(terminations),createtype(P)*/ 
(
 queued_by_node,
 removed_by_node,
 start_time,
 end_time,
 duration_s,
 ec2_instanceid,
 node_address,
 node_subnet_cidr,
 node_public_address,
 lifecycle_action_token,
 lifecycle_action_asg,
 status,
 is_running
)
AS
 SELECT terminations.queued_by_node,
        terminations.removed_by_node,
        terminations.start_time,
        terminations.end_time,
        terminations.duration_s,
        terminations.ec2_instanceid,
        terminations.node_address,
        terminations.node_subnet_cidr,
        terminations.node_public_address,
        terminations.lifecycle_action_token,
        terminations.lifecycle_action_asg,
        terminations.status,
        terminations.is_running
 FROM autoscale.terminations
 ORDER BY terminations.start_time
UNSEGMENTED ALL NODES;

CREATE PROJECTION autoscale.downNodes_super /*+basename(downNodes),createtype(P)*/ 
(
 detected_by_node,
 trigger_termination_time,
 node_down_since,
 ec2_instanceid,
 node_address,
 node_subnet_cidr,
 status
)
AS
 SELECT downNodes.detected_by_node,
        downNodes.trigger_termination_time,
        downNodes.node_down_since,
        downNodes.ec2_instanceid,
        downNodes.node_address,
        downNodes.node_subnet_cidr,
        downNodes.status
 FROM autoscale.downNodes
 ORDER BY downNodes.detected_by_node,
          downNodes.trigger_termination_time,
          downNodes.node_down_since,
          downNodes.ec2_instanceid,
          downNodes.node_address,
          downNodes.node_subnet_cidr,
          downNodes.status
UNSEGMENTED ALL NODES;

CREATE PROJECTION public.adi_by_region /*+createtype(L)*/ 
(
 yr,
 mnth,
 region,
 country_code,
 domain,
 tot_requests,
 product
)
AS
 SELECT adi_by_region.yr,
        adi_by_region.mnth,
        adi_by_region.region,
        adi_by_region.country_code,
        adi_by_region.domain,
        adi_by_region.tot_requests,
        adi_by_region.product
 FROM public.adi_by_region
 ORDER BY adi_by_region.yr,
          adi_by_region.mnth,
          adi_by_region.region,
          adi_by_region.country_code,
          adi_by_region.domain,
          adi_by_region.product
SEGMENTED BY hash(adi_by_region.yr, adi_by_region.mnth, adi_by_region.region, adi_by_region.country_code, adi_by_region.domain, adi_by_region.product) ALL NODES KSAFE 1;

CREATE PROJECTION public.adi_dimensional_by_date_test /*+createtype(L)*/ 
(
 _year_quarter,
 bl_date,
 product,
 v_prod_major,
 prod_os,
 v_prod_os,
 channel,
 locale,
 continent_code,
 cntry_code,
 tot_requests_on_date,
 distro_name,
 distro_version,
 buildid
)
AS
 SELECT adi_dimensional_by_date_test._year_quarter,
        adi_dimensional_by_date_test.bl_date,
        adi_dimensional_by_date_test.product,
        adi_dimensional_by_date_test.v_prod_major,
        adi_dimensional_by_date_test.prod_os,
        adi_dimensional_by_date_test.v_prod_os,
        adi_dimensional_by_date_test.channel,
        adi_dimensional_by_date_test.locale,
        adi_dimensional_by_date_test.continent_code,
        adi_dimensional_by_date_test.cntry_code,
        adi_dimensional_by_date_test.tot_requests_on_date,
        adi_dimensional_by_date_test.distro_name,
        adi_dimensional_by_date_test.distro_version,
        adi_dimensional_by_date_test.buildid
 FROM public.adi_dimensional_by_date_test
 ORDER BY adi_dimensional_by_date_test._year_quarter,
          adi_dimensional_by_date_test.bl_date,
          adi_dimensional_by_date_test.product,
          adi_dimensional_by_date_test.v_prod_major,
          adi_dimensional_by_date_test.prod_os,
          adi_dimensional_by_date_test.v_prod_os,
          adi_dimensional_by_date_test.channel,
          adi_dimensional_by_date_test.locale,
          adi_dimensional_by_date_test.continent_code,
          adi_dimensional_by_date_test.cntry_code,
          adi_dimensional_by_date_test.tot_requests_on_date,
          adi_dimensional_by_date_test.distro_name,
          adi_dimensional_by_date_test.distro_version,
          adi_dimensional_by_date_test.buildid
SEGMENTED BY hash(adi_dimensional_by_date_test._year_quarter, adi_dimensional_by_date_test.bl_date, adi_dimensional_by_date_test.v_prod_major, adi_dimensional_by_date_test.continent_code, adi_dimensional_by_date_test.cntry_code, adi_dimensional_by_date_test.tot_requests_on_date, adi_dimensional_by_date_test.product, adi_dimensional_by_date_test.buildid, adi_dimensional_by_date_test.prod_os, adi_dimensional_by_date_test.v_prod_os, adi_dimensional_by_date_test.locale, adi_dimensional_by_date_test.channel, adi_dimensional_by_date_test.distro_name, adi_dimensional_by_date_test.distro_version) ALL NODES KSAFE 1;

CREATE PROJECTION public.adi_firefox_by_date_version_country_locale_channel /*+createtype(L)*/ 
(
 ping_date,
 version,
 country,
 locale,
 release_channel,
 ADI
)
AS
 SELECT adi_firefox_by_date_version_country_locale_channel.ping_date,
        adi_firefox_by_date_version_country_locale_channel.version,
        adi_firefox_by_date_version_country_locale_channel.country,
        adi_firefox_by_date_version_country_locale_channel.locale,
        adi_firefox_by_date_version_country_locale_channel.release_channel,
        adi_firefox_by_date_version_country_locale_channel.ADI
 FROM public.adi_firefox_by_date_version_country_locale_channel
 ORDER BY adi_firefox_by_date_version_country_locale_channel.ping_date,
          adi_firefox_by_date_version_country_locale_channel.country,
          adi_firefox_by_date_version_country_locale_channel.locale,
          adi_firefox_by_date_version_country_locale_channel.version,
          adi_firefox_by_date_version_country_locale_channel.release_channel
SEGMENTED BY hash(adi_firefox_by_date_version_country_locale_channel.ping_date, adi_firefox_by_date_version_country_locale_channel.country, adi_firefox_by_date_version_country_locale_channel.locale, adi_firefox_by_date_version_country_locale_channel.version, adi_firefox_by_date_version_country_locale_channel.release_channel) ALL NODES KSAFE 1;

CREATE PROJECTION public.copy_adi_dimensional_by_date_s3 /*+createtype(L)*/ 
(
 _year_quarter,
 bl_date,
 product,
 v_prod_major,
 prod_os,
 v_prod_os,
 channel,
 locale,
 continent_code,
 cntry_code,
 tot_requests_on_date,
 distro_name,
 distro_version,
 buildid
)
AS
 SELECT copy_adi_dimensional_by_date_s3._year_quarter,
        copy_adi_dimensional_by_date_s3.bl_date,
        copy_adi_dimensional_by_date_s3.product,
        copy_adi_dimensional_by_date_s3.v_prod_major,
        copy_adi_dimensional_by_date_s3.prod_os,
        copy_adi_dimensional_by_date_s3.v_prod_os,
        copy_adi_dimensional_by_date_s3.channel,
        copy_adi_dimensional_by_date_s3.locale,
        copy_adi_dimensional_by_date_s3.continent_code,
        copy_adi_dimensional_by_date_s3.cntry_code,
        copy_adi_dimensional_by_date_s3.tot_requests_on_date,
        copy_adi_dimensional_by_date_s3.distro_name,
        copy_adi_dimensional_by_date_s3.distro_version,
        copy_adi_dimensional_by_date_s3.buildid
 FROM public.copy_adi_dimensional_by_date_s3
 ORDER BY copy_adi_dimensional_by_date_s3._year_quarter,
          copy_adi_dimensional_by_date_s3.bl_date,
          copy_adi_dimensional_by_date_s3.product,
          copy_adi_dimensional_by_date_s3.v_prod_major,
          copy_adi_dimensional_by_date_s3.prod_os,
          copy_adi_dimensional_by_date_s3.v_prod_os,
          copy_adi_dimensional_by_date_s3.channel,
          copy_adi_dimensional_by_date_s3.locale,
          copy_adi_dimensional_by_date_s3.continent_code,
          copy_adi_dimensional_by_date_s3.cntry_code,
          copy_adi_dimensional_by_date_s3.tot_requests_on_date,
          copy_adi_dimensional_by_date_s3.distro_name,
          copy_adi_dimensional_by_date_s3.distro_version,
          copy_adi_dimensional_by_date_s3.buildid
SEGMENTED BY hash(copy_adi_dimensional_by_date_s3._year_quarter, copy_adi_dimensional_by_date_s3.bl_date, copy_adi_dimensional_by_date_s3.v_prod_major, copy_adi_dimensional_by_date_s3.continent_code, copy_adi_dimensional_by_date_s3.cntry_code, copy_adi_dimensional_by_date_s3.tot_requests_on_date, copy_adi_dimensional_by_date_s3.product, copy_adi_dimensional_by_date_s3.buildid, copy_adi_dimensional_by_date_s3.prod_os, copy_adi_dimensional_by_date_s3.v_prod_os, copy_adi_dimensional_by_date_s3.locale, copy_adi_dimensional_by_date_s3.channel, copy_adi_dimensional_by_date_s3.distro_name, copy_adi_dimensional_by_date_s3.distro_version) ALL NODES KSAFE 1;

CREATE PROJECTION public.copy_adi_dimensional_by_date /*+createtype(L)*/ 
(
 _year_quarter,
 bl_date,
 product,
 v_prod_major,
 prod_os,
 v_prod_os,
 channel,
 locale,
 continent_code,
 cntry_code,
 tot_requests_on_date,
 distro_name,
 distro_version,
 buildid
)
AS
 SELECT copy_adi_dimensional_by_date._year_quarter,
        copy_adi_dimensional_by_date.bl_date,
        copy_adi_dimensional_by_date.product,
        copy_adi_dimensional_by_date.v_prod_major,
        copy_adi_dimensional_by_date.prod_os,
        copy_adi_dimensional_by_date.v_prod_os,
        copy_adi_dimensional_by_date.channel,
        copy_adi_dimensional_by_date.locale,
        copy_adi_dimensional_by_date.continent_code,
        copy_adi_dimensional_by_date.cntry_code,
        copy_adi_dimensional_by_date.tot_requests_on_date,
        copy_adi_dimensional_by_date.distro_name,
        copy_adi_dimensional_by_date.distro_version,
        copy_adi_dimensional_by_date.buildid
 FROM public.copy_adi_dimensional_by_date
 ORDER BY copy_adi_dimensional_by_date._year_quarter,
          copy_adi_dimensional_by_date.bl_date,
          copy_adi_dimensional_by_date.product,
          copy_adi_dimensional_by_date.v_prod_major,
          copy_adi_dimensional_by_date.prod_os,
          copy_adi_dimensional_by_date.v_prod_os,
          copy_adi_dimensional_by_date.channel,
          copy_adi_dimensional_by_date.locale,
          copy_adi_dimensional_by_date.continent_code,
          copy_adi_dimensional_by_date.cntry_code,
          copy_adi_dimensional_by_date.tot_requests_on_date,
          copy_adi_dimensional_by_date.distro_name,
          copy_adi_dimensional_by_date.distro_version,
          copy_adi_dimensional_by_date.buildid
SEGMENTED BY hash(copy_adi_dimensional_by_date._year_quarter, copy_adi_dimensional_by_date.bl_date, copy_adi_dimensional_by_date.v_prod_major, copy_adi_dimensional_by_date.continent_code, copy_adi_dimensional_by_date.cntry_code, copy_adi_dimensional_by_date.tot_requests_on_date, copy_adi_dimensional_by_date.product, copy_adi_dimensional_by_date.buildid, copy_adi_dimensional_by_date.prod_os, copy_adi_dimensional_by_date.v_prod_os, copy_adi_dimensional_by_date.locale, copy_adi_dimensional_by_date.channel, copy_adi_dimensional_by_date.distro_name, copy_adi_dimensional_by_date.distro_version) ALL NODES KSAFE 1;

CREATE PROJECTION public.fhr_rollups_monthly_base_2015 /*+createtype(L)*/ 
(
 vendor,
 name,
 channel,
 os,
 osdetail,
 distribution,
 locale,
 geo,
 version,
 isstdprofile,
 stdchannel,
 stdos,
 distribtype,
 snapshot,
 granularity,
 timeStart,
 timeEnd,
 tTotalProfiles,
 tExistingProfiles,
 tNewProfiles,
 tActiveProfiles,
 tInActiveProfiles,
 tActiveDays,
 tTotalSeconds,
 tActiveSeconds,
 tNumSessions,
 tCrashes,
 tTotalSearch,
 tGoogleSearch,
 tYahooSearch,
 tBingSearch,
 tOfficialSearch,
 tIsDefault,
 tIsActiveProfileDefault,
 t5outOf7,
 tChurned,
 tHasUP
)
AS
 SELECT fhr_rollups_monthly_base_2015.vendor,
        fhr_rollups_monthly_base_2015.name,
        fhr_rollups_monthly_base_2015.channel,
        fhr_rollups_monthly_base_2015.os,
        fhr_rollups_monthly_base_2015.osdetail,
        fhr_rollups_monthly_base_2015.distribution,
        fhr_rollups_monthly_base_2015.locale,
        fhr_rollups_monthly_base_2015.geo,
        fhr_rollups_monthly_base_2015.version,
        fhr_rollups_monthly_base_2015.isstdprofile,
        fhr_rollups_monthly_base_2015.stdchannel,
        fhr_rollups_monthly_base_2015.stdos,
        fhr_rollups_monthly_base_2015.distribtype,
        fhr_rollups_monthly_base_2015.snapshot,
        fhr_rollups_monthly_base_2015.granularity,
        fhr_rollups_monthly_base_2015.timeStart,
        fhr_rollups_monthly_base_2015.timeEnd,
        fhr_rollups_monthly_base_2015.tTotalProfiles,
        fhr_rollups_monthly_base_2015.tExistingProfiles,
        fhr_rollups_monthly_base_2015.tNewProfiles,
        fhr_rollups_monthly_base_2015.tActiveProfiles,
        fhr_rollups_monthly_base_2015.tInActiveProfiles,
        fhr_rollups_monthly_base_2015.tActiveDays,
        fhr_rollups_monthly_base_2015.tTotalSeconds,
        fhr_rollups_monthly_base_2015.tActiveSeconds,
        fhr_rollups_monthly_base_2015.tNumSessions,
        fhr_rollups_monthly_base_2015.tCrashes,
        fhr_rollups_monthly_base_2015.tTotalSearch,
        fhr_rollups_monthly_base_2015.tGoogleSearch,
        fhr_rollups_monthly_base_2015.tYahooSearch,
        fhr_rollups_monthly_base_2015.tBingSearch,
        fhr_rollups_monthly_base_2015.tOfficialSearch,
        fhr_rollups_monthly_base_2015.tIsDefault,
        fhr_rollups_monthly_base_2015.tIsActiveProfileDefault,
        fhr_rollups_monthly_base_2015.t5outOf7,
        fhr_rollups_monthly_base_2015.tChurned,
        fhr_rollups_monthly_base_2015.tHasUP
 FROM public.fhr_rollups_monthly_base_2015
 ORDER BY fhr_rollups_monthly_base_2015.vendor,
          fhr_rollups_monthly_base_2015.name,
          fhr_rollups_monthly_base_2015.channel,
          fhr_rollups_monthly_base_2015.os,
          fhr_rollups_monthly_base_2015.osdetail,
          fhr_rollups_monthly_base_2015.distribution,
          fhr_rollups_monthly_base_2015.locale,
          fhr_rollups_monthly_base_2015.geo,
          fhr_rollups_monthly_base_2015.version,
          fhr_rollups_monthly_base_2015.isstdprofile,
          fhr_rollups_monthly_base_2015.stdchannel,
          fhr_rollups_monthly_base_2015.stdos,
          fhr_rollups_monthly_base_2015.distribtype,
          fhr_rollups_monthly_base_2015.snapshot,
          fhr_rollups_monthly_base_2015.granularity,
          fhr_rollups_monthly_base_2015.timeStart,
          fhr_rollups_monthly_base_2015.timeEnd,
          fhr_rollups_monthly_base_2015.tTotalProfiles,
          fhr_rollups_monthly_base_2015.tExistingProfiles,
          fhr_rollups_monthly_base_2015.tNewProfiles,
          fhr_rollups_monthly_base_2015.tActiveProfiles,
          fhr_rollups_monthly_base_2015.tInActiveProfiles,
          fhr_rollups_monthly_base_2015.tActiveDays,
          fhr_rollups_monthly_base_2015.tTotalSeconds,
          fhr_rollups_monthly_base_2015.tActiveSeconds,
          fhr_rollups_monthly_base_2015.tNumSessions,
          fhr_rollups_monthly_base_2015.tCrashes,
          fhr_rollups_monthly_base_2015.tTotalSearch,
          fhr_rollups_monthly_base_2015.tGoogleSearch,
          fhr_rollups_monthly_base_2015.tYahooSearch,
          fhr_rollups_monthly_base_2015.tBingSearch,
          fhr_rollups_monthly_base_2015.tOfficialSearch,
          fhr_rollups_monthly_base_2015.tIsDefault,
          fhr_rollups_monthly_base_2015.tIsActiveProfileDefault,
          fhr_rollups_monthly_base_2015.t5outOf7,
          fhr_rollups_monthly_base_2015.tChurned,
          fhr_rollups_monthly_base_2015.tHasUP
SEGMENTED BY hash(fhr_rollups_monthly_base_2015.tTotalProfiles, fhr_rollups_monthly_base_2015.tExistingProfiles, fhr_rollups_monthly_base_2015.tNewProfiles, fhr_rollups_monthly_base_2015.tActiveProfiles, fhr_rollups_monthly_base_2015.tInActiveProfiles, fhr_rollups_monthly_base_2015.tActiveDays, fhr_rollups_monthly_base_2015.tTotalSeconds, fhr_rollups_monthly_base_2015.tActiveSeconds, fhr_rollups_monthly_base_2015.tNumSessions, fhr_rollups_monthly_base_2015.tCrashes, fhr_rollups_monthly_base_2015.tTotalSearch, fhr_rollups_monthly_base_2015.tGoogleSearch, fhr_rollups_monthly_base_2015.tYahooSearch, fhr_rollups_monthly_base_2015.tBingSearch, fhr_rollups_monthly_base_2015.tOfficialSearch, fhr_rollups_monthly_base_2015.tIsDefault, fhr_rollups_monthly_base_2015.tIsActiveProfileDefault, fhr_rollups_monthly_base_2015.t5outOf7, fhr_rollups_monthly_base_2015.tChurned, fhr_rollups_monthly_base_2015.tHasUP, fhr_rollups_monthly_base_2015.vendor, fhr_rollups_monthly_base_2015.name, fhr_rollups_monthly_base_2015.channel, fhr_rollups_monthly_base_2015.os, fhr_rollups_monthly_base_2015.osdetail, fhr_rollups_monthly_base_2015.distribution, fhr_rollups_monthly_base_2015.locale, fhr_rollups_monthly_base_2015.geo, fhr_rollups_monthly_base_2015.version, fhr_rollups_monthly_base_2015.isstdprofile, fhr_rollups_monthly_base_2015.stdchannel, fhr_rollups_monthly_base_2015.stdos) ALL NODES KSAFE 1;

CREATE PROJECTION public.fhr_rollups_monthly_base /*+createtype(L)*/ 
(
 vendor,
 name,
 channel,
 os,
 osdetail,
 distribution,
 locale,
 geo,
 version,
 isstdprofile,
 stdchannel,
 stdos,
 distribtype,
 snapshot,
 granularity,
 timeStart,
 timeEnd,
 tTotalProfiles,
 tExistingProfiles,
 tNewProfiles,
 tActiveProfiles,
 tInActiveProfiles,
 tActiveDays,
 tTotalSeconds,
 tActiveSeconds,
 tNumSessions,
 tCrashes,
 tTotalSearch,
 tGoogleSearch,
 tYahooSearch,
 tBingSearch,
 tOfficialSearch,
 tIsDefault,
 tIsActiveProfileDefault,
 t5outOf7,
 tChurned,
 tHasUP
)
AS
 SELECT fhr_rollups_monthly_base.vendor,
        fhr_rollups_monthly_base.name,
        fhr_rollups_monthly_base.channel,
        fhr_rollups_monthly_base.os,
        fhr_rollups_monthly_base.osdetail,
        fhr_rollups_monthly_base.distribution,
        fhr_rollups_monthly_base.locale,
        fhr_rollups_monthly_base.geo,
        fhr_rollups_monthly_base.version,
        fhr_rollups_monthly_base.isstdprofile,
        fhr_rollups_monthly_base.stdchannel,
        fhr_rollups_monthly_base.stdos,
        fhr_rollups_monthly_base.distribtype,
        fhr_rollups_monthly_base.snapshot,
        fhr_rollups_monthly_base.granularity,
        fhr_rollups_monthly_base.timeStart,
        fhr_rollups_monthly_base.timeEnd,
        fhr_rollups_monthly_base.tTotalProfiles,
        fhr_rollups_monthly_base.tExistingProfiles,
        fhr_rollups_monthly_base.tNewProfiles,
        fhr_rollups_monthly_base.tActiveProfiles,
        fhr_rollups_monthly_base.tInActiveProfiles,
        fhr_rollups_monthly_base.tActiveDays,
        fhr_rollups_monthly_base.tTotalSeconds,
        fhr_rollups_monthly_base.tActiveSeconds,
        fhr_rollups_monthly_base.tNumSessions,
        fhr_rollups_monthly_base.tCrashes,
        fhr_rollups_monthly_base.tTotalSearch,
        fhr_rollups_monthly_base.tGoogleSearch,
        fhr_rollups_monthly_base.tYahooSearch,
        fhr_rollups_monthly_base.tBingSearch,
        fhr_rollups_monthly_base.tOfficialSearch,
        fhr_rollups_monthly_base.tIsDefault,
        fhr_rollups_monthly_base.tIsActiveProfileDefault,
        fhr_rollups_monthly_base.t5outOf7,
        fhr_rollups_monthly_base.tChurned,
        fhr_rollups_monthly_base.tHasUP
 FROM public.fhr_rollups_monthly_base
 ORDER BY fhr_rollups_monthly_base.vendor,
          fhr_rollups_monthly_base.name,
          fhr_rollups_monthly_base.channel,
          fhr_rollups_monthly_base.os,
          fhr_rollups_monthly_base.osdetail,
          fhr_rollups_monthly_base.distribution,
          fhr_rollups_monthly_base.locale,
          fhr_rollups_monthly_base.geo,
          fhr_rollups_monthly_base.version,
          fhr_rollups_monthly_base.isstdprofile,
          fhr_rollups_monthly_base.stdchannel,
          fhr_rollups_monthly_base.stdos,
          fhr_rollups_monthly_base.distribtype,
          fhr_rollups_monthly_base.snapshot,
          fhr_rollups_monthly_base.granularity,
          fhr_rollups_monthly_base.timeStart,
          fhr_rollups_monthly_base.timeEnd,
          fhr_rollups_monthly_base.tTotalProfiles,
          fhr_rollups_monthly_base.tExistingProfiles,
          fhr_rollups_monthly_base.tNewProfiles,
          fhr_rollups_monthly_base.tActiveProfiles,
          fhr_rollups_monthly_base.tInActiveProfiles,
          fhr_rollups_monthly_base.tActiveDays,
          fhr_rollups_monthly_base.tTotalSeconds,
          fhr_rollups_monthly_base.tActiveSeconds,
          fhr_rollups_monthly_base.tNumSessions,
          fhr_rollups_monthly_base.tCrashes,
          fhr_rollups_monthly_base.tTotalSearch,
          fhr_rollups_monthly_base.tGoogleSearch,
          fhr_rollups_monthly_base.tYahooSearch,
          fhr_rollups_monthly_base.tBingSearch,
          fhr_rollups_monthly_base.tOfficialSearch,
          fhr_rollups_monthly_base.tIsDefault,
          fhr_rollups_monthly_base.tIsActiveProfileDefault,
          fhr_rollups_monthly_base.t5outOf7,
          fhr_rollups_monthly_base.tChurned,
          fhr_rollups_monthly_base.tHasUP
SEGMENTED BY hash(fhr_rollups_monthly_base.tTotalProfiles, fhr_rollups_monthly_base.tExistingProfiles, fhr_rollups_monthly_base.tNewProfiles, fhr_rollups_monthly_base.tActiveProfiles, fhr_rollups_monthly_base.tInActiveProfiles, fhr_rollups_monthly_base.tActiveDays, fhr_rollups_monthly_base.tTotalSeconds, fhr_rollups_monthly_base.tActiveSeconds, fhr_rollups_monthly_base.tNumSessions, fhr_rollups_monthly_base.tCrashes, fhr_rollups_monthly_base.tTotalSearch, fhr_rollups_monthly_base.tGoogleSearch, fhr_rollups_monthly_base.tYahooSearch, fhr_rollups_monthly_base.tBingSearch, fhr_rollups_monthly_base.tOfficialSearch, fhr_rollups_monthly_base.tIsDefault, fhr_rollups_monthly_base.tIsActiveProfileDefault, fhr_rollups_monthly_base.t5outOf7, fhr_rollups_monthly_base.tChurned, fhr_rollups_monthly_base.tHasUP, fhr_rollups_monthly_base.vendor, fhr_rollups_monthly_base.name, fhr_rollups_monthly_base.channel, fhr_rollups_monthly_base.os, fhr_rollups_monthly_base.osdetail, fhr_rollups_monthly_base.distribution, fhr_rollups_monthly_base.locale, fhr_rollups_monthly_base.geo, fhr_rollups_monthly_base.version, fhr_rollups_monthly_base.isstdprofile, fhr_rollups_monthly_base.stdchannel, fhr_rollups_monthly_base.stdos) ALL NODES KSAFE 1;

CREATE PROJECTION public.nagios_log_data /*+createtype(L)*/ 
(
 event_occurred_at,
 incident_type,
 host,
 service,
 status,
 notify_by,
 description,
 filename
)
AS
 SELECT nagios_log_data.event_occurred_at,
        nagios_log_data.incident_type,
        nagios_log_data.host,
        nagios_log_data.service,
        nagios_log_data.status,
        nagios_log_data.notify_by,
        nagios_log_data.description,
        nagios_log_data.filename
 FROM public.nagios_log_data
 ORDER BY nagios_log_data.event_occurred_at,
          nagios_log_data.incident_type,
          nagios_log_data.host,
          nagios_log_data.service,
          nagios_log_data.status,
          nagios_log_data.notify_by,
          nagios_log_data.description,
          nagios_log_data.filename
SEGMENTED BY hash(nagios_log_data.event_occurred_at, nagios_log_data.status, nagios_log_data.incident_type, nagios_log_data.filename, nagios_log_data.host, nagios_log_data.service, nagios_log_data.notify_by, nagios_log_data.description) ALL NODES KSAFE 1;

CREATE PROJECTION public.v4_submissionwise_v5 /*+createtype(L)*/ 
(
 submission_date,
 search_provider,
 search_count,
 country,
 locale,
 distribution_id,
 default_provider,
 profiles_matching,
 profile_share,
 intermediate_source
)
AS
 SELECT v4_submissionwise_v5.submission_date,
        v4_submissionwise_v5.search_provider,
        v4_submissionwise_v5.search_count,
        v4_submissionwise_v5.country,
        v4_submissionwise_v5.locale,
        v4_submissionwise_v5.distribution_id,
        v4_submissionwise_v5.default_provider,
        v4_submissionwise_v5.profiles_matching,
        v4_submissionwise_v5.profile_share,
        v4_submissionwise_v5.intermediate_source
 FROM public.v4_submissionwise_v5
 ORDER BY v4_submissionwise_v5.submission_date,
          v4_submissionwise_v5.search_provider,
          v4_submissionwise_v5.search_count,
          v4_submissionwise_v5.country,
          v4_submissionwise_v5.locale,
          v4_submissionwise_v5.distribution_id,
          v4_submissionwise_v5.default_provider,
          v4_submissionwise_v5.profiles_matching,
          v4_submissionwise_v5.profile_share,
          v4_submissionwise_v5.intermediate_source
SEGMENTED BY hash(v4_submissionwise_v5.submission_date, v4_submissionwise_v5.search_count, v4_submissionwise_v5.profiles_matching, v4_submissionwise_v5.profile_share, v4_submissionwise_v5.search_provider, v4_submissionwise_v5.country, v4_submissionwise_v5.locale, v4_submissionwise_v5.distribution_id, v4_submissionwise_v5.default_provider, v4_submissionwise_v5.intermediate_source) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_monthly_rollups /*+createtype(L)*/ 
(
 month,
 search_provider,
 search_count,
 country,
 locale,
 distribution_id,
 default_provider,
 profiles_matching,
 processed
)
AS
 SELECT ut_monthly_rollups.month,
        ut_monthly_rollups.search_provider,
        ut_monthly_rollups.search_count,
        ut_monthly_rollups.country,
        ut_monthly_rollups.locale,
        ut_monthly_rollups.distribution_id,
        ut_monthly_rollups.default_provider,
        ut_monthly_rollups.profiles_matching,
        ut_monthly_rollups.processed
 FROM public.ut_monthly_rollups
 ORDER BY ut_monthly_rollups.month,
          ut_monthly_rollups.search_provider,
          ut_monthly_rollups.search_count,
          ut_monthly_rollups.country,
          ut_monthly_rollups.locale,
          ut_monthly_rollups.distribution_id,
          ut_monthly_rollups.default_provider,
          ut_monthly_rollups.profiles_matching,
          ut_monthly_rollups.processed
SEGMENTED BY hash(ut_monthly_rollups.month, ut_monthly_rollups.search_count, ut_monthly_rollups.profiles_matching, ut_monthly_rollups.processed, ut_monthly_rollups.search_provider, ut_monthly_rollups.country, ut_monthly_rollups.locale, ut_monthly_rollups.distribution_id, ut_monthly_rollups.default_provider) ALL NODES KSAFE 1;

CREATE PROJECTION public.pocket_mobile_daily_active_users /*+createtype(L)*/ 
(
 activity_date,
 platform,
 dau,
 wau_rolling_7,
 mau_rolling_30,
 mau_rolling_31,
 mau_rolling_28,
 app
)
AS
 SELECT pocket_mobile_daily_active_users.activity_date,
        pocket_mobile_daily_active_users.platform,
        pocket_mobile_daily_active_users.dau,
        pocket_mobile_daily_active_users.wau_rolling_7,
        pocket_mobile_daily_active_users.mau_rolling_30,
        pocket_mobile_daily_active_users.mau_rolling_31,
        pocket_mobile_daily_active_users.mau_rolling_28,
        pocket_mobile_daily_active_users.app
 FROM public.pocket_mobile_daily_active_users
 ORDER BY pocket_mobile_daily_active_users.activity_date,
          pocket_mobile_daily_active_users.platform,
          pocket_mobile_daily_active_users.dau,
          pocket_mobile_daily_active_users.wau_rolling_7,
          pocket_mobile_daily_active_users.mau_rolling_30,
          pocket_mobile_daily_active_users.mau_rolling_31,
          pocket_mobile_daily_active_users.mau_rolling_28,
          pocket_mobile_daily_active_users.app
SEGMENTED BY hash(pocket_mobile_daily_active_users.activity_date, pocket_mobile_daily_active_users.platform, pocket_mobile_daily_active_users.dau, pocket_mobile_daily_active_users.wau_rolling_7, pocket_mobile_daily_active_users.mau_rolling_30, pocket_mobile_daily_active_users.mau_rolling_31, pocket_mobile_daily_active_users.mau_rolling_28, pocket_mobile_daily_active_users.app) ALL NODES KSAFE 1;

CREATE PROJECTION public.releases /*+createtype(L)*/ 
(
 is_released,
 version_int,
 version,
 channel,
 merge_date,
 release_date,
 product
)
AS
 SELECT releases.is_released,
        releases.version_int,
        releases.version,
        releases.channel,
        releases.merge_date,
        releases.release_date,
        releases.product
 FROM public.releases
 ORDER BY releases.is_released,
          releases.version_int,
          releases.version,
          releases.channel,
          releases.merge_date,
          releases.release_date,
          releases.product
SEGMENTED BY hash(releases.is_released, releases.version_int, releases.version, releases.merge_date, releases.release_date, releases.channel, releases.product) ALL NODES KSAFE 1;

CREATE PROJECTION public.reviews /*+createtype(L)*/ 
(
 ID,
 Store,
 Device,
 Source,
 Country,
 "Review Date",
 Version,
 Rating,
 "Original Reviews",
 "Translated Reviews",
 Sentiment,
 Spam,
 "Verb Phrases",
 "Noun Phrases",
 "Clear Filters"
)
AS
 SELECT reviews.ID,
        reviews.Store,
        reviews.Device,
        reviews.Source,
        reviews.Country,
        reviews."Review Date",
        reviews.Version,
        reviews.Rating,
        reviews."Original Reviews",
        reviews."Translated Reviews",
        reviews.Sentiment,
        reviews.Spam,
        reviews."Verb Phrases",
        reviews."Noun Phrases",
        reviews."Clear Filters"
 FROM public.reviews
 ORDER BY reviews.ID
SEGMENTED BY hash(reviews.ID) ALL NODES KSAFE 1;

CREATE PROJECTION public.categorization /*+createtype(L)*/ 
(
 ID,
 Feature,
 Component,
 theAction
)
AS
 SELECT categorization.ID,
        categorization.Feature,
        categorization.Component,
        categorization.theAction
 FROM public.categorization
 ORDER BY categorization.ID,
          categorization.Feature,
          categorization.Component,
          categorization.theAction
SEGMENTED BY hash(categorization.ID, categorization.Feature, categorization.Component, categorization.theAction) ALL NODES KSAFE 1;

CREATE PROJECTION public.key_issue /*+createtype(L)*/ 
(
 ID,
 "Key Issue"
)
AS
 SELECT key_issue.ID,
        key_issue."Key Issue"
 FROM public.key_issue
 ORDER BY key_issue.ID,
          key_issue."Key Issue"
SEGMENTED BY hash(key_issue.ID, key_issue."Key Issue") ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_retention /*+createtype(L)*/ 
(
 date,
 os,
 period,
 retention,
 app
)
AS
 SELECT adjust_retention.date,
        adjust_retention.os,
        adjust_retention.period,
        adjust_retention.retention,
        adjust_retention.app
 FROM public.adjust_retention
 ORDER BY adjust_retention.date,
          adjust_retention.os,
          adjust_retention.period,
          adjust_retention.retention,
          adjust_retention.app
SEGMENTED BY hash(adjust_retention.date, adjust_retention.period, adjust_retention.retention, adjust_retention.os, adjust_retention.app) ALL NODES KSAFE 1;

CREATE PROJECTION public.last_updated /*+createtype(L)*/ 
(
 name,
 updated_at,
 updated_by
)
AS
 SELECT last_updated.name,
        last_updated.updated_at,
        last_updated.updated_by
 FROM public.last_updated
 ORDER BY last_updated.name
SEGMENTED BY hash(last_updated.name) ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_daily_active_users /*+createtype(L)*/ 
(
 adj_date,
 os,
 daus,
 waus,
 maus,
 installs,
 app
)
AS
 SELECT adjust_daily_active_users.adj_date,
        adjust_daily_active_users.os,
        adjust_daily_active_users.daus,
        adjust_daily_active_users.waus,
        adjust_daily_active_users.maus,
        adjust_daily_active_users.installs,
        adjust_daily_active_users.app
 FROM public.adjust_daily_active_users
 ORDER BY adjust_daily_active_users.adj_date,
          adjust_daily_active_users.os,
          adjust_daily_active_users.daus,
          adjust_daily_active_users.waus,
          adjust_daily_active_users.maus,
          adjust_daily_active_users.installs,
          adjust_daily_active_users.app
SEGMENTED BY hash(adjust_daily_active_users.adj_date, adjust_daily_active_users.daus, adjust_daily_active_users.waus, adjust_daily_active_users.maus, adjust_daily_active_users.installs, adjust_daily_active_users.os, adjust_daily_active_users.app) ALL NODES KSAFE 1;

CREATE PROJECTION public.f_bugs_snapshot_v2 /*+createtype(L)*/ 
(
 id,
 es_id,
 bug_id,
 bug_severity,
 bug_status,
 bug_version_num,
 assigned_to,
 component,
 created_by,
 created_ts,
 modified_by,
 modified_ts,
 op_sys,
 priority,
 product,
 qa_contact,
 reported_by,
 reporter,
 version,
 expires_on,
 cf_due_date,
 target_milestone,
 short_desc,
 bug_status_resolution,
 keywords,
 snapshot_date
)
AS
 SELECT f_bugs_snapshot_v2.id,
        f_bugs_snapshot_v2.es_id,
        f_bugs_snapshot_v2.bug_id,
        f_bugs_snapshot_v2.bug_severity,
        f_bugs_snapshot_v2.bug_status,
        f_bugs_snapshot_v2.bug_version_num,
        f_bugs_snapshot_v2.assigned_to,
        f_bugs_snapshot_v2.component,
        f_bugs_snapshot_v2.created_by,
        f_bugs_snapshot_v2.created_ts,
        f_bugs_snapshot_v2.modified_by,
        f_bugs_snapshot_v2.modified_ts,
        f_bugs_snapshot_v2.op_sys,
        f_bugs_snapshot_v2.priority,
        f_bugs_snapshot_v2.product,
        f_bugs_snapshot_v2.qa_contact,
        f_bugs_snapshot_v2.reported_by,
        f_bugs_snapshot_v2.reporter,
        f_bugs_snapshot_v2.version,
        f_bugs_snapshot_v2.expires_on,
        f_bugs_snapshot_v2.cf_due_date,
        f_bugs_snapshot_v2.target_milestone,
        f_bugs_snapshot_v2.short_desc,
        f_bugs_snapshot_v2.bug_status_resolution,
        f_bugs_snapshot_v2.keywords,
        f_bugs_snapshot_v2.snapshot_date
 FROM public.f_bugs_snapshot_v2
 ORDER BY f_bugs_snapshot_v2.id,
          f_bugs_snapshot_v2.es_id,
          f_bugs_snapshot_v2.bug_id,
          f_bugs_snapshot_v2.bug_severity,
          f_bugs_snapshot_v2.bug_status,
          f_bugs_snapshot_v2.bug_version_num,
          f_bugs_snapshot_v2.assigned_to,
          f_bugs_snapshot_v2.component,
          f_bugs_snapshot_v2.created_by,
          f_bugs_snapshot_v2.created_ts,
          f_bugs_snapshot_v2.modified_by,
          f_bugs_snapshot_v2.modified_ts,
          f_bugs_snapshot_v2.op_sys,
          f_bugs_snapshot_v2.priority,
          f_bugs_snapshot_v2.product,
          f_bugs_snapshot_v2.qa_contact,
          f_bugs_snapshot_v2.reported_by,
          f_bugs_snapshot_v2.reporter,
          f_bugs_snapshot_v2.version,
          f_bugs_snapshot_v2.expires_on,
          f_bugs_snapshot_v2.cf_due_date,
          f_bugs_snapshot_v2.target_milestone,
          f_bugs_snapshot_v2.short_desc,
          f_bugs_snapshot_v2.bug_status_resolution,
          f_bugs_snapshot_v2.keywords,
          f_bugs_snapshot_v2.snapshot_date
SEGMENTED BY hash(f_bugs_snapshot_v2.id, f_bugs_snapshot_v2.created_ts, f_bugs_snapshot_v2.modified_ts, f_bugs_snapshot_v2.snapshot_date, f_bugs_snapshot_v2.es_id, f_bugs_snapshot_v2.bug_id, f_bugs_snapshot_v2.bug_severity, f_bugs_snapshot_v2.bug_status, f_bugs_snapshot_v2.bug_version_num, f_bugs_snapshot_v2.assigned_to, f_bugs_snapshot_v2.component, f_bugs_snapshot_v2.created_by, f_bugs_snapshot_v2.modified_by, f_bugs_snapshot_v2.op_sys, f_bugs_snapshot_v2.priority, f_bugs_snapshot_v2.product, f_bugs_snapshot_v2.qa_contact, f_bugs_snapshot_v2.reported_by, f_bugs_snapshot_v2.reporter, f_bugs_snapshot_v2.version, f_bugs_snapshot_v2.expires_on, f_bugs_snapshot_v2.cf_due_date, f_bugs_snapshot_v2.target_milestone, f_bugs_snapshot_v2.short_desc, f_bugs_snapshot_v2.bug_status_resolution, f_bugs_snapshot_v2.keywords) ALL NODES KSAFE 1;

CREATE PROJECTION public.f_bugs_status_resolution /*+createtype(L)*/ 
(
 bug_id,
 bug_severity,
 short_desc,
 bug_status,
 bug_status_previous,
 status_update,
 status_change_update,
 curr_snapshot_date
)
AS
 SELECT f_bugs_status_resolution.bug_id,
        f_bugs_status_resolution.bug_severity,
        f_bugs_status_resolution.short_desc,
        f_bugs_status_resolution.bug_status,
        f_bugs_status_resolution.bug_status_previous,
        f_bugs_status_resolution.status_update,
        f_bugs_status_resolution.status_change_update,
        f_bugs_status_resolution.curr_snapshot_date
 FROM public.f_bugs_status_resolution
 ORDER BY f_bugs_status_resolution.status_change_update,
          f_bugs_status_resolution.bug_id
SEGMENTED BY hash(f_bugs_status_resolution.bug_id) ALL NODES KSAFE 1;

CREATE PROJECTION public.sf_donations /*+createtype(L)*/ 
(
 opp_name,
 amount,
 contact_id
)
AS
 SELECT sf_donations.opp_name,
        sf_donations.amount,
        sf_donations.contact_id
 FROM public.sf_donations
 ORDER BY sf_donations.opp_name,
          sf_donations.amount,
          sf_donations.contact_id
SEGMENTED BY hash(sf_donations.amount, sf_donations.opp_name, sf_donations.contact_id) ALL NODES KSAFE 1;

CREATE PROJECTION public.sf_foundation_signups /*+createtype(L)*/ 
(
 contact_id,
 signup_date
)
AS
 SELECT sf_foundation_signups.contact_id,
        sf_foundation_signups.signup_date
 FROM public.sf_foundation_signups
 ORDER BY sf_foundation_signups.contact_id,
          sf_foundation_signups.signup_date
SEGMENTED BY hash(sf_foundation_signups.signup_date, sf_foundation_signups.contact_id) ALL NODES KSAFE 1;

CREATE PROJECTION public.sf_contacts /*+createtype(L)*/ 
(
 id,
 created_date,
 email,
 email_format,
 contact_name,
 email_language,
 signup_source_url,
 confirmation_miti_subscriber,
 sub_apps_and_hacks,
 sub_firefox_and_you,
 sub_firefox_accounts_journey,
 sub_mozilla_foundation,
 sub_miti_subscriber,
 sub_mozilla_leadership_network,
 sub_mozilla_learning_network,
 sub_webmaker,
 sub_mozillians_nda,
 sub_open_innovation_subscriber,
 subscriber,
 sub_test_flight,
 sub_test_pilot,
 sub_view_source_global,
 sub_view_source_namerica,
 double_opt_in,
 unengaged,
 email_opt_out,
 mailing_country
)
AS
 SELECT sf_contacts.id,
        sf_contacts.created_date,
        sf_contacts.email,
        sf_contacts.email_format,
        sf_contacts.contact_name,
        sf_contacts.email_language,
        sf_contacts.signup_source_url,
        sf_contacts.confirmation_miti_subscriber,
        sf_contacts.sub_apps_and_hacks,
        sf_contacts.sub_firefox_and_you,
        sf_contacts.sub_firefox_accounts_journey,
        sf_contacts.sub_mozilla_foundation,
        sf_contacts.sub_miti_subscriber,
        sf_contacts.sub_mozilla_leadership_network,
        sf_contacts.sub_mozilla_learning_network,
        sf_contacts.sub_webmaker,
        sf_contacts.sub_mozillians_nda,
        sf_contacts.sub_open_innovation_subscriber,
        sf_contacts.subscriber,
        sf_contacts.sub_test_flight,
        sf_contacts.sub_test_pilot,
        sf_contacts.sub_view_source_global,
        sf_contacts.sub_view_source_namerica,
        sf_contacts.double_opt_in,
        sf_contacts.unengaged,
        sf_contacts.email_opt_out,
        sf_contacts.mailing_country
 FROM public.sf_contacts
 ORDER BY sf_contacts.id,
          sf_contacts.created_date,
          sf_contacts.email,
          sf_contacts.email_format,
          sf_contacts.contact_name,
          sf_contacts.email_language,
          sf_contacts.signup_source_url,
          sf_contacts.confirmation_miti_subscriber,
          sf_contacts.sub_apps_and_hacks,
          sf_contacts.sub_firefox_and_you,
          sf_contacts.sub_firefox_accounts_journey,
          sf_contacts.sub_mozilla_foundation,
          sf_contacts.sub_miti_subscriber,
          sf_contacts.sub_mozilla_leadership_network,
          sf_contacts.sub_mozilla_learning_network,
          sf_contacts.sub_webmaker,
          sf_contacts.sub_mozillians_nda,
          sf_contacts.sub_open_innovation_subscriber,
          sf_contacts.subscriber,
          sf_contacts.sub_test_flight,
          sf_contacts.sub_test_pilot,
          sf_contacts.sub_view_source_global,
          sf_contacts.sub_view_source_namerica,
          sf_contacts.double_opt_in,
          sf_contacts.unengaged,
          sf_contacts.email_opt_out,
          sf_contacts.mailing_country
SEGMENTED BY hash(sf_contacts.created_date, sf_contacts.email_format, sf_contacts.confirmation_miti_subscriber, sf_contacts.sub_apps_and_hacks, sf_contacts.sub_firefox_and_you, sf_contacts.sub_firefox_accounts_journey, sf_contacts.sub_mozilla_foundation, sf_contacts.sub_miti_subscriber, sf_contacts.sub_mozilla_leadership_network, sf_contacts.sub_mozilla_learning_network, sf_contacts.sub_webmaker, sf_contacts.sub_mozillians_nda, sf_contacts.sub_open_innovation_subscriber, sf_contacts.subscriber, sf_contacts.sub_test_flight, sf_contacts.sub_test_pilot, sf_contacts.sub_view_source_global, sf_contacts.sub_view_source_namerica, sf_contacts.double_opt_in, sf_contacts.unengaged, sf_contacts.email_opt_out, sf_contacts.email_language, sf_contacts.id, sf_contacts.email, sf_contacts.contact_name, sf_contacts.mailing_country, sf_contacts.signup_source_url) ALL NODES KSAFE 1;

CREATE PROJECTION public.sf_donation_count /*+createtype(L)*/ 
(
 opp_name,
 opp_type,
 lead_source,
 amount,
 close_date,
 next_step,
 stage,
 probability,
 fiscal_period,
 age,
 created_date,
 opp_owner,
 owner_role,
 account_name
)
AS
 SELECT sf_donation_count.opp_name,
        sf_donation_count.opp_type,
        sf_donation_count.lead_source,
        sf_donation_count.amount,
        sf_donation_count.close_date,
        sf_donation_count.next_step,
        sf_donation_count.stage,
        sf_donation_count.probability,
        sf_donation_count.fiscal_period,
        sf_donation_count.age,
        sf_donation_count.created_date,
        sf_donation_count.opp_owner,
        sf_donation_count.owner_role,
        sf_donation_count.account_name
 FROM public.sf_donation_count
 ORDER BY sf_donation_count.opp_name,
          sf_donation_count.opp_type,
          sf_donation_count.lead_source,
          sf_donation_count.amount,
          sf_donation_count.close_date,
          sf_donation_count.next_step,
          sf_donation_count.stage,
          sf_donation_count.probability,
          sf_donation_count.fiscal_period,
          sf_donation_count.age,
          sf_donation_count.created_date,
          sf_donation_count.opp_owner,
          sf_donation_count.owner_role,
          sf_donation_count.account_name
SEGMENTED BY hash(sf_donation_count.amount, sf_donation_count.close_date, sf_donation_count.probability, sf_donation_count.fiscal_period, sf_donation_count.age, sf_donation_count.created_date, sf_donation_count.opp_name, sf_donation_count.stage, sf_donation_count.opp_type, sf_donation_count.lead_source, sf_donation_count.next_step, sf_donation_count.opp_owner, sf_donation_count.owner_role, sf_donation_count.account_name) ALL NODES KSAFE 1;

CREATE PROJECTION public.sf_copyright_petition /*+createtype(L)*/ 
(
 contact_id,
 signed_on_date
)
AS
 SELECT sf_copyright_petition.contact_id,
        sf_copyright_petition.signed_on_date
 FROM public.sf_copyright_petition
 ORDER BY sf_copyright_petition.contact_id,
          sf_copyright_petition.signed_on_date
SEGMENTED BY hash(sf_copyright_petition.signed_on_date, sf_copyright_petition.contact_id) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_desktop_daily_active_users /*+createtype(L)*/ 
(
 day,
 mau,
 dau,
 smooth_dau,
 engagement_ratio
)
AS
 SELECT ut_desktop_daily_active_users.day,
        ut_desktop_daily_active_users.mau,
        ut_desktop_daily_active_users.dau,
        ut_desktop_daily_active_users.smooth_dau,
        ut_desktop_daily_active_users.engagement_ratio
 FROM public.ut_desktop_daily_active_users
 ORDER BY ut_desktop_daily_active_users.day,
          ut_desktop_daily_active_users.mau,
          ut_desktop_daily_active_users.dau,
          ut_desktop_daily_active_users.smooth_dau,
          ut_desktop_daily_active_users.engagement_ratio
SEGMENTED BY hash(ut_desktop_daily_active_users.day, ut_desktop_daily_active_users.mau, ut_desktop_daily_active_users.dau, ut_desktop_daily_active_users.smooth_dau, ut_desktop_daily_active_users.engagement_ratio) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_desktop_daily_active_users_extended /*+createtype(L)*/ 
(
 day,
 mau,
 dau,
 smooth_dau
)
AS
 SELECT ut_desktop_daily_active_users_extended.day,
        ut_desktop_daily_active_users_extended.mau,
        ut_desktop_daily_active_users_extended.dau,
        ut_desktop_daily_active_users_extended.smooth_dau
 FROM public.ut_desktop_daily_active_users_extended
 ORDER BY ut_desktop_daily_active_users_extended.day,
          ut_desktop_daily_active_users_extended.mau,
          ut_desktop_daily_active_users_extended.dau,
          ut_desktop_daily_active_users_extended.smooth_dau
SEGMENTED BY hash(ut_desktop_daily_active_users_extended.day, ut_desktop_daily_active_users_extended.mau, ut_desktop_daily_active_users_extended.dau, ut_desktop_daily_active_users_extended.smooth_dau) ALL NODES KSAFE 1;

CREATE PROJECTION public.redash_focus_retention /*+createtype(L)*/ 
(
 os,
 cohort,
 week,
 cohort_size,
 weeK_num,
 active_users
)
AS
 SELECT redash_focus_retention.os,
        redash_focus_retention.cohort,
        redash_focus_retention.week,
        redash_focus_retention.cohort_size,
        redash_focus_retention.weeK_num,
        redash_focus_retention.active_users
 FROM public.redash_focus_retention
 ORDER BY redash_focus_retention.os,
          redash_focus_retention.cohort,
          redash_focus_retention.week,
          redash_focus_retention.cohort_size,
          redash_focus_retention.weeK_num,
          redash_focus_retention.active_users
SEGMENTED BY hash(redash_focus_retention.cohort, redash_focus_retention.week, redash_focus_retention.cohort_size, redash_focus_retention.weeK_num, redash_focus_retention.active_users, redash_focus_retention.os) ALL NODES KSAFE 1;

CREATE PROJECTION public.churn_cohort /*+createtype(L)*/ 
(
 channel,
 country,
 is_funnelcake,
 acquisition_period,
 start_version,
 sync_usage,
 current_version,
 week_since_acquisition,
 is_active,
 n_profiles,
 usage_hours,
 sum_squared_usage_hours
)
AS
 SELECT churn_cohort.channel,
        churn_cohort.country,
        churn_cohort.is_funnelcake,
        churn_cohort.acquisition_period,
        churn_cohort.start_version,
        churn_cohort.sync_usage,
        churn_cohort.current_version,
        churn_cohort.week_since_acquisition,
        churn_cohort.is_active,
        churn_cohort.n_profiles,
        churn_cohort.usage_hours,
        churn_cohort.sum_squared_usage_hours
 FROM public.churn_cohort
 ORDER BY churn_cohort.channel,
          churn_cohort.country,
          churn_cohort.is_funnelcake,
          churn_cohort.acquisition_period,
          churn_cohort.start_version,
          churn_cohort.sync_usage,
          churn_cohort.current_version,
          churn_cohort.week_since_acquisition,
          churn_cohort.is_active,
          churn_cohort.n_profiles,
          churn_cohort.usage_hours,
          churn_cohort.sum_squared_usage_hours
SEGMENTED BY hash(churn_cohort.country, churn_cohort.is_funnelcake, churn_cohort.acquisition_period, churn_cohort.week_since_acquisition, churn_cohort.is_active, churn_cohort.n_profiles, churn_cohort.usage_hours, churn_cohort.sum_squared_usage_hours, churn_cohort.start_version, churn_cohort.sync_usage, churn_cohort.current_version, churn_cohort.channel) ALL NODES KSAFE 1;

CREATE PROJECTION public.mozilla_staff /*+createtype(L)*/ 
(
 employee_id,
 first_name,
 last_name,
 email_address,
 supervisory_organization,
 cost_center,
 functional_group,
 manager_id,
 manager_lastname,
 manager_firstname,
 is_manager,
 hire_date,
 location,
 snapshot_date
)
AS
 SELECT mozilla_staff.employee_id,
        mozilla_staff.first_name,
        mozilla_staff.last_name,
        mozilla_staff.email_address,
        mozilla_staff.supervisory_organization,
        mozilla_staff.cost_center,
        mozilla_staff.functional_group,
        mozilla_staff.manager_id,
        mozilla_staff.manager_lastname,
        mozilla_staff.manager_firstname,
        mozilla_staff.is_manager,
        mozilla_staff.hire_date,
        mozilla_staff.location,
        mozilla_staff.snapshot_date
 FROM public.mozilla_staff
 ORDER BY mozilla_staff.employee_id,
          mozilla_staff.first_name,
          mozilla_staff.last_name,
          mozilla_staff.email_address,
          mozilla_staff.supervisory_organization,
          mozilla_staff.cost_center,
          mozilla_staff.functional_group,
          mozilla_staff.manager_id,
          mozilla_staff.manager_lastname,
          mozilla_staff.manager_firstname,
          mozilla_staff.is_manager,
          mozilla_staff.hire_date,
          mozilla_staff.location,
          mozilla_staff.snapshot_date
SEGMENTED BY hash(mozilla_staff.is_manager, mozilla_staff.hire_date, mozilla_staff.snapshot_date, mozilla_staff.employee_id, mozilla_staff.first_name, mozilla_staff.last_name, mozilla_staff.supervisory_organization, mozilla_staff.cost_center, mozilla_staff.functional_group, mozilla_staff.manager_id, mozilla_staff.manager_lastname, mozilla_staff.manager_firstname, mozilla_staff.location, mozilla_staff.email_address) ALL NODES KSAFE 1;

CREATE PROJECTION public.mozilla_staff_plus /*+createtype(L)*/ 
(
 employee_id,
 first_name,
 last_name,
 email_address,
 supervisory_organization,
 cost_center,
 functional_group,
 manager_id,
 manager_lastname,
 manager_firstname,
 manager_email,
 is_manager,
 hire_date,
 location,
 home_city,
 home_country,
 home_postal,
 desk_number,
 snapshot_date
)
AS
 SELECT mozilla_staff_plus.employee_id,
        mozilla_staff_plus.first_name,
        mozilla_staff_plus.last_name,
        mozilla_staff_plus.email_address,
        mozilla_staff_plus.supervisory_organization,
        mozilla_staff_plus.cost_center,
        mozilla_staff_plus.functional_group,
        mozilla_staff_plus.manager_id,
        mozilla_staff_plus.manager_lastname,
        mozilla_staff_plus.manager_firstname,
        mozilla_staff_plus.manager_email,
        mozilla_staff_plus.is_manager,
        mozilla_staff_plus.hire_date,
        mozilla_staff_plus.location,
        mozilla_staff_plus.home_city,
        mozilla_staff_plus.home_country,
        mozilla_staff_plus.home_postal,
        mozilla_staff_plus.desk_number,
        mozilla_staff_plus.snapshot_date
 FROM public.mozilla_staff_plus
 ORDER BY mozilla_staff_plus.employee_id,
          mozilla_staff_plus.first_name,
          mozilla_staff_plus.last_name,
          mozilla_staff_plus.email_address,
          mozilla_staff_plus.supervisory_organization,
          mozilla_staff_plus.cost_center,
          mozilla_staff_plus.functional_group,
          mozilla_staff_plus.manager_id,
          mozilla_staff_plus.manager_lastname,
          mozilla_staff_plus.manager_firstname,
          mozilla_staff_plus.manager_email,
          mozilla_staff_plus.is_manager,
          mozilla_staff_plus.hire_date,
          mozilla_staff_plus.location,
          mozilla_staff_plus.home_city,
          mozilla_staff_plus.home_country,
          mozilla_staff_plus.home_postal,
          mozilla_staff_plus.desk_number,
          mozilla_staff_plus.snapshot_date
SEGMENTED BY hash(mozilla_staff_plus.is_manager, mozilla_staff_plus.hire_date, mozilla_staff_plus.snapshot_date, mozilla_staff_plus.employee_id, mozilla_staff_plus.first_name, mozilla_staff_plus.last_name, mozilla_staff_plus.supervisory_organization, mozilla_staff_plus.cost_center, mozilla_staff_plus.functional_group, mozilla_staff_plus.manager_id, mozilla_staff_plus.manager_lastname, mozilla_staff_plus.manager_firstname, mozilla_staff_plus.location, mozilla_staff_plus.home_city, mozilla_staff_plus.home_country, mozilla_staff_plus.home_postal, mozilla_staff_plus.desk_number, mozilla_staff_plus.email_address, mozilla_staff_plus.manager_email) ALL NODES KSAFE 1;

CREATE PROJECTION public.mobile_daily_active_users /*+createtype(L)*/ 
(
 app,
 os,
 day,
 dau,
 smooth_dau,
 wau,
 mau,
 weekly_engagement,
 monthly_engagement
)
AS
 SELECT mobile_daily_active_users.app,
        mobile_daily_active_users.os,
        mobile_daily_active_users.day,
        mobile_daily_active_users.dau,
        mobile_daily_active_users.smooth_dau,
        mobile_daily_active_users.wau,
        mobile_daily_active_users.mau,
        mobile_daily_active_users.weekly_engagement,
        mobile_daily_active_users.monthly_engagement
 FROM public.mobile_daily_active_users
 ORDER BY mobile_daily_active_users.app,
          mobile_daily_active_users.os,
          mobile_daily_active_users.day,
          mobile_daily_active_users.dau,
          mobile_daily_active_users.smooth_dau,
          mobile_daily_active_users.wau,
          mobile_daily_active_users.mau,
          mobile_daily_active_users.weekly_engagement,
          mobile_daily_active_users.monthly_engagement
SEGMENTED BY hash(mobile_daily_active_users.day, mobile_daily_active_users.dau, mobile_daily_active_users.smooth_dau, mobile_daily_active_users.wau, mobile_daily_active_users.mau, mobile_daily_active_users.weekly_engagement, mobile_daily_active_users.monthly_engagement, mobile_daily_active_users.app, mobile_daily_active_users.os) ALL NODES KSAFE 1;

CREATE PROJECTION public.fx_desktop_er /*+createtype(L)*/ 
(
 activity_date,
 mau,
 dau,
 smooth_dau,
 er
)
AS
 SELECT fx_desktop_er.activity_date,
        fx_desktop_er.mau,
        fx_desktop_er.dau,
        fx_desktop_er.smooth_dau,
        fx_desktop_er.er
 FROM public.fx_desktop_er
 ORDER BY fx_desktop_er.activity_date,
          fx_desktop_er.mau,
          fx_desktop_er.dau,
          fx_desktop_er.smooth_dau,
          fx_desktop_er.er
SEGMENTED BY hash(fx_desktop_er.activity_date, fx_desktop_er.mau, fx_desktop_er.dau, fx_desktop_er.smooth_dau, fx_desktop_er.er) ALL NODES KSAFE 1;

CREATE PROJECTION public.fx_desktop_er_by_top_countries /*+createtype(L)*/ 
(
 country,
 activity_date,
 mau,
 dau,
 smooth_dau,
 er
)
AS
 SELECT fx_desktop_er_by_top_countries.country,
        fx_desktop_er_by_top_countries.activity_date,
        fx_desktop_er_by_top_countries.mau,
        fx_desktop_er_by_top_countries.dau,
        fx_desktop_er_by_top_countries.smooth_dau,
        fx_desktop_er_by_top_countries.er
 FROM public.fx_desktop_er_by_top_countries
 ORDER BY fx_desktop_er_by_top_countries.country,
          fx_desktop_er_by_top_countries.activity_date,
          fx_desktop_er_by_top_countries.mau,
          fx_desktop_er_by_top_countries.dau,
          fx_desktop_er_by_top_countries.smooth_dau,
          fx_desktop_er_by_top_countries.er
SEGMENTED BY hash(fx_desktop_er_by_top_countries.country, fx_desktop_er_by_top_countries.activity_date, fx_desktop_er_by_top_countries.mau, fx_desktop_er_by_top_countries.dau, fx_desktop_er_by_top_countries.smooth_dau, fx_desktop_er_by_top_countries.er) ALL NODES KSAFE 1;


CREATE FUNCTION public.isOrContains(map Long Varchar, val Varchar)
RETURN boolean AS
BEGIN
RETURN CASE WHEN (public.MapSize(map) <> (-1)) THEN public.MapContainsValue(map, val) ELSE (map = (val)) END;
END;

CREATE FUNCTION v_txtindex.caseInsensitiveNoStemming(x Long Varchar)
RETURN long varchar AS
BEGIN
RETURN lower(x);
END;

CREATE FUNCTION v_txtindex.StemmerCaseInsensitive(v Long Varchar)
RETURN long varchar AS
BEGIN
RETURN v_txtindex.StemmerCaseSensitive(lower(v));
END;

CREATE FUNCTION v_txtindex.Stemmer(v Long Varchar)
RETURN long varchar AS
BEGIN
RETURN v_txtindex.StemmerCaseSensitive(lower(v));
END;

SELECT MARK_DESIGN_KSAFE(1);


