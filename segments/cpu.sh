#!bin/bash

run_segment() {
  if shell_is_linux; then
    cpu_line=$(top -b -n 1 | grep "Cpu(s)" )
    cpu_idle=$(echo "$cpu_line" | grep -Po "(\d+(.\d+)?)(?=%?\s?(id(le)?))")
  elif shell_is_osx; then
    cpus_line=$(top -e -l 1 | grep "CPU usage:" | sed 's/CPU usage: //')
    cpu_idle=$(echo "$cpus_line" | awk '{print $5}'  | sed 's/%//' )
  fi

  if [ -n "$cpu_idle" ]; then
    busy=$(printf "%.0f" $((100-$cpu_idle)))
    $(divide_ceil $busy 10)
    p=$?
    format_print $(printf '%.0s' $(seq 1 $((10-$p)))) 233
    format_print $(printf '%.0s' $(seq 1 $p)) 2
    separator
    return 0
  else
    return 1
  fi
}

