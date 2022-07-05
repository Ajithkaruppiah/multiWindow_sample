import 'dart:io';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_window/MultiWindowWidget.dart';
import 'package:multi_window/TestChannel.dart';
import 'Details.dart';
import 'package:window_manager/window_manager.dart';

Future main(List<String> args) async {
  if (args.isNotEmpty) {
    runApp(_ExampleSubWindow(
      windowController: WindowController.fromWindowId(1),
      // args: [] as Map<dynamic, dynamic>,
    ));
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions(
      size: Size(800, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });

    runApp(MyApp());
  }
}

class MyApp extends StatefulWidget {
  static final String title = 'Taft Appsuite';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    _init();
    super.initState();

    /* FlutterWindowClose.setWindowShouldCloseHandler(() async {
      print('oru valiya ulla varudhu');
      return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: const Text('Do you really want to quit?'),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Yes')),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('No')),
                ]);
          });
    });*/
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isClosable();
    if (_isPreventClose) {
      print("Window is closing");
      /* showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Are you sure you want to close this window?'),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await windowManager.destroy();
                },
              ),
            ],
          );
        },
      );*/
    }
  }

  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: MyApp.title,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        home: Details(),
      );
}

class _ExampleSubWindow extends StatefulWidget {
  _ExampleSubWindow({
    Key? key,
    required this.windowController,
    // required this.args,
  }) : super(key: key);

  final WindowController windowController;

  @override
  State<_ExampleSubWindow> createState() => _ExampleSubWindowState();
}

class _ExampleSubWindowState extends State<_ExampleSubWindow>
    with WindowListener {
  final MethodChannel _channel = const MethodChannel('window_manager');
  ObserverList<WindowListener>? _listeners = ObserverList<WindowListener>();
  // final _changeTextChannel = TestChannel();
  @override
  void initState() {
    print("sub window id:" + widget.windowController.windowId.toString());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: MultiWindowWidget(
          controller: widget.windowController,
        ),
      ),
    );
  }
}
