<?php

$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

if ($path === '/' || $path === '/index.php') {
    return false;
}

if (is_string($path) && preg_match(
    '~^/assets/(?:[a-zA-Z0-9_-]+/)*[a-zA-Z0-9_.-]+\.(css|js|png|jpg|jpeg|svg|webp|gif|ico|woff2?)$~i',
    $path
)) {
    $file = realpath(__DIR__ . $path);
    $assets = realpath(__DIR__ . '/assets');

    if ($file && $assets && is_file($file) &&
        str_starts_with($file, $assets . DIRECTORY_SEPARATOR)) {
        return false;
    }
}

http_response_code(404);
exit('Not Found');