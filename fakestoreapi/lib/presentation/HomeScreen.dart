import 'package:fakestoreapi/data/datasources/DioClient.dart';
import 'package:fakestoreapi/data/provider/CartProviderModel.dart';
import 'package:fakestoreapi/presentation/CartScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            child: Icon(
              Icons.shopping_cart,
            ),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: FutureBuilder(
        future: DioClient().getAllProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text("Error");
          if (!snapshot.hasData) return const Text("Data not Found");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) {
              return Card(
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        snapshot.data![index].image,
                        height: 250,
                      ),
                      Text(
                        snapshot.data![index].title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data![index].rating.rate.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "\$ ${snapshot.data![index].price.toString()}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      Text(
                        snapshot.data![index].description,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${Provider.of<CartProviderModel>(context).allProductModelCount}',
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Provider.of<CartProviderModel>(context,
                                          listen: false)
                                      .removeToCart(snapshot.data![index].id);
                                },
                                child: Text("-"),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Provider.of<CartProviderModel>(context,
                                          listen: false)
                                      .addToCart(snapshot.data![index].id);
                                },
                                child: Text("Add to cart"),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
