#!/bin/bash

# Check if there is an argument, if not we print usage help
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_bash_script.sh>"
    exit 1
fi

# Check if gcc is installed
if ! command -v gcc &> /dev/null; then
    echo "Error: gcc is not installed on this system"
    exit 1
fi

data_file="bash_script_data"
hex_file="bash_script_hex.c"
c_file="script_launcher.c"

bash_script_file="$1"
executable_name=$(basename "$bash_script_file" .sh)

# Transform the bash script in hex to include in C code
cat "$bash_script_file" > "$data_file"
xxd -i "$data_file" > "$hex_file"

# The C code
cat > "$c_file" <<EOL
#include <stdio.h>
#include <stdlib.h>

#include "bash_script_hex.c"

int main() {
    // Check if Bash is installed on the system
    if (system("which bash > /dev/null") != 0) {
        fprintf(stderr, "Error: bash is not installed on this system\n");
        return 1;
    }

    // Create a process to execute Bash
    FILE *fp = popen("bash", "w");
    if (!fp) {
        fprintf(stderr, "Error while opening pipe to bash\n");
        return 1;
    }

    // Write the script content to stdin
    fwrite(bash_script_data, 1, bash_script_data_len, fp);

    // Close the process
    pclose(fp);

    return 0;
}
EOL

mkdir -p bin

# C code compile
gcc "$c_file" -O3 -o "bin/$executable_name"

# Check if everything was fine
if [ $? -eq 0 ]; then
    echo "Compilation ✅"
    echo "Launch the compiled file: ./bin/$executable_name"
else
    echo "Error during compilation"
fi

# Cleaning
rm $c_file $data_file $hex_file
