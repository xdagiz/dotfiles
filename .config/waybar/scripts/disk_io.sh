#!/usr/bin/env bash

DEV="sda" # change if your disk is e.g. nvme0n1

# run iostat with JSON, take the *second* snapshot (current throughput)
DATA=$(iostat -d -m -o JSON 1 2)

# extract read/write MB/s for the device
READ=$(echo "$DATA" |
  jq -r --arg d "$DEV" \
    '.sysstat.hosts[0].statistics[1].disk[] 
       | select(.disk_device == $d) 
       | ."MB_read/s"')

WRITE=$(echo "$DATA" |
  jq -r --arg d "$DEV" \
    '.sysstat.hosts[0].statistics[1].disk[] 
       | select(.disk_device == $d) 
       | ."MB_wrtn/s"')

# fallback if jq fails
[ -z "$READ" ] && READ="0"
[ -z "$WRITE" ] && WRITE="0"

# output JSON Waybar understands
# printf "{\"text\":\" ${READ}MB/s  ${WRITE}MB/s\"}"
printf '{"text":" %s MB/s"}' "$READ"
