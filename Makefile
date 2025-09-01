# Kibishi - Makefile

.PHONY: build run clean debug release test help

# Variables
BINARY_NAME = Kibishi
BUILD_DIR = .build

# Default target
all: build

# Build in debug mode
build:
	@echo "🔨 Building $(BINARY_NAME) (debug)..."
	swift build

# Build in release mode  
release:
	@echo "🔨 Building $(BINARY_NAME) (release)..."
	swift build -c release

# Run the application
run:
	@echo "🚀 Running $(BINARY_NAME)..."
	swift run

# Clean build artifacts
clean:
	@echo "🧹 Cleaning build artifacts..."
	swift package clean

# Debug build and run
debug: build run

# Run tests
test:
	@echo "🧪 Running tests..."
	swift test

# Show help
help:
	@echo "Kibishi - Available commands:"
	@echo "  make build    - Build in debug mode"
	@echo "  make release  - Build in release mode"
	@echo "  make run      - Build and run the application"
	@echo "  make debug    - Build and run in debug mode"
	@echo "  make clean    - Clean build artifacts"
	@echo "  make test     - Run tests"
	@echo "  make help     - Show this help"