import 'package:flutter/material.dart';
import 'package:flutter_exposure_listener/gm_exposure_listener.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.position.didEndScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('曝光测试'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("第一个可见的"),
                  Text("最后一个可见的"),
                ],
              ),
            ),
            Container(
                height: 500,
                child: GmExposureListener(
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          alignment: Alignment.center,
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.blue,
                          child: Text("这是第一个$index"),
                        ),
                      );
                    },
                    itemCount: 20,
                  ),
                  callBack: (first, last, scrotic) {
                    print("这是第一个可见的$first");
                    print("这是最后一个可见的$last");
                  },
                  scroll: Axis.vertical,
                ))
          ],
        ));
  }
}
