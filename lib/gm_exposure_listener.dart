import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///定义曝光回调函数
///参数含义为 首 尾索引
///滚动监听的类型参数
typedef ExposureCallBack = void Function(
    int firstIndex, int lastIndex, ScrollNotification scrollNotification);

class GmExposureListener extends StatelessWidget {
  final Widget child;
  final Axis scroll;
  final ExposureCallBack callBack;

  GmExposureListener({Key key, this.child, this.scroll, this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: child,
      onNotification: _onNotification,
    );
  }

  bool _onNotification(ScrollNotification scrollNotification) {
    final sliverMultiBoxAdaptorElement =
        findSliverMultiBoxAdaptorElement(scrollNotification.context);

    /// 为空时 返回
    if (sliverMultiBoxAdaptorElement == null) return false;
    int firstIndex = sliverMultiBoxAdaptorElement.childCount;

    ///firstIndex 为空时 抛出异常
    assert(firstIndex != null);
    int endIndex = -1;

    ///遍历子元素
    void onForEachChildren(Element element) {
      final SliverMultiBoxAdaptorParentData oldParentData =
          element?.renderObject?.parentData;
      if (oldParentData != null) {
        double boundFirst = oldParentData.layoutOffset;
        double itemLength = scroll == Axis.vertical
            ? element.renderObject.paintBounds.height
            : element.renderObject.paintBounds.width;
        double boundEnd = itemLength + boundFirst;
        if (boundFirst >= scrollNotification.metrics.pixels &&
            boundEnd <=
                (scrollNotification.metrics.pixels +
                    scrollNotification.metrics.viewportDimension)) {
          ///计算 头部的索引值
          firstIndex = min(firstIndex, oldParentData.index);

          ///计算 尾部的索引值
          endIndex = max(endIndex, oldParentData.index);
        }
      }
    }

    sliverMultiBoxAdaptorElement.visitChildren(onForEachChildren);
    callBack(firstIndex, endIndex, scrollNotification);
    return false;
  }

  SliverMultiBoxAdaptorElement findSliverMultiBoxAdaptorElement(
      Element element) {
    if (element is SliverMultiBoxAdaptorElement) {
      return element;
    }

    SliverMultiBoxAdaptorElement target;
    element.visitChildElements((element) {
      target ??= findSliverMultiBoxAdaptorElement(element);
    });
    return target;
  }
}
