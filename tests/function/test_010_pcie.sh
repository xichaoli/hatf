###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-24 11:20:56
# @LastEditors: xichaoli xichaoli@sina.cn
# @LastEditTime: 2022-08-24 14:23:53
# @FilePath: /hatf/tests/function/test_010_pcie.sh
# @Description: 测试PCIe插槽是否可用
###

###
# @description: 由于PCIe卡不能热插拔，所以需要在系统启动前连接好所有被测卡.
# 实际测试时可通过 lspci 命令获取设备号，修改脚本后再做测试.
###
# shellcheck disable=SC3030
test_pcie() {
    log_info "Start to test PCIe slots ..."

    declare -A dut_cards
    dut_cards=(
        ["NP-IOC601-2SFP+"]="8086:1572"
        ["FP068E"]="8086:1581"
        ["PE-044P"]="8848:1020"
        ["MegaRAID"]="1000:0079"
    )

    keys="NP-IOC601-2SFP+ FP068E PE-044P MegaRAID"

    for card in $keys; do
        whiptail --msgbox "请确认设备型号为 ${card} 的测试卡已插好" 10 50

        if [ -n "$(lspci -d "${dut_cards[${card}]}")" ]; then
            log_info "已识别到 ${card} 型号的测试卡"
        else
            log_err "未识别到 ${card} 型号的测试卡！"
        fi

        BUS_NUM=$(lspci -D -d "${dut_cards[${card}]}" | cut -d ':' -f1-2 | uniq)

        if [ "${card}" = "MegaRAID" ]; then
            TARGET_SPEED="5 GT/s"
        else
            TARGET_SPEED="8 GT/s"
        fi
        TARGET_WIDTH="8"

        CURRENT_SPEED=$(cat /sys/class/pci_bus/"${BUS_NUM}"/device/current_link_speed)
        CURRENT_WIDTH=$(cat /sys/class/pci_bus/"${BUS_NUM}"/device/current_link_width)

        if [ "${TARGET_SPEED}" = "${CURRENT_SPEED}" ]; then
            log_info "PCIe卡 ${card} 连接速率为 ${CURRENT_SPEED},符合预期"
        else
            log_err "PCIe卡 ${card} 连接速率为 ${CURRENT_SPEED},不符合预期!"
        fi

        if [ "${TARGET_WIDTH}" = "${CURRENT_WIDTH}" ]; then
            log_info "PCIe卡 ${card} 连接带宽为 ${CURRENT_WIDTH},符合预期"
        else
            log_err "PCIe卡 ${card} 连接速率为 x${CURRENT_WIDTH},不符合预期!"
        fi
    done
    log_info "Stop testing PCIe slots ..."
}
