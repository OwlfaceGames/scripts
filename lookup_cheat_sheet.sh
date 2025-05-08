
#!/usr/bin/env bash
languages=`echo "golang lua cpp c typescript nodejs" | tr ' ' '\n'`
core_utils=`echo "xargs find mv sed awk" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read -p "query: " query

if printf "$languages\n" | grep -q "^$selected$"; then
    tmux neww bash -c "curl -s cht.sh/$selected/`echo $query | tr ' ' '+'` | less -R"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less -R"
fi

