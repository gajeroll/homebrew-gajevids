# homebrew-gajevids

Homebrew tap for `gajevids` - YAML-based FFmpeg video composition tool.

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

## Example Configuration

<!-- start example_gajevids.yml -->

```yaml
# gajevids configuration example (v0)

# Schema version (default is 0 if omitted)
version: 0

# [Required]
# Output video path
output: "output.mp4"

# Frame rate (defaults to 30)
fps: 24

# Resolution (defaults to 1280x720)
resolution:
  w: 1280
  h: 720

# [Required]
# Video source files
videos:
  intro: "intro.mp4"
  main: "main_content.mp4"
  outro: "outro.mp4"

# [Required]
# Transition definitions
transitions:
  fade:
    type: fadeblack
    duration: 0.5
  slide:
    type: slideleft
    duration: 1.0
  fancy:
    type: zoomin
    duration: 0.8

# [Required]
# Default transition when none specified
default_transition: fade

# [Required]
# Timeline - sequence of videos and transitions
timeline:
  - video: intro
  - transition: fancy
  - video: main
  - transition: slide
  - video: outro
```

<!-- end example_gajevids.yml -->


## License

MIT License
