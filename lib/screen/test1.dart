import 'package:flutter/material.dart';

class Test1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Test1State();
}

class _Test1State extends State<Test1>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<double> headerNegativeOffset = ValueNotifier<double>(0);
  final ValueNotifier<bool> appbarShadow = ValueNotifier<bool>(false);

  final double maxHeaderHeight = 250.0;
  final double minHeaderHeight = 56.0;
  final double bodyContentRatioMin = .8;
  final double bodyContentRatioMax = 1.0;

  ///must be between min and max values of body content ratio.
  final double bodyContentRatioParallax = .9;

  @override
  void dispose() {
    headerNegativeOffset.dispose();
    appbarShadow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //just for status bar color
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Colors.pink,
          elevation: 0.0,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Stack(children: [
            Container(
                child: ValueListenableBuilder<double>(
                    valueListenable: headerNegativeOffset,
                    builder: (context, offset, child) {
                      return Transform.translate(
                        offset: Offset(0, offset * -1),
                        child: SizedBox(
                          height: maxHeaderHeight,
                          child: Container(
                            color: Colors.pink,
                          ),
                        ),
                      );
                    })),
            NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                if (notification.extent == bodyContentRatioMin) {
                  appbarShadow.value = false;
                  headerNegativeOffset.value = 0;
                } else if (notification.extent == bodyContentRatioMax) {
                  appbarShadow.value = true;
                  headerNegativeOffset.value =
                      maxHeaderHeight - minHeaderHeight;
                } else {
                  double newValue = (maxHeaderHeight - minHeaderHeight) -
                      ((maxHeaderHeight - minHeaderHeight) *
                          ((bodyContentRatioParallax - (notification.extent)) /
                              (bodyContentRatioMax -
                                  bodyContentRatioParallax)));
                  appbarShadow.value = false;
                  if (newValue >= maxHeaderHeight - minHeaderHeight) {
                    appbarShadow.value = true;
                    newValue = maxHeaderHeight - minHeaderHeight;
                  } else if (newValue < 0) {
                    appbarShadow.value = false;
                    newValue = 0;
                  }
                  headerNegativeOffset.value = newValue;
                }

                return true;
              },
              child: Stack(
                children: <Widget>[
                  DraggableScrollableSheet(
                    initialChildSize: bodyContentRatioMin,
                    minChildSize: bodyContentRatioMin,
                    maxChildSize: bodyContentRatioMax,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Stack(
                        children: <Widget>[
                          Container(
                            alignment: AlignmentDirectional.center,
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0),
                            child: Material(
                              type: MaterialType.canvas,
                              color: Colors.white,
                              elevation: 2.0,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24.0),
                                topRight: Radius.circular(24.0),
                              ),
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: 200,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(title: Text('Item $index'));
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
          ]),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            child: ValueListenableBuilder<bool>(
                valueListenable: appbarShadow,
                builder: (context, value, child) {
                  ///default height of appbar is 56.0. You can also
                  ///use a custom widget with custom height if you want.
                  return AppBar(
                    backgroundColor: Colors.pink,
                    title: Text("Notes"),
                    elevation: value ? 2.0 : 0.0,
                  );
                }),
          ),
        ],
      ),
      drawer: Drawer(),
    );
  }
}