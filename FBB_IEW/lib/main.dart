import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'model/RamadanModel.dart';

void main() {
  runApp(const MyApp());
}

const platform = OptionalMethodChannel('com.orange.omnis/iew_fbb');

Future<dynamic> getPrize() async {
  Map<dynamic, dynamic> str = jsonDecode(
      '{"code":"ramadan","logo":null,"startDate":"2023-03-12T00:00:00Z","endDate":"2023-04-20T00:00:00Z","ramadanStartDate":"2023-03-14T00:00:00Z","ramadanEndDate":"2023-04-15T00:00:00Z","prizes":[],"vouchers":[],"question":{"code":"3","number":3,"text":"يطلق على سورة الملك أيضاً:","answered":false,"title":"اليوم الثالث","answers":[{"id":10354977,"correct":false,"text":"خدمات إضافية بأسعار تفضيلية على اشتراك الإنترنت الثابت"},{"id":10354979,"correct":false,"text":"خصومات واسعة لمشتركي خطوط الخلوي"},{"id":10354978,"correct":false,"text":"Additional services for ADSL and Fiber subscribers"},{"id":10354976,"correct":false,"text":"تبارك"}]},"points":0,"returning":false}');
  // {"data":{"code":"ramadan","logo":null,"startDate":"2023-03-12T00:00:00Z","endDate":"2023-04-20T00:00:00Z","ramadanStartDate":"2023-03-14T00:00:00Z","ramadanEndDate":"2023-04-15T00:00:00Z","prizes":[],"vouchers":[],"question":{"code":"3","number":3,"text":"يطلق على سورة الملك أيضاً:","answered":false,"title":"اليوم الثالث","answers":[{"id":10354977,"correct":false,"text":"الفاتحة"},{"id":10354979,"correct":false,"text":"مريم"},{"id":10354978,"correct":false,"text":"الرحمن"},{"id":10354976,"correct":false,"text":"تبارك"}]},"points":0,"returning":false},"path":"/","status":200,"timestamp":"2023-03-14T10:43:04.109189Z"}
  Map<dynamic, dynamic> prize = str; //Map<dynamic, dynamic>();

  Map<dynamic, dynamic> prizes =
      await platform.invokeMethod('fawaneesInfo') ?? prize;
  return RamadanModel.$UserFromJson(prizes);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const QuestionWidget(),
    );
  }
}

Future<void> end() async {
  await platform.invokeMethod('back');
}

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<QuestionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    List<String> dynamicItems = [
      'INT0410948',
      '00962 ( 6 ) 5833456',
      '00776800000'
    ];
    List<String> anotherDynamicItems = [
      'INT0410948',
      '00962 ( 6 ) 5833456',
      '00776800000'
    ];

    void updateDynamicList() {
      setState(() {
        dynamicItems = ['Item A', 'Item B', 'Item C', 'Item D', 'Item E'];
      });
    }

    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return WillPopScope(
        onWillPop: () async {
          end();
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                color: Colors.black,
                icon: const Icon(Icons.arrow_back),
                onPressed: () => end(), //Navigator.of(context).pop(),
              ),
              elevation: 0,
            ),
            body: FutureBuilder(
                future: Future.wait([getPrize()]),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print("test ${snapshot.error}");
                  }
                  if (snapshot.hasData) {
                    var userList = snapshot.data![0];
                    RamadanModel ramadanModel = userList;
                    print("test2 ${ramadanModel.code}");
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: dynamicItems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: Icon(Icons.star),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dynamicItems[index],
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Some Other Info",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 17),
                                child: Text(
                                  "Verified Lines",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFE76900),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: anotherDynamicItems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: Icon(Icons.warning),

                                    // Change the icon to "warning"

                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dynamicItems[index],
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Some Other Info",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                })));
  }

  void setElevatedButton() {
    // setState(() {
    //   questions.isUnLocked = true;
    // });
  }

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  Widget build1(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.amber[colorCodes[index]],
            child: Center(child: Text('Entry ${entries[index]}')),
          );
        });
  }
}
