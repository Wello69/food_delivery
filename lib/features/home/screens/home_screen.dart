import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGrid = true;
  List<String> bannerImages = [];
  bool loadingBanners = true;

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: Duration(milliseconds: 5000),
    receiveTimeout: Duration(milliseconds: 5000),
  ));

  @override
  void initState() {
    super.initState();
    _loadBanners();
  }

  Future<void> _loadBanners() async {
    try {
      final res = await _dio.get('https://picsum.photos/v2/list?limit=6');
      if (res.statusCode == 200) {
        final List data = res.data as List;
        bannerImages = data.map<String>((e) => e['download_url'] as String).toList();
      } else {
        bannerImages = [];
      }
    } catch (e) {
      bannerImages = [];
    } finally {
      if (mounted) setState(() => loadingBanners = false);
    }
  }

  Widget _buildBanner() {
    if (loadingBanners) {
      return Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    }
    if (bannerImages.isEmpty) {
      return Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: const Text('No banners'),
      );
    }
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 150.0,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayInterval: const Duration(seconds: 3),
        viewportFraction: 0.85,
      ),
      itemCount: bannerImages.length,
      itemBuilder: (context, index, _) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Image.network(bannerImages[index], fit: BoxFit.cover, width: double.infinity),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Delivery.',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              print('Moving to cart screen.');
            },
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for food...',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[300],
                  ),
                  prefixIcon: Icon(Icons.search, size: 24.0, color: Colors.blue[300]),
                  filled: true,
                  fillColor: Colors.blue[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    // borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            _buildBanner(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Featured Items.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isGrid = false),
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      color: isGrid ? Colors.blue[200] : Colors.blue,
                      alignment: Alignment.center,
                      child: const Text(
                        'List View',
                        style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isGrid = true),
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      color: isGrid ? Colors.blue : Colors.blue[200],
                      alignment: Alignment.center,
                      child: const Text(
                        'Grid View',
                        style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.all(16),
              color: Colors.blue[50],
            ), // Products placeholder
          ],
        ),
      ),
    );
  }
}
