import 'dart:convert';
import 'dart:io';
import 'package:assignment/model/client_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<ClientClass> clientList;
  bool isLoading = true;

  getClientData() async {
    String url = "https://run.mocky.io/v3/f3feef1c-9bfa-43fd-b2a0-bbe9abadb4f6";
    late List data;
    Response response = await get(Uri.parse(url));
    final jsonResponse = jsonDecode(response.body);
    data = jsonResponse['clients'];

    setState(() {
      clientList = data.map((data) => ClientClass.fromJson(data)).toList();
      isLoading= false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClientData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Clients'),),
        body: isLoading ? const Center(child: CircularProgressIndicator()) :
        WillPopScope(
          onWillPop: () async {
            return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Do you really want to exist the app ?"),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("No"),
                    ),
                    ElevatedButton(
                      onPressed: () => exit(0),
                      child: const Text("Yes"),
                    ),
                  ],
                ));
          },
          child: ListView.builder(
              itemCount: clientList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 120,
                  margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0,10)
                    )],
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(clientList[index].name,
                          style: const TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),),
                        const SizedBox(height: 8,),
                        Text(clientList[index].company,style: TextStyle(fontSize: 18,
                            fontWeight: FontWeight.bold,color: Colors.blue[900]),),
                       const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Paid: ${clientList[index].invoicepaid}',
                              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            Text('Pending: ${clientList[index].invoicePending}',
                              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}
