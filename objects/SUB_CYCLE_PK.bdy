CREATE OR REPLACE PACKAGE BODY EM_CODE.SUB_CYCLE_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : SUB_CYCLE_PK
|| CREATED BY          : Arun S. Rajagopalan
|| CREATE DATE         : Feb, 07th 2023
|| DESCRIPTION         : To maintain cycles
||---------------------------------------------------------------------------------
|| CHANGELOG
||---------------------------------------------------------------------------------
|| DATE        USER ID     CHANGES
||---------------------------------------------------------------------------------
||
||---------------------------------------------------------------------------------
||
*/
is

   procedure get_add
   (
      i_cycle_id em.cycles.id%type,
      o_unit     out em.sub_cycle_add.units%type,
      o_term     out em.interval_measures.symbol%type
   )
   /*
   ||----------------------------------------------------------------------------
   || get
   ||   Get the units and terms that is needed to be added
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/07 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is

   begin

      select nvl(converted_unit, units) units, nvl(v.symbol, m.symbol) symbol
      into   o_unit, o_term
      from   em.sub_cycle_add       u
      join   em.interval_measures   m
      on     m.id = u.interval_id
      left outer join
             em.interval_conversions c
      on     c.measure_id = m.id
      left outer join
             em.interval_measures    v
      on     v.id = c.converted_measure_id
      where  u.cycle_id = i_cycle_id;

   exception
      when others then
         o_unit := null;
         o_term := null;

   end get_add;

   function get_day_of_the_year
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return TYPE_PK.rt_date
   /*
   ||----------------------------------------------------------------------------
   || get_day_of_the_year
   ||   day of the year
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/17 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_next_cycle TYPE_PK.rt_date;
   begin
      with
         input_date as
            (select to_char(i_date, 'DDD') day_id
             from   dual
            ),
         year_begin as
            (select trunc(i_date, 'YYYY') current_year, trunc(i_date, 'YYYY') + interval '1' year next_year
             from   dual
            ),
         sub_cycles as
            (select y.day_id, nvl(lead(y.day_id) over(partition by y.cycle_id order by y.day_id), min(y.day_id) over(partition by y.cycle_id)) lg_day_id,
                    min(y.day_id) over(partition by y.cycle_id) min_day_id, max(y.day_id) over(partition by y.cycle_id) max_day_id, count(1) over(partition by y.cycle_id) cnt_days
             from   em.sub_cycle_days_in_an_year y
             where  y.cycle_id = i_cycle_id
            )
         select (case
                    when cnt_days = 1
                    then
                       case
                          when c.day_id > i.day_id
                          then
                             (current_year - 1) + c.day_id
                          else
                             (next_year - 1) + c.day_id
                       end
                    else
                       case
                          when (    i.day_id >= c.day_id
                                and i.day_id < c.lg_day_id
                               )
                          then
                             (current_year - 1) + c.lg_day_id
                          when (    i.day_id < c.min_day_id
                                and c.day_id = c.min_day_id
                               )
                          then
                             (current_year - 1) + c.min_day_id
                          when (    i.day_id >= c.max_day_id
                                and c.lg_day_id < c.day_id
                               )
                          then
                             (next_year - 1) + c.min_day_id
                       end
                 end
                ) next_date,
                (case
                    when cnt_days = 1
                    then
                       c.day_id
                    else
                       case
                          when (    i.day_id >= c.day_id
                                and i.day_id < c.lg_day_id
                               )
                          then
                             c.lg_day_id
                          else
                             c.min_day_id
                       end
                 end
                ) day_id
         into   l_next_cycle.approximate_date, l_next_cycle.id
         from   sub_cycles c
         join   input_date i
         on     1 = 1
         join   year_begin b
         on     1 = 1
         where  cnt_days = 1
         or     (    i.day_id >= c.day_id
                 and i.day_id < c.lg_day_id
                )
         or     (    i.day_id < c.min_day_id
                 and c.day_id = c.min_day_id
                )
         or     (    i.day_id >= c.max_day_id
                 and c.lg_day_id < c.day_id
                );

      return l_next_cycle;
   exception
      when others then
         return null;

   end get_day_of_the_year;

   function get_week_of_the_year
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return TYPE_PK.rt_date
   /*
   ||----------------------------------------------------------------------------
   || get_week_of_the_year
   ||   week of the year
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/17 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_next_cycle TYPE_PK.rt_date;
   begin
      with
         input_date as
            (select to_char(i_date, 'WW') week_id
             from   dual
            ),
         year_begin as
            (select trunc(i_date, 'YYYY') current_year, trunc(i_date, 'YYYY') + interval '1' year next_year
             from   dual
            ),
         sub_cycles as
            (select y.week_id, nvl(lead(y.week_id) over(partition by y.cycle_id order by y.week_id), min(y.week_id) over(partition by y.cycle_id)) lg_week_id,
                    min(y.week_id) over(partition by y.cycle_id) min_week_id, max(y.week_id) over(partition by y.cycle_id) max_week_id, count(1) over(partition by y.cycle_id) cnt_weeks
             from   em.sub_cycle_weeks_in_a_year y
             where  y.cycle_id = i_cycle_id
            )
         select (case
                    when cnt_weeks = 1
                    then
                       case
                          when c.week_id > i.week_id
                          then
                             (current_year - 1) + ((c.week_id - 1) * 7)
                          else
                             (next_year - 1) + ((c.week_id - 1) * 7)
                       end
                    else
                       case
                          when (    i.week_id >= c.week_id
                                and i.week_id < c.lg_week_id
                               )
                          then
                             (current_year - 1) + ((c.lg_week_id - 1) * 7)
                          when (    i.week_id < c.min_week_id
                                and c.week_id = c.min_week_id
                               )
                          then
                             (current_year - 1) + ((c.min_week_id - 1) * 7)
                          when (    i.week_id >= c.max_week_id
                                and c.lg_week_id < c.week_id
                               )
                          then
                             (next_year - 1) + ((c.min_week_id - 1) * 7)
                       end
                 end
                ) next_date,
                (case
                    when cnt_weeks = 1
                    then
                       c.week_id
                    else
                       case
                          when (    i.week_id >= c.week_id
                                and i.week_id < c.lg_week_id
                               )
                          then
                             c.lg_week_id
                          else
                             c.min_week_id
                       end
                 end
                ) week_id
         into   l_next_cycle.approximate_date, l_next_cycle.id
         from   sub_cycles c
         join   input_date i
         on     1 = 1
         join   year_begin b
         on     1 = 1
         where  cnt_weeks = 1
         or     (    i.week_id >= c.week_id
                 and i.week_id < c.lg_week_id
                )
         or     (    i.week_id < c.min_week_id
                 and c.week_id = c.min_week_id
                )
         or     (    i.week_id >= c.max_week_id
                 and c.lg_week_id < c.week_id
                );

      return l_next_cycle;
   exception
      when others then
         return null;

   end get_week_of_the_year;

   function get_month_of_the_year
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return TYPE_PK.rt_date
   /*
   ||----------------------------------------------------------------------------
   || get_month_of_the_year
   ||   month of the year
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/17 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_next_cycle TYPE_PK.rt_date;
   begin
      with
         input_date as
            (select to_char(i_date, 'MM') month_id, trunc(i_date, 'MM') dt
             from   dual
            ),
         year_begin as
            (select trunc(i_date, 'YYYY') + interval '1' year next_year
             from   dual
            ),
         sub_cycles as
            (select y.month_id, nvl(lead(y.month_id) over(partition by y.cycle_id order by y.month_id), min(y.month_id) over(partition by y.cycle_id)) lg_month_id,
                    min(y.month_id) over(partition by y.cycle_id) min_month_id, max(y.month_id) over(partition by y.cycle_id) max_month_id, count(1) over(partition by y.cycle_id) cnt_months
             from   em.sub_cycle_months y
             where  y.cycle_id = i_cycle_id
            )
         select (case
                    when cnt_months = 1
                    then
                       case
                          when c.month_id >= i.month_id
                          then
                             add_months(i.dt, c.lg_month_id - i.month_id)
                          else
                             add_months(next_year, c.lg_month_id - 1)
                       end
                    else
                       case
                          when i.month_id = c.month_id
                          then
                              i.dt
                          when (    i.month_id > c.month_id
                                and i.month_id < c.lg_month_id
                               )
                          then
                             add_months(i.dt, (c.lg_month_id - i.month_id))
                          when (    i.month_id >= c.max_month_id
                                and c.lg_month_id < c.month_id
                               )
                          then
                             add_months(next_year, c.lg_month_id - 1)
                          when i.month_id < c.month_id
                          and  c.month_id = min_month_id
                          then
                             add_months(i.dt, c.month_id - i.month_id)
                       end
                 end
                ) next_date,
                (case
                    when cnt_months = 1
                    then
                       c.month_id
                    else
                       case
                          when i.month_id = c.month_id
                          then
                              c.month_id
                          when (    i.month_id > c.month_id
                                and i.month_id <= c.lg_month_id
                               )
                          then
                             c.lg_month_id
                          else
                             c.min_month_id
                       end
                 end
                ) month_id
         into   l_next_cycle.approximate_date, l_next_cycle.id
         from   sub_cycles c
         join   input_date i
         on     1 = 1
         join   year_begin b
         on     1 = 1
         where  cnt_months = 1
         or     i.month_id = c.month_id
         or     (    i.month_id > c.month_id
                 and i.month_id < c.lg_month_id
                )
         or     (    i.month_id >= c.max_month_id
                 and c.lg_month_id < c.month_id
                )
         or     (    i.month_id < c.month_id
                 and c.month_id = c.min_month_id
                );

      return l_next_cycle;
   exception
      when others then
         return null;

   end get_month_of_the_year;

   function get_day_of_the_month
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return TYPE_PK.rt_date
   /*
   ||----------------------------------------------------------------------------
   || get_day_of_the_month
   ||   day of the month
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/17 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_next_cycle TYPE_PK.rt_date;
   begin
      with
         input_date as
            (select to_char(i_date, 'DD') day_id, trunc(i_date, 'MM') dt, last_day(trunc(i_date, 'MM')) next_dt
             from   dual
            ),
         year_begin as
            (select trunc(i_date, 'YYYY') + interval '1' year next_year
             from   dual
            ),
         sub_cycles as
            (select y.day_id, nvl(lead(y.day_id) over(partition by y.cycle_id order by y.day_id), min(y.day_id) over(partition by y.cycle_id)) lg_day_id,
                    min(y.day_id) over(partition by y.cycle_id) min_day_id, max(y.day_id) over(partition by y.cycle_id) max_day_id, count(1) over(partition by y.cycle_id) cnt_days
             from   em.sub_cycle_days_in_a_month y
             where  y.cycle_id = i_cycle_id
            )
         select (case
                    when cnt_days = 1
                    then
                       case
                          when c.day_id > i.day_id
                          then
                             (dt - 1) + c.day_id
                          else
                             next_dt + c.day_id
                       end
                    else
                       case
                          when (    i.day_id >= c.day_id
                                and i.day_id < c.lg_day_id
                               )
                          then
                             (dt - 1) + c.lg_day_id
                          when (    i.day_id < c.min_day_id
                                and c.day_id < c.lg_day_id
                               )
                          then
                             dt + c.min_day_id
                          when (    i.day_id >= c.max_day_id
                                and c.lg_day_id < c.day_id
                               )
                          then
                             case
                                when to_char(i_date, 'MM') = to_char((next_year - 1), 'MM')
                                then
                                   (next_year - 1) + c.min_day_id
                                else
                                   next_dt + c.lg_day_id
                             end
                       end
                 end
                ) next_date,
                (case
                    when cnt_days = 1
                    then
                       c.day_id
                    else
                       case
                          when (    i.day_id >= c.day_id
                                and i.day_id < c.lg_day_id
                               )
                          then
                             c.lg_day_id
                          else
                             c.min_day_id
                       end
                 end
                ) day_id
         into   l_next_cycle.approximate_date, l_next_cycle.id
         from   sub_cycles c
         join   input_date i
         on     1 = 1
         join   year_begin b
         on     1 = 1
         where  cnt_days = 1
         or     (    i.day_id >= c.day_id
                 and i.day_id < c.lg_day_id
                )
         or     (    i.day_id < c.min_day_id
                 and c.day_id < c.lg_day_id
                )
         or     (    i.day_id >= c.max_day_id
                 and c.lg_day_id < c.day_id
                );

      return l_next_cycle;
   exception
      when others then
         return null;

   end get_day_of_the_month;

   function get_week_of_the_month
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return TYPE_PK.rt_date
   /*
   ||----------------------------------------------------------------------------
   || get_week_of_the_month
   ||   week of the month
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/17 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_next_cycle TYPE_PK.rt_date;
   begin
      with
         input_date as
            (select to_char(i_date, 'W') week_id, trunc(i_date, 'MM') dt
             from   dual
            ),
         year_begin as
            (select trunc(i_date, 'YYYY') + interval '1' year next_year
             from   dual
            ),
         sub_cycles as
            (select y.week_id, nvl(lead(y.week_id) over(partition by y.cycle_id order by y.week_id), min(y.week_id) over(partition by y.cycle_id)) lg_week_id,
                    min(y.week_id) over(partition by y.cycle_id) min_week_id, max(y.week_id) over(partition by y.cycle_id) max_week_id, count(1) over(partition by y.cycle_id) cnt_weeks
             from   em.sub_cycle_weeks_in_a_month y
             where  y.cycle_id = i_cycle_id
            )
         select (case
                    when cnt_weeks = 1
                    then
                       case
                          when c.week_id > i.week_id
                          then
                             dt + ((c.week_id - 1) * 7)
                          when c.week_id <= i.week_id
                          then
                             case
                                when to_char(dt, 'MM') = to_char((next_year - 1), 'MM')
                                then
                                   case
                                      when c.week_id = i.week_id
                                      then
                                         dt + ((c.week_id - 1) * 7)
                                      else
                                         next_year + ((c.week_id - 1) * 7)
                                   end
                                when c.week_id < i.week_id
                                then
                                   add_months(dt, 1) + ((c.week_id - 1) * 7)
                                else
                                   dt + ((c.week_id - 1) * 7)
                             end
                       end
                    else
                       case
                          when (    i.week_id > c.week_id
                                and i.week_id <= c.lg_week_id
                               )
                          then
                             dt + ((c.lg_week_id - 1) * 7)
                          when (    i.week_id <= c.min_week_id
                                and c.week_id <= c.lg_week_id
                               )
                          then
                             dt + ((c.min_week_id - 1) * 7)
                          when (    i.week_id > c.max_week_id
                                and c.lg_week_id < c.week_id
                               )
                          then
                             case
                                when to_char(dt, 'MM') = to_char((next_year - 1), 'MM')
                                then
                                   next_year + ((c.min_week_id - 1) * 7)
                                else
                                   add_months(dt, 1) + ((c.min_week_id - 1) * 7)
                             end
                       end
                 end
                ) next_date,
                c.week_id
         into   l_next_cycle.approximate_date, l_next_cycle.id
         from   sub_cycles c
         join   input_date i
         on     1 = 1
         join   year_begin b
         on     1 = 1
         where  cnt_weeks = 1
         or     (    i.week_id > c.week_id
                 and i.week_id <= c.lg_week_id
                )
         or     (    i.week_id <= c.min_week_id
                 and c.week_id <= c.lg_week_id
                )
         or     (    i.week_id > c.max_week_id
                 and c.lg_week_id < c.week_id
                );

      return l_next_cycle;
   exception
      when others then
         return null;

   end get_week_of_the_month;

   function get_day_of_the_week
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return TYPE_PK.rt_date
   /*
   ||----------------------------------------------------------------------------
   || get_day_of_the_week
   ||   day of the week
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/17 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_next_cycle TYPE_PK.rt_date;
   begin
      select min(next_day(i_date, c.day_id)), to_char(min(next_day(i_date, c.day_id)), 'D') day_id, to_char(min(next_day(i_date, c.day_id)), 'DY') day_desc
      into   l_next_cycle.approximate_date, l_next_cycle.id, l_next_cycle.description
      from   em.sub_cycle_days_of_the_week c
      where  c.cycle_id = i_cycle_id;

      return l_next_cycle;
   exception
      when others then
         return null;

   end get_day_of_the_week;

   function get_time_of_the_day
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return em.sub_cycle_time_in_a_day.database_time%type
   /*
   ||----------------------------------------------------------------------------
   || get_time_of_the_day
   ||   time of the day
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/17 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   is
      l_next_time em.sub_cycle_time_in_a_day.database_time%type;
   begin
      with
         input_date as
            (select to_char(i_date, 'HH24:MI') database_time
             from   dual
            ),
         sub_cycles as
            (select y.database_time, nvl(lead(y.database_time) over(partition by y.cycle_id order by y.database_time), min(y.database_time) over(partition by y.cycle_id)) lg_database_time,
                    min(y.database_time) over(partition by y.cycle_id) min_database_time, max(y.database_time) over(partition by y.cycle_id) max_database_time, count(1) over(partition by y.cycle_id) cnt_db_time
             from   em.sub_cycle_time_in_a_day y
             where  y.cycle_id = i_cycle_id
            )
         select (case
                    when cnt_db_time = 1
                    then
                       c.database_time
                    else
                       case
                          when (    i.database_time >= c.database_time
                                and i.database_time < c.lg_database_time
                                and c.database_time < c.lg_database_time
                               )
                          then
                             c.lg_database_time
                          when (    c.database_time > c.lg_database_time
                                and i.database_time >= c.max_database_time
                               )
                          then
                             c.min_database_time
                          else
                             c.database_time
                       end
                 end
                ) next_time
         into   l_next_time
         from   sub_cycles c
         join   input_date i
         on     1 = 1
         where  cnt_db_time = 1
         or     i.database_time = c.database_time
         or     (    i.database_time >= c.database_time
                 and i.database_time < c.lg_database_time
                 and c.database_time < c.lg_database_time
                )
         or     (    c.database_time > c.lg_database_time
                 and i.database_time >= c.max_database_time
                )
         or     (    i.database_time < c.database_time
                 and c.database_time = c.min_database_time
                );

      return l_next_time;
   exception
      when others then
         return null;

   end get_time_of_the_day;

end SUB_CYCLE_PK;
/
