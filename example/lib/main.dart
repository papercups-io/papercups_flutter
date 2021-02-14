import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:papercups_flutter/papercups_flutter.dart';
import 'package:thememode_selector/thememode_selector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeModeManager(
        defaultThemeMode: ThemeMode.light,
        builder: (themeMode) {
          return MaterialApp(
            title: 'Papercups Demo',
            theme: ThemeData(
              primarySwatch: Colors.cyan,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: Colors.cyan,
            ),
            themeMode: themeMode,
            home: MyHomePage(),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var show = true;

  TextEditingController titleController =
      TextEditingController(text: "Welcome to Papercups!");
  TextEditingController subtitleController =
      TextEditingController(text: "Ask us anything using the chat window!");
  Color color = Color(0xff1890ff);

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    titleController.addListener(() {
      setState(() {});
    });
    subtitleController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: InkWell(
          customBorder: CircleBorder(),
          onTap: () {
            setState(() {
              show = !show;
            });
          },
          child: Icon(
            show ? Icons.close : Icons.chat_bubble_rounded,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 50, right: 50),
                constraints: BoxConstraints(maxWidth: 800),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Demo",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        "Hello! Try customizing the chat widget's display text and colors."),
                    SizedBox(
                      height: 40,
                    ),
                    Text("Change the theme:"),
                    SizedBox(
                      height: 15,
                    ),
                    ThemeModeSelector(
                        height: 25,
                        onChanged: (mode) {
                          ThemeModeManager.of(context).themeMode = mode;
                        }),
                    SizedBox(
                      height: 40,
                    ),
                    Text("Update the title:"),
                    SizedBox(
                      height: 15,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 800),
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: 'Enter a title',
                          contentPadding: EdgeInsets.all(10),
                          isCollapsed: true,
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.zero),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff1890ff)),
                              borderRadius: BorderRadius.zero),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text("Update the subtitle:"),
                    SizedBox(
                      height: 15,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 800),
                      child: TextField(
                        controller: subtitleController,
                        decoration: InputDecoration(
                          hintText: 'Enter a subtitle',
                          contentPadding: EdgeInsets.all(10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          isCollapsed: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff1890ff)),
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                        "Try changing the color (you can enter any value you want!)"),
                    SizedBox(
                      height: 15,
                    ),
                    ColorPicker(
                        color: color,
                        showColorCode: true,
                        enableShadesSelection: false,
                        pickersEnabled: {
                          ColorPickerType.primary: false,
                          ColorPickerType.accent: false,
                          ColorPickerType.wheel: true,
                          ColorPickerType.both: false,
                          ColorPickerType.bw: false,
                        },
                        onColorChanged: (c) {
                          setState(() {
                            color = c;
                          });
                        }),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(bottom: 70, top: 10),
            child: Visibility(
              visible: show,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Theme.of(context).shadowColor.withOpacity(0.2),
                    ),
                  ],
                ),
                constraints: BoxConstraints(
                  minWidth: 100,
                  maxWidth: 380,
                  minHeight: 100,
                  maxHeight: 800,
                ),
                margin: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: PaperCupsWidget(
                    closeAction: () {
                      setState(() {
                        show = !show;
                      });
                    },
                    props: Props(
                      accountId: "843d8a14-8cbc-43c7-9dc9-3445d427ac4e",
                      title: titleController.text,
                      primaryColor: color,
                      greeting:
                          "Hello, have any questions or feedback? Let me know below!",
                      subtitle: subtitleController.text,
                      customer: null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Credits to https://github.com/BlueCowGroup/thememode_selector for this section
// Copyright (c) 2021 Blue Cow Group, LLC
class ThemeModeManager extends StatefulWidget {
  final Widget Function(ThemeMode themeMode) builder;
  final ThemeMode defaultThemeMode;

  const ThemeModeManager({Key key, this.builder, this.defaultThemeMode})
      : super(key: key);

  @override
  _ThemeModeManagerState createState() =>
      _ThemeModeManagerState(themeMode: defaultThemeMode);

  static _ThemeModeManagerState of(BuildContext context) {
    return context.findAncestorStateOfType<_ThemeModeManagerState>();
  }
}

class _ThemeModeManagerState extends State<ThemeModeManager> {
  ThemeMode _themeMode;

  _ThemeModeManagerState({ThemeMode themeMode}) : _themeMode = themeMode;

  set themeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      setState(() {
        _themeMode = mode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_themeMode);
  }
}
