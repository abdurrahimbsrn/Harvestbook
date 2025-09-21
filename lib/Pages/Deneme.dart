import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Deneme(),
    );
  }
}

// Kontroller sınıfı
class TabControllerX extends GetxController {
  // Reaktif bir değişken oluşturuyoruz.
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

class Deneme extends StatelessWidget {
  // TabControllerX instance'ını alıyoruz
  final TabControllerX _tabControllerX = Get.put(TabControllerX());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İki Sekmeli TabBar - GetX'),
        bottom: TabBar(
          onTap: (index) {
            _tabControllerX.changeIndex(index);
          },
          tabs: [
            Tab(text: 'Sekme 1'),
            Tab(text: 'Sekme 2'),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() {
              return Container(
                height: 200,
                width: 200,
                color: _tabControllerX.selectedIndex.value == 0
                    ? Colors.blue
                    : Colors.green,
                child: Center(
                  child: Text(
                    _tabControllerX.selectedIndex.value == 0
                        ? 'Mavi Sekme'
                        : 'Yeşil Sekme',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              );
            }),
            SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text('Sekme 1 İçeriği'),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text('Sekme 2 İçeriği'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
