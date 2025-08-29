import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGrid = true;

  // Dummy Food Data
  final List<Map<String, String>> featuredItems = [
    {
      "name": "Pizza",
      "price": "\$12.99",
      "image": "https://picsum.photos/200/200?random=1",
    },
    {
      "name": "Burger",
      "price": "\$8.99",
      "image": "https://picsum.photos/200/200?random=2",
    },
    {
      "name": "Pasta",
      "price": "\$10.50",
      "image": "https://picsum.photos/200/200?random=3",
    },
    {
      "name": "Salad",
      "price": "\$6.99",
      "image": "https://picsum.photos/200/200?random=4",
    },
    {
      "name": "Sushi",
      "price": "\$14.99",
      "image": "https://picsum.photos/200/200?random=5",
    },
  ];

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
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for food...',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[300],
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 24.0,
                      color: Colors.blue[300],
                    ),
                    filled: true,
                    fillColor: Colors.blue[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              // Carousel Placeholder
              Container(
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 16),

              // Section Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Featured Items.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              // Toggle Buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isGrid = false),
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isGrid ? Colors.blue[200] : Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'List View',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
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
                        decoration: BoxDecoration(
                          color: isGrid ? Colors.blue : Colors.blue[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Grid View',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Featured Items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: isGrid
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: featuredItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.7,
                            ),
                        itemBuilder: (context, index) {
                          final item = featuredItems[index];
                          return _buildFoodCard(item);
                        },
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: featuredItems.length,
                        itemBuilder: (context, index) {
                          final item = featuredItems[index];
                          return _buildFoodRow(item);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodCard(Map<String, String> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              item["image"]!,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["name"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item["price"]!,
                    style: TextStyle(color: Colors.blue[700], fontSize: 14),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => print("Add ${item["name"]} to cart"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(36),
                    ),
                    child: const Text("Add to Cart"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodRow(Map<String, String> item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Image.network(
          item["image"]!,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        title: Text(
          item["name"]!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(item["price"]!),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          color: Colors.blue,
          onPressed: () => print("Add ${item["name"]} to cart"),
        ),
      ),
    );
  }
}
