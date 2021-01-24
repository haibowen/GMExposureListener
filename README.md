## 一个flutter列表中针对曝光埋点进行处理的工具Widget
## 使用方法如下所示

~~~
GmExposureListener(
    child:child //孩子节点 widget
    scroll: Axis.vertical,//滑动的方向
    callBack:（first,last,ScrollNotification scrollNotification）{
    print("第一个可见的元素$first")
    print（“最后一个可见的元素$last"）
    }
)
~~~
## 首次进入页面的默认值
对于flutter中的滑动事件一般都是由ScrollNotification 来驱动的，这就会导致第一次进入页面的时候，没有滑动驱动，就没有曝光数据
因此我们需要在页面构建的初始化的生命周期里手动调用一下触发滑动的事件
~~~
 @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.scrollController.position.didEndScroll();
    });
  }
 ~~~
 ## 待优化的点
 目前列表中的曝光坑位中的item只要有被遮挡就不再曝光，需要继续优化

