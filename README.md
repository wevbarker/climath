![license](https://img.shields.io/github/license/wevbarker/NoMoreNotebooks)
![Mathematica](https://img.shields.io/badge/Mathematica-14.0+-orange.svg)

# _NoMoreNotebooks_: Programmatic Wolfram Notebook Interface
## Version 14.2

- Updated for Wolfram Language 14.2 compatibility
- Added support for both Wolfram and Mathematica FrontEnd commands
- Enhanced non-interactive mode for batch processing

## License

Copyright © 2024 Will Barker

_NoMoreNotebooks_ is distributed as free software under the [GNU General Public License (GPL)](https://www.gnu.org/licenses/gpl-3.0.en.html).

_NoMoreNotebooks_ is provided without warranty, or the implied warranty of merchantibility or fitness for a particular purpose.

If _NoMoreNotebooks_ was useful to your research, please consider citing this work.

## About

_NoMoreNotebooks_ is a software package for _Wolfram_ (formerly _Mathematica_) designed to provide a programmatic interface to Wolfram notebooks. It enables running Wolfram Language code through a FrontEnd connection while maintaining complete control over notebook creation, evaluation, and output generation.

The package allows you to:
- Create and manipulate notebooks programmatically
- Execute Wolfram Language files in notebook environments
- Export notebook contents to various formats
- Control evaluation flow and timing
- Work in both interactive and batch processing modes

## Example: Basic workflow

In a fresh notebook or kernel session, load the package:
```mathematica
<<NoMoreNotebooks`;
```

Establish a FrontEnd connection and create a target notebook:
```mathematica
Ignite[]
```

Load and execute a Wolfram Language file in the notebook:
```mathematica
Burn["myfile.m"]
```

Export the notebook to a file:
```mathematica
Singe["output.pdf"]
```

Close the notebook when finished:
```mathematica
Douse[]
```

## Core Functions

### `Ignite[]`
Establishes a FrontEnd connection and creates a target notebook with dark theme styling. This must be called before any other operations.

### `Burn[filename]`
Loads and executes a `.m` file in the target notebook. The file is evaluated and the results are displayed in the notebook. The corresponding `.nb` file is automatically saved.

### `Douse[]`
Closes the target notebook and cleans up the FrontEnd connection.

### `Singe[filename]`
Exports the current notebook contents to the specified file format (typically PDF).

### `Smother[]`
Aborts the current evaluation in the target notebook.

### `VimJ[]`
Navigation helper that moves to the next cell in the notebook.

## Configuration Variables

The package behavior can be customized through several global variables:

- `$NonInteractive`: Set to `True` for batch processing mode (default: `False`)
- `$TargetKernelName`: Kernel name for evaluation (default: `"NoMoreNotebooks"`)
- `$DeletePauseTime`: Delay time for cell operations in seconds (default: `10`)

## Quickstart

### Requirements

#### Basic hardware requirements

- A multi-core processor (recommended for better performance)
- Sufficient memory for Wolfram Language operations

#### Operating systems

- [_Linux_](https://www.linux.org/) (recommended, tested on various distributions)
- [_macOS_](https://www.apple.com/uk/macos) (supported)
- [_Windows_](https://www.microsoft.com/en-gb/windows?r=1) (supported)

#### Software dependencies

- [_Wolfram_ (formerly _Mathematica_)](https://www.wolfram.com/mathematica/) (required, tested on _Wolfram v 14.2.0.0_)

### Installation

:warning: Note that _Mathematica_ was re-branded as _Wolfram_ on July 31 2024 with the release of _Wolfram v 14.1_. The package automatically detects your version and uses the appropriate commands.

#### Installation via script

1. ***Download.*** Clone or download this repository to your local system.

2. ***Install.*** Run the provided installation script:
```bash
./install.sh
```

This will copy the package to both `~/.Wolfram/Applications/` and `~/.Mathematica/Applications/` directories, ensuring compatibility with both new and legacy installations.

#### Manual installation

Alternatively, you can manually copy the `NoMoreNotebooks/` directory to your Wolfram Applications directory:

**Linux/macOS:**
```bash
cp -r NoMoreNotebooks ~/.Wolfram/Applications/
cp -r NoMoreNotebooks ~/.Mathematica/Applications/  # For legacy versions
```

**Windows:**
Copy the `NoMoreNotebooks/` folder to:
- `C:\Users\[username]\AppData\Roaming\Mathematica\Applications\`
- `C:\Users\[username]\AppData\Roaming\Wolfram\Applications\`

## Version Compatibility

The package automatically adapts to your Wolfram Language version:

- **Version ≤ 14.0**: Uses `mathematica` command for FrontEnd launch
- **Version > 14.0**: Uses `wolframnb` command for FrontEnd launch

## Interactive vs Non-Interactive Modes

**Interactive Mode** (default):
- Provides user feedback and status messages
- Includes timing delays for cell operations
- Suitable for development and testing

**Non-Interactive Mode** (`$NonInteractive = True`):
- Optimized for batch processing
- Minimal output and faster execution
- Waits for file operations to complete automatically

## Use Cases

_NoMoreNotebooks_ is particularly useful for:

- **Batch processing**: Running multiple Wolfram Language files systematically
- **Automated reporting**: Generating formatted notebook outputs programmatically
- **Testing and validation**: Running code in controlled notebook environments
- **Documentation generation**: Creating formatted mathematical documents
- **Educational tools**: Automating notebook creation for teaching materials

## Getting Help

If you encounter issues or have questions:

- Check the function documentation within Wolfram Language using `?FunctionName`
- Ensure your Wolfram installation is properly configured
- Verify that the FrontEnd can be launched from your system
- For bug reports, please include your Wolfram version and operating system details

## Development Notes

- The package requires a functional Wolfram FrontEnd installation
- FrontEnd connection is essential for all notebook operations
- The package handles version differences automatically
- Dark theme styling is applied by default for better visibility
- File operations include automatic saving and cleanup