# Kibishi (厳しい)

A macOS application that displays impossible-to-ignore full-screen calendar notifications.

## About

Kibishi means "strict" or "severe" in Japanese. This application is designed to help people with concentration issues by providing calendar notifications that take over the entire screen, making them impossible to miss or ignore.

## Features

- Full-screen calendar notifications
- Integration with macOS Calendar
- Impossible to dismiss accidentally
- Helps improve meeting attendance
- Native macOS application built with Swift

## Requirements

- macOS 10.15 or later
- Swift 6.1 or later

## Building

```bash
# Build in debug mode
make build

# Build in release mode
make release

# Build and run
make run

# Clean build artifacts
make clean

# Run tests
make test

# Show all available commands
make help
```

## Development

This project uses Swift Package Manager. The main executable is defined in `Sources/main.swift`.

### Project Structure

```
kibishi/
├── Sources/
│   └── main.swift          # Main application entry point
├── Package.swift           # Swift Package Manager configuration
├── Makefile               # Build automation
├── CLAUDE.md              # Project context and decisions
└── README.md              # This file
```

## License

Open source project - license to be determined.

## Contributing

This is an early-stage project. Contributions and suggestions are welcome.