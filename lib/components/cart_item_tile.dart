import 'package:flutter/material.dart';
import 'package:yoncaesendemir_e_commerce_proje/models/products_model.dart';

class CartItemTile extends StatefulWidget {

  final Product item;
  //Hiçbir parametre almayan ve geriye hiçbir değer döndürmeyen, değiştirilemez bir fonksiyon (callback) tanımıdır.
  final VoidCallback OnRemove;

  const CartItemTile({super.key, required this.item ,required this.OnRemove});

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  @override
  
  Widget build(BuildContext context) {

     return Padding(
       padding: const EdgeInsets.all(12.0),
                  child: Row(
                   children: [
                    Container(
                      width: 70,
                      height: 70,
                      padding:const EdgeInsets.all(12),
                      decoration:
                        BoxDecoration(
                          color:Color.fromARGB(255, 185, 195, 199),
                          borderRadius: BorderRadius.circular(10),
                        ),
                   child: ClipRRect(
                        child:(widget.item.image!= null && widget.item.image!.isNotEmpty)
                      ? Image.network(widget.item.image!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        )
                        : const Icon(Icons.image_not_supported_outlined, size:60)
                      ),
                    ),
             
                SizedBox(width:10), 

                Expanded(
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start , mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.item.title ?? "",
                        style: TextStyle(
                          fontSize:16, fontWeight: FontWeight.bold
                        ),
                      ),
                  
                      Text(
                        widget.item.category ?? "",
                        style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                          fontStyle: FontStyle.italic
                        ),
                      ),

                      Text(
                        "${widget.item.price.toString()} £" ?? "",
                        style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 12, 62, 103)
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width:10),  

                IconButton( 
                icon: Icon(Icons.delete_outline_outlined),
                color: const Color.fromARGB(255, 106, 6, 1),
                onPressed:widget.OnRemove,
                ),
                
                   ],
           ),
     );
  
  }
}