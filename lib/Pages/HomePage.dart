import 'dart:convert';
import 'dart:io';

import 'package:HasatDefteri/Pages/Deneme.dart';
import 'package:HasatDefteri/Pages/TarlaPage.dart';
import 'package:HasatDefteri/data/TarlaDAO.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:HasatDefteri/Pages/GenelMasrafPage.dart';
import 'package:HasatDefteri/constObjects.dart';
import 'package:HasatDefteri/Models/Tarla.dart';

Colorss color=Colorss();

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
        appBar: AppBar(
          title: Text('Hasat Defteri',
              style: TextStyle(color: HexColor(color.cGreen2))),
          actions: const [
            // Profil ikonu
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white60,
                backgroundImage: AssetImage("lib/assets/icon/Adsız.png"),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
              () => NavigationBar(
              indicatorColor: Colors.yellow.shade700.withOpacity(0.5),
              height: 60,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
              destinations: [
                const NavigationDestination(
                    icon: Icon(Icons.home_filled), label: "Ana Sayfa"),

                NavigationDestination(
                    icon: Icon(Icons.analytics), label: "Toplam Gider"),
              ]),
        ),
        drawer: Drawer(
          // Çekmece menüsü
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text('Menü Başlığı'),
              ),
              ListTile(
                title: Text('Tarla'),
                onTap: () {
                  // Tıklandığında yapılacak işlemler
                },
              ),
              ListTile(
                title: Text('Mahsül'),
                onTap: () {
                  // Tıklandığında yapılacak işlemler
                },
              ),
            ],
          ),
        ),
        body: Obx(() => controller.screens[controller.selectedIndex.value]));
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [TarlaList(), ExpenseAnalyticsPage()];
}
