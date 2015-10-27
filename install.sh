#!/bin/bash
# solarized color schemes
if [ ! -d ~/.solarized ];
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

[[ ! -d ~/.config/fontsconfig/conf.d ]] && mkdir -p ~/.config/fontconfig/conf.d
[[ ! -d ~/.fonts ]] && mkdir -p ~/.fonts
dir=`mktemp -d`
git clone https://github.com/gabrielelana/awesome-terminal-fonts.git $dir
cp -f $dir/build/*.ttf ~/.fonts
cp -f $dir/build/*.sh ~/.fonts
cp -f $dir/config/10-symbols.conf ~/.config/fontconfig/conf.d
sed -i -e "s/PragmataPro/Source Code Pro/g" ~/.config/fontconfig/conf.d/10-symbols.conf
fc-cache -v ~/.fonts

cp tmux.conf ~/.tmux.conf
if [ ! -d ~/.tmux.d ];
then
  mkdir -p ~/.tmux.d
fi
cp tmux_status_line.sh ~/.tmux.d/tmux_status_line.sh
cp -r segments ~/.tmux.d
cp -r utils ~/.tmux.d

