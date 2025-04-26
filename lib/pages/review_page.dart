import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/data/model.dart';

class ReviewPage extends StatefulWidget {
  final OrderHistory order;

  const ReviewPage({Key? key, required this.order}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _rating = 0; // nilai rating (1-5)
  final TextEditingController _reviewController =
      TextEditingController(); // kontrol komentar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ulas ${widget.order.product.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Beri Rating:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tulis Ulasan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Bagikan pengalaman kamu...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Simpan atau kirim ulasan
                  final reviewText = _reviewController.text;
                  if (_rating == 0 || reviewText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Mohon isi rating dan ulasan!'),
                      ),
                    );
                  } else {
                    // Logika simpan bisa ditaruh di sini
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Terima kasih atas ulasannya!'),
                      ),
                    );
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  }
                },
                child: const Text('Kirim Ulasan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}
