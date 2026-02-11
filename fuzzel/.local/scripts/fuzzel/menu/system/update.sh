#!/usr/bin/env bash

$TERMINAL --class "pop-up-terminal" sh -c "yay --diffmenu=false --cleanmenu=false --editmenu=false -Syu --noconfirm; echo 'Done! Press Enter...'; read"
