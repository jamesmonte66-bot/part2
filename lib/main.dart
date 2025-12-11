import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:dart_openai/dart_openai.dart';

void main() {
  OpenAI.apiKey = 'YOUR_OPENAI_API_KEY'; // Replace with your key
  runApp(const MyApp());
}

/* ---------------------------- MAIN APP ---------------------------- */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce AI Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: Colors.grey[100],
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

/* ---------------------------- DATA MODELS ---------------------------- */
class Phone {
  final String name;
  final String brand;
  final double price;
  final String image;
  final double rating;
  final Map<String, String> specs;

  const Phone({
    required this.name,
    required this.brand,
    required this.price,
    required this.image,
    required this.rating,
    required this.specs,
  });

  String get formattedSpecs =>
      specs.entries.map((e) => "${e.key}: ${e.value}").join("\n");
}

/* ---------------------------- MOCK DATA ---------------------------- */
final List<Phone> phones = [
  const Phone(
    name: 'Samsung Galaxy M36 5G',
    brand: 'Samsung',
    price: 17999,
    image: 'assets/1.webp',
    rating: 4.4,
    specs: {
      'Display': '6.7" Super AMOLED, 120 Hz, 1080×2340',
      'Battery': '5000 mAh, 25W fast charging',
      'RAM / Storage': '6 GB / 128 GB',
      'Rear Camera': '50 MP + 8 MP + 2 MP',
      'Front Camera': '13 MP',
      'OS': 'Android 15 (One UI 7)',
    },
  ),
  const Phone(
    name: 'Samsung Galaxy A36 5G',
    brand: 'Samsung',
    price: 20999,
    image: 'assets/2.jpg',
    rating: 4.5,
    specs: {
      'Display': '6.7" Super AMOLED, 120 Hz',
      'Battery': '5000 mAh, 45W fast charging',
      'RAM / Storage': '8 GB / 128 GB',
      'Rear Camera': '50 MP + 8 MP + 5 MP',
      'Front Camera': '12 MP',
      'OS': 'Android 15',
    },
  ),
  const Phone(
    name: 'Samsung Galaxy A56 5G',
    brand: 'Samsung',
    price: 25999,
    image: 'assets/3.png',
    rating: 4.6,
    specs: {
      'Display': '6.7" FHD+ Super AMOLED, 120 Hz',
      'Battery': '5000 mAh, 45W fast charging',
      'RAM / Storage': '8 GB / 128 GB',
      'Rear Camera': '50 MP + 12 MP + 5 MP',
      'Front Camera': '12 MP',
      'OS': 'Android 15',
    },
  ),
  const Phone(
    name: 'Samsung Galaxy A17 5G',
    brand: 'Samsung',
    price: 14999,
    image: 'assets/4.jpg',
    rating: 4.1,
    specs: {
      'Display': '6.7" FHD+ LCD',
      'Battery': '5000 mAh, 25W fast charging',
      'RAM / Storage': '6 GB / 128 GB',
      'Rear Camera': '48 MP + auxiliary lenses',
      'Front Camera': '8 MP',
      'OS': 'Android 15',
    },
  ),
  const Phone(
    name: 'Samsung Galaxy M35 5G',
    brand: 'Samsung',
    price: 15999,
    image: 'assets/5.jpg',
    rating: 4.2,
    specs: {
      'Display': '6.7" Super AMOLED, 90 Hz',
      'Battery': '5000 mAh, 25W charging',
      'RAM / Storage': '6 GB / 128 GB',
      'Rear Camera': '48 MP + 8 MP + macro',
      'Front Camera': '13 MP',
      'OS': 'Android 14/15',
    },
  ),
  // iQOO
  const Phone(
    name: 'iQOO Z10 5G',
    brand: 'iQOO',
    price: 15999,
    image: 'assets/6.png',
    rating: 4.3,
    specs: {
      'Display': '6.77" AMOLED, 120 Hz',
      'Battery': '7300 mAh, 90 W fast charging',
      'RAM / Storage': '8 GB / 128 GB',
      'Rear Camera': '50 MP + 2 MP',
      'Front Camera': '32 MP',
      'OS': 'Android 15',
    },
  ),
  const Phone(
    name: 'iQOO Z10x 5G',
    brand: 'iQOO',
    price: 13999,
    image: 'assets/7.webp',
    rating: 4.1,
    specs: {
      'Display': '6.77" AMOLED, 120 Hz',
      'Battery': '7300 mAh, 90 W',
      'RAM / Storage': '8 GB / 128 GB',
      'Rear Camera': '50 MP + depth',
      'Front Camera': '8 MP',
      'OS': 'Android 15',
    },
  ),
  const Phone(
    name: 'iQOO Z9 5G',
    brand: 'iQOO',
    price: 12999,
    image: 'assets/8.jpg',
    rating: 4.0,
    specs: {
      'Display': '6.7" AMOLED, 90 Hz',
      'Battery': '7000 mAh, 80 W',
      'RAM / Storage': '6 GB / 128 GB',
      'Rear Camera': '48 MP + depth',
      'Front Camera': '16 MP',
      'OS': 'Android 14',
    },
  ),
  const Phone(
    name: 'iQOO Neo 10 5G',
    brand: 'iQOO',
    price: 18999,
    image: 'assets/9.png',
    rating: 4.4,
    specs: {
      'Display': '6.78" AMOLED, 120 Hz',
      'Battery': '7000 mAh, 120 W',
      'RAM / Storage': '8 GB / 256 GB',
      'Rear Camera': '64 MP + 8 MP + 2 MP',
      'Front Camera': '32 MP',
      'OS': 'Android 15',
    },
  ),
  const Phone(
    name: 'iQOO 15 5G',
    brand: 'iQOO',
    price: 24999,
    image: 'assets/10.jpg',
    rating: 4.7,
    specs: {
      'Display': '6.78" AMOLED, 120 Hz',
      'Battery': '6000 mAh, 120 W',
      'RAM / Storage': '12 GB / 256 GB',
      'Rear Camera': '50 MP + 12 MP + 5 MP',
      'Front Camera': '50 MP',
      'OS': 'Android 15',
    },
  ),
  // Xiaomi
  const Phone(
    name: 'Xiaomi Redmi 15 5G',
    brand: 'Xiaomi',
    price: 7999,
    image: 'assets/11.jpg',
    rating: 3.8,
    specs: {
      'Display': '6.9" FHD+ LCD, 144 Hz',
      'Battery': '7000 mAh, 33 W',
      'RAM / Storage': '4 GB / 128 GB',
      'Rear Camera': '50 MP + auxiliary',
      'Front Camera': '8 MP',
      'OS': 'Android 15',
    },
  ),
  const Phone(
    name: 'Xiaomi 15',
    brand: 'Xiaomi',
    price: 34999,
    image: 'assets/12.png',
    rating: 4.7,
    specs: {
      'Display': '6.4" AMOLED, 120 Hz, QHD+',
      'Battery': '4800 mAh, 120 W',
      'RAM / Storage': '8 GB / 128 GB',
      'Rear Camera': '50 MP + 50 MP + 12 MP',
      'Front Camera': '32 MP',
      'OS': 'Android 15',
    },
  ),
  const Phone(
    name: 'Xiaomi 15 Pro',
    brand: 'Xiaomi',
    price: 42999,
    image: 'assets/13.jpg',
    rating: 4.8,
    specs: {
      'Display': '6.7" AMOLED, 120 Hz, QHD+',
      'Battery': '5000 mAh, 120 W',
      'RAM / Storage': '12 GB / 256 GB',
      'Rear Camera': '50 MP + 50 MP + 50 MP',
      'Front Camera': '32 MP',
      'OS': 'Android 15',
    },
  ),
  const Phone(
    name: 'Xiaomi Redmi Note 14 5G',
    brand: 'Xiaomi',
    price: 15999,
    image: 'assets/14.webp',
    rating: 4.2,
    specs: {
      'Display': '6.67" AMOLED, 120 Hz',
      'Battery': '5000 mAh, 67 W',
      'RAM / Storage': '8 GB / 128 GB',
      'Rear Camera': '48–50 MP + 8 MP + 2 MP',
      'Front Camera': '16 MP',
      'OS': 'Android 15',
    },
  ),
  const Phone(
    name: 'Xiaomi Poco X7 Pro 5G',
    brand: 'Xiaomi',
    price: 18999,
    image: 'assets/15.jpg',
    rating: 4.3,
    specs: {
      'Display': '6.78" AMOLED, 120 Hz',
      'Battery': '5500 mAh, 67 W',
      'RAM / Storage': '8 GB / 256 GB',
      'Rear Camera': '64 MP + 8 MP + 2 MP',
      'Front Camera': '20 MP',
      'OS': 'Android 15',
    },
  ),
];

/* ---------------------------- CART & FAVORITES ---------------------------- */
final List<Phone> cart = [];
final List<Phone> favorites = [];

/* ---------------------------- AI VOICE ---------------------------- */
class AiVoice {
  static final FlutterTts _tts = FlutterTts();

  static Future init() async {
    await _tts.setLanguage('en-US');
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.45);
  }

  static Future speak(String text) async => await _tts.speak(text);
}

/* ---------------------------- AI ENGINE ---------------------------- */
class AiEngine {
  static List<Phone> smartSearch(String query) {
    final q = query.toLowerCase();
    if (q.isEmpty) return phones;
    return phones.where((p) {
      final hay = (p.name + ' ' + p.brand + ' ' + p.specs.values.join(' '))
          .toLowerCase();
      return hay.contains(q);
    }).toList();
  }

  static List<String> autoSuggest(String input) {
    final s = input.toLowerCase();
    final tags = <String>{};
    for (final p in phones) {
      if (p.name.toLowerCase().contains(s) ||
          p.brand.toLowerCase().contains(s)) {
        tags.add(p.brand);
      }
    }
    return tags.take(6).toList();
  }
}

/* ---------------------------- AI CHATBOT ---------------------------- */
class AiChatBot {
  static String answer(String query) {
    final q = query.toLowerCase();
    if (q.contains('best') && q.contains('under')) {
      final num = RegExp(r'\d+').firstMatch(q);
      if (num != null) {
        final budget = double.tryParse(num.group(0)!) ?? 0;
        final results = phones.where((p) => p.price <= budget).toList();
        if (results.isEmpty)
          return "No phones found under ₱${budget.toStringAsFixed(0)}";
        results.sort((a, b) => b.rating.compareTo(a.rating));
        final top = results.first;
        return "Best phone under ₱${budget.toStringAsFixed(0)}: ${top.name}, ₱${top.price}, rating ${top.rating}.\nSpecs:\n${top.formattedSpecs}";
      }
    }
    if (q.contains('gaming')) {
      final list = phones
          .where((p) => p.specs.values.join(' ').toLowerCase().contains('120'))
          .toList();
      if (list.isEmpty) return "No gaming phones found.";
      return "Top gaming picks:\n" +
          list
              .take(3)
              .map((p) => "- ${p.name} (₱${p.price})\n${p.formattedSpecs}")
              .join("\n\n");
    }
    return "Ask me about 'best under price', 'gaming phones', or 'strong battery phones'.";
  }
}

/* ---------------------------- MAIN SCREEN ---------------------------- */
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    AiVoice.init();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeTab(
        onAddToCart: _addToCart,
        onSearchChanged: (q) => setState(() => _searchQuery = q),
        searchQuery: _searchQuery,
      ),
      CartTab(onRemove: _removeFromCart),
      const AiHubScreen(),
      const FavoritesScreen(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: 'AI'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  void _addToCart(Phone phone) {
    setState(() => cart.add(phone));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${phone.name} added to cart')));
  }

  void _removeFromCart(Phone phone) {
    setState(() => cart.remove(phone));
  }
}

/* ---------------------------- HOME TAB ---------------------------- */
class HomeTab extends StatefulWidget {
  final Function(Phone) onAddToCart;
  final void Function(String) onSearchChanged;
  final String searchQuery;

  const HomeTab({
    super.key,
    required this.onAddToCart,
    required this.onSearchChanged,
    required this.searchQuery,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String localQuery = '';
  List<String> suggestions = [];

  @override
  void initState() {
    super.initState();
    localQuery = widget.searchQuery;
  }

  void _onQueryChanged(String q) {
    setState(() {
      localQuery = q;
      suggestions = AiEngine.autoSuggest(q);
    });
    widget.onSearchChanged(q);
  }

  @override
  Widget build(BuildContext context) {
    final results = (localQuery.trim().isEmpty)
        ? phones
        : AiEngine.smartSearch(localQuery);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Ecommerce AI Shop'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  onChanged: _onQueryChanged,
                  decoration: InputDecoration(
                    hintText: 'Search or ask AI',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 28,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    itemBuilder: (_, i) => ActionChip(
                      label: Text(suggestions[i]),
                      onPressed: () => _onQueryChanged(suggestions[i]),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(width: 6),
                    itemCount: suggestions.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: results.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (_, index) {
                  final phone = results[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PhoneDetailScreen(phone: phone),
                        ),
                      );
                    },
                    child: PhoneCard(
                      phone: phone,
                      onAddToCart: () => widget.onAddToCart(phone),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

/* ---------------------------- AI HUB ---------------------------- */
class AiHubScreen extends StatelessWidget {
  const AiHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true, // Allow scrolling when keyboard appears
      appBar: AppBar(title: const Text('AI ChatBot')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Ask something about phones',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final ans = AiChatBot.answer(controller.text);
                    AiVoice.speak(ans);
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('AI Answer'),
                        content: Text(ans),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------------------- PHONE CARD ---------------------------- */
class PhoneCard extends StatelessWidget {
  final Phone phone;
  final VoidCallback onAddToCart;

  const PhoneCard({super.key, required this.phone, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Image.asset(phone.image, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              phone.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '₱${phone.price.toStringAsFixed(0)}',
              style: TextStyle(color: Colors.green[700]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ElevatedButton(
              onPressed: onAddToCart,
              child: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------------------- PHONE DETAIL SCREEN ---------------------------- */
class PhoneDetailScreen extends StatelessWidget {
  final Phone phone;

  const PhoneDetailScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(phone.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(phone.image, fit: BoxFit.cover, width: double.infinity),
            const SizedBox(height: 12),
            Text(
              phone.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              '₱${phone.price.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 12),
            const Text(
              'Specifications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            ...phone.specs.entries.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text('${e.key}: ${e.value}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------------------- CART TAB ---------------------------- */
class CartTab extends StatelessWidget {
  final void Function(Phone) onRemove;

  const CartTab({super.key, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    if (cart.isEmpty) return const Center(child: Text('Cart is empty'));
    return ListView.builder(
      itemCount: cart.length,
      itemBuilder: (_, i) {
        final phone = cart[i];
        return ListTile(
          leading: Image.asset(phone.image, width: 50, fit: BoxFit.cover),
          title: Text(phone.name),
          subtitle: Text('₱${phone.price.toStringAsFixed(0)}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onRemove(phone),
          ),
        );
      },
    );
  }
}

/* ---------------------------- FAVORITES ---------------------------- */
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) return const Center(child: Text('No favorites yet'));
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (_, i) {
        final phone = favorites[i];
        return ListTile(
          leading: Image.asset(phone.image, width: 50, fit: BoxFit.cover),
          title: Text(phone.name),
          subtitle: Text('₱${phone.price.toStringAsFixed(0)}'),
        );
      },
    );
  }
}
