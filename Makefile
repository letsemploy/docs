clean:
	rm -rf site
	find . -name '__pycache__' -exec rm -fr {} + || true

install:
	uv sync

update:
	uv lock --upgrade
	uv sync

run:
	uv run mkdocs serve -w docs

build:
	uv run mkdocs build --strict

docs-publish:
	uv run mkdocs gh-deploy
