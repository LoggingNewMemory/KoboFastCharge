LATESTARTSERVICE=true

ui_print "🗡--------------------------------🗡"
ui_print "           Kobo Fast Charge         " 
ui_print "🗡--------------------------------🗡"
ui_print "         By: Kanagawa Yamada        "
ui_print "------------------------------------"
ui_print "      READ THE TELEGRAM MESSAGE     "
ui_print "------------------------------------"
ui_print " "
sleep 1.5

ui_print "-----------------📱-----------------"
ui_print "            DEVICE INFO             "
ui_print "-----------------📱-----------------"
ui_print "DEVICE : $(getprop ro.build.product) "
ui_print "MODEL : $(getprop ro.product.model) "
ui_print "MANUFACTURE : $(getprop ro.product.system.manufacturer) "
ui_print "PROC : $(getprop ro.product.board) "
ui_print "CPU : $(getprop ro.hardware) "
ui_print "ANDROID VER : $(getprop ro.build.version.release) "
ui_print "KERNEL : $(uname -r) "
ui_print "RAM : $(free | grep Mem |  awk '{print $2}') "
ui_print " "
sleep 1.5

ui_print "-----------------🗡-----------------"
ui_print "            MODULE INFO             "
ui_print "-----------------🗡-----------------"
ui_print "Name : Kobo Fast Charge"
ui_print "Version : V 3.0"
ui_print "Support Root : Magisk / KernelSU / APatch"
ui_print " "
sleep 1.5

ui_print "      INSTALLING KOBO KANAERU       "
ui_print " "
sleep 1.5

unzip -o "$ZIPFILE" 'KoboKanaeru/*' -d $MODPATH >&2
set_perm_recursive $MODPATH/KoboKanaeru 0 0 0774 0774

sleep 1.5

am start -a android.intent.action.VIEW -d https://t.me/KanagawaLabAnnouncement/290 >/dev/null 2>&1
