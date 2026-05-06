NAME   := kubebox
BINARY := dist/$(NAME)

.PHONY: build install dev clean help

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*##"}; {printf "  %-10s %s\n", $$1, $$2}'

build: ## Build the standalone binary
	uv sync
	uv run python -m PyInstaller --onefile --clean \
		--name $(NAME) \
		--add-data "streamlit_app.py:." \
		--add-data "core:core" \
		--collect-all streamlit \
		--collect-all networkx \
		--collect-all pyvis \
		--copy-metadata streamlit \
		--copy-metadata pyarrow \
		--hidden-import streamlit.web.bootstrap \
		main.py

install: build ## Install binary to /usr/local/bin
	cp $(BINARY) /usr/local/bin/$(NAME)

dev: ## Run without building (development mode)
	uv run python main.py

clean: ## Remove build artifacts
	rm -rf build dist __pycache__ *.spec
