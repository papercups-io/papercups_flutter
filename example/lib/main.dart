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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width - 10,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: PaperCupsWidget(
                        onStartLoading: () {
                          print("loading");
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
                          primaryColor: Colors.amber,
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
