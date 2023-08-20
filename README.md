# Bash Compiler
An experimental tool designed not for practical necessity but for the sheer joy of seeing if and how it can be done. At its heart, this project embodies the essence of tackling seemingly unnecessary challenges (thus absolutely indispensable) for my insatiable curious mind. 

The main objective to compile a Bash scripts and execute it from a C environment, to understand the underlying process, especially how one can embed third-party files into C code. 💡🛠️
## How it Works
Bash Compiler operates through a three-step process. First, it converts the Bash script into a hexadecimal representation. Then it seamlessly incorporates this representation into a C program. Finally, the C program is compiled into an executable. When this executable runs, it cleverly extracts the embedded Bash script, writes it to a temporary location, and launches it.
## Directory Structure
The project consists of a few key components. The `examples/` directory is where example Bash scripts like `diskspace.sh` and `services.sh` reside. The heart of the operation, `bash-compile.sh`, is located at the root and is responsible for automating the conversion of Bash scripts into executables. Once processed, the executables find their home in the `bin/` directory.
## Usage
To use the Bash Compiler, fire up the `bash-compile.sh` script and pass the path to your Bash script as an argument. Like magic, you will find the generated executable waiting for you in the `bin/` directory. An example command would be:
```
chmod +x bash-compile.sh
./bash-compile.sh examples/diskspace.sh
./bin/diskspace
```
## License
This project proudly dances in the open-source realm under the MIT License. For the nitty-gritty details, do check out the LICENSE file.