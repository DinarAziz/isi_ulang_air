import 'package:flutter/material.dart';

void main() {
  runApp(const WaterRefillApp());
}

class WaterRefillApp extends StatelessWidget {
  const WaterRefillApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Refill Service',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NepalWater'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Heading
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Selamat datang di isi ulang air',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          // Service Options
          Expanded(
            child: ListView(
              children: [
                serviceCard(context, 'Isi Air 400ml ', 'Rp 15,000'),
                serviceCard(context, 'Isi Air 700ml', 'Rp 10,000'),
                serviceCard(context, 'Isi Air 100ml', 'Rp 5,000'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrderPage()),
          );
        },
        child: const Icon(Icons.add_shopping_cart),
        tooltip: 'Order Now',
      ),
    );
  }

  // Card for displaying service options
  Widget serviceCard(BuildContext context, String title, String price) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        subtitle: Text(price, style: Theme.of(context).textTheme.bodyMedium),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue.shade300),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderPage(
                      selectedService: title,
                      price: price,
                    )),
          );
        },
      ),
    );
  }
}

class OrderPage extends StatefulWidget {
  final String? selectedService;
  final String? price;

  const OrderPage({super.key, this.selectedService, this.price});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place an Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Display selected service and price
              if (widget.selectedService != null)
                Column(
                  children: [
                    Text(
                      'Selected Service: ${widget.selectedService}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Price: ${widget.price}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order Placed')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Submit Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
