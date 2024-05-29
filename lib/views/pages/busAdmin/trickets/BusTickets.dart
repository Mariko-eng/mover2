import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/tripNumbers.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/trickets/BusTicketsActive.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/trickets/BusTicketsNonActive.dart';
import 'package:flutter/material.dart';

class BusAdminTicketsView extends StatefulWidget {
  final BusCompany company;
  const BusAdminTicketsView({Key? key, required this.company}) : super(key: key);

  @override
  _BusCompanyTicketsState createState() => _BusCompanyTicketsState();
}

class _BusCompanyTicketsState extends State<BusAdminTicketsView> {
  final _tripNoController = TextEditingController();
  final _tripIdController = TextEditingController();

  bool isAll = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      isAll = true;
      _tripNoController.text = "All Tickets";
      _tripIdController.text = "All Tickets";
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xfffdfdfd),
            elevation: 0,
            centerTitle: true,
            title: Column(
              children: [
                Text(
                  widget.company.name.toUpperCase(),
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.red[900],fontWeight: FontWeight.bold),
                ),
                Text(
                  "Tickets".toUpperCase(),
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue[900]),
                ),
              ],
            ),
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  width: 20,
                  height: 25,
                  child: Image.asset(
                    'assets/images/back_arrow.png',
                  )),
            ),
          ),
          body: Column(
            children: [
              FutureBuilder(
                  future: getAllTripsNumbersForBusCompany(
                      companyId: widget.company.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print("error");
                      print(snapshot.error);
                    }
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    List<TripNumbers>? data = snapshot.data;
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(30))),
                      child: TextFieldContainer(
                        child: TextField(
                          controller: _tripNoController,
                          readOnly: true,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(
                              fontSize: 17, color: Color(0xff62020a)),
                          cursorColor: Colors.red,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.search,
                              color: Color(0xff62020a),
                            ),
                            labelText: "Search Trip Number",
                            labelStyle:
                                TextStyle(fontSize: 12, color: Colors.black87),
                            border: InputBorder.none,
                          ),
                          onTap: () {
                            _showDestinations(context, data!);
                          },
                        ),
                      ),
                    );
                  }),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: const BoxDecoration(
                    color: Color(0xfffeecea),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(30))),
                child: const TabBar(labelColor: Color(0xff8c2636), tabs: [
                  Tab(
                    text: "ACTIVE TICKETS",
                  ),
                  Tab(
                    text: "INACTIVE TICKETS",
                  ),
                ]),
              ),
              Expanded(
                child: TabBarView(children: [
                  BusTicketsActive(
                    company: widget.company,
                    tripId: _tripIdController.text,
                  ),
                  BusTicketNonActive(
                      company: widget.company,
                      tripId: _tripIdController.text)
                ]),
              )
            ],
          ),
        ));
  }

  Future<void> _showDestinations(
      BuildContext context, List<TripNumbers> data) async {
    List sr = [];
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _ctr = TextEditingController();
          return StatefulBuilder(
              builder: (context, setState2) => AlertDialog(
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: LayoutBuilder(
                        builder: (ctx, constraints) {
                          return Column(
                            children: [
                              Container(
                                height: 50,
                                width: constraints.maxWidth,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: TextField(
                                      decoration: const InputDecoration(
                                          hintText:
                                              "Search Here (Enter Trip Number)",
                                          hintStyle: TextStyle(fontSize: 12),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red))),
                                      controller: _ctr,
                                      onChanged: (val) {
                                        List l = [];
                                        setState2(() {
                                          if (_ctr.text.isNotEmpty) {
                                            // data.add(_ctr.text);
                                            for (int i = 0;
                                                i < data.length;
                                                i++) {
                                              if (data[i]
                                                  .tripNumber
                                                  .toLowerCase()
                                                  .contains(_ctr.text
                                                      .toLowerCase())) {
                                                l.add(data[i]);
                                              }
                                            }
                                            sr = l;
                                            // print(l);
                                          } else {
                                            sr = l;
                                          }
                                        });
                                      },
                                    )),
                                    const Icon(Icons.search)
                                  ],
                                ),
                              ),
                              Container(
                                  height: constraints.maxHeight * 0.8,
                                  width: constraints.maxWidth,
                                  color: Colors.grey[200],
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: sr.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: sr.length,
                                          itemBuilder: (context1, int i) =>
                                              GestureDetector(
                                                onTap: () {
                                                  setState2(() {
                                                    _tripNoController.text =
                                                        sr[i].tripNumber;
                                                    _tripIdController.text =
                                                        sr[i].tripId;
                                                  });
                                                  Navigator.of(context).pop();
                                                  setState(() {});
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.arrow_right),
                                                    Text(sr[i].tripNumber),
                                                  ],
                                                ),
                                              ))
                                      : ListView.builder(
                                          itemCount: data.length,
                                          itemBuilder: (context1, int i) =>
                                              GestureDetector(
                                                onTap: () {
                                                  setState2(() {
                                                    _tripNoController.text =
                                                        data[i].tripNumber;
                                                    _tripIdController.text =
                                                        data[i].tripId;
                                                  });
                                                  Navigator.of(context).pop();
                                                  setState(() {});
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.arrow_right),
                                                    Text(data[i].tripNumber),
                                                  ],
                                                ),
                                              ))),
                            ],
                          );
                        },
                      ),
                    ),
                    actions: [],
                  ));
        });
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: size.width * 0.9,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xffe5e5e5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
