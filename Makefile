#!/usr/bin/env make
#
<<<<<<< HEAD
# Course repo, to work with a dbwebb course.
# See organisation on GitHub: https://github.com/dbwebb-se
=======
# An Anax module.
# See organisation on GitHub: https://github.com/canax
>>>>>>> caa6605cf75df41b68a7c387ad94a675662e54d7

# ------------------------------------------------------------------------
#
# General stuff, reusable for all Makefiles.
#

# Detect OS
OS = $(shell uname -s)

# Defaults
ECHO = echo

# Make adjustments based on OS
ifneq (, $(findstring CYGWIN, $(OS)))
	ECHO = /bin/echo -e
endif

# Colors and helptext
NO_COLOR	= \033[0m
ACTION		= \033[32;01m
OK_COLOR	= \033[32;01m
ERROR_COLOR	= \033[31;01m
WARN_COLOR	= \033[33;01m

# Print out colored action message
ACTION_MESSAGE = $(ECHO) "$(ACTION)---> $(1)$(NO_COLOR)"

# Which makefile am I in?
<<<<<<< HEAD
WHERE-AM-I = "$(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))"
=======
WHERE-AM-I = $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
>>>>>>> caa6605cf75df41b68a7c387ad94a675662e54d7
THIS_MAKEFILE := $(call WHERE-AM-I)

# Echo some nice helptext based on the target comment
HELPTEXT = $(call ACTION_MESSAGE, $(shell egrep "^\# target: $(1) " $(THIS_MAKEFILE) | sed "s/\# target: $(1)[ ]*-[ ]* / /g"))

# Check version  and path to command and display on one line
<<<<<<< HEAD
CHECK_VERSION = printf "%-15s %-13s %s\n" "`basename $(1)`" "`$(1) --version $(2)`" "`which $(1)`"
=======
CHECK_VERSION = printf "%-15s %-10s %s\n" "`basename $(1)`" "`$(1) --version $(2)`" "`which $(1)`"
>>>>>>> caa6605cf75df41b68a7c387ad94a675662e54d7

# Get current working directory, it may not exist as environment variable.
PWD = $(shell pwd)

# target: help                    - Displays help.
.PHONY:  help
help:
	@$(call HELPTEXT,$@)
	@sed '/^$$/q' $(THIS_MAKEFILE) | tail +3 | sed 's/#\s*//g'
	@$(ECHO) "Usage:"
	@$(ECHO) " make [target] ..."
	@$(ECHO) "target:"
	@egrep "^# target:" $(THIS_MAKEFILE) | sed 's/# target: / /g'



# ------------------------------------------------------------------------
#
# Specifics for this project.
#
# Default values for arguments
<<<<<<< HEAD
container ?= cli

# Add local bin path for test tools
PATH := $(PWD)/bin:$(PWD)/vendor/bin:$(PWD)/node_modules/.bin:$(PATH)
SHELL := env PATH='$(PATH)' $(SHELL)

# Tools
DBWEBB   		:= bin/dbwebb
DBWEBB_VALIDATE := bin/dbwebb-validate
DBWEBB_INSPECT  := bin/dbwebb-inspect
PHPCS   := bin/phpcs
PHPMD   := bin/phpmd



# ----------------------------------------------------------------------------
#
# Highlevel targets
#
# target: prepare                 - Prepare the build directory.
.PHONY: prepare
prepare:
	@$(call HELPTEXT,$@)
	[ -d build ]   || install -d build/webroot
	[ -d bin/pip ] || install -d bin/pip



# target: install                 - Install needed utilities locally.
.PHONY: install
install: prepare dbwebb-validate-install dbwebb-inspect-install dbwebb-install npm-install composer-install
	@$(call HELPTEXT,$@)

	@# Disable PHP tools with arguments
	curl -Lso $(PHPCS) https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && chmod 755 $(PHPCS)

	# curl -Lso $(PHPMD) http://static.phpmd.org/php/latest/phpmd.phar && chmod 755 $(PHPMD)
	curl -Lso $(PHPMD) http://www.student.bth.se/~mosstud/download/phpmd && chmod 755 $(PHPMD)

	# Shellcheck
	curl -s https://storage.googleapis.com/shellcheck/shellcheck-latest.linux.x86_64.tar.xz | tar -xJ -C build/ && rm -f bin/shellcheck && ln build/shellcheck-latest/shellcheck bin/

	@# Shellcheck
	@# tree (inspect)
	@# python through reqs and venv
	@# Add to check on dbwebb-cli to try all parts php in path, make, composer, node, npm, python3, python, mm.



# target: check                   - Check installed utilities.
.PHONY: check
check: dbwebb-validate-check docker-check
	@$(call HELPTEXT,$@)
	@$(call CHECK_VERSION, make, | head -1)



# target: test                    - Run tests.
.PHONY: test
test: dbwebb-publish-example dbwebb-testrepo
	@$(call HELPTEXT,$@)
	[ ! -f composer.json ] || composer validate


# target: testrepo                - Runs unit tests on course repo.
.PHONY: testrepo
testrepo: dbwebb-testrepo
	@$(call HELPTEXT,$@)



# target: clean                   - Remove all generated files.
.PHONY:  clean
clean:
	@$(call HELPTEXT,$@)
	rm -rf build
	rm -f npm-debug.log



# target: clean-me                - Remove me-directory.
.PHONY:  clean-me
clean-me:
	@$(call HELPTEXT,$@)
	rm -rf me



# target: clean-all               - Remove all installed files.
.PHONY:  clean-all
clean-all: clean
	@$(call HELPTEXT,$@)
	rm -rf bin
	rm -rf node_modules package-lock.json
	rm -rf vendor composer.lock
	rm -rf .venv



# ----------------------------------------------------------------------------
#
# Shortcuts for frequent usage
#
# target: validate                - Execute dbwebb validate what=part-to-validate.
.PHONY: validate
validate: dbwebb-validate
=======
container ?= latest

BIN     := .bin
#PHPUNIT := $(BIN)/phpunit
PHPUNIT := vendor/bin/phpunit
PHPLOC 	:= $(BIN)/phploc
PHPCS   := $(BIN)/phpcs
PHPCBF  := $(BIN)/phpcbf
PHPMD   := $(BIN)/phpmd
PHPDOC  := $(BIN)/phpdoc
BEHAT   := $(BIN)/behat
SHELLCHECK := $(BIN)/shellcheck
BATS := $(BIN)/bats



# target: prepare                 - Prepare for tests and build
.PHONY:  prepare
prepare:
	@$(call HELPTEXT,$@)
	[ -d .bin ] || mkdir .bin
	[ -d build ] || mkdir build
	rm -rf build/*



# target: clean                   - Removes generated files and directories.
.PHONY: clean
clean:
	@$(call HELPTEXT,$@)
	rm -rf build



# target: clean-cache             - Clean the cache.
.PHONY:  clean-cache
clean-cache:
	@$(call HELPTEXT,$@)
	rm -rf cache/*/*



# target: clean-all               - Removes generated files and directories.
.PHONY:  clean-all
clean-all: clean clean-cache
	@$(call HELPTEXT,$@)
	rm -rf .bin vendor composer.lock



# target: check                   - Check version of installed tools.
.PHONY:  check
check: check-tools-bash check-tools-php check-docker
>>>>>>> caa6605cf75df41b68a7c387ad94a675662e54d7
	@$(call HELPTEXT,$@)



<<<<<<< HEAD
# target: publish                 - Execute dbwebb publish what=part-to-validate.
.PHONY: publish
publish: dbwebb-publish
	@$(call HELPTEXT,$@)



# target: inspect                 - Execute dbwebb inspect options="" what=kmom01.
.PHONY: inspect
inspect: dbwebb-inspect
=======
# target: test                    - Run all tests.
.PHONY:  test
test: phpunit phpcs phpmd phploc behat shellcheck bats
	@$(call HELPTEXT,$@)
	composer validate



# target: doc                     - Generate documentation.
.PHONY:  doc
doc: phpdoc
>>>>>>> caa6605cf75df41b68a7c387ad94a675662e54d7
	@$(call HELPTEXT,$@)



<<<<<<< HEAD
# ----------------------------------------------------------------------------
#
# Python
#
# target: python-install          - Install Python utilities locally.
.PHONY: python-install
python-install: prepare
	@$(call HELPTEXT,$@)
	[ ! -f .requirements.txt ] || python3 -m pip install --requirement .requirements.txt



# target: python-upgrade          - Upgrade Python utilities locally.
.PHONY: python-upgrade
python-upgrade: prepare
	@$(call HELPTEXT,$@)
	[ ! -f .requirements.txt ] || python3 -m pip install --upgrade --requirement .requirements.txt



# target: python-venv             - Create Python virtual environment .venv.
.PHONY: python-venv
python-venv:
	@$(call HELPTEXT,$@)
	python3 -m venv .venv



# ----------------------------------------------------------------------------
#
# dbwebb cli
#
# target: dbwebb-install          - Download and install dbwebb-cli.
.PHONY: dbwebb-install
dbwebb-install: prepare
	@$(call HELPTEXT,$@)
	wget --quiet -O $(DBWEBB) https://raw.githubusercontent.com/mosbth/dbwebb-cli/master/dbwebb2
	chmod 755 $(DBWEBB)
	$(DBWEBB) config create noinput
	(cd bin; rm -f dbwebb-validate1; cp dbwebb-validate dbwebb-validate1)
	(cd bin; rm -f dbwebb-inspect1; cp dbwebb-inspect dbwebb-inspect1)



# target: dbwebb-testrepo         - Test course repo.
.PHONY: dbwebb-testrepo
dbwebb-testrepo:
	@$(call HELPTEXT,$@)
	env PATH='$(PATH)' $(DBWEBB) --silent --local testrepo
=======
# target: build                   - Do all build
.PHONY:  build
build: test doc #theme less-compile less-minify js-minify
	@$(call HELPTEXT,$@)



# target: install                 - Install all tools
.PHONY:  install
install: prepare install-tools-php install-tools-bash
	@$(call HELPTEXT,$@)
	composer install



# target: install-lowest          - Install lowest version of deoendencies
.PHONY:  install-lowest
install-lowest:
	@$(call HELPTEXT,$@)
	composer update --no-dev --prefer-lowest



# target: update                  - Update the codebase and tools.
.PHONY:  update
update:
	@$(call HELPTEXT,$@)
	[ ! -d .git ] || git pull
	composer update



# target: tag-prepare             - Prepare to tag new version.
.PHONY: tag-prepare
tag-prepare:
	@$(call HELPTEXT,$@)
>>>>>>> caa6605cf75df41b68a7c387ad94a675662e54d7



# ----------------------------------------------------------------------------
#
<<<<<<< HEAD
# dbwebb validate & publish
#
# target: dbwebb-validate-install - Download and install dbwebb-validate.
.PHONY: dbwebb-validate-install
dbwebb-validate-install: prepare
	@$(call HELPTEXT,$@)
	wget --quiet -O $(DBWEBB_VALIDATE) https://raw.githubusercontent.com/mosbth/dbwebb-cli/master/dbwebb2-validate
	chmod 755 $(DBWEBB_VALIDATE)



# target: dbwebb-validate-check   - Check version and environment for dbwebb-validate.
.PHONY: dbwebb-validate-check
dbwebb-validate-check:
	@$(call HELPTEXT,$@)
	env PATH='$(PATH)' $(DBWEBB_VALIDATE) --check



# target: dbwebb-validate         - Execute dbwebb validate options="" what=part-to-validate.
.PHONY: dbwebb-validate
dbwebb-validate:
	@$(call HELPTEXT,$@)
	env PATH='$(PATH)' $(DBWEBB_VALIDATE) $(options) $(what)



# target: dbwebb-publish          - Execute dbwebb publish options="" what=part-to-validate-publish.
.PHONY: dbwebb-publish
dbwebb-publish: prepare
	@$(call HELPTEXT,$@)
	env PATH='$(PATH)' $(DBWEBB_VALIDATE) --publish --publish-to build/webroot/ --publish-root . $(options) $(what)


# target: dbwebb-publishpure      - Execute dbwebb publishpure options="" what=part-to-validate-publish.
.PHONY: dbwebb-publishpure
dbwebb-publishpure: prepare
	@$(call HELPTEXT,$@)
	install -d build/webroot/$(what)
	env PATH='$(PATH)' $(DBWEBB_VALIDATE) --publish --publish-to build/webroot/$(what) --publish-root . --no-validate --no-minification $(options) $(what)



# target: dbwebb-publish-example  - Execute dbwebb publish /example to build/webroot
.PHONY: dbwebb-publish-example
dbwebb-publish-example: prepare
	@$(call HELPTEXT,$@)
	env PATH='$(PATH)' $(DBWEBB_VALIDATE) --publish --publish-to build/webroot/ --publish-root . $(options) example



# ----------------------------------------------------------------------------
#
# dbwebb inspect
#
# target: dbwebb-inspect-install  - Download and install dbwebb-inspect.
.PHONY: dbwebb-inspect-install
dbwebb-inspect-install: prepare
	@$(call HELPTEXT,$@)
	wget --quiet -O $(DBWEBB_INSPECT) https://raw.githubusercontent.com/mosbth/dbwebb-cli/master/dbwebb2-inspect
	chmod 755 $(DBWEBB_INSPECT)



# target: dbwebb-inspect-check    - Check version and environment for dbwebb-inspect.
.PHONY: dbwebb-inspect-check
dbwebb-inspect-check:
	@$(call HELPTEXT,$@)
	$(DBWEBB_INSPECT) --version



# target: dbwebb-inspect          - Execute dbwebb inspect what=kmom01.
.PHONY: dbwebb-inspect
dbwebb-inspect:
	@$(call HELPTEXT,$@)
	env PATH='$(PATH)' $(DBWEBB_INSPECT) $(options) . $(what)



# ----------------------------------------------------------------------------
#
# npm
#
# target: npm-install             - Install npm packages for development.
.PHONY: npm-install
npm-install: prepare
	@$(call HELPTEXT,$@)
	[ ! -f package.json ] || npm install



# target: npm-update              - Update npm packages for development.
.PHONY: npm-update
npm-update:
	@$(call HELPTEXT,$@)
	[ ! -f package.json ] || npm update



# ----------------------------------------------------------------------------
#
# composer
#
# target: composer-install        - Install composer packages for development.
.PHONY: composer-install
composer-install: prepare
	@$(call HELPTEXT,$@)
=======
# docker
#
# target: docker-up               - Start all docker container="", or specific, default "latest".
.PHONY: docker-up
docker-up:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml up -d $(container)



# target: docker-stop             - Stop running docker containers.
.PHONY: docker-stop
docker-stop:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml stop



# target: docker-run              - Run container="" with what="" one off command.
.PHONY: docker-run
docker-run:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run $(container) $(what)



# target: docker-bash             - Run container="" with what="bash" one off command.
.PHONY: docker-bash
docker-bash:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run $(container) bash



# target: docker-exec             - Run container="" with what="" command in running container.
.PHONY: docker-exec
docker-exec:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml exec $(container) $(what)



# target: docker-install          - Run make install in container="".
.PHONY: docker-install
docker-install:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run $(container) make install



# target: docker-test             - Run make test in container="".
.PHONY: docker-test
docker-test:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run $(container) make test



# target: check-docker            - Check versions of docker.
.PHONY: check-docker
check-docker:
	@$(call HELPTEXT,$@)
	@$(call CHECK_VERSION, docker, | cut -d" " -f3-)
	@$(call CHECK_VERSION, docker-compose, | cut -d" " -f3-)



# ------------------------------------------------------------------------
#
# PHP
#

# target: install-tools-php       - Install PHP development tools.
.PHONY: install-tools-php
install-tools-php:
	@$(call HELPTEXT,$@)
	#curl -Lso $(PHPDOC) https://www.phpdoc.org/phpDocumentor.phar && chmod 755 $(PHPDOC)
	curl -Lso $(PHPDOC) https://github.com/phpDocumentor/phpDocumentor2/releases/download/v2.9.0/phpDocumentor.phar && chmod 755 $(PHPDOC)

	curl -Lso $(PHPCS) https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && chmod 755 $(PHPCS)

	curl -Lso $(PHPCBF) https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar && chmod 755 $(PHPCBF)

	curl -Lso $(PHPMD) http://static.phpmd.org/php/latest/phpmd.phar && chmod 755 $(PHPMD)
	# curl -Lso $(PHPMD) http://www.student.bth.se/~mosstud/download/phpmd.phar && chmod 755 $(PHPMD)

	curl -Lso $(PHPLOC) https://phar.phpunit.de/phploc.phar && chmod 755 $(PHPLOC)

	curl -Lso $(BEHAT) https://github.com/Behat/Behat/releases/download/v3.3.0/behat.phar && chmod 755 $(BEHAT)

	# # Get PHPUNIT depending on current PHP installation
	# curl -Lso $(PHPUNIT) https://phar.phpunit.de/phpunit-$(shell \
	#  	php -r "echo version_compare(PHP_VERSION, '7.0', '<') \
	# 		? '5' \
	# 		: (version_compare(PHP_VERSION, '7.1', '>=') \
	# 			? '7' \
	# 			: '6'\
	# 	);" \
	# 	).phar && chmod 755 $(PHPUNIT)

>>>>>>> caa6605cf75df41b68a7c387ad94a675662e54d7
	[ ! -f composer.json ] || composer install



<<<<<<< HEAD
# target: composer-update         - Update composer packages for development.
.PHONY: composer-update
composer-update:
	@$(call HELPTEXT,$@)
	[ ! -f composer.json ] || composer update



# ----------------------------------------------------------------------------
#
# docker
#
# target: docker-up               - Start all docker container="", or specific, default "latest".
.PHONY: docker-up
docker-up:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml up -d $(container)



# target: docker-stop             - Stop running docker containers.
.PHONY: docker-stop
docker-stop:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml stop



# target: docker-run              - Run container="" with what="" one off command.
.PHONY: docker-run
docker-run:
	@$(call HELPTEXT,$@)
ifeq ($(what),)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run  $(container) bash
else
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run  $(container) $(what)
=======
# target: check-tools-php         - Check versions of PHP tools.
.PHONY: check-tools-php
check-tools-php:
	@$(call HELPTEXT,$@)
	php --version && echo
	composer show && echo
	@$(call CHECK_VERSION, $(PHPUNIT))
	@$(call CHECK_VERSION, $(PHPLOC))
	@$(call CHECK_VERSION, $(PHPCS))
	@$(call CHECK_VERSION, $(PHPMD))
	@$(call CHECK_VERSION, $(PHPCBF))
	@$(call CHECK_VERSION, $(PHPDOC))
	@$(call CHECK_VERSION, $(BEHAT))



# target: phpunit                 - Run unit tests for PHP.
.PHONY: phpunit
phpunit: prepare
	@$(call HELPTEXT,$@)
	[ ! -d "test" ] || $(PHPUNIT) --configuration .phpunit.xml $(options)



# target: phpcs                   - Codestyle for PHP.
.PHONY: phpcs
phpcs: prepare
	@$(call HELPTEXT,$@)
	[ ! -f .phpcs.xml ] || $(PHPCS) --standard=.phpcs.xml | tee build/phpcs



# target: phpcbf                  - Fix codestyle for PHP.
.PHONY: phpcbf
phpcbf:
	@$(call HELPTEXT,$@)
ifneq ($(wildcard test),)
	[ ! -f .phpcs.xml ] || $(PHPCBF) --standard=.phpcs.xml
else
	[ ! -f .phpcs.xml ] || $(PHPCBF) --standard=.phpcs.xml src
>>>>>>> caa6605cf75df41b68a7c387ad94a675662e54d7
endif



<<<<<<< HEAD
# target: docker-run-server       - Run --service-ports container="" with what="" one off command.
.PHONY: docker-run-server
docker-run-server:
	@$(call HELPTEXT,$@)
ifeq ($(what),)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run --service-ports $(container) bash
else
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run --service-ports $(container) $(what)
endif



# target: docker-exec             - Run container="" with what="" command in running container.
.PHONY: docker-exec
docker-exec:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml exec $(container) $(what)



# target: docker-install          - Run make install in container="".
.PHONY: docker-install
docker-install:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run $(container) make install



# target: docker-test             - Run "make test" in container="".
.PHONY: docker-test
docker-test:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run $(container) make test



# target: docker-test-clean       - Run make clean-me test in docker.
.PHONY: docker-test-clean
docker-test-clean:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run $(container) make clean-me test



# target: docker-validate         - Run dbwebb validate what="" in docker.
.PHONY: docker-validate
docker-validate:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run $(container) make validate options="$(options)" what="$(what)"



# target: docker-publish          - Run dbwebb publish what="" in docker.
.PHONY: docker-publish
docker-publish:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run $(container) make publish options="$(options)" what="$(what)"



# target: docker-publish-me       - Run dbwebb publishpure what="me" in docker.
.PHONY: docker-publish-me
docker-publish-me:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run $(container) make dbwebb-publishpure options="$(options)" what="me"



# target: docker-publish-example  - Run dbwebb publishpure what="example" in docker.
.PHONY: docker-publish-example
docker-publish-example:
	@$(call HELPTEXT,$@)
	[ ! -f docker-compose.yaml ] || docker-compose -f docker-compose.yaml run $(container) make dbwebb-publishpure options="$(options)" what="example"



# target: docker-check            - Check versions of docker.
.PHONY: docker-check
docker-check:
	@$(call HELPTEXT,$@)
	@$(call CHECK_VERSION, docker, | cut -d" " -f3)
	@$(call CHECK_VERSION, docker-compose, | cut -d" " -f3)
=======
# target: phpmd                   - Mess detector for PHP.
.PHONY: phpmd
phpmd: prepare
	@$(call HELPTEXT,$@)
	- [ ! -f .phpmd.xml ] || [ ! -d src ] || $(PHPMD) . text .phpmd.xml | tee build/phpmd



# target: phploc                  - Code statistics for PHP.
.PHONY: phploc
phploc: prepare
	@$(call HELPTEXT,$@)
	[ ! -d src ] || $(PHPLOC) src > build/phploc



# target: phpdoc                  - Create documentation for PHP.
.PHONY: phpdoc
phpdoc:
	@$(call HELPTEXT,$@)
	[ ! -d doc ] || $(PHPDOC) --config=.phpdoc.xml



# target: behat                   - Run behat for feature tests.
.PHONY: behat
behat:
	@$(call HELPTEXT,$@)
	[ ! -d features ] || $(BEHAT)


# ------------------------------------------------------------------------
#
# Bash
#

# target: install-tools-bash      - Install Bash development tools.
.PHONY: install-tools-bash
install-tools-bash:
	@$(call HELPTEXT,$@)
	# Shellcheck
	curl -s https://storage.googleapis.com/shellcheck/shellcheck-latest.linux.x86_64.tar.xz | tar -xJ -C build/ && rm -f .bin/shellcheck && ln build/shellcheck-latest/shellcheck .bin/

	# Bats
	curl -Lso $(BIN)/bats-exec-suite https://raw.githubusercontent.com/sstephenson/bats/master/libexec/bats-exec-suite
	curl -Lso $(BIN)/bats-exec-test https://raw.githubusercontent.com/sstephenson/bats/master/libexec/bats-exec-test
	curl -Lso $(BIN)/bats-format-tap-stream https://raw.githubusercontent.com/sstephenson/bats/master/libexec/bats-format-tap-stream
	curl -Lso $(BIN)/bats-preprocess https://raw.githubusercontent.com/sstephenson/bats/master/libexec/bats-preprocess
	curl -Lso $(BATS) https://raw.githubusercontent.com/sstephenson/bats/master/libexec/bats
	chmod 755 $(BIN)/bats*



# target: check-tools-bash        - Check versions of Bash tools.
.PHONY: check-tools-bash
check-tools-bash:
	@$(call HELPTEXT,$@)
	@$(call CHECK_VERSION, $(SHELLCHECK))
	@$(call CHECK_VERSION, $(BATS))



# target: shellcheck              - Run shellcheck for bash files.
.PHONY: shellcheck
shellcheck:
	@$(call HELPTEXT,$@)
	[ ! -f src/*.bash ] || $(SHELLCHECK) --shell=bash src/*.bash



# target: bats                    - Run bats for unit testing bash files.
.PHONY: bats
bats:
	@$(call HELPTEXT,$@)
	[ ! -d bats ] || $(BATS) bats/



# ------------------------------------------------------------------------
#
# Developer
#
# target: scaff-reinstall         - Reinstall using scaffolding processing scripts.
.PHONY: scaff-reinstall
scaff-reinstall:
	@$(call HELPTEXT,$@)
	#rm -rf -v !(composer.*|vendor|.anax); .anax/scaffold/postprocess.bash



# ------------------------------------------------------------------------
#
# Theme
#
# target: theme                   - Do make build install in theme/ if available.
.PHONY: theme
theme:
	@$(call HELPTEXT,$@)
	[ ! -d theme ] || $(MAKE) --directory=theme build
	rsync -a theme/htdocs/css htdocs/



# # ------------------------------------------------------------------------
# #
# # Cimage
# #
# 
# define CIMAGE_CONFIG
# <?php
# return [
#     "mode"         => "development",
#     "image_path"   =>  __DIR__ . "/../img/",
#     "cache_path"   =>  __DIR__ . "/../../cache/cimage/",
#     "autoloader"   =>  __DIR__ . "/../../vendor/autoload.php",
# ];
# endef
# export CIMAGE_CONFIG
# 
# define GIT_IGNORE_FILES
# # Ignore everything in this directory
# *
# # Except this file
# !.gitignore
# endef
# export GIT_IGNORE_FILES
# 
# # target: cimage-install          - Install Cimage in htdocs
# .PHONY: cimage-install
# cimage-install:
# 	@$(call HELPTEXT,$@)
# 	install -d htdocs/img htdocs/cimage cache/cimage
# 	chmod 777 cache/cimage
# 	$(ECHO) "$$GIT_IGNORE_FILES" | bash -c 'cat > cache/cimage/.gitignore'
# 	cp vendor/mos/cimage/webroot/img.php htdocs/cimage
# 	cp vendor/mos/cimage/webroot/img/car.png htdocs/img/
# 	touch htdocs/cimage/img_config.php
# 
# # target: cimage-update           - Update Cimage to latest version.
# .PHONY: cimage-update
# cimage-update:
# 	@$(call HELPTEXT,$@)
# 	composer require mos/cimage
# 	install -d htdocs/img htdocs/cimage cache/cimage
# 	chmod 777 cache/cimage
# 	$(ECHO) "$$GIT_IGNORE_FILES" | bash -c 'cat > cache/cimage/.gitignore'
# 	cp vendor/mos/cimage/webroot/img.php htdocs/cimage
# 	cp vendor/mos/cimage/webroot/img/car.png htdocs/img/
# 	touch htdocs/cimage/img_config.php
# 
# # target: cimage-config-create    - Create configfile for Cimage.
# .PHONY: cimage-config-create
# cimage-config-create:
# 	@$(call HELPTEXT,$@)
# 	$(ECHO) "$$CIMAGE_CONFIG" | bash -c 'cat > htdocs/cimage/img_config.php'
# 	cat htdocs/cimage/img_config.php
>>>>>>> caa6605cf75df41b68a7c387ad94a675662e54d7
