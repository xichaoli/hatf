#!/bin/bash
###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-24 11:20:56
 # @LastEditors: xichaoli xichao@sina.cn
 # @LastEditTime: 2022-09-14 10:11:21
# @FilePath: /hatf/tests/function/test_010_pcie.sh
# @Description: 测试PCIe插槽是否可用
###

###
# @description: 由于PCIe卡不能热插拔，所以需要在系统启动前连接好所有被测卡.
# 实际测试时可通过 lspci 命令获取设备号，修改脚本后再做测试.
###
# shellcheck disable=SC3030

test_pcie_recognize() {
    local title="pcie_$1_recognize"
    local case_id=0101

    ((RUN_NUM += 1))
    whiptail --msgbox "请确认设备型号为 $1 的测试卡已插好" 10 50
    if [[ -n "$(lspci -d "${dut_cards[$1]}")" ]]; then
        ((PASS_NUM += 1))
        log_info "已识别到 $1 型号的测试卡"
    else
        ((FAIL_NUM += 1))
        fail_id[${title}]=${case_id}
        log_err "未识别到 $1 型号的测试卡！"
    fi
}

test_pcie_speed() {
    local title="pcie_$1_speed"
    local case_id=0102

    ((RUN_NUM += 1))
    if [[ "$1" = "MegaRAID" ]]; then
        local TARGET_SPEED="5 GT/s"
    else
        local TARGET_SPEED="8 GT/s"
    fi
    local CURRENT_SPEED
    CURRENT_SPEED=$(cat /sys/class/pci_bus/"$2"/device/current_link_speed)

    if [ "${TARGET_SPEED}" = "${CURRENT_SPEED}" ]; then
        ((PASS_NUM += 1))
        log_info "PCIe卡 $1 连接速率为 ${CURRENT_SPEED},符合预期"
    else
        ((FAIL_NUM += 1))
        fail_id[${title}]=${case_id}
        log_err "PCIe卡 $1 连接速率为 ${CURRENT_SPEED},不符合预期!"
    fi
}

test_pcie_width() {
    local title="pcie_$1_width"
    local case_id=0103

    ((RUN_NUM += 1))

    local TARGET_WIDTH="8"

    local CURRENT_WIDTH
    CURRENT_WIDTH=$(cat /sys/class/pci_bus/"$2"/device/current_link_width)

    if [ "${TARGET_WIDTH}" = "${CURRENT_WIDTH}" ]; then
        ((PASS_NUM += 1))
        log_info "PCIe卡 $1 连接带宽为 ${CURRENT_WIDTH},符合预期"
    else
        ((FAIL_NUM += 1))
        fail_id[${title}]=${case_id}
        log_err "PCIe卡 $1 连接速率为 x${CURRENT_WIDTH},不符合预期!"
    fi
}

test_pcie() {
    log_info "Start to test PCIe slots ..."

    declare -A dut_cards
    dut_cards=(
        ["NP-IOC601-2SFP+"]="8086:1572"
        ["FP068E"]="8086:1581"
        ["PE-044P"]="8848:1020"
        ["MegaRAID"]="1000:0079"
    )

    for card in "${!dut_cards[@]}"; do

    local BUS_NUM
    BUS_NUM=$(lspci -D -d "${dut_cards[${card}]}" | cut -d ':' -f1-2 | uniq)

    ((RUN_NUM += 1))

    test_pcie_recognize "${card}"
    test_pcie_speed "${card}" "${BUS_NUM}"
    test_pcie_width "${card}" "${BUS_NUM}"
done    log_info "Stop testing PCIe slots ..."
}
