#!/bin/bash

source ./utils/shell.sh

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

if shell_is_linux; then
  [[ ! -d ~/.config/fontsconfig/conf.d ]] && mkdir -p ~/.config/fontconfig/conf.d
  [[ ! -d ~/.fonts ]] && mkdir -p ~/.fonts
  dir=`mktemp -d`
  git clone https://github.com/gabrielelana/awesome-terminal-fonts.git $dir
  cp -f $dir/build/*.ttf ~/.fonts
  cp -f $dir/build/*.sh ~/.fonts
  cp -f $dir/config/10-symbols.conf ~/.config/fontconfig/conf.d
  sed -i -e "s/PragmataPro/Sauce Code Powerline/g" ~/.config/fontconfig/conf.d/10-symbols.conf
  rm -r $dir

  dir_pwl_patched=`mktemp -d`
  git clone https://github.com/powerline/fonts.git $dir_pwl_patched
  cp -f $dir_pwl_patched/SourceCodePro/*.otf ~/.fonts
  rm -r $dir_pwl_patched
  fc-cache -fv ~/.fonts
elif [[ shell_is_osx && ! -f $HOME/Library/Fonts/Sauce\ Code\ Powerline\ Plus\ Nerd\ File\ Types\ Plus\ Font\ Awesome.otf ]]
then
  curl -o $HOME/Library/Fonts/Sauce\ Code\ Powerline\ Plus\ Nerd\ File\ Types\ Plus\ Font\ Awesome.otf https://cdn.rawgit.com/ryanoasis/nerd-fonts/master/patched-fonts/SourceCodePro/Regular/Sauce%20Code%20Powerline%20Plus%20Nerd%20File%20Types%20Plus%20Font%20Awesome.otf
fi

cp tmux.conf ~/.tmux.conf
if [ ! -d ~/.tmux.d ];
then
  mkdir -p ~/.tmux.d
fi
cp tmux_status_line.sh ~/.tmux.d/tmux_status_line.sh
cp -r segments ~/.tmux.d
cp -r utils ~/.tmux.d
