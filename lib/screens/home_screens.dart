import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../model/ItemData.dart';
import '../model/ItemData.dart';
import '../model/ItemData.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<ItemData> getData()async{
    var url = 'https://webhook.site/ac268ed9-24a9-4f5c-a840-154a14ed629e';
    http.Response response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body.toString());
    if (response.statusCode == 200){

      return ItemData.fromJson(jsonData);
    }
    else {
      return ItemData.fromJson(jsonData);
    }

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rest Api'),
      ),
      body:  Column(
        children: [
          Expanded(
            child: FutureBuilder<ItemData>(
                future: getData(),
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  else if(snapshot.hasData){
                    return ListView.builder(
                       itemCount:snapshot.data!.data!.length,
                        itemBuilder:(context,index){
                         return Column(
                           children: [
                             SizedBox(
                               height: MediaQuery.of(context).size.height*3,
                               width:  MediaQuery.of(context).size.width*1,
                               child :ListView.builder(
                                   itemCount:  snapshot.data!.data![index].image!.length,
                                   itemBuilder:(context,position){
                                     return Container(
                                       height: MediaQuery.of(context).size.height*.25,
                                       width:  MediaQuery.of(context).size.width*.5,
                                       decoration: BoxDecoration(
                                         image: DecorationImage(
                                           image: NetworkImage(snapshot.data!.data![index].image![position]._url.toString()),
                                         )
                                       ),

                                     );
                                   }
                               ) ,
                             )
                           ],
                         );
                        }
                    );

                  }
                  else{
                    return Center( child:  Text(snapshot.error.toString()),);
                  }
                },
              ),
          ),
        ],
      ),
    );
  }
}
