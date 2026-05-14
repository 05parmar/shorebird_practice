import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Quotes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Helvetica', 
        scaffoldBackgroundColor: const Color(0xFF161616),
      ),
      home: const MainScreen(),
    );
  }
}

class QuoteData {
  final String title;
  final String category;
  final Color color;
  final Color? textColor;
  final String? quote;
  final List<String>? tags;
  bool isLiked;

  QuoteData({
    required this.title,
    required this.category,
    required this.color,
    this.textColor,
    this.quote,
    this.tags,
    this.isLiked = false,
  });
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  int? expandedIndex = 2; // Initially expand "Shoe Dog"

  final List<QuoteData> quotes = [
    QuoteData(
      title: 'A Man Called Otto',
      category: 'Movie',
      color: const Color(0xFF5A9EBA),
    ),
    QuoteData(
      title: 'Pursuit of Happiness',
      category: 'Movie',
      color: const Color(0xFFF3C065),
      textColor: Colors.black87,
    ),
    QuoteData(
      title: 'Shoe Dog',
      category: 'Book',
      color: const Color(0xFFD96350),
      quote: "“Don't tell people how to do things, tell them what to do and let them surprise you with their results.”",
      tags: ['ADVICE', 'LEADERSHIP'],
      isLiked: true,
    ),
    QuoteData(
      title: 'Show and Tell',
      category: 'Book',
      color: const Color(0xFF7D332D),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // So the header area is white
      body: Stack(
        children: [
          Positioned.fill(
            child: IndexedStack(
              index: _currentIndex,
              children: [
                _buildHomeTab(),
                _buildSearchTab(),
                _buildLibraryTab(),
                _buildSettingsTab(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  // ===================== HOME TAB =====================
  Widget _buildHomeTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            bottom: false,
            child: _buildHeader(),
          ),
          ...List.generate(quotes.length, (index) {
            final quote = quotes[index];
            final previousColor = index == 0 ? Colors.white : quotes[index - 1].color;
            return _buildCard(quote, index, previousColor);
          }),
          // Add a filler block with the last card's color so it scrolls nicely behind the nav bar
          Container(
            color: quotes.last.color,
            height: 150, // Added more height to ensure bottom card clears the nav bar
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily\nQuotes',
                  style: TextStyle(
                    fontSize: 42,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'We have picked\nsome quotes for You',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 120,
              alignment: Alignment.centerRight,
              child: Icon(Icons.auto_awesome_mosaic, size: 70, color: Colors.grey[200]),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCard(QuoteData data, int index, Color previousColor) {
    final isExpanded = expandedIndex == index;
    final textColor = data.textColor ?? Colors.white;

    return Container(
      color: previousColor,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: data.color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                expandedIndex = isExpanded ? null : index;
              });
            },
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 28, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          data.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            letterSpacing: -0.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          data.isLiked ? Icons.favorite : Icons.favorite_border, 
                          color: data.isLiked ? Colors.redAccent : textColor
                        ),
                        onPressed: () {
                          setState(() {
                            data.isLiked = !data.isLiked;
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    data.category,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastOutSlowIn,
                    alignment: Alignment.topCenter,
                    child: isExpanded && data.quote != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Divider(color: textColor.withOpacity(0.2), thickness: 1),
                              const SizedBox(height: 20),
                              Text(
                                data.quote!,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                  color: textColor,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 24),
                              if (data.tags != null)
                                Row(
                                  children: data.tags!.map((tag) {
                                    return Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: textColor.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        tag,
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )
                            ],
                          )
                        : const SizedBox(height: 8),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===================== SEARCH TAB =====================
  Widget _buildSearchTab() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Search',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.black),
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for quotes, authors, books...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Browse Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: [
                    _buildCategoryCard('Motivation', const Color(0xFF5A9EBA)),
                    _buildCategoryCard('Leadership', const Color(0xFFF3C065)),
                    _buildCategoryCard('Life', const Color(0xFFD96350)),
                    _buildCategoryCard('Wisdom', const Color(0xFF7D332D)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ===================== LIBRARY TAB =====================
  Widget _buildLibraryTab() {
    final likedQuotes = quotes.where((q) => q.isLiked).toList();
    
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Library',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.black),
              ),
              const SizedBox(height: 8),
              Text(
                '${likedQuotes.length} Saved Quotes',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: likedQuotes.isEmpty
                    ? Center(
                        child: Text(
                          'No saved quotes yet.',
                          style: TextStyle(color: Colors.grey[400], fontSize: 18),
                        ),
                      )
                    : ListView.separated(
                        itemCount: likedQuotes.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final q = likedQuotes[index];
                          return Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: q.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: q.color.withOpacity(0.3)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  q.title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: q.color,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  q.quote ?? 'No quote content.',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===================== SETTINGS TAB =====================
  Widget _buildSettingsTab() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.black),
              ),
              const SizedBox(height: 32),
              _buildSettingItem(Icons.notifications_outlined, 'Daily Notifications'),
              const Divider(),
              _buildSettingItem(Icons.color_lens_outlined, 'App Theme'),
              const Divider(),
              _buildSettingItem(Icons.star_outline, 'Rate Us'),
              const Divider(),
              _buildSettingItem(Icons.info_outline, 'About'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.grey[800]),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  // ===================== BOTTOM NAV =====================
  Widget _buildBottomNav() {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A), // Pure dark color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 15,
            offset: Offset(0, -4),
          ),
        ],
      ),
      // Use MediaQuery bottom padding to push items up if OS navbar takes space
      padding: EdgeInsets.only(top: 20, bottom: bottomPadding > 0 ? bottomPadding + 10 : 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_filled, 'Home', 0),
          _buildNavItem(Icons.search, 'Search', 1),
          _buildNavItem(Icons.folder_outlined, 'Library', 2),
          _buildNavItem(Icons.tune, 'Settings', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon, 
              color: isSelected ? Colors.white : Colors.grey[600], 
              size: 28
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
