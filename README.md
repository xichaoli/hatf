# HATF (Hardware auto test framework)

目前支持S9080,S6040平台,F6040,S6016等平台的适配尚未完成！

# Dependencies

```
apt install whiptail pciutils dmidecode i2c-tools usbutils memtester stress
```

# Quick Start

```
sudo ./hatf
```

可以在串口终端执行测试，但更推荐使用ssh连接！

# case ID:

#### 类型编号+模块编号+测试序号

示例：0 06 1

##### 类型编号：

0 function
1 stability  
2 performance

##### 模块编号:

01 ~ 99

##### 功能序号:

0 ~ 9
