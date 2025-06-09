dev:
	uv run services/trades/src/trades/main.py

build:
	docker build -t trades:dev -f docker/trades_multistage.Dockerfile .


deploy:
	kubectl delete -f deployments/dev/trades/trades.yaml
	kubectl apply -f deployments/dev/trades/trades.yaml

