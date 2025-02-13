# Microprocessor_course
## NCKU ES Course with 8051 MCU  
### 1. 嵌入式系統介紹  
#### MPU（Microprocessor Unit）微處理器單元
將中央處理器 CPU （Central Processing Unit） 封裝於一個晶片中，晶片內沒有其他周邊裝置，因此需要搭配其他 ROM、RAM 等裝置使用，較有名的 MPU 有 Zilog Z80、8086 等。
#### MCU（Microcontroller Unit）微控制器單元
除了中央處理器之外，還有其他周邊裝置被封裝在同一晶片中，常見的周邊裝置包含了 ROM、RAM、UART、Timer、I/O 等， 8051、PIC、ATmega328、STM32 系列等晶片為現在常見的 MCU。
#### SoC（System on Chip）系統晶片
隨著晶圓製程技術提升，相同的體積下可以放入更多的晶片，晶片設計廠商可以將各種具有運算核心功能的晶片連同 RAM、ROM、振盪器等封裝在同一張晶片中，現今常見的 SoC 主要的架構包含了負責運算的單元、記憶體控制單元、類比數位的轉換器、管理供電來源的穩壓器，根據功能需求，還可能加入GPU、DSP、網路晶片等，例如 BeagleBone 的主晶片 AM3358，其內部包含了：ARM® Cortex® -A8 處理器、Memory 介面、Real-Time、Power、顯示、 Clock 管理、圖像處理、內部通訊…等可以處理各種功能的運算單元。
### 2. 8051 介紹
#### 8051 內部元件
• 8051 的運算核心為 8 位元的 CPU。  
• 8051 內部有 4KB 的內部程式記憶體 ROM （read only memory，現多以 Flash memory 取代）和 128Bytes 的內部資料記憶體 RAM（read access memory），兩者最大皆可擴充至外部 64KB。  
• 具有內部震盪電路，利用石英震盪晶體搭配兩個電容即可對 8051 提供時脈來源。  
• 具有 4 組可位元定址的 GPIO （General-purpose input/output），分別為 P0、P1、P2、P3，其中 P0 腳位設計上主要做為位址或資料傳輸用，若要拿來提供訊號需要外接上拉電阻。  
• 具有 2 組 16 位元的 timer，分別為 timer0 和 timer1。  
• 具有 5 個中斷來源，分別為 INT0 （外部中斷 0）、INT1 （外部中斷 1）、T0（計時器 0）、T1 （計時器 1）、RXD & TXD （UART）。  
• 具有 1 組全雙工序列埠 UART（Universal Asynchronous Receiver Transmitter）。  
