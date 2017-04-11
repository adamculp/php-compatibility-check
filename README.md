# php-compatibility-check
Docker image to check PHP code for compatibility to PHP versions.

The objective is to provide a quick report of known PHP security alerts, based on the contents from a given 
composer.lock file, in an easy to use Docker image.

More specifically this image provides 3 different applications to test with:

- wimg/php-compatibility
    * Leverages PHP_Codesniffer to "sniff" code for incompatible code to various versions of PHP.
    It then reports what version of PHP the code is broken with, and what version of PHP the code
    was broken by.
- sstalle/php7cc
    * Runs against the codebase and indicates what is broken in PHP version 7
- etsy/phan
    * Runs against the codebase and indicates what is broken in PHP version 7+


IMPORTANT: This tool makes no claims of being an exhaustive reference, but with the 3 included tools, should 
be fairly comprehensive.

## Usage

Windows users: The use of "$PWD" for present working directory will not work as expected, instead use the full path. 
Such as "//c/Users/adamculp/project".

### PHPCompatibility

More info on how to run this tool can be found at: https://github.com/wimg/PHPCompatibility

Note: The usage of "--extensions=vendor/wimg/php-compatibility" is a bit of a hack, to work around a bug 
preventing the rules from being loaded. Normally "--config-set installed_paths vendor/wimg/php-compatibility/" 
should work.

```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-compatibility-check:latest \
php vendor/bin/phpcs -sv --extensions=vendor/wimg/php-compatibility --standard='PHPCompatibility' \
--extensions=php --ignore=vendor --report-file=./phpcompatibility_results.txt .
```

In the example above, Docker runs an interactive terminal to be removed when all is completed, and mounts 
the current host directory ($PWD) inside the container, sets this as the current working directory, and then 
loads the image adamculp/php-compatibility-check. Following this we call the chosen application to check on 
the code, and finally, output the results to a text file in the current working directory.

This is the most common use case, enabling the user to run the tool on code located anywhere 
on the host system by altering the path used in the command.

### Other Tool Examples

#### php7cc

More info on how to run this tool can be found at: https://github.com/sstalle/php7cc

```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-compatibility-check:latest \
php vendor/bin/php7cc --extensions=php \
--except=vendor > ./php7cc_results.txt .
```

#### Phan

More info on how to run this tool can be found at: https://github.com/etsy/phan

```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-compatibility-check:latest \
php vendor/bin/phan -l . --exclude-directory-list "vendor/" \
> ./phan_results.txt
```

By default Phan examines code in the following directories, plus what is specified in the command:

```php
'directory_list' => [
        'src',
        'tests/Phan',
        'vendor/phpunit/phpunit/src',
        'vendor/symfony/console',
        '.phan/stubs',
    ],
```

To do otherwise it will require you to edit the Phan Phan/.phan/config.php file, and use the Alternative 
Preparations as indicated below.

## Alternative Preparations

Rather than allowing Docker to retrieve the image from Docker Hub, users could also build the docker image locally 
by cloning the image repo from Github.

Why? As an example, a different version of PHP provided by including a different PHP image may be desired. Or a 
specific version of the tools loaded by Composer might be required.

After cloning, navigate to the location:

```
$ git clone https://github.com/adamculp/php-compatibility-check.git
$ cd php-compatibility-check
```

Alter the Dockerfile as desired, then build the image locally:

```
$ docker build -t adamculp/php-compatibility-check .
```

Or a user may simply desire the image as-is, for later use:

```
$ docker build -t adamculp/php-compatibility-check https://github.com/adamculp/php-compatibility-check.git
```

## Enjoy!

Please star, on Docker Hub and/or Github, if you find this helpful.

