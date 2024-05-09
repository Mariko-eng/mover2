import 'package:bus_stop_develop_admin/models/user/userClientModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SuperAllClientsListView extends StatefulWidget {
  const SuperAllClientsListView({Key? key}) : super(key: key);

  @override
  _AllClientsState createState() => _AllClientsState();
}

class _AllClientsState extends State<SuperAllClientsListView> {
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
          Text("Registered Clients".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),)
      ),
      body: StreamBuilder(
        stream: getAllClients(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            if (kDebugMode) {
              print(snapshot.error);
            }
          }
          if(snapshot.hasData){
            List<UserClientModel>? data = snapshot.data;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, int index){
                    return ListTile(
                      onTap: (){},
                      leading: const Icon(Icons.arrow_right_sharp),
                      title: Text(data[index].name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index].email),
                          Text(data[index].phone),
                        ],
                      ),
                    );
                  }),
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }
}
