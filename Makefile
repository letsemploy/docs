clean:
	rm -rf site
	find . -name '__pycache__' -exec rm -fr {} + || true

install:
	uv sync

update:
	uv lock --upgrade
	uv sync

run:
	uv run properdocs serve -w docs -a localhost:8001

build:
	uv run properdocs build --strict

docs-publish:
	uv run properdocs gh-deploy
