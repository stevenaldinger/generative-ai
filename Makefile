# ==================== [START] Global Variable Declaration =================== #
SHELL := /bin/bash
BASE_DIR := $(shell pwd)

GID := $(shell id -g $${USER})
UID := $(shell id -u $${USER})
OPERATING_SYSTEM := $(shell uname -s)

# port number and password are configured in the docker compose file
JUPYTER_NOTEBOOK_URL := http://127.0.0.1:8888/lab?token=meatwad
CHATBOT_URL := http://127.0.0.1:8080

include .env

export
# ===================== [END] Global Variable Declaration ==================== #

# ========================== [START] Docker Targets ========================== #
bash:
	@docker compose exec -it jupyter bash

IMAGE_TAG ?= latest
build_chatbot:
	@docker compose -f app/docker-compose.yml build chatbot
	@docker push gcr.io/$(GCP_PROJECT)/chatbot:$(IMAGE_TAG)
	@docker compose -f support/gcloud/docker-compose.yml run --rm -it gcloud bash -c "/mnt/project/support/replace_env_value.sh CHATBOT_SERVICE_IMAGE gcr.io/$(GCP_PROJECT)/chatbot:$(IMAGE_TAG) /mnt/project/.env"

# usage example:
# - make docs
.PHONY: docs
docs:
	@rm -rf docs/modules/*
	@mkdir -p docs/modules
	@env_running=$$(docker compose ps --status running | grep jupyter > /dev/null 2>&1 && echo -n true);\
	([ "$(env_running)" = "true" ]) && docker compose exec -it jupyter bash -c "cd /home/${USER}/work/docs/modules && python -m pydoc -w /home/${USER}/work/modules/";\
	([ "$(env_running)" != "true" ]) && docker compose run --rm -it jupyter bash -c "cd /home/${USER}/work/docs/modules && python -m pydoc -w /home/${USER}/work/modules/";

# if the anything inside the container or the host starts acting weird, this
# target will fix the permissions of the files in the container/on your machine
fix_permissions:
	@docker compose exec -it jupyter bash -c 'ls -al /home/$$NB_USER'
	@docker compose exec -it jupyter bash -c 'fix-permissions /home/$$NB_USER'
	@docker compose exec -it jupyter bash -c 'ls -al /home/$$NB_USER'

# usage example:
# - make logs
logs:
	@docker compose logs -f jupyter

# usage example: make new_notebook name=spacy-notebook
new_notebook:
	@support/new_notebook.sh $(name)

# usage examples:
# - make start_chatbot
# - make start_chatbot chrome=true
# - make start_chatbot firefox=true
start_chatbot:
	@docker compose -f app/docker-compose.yml up --detach
	@echo "chatbot is running at $(CHATBOT_URL)"
	@([ $(OPERATING_SYSTEM) = "Darwin" ] && [ "$(chrome)" = "true" ])  && open -a "Google Chrome" "$(CHATBOT_URL)" || true
	@([ $(OPERATING_SYSTEM) = "Darwin" ] && [ "$(firefox)" = "true" ]) && open -a "Firefox"       "$(CHATBOT_URL)" || true
	@([ $(OPERATING_SYSTEM) = "Linux"  ] && ([ "$(chrome)" = "true" ] || [ "$(firefox)" = "true" ]) ) && xdg-open "$(CHATBOT_URL)" 2>/dev/null &

# usage examples:
# - make start build=true chrome=true
# - make start firefox=true
start:
	$(info checking if image should rebuild...)
ifeq ($(build), true)
	@docker compose up --detach --build
else
	@docker compose up --detach
endif
	@([ $(OPERATING_SYSTEM) = "Darwin" ] && [ "$(chrome)" = "true" ])  && open -a "Google Chrome" "$(JUPYTER_NOTEBOOK_URL)" || true
	@([ $(OPERATING_SYSTEM) = "Darwin" ] && [ "$(firefox)" = "true" ]) && open -a "Firefox"       "$(JUPYTER_NOTEBOOK_URL)" || true
	@([ $(OPERATING_SYSTEM) = "Linux"  ] && ([ "$(chrome)" = "true" ] || [ "$(firefox)" = "true" ]) ) && xdg-open "$(JUPYTER_NOTEBOOK_URL)" 2>/dev/null &

# usage example:
# - make stop
stop:
	@docker compose down

# usage example:
# - make stop_chatbot
stop_chatbot:
	@docker compose -f app/docker-compose.yml down

# usage example:
# - make test
test:
	@env_running=$$(docker compose ps --status running | grep jupyter > /dev/null 2>&1 && echo -n true);\
	([ "$(env_running)" = "true" ]) && docker compose exec -it jupyter bash -c "cd /home/${USER}/work/modules && python -m unittest discover -v";\
	([ "$(env_running)" != "true" ]) && docker compose run --rm -it jupyter bash -c "cd /home/${USER}/work/modules && python -m unittest discover -v";
# =========================== [END] Docker Targets =========================== #

# ====================== [START] Infrastructure Targets ====================== #
# usage example:
# - make terraform_init
terraform_init:
	@docker compose -f terraform/docker-compose.yml run --rm -it terraform init

# usage example:
# - make terraform_plan
terraform_plan:
	@make terraform_init
	@docker compose -f terraform/docker-compose.yml run --rm -it terraform plan

# usage example:
# - make terraform_apply
terraform_apply:
	@make terraform_init
	@docker compose -f terraform/docker-compose.yml run --rm -it terraform apply
	@export API_KEY=$$(docker compose -f terraform/docker-compose.yml run --rm -it terraform output -raw custom_search_api_key);\
	docker compose -f support/gcloud/docker-compose.yml run --rm -it gcloud bash -c "/mnt/project/support/replace_env_value.sh GOOGLE_API_KEY $$API_KEY /mnt/project/.env"
	@export BUCKET_NAME=$$(docker compose -f terraform/docker-compose.yml run --rm -it terraform output -raw google_storage_bucket_name);\
	docker compose -f support/gcloud/docker-compose.yml run --rm -it gcloud bash -c "/mnt/project/support/replace_env_value.sh GCP_BUCKET_NAME $$BUCKET_NAME /mnt/project/.env"

# usage example:
# - make terraform_destroy
terraform_destroy:
	@docker compose -f terraform/docker-compose.yml run --rm -it terraform destroy
# ======================= [END] Infrastructure Targets ======================= #

# =================== [START] Google Cloud Config Targets ==================== #
# usage example:
# - make gcloud_init
gcloud_init:
	@docker compose -f support/gcloud/docker-compose.yml run --rm -it gcloud bash -c 'gcloud config configurations create $$GCP_PROJECT'
	@docker compose -f support/gcloud/docker-compose.yml run --rm -it gcloud bash -c 'gcloud config set project $$GCP_PROJECT'

# usage example:
# - make gcloud_login
gcloud_login:
	@docker compose -f support/gcloud/docker-compose.yml run --rm -it gcloud bash -c 'gcloud config set project $$GCP_PROJECT'
	@docker compose -f support/gcloud/docker-compose.yml run --rm -it gcloud bash -c 'gcloud auth login'
	@docker compose -f support/gcloud/docker-compose.yml run --rm -it gcloud bash -c 'gcloud auth application-default login'
	@docker compose -f support/gcloud/docker-compose.yml run --rm -it gcloud bash -c 'gcloud auth configure-docker || echo "docker setup failed, but it was probably already configured"'
	@docker compose -f support/gcloud/docker-compose.yml run --rm -it gcloud bash -c '/mnt/project/support/replace_env_value.sh USER_EMAIL_ADDRESS $$(gcloud config get core/account) /mnt/project/.env'
# ==================== [END] Google Cloud Config Targets ===================== #
