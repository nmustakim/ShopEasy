import 'package:flutter/material.dart';
import 'package:shopeasy/models/categories.dart';

import '../../firebase_helpers/firestore_helper.dart';
import '../../models/product.dart';
import '../item_details/item_details.dart';

class ProductByCategory extends StatefulWidget {
  final CategoryModel categoryModel;
  const ProductByCategory({Key? key, required this.categoryModel}) : super(key: key);

  @override
  State<ProductByCategory> createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {

  List<ProductModel> productsByCategories = [];
  bool isLoading = false;

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }
  getCategoryList()async{
    setState(() {
      isLoading = true;
    });

    productsByCategories = await FireStoreHelper.fireStoreHelper.getProductsByCategories(widget.categoryModel.id);
    productsByCategories.shuffle();
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:      Text(
            widget.categoryModel.name,
            style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
          ),),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child:isLoading ? const Center(child: SizedBox(height:50,width:50,child: CircularProgressIndicator()),): Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    child: TextField(
                      textAlign: TextAlign.center,
                      // onChanged: (v) => runFilter(v),
                      // controller: searchController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white30,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: "search by title",
                          prefixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.search_rounded)),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.sort,
                                color: Colors.red,
                              ))),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  const SizedBox(height: 15,),
                  productsByCategories.isEmpty ? const Center(child: Text("Popular products list is empty"),) : Expanded(
                    child: GridView.builder(
                        itemCount: productsByCategories.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          ProductModel product = productsByCategories[index];
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

                            child: Container(color:Colors.white54,child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: Image.network(product.image,height: 70,)),
                                const SizedBox(height: 8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Text(product.name),   Text("${product.price}\$"),
                                  ],),
                                const SizedBox(height: 8,),



                                SizedBox(height:20,child: OutlinedButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetails(product: product)));
                                }, child: const Text('Buy')))





                              ],),),
                          );


                        }),
                  ),
                ],
              ),
            )));
  }
}


