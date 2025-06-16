dev:
	uv run services/${service}/src/${service}/main.py

build:
	docker build -t ${service}:dev -f docker/${service}_multistage.Dockerfile .


deploy:
	kubectl delete -f deployments/dev/trades/trades.yaml
	kubectl apply -f deployments/dev/trades/trades.yaml

lint:
	ruff check . --fix

format:
	ruff format .

