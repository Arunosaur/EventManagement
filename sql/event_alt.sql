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


create table classifications
(id          varchar2(4) not null constraint pk_classifications primary key,
 description varchar2(40) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null
);

create table applications_classified
(application_id   number(5) not null,
 class_id         varchar2(4) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_applications_classified primary key (application_id, class_id),
 constraint fk_applications_classified_applications foreign key (application_id) references applications(id),
 constraint fk_applications_classified_classifications foreign key (class_id) references classifications(id)
);

create table groups
(id  NUMBER(38,0) not null constraint pk_groups primary key,
 description  VARCHAR2(50) not null,
 cycle_id  NUMBER(5) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint fk_groups_cycle foreign key (cycle_id) references cycles(id)
);

create table event_definitions
(id   NUMBER(38,0) not null constraint pk_event_definitions primary key,
 description  VARCHAR2(80) not null,
 procedure_name  VARCHAR2(512)  not null,
 application_id number(5) not null,
 class_id       varchar2(4) not null,
 user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint fk_event_definitions_applications_classified foreign key (application_id, class_id) references applications_classified (application_id, class_id)
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
 user_id varchar2(128) not null,
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
 end_ts   TIMESTAMP(6)   null,
 finish_cd number(1) not null,
 constraint pk_event_logs primary key (queue_id, lap_id),
 constraint fk_event_logs_event_queues foreign key (queue_id) references event_queues(id)
);

create table event_group_organization_defaults
(group_id    NUMBER(38,0) not null,
 event_definition_id NUMBER(38,0) not null,
 event_sequence      number(4) not null,
 organization_id     number(5) not null,
 value               clob not null,
 preferred_run_tm    date,
 create_user_id varchar2(128) not null,
 create_date       date default current_date not null,
 last_update_user_id varchar2(128) not null,
 last_change_date  date default current_date not null,
 constraint pk_event_group_organization_defaults primary key (group_id, event_definition_id, event_sequence, organization_id),
 constraint fk_event_group_organization_defaults_group_events foreign key (group_id, event_definition_id)  references group_events (group_id, event_definition_id),
 constraint fk_event_group_organization_defaults_event_parameters foreign key (event_definition_id, event_sequence) references event_parameters (event_definition_id, sequence),
 constraint fk_event_group_organization_defaults_organizations foreign key (organization_id) references organizations(id)
);
