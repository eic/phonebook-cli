#!/bin/bash

# SPDX-License-Identifier: MIT
# Copyright (C) 2023, Dmitry Arkhipkin, Wouter Deconinck

if [[ $# -lt 1 ]] ; then
    echo "$(basename $0) - Simple command line interface to the EICUG phonebook"
    echo ""
    echo "Usage:  $(basename $0) <name>"
    exit 0
fi

IDS=$( curl -s "https://phonebook.sdcc.bnl.gov/eic/service/index.php?q=/service/search/object:members/type:combined/keyword:{$1}/autocomplete:no" | jq -r -c '.[] | .members_id ' )

for i in $IDS
do
    URL="https://phonebook.sdcc.bnl.gov/eic/service/index.php/?q=/members/get/id:$i"
    DATA=$( curl -s "https://phonebook.sdcc.bnl.gov/eic/service/index.php/?q=/members/get/id:$i" | jq -r -c '.fields | ."1",."3",."20"' )
    echo $i $DATA
done
