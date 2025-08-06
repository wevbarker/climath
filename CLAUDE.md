# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NoMoreNotebooks is a Wolfram Language package that provides a programmatic interface to Mathematica/Wolfram notebooks. It allows running Mathematica code through a FrontEnd connection while maintaining control over notebook creation, evaluation, and output.

## Installation and Setup

```bash
# Install the package to Wolfram/Mathematica Applications directories
./install.sh
```

The installer uses rsync to copy the package to both `~/.Wolfram/Applications/` and `~/.Mathematica/Applications/` directories.

## Core Architecture

The package consists of:
- **NoMoreNotebooks.m**: Main package file containing all functionality
- **Kernel/init.wl**: Package loader that imports the main module
- **Logo.txt**: ASCII art displayed when the package loads

### Key Components

- **Package Structure**: Uses standard Wolfram Language package format with `BeginPackage` and context management
- **FrontEnd Integration**: Connects to Mathematica FrontEnd to create and manipulate notebooks programmatically
- **Version Handling**: Adapts behavior based on `$VersionNumber` (<=14 vs >14) for different Mathematica versions

## Main Functions

- `Ignite[]`: Establishes FrontEnd connection and creates a target notebook with dark theme
- `Douse[]`: Closes the target notebook
- `Burn[filename]`: Loads and executes a .m file in the notebook, saves as .nb
- `Smother[]`: Aborts current evaluation
- `Singe[filename]`: Prints/exports the notebook to a file
- `VimJ[]`: Navigation helper (moves to next cell)

## Configuration Variables

- `$NonInteractive`: Controls interactive vs batch mode behavior
- `$TargetKernelName`: Kernel name for evaluation ("NoMoreNotebooks")
- `$FrontEndLaunchCommand`: Version-specific command for launching FrontEnd
- `$DeletePauseTime`: Delay time for cell deletion operations (10 seconds)

## Development Notes

- The package requires a running Mathematica/Wolfram installation
- FrontEnd connection is essential for all notebook operations
- Version 14+ uses `wolframnb` instead of `mathematica` for FrontEnd launch
- Interactive mode includes pauses and user feedback; non-interactive mode waits for file operations to complete