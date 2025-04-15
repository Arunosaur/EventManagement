create table applications
(id               number(5)                 not null constraint pk_applications primary key,
 code             varchar2(8)               not null constraint uk_applications unique,
 name             varchar2(40)              not null,
 description      varchar2(200)             not null,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null
)
/

create table organization_types
(id               number(3)                 not null constraint pk_organization_types primary key,
 code             varchar2(8)               not null constraint uk_organization_types unique,
 description      varchar2(40)              not null,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null
)
/

create table organizations
(id               number(5)                 not null constraint pk_organizations primary key,
 type             number(3)                 not null constraint fk_organizations_organization_types references organization_types,
 code             varchar2(8)               not null constraint uk_organizations_1 unique,
 short_nm         varchar2(5)               not null constraint uk_organizations_2 unique,
 name             varchar2(40)              not null,
 parent_id        number(5)                          constraint fk_organizations_organizations references organizations,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null
)
/

create table cycles
(id               number(5)                 not null constraint pk_cycles primary key,
 code             varchar2(20)              not null constraint uk_cycles unique,
 description      varchar2(80)              not null,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null
)
/

create table months_in_a_year
(id               number(2)                 not null constraint pk_months_in_a_year primary key,
 code             varchar2(3)               not null constraint uk_months_in_a_year unique,
 description      varchar2(9)               not null,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null
)
/

create table sub_cycle_months
(cycle_id         number(5)                 not null constraint fk_sub_cycle_months_cycles references cycles,
 month_id         number(2)                 not null constraint fk_sub_cycle_months_months_in_a_year references months_in_a_year,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null,
 constraint pk_sub_cycle_months primary key (cycle_id, month_id)
)
/

create table sub_cycle_weeks_in_a_year
(cycle_id         number(5)                 not null constraint fk_sub_cycle_weeks_in_a_year_cycles references cycles,
 week_id          number(2)                 not null constraint ck_sub_cycle_weeks_in_a_year check (week_id between 1 and 52),
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null,
 constraint pk_sub_cycle_weeks_in_a_year primary key (cycle_id, week_id)
)
/

create table sub_cycle_weeks_in_a_month
(cycle_id         number(5)                 not null constraint fk_sub_cycle_weeks_in_a_month_cycles references cycles,
 week_id          number(1)                 not null constraint ck_sub_cycle_weeks_in_a_month check (week_id between 1 and 5),
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null,
 constraint pk_sub_cycle_weeks_in_a_month primary key (cycle_id, week_id)
)
/

create table days_of_the_week
(id               number(1)                 not null constraint pk_days_of_the_week primary key,
 code             varchar2(3)               not null constraint uk_days_of_the_week unique,
 description      varchar2(9)               not null,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null
)
/

create table sub_cycle_days_of_the_week
(cycle_id         number(5)                 not null constraint fk_sub_cycle_days_of_the_week_cycles references cycles,
 day_id           number(1)                 not null constraint fk_sub_cycle_days_of_the_week_days_of_the_week references days_of_the_week,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null,
 constraint pk_sub_cycle_days_of_the_week primary key (cycle_id, day_id)
)
/

create table sub_cycle_time_in_a_day
(cycle_id         number(5)                 not null constraint fk_sub_cycle_time_in_a_day references cycles,
 database_time    varchar2(5)               not null constraint ck_sub_cycle_time_in_a_day check (regexp_like(database_time, '^(([0-9])|([0-1][0-9])|([2][0-3]))(:(([0-9])|([0-5][0-9])))?$')),
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null,
 constraint pk_sub_cycle_time_in_a_day primary key (cycle_id, database_time)
)
/

create table sub_cycle_generics
(cycle_id         number(5)                 not null constraint fk_sub_cycle_generics references cycles,
 measure_code     varchar2(20)              not null,
 units            number(8, 2) default 0    not null,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null,
 constraint pk_sub_cycle_generics primary key (cycle_id, measure_code)
)
/

create table interval_measures
(
    id               number(1)                 not null constraint pk_interval_measures primary key,
    symbol           varchar2(7)               not null constraint uk_interval_measures unique,
    description      varchar2(7)               not null,
    user_id          varchar2(128)             not null,
    last_change_date date default current_date not null
)
/

create table interval_conversions
(unit                 number(6)                 not null,
 measure_id           number(1)                 not null constraint fk_interval_conversions_interval_measures_1 references interval_measures,
 converted_unit       number(6)                 not null,
 converted_measure_id number(1)                 not null constraint fk_interval_conversions_interval_measures_2 references interval_measures,
 user_id              varchar2(128)             not null,
 last_change_date     date default current_date not null,
 constraint pk_interval_conversions primary key (unit, measure_id)
)
/

create table sub_cycle_add
(cycle_id         number(5)                 not null constraint fk_sub_cycle_add_cycles references cycles,
 interval_id      number(1)                 not null constraint fk_sub_cycle_add_interval_measures references interval_measures,
 units            number(8, 2)              not null,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null,
 constraint pk_sub_cycle_add primary key (cycle_id, interval_id)
)
/

create table groups
(id               number(38)                not null constraint pk_groups primary key,
 description      varchar2(50)              not null,
 application_id   number(5)                 not null constraint fk_groups_application references applications,
 cycle_id         number(5)                 not null constraint fk_groups_cycle references cycles,
 preferred_run_tm date,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null
)
/

create unique index unq_groups_01 on groups (description)
/

create table event_definitions
(id               number(38)                not null constraint pk_event_definitions primary key,
 description      varchar2(80)              not null,
 procedure_name   varchar2(512)             not null,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null
)
/

create unique index unq_event_definitions_01
    on event_definitions (description, procedure_name)
/

create unique index fbi_event_definitions_01
    on event_definitions (upper("procedure_name"))
/

create table event_restrictions
(event_id            number(38)                not null constraint fk_event_restrictions_event_definitions_1 references event_definitions,
 restricted_event_id number(38)                not null constraint fk_event_restrictions_event_definitions_2 references event_definitions,
 user_id             varchar2(128)             not null,
 last_change_date    date default current_date not null,
 constraint pk_event_restrictions primary key (event_id, restricted_event_id)
)
/

create table group_restrictions
(group_id            number(38)                not null constraint fk_group_restrictions_groups_1 references groups,
 restricted_group_id number(38)                not null constraint fk_group_restrictions_groups_2 references groups,
 user_id             varchar2(128)             not null,
 last_change_date    date default current_date not null,
 constraint pk_group_restrictions primary key (group_id, restricted_group_id)
)
/

create table group_event_restrictions
(group_id            number(38)                not null constraint fk_group_event_restrictions_groups references groups,
 restricted_event_id number(38)                not null constraint fk_group_event_restrictions_event_definition references event_definitions,
 user_id             varchar2(128)             not null,
 last_change_date    date default current_date not null,
 constraint pk_group_event_restrictions primary key (group_id, restricted_event_id)
)
/

create table event_group_restrictions
(event_id            number(38)                not null constraint fk_event_group_restrictions_event_definitions references event_definitions,
 restricted_group_id number(38)                not null constraint fk_event_group_restrictions_groups references groups,
 user_id             varchar2(128)             not null,
 last_change_date    date default current_date not null,
 constraint pk_event_group_restrictions primary key (event_id, restricted_group_id)
)
/

create table data_types
(id               number(4)                 not null constraint pk_data_types primary key,
 description      varchar2(40)              not null,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null
)
/

create table event_parameters
(event_definition_id number(38)                not null constraint fk_event_parameters_event_definitions references event_definitions,
 sequence            number(4)                 not null,
 parameter_name      varchar2(128)             not null,
 data_type_id        number(2)                 not null constraint fk_event_parameters_data_types references data_types,
 parameter_size      varchar2(10),
 parameter_type      varchar2(10),
 user_id             varchar2(128)             not null,
 last_change_date    date default current_date not null,
 constraint pk_event_parameters primary key (event_definition_id, sequence)
)
/

create table group_events
(group_id            number(38)                not null constraint fk_group_events_groups references groups,
 event_definition_id number(38)                not null constraint fk_group_events_event_definitions references event_definitions,
 sequence            number(4)                 not null,
 user_id             varchar2(128)             not null,
 last_change_date    date default current_date not null,
 constraint pk_group_events primary key (group_id, event_definition_id)
)
/

create table event_queue_status
(id               number(3)                 not null constraint pk_event_queue_status primary key,
 description      varchar2(40)              not null,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null
)
/

create table event_group_organization_defaults
(group_id            number(38)                not null,
 event_definition_id number(38)                not null,
 parameter_sequence  number(4)                 not null,
 organization_id     number(5)                 not null constraint fk_event_group_organization_defaults_organizations references organizations,
 value               clob                      not null,
 create_user_id      varchar2(128)             not null,
 create_date         date default current_date not null,
 last_update_user_id varchar2(128)             not null,
 last_change_date    date default current_date not null,
 constraint pk_event_group_organization_defaults primary key (group_id, event_definition_id, parameter_sequence, organization_id),
 constraint fk_event_group_organization_defaults_event_parameters foreign key (event_definition_id, parameter_sequence) references event_parameters,
 constraint fk_event_group_organization_defaults_group_events foreign key (group_id, event_definition_id) references group_events
)
/

create table helper_sql_types
(id               number(3)                 not null constraint pk_helper_sql_types primary key,
 description      varchar2(20)              not null,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null
)
/

create table helper_sql_execution_points
(id               number(1)                 not null constraint pk_helper_sql_execution_points primary key,
 description      varchar2(5)               not null,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null
)
/

create table helper_sql_headers
(id                 number(5)                 not null constraint pk_helper_sql_headers primary key,
 type               number(3)                 not null constraint fk_helper_sql_headers_helper_sql_types references helper_sql_types,
 execution_point_id number(1)                 not null constraint fk_helper_sql_headers_helper_sql_execution_points references helper_sql_execution_points,
 reference_id       number(38)                not null,
 sub_reference_id   number(38),
 user_id            varchar2(128)             not null,
 last_change_date   date default current_date not null
)
/

create table helper_sql_details
(header_id        number(5)                 not null constraint fk_helper_sql_details_helper_sql_headers references helper_sql_headers,
 id               number(3)                 not null,
 sql_text         clob                      not null,
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null,
 constraint pk_helper_sql_details primary key (header_id, id)
)
/

create table sub_cycle_days_in_a_month
(cycle_id         number(5)                 not null constraint fk_sub_cycle_days_in_a_month_cycles references cycles,
 day_id           number(2)                 not null constraint ck_sub_cycle_days_in_a_month check (day_id between 1 and 31),
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null,
 constraint pk_sub_cycle_days_in_a_month primary key (cycle_id, day_id)
)
/

create table sub_cycle_days_in_an_year
(cycle_id         number(5)                 not null constraint fk_sub_cycle_days_in_an_year_cycles references cycles,
 day_id           number(3)                 not null constraint ck_sub_cycle_days_in_an_year check (day_id between 1 and 366),
 user_id          varchar2(128)             not null,
 last_change_date date default current_date not null,
 constraint pk_sub_cycle_days_in_an_year primary key (cycle_id, day_id)
)
/

create table event_queues
(id                  number(38)                not null constraint pk_event_queues primary key,
 previous_id         number(38)                         constraint fk_event_queues_event_queues references event_queues,
 group_id            number(38)                not null,
 event_definition_id number(38)                not null,
 organization_id     number(5)                 not null constraint fk_event_queues_organizations references organizations,
 value               clob,
 status_id           number(3)                 not null constraint fk_event_queues_event_queue_status references event_queue_status,
 run_after_tm        date,
 create_user_id      varchar2(128)             not null,
 create_date         date default current_date not null,
 last_update_user_id varchar2(128)             not null,
 last_change_date    date default current_date not null,
 constraint fk_event_queues_group_events foreign key (group_id, event_definition_id) references group_events
)
/

create table event_logs
(queue_id  number(38)          not null constraint fk_event_logs_event_queues references event_queues,
 lap_id    number(4) default 1 not null,
 message   varchar2(512)       not null,
 create_ts timestamp(6)        not null,
 begin_ts  timestamp(6),
 end_ts    timestamp(6),
 finish_cd number(1)           not null,
 constraint pk_event_logs primary key (queue_id, lap_id)
)
/