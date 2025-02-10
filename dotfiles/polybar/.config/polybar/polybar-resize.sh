#!/bin/bash
i3-msg -t subscribe '[ "mode" ]' | while read -r line; do
    if [[ $line == *"resize"* ]]; then
        polybar-msg hook mode 2
    else
        polybar-msg hook mode 1
    fi
done

