
## Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports Clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports Clk]


## Switches
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports C]

## LEDs
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports HG]
set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports HY]
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports HR]
set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports FG]
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports FY]
set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports FR]

##Buttons
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports Reset]
#set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports btnU]
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports TS] # left button
set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports TL] # right button
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports btnD]

## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## SPI configuration mode options for QSPI boot, can be used for all designs
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
