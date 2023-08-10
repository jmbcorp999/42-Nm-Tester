#!/bin/bash

# Note: It is expected to have differences in error messages in win32/64 files!
# The objective only requires handling ELF 32/64 files and not PE files!
# Hence, we consider the message "file format not recognized" correct for PE files.
# The true NM displays a different message, depending on the file.

export LANG=en_US.UTF-8

echo "---------------------------------------------------------------------" | stdbuf -o0 cat
echo "Tests in progress... (this might take a few minutes)"
echo "---------------------------------------------------------------------" | stdbuf -o0 cat

exec 2>/dev/null

> segfaults.txt
> ok.txt
> diff_content.txt
> diff_errormsg.txt
> results.txt

find exemple_files -type f | while read file; do
    echo "Testing $file"
    ./ft_nm "$file" &> ft_nm_output.txt
    nm "$file" &> nm_output.txt

    if ! [ -s ft_nm_output.txt ]; then
        echo "$file" >> segfaults.txt
		continue
    fi

diff ft_nm_output.txt nm_output.txt > temp_diff.txt

    if [ -s temp_diff.txt ]; then
        num_lines=$(cat temp_diff.txt | grep -- ">" | wc -l)
        filename=$(basename "$file")
        if [[ $filename == pe-* ]] && [ "$num_lines" -le 3 ]; then
            echo "$file" >> ok.txt
        elif [[ $filename != pe-* ]] && [ "$num_lines" -le 2 ]; then
            echo "$file" >> diff_errormsg.txt
            cat temp_diff.txt >> diff_errormsg.txt
            echo "---------------------------------------------------------------------" >> diff_errormsg.txt
        else
            echo "$file" >> diff_content.txt
            cat temp_diff.txt >> diff_content.txt
            echo "---------------------------------------------------------------------" >> diff_content.txt
        fi
    else
        echo "$file" >> ok.txt
    fi

done

# Delete temporary files.
rm ft_nm_output.txt nm_output.txt temp_diff.txt

OK=$(cat ok.txt | wc -l)
DIFF_CONTENT=$(cat diff_content.txt | grep -- "---------------------------------------------------------------------" | wc -l)
DIFF_ERROR_MSG=$(cat diff_errormsg.txt | grep -- "---------------------------------------------------------------------" | wc -l)
SEGFAULTS=$(cat segfaults.txt | wc -l)

{
    echo "---------------------------------------------------------------------"
    echo "Files tested: " $((OK + DIFF_CONTENT + DIFF_ERROR_MSG + SEGFAULTS))
    echo "---------------------------------------------------------------------"
    echo "Files OK: " $OK
    cat ok.txt
    echo "---------------------------------------------------------------------"
    echo "Files with different content: " $DIFF_CONTENT
    cat diff_content.txt | grep -v "<" | grep "exemple_files"
    echo "---------------------------------------------------------------------"
    echo "Files with different error message: " $DIFF_ERROR_MSG
    cat diff_errormsg.txt | grep -v "<" | grep -v ">" | grep -v "bfd plugin: exemple_files" | grep "exemple_files"
    echo "---------------------------------------------------------------------"
    echo "Files causing segfault: " $SEGFAULTS
    cat segfaults.txt
    echo "---------------------------------------------------------------------"
} | tee results.txt
