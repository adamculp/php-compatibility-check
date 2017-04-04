#!/bin/sh

php /usr/local/lib/php-compatibility-check/composer.phar $@
STATUS=$?
return $STATUS