import 'package:flutter/material.dart';

void main() {
  runApp(BirthdayApp());
}

class BirthdayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthday Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: TextTheme(
          // Updated text theme properties
          headlineMedium: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      home: BirthdayScreen(),
    );
  }
}

class BirthdayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Color(0xFFD2BCD5),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'lib/Birthday.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Happy Birthday Marah ! ',
                  style: textTheme.headlineMedium, // Updated property
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Wishing you a wonderful day filled with love, laughter, and all the things that make you smile.',
                  style: textTheme.bodyLarge, // Updated property
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the BirthdayWishScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BirthdayWishScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: textTheme.labelLarge, // Updated button text style
                ),
                child: Text('Send Birthday Wish'),
              ),
              SizedBox(height: 20), // Space between buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to the BirthdayWishListScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BirthdayWishListScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: textTheme.labelLarge, // Updated button text style
                ),
                child: Text('View All Wishes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BirthdayWishScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Write a Birthday Wish'),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Color(0xFFF4E3F8),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Birthday Wish:',
              style: textTheme.headlineMedium, // Updated property
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write your wish here...',
                border: OutlineInputBorder(),
              ),
              style: textTheme.bodyLarge, // Updated property
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle the wish submission logic here
                  String wish = _controller.text;
                  if (wish.isNotEmpty) {
                    BirthdayWishData.instance.addWish(wish); // Save the wish
                    print('Wish submitted: $wish');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Birthday wish sent!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    _controller.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please write a wish before submitting.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: textTheme.labelLarge, // Updated button text style
                ),
                child: Text('Submit Wish'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BirthdayWishListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final wishes = BirthdayWishData.instance.wishes;

    return Scaffold(
      appBar: AppBar(
        title: Text('All Birthday Wishes'),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Color(0xFFF4E3F8),
      body: ListView.builder(
        itemCount: wishes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              leading: Icon(Icons.cake, color: Colors.purple),
              title: Text(
                'Wish ${index + 1}',
                style: textTheme.headlineSmall,
              ),
              subtitle: Text(
                wishes[index],
                style: textTheme.bodyLarge,
              ),
            ),
          );
        },
      ),
    );
  }
}

class BirthdayWishData {
  // Singleton pattern
  BirthdayWishData._privateConstructor();
  static final BirthdayWishData instance = BirthdayWishData._privateConstructor();

  final List<String> _wishes = [];

  List<String> get wishes => _wishes;

  void addWish(String wish) {
    _wishes.add(wish);
  }
}
