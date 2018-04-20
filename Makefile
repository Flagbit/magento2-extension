include dev/.env

COMPOSE_FILE=dev/docker-compose.yaml
COMPOSE=docker-compose -f $(COMPOSE_FILE) -p mage


default: help

up: ## Creates containers and starts app
	@$(COMPOSE) up -d
	@echo "Waiting for DB to be ready..."
	@sleep 3
	@$(COMPOSE) exec web install-magento
	@$(COMPOSE) exec --user 33 web composer dump-autoload
	@$(COMPOSE) exec --user 33 web bin/magento setup:upgrade
	@$(COMPOSE) exec --user 33 web bin/magento setup:di:compile

down: ## Destorys containers
	@$(COMPOSE) down

start: ## Starts existing containers
	@$(COMPOSE) start

stop: ## Stops containers
	@$(COMPOSE) stop

ps: ## Displays container statuses
	@$(COMPOSE) ps

ssh: ## Enters the web container
	@$(COMPOSE) exec web bash

exec: ## Runs command in web container (make exec command=your-command)
	@$(COMPOSE) exec web $(command)

install-magento: ## Installs Magento in the container
	@$(COMPOSE) exec web install-magento

install-sampledata: ## Installs Magento sample data in the container
	@$(COMPOSE) exec web install-sampledata

magento: ## Runs Magento CLI command (make magento command=your-command)
	@$(COMPOSE) exec --user 33 web bin/magento $(command)

mysql: ## Enter MYSQL command line
	@$(COMPOSE) exec db mysql -u magento -p$(MYSQL_PASSWORD)

exception: ## Tail Magento exception logs
	@echo "Following var/log/exception.log\n"
	@$(COMPOSE) exec web tail -f -n 10 var/log/exception.log

help: ## This help message
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' -e 's/:.*#/: #/' | column -t -s '##'