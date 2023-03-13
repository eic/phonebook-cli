#!/bin/bash

IDS=$( curl -s "https://phonebook.sdcc.bnl.gov/eic/service/index.php?q=/service/search/object:members/type:combined/keyword:{$1}/autocomplete:no" | jq -r -c '.[] | .members_id ' )

for i in $IDS
do
    URL="https://phonebook.sdcc.bnl.gov/eic/service/index.php/?q=/members/get/id:$i"
    DATA=$( curl -s "https://phonebook.sdcc.bnl.gov/eic/service/index.php/?q=/members/get/id:$i" | jq -r -c '.fields | ."1",."3",."20"' )
    echo $i $DATA
done
