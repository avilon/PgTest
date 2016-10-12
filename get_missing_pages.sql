/**
 * \descr Возвращает таблицу учащихся, пройденных ими тестов и потерянных (несданых) листов с заданиями
 * \author Bykov A.
 * \version 1.0
 *
 * Алгоритм:
 * Запрашиваем список тестов и студентов, прроходивших тесты.
 * Задача - получить реально пройденные тесты с id учащихся.
 * По каждому полученному тесту, получаем количество листов с заданиями.
 * Далее, используя id учащегося и id теста, который он сдавал, смотрим,
 * сколько листов с заданиями получено от учащегося (лежит в базе)
 * Если это количество совпадает с общим количеством листов, то ничего не делаем,
 * идем по курсору дальше.
 * Если листов сдано меньше, то запросом получаем список номеров несданных страниц,
 * и записываем их в строку, используя для этого отдельный цикл.
 *
 * Заполняем колонки выходной таблицы значеениями:
 *   id теста, id варианта, id учащегося, список несданых листов и возвращаем строку данных клиенту
 */
create or replace function get_missing_pages (
        _test_id int default null
)

returns table (
    student_id        int,
    test_id           int,
    version_name      char,
    lost_page_indices text
)

as $$
declare
  cur_test_id int = 0;
  -- Перечисление несданных листов
  lost_pages  text;
  --- Количество листов, сданных учащимся в тесте
  put_cnt int = 0;
  -- Общее количество листов в тесте
  page_in_test int = 0;

  rec_test_list record;

  /*
   * Список тестов и id студентов, которые их сдавали
   */
  rc_test_list cursor for
    select v.test_id
          ,v.name           as test_name
          ,p.version_id
          ,sp.student_id
          ,count(*)         as put_cnt
      from versions      v
          ,pages         p
          ,student_pages sp
     where 1 = 1
       and p.version_id = v.id
       and sp.page_id = p.id
       and (v.test_id = _test_id or _test_id is null)
     group by v.test_id
             ,v.name
             ,p.version_id
             ,sp.student_id
     order by v.test_id
             ,p.version_id;

    /*
     * Номера несданных листов
     */
    rc_page_list cursor (v_version_id int, v_student_id int) for
      select p.index
        from versions v
            ,pages    p
       where 1 = 1
         and p.version_id = v.id
         and v.id = v_version_id
         and p.id not in (
            select px.id
              from pages         px
                  ,student_pages sp
             where 1 = 1
               and sp.page_id = px.id
               and px.version_id = v.id
               and sp.student_id = v_student_id
   );
begin

  for rec_test_list in rc_test_list
  loop
    if cur_test_id <> rec_test_list.test_id then
      cur_test_id := rec_test_list.test_id;

      -- Выясним, сколько вообще в этом тесте страниц
      select count(*)
        into page_in_test
        from versions v
            ,pages    p
       where 1 = 1
         and p.version_id = v.id
         and v.id = rec_test_list.version_id;

      raise notice '     Current test_id: %', cur_test_id;
      raise notice '     Page in test:    %', page_in_test;
    end if;

    put_cnt = rec_test_list.put_cnt;

    if (put_cnt <> page_in_test) then

      raise notice ' ... version_id: %, student_id: %', rec_test_list.test_id, rec_test_list.student_id;

      lost_pages := '';
      for ndx in rc_page_list (v_version_id := rec_test_list.version_id,
                               v_student_id := rec_test_list.student_id)
      --- Формируем список потерянных листов	
      loop
        if (length(lost_pages) > 0) then
          lost_pages := lost_pages || ', ';
        end if;

        lost_pages := lost_pages || ndx.index;

        raise notice 'test_id: %, version_id: %, student_id: %, page_in_test: %, put_cnt: %, ndx = %',
               rec_test_list.test_id, rec_test_list.version_id, rec_test_list.student_id, page_in_test, put_cnt, ndx.index;

      end loop;
      
      --- возвращаем новую строку с данными о потерях
      student_id   = rec_test_list.student_id;
      test_id      = rec_test_list.test_id;
      version_name = rec_test_list.test_name;
      lost_page_indices = lost_pages;

      return next;
    end if;

  end loop;
end;
$$
language 'plpgsql' volatile


/*  
  
-- Тестовые запуски
select * from get_missing_pages(1) t;
select * from get_missing_pages() t;

*/
