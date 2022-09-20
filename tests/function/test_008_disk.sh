#!/bin/bash
#shellcheck disable=SC2034
#bashsupport disable=BP2001
###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-23 17:21:35
# @LastEditors: xichaoli xichaoli@sina.cn
# @LastEditTime: 2022-08-24 11:03:28
# @FilePath: /hatf/tests/function/test_008_disk.sh
# @Description: 测试设备存储设备是否正常
###

###
# @description: 由于硬盘接口不能热插拔，所以需要在系统启动前连接好所有被测硬盘.
# 实际测试时可通过 lsblk -S 命令获取实际使用的硬盘型号，修改脚本后再做测试.
###
test_disk() {
    log_info "Start to test SATA interface ..."
    local title="disk"
    local case_id="0082"

    local dut_disks
    dut_disks="BIWIN_SSD KINGSTON_SA400M8120G KINGSTON_SA400S37120G ST9500620NS"

    for disk in ${dut_disks}; do
        ((RUN_NUM += 1))
        whiptail --msgbox "请确认设备型号为 ${disk} 的测试硬盘已插好!" 10 50

        if lsblk -S | grep -q "${disk}"; then
            ((PASS_NUM += 1))
            log_info "已识别到 ${disk} 型号的测试硬盘"
        else
            ((FAIL_NUM += 1))
            fail_id[${title}]=${case_id}
            log_err "未识别到 ${disk} 型号的测试硬盘！"
        fi
    done
    log_info "Stop testing SATA interface ..."
}
