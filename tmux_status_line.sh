#!/bin/bash
export TMUX_STATUS_LINE_DIR="$(dirname $0)"

source ${TMUX_STATUS_LINE_DIR}/utils/helpers.sh
source ${TMUX_STATUS_LINE_DIR}/utils/math.sh
source ${TMUX_STATUS_LINE_DIR}/utils/shell.sh
source ${TMUX_STATUS_LINE_DIR}/segments/cpu.sh

run_segment
