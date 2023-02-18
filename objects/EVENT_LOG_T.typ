CREATE OR REPLACE TYPE EM_CODE.EVENT_LOG_T AS
OBJECT(queue_id          number(38),
       lap_id            number(4),
       application       varchar2(200),
       group_description varchar2(50),
       event             varchar2(80),
       organization_id   number(5),
       organization      varchar2(40),
       message           varchar2(512),
       create_ts         timestamp(6),
       begin_ts          timestamp(6),
       end_ts            timestamp(6),
       finish_cd         number(1),
       status_id         number(3),
       status            varchar2(40)
      );
/
