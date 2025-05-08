#!/usr/bin/env bash
read -p "query: " query
tmux neww bash -c "curl -s cht.sh/c/`echo $query | tr ' ' '+'` | less -R"
