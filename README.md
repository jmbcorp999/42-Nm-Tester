# 42-NM_Tester
This script is designed to compare the output of the ft_nm command with the standard nm command on ELF 32/64 files.

##Requirements
Ensure you have the stdbuf utility installed on your system.
Place the ELF 32/64 files you wish to test inside an exemple_files directory.

----

## Usage
1. Clone the repository
``git clone (https://github.com/jmbcorp999/42-Nm-Tester)``
<br>
2. Copy your executable **ft_nm** inside the tester directory
<br>
3. Navigate to the repository directory
``cd 42-Nm-Tester``
<br>
4. Give execution permissions to the scripts
``chmod +x tester_unique.sh``
``chmod +x tester_bash.sh``
<br>
5. Run the script (only one test)
``./tester_unique.sh [FILE_TO_TEST]``
For testing only one specific file.
<br>
6. Run the script (bach tests)
``./tester_bash.sh``
For testing all the files inside the exemple_files directory (67 are allready present inside, in two subfolders good_files and bad_files)
After running the script, it will process each file inside the example_files directory, comparing the output of ./ft_nm with the standard nm command. Results are saved in the results.txt file.

----

## Interpreting the Output
The script categorizes its results into:

**Files that are OK**: These files do not show any significant difference between the two commands' outputs (see ok.txt for details).

**Files with different content**: These files had some differences in the main content of the output (see diff_content.txt for details).

**Files with different error messages**: These are the files for which the error messages (if any) were different between the two commands' outputs (see diff_errormsg.txt for details).

**Files causing segfault**: These are the files that caused the ft_nm command to crash or segfault (see segfaults.txt for details).

**For a detailed breakdown, check the results.txt file after the script runs (same as the prompt output).**

----

**Tested with Ubuntu 23.04 / GNU nm (GNU Binutils for Ubuntu) 2.40**

----

## Usefull ressources for the project :
https://own2pwn.fr/elf-intro (french)
https://sourceware.org/binutils/docs/binutils/nm.html
https://medium.com/obscure-system/symbolism-in-nm-4af02e425710
https://docs.oracle.com/cd/E19120-01/open.solaris/819-0690/chapter6-1238/index.html
https://docs.oracle.com/cd/E19120-01/open.solaris/819-0690/chapter6-46512/index.html

