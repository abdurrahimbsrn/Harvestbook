import 'package:HasatDefteri/data/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_circular_text/circular_text.dart';
import '../Models/Masraf.dart';
import '../constObjects.dart';

Colorss color = Colorss(); // Renklerinizi tanımladığınız sınıf
var dbHelper = DatabaseHelper();
List<Map<String, String>> expenses = [];
late int bunela=999;


MasrafListController masrafListController=Get.put(MasrafListController());

class FarmDetailPage extends StatefulWidget {
  final int? tarlaID;
  final String tarlaAdi;
  final double toplamMasraf;

  FarmDetailPage({
    required this.tarlaID,
    required this.tarlaAdi,
    required this.toplamMasraf,
  });

  @override
  _FarmDetailPageState createState() => _FarmDetailPageState();
}

class _FarmDetailPageState extends State<FarmDetailPage> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting(
        'tr_TR', null); // Türkçe uluslararasılaştırma verilerini başlat
  }

  final amountFormat = NumberFormat("#,##0.00", "tr_TR");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tarlaAdi),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 6),
            child: IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(
                Icons.delete_outline_rounded,
                color: Colors.red.shade900,
              ),
              style: IconButton.styleFrom(iconSize: 32),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toplam masraf gösterimi
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: HexColor(color.cGreen2)),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 35,
                    decoration: BoxDecoration(
                      color: HexColor(color.cGreen2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(9),
                        topRight: Radius.circular(9),
                      ),
                      border: Border.all(color: HexColor(color.cGreen2)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Toplam Masraf: " + "${widget.toplamMasraf}" + " TL",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 200,
                            child: FuelIndicator(
                              imageUrl: 'lib/assets/icon/iconYakit.png',
                              label: 'YAKIT',
                              percentage: 0.20,
                              color1: Colors.green.shade900,
                              color2: Colors.greenAccent,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 200,
                            child: FuelIndicator(
                              imageUrl: 'lib/assets/icon/iconGubre.png',
                              label: 'GÜBRE',
                              percentage: 0.80,
                              color1: Colors.yellow.shade700,
                              color2: Colors.yellowAccent.shade700,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 200,
                            child: FuelIndicator(
                              imageUrl: 'lib/assets/icon/iconilac.png',
                              label: 'İLAÇ',
                              percentage: 0.80,
                              color1: Colors.red.shade900,
                              color2: Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(" Diğer Masraflar: 2.350.000"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(bunela.toString()),
            // Masraflar listesi
            const Text(
              'Masraflar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Obx(
                    () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: masrafListController.masrafList.length,
                  itemBuilder: (context, position) {
                    final masraf = masrafListController.masrafList[position];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: HexColor(color.cGreen2),
                          width: 2.0,
                        ),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: HexColor(color.cGreen2),
                              width: 2.0,
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              '${masraf.masrafAdi} - ${masraf.ucret}₺',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(masraf.aciklama),
                            trailing: Text(
                              DateFormat('dd MMMM', 'tr_TR').format(DateTime.now()),
                              style: const TextStyle(fontSize: 12),
                            ),
                            onTap: () {
                              // Masraf düzenleme işlemi
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),


            const SizedBox(
              height: 55,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddExpenseModal(context);
        },
        label: const Text(
          'Yeni Masraf Ekle',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: HexColor(color.cGreen2),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  var masrafAdiController = TextEditingController();

  // Masraf ekleme yarım ekranı
  void _showAddExpenseModal(BuildContext context) {
    String selectedExpenseType = 'Yakıt';
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
                  children: <Widget>[
                    Text('Yeni Masraf Ekle',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Masraf Türü', style: TextStyle(fontSize: 18)),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        ChoiceChip(
                          label: Text('Yakıt'),
                          selected: selectedExpenseType == 'Yakıt',
                          onSelected: (bool selected) {
                            setModalState(() {
                              selectedExpenseType = 'Yakıt';
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text('İlaç'),
                          selected: selectedExpenseType == 'İlaç',
                          onSelected: (bool selected) {
                            setModalState(() {
                              selectedExpenseType = 'İlaç';
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text('Gübre'),
                          selected: selectedExpenseType == 'Gübre',
                          onSelected: (bool selected) {
                            setModalState(() {
                              selectedExpenseType = 'Gübre';
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text('Tohum'),
                          selected: selectedExpenseType == 'Tohum',
                          onSelected: (bool selected) {
                            setModalState(() {
                              selectedExpenseType = 'Tohum';
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text('Sulama'),
                          selected: selectedExpenseType == 'Sulama',
                          onSelected: (bool selected) {
                            setModalState(() {
                              selectedExpenseType = 'Sulama';
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text('İşçi'),
                          selected: selectedExpenseType == 'İşçi',
                          onSelected: (bool selected) {
                            setModalState(() {
                              selectedExpenseType = 'İşçi';
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text('Hasat'),
                          selected: selectedExpenseType == 'Hasat',
                          onSelected: (bool selected) {
                            setModalState(() {
                              selectedExpenseType = 'Hasat';
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text('Diğer'),
                          selected: selectedExpenseType == 'Diğer',
                          onSelected: (bool selected) {
                            setModalState(() {
                              selectedExpenseType = 'Diğer';
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Diğer seçildiğinde gösterilecek TextField
                    if (selectedExpenseType == 'Diğer')
                      TextField(
                        maxLength: 15, // En fazla 15 karakter
                        controller: masrafAdiController,
                        decoration: const InputDecoration(
                          labelText: 'Diğer Masraf Türü',
                        ),
                        onChanged: (text) {
                          // Seçilen masraf türü güncellendiğinde yapılacak işlemler
                        },
                      ),

                    TextField(
                      controller: amountController,
                      decoration: const InputDecoration(
                        labelText: 'Tutar',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Açıklama',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        /*setState(() {
                          expenses.add({
                            'type': selectedExpenseType,
                            'amount': amountController.text,
                            'description': descriptionController.text,
                          });
                        });*/

                        if (masrafAdiController.text != null)
                          selectedExpenseType = masrafAdiController.text;

                        var yeniTarla = Masraf(
                            masrafAdi: selectedExpenseType,
                            aciklama: descriptionController.text,
                            eklemeTarihi:
                                "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                            ucret: amountController.text as double);

                        // Yeni tarla ekle
                        Get.find<MasrafListController>().masrafEkle(yeniTarla);

                        Navigator.pop(context); // Modal Bottom Sheet'i kapatma
                      },
                      child: Text('Ekle'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
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
}

// Yüzdelik gösterim widgeti
class FuelIndicator extends StatelessWidget {
  final String imageUrl;
  final String label;
  final double percentage;
  final Color color1;
  final Color color2;

  FuelIndicator({
    required this.imageUrl,
    required this.label,
    required this.percentage,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 10.0,
          animation: true,
          percent: percentage,
          center: Image.asset(
            imageUrl,
            height: 50.0,
            width: 50.0,
          ),
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: color2.withOpacity(0.3),
          progressColor: color1,
        ),
        Positioned(
          top: 50.0,
          child: CircularText(
            children: [
              TextItem(
                text: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                ),
                space: 10.0,
                startAngle: -90,
                startAngleAlignment: StartAngleAlignment.center,
                direction: CircularTextDirection.clockwise,
              ),
            ],
            radius: 70,
            position: CircularTextPosition.outside,
          ),
        ),
        Positioned(
          bottom: 20.0,
          child: Text(
            '12.000.000₺',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
class MasrafListController extends GetxController {
  // Gözlemlenebilir masraf listesi
  var masrafList = <Masraf>[].obs;

  int get masrafCount => masrafList.length;

  @override
  void onInit() {
    super.onInit();
    getMasraf();
  }

  void getMasraf() async {
    var masrafFuture = dbHelper.getMasrafs();
    masrafFuture.then((data) {
      masrafList.value = data.cast<Masraf>(); // Verileri güncelleyin
      bunela=masrafList.length;
    });
  }

  // Yeni masraf ekleme fonksiyonu
  Future<void> masrafEkle(Masraf yeniMasraf) async {
    var result = await dbHelper.insertMasraf(yeniMasraf);
    if (result > 0) {
      masrafList.add(yeniMasraf); // Listeyi güncelleyin

      //txtAdi.clear();
      //txtDonum.clear();
      //txtEkiliMahsul.clear();
      print('Tarla başarıyla eklendi.');
      Get.back(); // Modalı kapat
    } else {
      print('Tarla eklenemedi.');
    }
  }
}
