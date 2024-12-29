#!/bin/sh

set -eu

message_id=$(cat)

curl "https://commitfest.postgresql.org/search/?searchterm=$message_id" \
    --HEAD -o /dev/null --silent --write-out '%{redirect_url}' |
    sed 's=https://commitfest.postgresql.org/patch/\(.\+\)/=https://github.com/postgresql-cfbot/postgresql/compare/cf/\1~1..cf/\1='
