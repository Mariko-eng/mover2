import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/trickets/BusCompanyTicketTile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/loading.dart';

class AllTickets extends StatefulWidget {
  const AllTickets({Key? key}) : super(key: key);

  @override
  _AllTicketsState createState() => _AllTicketsState();
}

class _AllTicketsState extends State<AllTickets> {
  BusCompany? busCompany;

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
            "Tickets".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
      body: FutureBuilder(
          future: fetchBusCompanies(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Center(
                child: Text("Something Went Wrong!"),
              );
            }
            if (!snapshot.hasData){
              return Center(child: LoadingWidget(),);
            }else{
              List<BusCompany>? companies = snapshot.data;
              if(companies  == null) {
                return Container();
              }
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: GestureDetector(
                            onTap: (){
                              _showSelectDialog(companies: companies!);
                            },
                            child: Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.red
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Row(
                                children: [
                                  Expanded(child: Text("Select Bus Company")),
                                  Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  busCompany != null ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(busCompany!.name.toUpperCase() +" "+ "Trips".toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red
                              ),
                            )
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ) : Container(),

                  busCompany == null ? Container() :
                  StreamBuilder(
                    stream: getMyBusCompanyTickets(
                        companyId: busCompany!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        if (kDebugMode) {
                          print(snapshot.error);
                          return Expanded(
                            child: const Center(
                              child: Text("Something Went Wrong!"),
                            ),
                          );
                        }
                      }
                      if (!snapshot.hasData){
                        return Expanded(child: Center(child: LoadingWidget()));
                      }else{
                        List<TripTicket>? tickets = snapshot.data;
                        if(tickets == null) {
                          return Container();
                        }
                        if(tickets.isEmpty) {
                          return Expanded(
                            child: Center(
                              child: Text("No Tickets For Now!"),
                            ),
                          );
                        }else{
                          return Expanded(
                            child: ListView.builder(
                              itemCount: tickets.length,
                              itemBuilder: (context, int i) {
                                TripTicket ticket = tickets[i];
                                return
                                            FutureBuilder(
                                                  future: ticket.setTripData(context),
                                                  // ignore: missing_return
                                                  builder: (context, snapshot) {
                                                    TripTicket? ticket = snapshot.data;
                                                    switch (snapshot.connectionState) {
                                                      case ConnectionState.waiting:
                                                          return LoadingWidget();

                                                      case ConnectionState.none:
                                                        return Container(
                                                          child: const Text(
                                                            'No Tickets',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Color(0xFFE4191D), fontSize: 20.0),
                                                          ),
                                                        );
                                                      case ConnectionState.active:
                                                        return const Text('Searching... ');
                                                      case ConnectionState.done:
                                                        return ticket == null
                                                            ? Container()
                                                            : BusCompanyTicketTile(tripTicket: ticket);
                                                    }
                                                  },
                                                );
                              },
                            ),
                          );
                        }
                      }
                      // return Center(child: Loading());
                    },
                  ),
                ],
              );
            }
          }
      ),
    );
  }

  Future<void> _showSelectDialog({required List<BusCompany> companies}) async {
    await Get.defaultDialog(
        title: "Select Company",
        titleStyle: const TextStyle(
            color: Colors.red,
            fontSize: 15,
            fontWeight: FontWeight.w600
        ),
        barrierDismissible: true,
        content: SizedBox(
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...companies.map((item) => Container(
                  child: Card(
                    child: ListTile(
                      onTap: (){
                        setState(() {
                          busCompany = item;
                        });
                        Get.back();
                      },
                      title: Text(item.name),
                    ),
                  ),
                )).toList()
              ],
            ),
          ),
        ));
  }

}
