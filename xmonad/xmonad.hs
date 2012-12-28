import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.Gaps -- try to not use this
import System.IO


myTerminal = "terminator"
myBorderColor = "#00cc00"
myBorderWidth = 2
myModMask = mod4Mask -- Rebind Mod to the Windows key

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        {
        -- layoutHook=avoidStruts $ layoutHook defaultConfig
        -- , manageHook=manageHook defaultConfig <+> manageDocks
        manageHook = manageDocks <+> manageHook defaultConfig
        -- , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , layoutHook = gaps [(U,17)] $ Tall 1 (3/100) (1/2) ||| Full
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = myModMask
        , terminal = myTerminal
        , focusedBorderColor = myBorderColor
        , borderWidth = myBorderWidth
        }

        `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]

