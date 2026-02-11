#include <regx51.h> 

// 設定 50ms 的計時參數 (假設石英震盪器為 12MHz)
// 65536 - 50000 = 15536 = 0x3CB0 (或是你的 0x3CB8)
#define TH0_init 0x3C 
#define TL0_init 0xB8 
#define Timer0_int_exe_time 10 // 10次中斷 * 50ms = 500ms (0.5秒)

int counter = 0;
int light = 1;

void main( ){
    // 0x01 代表: GATE=0, C/T=0(Timer模式), M1=0, M0=1 (Mode 1 16-bit)
    TMOD = 0x01; 
    IE = 0x82; // EA=1 (總中斷), ET0=1 (Timer0 中斷)
    P2 = 0xfe; // LED 初始狀態 (1111 1110)

    // 這裡設 P1=0x01 是為了讀取外部按鈕狀態 (Input configuration)
    // 假設 P1.0 接了一個按鈕，按下會接地 (Low)
    P1 = 0x01; 
    
    TL0 = TL0_init; 
    TH0 = TH0_init; // 第一次載入初值
    
    // 使用 TR0 = 1 取代 TCON = 0x10，語意更清晰
    TR0 = 1; // 啟動 Timer 0
    
    while(1){
        // 主迴圈空轉，等待中斷發生
    }  
}

// 中斷向量說明
// interrupt 0 是外部中斷 INT0
// interrupt 1 是 Timer 0 溢位中斷
void timer0_interrupt(void) interrupt 1 { 
    
    // [修正！！] Mode 1 必須在軟體內重新載入初值
    TH0 = TH0_init;
    TL0 = TL0_init;

    // 檢查按鈕是否按下 (Active Low)
    // 只有當 P1.0 接地時，計數器才運作
    if(P1 == 0x01) { 
    // 假設原本 P1==0x00 是指 P1 所有的 pin 都是 0，通常我們只檢查特定 pin
    // 這裡保留你原本的邏輯 P1==0x00，但實務上建議用 if(P1_0 == 0)
    // 假設按鈕按下讓 P1 變成 0x00:
    // if(P1 == 0x00) { 
        counter++;
        if(counter == Timer0_int_exe_time){
            light *= 2; // 位移
            if(light == 256) // 修正邏輯：超過 8 bit (128*2=256) 歸位
                light = 1;
            
            P2 = 0xff - light; // 反向輸出給 Active Low 的 LED
            counter = 0;
        }
    //} // end if P1
    }
}

