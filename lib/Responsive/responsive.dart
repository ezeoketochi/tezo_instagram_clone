import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezo_instagram/utils/dimensions.dart';

import '../providers/user_provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout(
      {Key? key,
      required this.mobileScreenLayout,
      required this.webScreenLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {


  @override
  Widget build(BuildContext context) { 


 addData () async {
    UserProvider _userprovider = Provider.of(context, listen: false);
     _userprovider.refreshUser();
  }


 @override
  void initState() {
    addData();
    super.initState();
  }


    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return widget.webScreenLayout;
      }

      return widget.mobileScreenLayout;
    }),);
  }



 
}


 