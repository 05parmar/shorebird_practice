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
      home: const QuotesScreen(),
    );
  }
}

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  ...List.generate(quotes.length, (index) {
                    final quote = quotes[index];
                    final previousColor = index == 0 ? Colors.white : quotes[index - 1].color;
                    return _buildCard(quote, index, previousColor);
                  }),
                  // Add a filler block with the last card's color so it scrolls nicely behind the nav bar
                  Container(
                    color: quotes.last.color,
                    height: 120, // Enough to be behind the bottom nav
                  ),
                ],
              ),
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

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 60, bottom: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
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
              height: 140,
              alignment: Alignment.centerRight,
              // Using an icon as a placeholder for the illustration
              child: Icon(Icons.menu_book, size: 80, color: Colors.grey[200]),
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
                      Text(
                        data.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Icon(Icons.more_horiz, color: textColor),
                    ],
                  ),
                  const SizedBox(height: 4),
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
                              const SizedBox(height: 24),
                              Divider(color: textColor.withOpacity(0.2), thickness: 1),
                              const SizedBox(height: 24),
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

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF121212), // Very dark background for bottom nav
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 20, bottom: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_filled, 'Home', true),
          _buildNavItem(Icons.search, 'Search', false),
          _buildNavItem(Icons.folder_outlined, 'Library', false),
          _buildNavItem(Icons.tune, 'Settings', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isSelected ? Colors.white : Colors.grey[600], size: 28),
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

  QuoteData({
    required this.title,
    required this.category,
    required this.color,
    this.textColor,
    this.quote,
    this.tags,
  });
}
