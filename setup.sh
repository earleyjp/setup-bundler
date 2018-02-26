#!/bin/bash

# Rbenvのインストール
hash rbenv > /dev/null 2>&1 || {
  echo "Not installed rbenv."
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
}
ls  ~/.rbenv/plugins/ruby-build > /dev/null 2>&1 || {
  echo "Not installed ruby-build."
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
}
RBENV_COMMNET="Add rbenv"
grep "${RBENV_COMMNET}" ~/.bash_profile > /dev/null 2>&1 || {
  echo "Add rbenv path."
  echo >> ~/.bash_profile
  echo "# ${RBENV_COMMNET}" >>  ~/.bash_profile
  echo "export PATH=\"${HOME}/.rbenv/bin:${PATH}\"" >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
}
cd
source ~/.bash_profile
cd - > /dev/null 2>&1

rbenv versions | grep " 2.5.0 " > /dev/null 2>&1 || {
  echo "Not installed Ruby 2.5.0"
  rbenv install 2.5.0 && rbenv global 2.5.0
  rbenv rehash
}

# Bundlerのインストール
hash bundler > /dev/null 2>&1 || {
  echo "Not installed Bundler"
  rbenv exec gem install bundler
}
bundler -v 2> /dev/null || {
  echo "Version unmatch bundler"
  rbenv exec gem install bundler
}

echo "Install completed."
