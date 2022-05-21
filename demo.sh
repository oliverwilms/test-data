#!/bin/bash

function random_number() {

  printf "%0$1g" $(( $RANDOM % $2 +1))
}

if [ -z "$1" ]; then 
    echo "Usage:  foo.sh (# of files to generate) [transaction date YYYYMMDD] [output folder]"
    exit    
fi
