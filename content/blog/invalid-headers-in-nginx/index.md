---
title: Как передавать заголовки с точкой в Nginx
description: Как передавать заголовки с точкой в Nginx
date: 2020-02-16
---

В одном проекте перед эксплуатацией была задача по интеграции с биллинг-системой
заказчика через реверс-прокси Nginx. Особенность этой системы — спецификация API
с необходимостью передавать HTTP-заголовок с точкой.

Несмотря на то, что [RFC 2616](https://tools.ietf.org/html/rfc2616#section-4.2) разрешает
использовать любые ASCII-символы (за исключением управляющих символов и некоторых разделителей),
в Nginx такие заголовки считаются некорректными и переданы не будут. Системный администратор
может разрешить любые невалидные заголовки опцией `ignore_invalid_headers` глобально,
однако есть и другой способ.

Со стороны приложения достаточно использовать привычные заголовки, заменив точки дефисами,
а в реверс-прокси указать заголовок в кавычках.

```
location / {
    proxy_pass http://[...];
    proxy_set_header "Service.Id" "$http_service_id";
    [...]
}
```

На мой взгляд, достаточно изящный ход, сочетающий отказ от `ignore_invalid_headers` и
решение задачи на уровне веб-сервера.