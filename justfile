process: build
	node -r dotenv/config lib/processor.js

serve:
	npx squid-graphql-server

up:
  docker compose up

pull:
  docker compose pull

clear:
  docker compose rm -f
  rm -rf .data

down:
  docker compose down

build:
	npm run build

codegen:
	npx sqd codegen

typegen: ksmVersion
	npx squid-substrate-typegen typegen.json

ksmVersion: explore

explore:
	npx squid-substrate-metadata-explorer \
		--chain wss://basilisk-kodadot.hydration.cloud \
		--archive http://localhost:4010/v1/graphql \
		--out kusamaVersions.json

bug: down up

reset:
	npx sqd db drop
	npx sqd db create
	npx sqd db:migrate

migrate:
	npx sqd db:migrate

update-db:
	npx sqd db:create-migration Data

test:
  npm run test:unit

improve TAG:
	npx sqd squid:update snek@{{TAG}}

release TAG:
	npx sqd squid:release snek@{{TAG}}

kill TAG:
	npx sqd squid:kill "snek@{{TAG}}"

exec:
	docker exec -it snek-db-1 psql -U postgres -d squid

update-deps:
	npx taze