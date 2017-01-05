---
title: Профилирование CS-Cart в XHProf
updated: 2015-05-30
---

Инженерный подход анализа производительности веб-приложений лежит через профилирование. [Иерархический профилировщик XHProf](http://php.net/manual/ru/book.xhprof.php) от Facebook помогает разработчикам измерять и оценивать производительность PHP-кода. Чтобы начать его использовать для исследования проблемных мест в магазине CS-Cart:

**Шаг 1.** Установите XHProf из PECL

```
[sudo] pecl install xhprof-0.9.4
```

_Не забудьте перезапустить процесс веб-сервера или демона FPM._

**Шаг 2.** Перейдите в каталог с проектом

```
cd /var/www/html
```

**Шаг 3.** Склонируйте репозиторий XHProf

```
git clone https://github.com/phacility/xhprof.git
```

**Шаг 4.** Вставьте следующий код в начало файла `index.php`

```php
if (isset($_GET['debugging'])) {
    xhprof_enable(XHPROF_FLAGS_NO_BUILTINS | XHPROF_FLAGS_CPU | XHPROF_FLAGS_MEMORY);
}
```

**Шаг 5.** Найдите функцию `fn_dispatch` в файле `app/functions/fn.control.php`. Поместите следующий код после вызова хука `complete`

``` php
if (isset($_GET['debugging'])) {
    $xhprof_data = xhprof_disable();

    include_once DIR_ROOT . "/xhprof/xhprof_lib/utils/xhprof_lib.php";
    include_once DIR_ROOT . "/xhprof/xhprof_lib/utils/xhprof_runs.php";

    $xhprof_runs = new XHProfRuns_Default();
    $run_id = $xhprof_runs->save_run($xhprof_data, "xhprof_foo");

    echo "<!--\n" . "/xhprof/xhprof_html/index.php?run=$run_id&source=xhprof_foo\n" . "--!>\n";
}
```

Не забудьте закомментировать вызов `exit` в теле функции.

**Готово**

Откройте любую страницу веб-сайта. Отчёты профилировщика доступны в `http://example.org/xhprof/xhprof_html`. Отсортируйте строки таблицы по полю "Exclude Wall Time" для поиск медленных функций.

К сожалению, Facebook приостановили развитие расширения в феврале 2015 года — тогда, когда PHP 7.0 ещё не вышел. Энтузиасты развивают форк с [поддержкой 7-й ветки](https://github.com/RustJason/xhprof), но использовать его в бою не рекомендую.