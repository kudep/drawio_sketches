SHELL = /bin/bash

BUILD_DIR=build
TYPE_FILE=$(BUILD_DIR)/type
FINISH_DATE_FILE=$(BUILD_DIR)/finish_date

help:
	@echo "use `make build` or `make svg build` to export all files to svg format"
	@echo "use `make png build` to export all files to png format"
	@echo "use `make clear` to remove exported files"

.PHONY: help


env:
	@mkdir -p $(BUILD_DIR)
png: env
	@echo "png" > $(TYPE_FILE)
svg: env
	@echo "svg" > $(TYPE_FILE)
type: env
	@test -f $(TYPE_FILE) || $(MAKE) svg
build: type
	@utils/build.sh $(FINISH_DATE_FILE) $(TYPE_FILE) $(BUILD_DIR) 
clean:
	@rm -rf $(BUILD_DIR)
.PHONY: env png svg type build clean