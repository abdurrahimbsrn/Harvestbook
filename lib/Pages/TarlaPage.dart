import 'package:HasatDefteri/Algoritmalar.dart';
import 'package:HasatDefteri/Pages/tarlaMasraf.dart';
import 'package:HasatDefteri/data/TarlaDAO.dart';
import 'package:HasatDefteri/data/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Models/Tarla.dart';
import '../constObjects.dart';

// Renklerinizi tanımladığınız sınıf
Colorss color = Colorss();
var dbHelper = DatabaseHelper();


class TarlaList extends StatelessWidget {
  // Controller'ı tanımlayın ve başlatın
  final TarlaListController controller = Get.put(TarlaListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  _showAddExpenseModal(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor(color.cGreen2),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.5,
                        color: HexColor(color.cYellow3),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  "TARLA EKLE",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

          // Tarla kartları
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.tarlaList.length,
                itemBuilder: (BuildContext context, int position) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FarmDetailPage(
                            tarlaID: controller.tarlaList[position].tarlaID,
                            tarlaAdi: controller.tarlaList[position].tarlaAdi,
                            toplamMasraf: controller.tarlaList[position].toplamMasraf,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: HexColor(color.cGreen2)),
                      ),
                      elevation: 4,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                            child: Image.asset(
                                  TarlaImageGenerator.imageAdress(
                                      controller.tarlaList[position].tarlaID),
                                  height: 80,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  controller.tarlaList[position].tarlaAdi,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                ),
                                Spacer(),
                                Text(
                                  'Masraf: ${controller.tarlaList[position].toplamMasraf.toStringAsFixed(2)} ₺',
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage("lib/assets/icon/seed.png"),
                                  width: 15,
                                ),
                                SizedBox(width: 5),
                                Text(
                                    controller.tarlaList[position].ekiliMahsul),
                                Spacer(),
                                Text(
                                  '${controller.tarlaList[position].donum} Dönüm',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TarlaListController extends GetxController {
  // Gözlemlenebilir tarla listesi
  var tarlaList = <Tarla>[].obs;

  int get tarlaCount => tarlaList.length;

  @override
  void onInit() {
    super.onInit();
    getTarla();
  }

  void getTarla() async {
    var tarlaFuture = dbHelper.getTarlas();
    tarlaFuture.then((data) {
      tarlaList.value = data.cast<Tarla>(); // Verileri güncelleyin
    });
  }

  // Yeni tarla ekleme fonksiyonu
  Future<void> tarlaEkle(Tarla yeniTarla) async {
    var result = await dbHelper.insertTarla(yeniTarla);
    if (result > 0) {
      tarlaList.add(yeniTarla); // Listeyi güncelleyin

      txtAdi.clear();
      txtDonum.clear();
      txtEkiliMahsul.clear();
      print('Tarla başarıyla eklendi.');
      Get.back(); // Modalı kapat
    } else {
      print('Tarla eklenemedi.');
    }
  }
}

var txtAdi = TextEditingController();
var txtDonum = TextEditingController();
var txtEkiliMahsul = TextEditingController();

// Tarla ekleme yarım ekranı
void _showAddExpenseModal(BuildContext context) {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      color: HexColor(color.cYellow3),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Tarla Ekle",
                      style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Tarla İsmi',
                      ),
                      controller: txtAdi,
                      onChanged: (text) {
                        // Seçilen masraf türü güncellendiğinde yapılacak işlemler
                      },
                    ),
                    TextField(
                      controller: txtDonum,
                      decoration: const InputDecoration(
                        labelText: 'Dönüm',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  TextField(
                    controller: txtEkiliMahsul,
                    decoration: const InputDecoration(
                      labelText: 'Ekili Mahsül',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      var yeniTarla = Tarla(
                        tarlaAdi: txtAdi.text,
                        ekiliMahsul: txtEkiliMahsul.text,
                        donum: int.tryParse(txtDonum.text) ?? 0,
                        resimAdresi: 'lib/assets/tarla1.jpg',
                        eklemeTarihi:
                            "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                      );

                      // Yeni tarla ekle
                      Get.find<TarlaListController>().tarlaEkle(yeniTarla);
                    },
                    child: Text(
                      'Ekle',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor(color.cGreen2),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
