DOCKER_RM = false

build: buildfs
	@docker build -t imega/nginx-stub .

buildfs:
	@docker run --rm=$(DOCKER_RM) \
		-v $(CURDIR)/runner:/runner \
		-v $(CURDIR)/build:/build \
		-v $(CURDIR)/src:/src \
		imega/base-builder \
		--packages="nginx-lua"

build/containers/nginx_stub:
	@mkdir -p $(shell dirname $@)
	@docker run -d --name nginx_stub $(APPDIR) -v $(CURDIR)/data:/data -p 80:80 imega/nginx-stub
	@touch $@

get_containers:
	$(eval CONTAINERS := $(subst build/containers/,,$(shell find build/containers -type f)))

stop: get_containers
	@-docker stop $(CONTAINERS)

clean: stop
	@-docker rm -fv $(CONTAINERS)
	@-rm -rf build/containers/*

logdir:
	@mkdir -p $(CURDIR)/src/app/logs
	@touch $(CURDIR)/src/app/logs/error.log

start: APPDIR = -v $(CURDIR)/src/app:/app
start: logdir build/containers/nginx_stub

test: build build/containers/nginx_stub
	@docker run --rm=$(DOCKER_RM) \
		-v $(CURDIR)/tests:/tests \
		-v $(CURDIR)/data:/data \
		-w /tests \
		--link nginx_stub:server \
		alpine \
		sh -c 'apk add --update bash curl && ./test.sh server'

.PHONY: build
