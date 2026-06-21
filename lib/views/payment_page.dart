import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final double totalAmount;
  const PaymentPage({super.key, required this.totalAmount});

  @override
  State<PaymentPage> createState() => _PaymentPageState(); // İsim standardı için State eklendi
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController expirationDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Page")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: fromKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Payment amount: ₺${widget.totalAmount.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                "required field",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey),
              ),
              const SizedBox(height: 80),
              
   Expanded(
     child: Column(
      children: [
                      // 1. Kart Numarası
                TextFormField(
                  controller: cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Card Number",
                    prefixIcon: const Icon(Icons.credit_card),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Card number field cannot be left blank.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
            
                // 2. İsim (obscureText kaldırıldı)
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    prefixIcon: const Icon(Icons.person_outline),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "The name field cannot be left blank.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
            
                // 3. Soyisim (obscureText kaldırıldı)
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    labelText: "Last Name",
                    prefixIcon: const Icon(Icons.person_outline),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "The Last Name field cannot be left blank.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
            
                // 4. Tarih ve CVV  
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: expirationDateController, // Düzenlendi
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: "Expiry Date (MM/YY)",
                          prefixIcon: const Icon(Icons.calendar_today_outlined),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Cannot be blank.";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextFormField(
                        controller: cvvController, // Düzenlendi
                        obscureText: true, // Sadece CVV gizli olur
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "CVV",
                          prefixIcon: const Icon(Icons.lock_outline),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Cannot be blank.";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
      ],
     ),
   ),

            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                onPressed: () {
                  if (fromKey.currentState!.validate()) {
                    // Form doğrulaması başarılıysa ödeme işlemlerini tetikle
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Payment...')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blueAccent.shade700,
                ),
                child: const Text("Pay Now", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}