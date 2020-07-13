import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/color.dart';

class September extends StatefulWidget {



  @override

  _septemberState createState() => _septemberState();
}

class _septemberState extends State<September>{


  final String url = "http://4foxwebsolution.com/festivals.com/api/getFestivals";
  List data;
  var  newdata;
  String value = "9";
  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }



  Future<String> getJsonData() async{
    var response = await http.post(
      // Encode the url
        Uri.encodeFull(url), body: {
      "fest_id" : value ,

    }
      //only accept json response
      //headers: {"Accept": "application/json"}
    );

    if(response.statusCode == 200) {
      print(response.body);


      setState(() {
        var convertDataToJson = json.decode(response.body);
//     data = convertDataToJson['res_data'];

        data = convertDataToJson["res_data"]["festival_details"];
      });

    }

    return "Success";
  }

  Random random = new Random();

  int index = 0;

  void changeIndex() {
    setState(() => index = random.nextInt(100));
  }

  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: new ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index){
              return
                new Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    margin: const EdgeInsets.all(10.0),

//                    color: colors[index],
                    color: colors[index],


                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                            child: Wrap(
//                                  spacing: 8.0, // gap between adjacent chips
//                                  runSpacing: 4.0, // gap between lines
//                                  direction: Axis.horizontal,
                                children: <Widget>[

                                  //We only want to wrap the text message with flexible widget
                                  Container(
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              data[index]["fes_name"], style: new TextStyle(fontSize: 30.0,color: Colors.white)
                                          )
                                      )

                                  ),

//                                  Flexible(
//                                    child: Text(data[index]["fes_name"], style: new TextStyle(fontSize: 30.0),textAlign: TextAlign.left,
//                                    ),
//                                  ),
                                  Spacer(),
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0, bottom: 30.0),
                            child: Row(children: <Widget>[
                              Text(data[index]["m_date"], style: new TextStyle(fontSize: 20.0,color: Colors.white)),
//                              Text(
//                                  "${DateFormat('dd/MM/yyyy').format(trip.startDate).toString()} - ${DateFormat('dd/MM/yyyy').format(trip.endDate).toString()}"),
                              Spacer(),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                            child: Row(children: <Widget>[
                              Text(data[index]["fes_cat"], style: new TextStyle(fontSize: 20.0,color: Colors.white)),
//                              Text(
//                                  "${DateFormat('dd/MM/yyyy').format(trip.startDate).toString()} - ${DateFormat('dd/MM/yyyy').format(trip.endDate).toString()}"),
                              Spacer(),
                            ]),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Wrap(

                              children: <Widget>[
                                Text("# Tag",style: new TextStyle(fontSize: 22.0,color: Colors.white70),),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(data[index]["tags"],style: new TextStyle(fontSize: 18.0,color: Colors.white,
                                  ),maxLines: 2,),

                                )
//                                Text(data[index]["tags"],style: new TextStyle(fontSize: 20.0),maxLines: 2,),
////                                Text("\$${trip.budget.toStringAsFixed(2)}", style: new TextStyle(fontSize: 35.0),),
//                                Spacer(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );


//                new ListTile(
//                  title: Text(data[index]["fes_name"]),
//                  subtitle: Text(data[index]["m_date"]),
//
//                );
            }
        ),
      ),

    );
  }}


