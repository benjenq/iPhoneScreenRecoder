iPhoneScreenRecoder
===============
A powerful tool to recording screen on iPhone device. support iOS 8+. Private Framework used so may not be approved by Apple.
強大的螢幕錄製工具，支援 iOS 8+ 的 iPhone 裝置。使用私有框架所以可能無法通過 Apple 的審查。

## How to Use?
如何使用？


1.Copy and Drag /fat/*.* to $(PROJECT_DIR) directory of your project.
將 /fat/*.* 拖曳與複製到專案的根目錄下。

2. Search Paths Configuration:
設定搜尋路徑:

Header Search Paths
$(PROJECT_DIR)/fat/include

Library Search Paths
$(inherited)
$(PROJECT_DIR)/fat/lib


3. Copy and Drag AirPlay/*.h,*.m to your project directory.
拖曳與複製 AirPlay/*.h,*.m 到專案內。

4. 新增以下 Framework
![GitHub](https://github.com/benjenq/iPhoneScreenRecoder/blob/master/FrameworkList.png "GitHub,benjenq")

## How this demo to work?
Demo 如何運作？

Launch application, press "Start" button, the screen recoder will start with timer indecated. You can switch to any application and it record anything happened on screen you seen.
啟動應用程式, 按下「Start」按鈕，螢幕錄製程序伴隨計時器啟動。你可以切換到任何的應用程序畫面，任何螢幕上所見的畫面將被全數紀錄。

Connect iPhone device to iTunes PC via USB cable and transfer the screen-recorded file named "output.mp4" via iTunes.
用 USB 電纜連接 iPhone 與 iTunes 個人電腦，可將螢幕錄製的影片檔案 "output.mp4" 透過 iTunes 傳送。

## Special thanks:
This project reference from RecordMyScreen-iOS10 project.
xindawndev
https://raw.githubusercontent.com/xindawndev/RecordMyScreen-iOS10
