
import 'package:flutter/material.dart';
import 'package:soth_hak/model/foodmodel.api.dart';

import 'category.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var controller = TextEditingController();
  var _isLoading = true;
  var resultModel = [];
  @override
  void initState() {
    // TODO: implement initState
    getResult();
    super.initState();
  }

  Future<void> getResult() async {
    print(controller.text);
    resultModel = await FoodModelApi.searchFood(controller.text);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
            slivers: [
              buildSearch(),
              buildCard()
            ],
             
              
            ),
    );
  }

  SliverToBoxAdapter buildSearch(){
    return SliverToBoxAdapter(
      child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Row(children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: 'Search food here',
                            prefixIcon: (Icon(Icons.search)),
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          getResult();
                        },
                      )
                    ]),
                  ),
    );
  }
  SliverFixedExtentList buildCard(){
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Category(
                      id: resultModel[index].id,
                      title: resultModel[index].title,
                      categoryPic: "https://spoonacular.com/recipeImages/${resultModel[index].id}-556x370.jpg",
                      time: resultModel[index].time,
                    )));
          },
          child: Hero(
            tag: resultModel[index].id,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              alignment: Alignment.center,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          "https://spoonacular.com/recipeImages/${resultModel[index].id}-556x370.jpg",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(40)),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.black),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${resultModel[index].time} min",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(149, 81, 78, 78),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 150, 20, 15),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          resultModel[index].title,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }, childCount: resultModel.length),
      itemExtent: 290.0,
    );
  }
  SliverToBoxAdapter buildCar1d() {
    return SliverToBoxAdapter(
      child: Expanded(
        child: ListView.builder(itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Category(
                      id: resultModel[index].id,
                      title: resultModel[index].title,
                      categoryPic: resultModel[index].img,
                      time: resultModel[index].time,
                    )));
          },
          child: Hero(
            tag: resultModel[index].id,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              alignment: Alignment.center,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          "https://spoonacular.com/recipeImages/${resultModel[index].id}-556x370.jpg",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(40)),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.black),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${resultModel[index].time} min",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(149, 81, 78, 78),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 150, 20, 15),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          resultModel[index].title,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
          }),
      ),
    );
    
  }
}
