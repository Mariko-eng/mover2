import 'package:bus_stop_develop_admin/models/info.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/info/AdminInfoDetailView.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/info/AdminInfoEditView.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/info/AdminInfoNewView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AdminInfoListView extends StatefulWidget {
  const AdminInfoListView({super.key});

  @override
  State<AdminInfoListView> createState() => _AdminInfoListViewState();
}

class _AdminInfoListViewState extends State<AdminInfoListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfffdfdfd),
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
                width: 20,
                height: 25,
                child: Image.asset(
                  'assets/images/back_arrow.png',
                )),
          ),
          centerTitle: true,
          title: Text(
            "What's New".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[900],
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminInfoNewView()));
          },
          child: Icon(
            Icons.add_box,
            color: Colors.white,
          )),
      body: Column(
        children: [
          StreamBuilder<Object>(
              stream: getAllInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Expanded(
                      child: Center(child: Text("Something Went Wrong!")));
                }
                if (snapshot.hasData) {
                  List<InfoModel> data = snapshot.data as List<InfoModel>;
                  if (data.isEmpty) {
                    return Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 270,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      child: Image.asset(
                                        'assets/images/image11.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      height: 270,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border:
                                            Border.all(color: Colors.black26),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [0.35, 0.95, 1.0],
                                          colors: [
                                            Colors.transparent,
                                            Colors.black87,
                                            Colors.black,
                                            // Dark color at the bottom (adjust opacity as needed)
                                          ],
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Bus Stop",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Welcome to Bus Stop",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("No Posts Yet!!")],
                          ),
                        ],
                      ),
                    );
                  }
                  return Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: (){
                                  Get.to(() =>
                                      AdminInfoDetailView(
                                          infoModel: data[
                                          index]));
                                },
                                child: Container(
                                  height: 270,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: Container(
                                          height: 200,
                                          width: double.infinity,
                                          child: Hero(
                                              tag: data[index].id,
                                              child: Image.network(
                                                  data[index].imageUrl)),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          height: 270,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border:
                                                Border.all(color: Colors.black26),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [0.35, 0.95, 1.0],
                                              colors: [
                                                Colors.transparent,
                                                Colors.black87,
                                                Colors.black,
                                                // Dark color at the bottom (adjust opacity as needed)
                                              ],
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data[index].title,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    data[index].subTitle,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white),
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            Get.to(() =>
                                                                AdminInfoDetailView(
                                                                    infoModel: data[
                                                                        index]));
                                                          },
                                                          child: Icon(
                                                            Icons.visibility,
                                                            color: Colors.white,
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            Get.to(() =>
                                                                AdminInfoEditView(
                                                                    infoModel: data[
                                                                        index]));
                                                          },
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: Colors
                                                                .yellow[200],
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }));
                }
                return Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.red,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 270,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  child: Image.asset(
                                    'assets/images/image11.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: 270,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.black26),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [0.35, 0.95, 1.0],
                                      colors: [
                                        Colors.transparent,
                                        Colors.black87,
                                        Colors.black,
                                        // Dark color at the bottom (adjust opacity as needed)
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Bus Stop",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Welcome to Bus Stop",
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
