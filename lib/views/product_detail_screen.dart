import 'package:flutter/material.dart';
import 'package:yoncaesendemir_e_commerce_proje/models/products_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final Set<int> cartIds;
  const ProductDetailScreen({super.key, required this.product, required this.cartIds});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:Text("Back")),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Hero(
                    // Hero wiget çalişabilmesi için karşılıklı tag bilgilerin uyuşuyor olması gerekiyor
                    tag:widget.product.id ?? 0,
                    child: Image.network(
                      widget.product.image!,
                      height: 350,
                      width: double.infinity,
                      fit:BoxFit.cover,
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                            Text(
                             widget.product.title ?? "", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,  ), 
                            ),
                            
                            const SizedBox(height: 4),
          
                           Text(
                             widget.product.category ?? "", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic,
                             color:Colors.black54  ), 
                            ),
          
                            const SizedBox(height: 4),
          
                             Text(
                             "Description", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600), 
                            ),
                            const SizedBox(height: 2),
          
                            Text(
                             widget.product.description ?? "", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,  ), 
                            ),
        
                            const SizedBox(height:4),
                                              // 1. FİYAT
                        Text(
                          widget.product.price != null ? "${widget.product.price} £" : "0.0 £",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 12, 62, 103),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
        
                      const SizedBox(height: 8),
                           Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 1. YORUM SAYISI (COUNT)
                        Row(
                          children: [
                            const Icon(Icons.comment, color: Colors.blueGrey, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              widget.product.rating?.count != null 
                                  ? "(${widget.product.rating!.count} comment)" 
                                  : "(0 comment)",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(12, 62, 103, 1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        // 2. PUAN (RATE)
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              widget.product.rating?.rate != null 
                                  ? widget.product.rating!.rate.toString() 
                                  : "0.0",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 12, 62, 103),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                      ),
        
                     const  SizedBox(height: 24,),
                  // genelde btn çağıracağımız yerde Elevated btn cağırırız
                  // iki tane özellik istiyor bir tane fonksiyon ney yapacağını tıklanacağına ney olacağına
                  // ikincisi de textyanı içerik   
        
                  ElevatedButton(onPressed: () {
                        // cartIds dolduruyoruz sepet sayfası iiçin set ile günceleme yaptım 
                        // add ile de cartIds dolduruyoruz
                        setState(() {
                          // default olarak 0 atıyoruz değer gelmezse hata vermemesı için 
                         widget.cartIds.add(widget.product.id ?? 0);
        
                         // btn tıklayınca gelen bidirim btn üzerinde
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text("Added to cart"),
                                        backgroundColor: Colors.green.shade900,
                                        // köşelerini yumuşatmak için
                                        behavior: SnackBarBehavior.floating,
                                        //Bildirim ekranda kalacak süre 
                                        
                               )
                            );
                        });
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.shade700,
                    minimumSize: Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10)
                    )
                  ),
                  child: Text(
                         "Buy Now", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
        
                         ),
                  ),
                  ),
                         ],     
                      ),
                    ),
                  
            ],
          ),
        ),
      ),

    );
  }
}