import 'package:flutter/material.dart';
import 'package:yoncaesendemir_e_commerce_proje/models/products_model.dart';
import 'package:yoncaesendemir_e_commerce_proje/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
//createState() => _HomeScreenState();
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

    // verilerin gelmesini beklediğimiz zamana kadar loading değişkeni 
    bool loading= false;
    // ApiServerdan oluşturduğumuz nesne
    ApiServices apiServices = ApiServices();
    //ürünleri tutan bir liste Liste tipi oluşturduğumuz class ProductModel tipinde olacak
     List<Product> allProducts= [];
    // hata meydana geldiğinde kullanılacak errorMessage 
    String errorMessage="";

    // Listeyi getirecek fonksiyon 
    Future <void> loadProducts() async{
      setState(() {
        loading= true; // Yükleniyor durumunu başlat
      });

     try {
    // products artık doğrudan bir List<ProductsModel> nesnesidir.
    final products = await apiServices.fetchProducts();

    setState(() {
      allProducts = products.data ?? []; // Gelen listeyi doğrudan atayabilirsiniz
      loading = false;        // Yükleniyor durumunu bitir
    });
  } catch (e) {
    setState(() {
      errorMessage="Failed to load products";
    });
  }
  finally{
    loading=false;
  }
}

// sayfa yüklenmeden önce çalişacak fonsiyonlar initState tanımlarız  
@override
  void initState() {
        loadProducts();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Haberler",)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             const Text("Welcom To Storied Store", style: TextStyle(fontSize: 32,
               fontWeight: FontWeight.bold,
               letterSpacing: -0.5,
              ),
              ),

            const SizedBox(height: 2),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                       const  Text("Discover", style: TextStyle(fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5
                              ),
                              ),
                          const Spacer(),

                        IconButton(icon: const Icon(Icons.shopping_bag_outlined), onPressed: () {}),

                ],
              ),

            const SizedBox(height: 2),

             const Text("Find the best and newest products.",
              style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
              ),
              ),

              const SizedBox(height: 12),

          Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(0, 230, 230, 232),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border:OutlineInputBorder(borderSide:BorderSide.none,
                  borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),

          ),

                const SizedBox(height: 14),

             ClipRRect(
              borderRadius: BorderRadius.circular(8),
            
               child: Image.network("https://wantapi.com/assets/banner.png",
                               height: 80,width: 
                               double.infinity,
                               fit: BoxFit.fitWidth,
                               ),
             ) ,  

              const SizedBox(height: 20),

                Expanded(
                  
                  child: loading ?
                         Center(child: CircularProgressIndicator(),)
                         :
                       GridView.builder(
                        itemCount: allProducts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:2,
                        crossAxisSpacing:10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8), 
                       itemBuilder: (cotext,index) {
                        // döngü mantığı ile çalışyor ürünlistesindeki her elemani index göre alip
                        final product=allProducts[index];
                         return Container(
                             decoration: BoxDecoration(
                              color: const Color.fromARGB(179, 206, 206, 211),
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
                                      child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),     // Sol Üst Köşe
                                      bottomRight: Radius.circular(20), // Sağ Alt Köşe
                                        ),
                                        child: Image.network(product.image!,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        ),
                                        ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(product.title ?? "" , style: TextStyle(
                                                fontSize: 14, fontWeight: FontWeight.bold
                                          ),
                                          ),
                                          const SizedBox(height:1),

                                               Text(product.category ?? "" , style: TextStyle(
                                                fontSize: 12, fontWeight: FontWeight.bold
                                          ),
                                          ),
                                           const SizedBox(height:1),

                                               Text(product.price.toString() ?? "", style: TextStyle(
                                                fontSize: 1, fontWeight: FontWeight.bold
                                          ),
                                          ),
                                        ], 
                                      ),
                                    ),
                              ],
                             ),
                         );
                       })
                ),

              ],
              // uürün yapısına ayit bilgilerini yazdım 
                ),
        ),
      ),
    );
  }
}