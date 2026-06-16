EN/
# 🛡️ Smart Server Room and Data Center Monitoring System

This project is an IoT-based security and telemetry system developed for the 24/7 continuous monitoring of environmental and electrical parameters in data centers and corporate server rooms. 

By detecting physical environmental changes in real-time, the system proactively identifies potential hardware failures before they occur and instantly reports critical anomalies to administrators across multiple platforms.


## 🚀 Hardware Components

* **Deneyap Kart 1A v2:** Main microcontroller unit (MCU) and core cloud communication module.
* **Deneyap Temperature and Humidity Sensor:** Used for precise HVAC and climate control monitoring.
* **Deneyap Microphone Sensor:** Acoustic monitoring designed to detect abnormal fan noise and hardware friction failures.
* **Deneyap Mini OLED Display:** Provides localized, on-site real-time data visualization.
* **PZEM-004T Multimeter Module (with Current Transformer):** Measures AC voltage, current, active power, and total energy consumption.


## 💻 Software & Technologies

- **Programming Languages:** C/C++, Python, Dart (Flutter), HTML / CSS / JavaScript
- **Development Environments:** Arduino IDE, VS Code
- **Cloud Database:** Google Firebase Realtime Database
- **Alerting & Notifications:** Telegram Bot API & Firebase Cloud Messaging (FCM)
- **Hosting & Deployment:** Netlify

  
## 🔑 Key Features

- **Real-Time Telemetry:** Continuous live tracking of ambient temperature, humidity, acoustic noise levels, and electrical power metrics.
- **Proactive Alert System:** Instant emergency notifications dispatched via Telegram bots and Push notifications (FCM) the moment any critical threshold is breached.
- **Cross-Platform Support:** Seamless, synchronized multi-platform monitoring across Android and Web interfaces powered by a single Flutter codebase.
- **Fault Tolerance:** A robust Python Gateway layer equipped with local logging mechanisms to prevent data loss during network or Wi-Fi disruptions.
- **Data Analytics & Visualization:** Interactive, live-updating charts for real-time energy consumption tracking and environmental trend analysis.


## 📂 Project Structure

| File / Folder | Description |
| :--- | :--- |
| `Arduino_Code.ino` | Firmware code running on Deneyap Kart for sensor data acquisition and Wi-Fi data streaming. |
| `data_gateway.py` | Python-based gateway script for serial port (UART) listening and Firebase data synchronization. |
| `sunucu_odasi_app` | Source code for the Flutter-based mobile and web client application. |
| `Rapor.pdf` | Detailed project graduation/capstone engineering report. |


## 📊 System Architecture

The data pipeline operates as follows: 
`Sensors ➔ Deneyap Kart ➔ Python Gateway ➔ Firebase Realtime Database ➔ Flutter App / Telegram Bot`

Raw telemetry data captured by the Deneyap Kart is securely transmitted over a serial interface to a local Python Gateway layer. The gateway processes and syncs this data with the Firebase cloud database. Once updated, the data is instantly reflected on the live web/mobile dashboard, and if any critical thresholds are exceeded, the Telegram bot automatically triggers urgent push alerts to the system administrators.


## 👨‍💻 Developers

- **Muhammet Melih DEMİRCİ**
- **Semanur GĞVEN**

## ⚠️ Security Notice

For security reasons, the following sensitive credentials and configuration files have been excluded from this public repository:
- Firebase API keys, database URLs, and service account credentials.
- Telegram Bot Tokens and Chat ID parameters.
- Private server network configurations and local network access credentials.

📄 **Note:** The comprehensive project report is available in the repository files as `bulut_bilişim_rapor (1)`.

TR/
# 🛡️ Akıllı Sunucu Odası ve Veri Merkezi İzleme Sistemi

Bu proje, veri merkezleri ve kurumsal sunucu odalarındaki çevresel ve elektriksel parametrelerin 7/24 kesintisiz izlenmesi amacıyla geliştirilmiş IoT tabanlı bir güvenlik ve telemetri sistemidir.

Sistem, fiziksel ortamdaki değişimleri anlık olarak algılayarak, donanım arızalarını henüz gerçekleşmeden proaktif bir şekilde tespit etmekte ve yöneticilere çoklu platformlar üzerinden raporlamaktadır.


## 🚀 Kullanılan Donanımlar

**Deneyap Kart 1A v2:** Ana mikrodenetleyici ve bulut haberleşme birimi.
**Deneyap Sıcaklık ve Nem Sensörü:** İklimlendirme denetimi.
**Deneyap Mikrofon Sensörü:** Fan arızaları için akustik izleme. 
**Deneyap Mini OLED Ekran:** Lokal veri gösterimi.
**PZEM-004T Akım Trafolu Akım Gerilim Enerji Multimetre Modülü.**


## 💻 Kullanılan Yazılımlar ve Teknolojiler

- Arduino IDE
- Python
- Flutter
- Google Firebase Realtime Database
- Telegram Bot API & Firebase Cloud Messaging (FCM)
- C/C++
- HTML / CSS / JavaScript
- Netlify

  
## 🔑 Sistem Özellikleri

- Gerçek Zamanlı Telemetri: Sıcaklık, nem, ses ve enerji verilerinin anlık takibi.
- Proaktif Uyarı Sistemi: Kritik eşik aşıldığında Telegram ve Push bildirimleri ile acil durum bilgilendirmesi.
- Çapraz Platform Desteği: Flutter sayesinde Android ve Web üzerinden aynı anda izleme.
- Hata Toleransı: Python Gateway katmanı ile veri kayıplarını önleyen yerel loglama mekanizması.
- Görselleştirme: Canlı grafiklerle anlık enerji tüketim ve ortam analizi.

## 📂 Proje Dosyaları

| **Dosya** | **Açıklama** |

-| Arduino_Code.ino | Deneyap Kart üzerindeki sensör okuma ve Wi-Fi haberleşme kodu |
-| data_gateway.py | Python tabanlı seri port dinleme ve Firebase veri aktarım kodu |
-| sunucu_odasi_app | Flutter mobil ve web projesi kaynak kodları |
-| Rapor.pdf | Detaylı proje bitirme raporu |

## 📊 Sistem Mimarisi

**Sistem;** Sensörler ➔ Deneyap Kart ➔ Python Gateway ➔ Firebase Realtime Database ➔ Flutter Uygulaması / Telegram Botu

Deneyap Kart tarafından toplanan ham telemetri verileri, seri arayüz (port) üzerinden güvenli bir şekilde yerel Python Gateway katmanına iletilir. Gateway bu verileri işleyerek Firebase bulut veritabanı ile senkronize eder. Güncellenen veriler anında canlı web ve mobil izleme panellerine yansıtılır; eğer belirlenen herhangi bir kritik eşik aşılırsa, Telegram botu otomatik olarak devreye girerek sistem yöneticilerine anlık acil durum bildirimleri gönderir.

## 👨‍💻 Geliştiriciler

- **Muhammet Melih DEMİRCİ** 
- **Semanur GÜVEN**

## ⚠️ Güvenlik Notu

Bu repoda güvenlik amacıyla aşağıdaki kritik bilgiler paylaşılmamıştır:
- Firebase API anahtarları ve servis hesabı bilgileri
- Telegram Bot Token ve Chat ID bilgileri
- Sunucu ağına ait özel erişim bilgileri

📄 **Note:** Proje Raporu Dosyalar Kısmında Ektedir. `bulut_bilişim_rapor (1).pdf`

