import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Delivery', style: TextStyle(fontSize:20.0, fontWeight:FontWeight.bold, color:Colors.black87)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 50, margin: const EdgeInsets.all(16), color: Colors.blue[100]), // SearchBar placeholder
            Container(height: 150, margin: const EdgeInsets.symmetric(horizontal: 16), color: Colors.blue[200]), // Carousel placeholder
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Featured Items', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isGrid = false),
                    child: Container(height: 40, margin: const EdgeInsets.symmetric(horizontal: 16), color: isGrid ? Colors.blue[200] : Colors.blue, alignment: Alignment.center, child: const Text('List View', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isGrid = true),
                    child: Container(height: 40, margin: const EdgeInsets.symmetric(horizontal: 16), color: isGrid ? Colors.blue : Colors.blue[200], alignment: Alignment.center, child: const Text('Grid View', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
                  ),
                ),
              ],
            ),
            Container(height: 200, margin: const EdgeInsets.all(16), color: Colors.blue[50]), // Products placeholder
          ],
        ),
      ),
    );
  }
}
