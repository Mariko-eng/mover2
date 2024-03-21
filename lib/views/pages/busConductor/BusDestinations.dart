import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/destination/destination.dart';
import 'package:bus_stop_develop_admin/views/pages/busConductor/busParks.dart';

class BusDestinationsConductor extends StatefulWidget {
  final BusCompany company;

  const BusDestinationsConductor({super.key, required this.company});

  @override
  State<BusDestinationsConductor> createState() =>
      _BusDestinationsConductorState();
}

class _BusDestinationsConductorState extends State<BusDestinationsConductor> {
  final _searchCtr = TextEditingController();

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
          title: Text(
            "All Destinations".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _searchCtr,
                    onChanged: (String? val) {
                      if (val != null) {
                        if (val.trim().isNotEmpty) {
                          setState(() {});
                        }
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Search Here...",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red)),
                        suffixIcon: const Icon(
                          Icons.search,
                          color: Colors.red,
                        )),
                  ),
                ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
                stream: getAllDestinations(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Expanded(
                        child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Something has Gone Wrong!"),
                        ],
                      ),
                    ));
                  }
                  if (!snapshot.hasData) {
                    return const Expanded(
                        child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ));
                  } else {
                    List<Destination>? data = snapshot.data;
                    return Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (context, int i) {
                            if (_searchCtr.text.trim().isNotEmpty) {
                              if (data[i].name.toLowerCase().contains(
                                  _searchCtr.text.trim().toLowerCase())) {
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      Get.to(() => BusParkLocationsConductor(
                                          company: widget.company,
                                          destination: snapshot.data![i]));
                                    },
                                    leading: const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                    title: Text(snapshot.data![i].name),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 30,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.red[900],
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "View Park Locations",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }
                            {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => BusParkLocationsConductor(
                                        company: widget.company,
                                        destination: snapshot.data![i]));
                                  },
                                  leading: const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                  title: Text(snapshot.data![i].name),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.red[900],
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "View Park Locations",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                    ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
