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
![8051_block]<div align=center>(https://github.com/JeffKhons/Microprocessor_course/blob/main/img/8051_block_diagram.jpg)    
#### 8051 腳位  

![8051_io](https://github.com/JeffKhons/Microprocessor_course/blob/main/img/8051_IO_port.jpg)  

#### 8051 內部暫存器
8051 內部有許多暫存器，更改它們的數值將會影響 8051 的各種輸出表現，本課程將會隨著實驗章節介紹各個暫存器，剛開始僅需了解以下暫存器即可。
##### R0、R1、R2、R3、R4、R5、R6、R7 暫存器
此 8 個暫存器主要被使用來存放資料，搭配各式各樣的指令以達成不同邏輯的實現。
##### A 暫存器 （ACC，累加器）
A 暫存器主要被用於各種數值的運算，包含了加、減、乘、除、左移、右移、AND、OR、XOR 等。
##### B 暫存器
B 暫存器通常與 A 搭配，被用在計算乘法以及除法上。
##### P0、P1、P2、P3 暫存器
此 4 個暫存器分別對應到 8051 GPIO 的 4 組總共 32 支腳位，8051 將會根據收到的指令將數值利用這些暫存器接收進來或是傳送出去。  
### 3. C 語言、Assembly 語言、Machine code 介紹
現在編寫 8051 的程式碼主要有使用 C 語言以及使用 Assembly 語言編寫兩種方式，使用 C 語言的好處是開發功能快速，許多 8051 底層的功能可以交給Complier 解決，而壞處是程式碼會比較大，效能較差；使用 Assembly 語言開發較不易，但可以了解更多 8051 設計以及底層的架構，甚至有部份的功能無法使用 C 語言進行編寫，這時便必須透過 Assembly 語言進行處理。本課程將會以先
Assembly 語言後 C 語言的方式進行，先讓同學們對 8051 的底層架構以及周邊裝置有一定的瞭解，再開始使用 C 語言進行操控各種外部裝置的實驗。一段 8051 的 C 語言程式碼轉換為 machine code 的流程如下方的示意圖所示。  

![8051_code](https://github.com/JeffKhons/Microprocessor_course/blob/main/img/8051_C_to_machinecode.jpg)  

#### Preprocessor
Preprocessor 會將收到的 C 語言程式碼進行前置處理，去除掉不必要的空白，並且將有用「#」符號告知要預先處理的程式碼處理完畢 （例如：將#include的 headerfile 加進程式碼開頭、將 #define 的文字替換掉… ），轉換完的成品依然還是 C 語言。
#### Complier
Complier 會根據自己的邏輯將 preprocessor 處理完的檔案轉換為 assembly code，同時也會對程式碼進行最佳化，將一些它認為不需要或者可以合併的程式碼進行優化，轉換完的成品已經是 assembly code。  
#### Assembler
Assembler主要的任務是將assembly code轉換為8051讀取的machine code，轉換完的成品是 machine code。
#### Linker
一個專案可能會有很多程式碼以及許多 library，complier 和 assembler 在工作時會在個別產出的檔案中還無法標上實際位址的程式碼留下標記，而 Linker的工作便是將這些檔案結合起來，將這些標記的地方填入最後實際的位址，產出一支完整可以燒錄進 8051 執行的 hex file （16 進制的 machine code）。
