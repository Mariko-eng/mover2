import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop_develop_admin/models/info.dart';

class AdminInfoDetailView extends StatefulWidget {
  final InfoModel infoModel;

  const AdminInfoDetailView({super.key, required this.infoModel});

  @override
  State<AdminInfoDetailView> createState() => _AdminInfoDetailViewState();
}

class _AdminInfoDetailViewState extends State<AdminInfoDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfffdfdfd),
          elevation: 0,
          centerTitle: true,
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
            "News & Info",
            style: TextStyle(color: Colors.red[900]),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(widget.infoModel.title.toUpperCase(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
                )],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                      tag: widget.infoModel.id,
                      child: Image.network(
                        widget.infoModel.imageUrl,
                        height: 200,
                      )),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text(widget.infoModel.subTitle.toUpperCase(),
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w400
                  ),
                )],
              ),
              Divider(),
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.infoModel.description,
                    style: TextStyle(
                        color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
