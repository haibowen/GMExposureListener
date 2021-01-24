import 'package:flutter/material.dart';
import 'package:flutter_exposure_listener/gm_exposure_listener.dart';

///
/// 普通 列表组件的使用 支持横向跟 竖向的滚动
///
/// listview   gridview
/// 如下是使用的事例了  listview的使用
///
class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  ScrollController _scrollController = ScrollController();

  int indexFirst;
  int indexLast;

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
                  Text("第一个可见的$indexFirst"),
                  Text("最后一个可见的$indexLast"),
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
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.blue,
                          child: Text("这是第一个$index"),
                        ),
                      );
                    },
                    itemCount: 20,
                  ),
                  callBack: (first, last, scrotic) {
                    indexFirst = first;
                    indexLast = last;
                    print("这是第一个可见的$first");
                    print("这是最后一个可见的$last");
                    setState(() {});
                  },
                  scroll: Axis.vertical,
                ))
          ],
        ));
  }
}
