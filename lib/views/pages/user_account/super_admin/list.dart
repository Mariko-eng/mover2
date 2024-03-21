import 'package:bus_stop_develop_admin/views/pages/user_account/super_admin/edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/user/userSuperAdminModel.dart';
import 'package:bus_stop_develop_admin/views/pages/user_account/super_admin/new.dart';
import 'package:get/get.dart';

class SuperAdminUserAccountsListView extends StatefulWidget {
  const SuperAdminUserAccountsListView({super.key});

  @override
  State<SuperAdminUserAccountsListView> createState() => _SuperAdminUserAccountsListViewState();
}

class _SuperAdminUserAccountsListViewState extends State<SuperAdminUserAccountsListView> {
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
          Text("Super Admin Accounts".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[900],
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SuperAdminUserAccountsNewView()));
          },
          child: Icon(Icons.add_box , color: Colors.white,)
      ),
      body: StreamBuilder(
        stream: getAdminAccounts(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            print(snapshot.error);
            // if (kDebugMode) {
            //   print(snapshot.error);
            // }
          }
          if(snapshot.hasData){
            List<SuperAdminUserModel>? data = snapshot.data;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, int index){
                    return Card(
                      child: ListTile(
                        onTap: (){
                          // _openBottomSheet( user: data[index]);
                        },
                        leading: const Icon(Icons.arrow_right_sharp),
                        title: Text(data[index].name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data[index].email),
                            Text(data[index].phoneNumber),
                            data[index].hotLine == "" ? Container() : Text(data[index].hotLine),

                            SizedBox(height: 10,),
                            Divider(),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.to(() => SuperAdminUserAccountsEditView(adminUserModel: data[index]));
                                  },
                                  child: Text("Edit Account",
                                  style: TextStyle(color: Colors.red,fontSize: 18),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        trailing: Icon(Icons.phone,color: Colors.green,),
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
