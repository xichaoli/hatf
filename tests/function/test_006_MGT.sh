###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-22 17:18:24
# @LastEditors: xichaoli xichaoli@sina.cn
# @LastEditTime: 2022-08-23 11:15:38
# @FilePath: /hatf/tests/function/test_006_MGT.sh
# @Description: 测试管理网口功能
###

test_speed() {
    SPEED=$(cat /sys/class/net/"$1"/speed)
    if [ 1000 -ne "${SPEED}" ]; then
        log_err "管理网口 $1 协商速率不正确，现为 ${SPEED}Mb/s !"
    else
        log_info "管理网口 $1 协商速率正确，为1000Mb/s ."
    fi
}

test_link() {
    # 设置管理口IP及对接网口的IP地址
    LOCAL_IP=$(whiptail --title "Set IP" --inputbox "设置管理网口 $1 的 IP地址:(例:192.168.2.2/24),无需配置请选择取消" \
        10 50 192.168. 3>&1 1>&2 2>&3)
    ip addr add "${LOCAL_IP}" dev "$1"

    DEST_IP=$(whiptail --title "Set IP" --inputbox "请确保已将与管理网口 $1 对接的网口IP地址按如下设置,无需配置请选择取消" \
        10 50 192.168. 3>&1 1>&2 2>&3)

    if ping -c 3 "${DEST_IP}"; then
        log_err "管理网口 $1 与 目标地址网络不通！"
    else
        log_info "管理网口 $1 与 目标地址网络联通正常."
    fi

    ip addr del "${LOCAL_IP}" dev "$1"
}

test_MGT() {
    log_info "Start to test the management interface ..."

    # 管理口使用WX1860A2网卡芯片，ID号为 8088:0101
    TEST_PORTS=$(lshw -businfo -numeric -class network | grep 8088:101 | awk '{print$2}')

    for port in ${TEST_PORTS}; do
        test_speed "${port}"
        test_link "${port}"
    done

    log_info "Stop testing the management interface ..."
}
