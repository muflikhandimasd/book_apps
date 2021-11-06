import 'dart:ui';

import 'package:book_apps/detail_page.dart';
import 'package:book_apps/models/book.dart';
import 'package:book_apps/models/menu_item.dart';
import 'package:book_apps/models/view_type.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isGridView = false;

  PopupMenuItem<ViewType> buildItem(ViewType type) => PopupMenuItem<ViewType>(
        value: type,
        child: Text(type.title),
      );

// Viewtype : class, tipe datanya berupa class spy bisa akses properti propertinya
  void onSelected(ViewType type) {
    switch (type) {
      case MenuItem.listView:
        setState(() {
          isGridView = false;
        });
        break;
      case MenuItem.gridView:
        setState(() {
          isGridView = true;
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    ListView buildListView() {
      return ListView.builder(
        itemCount: listBook.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var book = listBook[index];
          return InkWell(
            onTap: () {
              // context: super class, punya akses untuk di flutter
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detailpage(
                    book: book,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 6.0)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset(
                        book.imageAsset,
                        width: 64,
                        height: 64,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(book.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          Text(book.categoryBook,
                              style: const TextStyle(fontSize: 20))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    // GridView buildGridView() {
    //   return GridView.count(
    //     crossAxisCount: 2,
    //     shrinkWrap: true,
    //     physics: NeverScrollableScrollPhysics(),
    //     children: List.generate(listBook.length, (index) {
    //       var book = listBook[index];
    //       return Card(
    //         color: Colors.white,
    //         child: Column(
    //           children: [
    //             Expanded(
    //               child: Padding(
    //                 padding:
    //                     const EdgeInsets.only(left: 50, right: 50, top: 10),
    //                 child: Image.asset(
    //                   book.imageAsset,
    //                   width: MediaQuery.of(context).size.width,
    //                   fit: BoxFit.fill,
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(10),
    //               child: Column(
    //                 children: [
    //                   Text(
    //                     book.name,
    //                     textAlign: TextAlign.center,
    //                     style: const TextStyle(
    //                       fontSize: 16,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Text(
    //               book.categoryBook,
    //               textAlign: TextAlign.center,
    //               style: const TextStyle(fontSize: 17),
    //             ),
    //           ],
    //         ),
    //       );
    //     }),
    //   );
    // }

    GridView buildGridView() {
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(listBook.length, (index) {
          var book = listBook[index];
          return InkWell(
            onTap: () {
              // context: super class, punya akses untuk di flutter
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detailpage(
                    book: book,
                  ),
                ),
              );
            },
            child: Card(
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 50, right: 50, top: 10),
                        child: Image.asset(
                          book.imageAsset,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            book.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            book.categoryBook,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          );
        }),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton<ViewType>(
            itemBuilder: (context) =>
                // ... masukkan semua data
                // [...MenuItem.items.map(buildItem).toList()],
                MenuItem.items.map(buildItem).toList(),
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (type) => onSelected(type),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // banner
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Upgrade your skill\nUpgrade your life",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Image.asset(
                      'images/banner.png',
                      width: 100,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Books",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
              // buildListView(),
              // buildGridView(),

              LayoutBuilder(builder: (context, BoxConstraints constraints) {
                if (constraints.maxWidth <= 600) {
                  return isGridView ? buildGridView() : buildListView();
                } else if (constraints.maxWidth <= 1200) {
                  return isGridView ? buildGridView() : buildListView();
                } else {
                  return buildGridView();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
