clean:
	rm -rf *.egg-info
	rm -rf *.dist-info
	rm -rf dist
	rm -rf build
	find -name '__pycache__' -exec rm -fr {} || true \;

docs-publish:
	mkdocs gh-deploy

update:
	pip install -U pip-tools
	pip-compile -U --no-header --no-annotate --strip-extras --resolver backtracking
	pip-sync

install: update

run:
	mkdocs serve -w docs

schema-doc:
	rm -f docs/implementation/ojobpub-schema.md
	echo "---\nhide:\n- toc\n---" > docs/implementation/ojobpub-schema.md
	jsonschema-markdown --no-footer --resolve ojobpub.json >> docs/implementation/ojobpub-schema.md
