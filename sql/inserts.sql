prompt PL/SQL Developer Export Tables for user EM@OMS_OMST1
prompt Created by asrajag on Saturday, February 4, 2023
set feedback off
set define off

prompt Loading EM.APPLICATIONS...
insert into EM.APPLICATIONS (id, code, name, description, user_id, last_change_date)
values (1, 'TMSHUB', 'TMSHUB', 'Transportaion Hub', 'asrajag', to_date('29-11-2022 16:41:18', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.APPLICATIONS (id, code, name, description, user_id, last_change_date)
values (2, 'WMSHUB', 'WMSHUB', 'WMS Hub', 'asrajag', to_date('29-11-2022 16:41:19', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.APPLICATIONS (id, code, name, description, user_id, last_change_date)
values (3, 'WMSLT', 'WMSLT', 'WMS Light', 'asrajag', to_date('29-11-2022 16:41:19', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.APPLICATIONS (id, code, name, description, user_id, last_change_date)
values (4, 'OMS', 'OMS', 'Order Management System', 'asrajag', to_date('29-11-2022 16:41:19', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 4 records loaded
prompt Loading EM.CYCLES...
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (1, 'ON_DEMAND', 'On Demand', 'asrajag', to_date('29-11-2022 17:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (2, 'DAILY', 'Daily', 'asrajag', to_date('29-11-2022 17:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (3, 'WEEKDAYS', 'Week Days', 'asrajag', to_date('29-11-2022 17:00:02', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (4, 'WEEKENDS', 'Week Ends', 'asrajag', to_date('29-11-2022 17:00:02', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (5, 'WEEKLY', 'Weekly', 'asrajag', to_date('29-11-2022 17:00:02', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (6, 'MONTHLY', 'Monthly', 'asrajag', to_date('29-11-2022 20:57:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (7, 'QUARTERLY', 'Quarterly', 'asrajag', to_date('29-11-2022 20:57:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (8, 'HALF_YEARLY', 'Half Yearly', 'asrajag', to_date('29-11-2022 20:57:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (9, 'ANNUAL', 'Annual', 'asrajag', to_date('29-11-2022 20:57:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (10, 'BIMONTHLY_1', 'Twice a Month', 'asrajag', to_date('29-11-2022 20:57:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (11, 'BIMONTHLY_2', 'Once in Two Months', 'asrajag', to_date('29-11-2022 20:57:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (12, '5_MINUTES', 'Minutes', 'asrajag', to_date('29-11-2022 21:09:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (13, '30_MINUTES', 'Minutes', 'asrajag', to_date('29-11-2022 21:09:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (14, '1_HOURS', 'Hours', 'asrajag', to_date('29-11-2022 21:09:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (15, '2_HOURS', 'Hours', 'asrajag', to_date('29-11-2022 21:09:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (16, '6_HOURS', 'Hours', 'asrajag', to_date('29-11-2022 21:09:06', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (17, '12_HOURS', 'Hours', 'asrajag', to_date('29-11-2022 21:09:06', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (18, 'ALT_DAYS_1', 'M,W,F', 'asrajag', to_date('29-11-2022 21:09:06', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (19, 'ALT_DAYS_2', 'TU,TH', 'asrajag', to_date('29-11-2022 21:09:06', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (20, 'ALT_DAYS_3', 'SU,TU,F,', 'asrajag', to_date('29-11-2022 21:09:06', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (21, 'ALT_DAYS_4', 'M,W,TH,SA', 'asrajag', to_date('29-11-2022 21:09:06', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (22, '1ST_OF_MONTH', 'First of the Month', 'asrajag', to_date('01-12-2022 09:21:08', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (23, 'LAST_DAY_OF_MONTH', 'Last Day of the Month', 'asrajag', to_date('01-12-2022 09:21:08', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.CYCLES (id, code, description, user_id, last_change_date)
values (24, 'MID_MONTH', 'Middle of the Month', 'asrajag', to_date('01-12-2022 09:51:21', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 24 records loaded
prompt Loading EM.DATA_TYPES...
insert into EM.DATA_TYPES (id, description, user_id, last_change_date)
values (1, 'NUMBER', 'asrajag', to_date('30-11-2022 07:20:15', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.DATA_TYPES (id, description, user_id, last_change_date)
values (2, 'VARCHAR2', 'asrajag', to_date('30-11-2022 07:20:15', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.DATA_TYPES (id, description, user_id, last_change_date)
values (3, 'DATE', 'asrajag', to_date('30-11-2022 07:20:16', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.DATA_TYPES (id, description, user_id, last_change_date)
values (4, 'TIMESTAMP', 'asrajag', to_date('30-11-2022 07:20:16', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.DATA_TYPES (id, description, user_id, last_change_date)
values (5, 'CLOB', 'asrajag', to_date('30-11-2022 07:20:16', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.DATA_TYPES (id, description, user_id, last_change_date)
values (6, 'RAW', 'asrajag', to_date('30-11-2022 07:20:16', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 6 records loaded
prompt Loading EM.DAYS_OF_THE_WEEK...
insert into EM.DAYS_OF_THE_WEEK (id, code, description, user_id, last_change_date)
values (1, 'SUN', 'Sunday', 'asrajag', to_date('30-11-2022 20:08:43', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.DAYS_OF_THE_WEEK (id, code, description, user_id, last_change_date)
values (2, 'MON', 'Monday', 'asrajag', to_date('30-11-2022 20:08:43', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.DAYS_OF_THE_WEEK (id, code, description, user_id, last_change_date)
values (3, 'TUE', 'Tuesday', 'asrajag', to_date('30-11-2022 20:08:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.DAYS_OF_THE_WEEK (id, code, description, user_id, last_change_date)
values (4, 'WED', 'Wednesday', 'asrajag', to_date('30-11-2022 20:08:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.DAYS_OF_THE_WEEK (id, code, description, user_id, last_change_date)
values (5, 'THU', 'Thursday', 'asrajag', to_date('30-11-2022 20:08:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.DAYS_OF_THE_WEEK (id, code, description, user_id, last_change_date)
values (6, 'FRI', 'Friday', 'asrajag', to_date('30-11-2022 20:08:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.DAYS_OF_THE_WEEK (id, code, description, user_id, last_change_date)
values (7, 'SAT', 'Saturday', 'asrajag', to_date('30-11-2022 20:08:44', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 7 records loaded
prompt Loading EM.EVENT_DEFINITIONS...
insert into EM.EVENT_DEFINITIONS (id, description, procedure_name, user_id, last_change_date)
values (1, 'Simulation Package - Simulation', 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating', 'asrajag', to_date('02-02-2023 09:34:24', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_DEFINITIONS (id, description, procedure_name, user_id, last_change_date)
values (2, 'Simulation Package - Simulation - 1', 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_1', 'asrajag', to_date('03-02-2023 05:06:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_DEFINITIONS (id, description, procedure_name, user_id, last_change_date)
values (3, 'Simulation Package - Simulation - 2', 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_2', 'asrajag', to_date('03-02-2023 05:06:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_DEFINITIONS (id, description, procedure_name, user_id, last_change_date)
values (4, 'Simulation Package - Simulation - 3', 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_3', 'asrajag', to_date('03-02-2023 05:06:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_DEFINITIONS (id, description, procedure_name, user_id, last_change_date)
values (5, 'Simulation Package - Simulation - 4', 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_4', 'asrajag', to_date('03-02-2023 05:06:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_DEFINITIONS (id, description, procedure_name, user_id, last_change_date)
values (6, 'Simulation Package - Simulation - 5', 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_5', 'asrajag', to_date('03-02-2023 05:06:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_DEFINITIONS (id, description, procedure_name, user_id, last_change_date)
values (7, 'Simulation Package - Simulation - 6', 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_6', 'asrajag', to_date('03-02-2023 05:06:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_DEFINITIONS (id, description, procedure_name, user_id, last_change_date)
values (8, 'Simulation Package - Simulation - 7', 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_7', 'asrajag', to_date('03-02-2023 05:06:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_DEFINITIONS (id, description, procedure_name, user_id, last_change_date)
values (9, 'Simulation Package - Simulation - 8', 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_8', 'asrajag', to_date('03-02-2023 05:06:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_DEFINITIONS (id, description, procedure_name, user_id, last_change_date)
values (10, 'Simulation Package - Simulation - 9', 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_9', 'asrajag', to_date('03-02-2023 05:06:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_DEFINITIONS (id, description, procedure_name, user_id, last_change_date)
values (11, 'Simulation Package - Simulation - 10', 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_10', 'asrajag', to_date('03-02-2023 05:06:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_DEFINITIONS (id, description, procedure_name, user_id, last_change_date)
values (12, 'Simulation Package - Simulation - 11', 'WMSHUB_CODE.ASRAJAG_SIM_1_PK.simulating_11', 'asrajag', to_date('03-02-2023 05:24:42', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 12 records loaded
prompt Loading EM.GROUPS...
insert into EM.GROUPS (id, description, application_id, cycle_id, preferred_run_tm, user_id, last_change_date)
values (3, 'Arun Simulation Group 2', 2, 1, null, 'asrajag', to_date('03-02-2023 06:28:27', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.GROUPS (id, description, application_id, cycle_id, preferred_run_tm, user_id, last_change_date)
values (1, 'Arun Simulation Group', 2, 1, null, 'asrajag', to_date('02-02-2023 09:35:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.GROUPS (id, description, application_id, cycle_id, preferred_run_tm, user_id, last_change_date)
values (2, 'Arun Simulation Group 1', 2, 1, null, 'asrajag', to_date('03-02-2023 05:42:04', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 3 records loaded
prompt Loading EM.EVENT_GROUP_RESTRICTIONS...
prompt Table is empty
prompt Loading EM.EVENT_LOGS...
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (18, 1, 'Will start shortly...', to_timestamp('03-02-2023 11:02:42.684723', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:02:42.690996', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:02:42.690996', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (18, 2, 'Sleep index: 1 for DC 150', to_timestamp('03-02-2023 11:02:42.691722', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:02:42.691722', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:02:45.700724', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (18, 3, 'Sleep index: 2 for DC 150', to_timestamp('03-02-2023 11:02:45.700865', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:02:45.700865', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:02:52.036902', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (18, 4, 'Sleep index: 3 for DC 150', to_timestamp('03-02-2023 11:02:52.037111', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:02:52.037111', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:03:01.252800', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (18, 5, 'Sleep index: 4 for DC 150', to_timestamp('03-02-2023 11:03:01.252973', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:03:01.252973', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:03:13.540946', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (18, 6, 'Sleep index: 5 for DC 150', to_timestamp('03-02-2023 11:03:13.541137', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:03:13.541137', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:03:28.901898', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (18, 7, 'Simulation 1 is  Complete', to_timestamp('03-02-2023 11:03:28.903216', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:03:28.903216', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:03:28.903216', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (17, 1, 'Simulation is Complete', to_timestamp('03-02-2023 11:05:14.886115', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:05:17.894171', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:06:33.670125', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (20, 1, 'Will start shortly...', to_timestamp('03-02-2023 11:36:11.741755', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:11.744043', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:11.744043', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (20, 2, 'Sleep index: 1 for DC 200', to_timestamp('03-02-2023 11:36:11.744135', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:11.744135', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:14.788662', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (20, 3, 'Sleep index: 2 for DC 200', to_timestamp('03-02-2023 11:36:14.788824', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:14.788824', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:21.125314', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (20, 4, 'Sleep index: 3 for DC 200', to_timestamp('03-02-2023 11:36:21.125474', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:21.125474', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:30.341296', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (20, 5, 'Sleep index: 4 for DC 200', to_timestamp('03-02-2023 11:36:30.341430', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:30.341430', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:42.628951', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (20, 6, 'Sleep index: 5 for DC 200', to_timestamp('03-02-2023 11:36:42.629123', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:42.629123', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:57.989426', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (20, 7, 'Simulation 1 is  Complete', to_timestamp('03-02-2023 11:36:57.989603', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:57.989603', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:57.989603', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (21, 1, 'Simulation is Complete', to_timestamp('03-02-2023 11:36:57.993279', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:36:57.993580', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:38:13.700817', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (16, 1, 'Simulation is Complete', to_timestamp('03-02-2023 11:40:21.605738', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:40:24.646599', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 11:41:40.548598', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (13, 1, 'Will start shortly...', to_timestamp('02-02-2023 17:43:35.804258', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, -1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (14, 1, 'Complete', to_timestamp('02-02-2023 17:46:34.680610', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-02-2023 17:46:37.707017', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('02-02-2023 17:50:23.699259', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (15, 1, 'Simulation is Complete', to_timestamp('03-02-2023 05:34:51.519530', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 05:34:54.538263', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 05:36:10.566410', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (23, 1, 'Simulation is Complete', to_timestamp('03-02-2023 16:18:52.964784', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:18:56.027483', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:20:11.861074', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (22, 1, 'Simulation is Complete', to_timestamp('03-02-2023 16:25:48.166373', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:25:51.186944', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:27:07.088984', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (26, 1, 'Will start shortly...', to_timestamp('03-02-2023 16:28:13.600527', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:13.604579', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:13.604579', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (26, 2, 'Sleep index: 1 for DC 200', to_timestamp('03-02-2023 16:28:13.605243', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:13.605243', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:16.656876', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (26, 3, 'Sleep index: 2 for DC 200', to_timestamp('03-02-2023 16:28:16.657051', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:16.657051', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:22.929831', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (26, 4, 'Sleep index: 3 for DC 200', to_timestamp('03-02-2023 16:28:22.929954', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:22.929954', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:32.145812', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (26, 5, 'Sleep index: 4 for DC 200', to_timestamp('03-02-2023 16:28:32.145984', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:32.145984', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:44.435015', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (26, 6, 'Sleep index: 5 for DC 200', to_timestamp('03-02-2023 16:28:44.435148', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:44.435148', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:59.793024', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (26, 7, 'Simulation 1 is  Complete', to_timestamp('03-02-2023 16:28:59.794200', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:59.794200', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:59.794200', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into EM.EVENT_LOGS (queue_id, lap_id, message, create_ts, begin_ts, end_ts, finish_cd)
values (27, 1, 'Simulation is Complete', to_timestamp('03-02-2023 16:28:59.797254', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:28:59.797533', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('03-02-2023 16:30:15.504921', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
commit;
prompt 30 records loaded
prompt Loading EM.EVENT_PARAMETERS...
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (1, 1, 'i_dc_id', 1, null, null, 'asrajag', to_date('02-02-2023 10:02:13', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (1, 2, 'i_queue_id', 1, null, null, 'asrajag', to_date('02-02-2023 10:02:28', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (2, 1, 'i_dc_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (2, 2, 'i_queue_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (3, 1, 'i_dc_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (3, 2, 'i_queue_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (4, 1, 'i_dc_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (4, 2, 'i_string', 2, '20', null, 'asrajag', to_date('03-02-2023 05:23:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (4, 3, 'i_queue_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (5, 1, 'i_queue_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (5, 2, 'i_dc_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (6, 1, 'i_dc_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (6, 2, 'i_date', 3, null, null, 'asrajag', to_date('03-02-2023 05:23:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (6, 3, 'i_queue_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (7, 1, 'i_dc_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (7, 2, 'i_queue_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (8, 1, 'i_dc_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (8, 2, 'i_queue_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (9, 1, 'i_dc_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (9, 2, 'i_queue_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (10, 1, 'i_queue_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (10, 2, 'i_dc_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (11, 1, 'i_dc_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (11, 2, 'i_queue_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:23:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (12, 1, 'i_dc_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:24:57', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_PARAMETERS (event_definition_id, sequence, parameter_name, data_type_id, parameter_size, parameter_type, user_id, last_change_date)
values (12, 2, 'i_queue_id', 1, null, null, 'asrajag', to_date('03-02-2023 05:24:57', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 26 records loaded
prompt Loading EM.EVENT_QUEUE_STATUS...
insert into EM.EVENT_QUEUE_STATUS (id, description, user_id, last_change_date)
values (1, 'New', 'asrajag', to_date('01-12-2022 07:21:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_QUEUE_STATUS (id, description, user_id, last_change_date)
values (2, 'Locked', 'asrajag', to_date('01-12-2022 07:21:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_QUEUE_STATUS (id, description, user_id, last_change_date)
values (3, 'Released', 'asrajag', to_date('01-12-2022 07:21:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_QUEUE_STATUS (id, description, user_id, last_change_date)
values (4, 'Cancelled', 'asrajag', to_date('01-12-2022 07:21:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_QUEUE_STATUS (id, description, user_id, last_change_date)
values (5, 'Failed', 'asrajag', to_date('01-12-2022 07:21:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.EVENT_QUEUE_STATUS (id, description, user_id, last_change_date)
values (6, 'Completed', 'asrajag', to_date('01-12-2022 07:21:48', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 6 records loaded
prompt Loading EM.EVENT_RESTRICTIONS...
prompt Table is empty
prompt Loading EM.GROUP_EVENTS...
insert into EM.GROUP_EVENTS (group_id, event_definition_id, sequence, user_id, last_change_date)
values (3, 2, 1, 'asrajag', to_date('03-02-2023 06:29:14', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.GROUP_EVENTS (group_id, event_definition_id, sequence, user_id, last_change_date)
values (3, 1, 2, 'asrajag', to_date('03-02-2023 06:29:14', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.GROUP_EVENTS (group_id, event_definition_id, sequence, user_id, last_change_date)
values (1, 1, 1, 'asrajag', to_date('02-02-2023 09:36:19', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.GROUP_EVENTS (group_id, event_definition_id, sequence, user_id, last_change_date)
values (2, 2, 1, 'asrajag', to_date('03-02-2023 05:42:40', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 4 records loaded
prompt Loading EM.GROUP_EVENT_RESTRICTIONS...
prompt Table is empty
prompt Loading EM.GROUP_RESTRICTIONS...
prompt Table is empty
prompt Loading EM.HELPER_SQL_EXECUTION_POINTS...
insert into EM.HELPER_SQL_EXECUTION_POINTS (id, description, user_id, last_change_date)
values (1, 'NA', 'asrajag', to_date('01-12-2022 09:42:27', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.HELPER_SQL_EXECUTION_POINTS (id, description, user_id, last_change_date)
values (2, 'BEGIN', 'asrajag', to_date('01-12-2022 09:42:27', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.HELPER_SQL_EXECUTION_POINTS (id, description, user_id, last_change_date)
values (3, 'END', 'asrajag', to_date('01-12-2022 09:42:27', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 3 records loaded
prompt Loading EM.HELPER_SQL_TYPES...
insert into EM.HELPER_SQL_TYPES (id, description, user_id, last_change_date)
values (1, 'GENERICS', 'asrajag', to_date('01-12-2022 09:40:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.HELPER_SQL_TYPES (id, description, user_id, last_change_date)
values (2, 'GROUP', 'asrajag', to_date('01-12-2022 09:40:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.HELPER_SQL_TYPES (id, description, user_id, last_change_date)
values (3, 'EVENT', 'asrajag', to_date('01-12-2022 09:40:48', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 3 records loaded
prompt Loading EM.HELPER_SQL_HEADERS...
insert into EM.HELPER_SQL_HEADERS (id, type, execution_point_id, reference_id, sub_reference_id, user_id, last_change_date)
values (1, 1, 1, 22, null, 'asrajag', to_date('01-12-2022 09:48:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.HELPER_SQL_HEADERS (id, type, execution_point_id, reference_id, sub_reference_id, user_id, last_change_date)
values (2, 1, 1, 23, null, 'asrajag', to_date('01-12-2022 09:48:19', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.HELPER_SQL_HEADERS (id, type, execution_point_id, reference_id, sub_reference_id, user_id, last_change_date)
values (3, 1, 1, 24, null, 'asrajag', to_date('01-12-2022 09:55:13', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.HELPER_SQL_HEADERS (id, type, execution_point_id, reference_id, sub_reference_id, user_id, last_change_date)
values (4, 3, 2, -1000, null, 'asrajag', to_date('02-02-2023 13:02:46', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.HELPER_SQL_HEADERS (id, type, execution_point_id, reference_id, sub_reference_id, user_id, last_change_date)
values (9, 3, 3, -1000, null, 'asrajag', to_date('02-02-2023 17:10:31', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.HELPER_SQL_HEADERS (id, type, execution_point_id, reference_id, sub_reference_id, user_id, last_change_date)
values (5, 2, 2, 1, null, 'asrajag', to_date('02-02-2023 17:03:18', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.HELPER_SQL_HEADERS (id, type, execution_point_id, reference_id, sub_reference_id, user_id, last_change_date)
values (6, 3, 2, 1, 1, 'asrajag', to_date('02-02-2023 17:03:18', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.HELPER_SQL_HEADERS (id, type, execution_point_id, reference_id, sub_reference_id, user_id, last_change_date)
values (7, 3, 3, 1, 1, 'asrajag', to_date('02-02-2023 17:03:19', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.HELPER_SQL_HEADERS (id, type, execution_point_id, reference_id, sub_reference_id, user_id, last_change_date)
values (8, 2, 3, 1, null, 'asrajag', to_date('02-02-2023 17:03:19', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 9 records loaded
prompt Loading EM.INTERVAL_MEASURES...
insert into EM.INTERVAL_MEASURES (id, symbol, description, user_id, last_change_date)
values (1, 'SECOND', 'Second', 'asrajag', to_date('30-11-2022 21:20:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.INTERVAL_MEASURES (id, symbol, description, user_id, last_change_date)
values (2, 'MINUTE', 'Minute', 'asrajag', to_date('30-11-2022 21:20:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.INTERVAL_MEASURES (id, symbol, description, user_id, last_change_date)
values (3, 'HOUR', 'Hour', 'asrajag', to_date('30-11-2022 21:20:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.INTERVAL_MEASURES (id, symbol, description, user_id, last_change_date)
values (4, 'DAY', 'Day', 'asrajag', to_date('30-11-2022 21:20:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.INTERVAL_MEASURES (id, symbol, description, user_id, last_change_date)
values (5, 'WEEK', 'Week', 'asrajag', to_date('30-11-2022 21:20:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.INTERVAL_MEASURES (id, symbol, description, user_id, last_change_date)
values (6, 'MONTH', 'Month', 'asrajag', to_date('30-11-2022 21:20:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.INTERVAL_MEASURES (id, symbol, description, user_id, last_change_date)
values (7, 'YEAR', 'Year', 'asrajag', to_date('30-11-2022 21:20:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.INTERVAL_MEASURES (id, symbol, description, user_id, last_change_date)
values (8, 'DECADE', 'Decade', 'asrajag', to_date('30-11-2022 21:20:49', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 8 records loaded
prompt Loading EM.INTERVAL_CONVERSIONS...
insert into EM.INTERVAL_CONVERSIONS (unit, measure_id, converted_unit, converted_measure_id, user_id, last_change_date)
values (1, 2, 60, 1, 'asrajag', to_date('30-11-2022 21:23:15', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.INTERVAL_CONVERSIONS (unit, measure_id, converted_unit, converted_measure_id, user_id, last_change_date)
values (1, 3, 60, 2, 'asrajag', to_date('30-11-2022 21:23:15', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.INTERVAL_CONVERSIONS (unit, measure_id, converted_unit, converted_measure_id, user_id, last_change_date)
values (1, 4, 24, 3, 'asrajag', to_date('30-11-2022 21:23:15', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.INTERVAL_CONVERSIONS (unit, measure_id, converted_unit, converted_measure_id, user_id, last_change_date)
values (1, 5, 7, 4, 'asrajag', to_date('30-11-2022 21:23:15', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.INTERVAL_CONVERSIONS (unit, measure_id, converted_unit, converted_measure_id, user_id, last_change_date)
values (1, 7, 12, 6, 'asrajag', to_date('30-11-2022 21:23:15', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.INTERVAL_CONVERSIONS (unit, measure_id, converted_unit, converted_measure_id, user_id, last_change_date)
values (1, 8, 10, 7, 'asrajag', to_date('30-11-2022 21:23:15', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 6 records loaded
prompt Loading EM.MONTHS_IN_A_YEAR...
insert into EM.MONTHS_IN_A_YEAR (id, code, description, user_id, last_change_date)
values (1, 'JAN', 'January', 'asrajag', to_date('30-11-2022 20:45:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.MONTHS_IN_A_YEAR (id, code, description, user_id, last_change_date)
values (2, 'FEB', 'February', 'asrajag', to_date('30-11-2022 20:45:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.MONTHS_IN_A_YEAR (id, code, description, user_id, last_change_date)
values (3, 'MAR', 'March', 'asrajag', to_date('30-11-2022 20:45:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.MONTHS_IN_A_YEAR (id, code, description, user_id, last_change_date)
values (4, 'APR', 'April', 'asrajag', to_date('30-11-2022 20:45:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.MONTHS_IN_A_YEAR (id, code, description, user_id, last_change_date)
values (5, 'MAY', 'May', 'asrajag', to_date('30-11-2022 20:45:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.MONTHS_IN_A_YEAR (id, code, description, user_id, last_change_date)
values (6, 'JUN', 'June', 'asrajag', to_date('30-11-2022 20:45:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.MONTHS_IN_A_YEAR (id, code, description, user_id, last_change_date)
values (7, 'JUL', 'July', 'asrajag', to_date('30-11-2022 20:45:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.MONTHS_IN_A_YEAR (id, code, description, user_id, last_change_date)
values (8, 'AUG', 'August', 'asrajag', to_date('30-11-2022 20:45:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.MONTHS_IN_A_YEAR (id, code, description, user_id, last_change_date)
values (9, 'SEP', 'September', 'asrajag', to_date('30-11-2022 20:45:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.MONTHS_IN_A_YEAR (id, code, description, user_id, last_change_date)
values (10, 'OCT', 'October', 'asrajag', to_date('30-11-2022 20:45:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.MONTHS_IN_A_YEAR (id, code, description, user_id, last_change_date)
values (11, 'NOV', 'November', 'asrajag', to_date('30-11-2022 20:45:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.MONTHS_IN_A_YEAR (id, code, description, user_id, last_change_date)
values (12, 'DEC', 'December', 'asrajag', to_date('30-11-2022 20:45:05', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 12 records loaded
prompt Loading EM.ORGANIZATION_TYPES...
insert into EM.ORGANIZATION_TYPES (id, code, description, user_id, last_change_date)
values (1, 'CMP', 'Company', 'asrajag', to_date('29-11-2022 16:42:24', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATION_TYPES (id, code, description, user_id, last_change_date)
values (2, 'SUBCMP', 'Sub-Company', 'asrajag', to_date('29-11-2022 16:42:24', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATION_TYPES (id, code, description, user_id, last_change_date)
values (3, 'WHS', 'Warehouse', 'asrajag', to_date('29-11-2022 16:42:24', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 3 records loaded
prompt Loading EM.ORGANIZATIONS...
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (1, 1, 'MCL', 'MCL', 'McLane Company Inc.', null, 'asrajag', to_date('29-11-2022 16:55:03', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (2, 2, 'FS', 'FS', 'Food Service', 1, 'asrajag', to_date('29-11-2022 16:55:03', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (3, 2, 'GRO', 'GRO', 'Grocery', 1, 'asrajag', to_date('29-11-2022 16:55:03', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (4, 3, '100', 'SW', 'SOUTHWEST', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (5, 3, '150', 'SO', 'SOUTHERN', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (6, 3, '160', 'MD', 'DOTHAN', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (7, 3, '200', 'MW', 'WESTERN', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (8, 3, '250', 'ME', 'SUNEAST', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (9, 3, '260', 'MY', 'NE/CONCORD', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (10, 3, '270', 'PA', 'MCLANE PA', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (11, 3, '280', 'NT', 'NORTH TEXAS', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (12, 3, '290', 'FE', 'MCLANE OCALA', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (13, 3, '300', 'NW', 'NORTHWEST', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (14, 3, '350', 'MI', 'MIDWEST', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (15, 3, '360', 'MK', 'CUMBERLAND', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (16, 3, '370', 'MO', 'MCLANE OZARK', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (17, 3, '400', 'SE', 'SOUTHEAST', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (18, 3, '450', 'MZ', 'MID-ATLANTIC', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (19, 3, '460', 'MN', 'MINNESOTA', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (20, 3, '470', 'MG', 'MCLANE OHIO', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (21, 3, '500', 'MP', 'PACIFIC', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (22, 3, '550', 'SZ', 'SO. CALIF.', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (23, 3, '600', 'HP', 'HIGH PLAINS', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (24, 3, '710', 'WJ', 'NEW JERSEY', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (25, 3, '800', 'NE', 'NORTHEAST', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (26, 3, '850', 'MS', 'SUNWEST', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (27, 3, '951', 'GM', 'MCLANE INTERSTATE WAREHOUSE', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (28, 3, '988', 'NC', 'CAROLINA', 3, 'asrajag', to_date('02-02-2023 09:46:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (29, 3, '101', 'PO', 'PORTLAND 101', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (30, 3, '102', 'SC', 'TRACY 102', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (31, 3, '103', 'ON', 'RIVERSIDE 103', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (32, 3, '112', 'PH', 'PHOENIX 112', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (33, 3, '121', 'AU', 'DENVER 121', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (34, 3, '128', 'SA', 'SAN ANTONIO 128', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (35, 3, '129', 'HO', 'HOUSTON 129', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (36, 3, '132', 'SH', 'SHAWNEE 132', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (37, 3, '135', 'AL', 'ARLINGTON 135', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (38, 3, '141', 'ST', 'MILWAUKEE 141', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (39, 3, '142', 'MH', 'MEMPHIS 142', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (40, 3, '149', 'PL', 'PLYMOUTH 149', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (41, 3, '153', 'HE', 'CINCINNATI 153', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (42, 3, '159', 'BU', 'BURLINGTON 159', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (43, 3, '161', 'GU', 'ALBANY 161', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (44, 3, '162', 'MR', 'MANASSAS 162', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (45, 3, '164', 'CE', 'CHARLOTTE 164', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (46, 3, '166', 'FO', 'ATLANTA 166', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (47, 3, '170', 'OR', 'ORLANDO 170', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (48, 3, '601', '01', 'ROCKY MOUNT 601', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (49, 3, '602', '02', 'OKLAHOMA CITY 602', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (50, 3, '604', '04', 'RIVERSIDE 604', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (51, 3, '605', '05', 'COLUMBUS 605', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (52, 3, '606', '06', 'LAKELAND 606', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (53, 3, '607', '07', 'ROCKY MOUNT 607', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (54, 3, '608', '08', 'LEWISVILLE 608', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (55, 3, '609', '09', 'ORLANDO 609', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (56, 3, '613', '13', 'LAGRANGE 613', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (57, 3, '614', '14', 'ELKHORN 614', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (58, 3, '615', '15', 'SALISBURY 615', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (59, 3, '616', '16', 'TAYLORVILLE 616', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (60, 3, '619', '19', 'MASON CITY 619', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (61, 3, '620', '20', 'MACON 620', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (62, 3, '621', '21', 'AURORA 621', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (63, 3, '623', '23', 'FRANKFORT 623', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (64, 3, '627', '27', 'ABERDEEN 627', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (65, 3, '630', '30', 'ONTARIO 630', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (66, 3, '631', '31', 'MANTECA 631', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (67, 3, '632', '32', 'BUENA PARK 632', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (68, 3, '633', '33', 'TRACY 633', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (69, 3, '635', '35', 'DALLAS 635', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (70, 3, '636', '36', 'MERCED 636', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (71, 3, '637', '37', 'AUSTELL 637', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (72, 3, '652', '52', 'PLEASANTON 652', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (73, 3, '655', '55', 'ORLANDO 655', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (74, 3, '657', '57', 'SUMNER 657', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (75, 3, '659', '59', 'LANCASTER 659', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (76, 3, '661', '61', 'RANCHO CUCAMONGA 661', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (77, 3, '663', '63', 'FORT WORTH 663', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (78, 3, '671', '71', 'CORDELE 671', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (79, 3, '672', '72', 'ROCKY MOUNT 672', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (80, 3, '674', '74', 'RIVERSIDE SYC 674', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (81, 3, '675', '75', 'LOCKBOURNE 675', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (82, 3, '676', '76', 'HAINES CITY 676', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (83, 3, '678', '78', 'NEWNAN 678', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.ORGANIZATIONS (id, type, code, short_nm, name, parent_id, user_id, last_change_date)
values (84, 3, '957', 'T3', '3PL TEMPLE', 2, 'asrajag', to_date('02-02-2023 09:49:41', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 84 records loaded
prompt Loading EM.SUB_CYCLE_ADD...
insert into EM.SUB_CYCLE_ADD (cycle_id, interval_id, units, user_id, last_change_date)
values (2, 4, 1, 'asrajag', to_date('01-12-2022 08:35:19', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_ADD (cycle_id, interval_id, units, user_id, last_change_date)
values (5, 5, 1, 'asrajag', to_date('01-12-2022 08:38:19', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_ADD (cycle_id, interval_id, units, user_id, last_change_date)
values (6, 6, 1, 'asrajag', to_date('01-12-2022 08:38:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_ADD (cycle_id, interval_id, units, user_id, last_change_date)
values (7, 6, 3, 'asrajag', to_date('01-12-2022 08:39:18', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_ADD (cycle_id, interval_id, units, user_id, last_change_date)
values (8, 6, 6, 'asrajag', to_date('01-12-2022 08:45:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_ADD (cycle_id, interval_id, units, user_id, last_change_date)
values (9, 7, 1, 'asrajag', to_date('01-12-2022 08:45:52', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_ADD (cycle_id, interval_id, units, user_id, last_change_date)
values (10, 6, .5, 'asrajag', to_date('01-12-2022 09:01:09', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_ADD (cycle_id, interval_id, units, user_id, last_change_date)
values (11, 6, 2, 'asrajag', to_date('01-12-2022 09:01:24', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_ADD (cycle_id, interval_id, units, user_id, last_change_date)
values (12, 2, 5, 'asrajag', to_date('01-12-2022 09:03:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_ADD (cycle_id, interval_id, units, user_id, last_change_date)
values (13, 2, 30, 'asrajag', to_date('01-12-2022 09:03:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_ADD (cycle_id, interval_id, units, user_id, last_change_date)
values (14, 3, 1, 'asrajag', to_date('01-12-2022 09:03:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_ADD (cycle_id, interval_id, units, user_id, last_change_date)
values (15, 3, 2, 'asrajag', to_date('01-12-2022 09:03:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_ADD (cycle_id, interval_id, units, user_id, last_change_date)
values (16, 3, 6, 'asrajag', to_date('01-12-2022 09:03:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_ADD (cycle_id, interval_id, units, user_id, last_change_date)
values (17, 3, 12, 'asrajag', to_date('01-12-2022 09:03:41', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 14 records loaded
prompt Loading EM.SUB_CYCLE_DAYS_OF_THE_WEEK...
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (3, 2, 'asrajag', to_date('01-12-2022 08:37:16', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (3, 3, 'asrajag', to_date('01-12-2022 08:37:16', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (3, 4, 'asrajag', to_date('01-12-2022 08:37:16', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (3, 5, 'asrajag', to_date('01-12-2022 08:37:16', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (3, 6, 'asrajag', to_date('01-12-2022 08:37:16', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (4, 1, 'asrajag', to_date('01-12-2022 08:37:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (4, 7, 'asrajag', to_date('01-12-2022 08:37:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (18, 2, 'asrajag', to_date('01-12-2022 09:17:10', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (18, 4, 'asrajag', to_date('01-12-2022 09:17:10', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (18, 6, 'asrajag', to_date('01-12-2022 09:17:10', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (19, 3, 'asrajag', to_date('01-12-2022 09:17:10', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (19, 5, 'asrajag', to_date('01-12-2022 09:17:10', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (20, 1, 'asrajag', to_date('01-12-2022 09:18:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (20, 3, 'asrajag', to_date('01-12-2022 09:18:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (20, 6, 'asrajag', to_date('01-12-2022 09:18:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (21, 2, 'asrajag', to_date('01-12-2022 09:18:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (21, 4, 'asrajag', to_date('01-12-2022 09:18:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (21, 5, 'asrajag', to_date('01-12-2022 09:18:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_DAYS_OF_THE_WEEK (cycle_id, day_id, user_id, last_change_date)
values (21, 7, 'asrajag', to_date('01-12-2022 09:18:50', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 19 records loaded
prompt Loading EM.SUB_CYCLE_GENERICS...
insert into EM.SUB_CYCLE_GENERICS (cycle_id, measure_code, units, user_id, last_change_date)
values (22, 'MONTH', 1, 'asrajag', to_date('01-12-2022 09:53:58', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_GENERICS (cycle_id, measure_code, units, user_id, last_change_date)
values (23, 'MONTH', -1, 'asrajag', to_date('01-12-2022 09:53:58', 'dd-mm-yyyy hh24:mi:ss'));
insert into EM.SUB_CYCLE_GENERICS (cycle_id, measure_code, units, user_id, last_change_date)
values (24, 'MONTH', .5, 'asrajag', to_date('01-12-2022 09:54:38', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 3 records loaded
prompt Loading EM.SUB_CYCLE_MONTHS...
prompt Table is empty
prompt Loading EM.SUB_CYCLE_TIME_IN_A_DAY...
prompt Table is empty
prompt Loading EM.SUB_CYCLE_WEEKS_IN_A_MONTH...
prompt Table is empty
prompt Loading EM.SUB_CYCLE_WEEKS_IN_A_YEAR...
prompt Table is empty

set feedback on
set define on
prompt Done
