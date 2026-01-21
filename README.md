# 🛡️ Win32-API Stealth Keylogger (PoC)

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Windows-green.svg)
![Language](https://img.shields.io/badge/language-Batch%20%2F%20PowerShell-blue.svg)

A lightweight, high-performance keylogger prototype built using **Batch** and **PowerShell with Win32 API integration**. This project was developed in under an hour as a Proof of Concept (PoC) for educational purposes.

## ✨ Features
* **Win32 API Integration:** Uses `GetAsyncKeyState` and `ToUnicode` for precise keystroke capture.
* **Window Tracking:** Logs the title of the active window whenever the user switches applications.
* **Full Character Support:** Unlike basic loggers, this version supports special characters (@, #, ?, etc.) and Shift-modified keys.
* **Stealth Execution:** Runs in the background using the `Hidden` window style.
* **Zero Dependencies:** No need to install Python or external libraries; runs natively on Windows.

## 📁 Log Location
For ease of visibility during testing, the log file is created directly on your desktop:
`C:\Users\<YourUser>\Desktop\test_log.txt`

## 🚀 How to Run
1. Download the `.bat` file.
2. **Important:** Disable Windows Defender or your Antivirus temporarily. Since this script uses low-level API calls to capture keyboard input without being "signed," AVs will flag it by design.
3. Double-click the file.
4. To stop the process: Open **Task Manager**, find `PowerShell`, and select **End Task**.

## ❓ Q&A
* **Why is there Turkish in the code?** Turkish is my mother language, so some internal logic/comments remain in Turkish.
* **Does it log emojis?** No, it is restricted to ASCII/Unicode characters supported by the Win32 buffer.
* **Will this be updated?** Possibly. Future plans include logging network requests (HTTP/HTTPS).

## ⚠️ Disclaimer
**This project is for educational purposes only.** I created this to understand how low-level system hooks work. I have no intention of hacking or stealing data. I am not responsible for any misuse of this software. Use it only on systems you own or have explicit permission to test.

---
*If you find this project interesting for learning system hooks, feel free to leave a ⭐!*
