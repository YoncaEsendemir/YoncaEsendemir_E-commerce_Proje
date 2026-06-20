import 'package:flutter/material.dart';
import 'package:yoncaesendemir_e_commerce_proje/models/products_model.dart';
import 'package:yoncaesendemir_e_commerce_proje/components/cart_item_tile.dart';

class CartScreen extends StatefulWidget {
  // hangi ürünü sepete atıldığını gösteren değişken
  final Set<int> cartIds;
  final List<Product> products;
  // ilgili id'leri ürün listesine ekleyebilmek için  ğrğnler listesini cağırıyoruz
  const CartScreen({super.key, required this.cartIds, required this.products});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    // hangi ürünler sepete olduğnu products listeden ayıklıyoruz
    // where yapsıı bir döngüye karşılık gelıyor her ürünü tek tek veriyor
    final cartList = widget.products
        .where((product) => widget.cartIds.contains(product.id ?? 0))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            
            children: [
              Expanded(
                
            child:
            ListView.builder(
                itemCount: cartList.length,
                itemBuilder: (context, index)
                  {
                      final item=cartList[index];
          
                      return CartItemTile(item:item,
                      OnRemove:(){
                          setState(() {
                            widget.cartIds.remove(item.id);
                          });
                      });
                  }
            )
            ),
        
              const  SizedBox(height: 24),

              Container(
                    decoration: BoxDecoration(
                      color:Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                      border:Border.all(color: Colors.lightBlueAccent.shade200),
                    ),
              
                    padding: EdgeInsets.all(10),
                     child:Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                             Icon(Icons.info_outline, color: Colors.blueGrey,
                             ),

                              const SizedBox(width:10),
                          Expanded(
                            child: Text(
                                "Sepetinizi onaylamak istiyorsanız lütfen işlemi onaylayın ve bir sonraki adıma geçin. Onay işlemini tamamladıktan sonra siparişinizin detaylarını kontrol ederek alışverişinizi güvenli bir şekilde tamamlayabilirsiniz.",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal
                                ),
                            ),
                          )
                             
                              ],
                     )
              ),

              const  SizedBox(height: 12),
                // genelde btn çağıracağımız yerde Elevated btn cağırırız
               // iki tane özellik istiyor bir tane fonksiyon ney yapacağını tıklanacağına ney olacağına
               // ikincisi de textyanı içerik   
          
                    ElevatedButton(onPressed: () {
                          setState(() {
          
                           // btn tıklayınca gelen bidirim btn üzerinde
                              ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content: Text("Checkout"),
                                          backgroundColor: Colors.green.shade900,
                                          // köşelerini yumuşatmak için
                                          behavior: SnackBarBehavior.fixed,
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
                           "Checkout", style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
          
                           ),
                    ),
                    ),
            ] 
            ),
        ),
      ),
    );
  }
}
