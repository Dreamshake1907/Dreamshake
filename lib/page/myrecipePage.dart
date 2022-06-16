import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const defaultpadding = 10.0;

const defaultshadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12,
);

class GetImage extends StatelessWidget {
  final String documentId;

  GetImage({required this.documentId});

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
        return Text('Loading');
      }),
    );
  }
}

class GetRecipes extends StatelessWidget {
  final String documentId;

  GetRecipes({required this.documentId});

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
          Size size = MediaQuery.of(context).size;

          return SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: defaultpadding),
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
                              tag: '${data['Recipe Title']}',
                              child: Image.network(
                                '${data['imageURl']}',
                                fit: BoxFit.cover,
                                width: 350,
                                height: 150,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultpadding / 3),
                          child: Text(
                            '${data['Recipe Category']}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Text(
                          '${data['Recipe Description']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 5, 5, 5),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: defaultpadding / 2),
                          child: Text(
                            '${data['Recipe Ingredients']}',
                            style: TextStyle(
                              color: Color(0xFF747474),
                            ),
                          ),
                        ),
                        SizedBox(height: defaultpadding),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Text('Loading');
      }),
    );
  }
}
