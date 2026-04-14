# php-compatibility-check
A Docker image to check PHP code for compatibility with PHP versions.

The objective is to provide a quick report of known PHP security alerts, based on the contents of a given 
composer.lock file, in an easy-to-use Docker image.

More specifically, this image provides:

- phpcompatibility/php-compatibility
    * Leverages PHP_Codesniffer to "sniff" code for incompatible code to various versions of PHP.
    It then reports what version of PHP the code is broken with, and what version of PHP the code
    was broken by.


IMPORTANT: This tool makes no claims of being an exhaustive reference, but with the 3 included tools, should 
be fairly comprehensive.

## Usage

Windows users: The use of "$PWD" for the present working directory will not work as expected; instead, use the full path. 
Such as "//c/Users/adamculp/project".

### PHPCompatibility

More info on how to run this tool can be found at: https://github.com/PHPCompatibility/PHPCompatibility

```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest sh -c \
'php /usr/local/lib/php-code-quality/vendor/bin/phpcs -sv --config-set installed_paths  /usr/local/lib/php-code-quality/vendor/phpcompatibility/php-compatibility && \
php /usr/local/lib/php-code-quality/vendor/bin/phpcs -sv --standard='PHPCompatibility' --extensions=php --ignore=vendor . \
--report-file=./php_code_quality/phpcompatibility_results.txt .'
```

In the example above, Docker runs an interactive terminal to be removed when all is completed, and mounts 
the current host directory ($PWD) inside the container, sets this as the current working directory, and then 
loads the image adamculp/php-compatibility-check. Following this, we call the chosen application to check on 
the code, and finally, output the results to a text file in the current working directory.

This is the most common use case, enabling the user to run the tool on code located anywhere 
on the host system by altering the path used in the command.

## Alternative Preparations

Rather than allowing Docker to retrieve the image from Docker Hub, users could also build the docker image locally 
by cloning the image repo from GitHub.

Why? For example, a different version of PHP may be desired by including a different PHP image. Or a 
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

Please star, on Docker Hub and/or GitHub, if you find this helpful.

