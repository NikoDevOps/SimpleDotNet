#!/bin/bash


FILE="app.js"
LINE=20
WARNING_MESSAGE="Consider using const instead of var"


escape() {
  echo "$1" | sed 's/%/%25/g; s/\r/%0D/g; s/\n/%0A/g; s/:/%3A/g; s/,/%2C/g'
}

ESCAPED_WARNING=$(escape "$WARNING_MESSAGE")

echo "::warning file=$FILE,line=$LINE::$ESCAPED_WARNING"
echo "::warning:: file=$FILE,line=$LINE $ESCAPED_WARNING"
echo "Normal log message"
