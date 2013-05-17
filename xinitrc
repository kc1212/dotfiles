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

xrdb -merge ~/.Xresources &       # update x resources db

# my sessions: xmonad || openbox-session || gnome-session-cinnamon
# || gnome-session || startxfce4
mySession="xmonad"

if [ "$mySession" == "xmonad" ]; then
  xsetroot -cursor_name left_ptr &  # sets the cursor icon
  xset m 1 0 &                      # set mouse accelecation and threshold
  sh ~/.fehbg &                     # sets the background image
  volumeicon &                      # start volume icon

  trayer --edge top --align right --SetDockType true --SetPartialStrut true \
   --expand true --width 10 --transparent true --tint 0x000000 --height 12 &

  ibus-daemon -rxvd &               # start input daemon
  dropboxd &                        # start dropbox daemon
  xscreensaver -no-splash &         # start screensaver daemon
  # urxvtd &                          # terminal daemon, launch using urxvtc
  # conky -d -c ~/.conky/conkyrc &    # some fancy conky shit

  if [ -x /usr/bin/nm-applet ] ; then
     nm-applet --sm-disable &
  fi

  if [ -x /usr/bin/gnome-power-manager ] ; then
     sleep 3
     gnome-power-manager &
  fi

elif [ "$mySession" == "openbox-session" ]; then
  # sh ~/.fehbg &                     # sets the background image
  conky -d -c ~/.conky/conkyrc &
  # openbox automatically starts xscreensaver

else
  echo "another session!"

fi

exec $mySession

