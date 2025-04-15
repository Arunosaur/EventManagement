create or replace package body em_code.CYCLE_EVALUATOR_PK
/*
||---------------------------------------------------------------------------------
|| NAME                : CYCLE_EVALUATOR_PK
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

   function sub_cycle_add
   (
      i_date     date,
      i_interval varchar2,
      i_term     varchar2
   )
   return date
   /*
   ||----------------------------------------------------------------------------
   || sub_cycle_add
   ||   Get the next cycle for add
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/07 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   as
      l_next_cycle date;
   begin
/*
      execute immediate 'select case' || chr(10) ||
                        '          when :1 + interval '''|| i_interval || ''' ' || i_term || ' > sysdate + interval ''' || i_interval  || ''' ' || i_term || chr(10) ||
                        '          then' || chr(10) ||
                        '             :1 + interval '''|| i_interval || ''' ' || i_term || chr(10) ||
                        '          else' || chr(10) ||
                        '             trunc(sysdate, ''MI'') + interval ''' || i_interval || ''' ' || i_term || chr(10) ||
                        '       end' || chr(10) ||
                        'from   dual'
      into    l_next_cycle using i_date, i_date;
*/
      execute immediate 'select ' || chr(10) ||
                        '         :1 + interval '''|| i_interval || ''' ' || i_term || chr(10) ||
                        'from   dual'
      into    l_next_cycle using i_date;

      return l_next_cycle;

   exception
      when others then
         return null;

   end sub_cycle_add;

   function sub_cycle_generic(i_cycle_id em.cycles.id%type)
   return date
   /*
   ||----------------------------------------------------------------------------
   || sub_cycle_generic
   ||   Get the generic cycle
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/17 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   as
      l_sql_text   clob;
      l_next_cycle date;
   begin

      l_sql_text := HELPER_SQL_PK.get_generic(i_reference_id => i_cycle_id);

      execute immediate l_sql_text into l_next_cycle;

      return l_next_cycle;

   exception
      when others then
         return null;

   end sub_cycle_generic;

   function get_sub_cycle_group(i_cycle_id em.cycles.id%type)
   return varchar2
   is
      l_sc_code varchar2(1);
   begin
     select max(sc_code)
     into   l_sc_code
     from   (select 'A' sc_code
             from    dual
             where   exists (select 1
                             from   em.sub_cycle_add
                             where  cycle_id = i_cycle_id
                            )
             union all
             select 'C' sc_code
             from   dual
             where  exists (select 1
                            from   em.sub_cycle_days_in_an_year
                            where  cycle_id = i_cycle_id
                           )
             or     exists (select 1
                            from   em.sub_cycle_weeks_in_a_year
                            where  cycle_id = i_cycle_id
                           )
             or     exists (select 1
                            from   em.sub_cycle_months
                            where  cycle_id = i_cycle_id
                           )
             or     exists (select 1
                            from   em.sub_cycle_days_in_a_month
                            where  cycle_id = i_cycle_id
                           )
             or     exists (select 1
                            from   em.sub_cycle_weeks_in_a_month
                            where  cycle_id = i_cycle_id
                           )
             or     exists (select 1
                            from   em.sub_cycle_days_of_the_week
                            where  cycle_id = i_cycle_id
                           )
             union all
             select 'G' sc_code
             from    dual
             where   exists (select 1
                             from   em.sub_cycle_generics
                             where  cycle_id = i_cycle_id
                            )
            );

      return l_sc_code;

   exception
      when others then
         return null;

   end get_sub_cycle_group;

   function sub_cycle
   (
      i_cycle_id em.cycles.id%type,
      i_date     date
   )
   return date
   /*
   ||----------------------------------------------------------------------------
   || sub_cycle
   ||   Get the next cycle based on weeks in a month
   ||----------------------------------------------------------------------------
   ||             C H A N G E     L O G
   ||----------------------------------------------------------------------------
   || Date       | USERID  | Changes
   ||----------------------------------------------------------------------------
   || 2023/02/08 | asrajag | Original
   ||----------------------------------------------------------------------------
   */
   as

      l_next_cycle date;

      l_sc_code varchar2(1);

      l_time    varchar2(5);
   begin

      l_sc_code := get_sub_cycle_group(i_cycle_id);

      if l_sc_code = 'A'
      then
         declare
            l_unit em.sub_cycle_add.units%type;
            l_term em.interval_measures.symbol%type;
         begin
            SUB_CYCLE_PK.get_add(i_cycle_id, l_unit, l_term);
            if (    l_unit is not null
                and l_term is not null
               )
            then
               l_next_cycle := sub_cycle_add(i_date, l_unit, l_term);
            end if;
         end;
      elsif l_sc_code = 'C'
      then
         declare
            l_count   integer;

            l_dy_next_date    TYPE_PK.rt_date;
            l_wy_next_date    TYPE_PK.rt_date;
            l_my_next_date    TYPE_PK.rt_date;
            l_dm_next_date    TYPE_PK.rt_date;
            l_wm_next_date    TYPE_PK.rt_date;
            l_dw_next_date    TYPE_PK.rt_date;
         begin
            l_count := 0;
            l_dy_next_date := SUB_CYCLE_PK.get_day_of_the_year(i_cycle_id => i_cycle_id, i_date => i_date);
            if l_dy_next_date.id is not null
            then
               l_count := l_count + 1;
            end if;

            l_wy_next_date := SUB_CYCLE_PK.get_week_of_the_year(i_cycle_id => i_cycle_id, i_date => i_date);
            if l_wy_next_date.id is not null
            then
               l_count := l_count + 1;
            end if;

            l_my_next_date := SUB_CYCLE_PK.get_month_of_the_year(i_cycle_id => i_cycle_id, i_date => i_date);
            if l_my_next_date.id is not null
            then
               l_count := l_count + 1;
            end if;

            l_dm_next_date := SUB_CYCLE_PK.get_day_of_the_month(i_cycle_id => i_cycle_id, i_date => i_date);
            if l_dm_next_date.id is not null
            then
               l_count := l_count + 1;
            end if;

            l_wm_next_date := SUB_CYCLE_PK.get_week_of_the_month(i_cycle_id => i_cycle_id, i_date => i_date);
            if l_wm_next_date.id is not null
            then
               l_count := l_count + 1;
            end if;

            l_dw_next_date := SUB_CYCLE_PK.get_day_of_the_week(i_cycle_id => i_cycle_id, i_date => i_date);
            if l_dw_next_date.id is not null
            then
               l_count := l_count + 1;
            end if;

            if l_count = 1
            then
               l_next_cycle := coalesce(l_dy_next_date.approximate_date, l_wy_next_date.approximate_date, l_my_next_date.approximate_date,
                                        l_dm_next_date.approximate_date, l_wm_next_date.approximate_date, l_dw_next_date.approximate_date
                                       );
            elsif l_dw_next_date.id is not null
            then
               if l_wm_next_date.id is not null
               then
                  if l_my_next_date.id is not null
                  then
                     l_next_cycle := case
                                        when to_char(l_my_next_date.approximate_date, 'D') = l_dw_next_date.id
                                        then
                                           l_my_next_date.approximate_date + ((l_wm_next_date.id - 1) * 7)
                                        else
                                           next_day(l_my_next_date.approximate_date + ((l_wm_next_date.id - 1) * 7), l_dw_next_date.description)
                                     end;
                  else 
                     l_next_cycle := case
                                        when to_char(l_wm_next_date.approximate_date, 'D') = l_dw_next_date.id
                                        then
                                           l_wm_next_date.approximate_date
                                        else
                                           next_day(l_wm_next_date.approximate_date, l_dw_next_date.description)
                                     end;
                  end if;
               elsif l_wy_next_date.id is not null
               then
                  l_next_cycle := case
                                     when to_char(l_wy_next_date.approximate_date, 'D') = l_dw_next_date.id
                                     then
                                        l_wy_next_date.approximate_date
                                     else
                                        next_day(l_wy_next_date.approximate_date, l_dw_next_date.description)
                                  end;
               end if;
            elsif l_dm_next_date.id is not null
            then
               if l_my_next_date.id is not null
               then
                  l_next_cycle := l_my_next_date.approximate_date + (l_dm_next_date.id - 1);
               end if;
            end if;
         end;
      elsif l_sc_code = 'G'
      then
         l_next_cycle := sub_cycle_generic(i_cycle_id => i_cycle_id);
      end if;

      l_time := SUB_CYCLE_PK.get_time_of_the_day(i_cycle_id => i_cycle_id, i_date => i_date);

      if l_time is not null
      then
         l_next_cycle := to_date(to_char(trunc(l_next_cycle), 'YYYYMMDD') || l_time, 'YYYYMMDDHH24:MI');
      end if;

      return l_next_cycle;

   exception
      when others then
         return null;

   end sub_cycle;

end CYCLE_EVALUATOR_PK;
/
