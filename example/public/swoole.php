<?php

$http = new swoole_http_server("localhost", 8888);

$http->on("start", function ($server) {
    echo "Swoole http server is started at http://localhost:8888\n";
});

$http->on("request", function ($request, $response) {
    $response->header("Content-Type", "text/plain");
    $response->end("Hello Swoole\n");
});

$http->start();
