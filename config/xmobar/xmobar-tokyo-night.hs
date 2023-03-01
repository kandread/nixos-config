Config {
  font = "Roboto Mono Nerd Font 18"
  , additionalFonts = [ "FontAwesome 16"
                      ]
  , bgColor      = "#1a1b26"
  , fgColor      = "#a9b1d6"
  , position     = TopSize L 100 40
  , lowerOnStart = False
  , hideOnStart  = False
  , overrideRedirect = False
  , allDesktops  = True
  , persistent   = True
  , iconRoot = ".config/xmobar/icons/"
  , commands = [ Run Com "uname" ["-r"] "" -1
               -- , Run Com "echo" ["<fn=2>\xf0aa</fn>"] "up" 3600
               , Run Com "echo" ["<fn=2>\xf11c</fn>"] "keyicon" 3600
               , Run Com "echo" ["<fc=#777777><fn=2>\xf053</fn></fc>"] "sep" 10000
               , Run Date "<fc=#73daca><fc=#777777><fn=2>\xf053</fn></fc> <fn=2>\xf073</fn> %a %d.%m.%y </fc>" "date"  100000
               , Run Date "<fc=#7dcfff><fc=#777777><fn=2>\xf053</fn></fc> <fn=2>\xf017</fn> %H:%M:%S</fc>" "time"  10
               , Run Memory ["-t", "<fc=#b4f9f8><fn=2>\xf233</fn> <used>M (<usedratio>%)</fc>"] 20
               , Run Com ".config/xmobar/scripts/trayer-padding-icon.sh" [] "trayerpad" 20
               , Run Network "wlo1" ["-t", "<fn=2>\xf1eb</fn> <rx>kb <fn=2>\xf063</fn><fn=2>\xf062</fn> <tx>kb"] 20
               , Run Cpu [ "--template", "<fc=#2ac3de><fn=2>\xf2db</fn> <total>%</fc>"
                         , "--Low","3"
                         , "--High","50"
                         , "--low","#2ac3de"
                         , "--normal","#3bc3de"
                         , "--high","#f7768e"] 50
               , Run Com "bash" [".config/xmobar/scripts/keyboard"] "keyboard" 5
               , Run Com "bash" [".config/xmobar/scripts/volume"] "volume" 1
               , Run UnsafeStdinReader
               ]
  , sepChar = "%"
  , alignSep = "}{"
  , template = " <action=`kitty`><icon=haskell_20.xpm/></action> <fc=#777777>|</fc> %UnsafeStdinReader%}{ <fc=#a9b1d6>%wlo1%</fc> <fc=#7aa2f7>%sep% <action=`pamixer -t`><action=`pamixer -i 5` button=4><action=`pamixer -d 5` button=5>%volume%</action></action></action></fc> <fc=#cfc9c2>%sep%<action=`(setxkbmap -query | grep -q 'layout:\s\+us') && setxkbmap gr || setxkbmap us`>%keyicon% %keyboard%</action></fc> %date% %time% <fc=#777777>%sep%</fc>%trayerpad%"
      }
