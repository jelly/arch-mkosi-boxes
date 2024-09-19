#!/bin/bash

image="${1}"
partition_name="${2}"

echo "$image"

# partition_name="esp"

partitiontable=$(sfdisk -J "${image}")
sectorsize=$(jq -r '.partitiontable.sectorsize' <<< "${partitiontable}")
partition_info=$(sfdisk -J ${image} | jq -r ".partitiontable.partitions[] | select(.name == \"$partition_name\")")
partition_start=$(jq -r '.start' <<< "${partition_info}")
partition_size=$(jq -r '.size' <<< "${partition_info}")

target="${image}-${partition_name}"

dd if="${image}" of="${target}" bs="${sectorsize}" skip="${partition_start}" count="${partition_size}" status=progress
echo "created ${target}"
