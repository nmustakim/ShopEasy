import 'package:flutter/material.dart';
import 'package:shopeasy/firebase_helpers/firestore_helper.dart';
import 'package:shopeasy/screens/item_details/item_details.dart';
import 'package:shopeasy/screens/product_by_category/products_by_categories.dart';
import '../../models/categories.dart';
import '../../models/product.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
List<CategoryModel> categoryProductsList = [];
List<ProductModel> popularProductsList = [];
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
   categoryProductsList =  await FireStoreHelper.fireStoreHelper.getCategories();
   categoryProductsList.shuffle();
   popularProductsList = await FireStoreHelper.fireStoreHelper.getPopular();
   popularProductsList.shuffle();
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                  const SizedBox(height: 10),
                  const Text(
                    "Categories",
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,

                    child: Row(
                        children: categoryProductsList
                            .map(
                              (item) => Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: InkWell(
                                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductByCategory(categoryModel: item)));},
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.network(item.image,height: 50,width: 100,),
                                         Text(item.name)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList()),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    "Popular",
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                  ),
                 const SizedBox(height: 15,),
                 popularProductsList.isEmpty ? const Center(child: Text("Popular products list is empty"),) : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: GridView.builder(
                          itemCount: popularProductsList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            ProductModel product = popularProductsList[index];
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

                                  Text(product.name),
                                    Text("${product.price}\$"),
                                ],),
                                const SizedBox(height: 8,),



                                  SizedBox(height:20,child: OutlinedButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetails(product: product)));
                                  }, child: const Text('Buy')))





                              ],),),
                            );


                          }),
                    ),
                  ),
                ],
              ),
            )));
  }
}


