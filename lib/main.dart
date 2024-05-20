import 'package:flutter/material.dart';

import 'categoryscreen.dart';
import 'skyapi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(20, 33, 61, 1)),
        useMaterial3: true,
      ),
      home: Category()// MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;

  */
/*@override
  void initState() {
    // TODO: implement initState
    setState(() {
      isLoading = true;
    });
    Skyapi().loadPostData(widget.title).then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }*//*


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromRGBO(20, 33, 61, 1),
        title: Text("hello"),
      ),
      body: Center(
        child: isLoading == true
            ? CircularProgressIndicator()
            : Container(
                height: double.infinity,
                width: double.infinity,
                child: GridView.builder(
                  itemCount: histList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets .all(8.0),
                      child: Container(
                        // height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    histList[index]!.largeImageUrl!))),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3/4,
                      crossAxisSpacing: 10),
                ),
              ),
      ),
    );
  }
}
*/
