#!/bin/sh

set -e

if [ $# -eq 0 ]; then
   echo "$0: no input files"
   exit 1
fi

for target in "$@"; do
    VARS=`grep -oe '${[A-z0-9_][A-z0-9_]*}' $target | cut -d'{' -f 2 | cut -d'}' -f 1`
    for var in $VARS; do
        VALUE=$(eval "echo \${$var-%UNDEF%} | sed -e 's/[\\/&]/\\\\&/g'")
        if [ "$VALUE" = "%UNDEF%" ]; then
            echo "$0: $target: $var is undefined"
            exit 1
        fi
        sed -i 's/\${'"$var"'}/'"$VALUE"'/g' $target
    done
done
