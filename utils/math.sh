#!/bin/bash

# $1: divide, $2: by
divide_ceil() {
  return $((($1 + $2 - 1) / $2))
}
