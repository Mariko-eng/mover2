import 'package:bus_stop_develop_admin/models/destination/destination.dart';
import 'package:bus_stop_develop_admin/views/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllDestinationsViewEdit extends StatefulWidget {
  final Destination destination;
  // final bool isView;
  const AllDestinationsViewEdit({Key? key,required this.destination}) : super(key: key);

  @override
  _AllDestinationsViewEditState createState() => _AllDestinationsViewEditState();
}

class _AllDestinationsViewEditState extends State<AllDestinationsViewEdit> {
  final _nameController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.destination.name;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
      body: LoadingWidget(),
    )
        : Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[200],
          iconTheme: const IconThemeData(color: Color(0xff62020a)),
          title: const Text(
            "Update Destination",
            style: TextStyle(color: Color(0xff62020a)),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldContainer(
                  child: TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(fontSize: 20),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.people_outline,
                        color: Color(0xff62020a),
                      ),
                      hintText: "Destination Name",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 10),
                  child: GestureDetector(
                    onTap: () async {
                      if (_nameController.text.isEmpty) {
                        Get.snackbar("Failed",
                            "Destination Name Is Empty",
                            colorText: Colors.white,
                            backgroundColor: Colors.purpleAccent);
                      } else if (_nameController.text.trim().length < 3 ){
                        Get.snackbar("Failed",
                            "Destination Name Is Very Short",
                            colorText: Colors.white,
                            backgroundColor: Colors.purpleAccent);
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        bool result = await updateDestination(destId: widget.destination.id,name: _nameController.text.trim().toUpperCase());
                        if (result == false) {
                          setState(() {
                            isLoading = false;
                          });
                          Get.snackbar(
                              "Failed To Update Destination", "Try Again",
                              colorText: Colors.white,
                              backgroundColor: Colors.purpleAccent);
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          Get.back();
                          Get.snackbar("Success", "Destination Updated",
                              colorText: Colors.white,
                              backgroundColor: Colors.greenAccent);
                        }
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 62,
                        decoration: BoxDecoration(
                            color:  Colors.green[800],
                            borderRadius:
                            BorderRadius.circular(20.0)),
                        child: const Text(
                          "Update Destination",
                          style: TextStyle(
                              fontSize: 20, color: Colors.white),
                        )),
                  ),
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 10),
                  child: GestureDetector(
                    onDoubleTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      bool result = await deleteDestination(destId: widget.destination.id);
                      if (result == false) {
                        setState(() {
                          isLoading = false;
                        });
                        Get.snackbar(
                            "Failed To Delete Destination", "Try Again",
                            colorText: Colors.white,
                            backgroundColor: Colors.purpleAccent);
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        Get.back();
                        Get.snackbar("Success", "Destination Deleted",
                            colorText: Colors.white,
                            backgroundColor: Colors.greenAccent);
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 62,
                        decoration: BoxDecoration(
                            color: const Color(0xff62020a),
                            borderRadius:
                            BorderRadius.circular(20.0)),
                        child: const Text(
                          "Delete Destination",
                          style: TextStyle(
                              fontSize: 20, color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ),
        )
    );
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xffe5e5e5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}

