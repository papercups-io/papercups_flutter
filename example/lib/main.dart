import 'dart:math';

import 'package:flutter/material.dart';
import 'package:papercups_flutter/papercups_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Papercups demo"),
      ),
      body: Builder(builder: (context) {
        return Center(
          child: ElevatedButton(
            onPressed: () {
              Scaffold.of(context).showBottomSheet(
                (context) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    width: min(
                      size.width - 20,
                      500,
                    ),
                    height: min(
                      size.height * 0.8,
                      size.height - 20,
                    ),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: PaperCupsWidget(
                        onStartLoading: () {
                          print("Loading");
                        },
                        onFinishLoading: () {
                          print("Finished");
                        },
                        onError: (error) {
                          print("Error happened!");
                        },
                        closeAction: () {
                          Navigator.of(context).pop();
                        },
                        props: Props(
                          accountId: "eb504736-0f20-4978-98ff-1a82ae60b266",
                          title: "Welcome",
                          greeting: "Welcome to the test app!",
                          newMessagePlaceholder: "Papercups",
                          subtitle: "This is a test chat widget!",
                          customer: CustomerMetadata(
                            email: "flutter-plugin@test.com",
                            externalId: "123456789876543",
                            name: "Test App",
                            otherMetadata: {
                              "app": "example",
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Text("Open Chat Widget!"),
          ),
        );
      }),
    );
  }
}
