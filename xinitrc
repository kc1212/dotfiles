# exec startlxde
#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb -merge ~/.Xresources         # update x resources db
xscreensaver -no-splash &         # starts screensaver daemon 
xsetroot -cursor_name left_ptr &  # sets the cursor icon
sh ~/.fehbg &                     # sets the background image

#setup trayer
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
--expand true --width 15 --height 12 --transparent true --tint 0x000000 &

#start dropbox daemon
dropboxd &

# exec gnome-session
# exec startkde
# exec startxfce4
exec xmonad
# exec startlxde
# exec openbox-session

# set keyboad layout
# setxkbmap -layout us
