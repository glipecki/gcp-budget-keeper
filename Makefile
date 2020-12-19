.PHONY: infrastructure

all: clean infrastructure

clean:
	@echo "Cleaning build directories"
	cd infrastructure; rm -rf build

infrastructure:
	@echo "Deploying infrastructure"
	cd infrastructure; GOOGLE_APPLICATION_CREDENTIALS=$(credentials) terraform apply --var-file $(env)
