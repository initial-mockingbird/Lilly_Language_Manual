#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

nohup mdbook serve --open &
echo "$!" >> .serve_pids
