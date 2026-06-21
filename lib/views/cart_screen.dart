import 'package:flutter/material.dart';
import 'package:yoncaesendemir_e_commerce_proje/models/products_model.dart';
import 'package:yoncaesendemir_e_commerce_proje/components/cart_item_tile.dart';
import 'package:yoncaesendemir_e_commerce_proje/views/payment_page.dart';

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
  //int totalSum=0;
  @override
  Widget build(BuildContext context) {
    // hangi ürünler sepete olduğnu products listeden ayıklıyoruz
    // where yapsıı bir döngüye karşılık gelıyor her ürünü tek tek veriyor
    final cartList = widget.products
        .where((product) => widget.cartIds.contains(product.id ?? 0))
        .toList();

      //Taplam tutar hesaplama
      // ürün fiyatlari double olduğu için .fold() ile topladım.
      final double totalSum= cartList.fold(0.0 ,(sum,item) => sum + (item.price ?? 0.0)  );

    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
          
            children: [
              Expanded(
                
            child: cartList.isEmpty ?  
            Center(
              child: Column(
                // sadece gerekli alanı kapsar  
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_bag_outlined, size:68, color: Colors.black26),

              const SizedBox(height:16),
                Text(
                  "Your cart is empty", style: TextStyle(fontSize: 16, color: Colors.black38),
                ),

                const SizedBox(height:16),

                Text(
                  "Quality and reliable shopping", style: TextStyle(fontSize: 20, color: Colors.black38),
                ),
                ],
              ),
            )
            :
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
              Text("Total Amount to be Paid ${totalSum.toString()}£",
              style: TextStyle( 
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
                 color:Colors.black),
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
                                "If you wish to confirm your cart, please confirm the transaction and proceed to the next step. After completing the confirmation process, you can check your order details and securely complete your purchase.",
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
                      // sepet boş ise Ödeme ekrana gitmez Ana ekrana geçer
                          if(totalSum>0){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentPage(totalAmount:totalSum)));
                          }
                          else{
                             // Sepeti boş olduüunu bildiren SnackBar 
                             ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: 
                                const Row(children: [
                                  Icon(Icons.info_outline, color:Colors.white10 ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Text(
                                      "Your shopping bag is empty! Going back to Home Screen.", style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                                ),
                                backgroundColor: Colors.deepOrange,
                                // bildirim ekranda kalma süresi
                                duration: const Duration(seconds: 2),
                                //Havada asılı
                                behavior: SnackBarBehavior.floating,
                                // kenarlara yumuşaklık versin diye
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                )
                             );

                            //Kullanıcıyı ana ekrana geri gönderiyoruz
                            Navigator.pop(context);
                          }
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
