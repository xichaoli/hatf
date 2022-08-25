###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-24 09:19:02
# @LastEditors: xichaoli xichaoli@sina.cn
# @LastEditTime: 2022-08-24 16:46:13
# @FilePath: /hatf/tests/function/test_led.sh
# @Description: 测试管理板的 sys 状态灯
###

test_led() {
    log_info "Start to test the LED of sys ..."
    declare -A led_status
    led_status=(
        ["green_bright"]="0x01"
        ["green_blink"]="0x11"
        ["red_bright"]="0x12"
        ["red_blink"]="0x22"
        ["go_out"]="0x0"
    )

    # for status in $(echo ${!led_status[@]}); do
    # 使用 $(echo ${!led_status[@]})，输出的键值是不按预期顺序的
    keys="green_bright green_blink red_bright red_blink go_out"
    for status in $keys; do
        whiptail --msgbox "设置LED灯状态为 ${status}" 10 50
        i2cset -f -y 2 0x64 0xc "${led_status[${status}]}"

        if (whiptail --title "led status" --yesno "请确认LED灯状态是否为 ${status}?" 10 50 3>&1 1>&2 2>&3); then
            log_info "LED 灯 ${status} 状态正确"
        else
            log_err "LED 灯 ${status} 状态不正确！"
        fi
    done

    log_info "Stop testing the LED of sys ..."
}
