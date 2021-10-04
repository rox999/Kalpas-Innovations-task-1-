import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getRequest();
  }

  List<Data> dataList = [];
  Future<void> getRequest() async {
    String url = "https://api.first.org/data/v1/news";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    // print(responseData["data"]);

    // print("here");
    for (var singleData in responseData["data"]) {
      if (singleData["summary"] == null) continue;
      Data data = Data(singleData["id"], singleData["title"],
          singleData["summary"], singleData["link"], singleData["published"]);
      dataList.add(data);
    }
    setState(() {});
    print(dataList);
  }

  List<Data> favourites = [];
  var selection = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(children: [
              Expanded(
                child: Container(
                  child: selection == true
                      ? ListView.builder(
                          itemCount: dataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                leading: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      dataList[index].liked =
                                          !dataList[index].liked;
                                      if (dataList[index].liked) {
                                        favourites.add(dataList[index]);
                                      } else {
                                        favourites.remove(dataList[index]);
                                      }
                                    });
                                  },
                                  icon: Image.asset(
                                    'assets/heart.png',
                                    fit: BoxFit.cover,
                                    color: dataList[index].liked == true
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  //icon: AssetImage('assete/heartIcon.png'),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    dataList[index].title,
                                    maxLines: 2,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        dataList[index].summary,
                                        maxLines: 2,
                                        style: TextStyle(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        dataList[index].published,
                                        style: TextStyle(color: Colors.grey),
                                        textAlign: TextAlign.start,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                      : favourites.length > 0
                          ? ListView.builder(
                              itemCount: favourites.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  child: ListTile(
                                    leading: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          dataList.remove(favourites[index]);
                                          favourites.remove(favourites[index]);
                                        });
                                      },
                                      icon: Image.asset(
                                        'assets/heart.png',
                                        fit: BoxFit.cover,
                                        color: Colors.red,
                                      ),
                                      //icon: AssetImage('assete/heartIcon.png'),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        favourites[index].title,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            favourites[index].summary,
                                            maxLines: 2,
                                            style: TextStyle(),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                              favourites[index].published,
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : Container(
                              child: Center(
                                child: Text(
                                    'Nothing is added to favourites yet..'),
                              ),
                            ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      padding: EdgeInsets.all(8),
                      color: selection == true ? Colors.blue : Colors.white,
                      // minWidth: 50,
                      onPressed: () {
                        setState(() {
                          selection = true;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.menu,
                            color:
                                selection == true ? Colors.white : Colors.black,
                          ),
                          Text(
                            'News  ',
                            style: TextStyle(
                                fontSize: 26,
                                color: selection == true
                                    ? Colors.white
                                    : Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      padding: EdgeInsets.all(8),
                      color: selection == false ? Colors.blue : Colors.white,
                      //minWidth: 50,
                      onPressed: () {
                        setState(() {
                          selection = false;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/heart.png',
                            fit: BoxFit.cover,
                            width: 28,
                            color:
                                selection == true ? Colors.red : Colors.white,
                          ),
                          Text(
                            'Favs  ',
                            style: TextStyle(
                                fontSize: 26,
                                color: selection == false
                                    ? Colors.white
                                    : Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Container()
                ],
              ),
            ])),
      ),
    );
  }
}

class Data {
  int id = 0;
  String title = '';
  String summary = '';
  String link = '';
  String published = '';
  bool liked = false;

  Data(this.id, this.title, this.summary, this.link, this.published);
}
