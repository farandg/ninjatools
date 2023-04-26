# CLEANUP_FILE.SH

## Delete Lines Starting with Pattern Script

This script deletes all lines in a file that start with a given pattern. It takes two arguments: the file name and the pattern.

### Prerequisites

- Bash
- sed

### Usage

First, make the script executable:

```bash
chmod +x script_name.sh
```

Then, run the script with the required arguments:

```bash
./cleanup_file.sh <file_name> <pattern>
```
Replace ```file_name``` with the path to the file you want to process, and ```pattern``` with the pattern you want to match at the beginning of lines to be deleted.  

Example:
Removing all commented lines in a python script called ```example.py``` in the same dir.
```bash
./cleanup_file.sh example.py "#"
```


