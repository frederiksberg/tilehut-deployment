MAKEFLAGS += --silent

run: build
	docker-compose up

deploy: build
	docker-compose up -d

clean: kill
	docker-compose rm -f

build: clean
	docker build -t frbsc/tilestream:latest -f ./Dockerfile .

kill:
	docker-compose down