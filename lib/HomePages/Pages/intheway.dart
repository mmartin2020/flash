import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Intheway extends StatelessWidget {
  const Intheway({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(children: [

Container(child: GoogleMap(
  initialCameraPosition: CameraPosition(zoom: 17.5, target: LatLng(-33.4436491,-70.6644089)),),

),

        Positioned(bottom:0.0,child: Container(

        width: MediaQuery.of(context).size.width,
          height: 100.0,
child: Column(
  children: [
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(width: 150.0,height: 5.0, decoration: BoxDecoration(
              color: Colors.black12,
           borderRadius: BorderRadius.all(Radius.circular(20.0))
              )),
    ),
    SizedBox(height: 30.0,),
        Row(mainAxisAlignment:MainAxisAlignment.spaceAround,
    
    crossAxisAlignment: CrossAxisAlignment.center,
    
      children: [
    
         Icon(Icons.delivery_dining,size: 30.0,color: Colors.cyan,),
       /*  LinearProgressIndicator(backgroundColor: 
         Colors.deepOrange.withOpacity(0.3),color: Colors.deepOrange,value: 20.0,),*/
         
         Icon(Icons.home,size: 30.0,color: Colors.lime,)
    
      ],
    
    ),
  ],
),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)))),





        )
      ],),
    );
  }
}