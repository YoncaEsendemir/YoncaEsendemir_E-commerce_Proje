import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yoncaesendemir_e_commerce_proje/models/products_model.dart';

class ApiServices {

// gelen sonuç response değişkenıne dönecek 
// bir iste işlemi yaptığımız için ve beleme urumu olabildiği için bir asenkon fonsiyonu tanımladık
// asenkron bir çok get istğe aynı zamanda alir await ise bekletir tüm veriler geldiğinde 
// response değişkenıne döner data 
    Future<ProductsModel> fetchProducts() async{

      final response = await http.get(Uri.parse("https://fakestoreapi.com/products"),
      );

       // responsla beraber gelen status durum kodlarına göre  koşulu ifade kontrol için
       // başarılı ise 200 ok if girecek  
            if(response.statusCode==200)
            {
              // responseden gelen  body string body bir json decode işlemi ile çözümlüyoruz gerekiyor
              //products model dönüştürme.
                final data =jsonDecode(response.body);
              //internetten veya bir veri tabanından gelen karmaşık ham verileri (JSON'ı), 
              //uygulamanın anlayabileceği düzenli bir nesneye (objeye) dönüştürmek
               return ProductsModel.fromJson(data);
            }
            else{
              // başarısız status gelirse 500 server hatası.
              throw Exception("Failed to load products.");
            }
  
              


    }

}