import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Day 01 exercises',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: const MainPage(title: 'Weather'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: widget.title),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}

/*

@override
  Widget  build(BuildContext  context) {
    return  Expanded(
      flex: 1,
      child:
        Container(
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 1),
              Text(
                inpt,
                textAlign: TextAlign.end,
                style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.normal)),
                const SizedBox(height: 20),
              Text(
                rst,
                textAlign: TextAlign.end,
                style: const TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.normal)),
              const SizedBox(height: 30),
            ],
          ),
      ),
    );
  }


*****


class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wheater App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 202, 26, 218)),
        useMaterial3: true,
      ),
      home: const MainPage(title: 'Home'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String textoVariavel = "";
  String textoSearch = "";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            leading: IconButton(
              icon: const Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  textoVariavel = textoSearch;
                });
              },
            ),
            title: Container(
              padding: const EdgeInsets.all(5),
              child: TextField(
                decoration: const InputDecoration(
                    hintText: "Search location...", border: InputBorder.none),
                onChanged: (value) {
                  setState(() {
                    textoSearch = value;
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    textoVariavel = value;
                  });
                },
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.near_me),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    textoVariavel = "Geolocation";
                  });
                },
              )
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: Text("Currently\n$textoVariavel"),
              ),
              Center(
                child: Text("Today\n$textoVariavel"),
              ),
              Center(
                child: Text("Weekly\n$textoVariavel"),
              ),
            ],
          ),
          bottomNavigationBar: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.schedule),
                text: "Currently",
              ),
              Tab(
                icon: Icon(Icons.today),
                text: "Today",
              ),
              Tab(
                icon: Icon(Icons.date_range),
                text: "Weekly",
              ),
            ],
          ),
        ));
  }
}




*/
