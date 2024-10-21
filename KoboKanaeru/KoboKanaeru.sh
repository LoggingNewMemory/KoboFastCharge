chmod 644 /sys/class/power_supply/battery/temperature
echo "38" > /sys/class/power_supply/battery/temperature
chmod 444 /sys/class/power_supply/battery/temperature

chmod 644 /sys/devices/platform/bms/*
chmod 644 /sys/devices/platform/charger/*
chmod 644 /sys/devices/platform/main/*
chmod 644 /sys/devices/platform/battery/*
chmod 644 /sys/devices/mtk-battery/restricted_current
chmod 644 /sys/devices/platform/pc_port/current_max
chmod 644 /sys/devices/platform/constant_charge_current__max

echo '150' > /sys/devices/platform/bms/temp_cool
echo '460' > /sys/devices/platform/bms/temp_hot
echo '460' > /sys/devices/platform/bms/temp_warm

echo '9000000' > /sys/devices/platform/charger/current_max
echo '9000' > /sys/devices/platform/charger/sc_ibat_limit
echo '14000' > /sys/devices/platform/charger/sc_stime
echo '9000000' > /sys/devices/platform/charger/hw_current_max
echo '9000000' > /sys/devices/platform/charger/pd_current_max
echo '9000000' > /sys/devices/platform/charger/ctm_current_max
echo '9000000' > /sys/devices/platform/charger/sdp_current_max

echo '9000000' > /sys/devices/platform/main/current_max
echo '9000000' > /sys/devices/platform/main/constant_charge_current_max

echo '9000000' > /sys/devices/platform/battery/current_max
echo '9000000' > /sys/devices/platform/battery/constant_charge_current_max

echo '10800000' > /sys/devices/mtk-battery/restricted_current
echo '9000000' > /sys/devices/platform/pc_port/current_max
echo '9000000' > /sys/devices/platform/constant_charge_current__max

chmod 444 /sys/devices/platform/bms/*
chmod 444 /sys/devices/platform/charger/*
chmod 444 /sys/devices/platform/main/*
chmod 444 /sys/devices/platform/battery/*
chmod 444 /sys/devices/mtk-battery/restricted_current
chmod 444 /sys/devices/platform/pc_port/current_max
chmod 444 /sys/devices/platform/constant_charge_current__max