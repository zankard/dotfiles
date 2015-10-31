#!/bin/bash
format_print() {
  if [[ -n $3 ]]; then
    echo -n "#[fg=colour$2 bg=colour${3}]"
  else
    echo -n "#[fg=colour${2}]"
  fi
  echo -n $1
}
separator() {
  echo -n " "
}
