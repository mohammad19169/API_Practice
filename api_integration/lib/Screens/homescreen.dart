import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Homescreen extends StatefulWidget {
   const Homescreen({super.key});
  

  @override
  State<Homescreen> createState() => _HomescreenState();
}
class _HomescreenState extends State<Homescreen> {
  List posts=[];
  var authToken='346b45e26a52908b1625de738804690e19e11fba';
  Future <List>GetData()async{
    var url='https://api.todoist.com/rest/v2/tasks';
    var response=await http.get(Uri.parse(url),
    headers: {'Authorization':"Bearer $authToken"});
   if (response.statusCode==200) {
      var body=jsonDecode(response.body);
    // setState(() {
    //   posts=body;
    // });
     return body;
   }
   throw 'No Data';
  }
   List<Map<String,dynamic>> data=[
    
 { "content":"Umer",
    //"age":22,
    "description":"Flutter Developer"
  },
  {
    "content":"Hamza",
    //"age":22,
    "description":"Businessman"
  }];
  
  Future <void>SendData()async{
    for (var item in data) {
    var url='https://api.todoist.com/rest/v2/tasks';
    var response=await http.post(
    Uri.parse(url),
    headers:{"Content-Type":"application/json","Authorization":"Bearer $authToken"},
    body:jsonEncode(item));
    if (response.statusCode==200) {
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(title: const Text('Success'),content: const Text('Data Posted Successfully'),actions: [
        TextButton(onPressed: Navigator.of(context).pop, child: const Text('Cancel')),
        TextButton(onPressed: Navigator.of(context).pop, child: const Text('Ok'))
     ],
     
     );
      });
      
      GetData();}
      
    
    else{  showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(title: const Text('Error'),content: const Text('Data not posted'),actions: [
        TextButton(onPressed: Navigator.of(context).pop, child: const Text('Cancel')),
        TextButton(onPressed: Navigator.of(context).pop, child: const Text('Ok'))
     ],
     );
      });
    }}}
  Future<void>DeleteData(List<String> id)async{
    for(var item in id){
      var url='https://api.todoist.com/rest/v2/tasks/$item';
    var response=await http.delete( Uri.parse(url),headers: {"Authorization":"Bearer $authToken",'Content-Type':'application/json'});
    if (response.statusCode==204) {
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(title: const Text('Success'),content: const Text('Data Deleted Successfully'),actions: [
        TextButton(onPressed: Navigator.of(context).pop, child: const Text('Cancel')),
        TextButton(onPressed: Navigator.of(context).pop, child: const Text('Ok'))
     ],
     );
      });
  }else{
    showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(title: const Text('Error'),content: const Text('Data Deletion error'),actions: [
        TextButton(onPressed: Navigator.of(context).pop, child: const Text('Cancel')),
        TextButton(onPressed: Navigator.of(context).pop, child: const Text('Ok'))
     ],
     );
      });
  }
    }
    
  }
var newdata={
  "name":"Umer",
  "age":22,
  "profession":"Flutter App Developer"
};
  Future<void>updateData(String id)async{
    var url='https://api.todoist.com/rest/v2/tasks/$id';
    var response=await http.put( 
      Uri.parse(url),
      body: jsonEncode(newdata),
      headers: {'Content-Type':'application/json',"Authorization":"Bearer $authToken"}
      );
    if (response.statusCode==200) {
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(title: const Text('Success'),content: const Text('Data Updated Successfully'),actions: [
        TextButton(onPressed: Navigator.of(context).pop, child: const Text('Cancel')),
        TextButton(onPressed: Navigator.of(context).pop, child: const Text('Ok'))
     ],
     );
      });
  }throw 'Unable to update';
  }
@override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   GetData();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Integration'),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body:ElevatedButton(onPressed: (){DeleteData(['8461718609','8461721418','8461723145','8461726979','8461726994']);}, child: const Center( child: Text('Delete Data'),))
      // body:ElevatedButton(onPressed: (){SendData();}, child: Center( child: Text('Send Data'),))
      //   FutureBuilder(future: GetData(), builder: ( context,AsyncSnapshot snapshot){
      //   posts=snapshot.data??[];
      //   if(snapshot.connectionState==ConnectionState.waiting){
      //     return Center(child: CircularProgressIndicator());
      //   }
      //   if (snapshot.hasError) {
      //       return Center(child: Icon(Icons.error_outline));
      //     }
      //    if(!snapshot.hasData ||snapshot.data.isEmpty){
      //     return Icon(Icons.error_outline);
      //   }
      //   else{
      //   return ListView.builder(
      //     itemCount: snapshot.data.length,
      //     itemBuilder: (context,index){
      //      //   var content=Text(posts[index]['content'])??'No Content';
      //         var content = Text(posts[index]['content'] ?? 'No Content');
      //         var id=Text(posts[index]['id']??'No Data');
      //       return ListTile(
      //         title: content,
      //         subtitle: id,
      //       );
      //     });
      //  }})
      //  ElevatedButton(onPressed: (){
      //   updateData('6700f98fa0a8cd03e8189c8f');
      //  }, child: Text('Update Data'))
      //  ElevatedButton(onPressed: (){
      //   DeleteData("6700ed29a0a8cd03e8189c7d");
      //  }, child: Text('Delete Data'))
       //ElevatedButton(onPressed: SendData, child: Text('Press me'))
    // ListView.builder(itemCount:posts.length,itemBuilder:  (context,index){
    //   return ListTile(
    //     title: Text(posts[index]['name']),
    //     subtitle: Text(posts[index]['age'].toString()),
    //   );
    // }

    // )
    );

    
    
  }}