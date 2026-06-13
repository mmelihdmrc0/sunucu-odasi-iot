import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  
  runApp(const SunucuOdasiApp());
}

class SunucuOdasiApp extends StatelessWidget {
  const SunucuOdasiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akıllı Sunucu Odası',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0F19),
        primaryColor: Colors.blueAccent,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final String firebaseUrl = "https://bulutbilisim-2b61c-default-rtdb.firebaseio.com/sunucu_odasi.json";
  
  double sicaklik = 0.0;
  double nem = 0.0;
  double basinc = 0.0;
  double desibel = 0.0;
  bool isOnline = false;
  Timer? _timer;

  final FlutterLocalNotificationsPlugin bildirimEklentisi = FlutterLocalNotificationsPlugin();
  String sonAlarmZamani = "";

  @override
  void initState() {
    super.initState();
    _bildirimleriKur();
    _veriCek();
    
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _veriCek();
      _alarmKontrolEt(); 
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _bildirimleriKur() async {
    const AndroidInitializationSettings androidAyarlar = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings ayarlar = InitializationSettings(android: androidAyarlar);
    
    await bildirimEklentisi.initialize(settings: ayarlar);
  }

  Future<void> _alarmKontrolEt() async {
    try {
      final res = await http.get(Uri.parse('https://bulutbilisim-2b61c-default-rtdb.firebaseio.com/sunucu_odasi/alarm.json'));
      if (res.statusCode == 200 && res.body != "null") {
        final data = json.decode(res.body);
        final String gelenMesaj = data['mesaj'] ?? "Tehlike!";
        final String gelenZaman = data['zaman'].toString();

        if (gelenZaman != sonAlarmZamani) {
          if (sonAlarmZamani != "") { 
            _bildirimGoster(gelenMesaj);
          }
          sonAlarmZamani = gelenZaman;
        }
      }
    } catch (e) {
      // Hata durumunda yoksay
    }
  }

  Future<void> _bildirimGoster(String mesaj) async {
    const AndroidNotificationDetails androidDetay = AndroidNotificationDetails(
      'alarm_kanali', 'Sunucu Odası Alarmları',
      importance: Importance.max,
      priority: Priority.high,
      color: Colors.redAccent,
      icon: '@mipmap/ic_launcher',
    );
    const NotificationDetails detay = NotificationDetails(android: androidDetay);
    
    await bildirimEklentisi.show(
      id: 0, 
      title: '🚨 KRİTİK SUNUCU UYARISI', 
      body: mesaj, 
      notificationDetails: detay,
    );
  }

  Future<void> _veriCek() async {
    try {
      final response = await http.get(Uri.parse(firebaseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null) {
          setState(() {
            sicaklik = (data['sicaklik'] ?? 0.0).toDouble();
            nem = (data['nem'] ?? 0.0).toDouble();
            basinc = (data['basinc'] ?? 0.0).toDouble();
            desibel = (data['ses_desibel'] ?? 0.0).toDouble();
            isOnline = true;
          });
        }
      } else {
        setState(() => isOnline = false);
      }
    } catch (e) {
      setState(() => isOnline = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "SERVER ROOM TELEMETRY",
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
                final res = await http.get(Uri.parse('https://bulutbilisim-2b61c-default-rtdb.firebaseio.com/sunucu_odasi/enerji.json'));
                if (res.statusCode == 200 && res.body != "null") {
                  return json.decode(res.body);
                }
                return null;
              }),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(color: Colors.lightBlueAccent),
                    ),
                  );
                }

                final veri = snapshot.data as Map<String, dynamic>? ?? {};
                final voltaj = veri['voltaj_V'] ?? 0.0;
                final akim = veri['akim_A'] ?? 0.0;
                final guc = veri['guc_W'] ?? 0.0;

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.electric_bolt, color: Colors.amberAccent, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "ANLIK ENERJİ TÜKETİMİ", 
                            style: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.bold, letterSpacing: 1)
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white12, height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text("VOLTAJ", style: TextStyle(fontSize: 12, color: Colors.white54)),
                              const SizedBox(height: 4),
                              Text("${voltaj.toStringAsFixed(1)} V", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                            ],
                          ),
                          Column(
                            children: [
                              const Text("AKIM", style: TextStyle(fontSize: 12, color: Colors.white54)),
                              const SizedBox(height: 4),
                              Text("${akim.toStringAsFixed(3)} A", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                            ],
                          ),
                          Column(
                            children: [
                              const Text("GÜÇ", style: TextStyle(fontSize: 12, color: Colors.white54)),
                              const SizedBox(height: 4),
                              Text("${guc.toStringAsFixed(1)} W", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    color: isOnline ? Colors.greenAccent : Colors.redAccent,
                    size: 16,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    isOnline ? "SİSTEM ÇEVRİMİÇİ - BAĞLANTI AKTİF" : "BAĞLANTI BEKLENİYOR...",
                    style: TextStyle(
                      color: isOnline ? Colors.greenAccent : Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildSensorCard("Sıcaklık", "${sicaklik.toStringAsFixed(1)} °C", Icons.thermostat, Colors.orangeAccent, sicaklik > 28.0),
                  _buildSensorCard("Nem Oranı", "%${nem.toStringAsFixed(1)}", Icons.water_drop, Colors.blueAccent, nem > 51.0),
                  _buildSensorCard("Atmosfer Basıncı", "${basinc.toStringAsFixed(0)} hPa", Icons.speed, Colors.purpleAccent, basinc > 1020.0),
                  _buildSensorCard("Gürültü", "${desibel.toStringAsFixed(1)} dB", Icons.volume_up, Colors.yellowAccent, desibel > 75.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorCard(String baslik, String deger, IconData ikon, Color renk, bool alarmVarMi) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: alarmVarMi ? Colors.redAccent : Colors.white12,
          width: alarmVarMi ? 2.0 : 1.0,
        ),
        boxShadow: alarmVarMi ? [const BoxShadow(color: Colors.redAccent, blurRadius: 10, spreadRadius: 1)] : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(ikon, size: 40, color: alarmVarMi ? Colors.redAccent : renk),
          const SizedBox(height: 15),
          Text(
            baslik.toUpperCase(),
            style: const TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 1),
          ),
          const SizedBox(height: 5),
          Text(
            deger,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: alarmVarMi ? Colors.redAccent : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}