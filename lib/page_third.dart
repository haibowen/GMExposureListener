import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_exposure_listener/gm_exposure_listener.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
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
        body: GmExposureListener(
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            slivers: [
              SliverList(
                delegate:
                    SliverChildBuilderDelegate(_onItemBuilder, childCount: 50),
              ),
            ],
          ),
          callBack: (first, last, scrotic) {
            print("这是第一个可见的$first");
            print("这是最后一个可见的$last");
          },
          scroll: Axis.vertical,
        ));
  }

  Widget _onItemBuilder(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.0),
          color: Colors.blue),
      height: Random().nextInt(50) + 50.0,
      width: Random().nextInt(50) + 50.0,
      child: Text(
        '$index',
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
