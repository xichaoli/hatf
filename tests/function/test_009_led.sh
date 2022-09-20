#!/bin/bash
###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-24 09:19:02
 # @LastEditors: xichaoli xichao@sina.cn
 # @LastEditTime: 2022-09-14 10:10:11
# @FilePath: /hatf/tests/function/test_led.sh
# @Description: 测试管理板的 sys 状态灯
###

# shellcheck disable=SC3030
test_led() {
    log_info "Start to test the LED of sys ..."

    local -A led_ctl
    local -A led_status

    # 只有S9080平台管理板上的sys灯是双色灯，其他平台是单色灯
    if [ "${DUT_MODEL}" = "S9080" ]; then
        led_ctl=(
            ["green_bright"]="0x01"
            ["green_blink"]="0x11"
            ["red_bright"]="0x12"
            ["red_blink"]="0x22"
            ["go_out"]="0x0"
        )

        led_status=([1]=green_bright [2]=green_blink [3]=red_bright [4]=red_blink [5]=go_out)
    else
        led_ctl=(
            ["green_bright"]="0x12"
            ["green_blink"]="0x22"
            ["go_out"]="0x0"
        )

        led_status=([1]=green_bright [2]=green_blink [3]=go_out)
    fi

    for num in $(seq ${#led_status[@]}); do
        local title="${led_status[$num]}"
        local case_id=009${num}

        ((RUN_NUM += 1))
        whiptail --msgbox "设置LED灯状态为 ${title}" 10 50
        i2cset -f -y 2 0x64 0xc "${led_ctl[${title}]}"

        if (whiptail --title "led status" --yesno "请确认LED灯状态是否为 ${title}?" 10 50 3>&1 1>&2 2>&3); then
            ((PASS_NUM += 1))
            log_info "LED 灯 ${title} 状态正确"
        else
            ((FAIL_NUM += 1))
            fail_id[${title}]=${case_id}
            log_err "LED 灯 ${title} 状态不正确！"
        fi
    done

    log_info "Stop testing the LED of sys ..."
}
