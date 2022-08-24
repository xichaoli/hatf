###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-22 14:03:50
# @LastEditors: xichaoli xichaoli@sina.cn
# @LastEditTime: 2022-08-22 17:31:33
# @FilePath: /hatf/tests/function/test_003_memory.sh
# @Description: 确认内存参数是否正确
###

test_memory() {
    log_info "Start to test the memory status ..."

    whiptail --title "Tips" --msgbox "开始内存状态测试，请确保所有内存型号、容量相同！" 10 50

    MEMORY_RANKS=$(dmidecode -t memory | grep -c "Rank:")
    SINGLE_MEMORY_SIZE=$(dmidecode -t memory | grep -E "(^\s*)Size: (.+)(MB$)" | uniq | awk '{print$2}')

    if (whiptail --title "rank number of memory" --yesno "设备插有 ${MEMORY_RANKS} 根内存条？" 10 50); then
        log_info "内存条数正确"
    else
        log_err "所插内存条数不正确"
    fi

    if (whiptail --title "single size of memory" --yesno "每根内存条容量是 ${SINGLE_MEMORY_SIZE} MB？" 10 50); then
        log_info "内存条容量正确"
    else
        log_err "所插内存容量不正确"
    fi

    log_info "Stop testing the memory status ..."
}
