#!/bin/bash

# Test case array
declare -a test
COUNT=0

# Read test case from test file 
while IFS='' read -r line || [[ -n "$line" ]]; do
  test["$COUNT"]=$line
  let COUNT=COUNT+1
done < "test"

if [ "$#" == 0 ];then
  echo "Need folder name"
  exit 1
elif [ -d "$1" ];then

  cd $1
  # make a grade folder
  if [ ! -d ../'_'$1'_g' ];then
    mkdir ../'_'$1'_g'
  fi

  for i in $(ls);do
    if [ -d $i ];then
      cd $i
      # make grade file for a student
      rm ../*.txt
      FILENAME='../_'$i'.txt'
      touch $FILENAME

      for j in $(ls);do
        if [ "${j:0:1}" != "_" ]; then
          PRO=0
          rm -f ./a.out
          # print python code
          echo '>'$1' for '$FILENAME | tee -a $FILENAME
          cat -n $j | tee -a $FILENAME

          echo -e "\n" | g++ $j 2>&1 | tee -a $FILENAME

	        for k in "${test[@]}";do
            if [ "${k:0:1}" == "#" ]; then
	              PRO=${k:1:2}
            elif [[ "$j" == *"$PRO"* ]];then
                # execute python code here
                echo -e "\n" | tee -a $FILENAME
                echo "Test Case: "$k | tee -a $FILENAME
                echo -e $k | ./a.out 2>&1 | tee -a $FILENAME
            fi
	        done
          rm -f ./a.out
          echo -e "\n" | tee -a $FILENAME
        fi
      done
      mv $FILENAME ../../'_'$1'_g'
      cd ..
    fi
  done
fi