PACKAGE := mlrun-trial
PACKAGE_DIR := src/${PACKAGE}
SHELL := env PYTHON_VERSION=3.9 /bin/bash
.SILENT: run devinstall install test lint format
PYTHON_VERSION ?= 3.9

setup:
	curl -sSf https://rye-up.com/get | RYE_NO_AUTO_INSTALL=1 RYE_INSTALL_OPTION="--yes" bash

install:
	$(HOME)/.rye/shims/rye sync --no-lock --no-dev
	$(HOME)/.rye/shims/rye run mlrun config set -a http://localhost:8080

devinstall:
	$(HOME)/.rye/shims/rye pin $(PYTHON_VERSION)
	$(HOME)/.rye/shims/rye add ipython pytest pytest-cov --dev
	$(HOME)/.rye/shims/rye sync
	$(HOME)/.rye/shims/rye run mlrun config set -a http://localhost:8080

test:
	$(HOME)/.rye/shims/rye run pytest

run: 
	$(HOME)/.rye/shims/rye run python main.py

lint:
	$(HOME)/.rye/shims/rye lint -q -- --select I --fix 

format:
	$(HOME)/.rye/shims/rye fmt

all: devinstall lint format test
