//Sushant Singh Basnet


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() => runApp(MaterialApp(
  title: "Corona App",
  debugShowCheckedModeBanner: false,
  home:ThuloCovid(),
),
);

class ThuloCovid extends StatefulWidget {
  @override
  _ThuloCovidState createState() => _ThuloCovidState();
}

class _ThuloCovidState extends State<ThuloCovid> {

//for loading icon
bool loading = true;
List listCountry;

  //taking data from api
  Future <String> _getWorldData() async {
    var response = await http.get("https://brp.com.np/covid/country.php");
    var getData = json.decode(response.body);


    if(this.mounted){
       setState(() {
        loading = false;
        listCountry = [getData];
      });
    }

    // debugPrint("$listCountry");
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loading= true;
      _getWorldData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Corona App - By Sushant'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),onPressed: (){
            _getWorldData();
          },)
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
          loading ? Center(child: CircularProgressIndicator()) :
           ListView.builder(
             shrinkWrap: true,
             physics:NeverScrollableScrollPhysics(),
             itemCount: listCountry==null?0 :listCountry[0]["countries_stat"].length -1 ,
             itemBuilder:(context, i){
                  // debugPrint("$i");
                 return listItem(i+1);
                 
                 
               }
             )
        ],
      ),
    );

  }
  Widget listItem(int i){
      return Column(
             children: <Widget>[
               Center(
                 child: Text(listCountry[0]["countries_stat"][i]["country_name"],style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
               
               ),
               Row(children: <Widget>[
                 Expanded(
                                    child: Container(
                     color: Colors.blue,
                     padding: EdgeInsets.all(20),
                     child: Column(children: <Widget>[
                       Text(listCountry[0]["countries_stat"][i]["active_cases"],style: TextStyle(color: Colors.white,fontSize: 18.0)),
                       Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                         Text(' हाल  संक्रमित',style: TextStyle(color: Colors.white ),),
                     ],
                     ),
                     ),
                 ),
                 Padding(padding: EdgeInsets.all(10)),
                  Expanded(
                      child: Container(
                     color: Colors.red,
                     padding: EdgeInsets.all(20),
                     child: Column(children: <Widget>[
                       Text(listCountry[0]["countries_stat"][i]["deaths"],style: TextStyle(color: Colors.white,fontSize: 18.0)),
                       Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                         Text('मृत्यु',style: TextStyle(color: Colors.white ),),
                     ],
                     ),
                     ),
                 ),Padding(padding: EdgeInsets.all(10)),
                  Expanded(
                      child: Container(
                     color: Colors.green,
                     padding: EdgeInsets.all(20),
                     child: Column(children: <Widget>[
                       Text(listCountry[0]["countries_stat"][i]["total_recovered"],style: TextStyle(color: Colors.white,fontSize: 18.0)),
                       Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                         Text('ठिक भएको',style: TextStyle(color: Colors.white ),),
                     ],
                     ),
                     ),
                 )
               ],
               ),
               
 
             ],
             
      );
   
    }
    
   
}


