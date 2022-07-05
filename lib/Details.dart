import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_window/Controller.dart';

class Details extends StatelessWidget {
  final int index = 1;
  final int avilablewindow = 0;

  final Controller imagecontroller = Get.put(Controller());
  int? firstPage;
  dynamic theme;
  //WindowController? window;

  @override
  Widget build(BuildContext context) {
    firstPage = index;
    imagecontroller.pathIndex.value =
        index; /*To update the index to show the path in draggable popup*/
    // PageController pageController = PageController(initialPage: firstPage!);
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.touch,
                      },
                    ),
                    child: Container(
                        child: Center(
                            child: Text(
                                "hello\n-tap information icon for open 1st window\n-tap left arrow icon for open 2nd window\n-tap right arrow icon for open 3rd window"))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    imagecontroller.closeWindow();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  //shape: new CircleBorder(),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: TextButton(
                    onPressed: () async {
                      //imagecontroller.isInfoPressed.value = true;
                      await imagecontroller.multiWindowCommon("a", true);
                    },
                    child: const Icon(
                      Icons.info_outlined,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    //shape: new CircleBorder(),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () async {
                          // imagecontroller.isInfoPressed.value = true;
                          await imagecontroller.multiWindowCommon("b", true);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        //shape: new CircleBorder(),
                      ),
                      TextButton(
                        onPressed: () async {
                          // imagecontroller.isInfoPressed.value = true;
                          await imagecontroller.multiWindowCommon("c", true);
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        //shape: new CircleBorder(),
                      ),
                    ],
                  ),
                ),
              ),
              /* Obx(() => imagecontroller.isInfoPressed.value == false
                  ? const SizedBox()
                  : draggablePopUp(constraints))*/
            ],
          ),
        ),
      );
    });
  }

  headingContainer(String title) {
    return Container(
      height: 30,
      width: 400.0,
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
        alignment: Alignment.topRight,
        child: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
              size: 15,
              // color: theme.iconcolor,
            ),
            onPressed: () {}),
      ),
    );
  }

  detailRow(String title, String value) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
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
        Padding(
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
      ],
    );
  }
}
