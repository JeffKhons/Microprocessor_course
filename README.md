# Microprocessor_course
## NCKU ES Course with 8051 MCU  
### 1. 嵌入式系統介紹  
#### MPU（Microprocessor Unit）微處理器單元
將中央處理器 CPU （Central Processing Unit） 封裝於一個晶片中，晶片內沒有其他周邊裝置，因此需要搭配其他 ROM、RAM 等裝置使用，較有名的 MPU 有 Zilog Z80、8086 等。
#### MCU（Microcontroller Unit）微控制器單元
除了中央處理器之外，還有其他周邊裝置被封裝在同一晶片中，常見的周邊裝置包含了 ROM、RAM、UART、Timer、I/O 等， 8051、PIC、ATmega328、STM32 系列等晶片為現在常見的 MCU。
#### SoC（System on Chip）系統晶片
隨著晶圓製程技術提升，相同的體積下可以放入更多的晶片，晶片設計廠商可以將各種具有運算核心功能的晶片連同 RAM、ROM、振盪器等封裝在同一張晶片中，現今常見的 SoC 主要的架構包含了負責運算的單元、記憶體控制單元、類比數位的轉換器、管理供電來源的穩壓器，根據功能需求，還可能加入GPU、DSP、網路晶片等，例如 BeagleBone 的主晶片 AM3358，其內部包含了：ARM® Cortex® -A8 處理器、Memory 介面、Real-Time、Power、顯示、 Clock 管理、圖像處理、內部通訊…等可以處理各種功能的運算單元。
