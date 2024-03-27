import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop_develop_admin/views/auth/login.dart';
import 'package:bus_stop_develop_admin/views/dashboard/busAdmin.dart';
import 'package:bus_stop_develop_admin/views/dashboard/busConductor.dart';
import 'package:bus_stop_develop_admin/views/dashboard/superBusAdmin.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:bus_stop_develop_admin/views/shared/page404.dart';
import 'package:bus_stop_develop_admin/controllers/authProvider.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    if (userProvider.isLoading) {
      return const LoadingWidget();
    } else {
      if (userProvider.userModel == null) {
        return const LoginScreen();
      } else {
        if(!userProvider.userModel!.isActive){
          userProvider.signOut();
        }else{
          if(userProvider.userModel!.group == "bus_conductor"){
            return DashboardBusConductor(user: userProvider.userModel!,);
          }else if(userProvider.userModel!.group == "bus_admin"){
            return DashboardBusAdmin(user: userProvider.userModel!,);
          }else if(userProvider.userModel!.group == "super_bus_admin"){
            return DashboardSuperAdmin(user: userProvider.userModel!,);
          }else{
            return Page404();
          }
        }
        return Page404();
      }
    }
  }
}

