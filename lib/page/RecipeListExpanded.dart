import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'detailed.dart';

const defaultPadding = 5.0;

// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);

class getRecipeTap extends StatelessWidget {
  final String documentId;

  getRecipeTap({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference Recipe =
        FirebaseFirestore.instance.collection('Recipe');

    return FutureBuilder<DocumentSnapshot>(
      future: Recipe.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Image.network('${data['imageURl']}');
        }
        return SizedBox(
            height: 100, width: 100, child: CircularProgressIndicator());
      }),
    );
  }
}

class getRecipesTapped extends StatelessWidget {
  final String documentId;
  getRecipesTapped({required this.documentId});

  @override
  Widget build(BuildContext context) {
    String tapID;
    CollectionReference Recipe =
        FirebaseFirestore.instance.collection('Recipe');

    return FutureBuilder<DocumentSnapshot>(
      future: Recipe.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          Size size = MediaQuery.of(context).size;
          double width = MediaQuery.of(context).size.width;
          return SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: width,
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                        color: Color(0xFFF1EFF1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: new InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        detailed(tapID: documentId)),
                              );

                              tapID = documentId;
                              print(documentId);
                            },
                            child: Hero(
                              tag: Text(
                                'click',
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: Image.network(
                                  '${data['imageURl']}',
                                  fit: BoxFit.cover,
                                  width: width,
                                  height: 150,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding / 2, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${data['Recipe Title']}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 77, 77, 77)),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.timelapse_outlined),
                                    Text(
                                        'min '
                                        '${data['Time to prepare']}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 77, 77, 77))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: Flexible(
                              child: ExpansionTile(
                                title: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Ingredients')),
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      '${data['Recipe Ingredients']}',
                                      style: TextStyle(
                                        color: Color(0xFF747474),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(height: defaultPadding),
                        /*FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text('${data['Recipe Description']}'),
                        )
                        */
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox(
            height: 100, width: 100, child: CircularProgressIndicator());
      }),
    );
  }
}

class getRecipesdetailed extends StatelessWidget {
  final String documentId;

  getRecipesdetailed({required this.documentId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    CollectionReference Recipe =
        FirebaseFirestore.instance.collection('Recipe');

    return FutureBuilder<DocumentSnapshot>(
      future: Recipe.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          Size size = MediaQuery.of(context).size;
          // it enable scrolling on small devices
          return SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                    decoration: BoxDecoration(
                        color: Color(0xFFF1EFF1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: new InkWell(
                            onTap: () {
                              print(documentId);
                            },
                            child: Hero(
                              tag: Text(
                                'click',
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: Image.network(
                                  '${data['imageURl']}',
                                  fit: BoxFit.cover,
                                  width: width,
                                  height: 150,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding / 3),
                          child: Text(
                            'Recipe Title: '
                            '${data['Recipe Title']}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding / 3),
                          child: Text(
                            'Catergory: '
                            '${data['Recipe Category']}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Text(
                          'Preparation min:'
                          '${data['Time to prepare']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 255, 126, 116),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: defaultPadding / 2),
                          child: Text(
                            'Ingredients:  '
                            '${data['Recipe Ingredients']}',
                            style: TextStyle(
                              color: Color(0xFF747474),
                            ),
                          ),
                        ),
                        SizedBox(height: defaultPadding),
                        Text('Description: ${data['Recipe Description']}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox(
            height: 100, width: 100, child: CircularProgressIndicator());
      }),
    );
  }
}
