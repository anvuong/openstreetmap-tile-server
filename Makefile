.PHONY: build push test

build:
	docker build -t anvh87/openstreetmap-tile-server .

push: build
	docker push anvh87/openstreetmap-tile-server:latest

test: build
	docker volume create openstreetmap-data
	docker run -v openstreetmap-data:/var/lib/postgresql/10/main anvh87/openstreetmap-tile-server import
	docker run -v openstreetmap-data:/var/lib/postgresql/10/main -p 80:80 -d anvh87/openstreetmap-tile-server run