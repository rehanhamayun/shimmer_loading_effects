// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shimmer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingListPage(),
    );
  }
}

class LoadingListPage extends StatefulWidget {
  @override
  _LoadingListPageState createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  bool _enabled = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future loadData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _enabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat List'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _enabled == true ? 10 : 6,
              // ignore: avoid_types_as_parameter_names
              itemBuilder: (BuildContext, index) {
                if (_enabled) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: _enabled,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                                'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Avatar1.jpg'),
                          ),
                          title: Container(
                            width: 100,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          subtitle: Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: const [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                                'https://flutter.dev/docs/cookbook/img-files/effects/split-check/Avatar1.jpg'),
                          ),
                          title: Text('John wick'),
                          subtitle: Text("Who kill John's dog "),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                onPressed: () {
                  setState(() {
                    _enabled = !_enabled;
                  });
                },
                child: Text(
                  _enabled ? 'Stop' : 'Press',
                  style: Theme.of(context).textTheme.button!.copyWith(
                      fontSize: 18.0,
                      color: _enabled ? Colors.white : Colors.black),
                )),
          )
        ],
      ),
    );
  }
}
