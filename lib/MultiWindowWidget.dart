import 'dart:ui';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MultiWindowWidget extends StatefulWidget {
  const MultiWindowWidget({Key? key, required this.controller})
      : super(key: key);

  final WindowController controller;

  @override
  State<MultiWindowWidget> createState() => _MultiWindowWidgetState();
}

class _MultiWindowWidgetState extends State<MultiWindowWidget> {
  String path = "";

  @override
  void initState() {
    super.initState();

    DesktopMultiWindow.setMethodHandler(_handleMethodCallback);
  }

  @override
  dispose() {
    DesktopMultiWindow.setMethodHandler(null);
    super.dispose();
  }

  Future<dynamic> _handleMethodCallback(
      MethodCall call, int fromWindowId) async {
    print(fromWindowId);
    // print(call.method);
    print(call.arguments);

    setState(() {
      path = call.arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: path == "window 1st"
          ? Column(
              children: [
                // closeButton(),

                headingContainer("General"),
                space(),
                detailRow("Created Date", "-"),
                space(),
                detailRow("path", path),
                space(),
                detailRow("width", "-"),
                space(),
                detailRow("height", "-"),
                space(),
                headingContainer("Global Positioning System"),
                space(),
                detailRow("Latitude", "-"),
                space(),
                detailRow("Longitude", "-"),
                space()
              ],
            )
          : path == "window 2nd"
              ? Center(
                  child: Text(
                  path,
                  style: TextStyle(color: Colors.white),
                ))
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        path,
                        style: TextStyle(color: Colors.white),
                      ),
                      Image.asset(
                        'assets/background.jpg',
                        /* width: 300,
                        height: 100,*/
                      ),
                    ],
                  ),
                ),
    );
  }

  space() {
    return const SizedBox(
      height: 15,
    );
  }

  headingContainer(String title) {
    return Container(
      height: 30,
      //width: 400.0,
      color: Colors.blueGrey,
      child: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
          child: Text(
            title,
          ),
        ),
      ),
    );
  }

  closeButton() {
    return Material(
      color: const Color.fromARGB(255, 38, 50, 56),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
              size: 15,
              // color: CustomColors.theme_change().iconcolor,
            ),
            onPressed: () async {
              widget.controller.close();
              // messages.clear();

              // imagecontroller.isInfoPressed.value = false;
            }),
      ),
    );
  }

  detailRow(String title, String value) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Container(
              width: 150,
              child: DefaultTextStyle(
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
                child: Text(
                  title,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Container(
              width: 150,
              child: DefaultTextStyle(
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
                child: Text(
                  value,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
