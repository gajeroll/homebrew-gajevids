

# homebrew-gajevids

Homebrew tap for `gajevids` - YAML-based FFmpeg video composition tool.

GitHub: https://github.com/gajeroll/homebrew-gajevids

## Installation

```bash
# Add the tap
brew tap gajeroll/gajevids

# Install gajevids
brew install gajevids
```

## Usage

After installation, you can use `gajevids` from anywhere:

```bash
# Create example configuration
gajevids --example

# Process videos
gajevids config.yml

# Show help
gajevids --help
```

## What is gajevids?

gajevids is a command-line tool that automatically composes multiple videos using YAML configuration files. Define video combinations and transitions with simple configuration files.

### Features

- **Simple YAML Configuration** - Intuitive configuration files
- **Automatic Calculation** - Automatically calculates video duration and start times
- **Rich Transitions** - Fade, dissolve, slide, and more
- **Default Transitions** - Automatically inserts transitions when not specified
- **Fast Execution** - Supports both Go binary and Bash script implementations
- **Cross-platform** - Works on macOS, Linux, and Windows (WSL)

## Dependencies

This formula automatically installs the required dependencies:

- `ffmpeg` - Video processing
- `yq` - YAML processing
- `go` - For building the Go binary

## Example Configuration

```yaml
output: "output.mp4"
fps: 30
resolution: "1280x720"

videos:
  intro: "intro.mp4"
  main: "main_content.mp4"
  outro: "outro.mp4"

transitions:
  fade:
    type: fadeblack
    duration: 0.5
  dissolve:
    type: dissolve
    duration: 1.0

default_transition: fade

timeline:
  - video: intro
  - transition: dissolve
  - video: main
  - video: outro
```

## License

MIT License
