#!/usr/bin/env bash

function caller_fn() {
    # get the list of function
    fn_list=$(fd -e ts . helpers | rg Caller | xargs rg -I -e "export function" | sort)
    # remove duplicated spaces
    fn_list=$(echo "$fn_list" | sed 's/  / /g')
    # remove coins: u64
    fn_list=$(echo "$fn_list" | sed 's/, coins: u64//g')

    echo "$fn_list"
}

function exported_fn() {
    cat ../as/toasts/test_sc/assembly/contracts/main.ts | rg -e "^export function" | sort
}

exported=$(exported_fn)
caller=$(caller_fn)

echo "### Functions that have correctly been exported ###"
comm -1 -2 <(echo -e "$exported") <(echo -e "$caller") | sed 's/^/    /g'

echo ""
echo "### Functions exported with errors ###"
delta <(echo -e "$exported") <(echo -e "$caller")
# if delta is not installed use diff
if [ $? -eq 127 ]; then
    diff -y --suppress-common-lines <(echo -e "$exported") <(echo -e "$caller")
fi
