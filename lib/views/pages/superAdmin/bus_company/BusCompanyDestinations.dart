import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/destination/destination.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/destinations/park_locations_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BusCompanyDestinationsListView extends StatefulWidget {
  final BusCompany company;
  const BusCompanyDestinationsListView({super.key, required this.company});

  @override
  State<BusCompanyDestinationsListView> createState() => _BusCompanyDestinationsListViewState();
}

class _BusCompanyDestinationsListViewState extends State<BusCompanyDestinationsListView> {
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
                width: 20,height: 25,
                child: Image.asset('assets/images/back_arrow.png',)),
          ),
          title:
          Text("All Destinations".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),)
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
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
                                borderSide: BorderSide(color: Colors.red)),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.red,
                            )),
                      ),
                    ))
              ],
            ),
            SizedBox(height: 10,),
            StreamBuilder(
                stream: getAllDestinations(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
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
                                          Get.to(() => BusParkLocationsListView(company: widget.company, destination: snapshot.data![i]));
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
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: const [
                                                      Icon(Icons.edit,
                                                        color: Colors.white,
                                                        size: 15,
                                                      ),
                                                      SizedBox(width: 5,),
                                                      Text("Edit Park Locations",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                        ),
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
                                }{
                                  return Card(
                                    child: ListTile(
                                      onTap: () {
                                        Get.to(() => BusParkLocationsListView(company: widget.company, destination: snapshot.data![i]));
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
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(Icons.edit,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                    SizedBox(width: 5,),
                                                    Text("Edit Park Locations",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),
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

