#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

err_closing=()

grep -v '^#\|^$' .serve_pids > .serve_pids.tmp
mv .serve_pids.tmp .serve_pids

while read -r pid; do
  echo "PID: $pid"
  if ps -p "$pid" > /dev/null
  then
    if kill -n 9 "$pid" > /dev/null
    then
      echo "Process $pid closed successfully"
    else
      err_closing+=("$pid")
      echo "Failed to close process $pid"
    fi
  else
    echo "Process $pid not found"
  fi
done < .serve_pids
echo "" > .serve_pids
printf "%s\n" "${err_closing[@]}" > .serve_pids
