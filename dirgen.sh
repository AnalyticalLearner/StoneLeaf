#!/bin/bash

# Create directories from 00 to 99
for i in {0..99}; do
    top_dir=$(printf "%02d" "$i")
    mkdir -p "$top_dir"

    # Create subdirectories named XX.YY inside XX
    for j in {0..99}; do
        sub_dir=$(printf "%02d" "$j")
        mkdir -p "$top_dir/${top_dir}.${sub_dir}"
    done
done
