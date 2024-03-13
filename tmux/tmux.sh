#!/bin/bash
cp .tmux ~/ -a
ln -s -f ~/.tmux/.tmux.conf ~/
cp ~/.tmux/.tmux.conf.local ~/
