import 'dart:developer';

import 'package:district/service/service_api.dart';
import 'package:flutter/material.dart';

import 'model/data.model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShowDistrict(),
    );
  }
}

class ShowDistrict extends StatefulWidget {
  const ShowDistrict({Key? key}) : super(key: key);

  @override
  State<ShowDistrict> createState() => _ShowDistrictState();
}

class _ShowDistrictState extends State<ShowDistrict> {
  final addDistrict = TextEditingController();
  List<Datum> d = [];

  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    final data = await SeviceApi().fetchData();

    setState(() {
      d = data.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter API and ListView Example",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter ListView"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding: EdgeInsets.all(16),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: d.length,
                  itemBuilder: (c, i) {
                    return Column(
                      children: [
                        Text(d[i].attributes.name),
                      ],
                    );

                    //   return InkWell(
                    //       onTap: () {
                    //         showDialog(
                    //             context: context,
                    //             builder: (c) {
                    //               return AlertDialog(
                    //                 title: Text("data"),
                    //                 //
                    //               );
                    //
                    //             });
                    //       },
                    //       child: const Text('Click to add'),
                    //       );
                    // },
                  }),
              SizedBox(
                height: 50,
              ),
              FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return AlertDialog(
                            title: const Text('Add new district'),
                            content: Container(
                              height: 200,
                              child: Column(
                                children: [
                                  TextField(
                                    controller: addDistrict,
                                    decoration: InputDecoration(
                                        labelText: 'Enter district name'),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        await SeviceApi()
                                            .postData(addDistrict.text);
                                        setState(() {
                                          getdata();
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Add'))
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  tooltip: 'Add district',
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
