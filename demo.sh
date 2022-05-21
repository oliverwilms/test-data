#!/bin/bash

function random_number() {

  printf "%0$1g" $(( $RANDOM % $2 +1))
}

if [ -z "$2" ]; then 
    echo "Usage:  foo.sh (# of files to generate) [transaction date YYYYMMDD] [output folder]"
    exit    
fi

### get date/time 

if [ $2 == "random" ]; then

  ### put code here to random date
  NEW_TRANSACTION_DATE="2020"$(random_number 2 12)$(random_number 2 31)
  #NEW_TRANSACTION_DATE=$(random_number 4 2019)$(random_number 2 12)$(random_number 2 31)
  NEW_DD2_DATE="DD2^"${NEW_TRANSACTION_DATE:4:2}"^"${NEW_TRANSACTION_DATE:6:2}"^"${NEW_TRANSACTION_DATE:2:2}

else

  NEW_TRANSACTION_DATE=$2
  NEW_DD2_DATE="DD2^"${NEW_TRANSACTION_DATE:4:2}"^"${NEW_TRANSACTION_DATE:6:2}"^"${NEW_TRANSACTION_DATE:2:2}

fi
