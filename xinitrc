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

# set keyboad layout
# setxkbmap -layout us

# my sessions: xmonad || openbox-session || gnome-session-cinnamon
# || gnome-session || startxfce4
mySession="xmonad"

if [ "$mySession" == "xmonad" ]; then
  xrdb -merge ~/.Xresources &       # update x resources db
  xscreensaver -no-splash &         # starts screensaver daemon 
  xsetroot -cursor_name left_ptr &  # sets the cursor icon
  sh ~/.fehbg &                     # sets the background image
  dropboxd &                        # start dropbox daemon
  # trayer --edge top --align right --margin 0 --width 108 --widthtype pixel --height 12 \
  #     --padding 1 --tint 0x000000 --transparent true & # set  trayer
  trayer --edge top --align right --SetDockType true --SetPartialStrut true \
   --expand true --width 10 --transparent true --tint 0x000000 --height 12 &
  conky -d -c ~/.conky/conkyrc &

elif [ "$mySession" == "openbox-session" ]; then
  xrdb -merge ~/.Xresources &       # update x resources db
  sh ~/.fehbg &                     # sets the background image
  (sleep 10 && conky -d -c ~/.conky/conkyrc) &
  # openbox automatically starts xscreensaver

else
  echo "invalid session!"

fi

exec $mySession

