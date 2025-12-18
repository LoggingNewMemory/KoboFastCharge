#!/system/bin/sh

DEFAULT_CURRENT=3000000
DEFAULT_VOLTAGE=5000000

get_max_values() {
    if [ -f "/sys/class/power_supply/battery/voltage_max_design" ]; then
        MAX_VOLTAGE=$(cat /sys/class/power_supply/battery/voltage_max_design)
    else
        MAX_VOLTAGE=$DEFAULT_VOLTAGE
    fi

    if [ -f "/sys/class/power_supply/battery/charge_current_max" ]; then
         MAX_CURRENT=$(cat /sys/class/power_supply/battery/charge_current_max)
    else
         MAX_CURRENT=$DEFAULT_CURRENT
    fi
    
    if [ "$MAX_CURRENT" -lt 2000000 ]; then
        MAX_CURRENT=3000000 
    fi

    if [ "$MAX_VOLTAGE" -gt 5500000 ]; then
        MAX_CURRENT=9000000
    fi
}

lock_val() {
    if [ -f "$2" ]; then
        chmod 0666 "$2" >/dev/null 2>&1
        echo "$1" > "$2" 2>/dev/null
        chmod 0444 "$2" >/dev/null 2>&1
    fi
}

get_max_values

for zone in /sys/class/thermal/thermal_zone*/mode; do
    lock_val "disabled" "$zone"
done

find /sys/ -name "temp_cool" -o -name "temp_hot" -o -name "temp_warm" 2>/dev/null | while read path; do
    case "$path" in
        *"cool"*) lock_val "150" "$path" ;;
        *"hot"*)  lock_val "480"  "$path" ;;
        *"warm"*) lock_val "480" "$path" ;;
    esac
done

for feature in fast_charge force_fast_charge boost_mode turbo_mode pd_allowed allow_hvdcp3; do
    find /sys/class/power_supply/ -name "$feature" 2>/dev/null | while read path; do
        lock_val "1" "$path"
    done
done

for limit in current_max constant_charge_current_max input_current_limit hw_current_max pd_current_max ctm_current_max sdp_current_max restricted_current; do
    find /sys/class/power_supply/ -name "$limit" 2>/dev/null | while read path; do
        lock_val "$MAX_CURRENT" "$path"
    done
done

find /sys/class/power_supply/ -name "input_voltage_limit" 2>/dev/null | while read path; do
        lock_val "$MAX_VOLTAGE" "$path"
done

if [ -d "/sys/devices/mtk-battery" ]; then
    lock_val "$MAX_CURRENT" "/sys/devices/mtk-battery/restricted_current"
    lock_val "$MAX_CURRENT" "/sys/devices/mtk-battery/fc_current_limit"
fi

if [ -d "/sys/class/qcom-battery" ]; then
    lock_val "0" "/sys/class/qcom-battery/restricted_charging"
    lock_val "0" "/sys/class/qcom-battery/restrict_chg"
    lock_val "$MAX_CURRENT" "/sys/class/qcom-battery/restricted_current"
    lock_val "$MAX_CURRENT" "/sys/class/qcom-battery/restrict_cur" 
fi

find /sys/devices/platform/ -name "constant_charge_current_max" -o -name "input_current_limit" 2>/dev/null | while read path; do
    lock_val "$MAX_CURRENT" "$path"
done

lock_val "0" "/sys/class/power_supply/battery/input_current_limited"
lock_val "1" "/sys/class/power_supply/battery/input_current_settled"
lock_val "100" "/sys/class/power_supply/battery/siop_level"