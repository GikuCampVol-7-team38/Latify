import 'package:flutter/material.dart';
import 'package:latify/notionWidget.dart';
import 'package:latify/notionPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}





class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _navigateToNotionPage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotionPage())
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        actions:<Widget>[
          IconButton(
            onPressed:(){},
            icon:Icon(Icons.favorite),
          ),
          IconButton(
            onPressed:(){},
            icon:Icon(Icons.more_vert),
          ),

        ],


        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _navigateToNotionPage,
              child: const Text('Go to Notion Page'),
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
