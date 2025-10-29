.PHONY: help install install-dev setup test lint format clean docker-build docker-up run-pipeline run-dashboard

help:
	@echo "Available commands:"
	@echo "  make install        - Install production dependencies"
	@echo "  make install-dev    - Install development dependencies"
	@echo "  make setup          - Initialize project (DB, auth, etc.)"
	@echo "  make test           - Run tests"
	@echo "  make lint           - Run linters"
	@echo "  make format         - Format code"
	@echo "  make clean          - Clean temporary files"
	@echo "  make docker-build   - Build Docker image"
	@echo "  make docker-up      - Start Docker containers"
	@echo "  make run-pipeline   - Run data pipeline"
	@echo "  make run-dashboard  - Start Streamlit dashboard"

install:
	pip install -r requirements.txt

install-dev:
	pip install -r requirements-dev.txt
	pre-commit install

setup:
	@echo "Initializing database..."
	python config/init_database.py
	@echo "Setup complete! Remember to:"
	@echo "  1. Copy .env.example to .env"
	@echo "  2. Add your API keys to .env"
	@echo "  3. Run: python dlt_pipelines/telegram_auth.py"

test:
	pytest tests/ -v --cov=dlt_pipelines --cov=analysis --cov-report=html
	@echo "Coverage report: htmlcov/index.html"

lint:
	flake8 dlt_pipelines/ analysis/ dagster_project/
	pylint dlt_pipelines/ analysis/ dagster_project/
	mypy dlt_pipelines/ analysis/

format:
	black dlt_pipelines/ analysis/ dagster_project/ tests/
	isort dlt_pipelines/ analysis/ dagster_project/ tests/

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".mypy_cache" -exec rm -rf {} +
	rm -rf build/ dist/ htmlcov/ .coverage

docker-build:
	docker build -t conflict-monitor:latest -f docker/Dockerfile .

docker-up:
	docker-compose -f docker/docker-compose.yml up -d

docker-down:
	docker-compose -f docker/docker-compose.yml down

run-pipeline:
	python dlt_pipelines/acled_source.py
	python dlt_pipelines/telegram_source.py

run-dagster:
	cd dagster_project && dagster dev

run-dashboard:
	streamlit run dashboard/app.py

backup-db:
	./scripts/backup_database.sh
