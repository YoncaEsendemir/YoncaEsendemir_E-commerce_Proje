import 'package:flutter/material.dart';
import 'package:yoncaesendemir_e_commerce_proje/models/products_model.dart';

class ProductItemTile extends StatefulWidget {
  // constacter ile product verileri getiriyoruz
  final Product product;

  const ProductItemTile({super.key, required this.product});

  @override
  State<ProductItemTile> createState() => _ProductItemTileState();
}

class _ProductItemTileState extends State<ProductItemTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
       // ürün yapısına ayit Özellikler 
                             decoration: BoxDecoration(
                              color: const Color.fromARGB(179, 240, 240, 244),
                              borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),     // Sol Üst Köşe
                              bottomRight: Radius.circular(20), // Sağ Alt Köşe
                              // topRight ve bottomLeft yazmadığımız için onlar 0 (sivri) kalır.
                            ),
                            boxShadow: [
                              BoxShadow(
                              color: Colors.black26,
                              blurRadius: 12,
                              offset: const Offset(5, 7)
                            ),
                            ]
                             ),

                             child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // boş gelebilir onun için bir varsayım değer  boş string
                          Expanded(
                            child: Hero(
                              tag:widget.product.id ?? 0,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                   topLeft: Radius.circular(12),     // Sol Üst Köşe
                                   bottomRight: Radius.circular(20), // Sağ Alt Köşe
                                          ),
                                          
                                 child:(widget.product.image!= null && widget.product.image!.isNotEmpty)
                                    ? Image.network(
                                        widget.product.image!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey[300],
                                            child: const Icon(Icons.broken_image, color: Colors.grey),
                                          );
                                        },
                                    )
                                  : Container(
                                   color: Colors.grey[300],
                                   width: double.infinity,
                                   child: const Icon(Icons.image_not_supported, color: Colors.grey),
                                                  ),
                                          ),
                            ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(widget.product.title ?? "" , style: TextStyle(
                                                fontSize: 14, fontWeight: FontWeight.bold
                                          ),
                                          ),
                                          const SizedBox(height:1),

                                               Text(widget.product.category ?? "" , style: TextStyle(
                                                fontSize: 13, fontWeight: FontWeight.normal, color: const Color.fromARGB(255, 51, 52, 52)
                                          ),
                                          ),
                                           const SizedBox(height:1),

                                               Text("${widget.product.price.toString()} £", style: TextStyle(
                                                fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 12, 62, 103)
                                          ),
                                          ),
                                        ], 
                                      ),
                                    ),
                              ],
                             ),
                         );
  }
}