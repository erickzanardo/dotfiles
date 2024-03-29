#!/bin/bash
_dir_chomp () {
  local p=${1/#$HOME/\~} b s
  s=${#p}
  while [[ $p != "${p//\/}" ]]&&(($s>$2))
  do
    p=${p#/}
    [[ $p =~ \.?. ]]
    b=$b/${BASH_REMATCH[0]}
    p=${p#*/}
    ((s=${#b}+${#p}))
  done
  echo ${b/\/~/\~}${b+/}$p
}

function current_arch() {
  local ARCH=$(arch)
  echo $ARCH
}

function ps1_curr_dir() {
  local HERE=$(pwd | sed "s|^$HOME|~|")
  echo $(_dir_chomp "$HERE" 10)
}

function ps1_project_type() {
  local STATUS=""
  local IS_MOBILE=""

  if [ -e "./Gemfile" ]
  then
    STATUS="[]"
  fi

  if [ -e "./package.json" ]
  then
    STATUS="$STATUS["

    if [ -e ".nvmrc" ]
    then
      CURRENT_NODE=$(node --version)
      REQUIRED_NODE=$(nvm_version $(cat .nvmrc))

      if [ "$CURRENT_NODE" !=  "$REQUIRED_NODE" ]
      then
        STATUS="$STATUS "
      fi
    fi
    STATUS="$STATUS]"

    PACKAGE_CONTENT=$(cat package.json)

    REACT=$(echo "$PACKAGE_CONTENT" | grep react)
    if [ -n "$REACT" ]
    then
      STATUS="$STATUS[]"
    fi

    REACT_NATIVE=$(echo "$PACKAGE_CONTENT" | grep react-native)
    if [ -n "$REACT_NATIVE" ]
    then
      IS_MOBILE="true"
    fi

    ELECTRON=$(echo "$PACKAGE_CONTENT" | grep electron)
    if [ -n "$ELECTRON" ]
    then
      STATUS="$STATUS[]"
    fi
  fi

  if [ -e "./bower.json" ]
  then
    STATUS="$STATUS[]"
  fi

  if [ -e "./gulpfile.js" ]
  then
    STATUS="$STATUS[]"
  fi

  if [ -e "./Dockerfile" ]
  then
    STATUS="$STATUS[]"
  fi

  if [ -e "./pom.xml" ]
  then
    STATUS="$STATUS[]"
  fi

  if [ -e "./build.gradle" ]
  then
    STATUS="$STATUS[ﲎ]"
    IS_MOBILE="true"
  fi

  if [ -e "./Podfile" ]
  then
    STATUS="$STATUS[]"
    IS_MOBILE="true"
  fi

  if [ -e "./pubspec.yaml" ]
  then
    STATUS="$STATUS[]"
    FLUTTER=$(cat ./pubspec.yaml | grep flutter)

    if [ -n "$FLUTTER" ]
    then
      IS_MOBILE="true"
    fi
  fi

  if [ -n "$IS_MOBILE" ]
  then
    STATUS="$STATUS[]"
  fi

  echo -e $STATUS
}

function ps1_git() {
  local STATUS=""

  local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ "$branch" != "" ]
  then
    STATUS=" $branch"

    DIFF=$(git status --porcelain)
    if [ "$DIFF" != "" ]
    then
      STATUS="$STATUS*"
    fi
    STATUS=" [$STATUS] "
  fi

  echo -e $STATUS
}

export PS1=$'\[\e[1;32m\]$(current_arch)  \[\e[0;36m\][$(ps1_curr_dir)]\[\e[0;33m\]$(ps1_git)\[\e[0;32m\]$(ps1_project_type)\[\e[0;m\]  '
