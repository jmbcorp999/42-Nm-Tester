#!/bin/bash

if [ $# -lt 1 ]; then
  echo -e "\nUsage: $0 <filename>"
  exit 1
fi

filename=$1

nm "$filename" > nm_output.txt
./ft_nm "$filename" > ft_nm_output.txt

if diff nm_output.txt ft_nm_output.txt >/dev/null; then
  echo -e "\nDiff OK\n"
  rm nm_output.txt ft_nm_output.txt
else
  echo -e "\nDIFF KO\n"
  diff nm_output.txt ft_nm_output.txt
  rm nm_output.txt ft_nm_output.txt
fi
