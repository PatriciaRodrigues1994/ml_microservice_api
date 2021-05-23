## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

# install the important devops tools

install-docker-compose:
	sudo wget -O /bin/docker-compose https://github.com/docker/compose/releases/download/1.25.5/docker-compose-Linux-x86_64
	chmod +x /bin/docker-compose

install-hadolint:
	sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64
	sudo chmod +x /bin/hadolint

install-kubectl:
# 	curl -LO "https://dl.k8s.io/release/v1.21.1/bin/linux/amd64/kubectl"
# 	curl -LO "https://dl.k8s.io/v1.21.1/bin/linux/amd64/kubectl.sha256"
# 	echo "$(<kubectl.sha256) kubectl" | sha256sum --check
	sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	kubectl version --client

# 	sudo wget -O /bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
# 	sudo chmod +x /bin/kubectl

install-minikube:
	sudo wget -O /bin/minikube https://github.com/kubernetes/minikube/releases/download/v1.9.2/minikube-linux-amd64
	sudo chmod +x /bin/minikube

setup:
	# Create python virtualenv & source it
	# 
	# source ~/.devops/bin/activate
	python3 -m venv .devops

install:
	# This should be run from inside a virtualenv
	pip install --upgrade pip &&\
		pip install -r requirements.txt &&\
			pip install 'pylint<=2.4.4' &&\
			pip install pytest

validate-circleci:
      circleci config process .circleci/config.yml

run-circleci-local:
      circleci local execute


test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203 app.py

all: install lint test
