# 🛡️ Akıllı Sunucu Odası ve Veri Merkezi İzleme Sistemi

Bu proje, veri merkezleri ve kurumsal sunucu odalarındaki çevresel ve elektriksel parametrelerin 7/24 kesintisiz izlenmesi amacıyla geliştirilmiş IoT tabanlı bir güvenlik ve telemetri sistemidir.

Sistem, fiziksel ortamdaki değişimleri anlık olarak algılayarak, donanım arızalarını henüz gerçekleşmeden proaktif bir şekilde tespit etmekte ve yöneticilere çoklu platformlar üzerinden raporlamaktadır.


## 🚀 Kullanılan Donanımlar

* Deneyap Kart 1A v2: Ana mikrodenetleyici ve bulut haberleşme birimi.
* Deneyap Sıcaklık ve Nem Sensörü: İklimlendirme denetimi.
* Deneyap Mikrofon Sensörü: Fan arızaları için akustik izleme. 
* Deneyap Mini OLED Ekran: Lokal veri gösterimi.
* PZEM-004T Akım Trafolu Akım Gerilim Enerji Multimetre Modülü.


## 💻 Kullanılan Yazılımlar ve Teknolojiler

- Arduino IDE
- Python
- Flutter
- Google Firebase Realtime Database
- Telegram Bot API & Firebase Cloud Messaging (FCM)
- C/C++
- HTML / CSS / JavaScript
* Netlify

  
## 🔑 Sistem Özellikleri

- Gerçek Zamanlı Telemetri: Sıcaklık, nem, ses ve enerji verilerinin anlık takibi.
- Proaktif Uyarı Sistemi: Kritik eşik aşıldığında Telegram ve Push bildirimleri ile acil durum bilgilendirmesi.
- Çapraz Platform Desteği: Flutter sayesinde Android ve Web üzerinden aynı anda izleme.
- Hata Toleransı: Python Gateway katmanı ile veri kayıplarını önleyen yerel loglama mekanizması.
- Görselleştirme: Canlı grafiklerle anlık enerji tüketim ve ortam analizi.

## 📂 Proje Dosyaları

| Dosya | Açıklama |

| Arduino_Code.ino | Deneyap Kart üzerindeki sensör okuma ve Wi-Fi haberleşme kodu |
| data_gateway.py | Python tabanlı seri port dinleme ve Firebase veri aktarım kodu |
| sunucu_odasi_app | Flutter mobil ve web projesi kaynak kodları |
| Rapor.pdf | Detaylı proje bitirme raporu |

## 📊 Sistem Mimarisi

Sistem; Sensörler $\rightarrow$ Deneyap Kart $\rightarrow$ Python Gateway $\rightarrow$ Firebase $\rightarrow$ Flutter/Telegram veri hattını izler. Deneyap Kart'tan gelen ham veriler, Python tabanlı bir Gateway üzerinden işlenerek Firebase'e aktarılır. Buradan tetiklenen veriler, hem canlı mobil/web arayüzlerine yansıtılır hem de acil durumlarda Telegram botu üzerinden yöneticiye bildirim olarak iletilir.

## 👨‍💻 Geliştiriciler

- Muhammet Melih DEMİRCİ 
- Semanur GÜVEN

## ⚠️ Güvenlik Notu

Bu repoda güvenlik amacıyla aşağıdaki kritik bilgiler paylaşılmamıştır:
- Firebase API anahtarları ve servis hesabı bilgileri
- Telegram Bot Token ve Chat ID bilgileri
- Sunucu ağına ait özel erişim bilgileri
