drop table cycles;
drop table organization_types;
drop table applications;
drop table sub_cycle_weeks_in_a_year;
drop table sub_cycle_weeks_in_a_month;
drop table sub_cycle_days_in_a_month;
drop table sub_cycle_days_in_an_year;
drop table days_of_the_week;
drop table sub_cycle_days_of_the_week;
drop table event_definitions;
drop table event_parameters;
drop table event_queue_status;
drop table group_events;
drop table organizations;
drop table event_group_organization_defaults;
drop table event_queues;
drop table event_logs;
drop table sub_cycle_time_in_a_day;
drop table sub_cycle_generics;
drop table data_types;
drop table groups;
drop table group_event_restrictions;
drop table event_group_restrictions;
drop table helper_sql_execution_points;
drop table helper_sql_types;
drop table helper_sql_headers;
drop table helper_sql_details;
drop table interval_measures;
drop table months_in_a_year;
drop table sub_cycle_months;
drop table sub_cycle_add;
drop table interval_conversions;
drop table event_restrictions;
drop table group_restrictions;

create table applications
(id   number(5)   not null constraint pk_applications primary key,
 code varchar2(8) not null constraint uk_applications unique,
 name varchar2(40) not null,
 description varchar2(200) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null
);

create table organization_types
(id number(3) not null constraint pk_organization_types primary key,
 code varchar2(8) not null constraint uk_organization_types unique,
 description varchar2(40) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null
);

create table organizations
(id number(5) not null constraint pk_organizations primary key,
 type number(3) not null,
 code varchar2(8) not null constraint uk_organizations_1 unique,
 short_nm varchar2(5) not null  constraint uk_organizations_2 unique,
 name     varchar2(40) not null,
 parent_id number(5) null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint fk_organizations_organization_types foreign key (type) references organization_types(id),
 constraint fk_organizations_organizations foreign key (parent_id) references organizations(id)
);

create table cycles
(id           NUMBER(5) not null constraint pk_cycles primary key,
 code        varchar2(20) not null constraint uk_cycles unique,
 description  VARCHAR2(80) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null
);

create table months_in_a_year
(id   number(2) not null constraint pk_months_in_a_year primary key,
 code varchar2(3) not null constraint uk_months_in_a_year unique,
 description varchar2(9) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null
);

create table sub_cycle_months
(cycle_id number(5) not null,
 month_id number(2) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_sub_cycle_months primary key (cycle_id, month_id),
 constraint fk_sub_cycle_months_cycles foreign key (cycle_id) references cycles(id),
 constraint fk_sub_cycle_months_months_in_a_year foreign key (month_id) references months_in_a_year(id)
);

create table sub_cycle_days_in_a_month
(cycle_id number(5) not null,
 day_id  number(2) not null constraint ck_sub_cycle_days_in_a_month check (day_id between 1 and 31),
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_sub_cycle_days_in_a_month primary key (cycle_id, day_id),
 constraint fk_sub_cycle_days_in_a_month_cycles foreign key (cycle_id) references cycles(id)
);

create table sub_cycle_days_in_an_year
(cycle_id number(5) not null,
 day_id  number(3) not null constraint ck_sub_cycle_days_in_an_year check (day_id between 1 and 366),
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_sub_cycle_days_in_an_year primary key (cycle_id, day_id),
 constraint fk_sub_cycle_days_in_an_year_cycles foreign key (cycle_id) references cycles(id)
);

create table sub_cycle_weeks_in_a_year
(cycle_id number(5) not null,
 week_id  number(2) not null constraint ck_sub_cycle_weeks_in_a_year check (week_id between 1 and 52),
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_sub_cycle_weeks_in_a_year primary key (cycle_id, week_id),
 constraint fk_sub_cycle_weeks_in_a_year_cycles foreign key (cycle_id) references cycles(id)
);

create table sub_cycle_weeks_in_a_month
(cycle_id number(5) not null,
 week_id  number(1) not null constraint ck_sub_cycle_weeks_in_a_month check (week_id between 1 and 5),
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_sub_cycle_weeks_in_a_month primary key (cycle_id, week_id),
 constraint fk_sub_cycle_weeks_in_a_month_cycles foreign key (cycle_id) references cycles(id)
);

create table days_of_the_week
(id   number(1) not null constraint pk_days_of_the_week primary key,
 code varchar2(3) not null constraint uk_days_of_the_week unique,
 description varchar2(9) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null
);

create table sub_cycle_days_of_the_week
(cycle_id number(5) not null,
 day_id   number(1) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_sub_cycle_days_of_the_week primary key (cycle_id, day_id),
 constraint fk_sub_cycle_days_of_the_week_cycles foreign key (cycle_id) references cycles(id),
 constraint fk_sub_cycle_days_of_the_week_days_of_the_week foreign key (day_id) references days_of_the_week(id)
);

create table sub_cycle_time_in_a_day
(cycle_id      number(5) not null,
 database_time varchar2(5) not null constraint ck_sub_cycle_time_in_a_day check(regexp_like(database_time, '^(([0-9])|([0-1][0-9])|([2][0-3]))(:(([0-9])|([0-5][0-9])))?$')),
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_sub_cycle_time_in_a_day primary key(cycle_id, database_time),
 constraint fk_sub_cycle_time_in_a_day foreign key (cycle_id) references cycles(id)
);

create table sub_cycle_generics
(cycle_id   number(5) not null,
 measure_code   varchar2(20) not null,
 units          number(8, 2) default 0 not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_sub_cycle_generics primary key (cycle_id, measure_code),
 constraint fk_sub_cycle_generics foreign key (cycle_id) references cycles(id)
);

create table interval_measures
(id   number(1) not null constraint pk_interval_measures primary key,
 symbol varchar2(7) not null constraint uk_interval_measures unique,
 description varchar2(7) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null
);

create table interval_conversions
(unit       number(6) not null,
 measure_id number(1) not null,
 converted_unit number(6) not null,
 converted_measure_id number(1) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_interval_conversions primary key (unit, measure_id),
 constraint fk_interval_conversions_interval_measures_1 foreign key (measure_id) references interval_measures(id),
 constraint fk_interval_conversions_interval_measures_2 foreign key (converted_measure_id) references interval_measures(id)
);

create table sub_cycle_add
(cycle_id  number(5) not null,
 interval_id number(1) not null,
 units       number(8, 2) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_sub_cycle_add primary key (cycle_id, interval_id),
 constraint fk_sub_cycle_add_cycles foreign key (cycle_id) references cycles(id),
 constraint fk_sub_cycle_add_interval_measures foreign key (interval_id) references interval_measures(id)
);

create table groups
(id  NUMBER(38,0) not null constraint pk_groups primary key,
 description  VARCHAR2(50) not null,
 application_id number(5) not null,
 cycle_id  NUMBER(5) not null,
 preferred_run_tm    date,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint fk_groups_application foreign key (application_id) references applications(id),
 constraint fk_groups_cycle foreign key (cycle_id) references cycles(id)
);

create table event_definitions
(id   NUMBER(38,0) not null constraint pk_event_definitions primary key,
 description  VARCHAR2(80) not null,
 procedure_name  VARCHAR2(512)  not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null
);

create table event_restrictions
(event_id            NUMBER(38,0) not null,
 restricted_event_id NUMBER(38,0) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_event_restrictions primary key (event_id, restricted_event_id),
 constraint fk_event_restrictions_event_definitions_1 foreign key (event_id) references event_definitions (id),
 constraint fk_event_restrictions_event_definitions_2 foreign key (restricted_event_id) references event_definitions (id)
);

create table group_restrictions
(group_id            NUMBER(38,0) not null,
 restricted_group_id NUMBER(38,0) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_group_restrictions primary key (group_id, restricted_group_id),
 constraint fk_group_restrictions_groups_1 foreign key (group_id) references groups (id),
 constraint fk_group_restrictions_groups_2 foreign key (restricted_group_id) references groups (id)
);

create table group_event_restrictions
(group_id            NUMBER(38,0) not null,
 restricted_event_id NUMBER(38,0) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_group_event_restrictions primary key (group_id, restricted_event_id),
 constraint fk_group_event_restrictions_groups foreign key (group_id) references groups (id),
 constraint fk_group_event_restrictions_event_definitions foreign key (restricted_event_id) references event_definitions (id)
);

create table event_group_restrictions
(event_id            number(38,0) not null,
 restricted_group_id number(38,0) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_event_group_restrictions primary key (event_id, restricted_group_id),
 constraint fk_event_group_restrictions_event_definitions foreign key (event_id) references event_definitions (id),
 constraint fk_event_group_restrictions_groups foreign key (restricted_group_id) references groups (id)
);

create table data_types
(id  NUMBER(4) not null constraint pk_data_types primary key,
 description  VARCHAR2(40) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null
);

create table event_parameters
(event_definition_id NUMBER(38,0) not null ,
 sequence  number(4) not null,
 parameter_name  VARCHAR2(128) not null,
 data_type_id   NUMBER(2) not null,
 parameter_size  VARCHAR2(10) null,
 parameter_type  VARCHAR2(10) null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_event_parameters primary key (event_definition_id, sequence),
 constraint fk_event_parameters_event_definitions foreign key (event_definition_id) references event_definitions (id),
 constraint fk_event_parameters_data_types foreign key (data_type_id) references data_types(id)
);

create table group_events
(group_id  NUMBER(38,0) not null,
 event_definition_id NUMBER(38,0) not null,
 sequence  NUMBER(4) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_group_events primary key (group_id, event_definition_id),
 constraint fk_group_events_groups foreign key (group_id) references groups(id),
 constraint fk_group_events_event_definitions foreign key (event_definition_id) references event_definitions (id)
);

create table event_queue_status
(id  NUMBER(3) not null constraint pk_event_queue_status primary key,  
 description  VARCHAR2(40) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null
);

create table event_queues
(id  NUMBER(38,0) not null constraint pk_event_queues primary key,
 previous_id  NUMBER(38,0) null,
 group_id  NUMBER(38,0) not null,
 event_definition_id NUMBER(38,0) not null,
 organization_id number(5) not null,
 value  CLOB  null,
 status_id   NUMBER(3) not null,
 run_after_tm   date null,
 create_user_id varchar2(128) not null,
 create_date       date default current_date not null,
 last_update_user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint fk_event_queues_event_queues foreign key (previous_id) references event_queues(id),
 constraint fk_event_queues_group_events foreign key (group_id, event_definition_id) references group_events (group_id, event_definition_id),
 constraint fk_event_queues_organizations foreign key (organization_id) references organizations(id),
 constraint fk_event_queues_event_queue_status foreign key (status_id) references event_queue_status(id)
);

create table event_logs
(queue_id number(38) not null,
 lap_id number(4)  default 1 not null,
 message  varchar2(512) not null,
 create_ts   TIMESTAMP(6) not null,
 begin_ts  TIMESTAMP(6) null,
 end_ts   TIMESTAMP(6) null,
 finish_cd number(1) not null,
 constraint pk_event_logs primary key (queue_id, lap_id),
 constraint fk_event_logs_event_queues foreign key (queue_id) references event_queues(id)
);

create table event_group_organization_defaults
(group_id    NUMBER(38,0) not null,
 event_definition_id NUMBER(38,0) not null,
 parameter_sequence  number(4) not null,
 organization_id     number(5) not null,
 value               clob not null,
 create_user_id varchar2(128) not null,
 create_date       date default current_date not null,
 last_update_user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_event_group_organization_defaults primary key (group_id, event_definition_id, parameter_sequence, organization_id),
 constraint fk_event_group_organization_defaults_group_events foreign key (group_id, event_definition_id)  references group_events (group_id, event_definition_id),
 constraint fk_event_group_organization_defaults_event_parameters foreign key (event_definition_id, parameter_sequence) references event_parameters (event_definition_id, sequence),
 constraint fk_event_group_organization_defaults_organizations foreign key (organization_id) references organizations(id)
);

create table helper_sql_types
(id  number(3) not null constraint pk_helper_sql_types primary key,
 description varchar2(20) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null
);

create table helper_sql_execution_points
(id   number(1) not null constraint pk_helper_sql_execution_points primary key,
 description varchar2(5) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null
);

create table helper_sql_headers
(id   number(5) not null constraint pk_helper_sql_headers primary key,
 type number(3) not null,
 execution_point_id number(1) not null,
 reference_id number(38, 0) not null,
 sub_reference_id number(38, 0) null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint fk_helper_sql_headers_helper_sql_types foreign key (type) references helper_sql_types(id),
 constraint fk_helper_sql_headers_helper_sql_execution_points foreign key (execution_point_id) references helper_sql_execution_points(id)
);

create table helper_sql_details
(header_id number(5) not null,
 id        number(3) not null,
 sql_text  clob not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_helper_sql_details primary key (header_id, id),
 constraint fk_helper_sql_details_helper_sql_headers foreign key (header_id) references helper_sql_headers(id)
);

