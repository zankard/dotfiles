#!/bin/bash
# solarized color schemes
if [ ! -f ~/.solarized ];
then
  mkdir ~/.solarized
  cd ~/.solarized
  git clone https://github.com/seebi/dircolors-solarized.git
  eval `dircolors ~/.solarized/dircolors-solarized/dircolors.256dark`
  ln -s ~/.solarized/dircolors-solarized/dircolors.256dark ~/.dir_colors

  git clone https://github.com/seebi/tmux-colors-solarized.git
  echo "
  source ~/.solarized/tmux-colors-solarized/tmuxcolors.conf" >> ~/.tmux.conf
fi
