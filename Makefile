# Define variables
RUST_WORKSPACE_DIR := pgrx-wasi
CURRENT_DIR := $(shell pwd)
BIN_DIR := $(CURRENT_DIR)/$(RUST_WORKSPACE_DIR)/bin
RUSTUP_SCRIPT := getrust
TOOLCHAIN := nightly

.PHONY: all install_pgrx clean

all: install_pgrx init_pgrx

pull_pgrx: ## pull pgrx submodule
	git submodule update --init --recursive

install_pgrx: pull_pgrx ## Step 2: Install pgrx locally and symlink
	cargo install cargo-local-install --force
	cd $(RUST_WORKSPACE_DIR) && cargo local-install


init_pgrx: install_pgrx ## Step 3: Add cargo-pgrx to PATH and initialize the development environment
	@echo "Initializing development environment once"
	cd $(RUST_WORKSPACE_DIR) && export PATH="$(BIN_DIR):$(PATH)" && cargo pgrx init


clean: ## Clean up rust build (optional)
	@echo "Cleaning up build artifacts"
	cargo clean --manifest-path $(RUST_WORKSPACE_DIR)/Cargo.toml

install_rust: ## Download the Rustup installation script
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o /tmp/rustup
	bash /tmp/rustup -y -t wasm32-unknown-unknown --default-toolchain $(TOOLCHAIN)


rust_addons: install_rust ## Install rust targets and addons
	rustup target add wasm32-unknown-unknown
	rustup target add wasm32-unknown-emscripten
	rustup component add rust-src --toolchain $(TOOLCHAIN)

build_ext_host: ## build extension host
	cd $(RUST_WORKSPACE_DIR)/pgrx-examples/world  && rm -rf target/ && cargo +nightly build --release --verbose --target wasm32-unknown-emscripten


build_ext: build_ext_host
	cd $(RUST_WORKSPACE_DIR)/pgrx-examples/hello-world  && cargo +nightly build -Zbuild-std=core --release --verbose --target wasm32-unknown-unknown --lib

dump_wasm: ## dump the wasm output of hello-world
	/opt/python-wasm-sdk/wasisdk/bin/wasm-objdump -x $(CURRENT_DIR)/$(RUST_WORKSPACE_DIR)/pgrx-examples/hello-world/target/wasm32-unknown-unknown/release/helloworld.wasm