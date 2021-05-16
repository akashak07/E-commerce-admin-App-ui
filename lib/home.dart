
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';




class Home extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Home> {
  String imageUrl;
  int _selectedIndex = 0;
  // uploadImage() async {
  //   final _firebaseStorage = FirebaseStorage.instance;
  //   final _imagePicker = ImagePicker();
  //   PickedFile image;
  // }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Upload"),
      content: Text("Uplaoded successfully!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      var filex = File(image.path);
      // File(image.path);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _firebaseStorage.ref()
            .child('images/imageName')
            .putFile(filex).onComplete;
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

     body:Container(
         child: SingleChildScrollView(
           child: Column(
             children: <Widget>[
               Align(
                 alignment: Alignment.center,
                 child: Container(
                     padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                     child:Text('Welcome Vendor',style: TextStyle(color: Colors.black45,fontSize: 40,fontWeight: FontWeight.bold),)
                 ),
               ),
               Container(
                 child:Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       TextButton(
                           child: Text(
                               "All items".toUpperCase(),
                               style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)
                           ),
                           style: ButtonStyle(
                               padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                               foregroundColor: MaterialStateProperty.all<Color>(Colors.black45),
                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                   RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(0.0),
                                       side: BorderSide(color: Colors.black45)
                                   )
                               )
                           ),
                           onPressed: () => null
                       ),
                       SizedBox(width: 10),
                       TextButton(
                           child: Text(
                               "Out of stock".toUpperCase(),
                               style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)
                           ),
                           style: ButtonStyle(
                               padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                               foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                   RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(0.0),
                                       side: BorderSide(color: Colors.blueAccent)
                                   )
                               )
                           ),
                           onPressed: () => null
                       ),
                     ]
                 )
               ),

               Container(
                 child: Align(
                   alignment: Alignment.center,
                   child: Container(
                       padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                       child:Text('Add New',style: TextStyle(color: Colors.black,fontSize: 25),)
                   ),
                 ),
               ),
               Container(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     Container(
                         child: Container(
                           height: 120,
                           width: 120,
                           color: Colors.grey[300],
                           child:  Align(
                             alignment: Alignment.bottomCenter,
                             child: TextButton(
                                 child: Text(
                                     "Upload".toUpperCase(),
                                     style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold)
                                 ),
                                 style: ButtonStyle(
                                     padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                     foregroundColor: MaterialStateProperty.all<Color>(Colors.black45),
                                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                         RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(0.0),
                                             side: BorderSide(color: Colors.black)
                                         )
                                     )
                                 ),
                                 onPressed: () {
                                   uploadImage();
                                 }
                             ),
                           ),
                         )
                     ),
                     Container(
                         child: Container(

                           height: 120,
                           width: 120,
                           color: Colors.grey[300],
                           child: Align(
                             alignment: Alignment.bottomCenter,
                             child:  TextButton(
                                 child: Text(
                                     "Upload".toUpperCase(),
                                     style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold)
                                 ),
                                 style: ButtonStyle(
                                     padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                     foregroundColor: MaterialStateProperty.all<Color>(Colors.black45),
                                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                         RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(0.0),
                                             side: BorderSide(color: Colors.black)
                                         )
                                     )
                                 ),
                                 onPressed: (){
                                   uploadImage();
                                 }
                             ),
                           ),
                         )
                     ),
                     Container(
                         child: Container(
                           height: 120,
                           width: 120,
                           color: Colors.grey[300],
                           child:  Align(
                             alignment: Alignment.bottomCenter,
                             child: TextButton(
                                 child: Text(
                                     "Upload".toUpperCase(),
                                     style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold)
                                 ),
                                 style: ButtonStyle(
                                     padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                     foregroundColor: MaterialStateProperty.all<Color>(Colors.black45),
                                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                         RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(0.0),
                                             side: BorderSide(color: Colors.black)
                                         )
                                     )
                                 ),
                                 onPressed: (){
                                   uploadImage();
                                 }
                             ),
                           ),
                         )
                     ),
                   ],
                 ),
               ),

               Container(
                 padding: EdgeInsets.fromLTRB(20, 20, 20, 5),

                 child: Card(
                   semanticContainer: true,
                   clipBehavior: Clip.antiAliasWithSaveLayer,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10.0),
                   ),
                   margin: EdgeInsets.all(1),
                   child: Container(
                     padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                     child: TextFormField(
                       decoration: InputDecoration(
                           border: InputBorder.none,
                           hintText: "Enter Category",
                           hintStyle: TextStyle(color: Colors.blueAccent)
                       ),
                     ),
                   ),
                 ),
               ),
               Container(
                 padding: EdgeInsets.fromLTRB(20, 5, 20, 5),

                 child: Card(
                   semanticContainer: true,
                   clipBehavior: Clip.antiAliasWithSaveLayer,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10.0),
                   ),
                   margin: EdgeInsets.all(1),
                   child: Container(
                     padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                     child: TextFormField(
                       decoration: InputDecoration(
                           border: InputBorder.none,
                           hintText: "Enter Product Name",
                           hintStyle: TextStyle(color: Colors.blueAccent)
                       ),
                     ),
                   ),
                 ),
               ),
               Container(
                 padding: EdgeInsets.fromLTRB(20, 5, 20, 5),

                 child: Card(
                   semanticContainer: true,
                   clipBehavior: Clip.antiAliasWithSaveLayer,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10.0),
                   ),
                   margin: EdgeInsets.all(1),
                   child: Container(
                     padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                     child: TextFormField(
                       decoration: InputDecoration(
                           border: InputBorder.none,
                           hintText: "Enter Prize Amount",
                           hintStyle: TextStyle(color: Colors.blueAccent)
                       ),
                     ),
                   ),
                 ),
               ),
               Container(
                 padding: EdgeInsets.fromLTRB(20, 5, 20, 5),

                 child: Card(
                   semanticContainer: true,
                   clipBehavior: Clip.antiAliasWithSaveLayer,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10.0),
                   ),
                   margin: EdgeInsets.all(1),
                   child: Container(
                     padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                     child: TextFormField(
                       decoration: InputDecoration(
                           border: InputBorder.none,
                           hintText: "Enter GST Amount",
                           hintStyle: TextStyle(color: Colors.blueAccent)
                       ),
                     ),
                   ),
                 ),
               ),
               Container(
                 padding: EdgeInsets.fromLTRB(20, 5, 20, 5),

                 child: Card(
                   semanticContainer: true,
                   clipBehavior: Clip.antiAliasWithSaveLayer,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10.0),
                   ),
                   margin: EdgeInsets.all(1),
                   child: Container(
                     padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                     child: TextFormField(
                       decoration: InputDecoration(
                           border: InputBorder.none,
                           hintText: "Enter Delivery Charge",
                           hintStyle: TextStyle(color: Colors.blueAccent)
                       ),
                     ),
                   ),
                 ),
               ),
               Container(
                 padding: EdgeInsets.fromLTRB(20, 5, 20, 5),

                 child: Card(
                   semanticContainer: true,
                   clipBehavior: Clip.antiAliasWithSaveLayer,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10.0),
                   ),
                   margin: EdgeInsets.all(1),
                   child: Container(
                     padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                     child: TextFormField(
                       decoration: InputDecoration(
                           border: InputBorder.none,
                           hintText: "Enter Offer(%)",
                           hintStyle: TextStyle(color: Colors.blueAccent)
                       ),
                     ),
                   ),
                 ),
               ),
               Container(
                 padding: const EdgeInsets.fromLTRB(20, 10,20, 0),
                 child: SizedBox(
                   width: 100,
                   child: RaisedButton(
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(30.0)
                     ),
                     color: Colors.lightBlue,
                     onPressed: (){
                       showAlertDialog(context);
                     },
                     child: Text("Upload",style: TextStyle(color: Colors.white),),
                   ),
                 ),
               )
             ],
           ),
         ),

      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100],
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.menu,
                  text: 'Menu',
                ),
                GButton(
                  icon: Icons.shopping_bag,
                  text: 'Order',
                ),
                GButton(
                  icon:Icons.monetization_on_rounded,
                  text: 'Pay-In',
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}