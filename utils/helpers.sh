#!/bin/bash
format_print() {
  if [[ -n $3 ]]; then
    echo -n "#[fg=$2 bg=$3]"
  else
    echo -n "#[fg=$2]"
  fi
  echo -n $1
}
separator() {
  echo -n " "
}
