# timelin_demo
本示例展示模拟耗时，使用Timeline分析方法 文章链接[掘金](https://juejin.cn/post/6990231632091299848)

# Flutter 性能优化实践之Timeline

## 前言

Flutter自诞生之时就以轻松构建美观、高性能组件著称，目标是提供逼近“原生性能”的60帧每秒（fps）的性能，或者是在可以达到120Hz的设备上提供120fps的性能。这里的帧率fps是指的画面每秒传输帧数，是衡量性能优化中屏幕是否卡顿的一个重要指标，如何测量一个应用的帧率，就要用到工具Timeline。

> 注：关于Performance性能指标的描述有多个方面，本文侧重点为Timeline

## Flutter 性能分析

flutter 支持三种模式编译的app，处于开发的不同阶段，使用不同模式下的app

### 调试模式

在命令行下输入`flutter run`，默认会启动debug模式，该模式下app使用JIT的编译方式，运行时去解析执行程序，意味着应用有着较慢的性能体验，比如冷启动或者第一次初始化Flutter Engine会有较长时间的黑屏、使用过程中掉帧和卡顿这都属于正常现象。

该模式下一个突出的特点是可以热重载，所以更像开发一个前端应用

### Release模式

命令行输入`flutter run --release` 会使用 Release 模式来进行编译，该模式下应用具有最大的优化和性能体验，采用AOT的编译技术，由dart本地虚拟机将代码编译成对应平台例如Android、IOS对应的机器码，相当于原生开发，编译耗时，失去了热重载，但具有良好性能。一般用于最后应用市场发包，失去了debug模式下的各种调试应用功能

### Profile模式

命令行输入`flutter run --profile`会使用Profile模式编译，一个专门的调试应用性能模式，该模式是在保留一部分调试能力的基础上，又较大程度还原app真是性能，所以该模式不建议在虚拟机或模拟器上运行，因为无法真实代表真机性能。

输入该命令，运行完以后控制台会打印调试的地址

![image-20210520225054156](http://p0.qhimg.com/t011118be379b51a6d8.png)

点击即可跳转到调试页

![image-20210520225223018](http://p0.qhimg.com/t015d6803899d3dbdd1.png)

这里选择timeline，点击Flutter Developer按钮，即可进入timeline的调试页面，在手机上操作几秒钟，点击右上角Refresh按钮，即可加载出图像，看页面代码应该也是临时借用的systemtrace的，操作都类似

![image-20210520230230074](http://p0.qhimg.com/t01a32201a8faaef572.png)

这个其实是以前旧版的调试方式，现在虽然也能使用，但是实际测试中发现不太准确，使用也不方便，现在基本不使用这种方式了，新版本的Performance页面很美观使用也方便，可以在Android studio中使用Flutter Performance插件中页面粗略判断timeline是否卡顿，也可以打开Flutter Performance右下角Open DevTools按钮在网页上具体分析。

## Flutter Inspector

这里顺便说下Android Studio中其他两个Flutter 插件，一个是`Flutter Outline`，即显示页面布局的大纲，可以快速查看页面布局的树形结构，菜单栏提供了包裹、删除、上下移动组件的快捷功能，很简单这里不详细介绍。另一个插件是`Flutter Inspector`，安装Flutter插件后，AS右侧边栏会出现这个标签，主要作用是开发过程中布局调试用的，类似Android开发里的Xml布局查看工具，只不过需要debug模式运行时才可以查看布局，这点相对于原生开发xml快速定位布局文件的体验还是差一些，相信后期还会有好的优化。

点击标签后页面如下

![image-20210521083222975](http://p0.qhimg.com/t0141a3224fddb0d1c5.png)

页面主要分上边功能按钮、左边View树、右边布局预览。

每个按钮的作用：

**Select Widget Mode**

![image-20210521083642029](http://p0.qhimg.com/t01f9849b5594b44a6b.png)

选择组件模式，选中后点击下方View Tree中某个Widget自动定位到代码位置，可在开发中快速定位代码

**Refresh Tree**

![image-20210521084224112](http://p0.qhimg.com/t0184f71a8ff352a6ca.png)

刷新View Tree，在App上跳转其他页面后，View Tree不自动更新，所以有了此按钮

**Slow Animations**

![image-20210521084423541](http://p0.qhimg.com/t01d2a78b6b9e815113.png)

放慢动画

**Debug Paint**

![image-20210521084534383](http://p0.qhimg.com/t018ba4a3262ec15952.png)

显示布局测量，可以快速确定组件边界，效果如下

<img src="http://p0.qhimg.com/t015665aab8280bb445.png" alt="image-20210521084803196" style="zoom:50%;" />

**Show Paint Baselines**

![image-20210521084912117](http://p0.qhimg.com/t0134a22b0da04f3a2c.png)

显示Text组件的Baseline，方便文字对齐

**Show Repaint Rainbow**

![image-20210521085047056](http://p0.qhimg.com/t01c9bcc5ec600577c3.png)

显示重绘时颜色变化

**Invert Oversized Images**

<img src="http://p0.qhimg.com/t01de0c9103257b515a.png" alt="image-20210521085404144" style="zoom:20%;" />

轻松查看分辨率比显示分辨率高的图片

<img src="http://p0.qhimg.com/t017732abacb7498cd7.png" alt="image-20210521085850906" style="zoom:50%;" />



## Flutter Performance

点击右边栏Flutter Performance，出现如下页面：

<img src="http://p0.qhimg.com/t01bb16546dd153b06d.png" alt="image-20210521090326483" style="zoom:30%;" />

左上角第一个按钮是在手机上显示performance Overlay，效果如下，其他按钮和上边Inspector中一样

<img src="http://p0.qhimg.com/t017d3f29080a07f53a.png" alt="image-20210521090608935" style="zoom:40%;" />

上边可以粗略判断App是否掉帧，白色正常，红色就卡顿了，中间内存占用，下边是每个组件的重绘状态，点击右下角的Open DevTools可以使用更多功能

`Track widget rebuilds`复选框勾上可以方便的查看页面中组件的重绘状态，对于不应该重绘的组件应该调整代码层级结构或者抽离组件的方式避免重绘造成性能的损失，这里分享个人在开发中总结的几点经验：

* **尽量少使用StatefulWidget编写大的页面，尽量避免在StatefulWidget中使用setState**
* **不需要重绘组件添加const关键字**
* **Provider刷新机制时使用Consumer下沉刷新范围**
* **小部件需要刷新抽取成StatefulWidget，缩小刷新范围**

### Timeline

时间线事件图表显示了应用程序中的所有事件跟踪。 Flutter框架在构建框架，绘制场景以及跟踪其他活动（例如HTTP流量）时会发出时间轴事件。这些事件显示在时间轴上。您还可以通过dart发送自己的时间线事件：developer [Timeline](https://api.flutter.dev/flutter/dart-developer/Timeline-class.html)和 [TimelineTask API](https://api.flutter.dev/flutter/dart-developer/TimelineTask-class.html)

Timeline 事件轨迹的格式和查看器并被许多其他项目使用，此类项目包括 [Chromium](http://dev.chromium.org/developers/how-tos/trace-event-profiling-tool) & [Android (via systrace)](https://developer.android.com/studio/command-line/systrace).

轨迹记录的形式是JSON文件格式存储的，点击右上角的Export按钮可以导出文件。

打开DevTools以后，在App上操作一段，点击左上角Refresh按钮即可加载出如下图所示时间线。

<img src="http://p0.qhimg.com/t01120a4e3318afe905.png" alt="image-20210720103706663" style="zoom:150%;" />

图中**蓝色条是正常帧，红色条是卡顿帧，鼠标移动到红条上可以查看当前卡顿帧的耗时，右上角有不同颜色放条的对应关系，分别有UI、Raster、Jank**。

### UI

UI线程在Dart VM中执行Dart代码。这包括您的应用程序以及Flutter框架中的代码。当您的应用创建并显示场景时，UI线程将创建一个层树（包含与设备无关的绘画命令的轻量级对象），并将该层树发送到要在设备上呈现的栅格线程。不要阻塞该线程。

### Raster

光栅线程（以前称为GPU线程）执行Flutter Engine中的图形代码。该线程获取层树并通过与GPU（图形处理单元）对话来显示它。您无法直接访问栅格线程或其数据，但是如果该线程速度很慢，则是由于您在Dart代码中所做的操作所致。图形库Skia在此线程上运行。

有时，场景会产生易于构造的图层树，但是在栅格线程上渲染的树代价很高。在这种情况下，您需要弄清楚代码正在做什么，这会导致渲染代码变慢。对于GPU而言，特定种类的工作负载更加困难。它们可能涉及对saveLayer（）的不必要调用，与多个对象相交的不透明性以及在特定情况下的剪辑或阴影

### Jank

帧渲染图显示带有红色叠加层的垃圾帧。如果一个帧完成的时间超过约16毫秒（对于60 FPS设备），则该帧被认为是过时的。为了达到60 FPS（每秒帧）的帧渲染速率，每个帧必须在约16 ms或更短的时间内渲染。错过此目标时，您可能会遇到UI混乱或掉帧的情况

### Render Frames

当一个Flutter应用或者Flutter Engine启动时，它会启动（或者从池中选择）另外三个线程，这些线程有些时候会有重合的工作点，但是通常，它们被称为`UI线程`，`GPU线程`，`IO线程`。UI、GPU之间的工作流程如下：

![](http://p0.qhimg.com/t01b778a05b0557f1e8.png)

为了生成一帧，Flutter engine首先装备了`vsync`锁存器，一个vsync的事件将会指示Flutter engine开始一些工作并最终绘制出新的帧呈现在屏幕上，vsync事件的生成频率会根据硬件平台的刷新率决定。

vsync首先会唤醒UI线程，UI线程的工作是将你代码中编写的Widget树转化为要渲染的RenderTree，Flutter中有三颗树的概念`WidgetTree`，`ElementTree`，`RenderTree`，dart文件中的Widget树并不是最终参与绘制的，而只是方便开发者编写页面的一个配置。比如，我们指定这里有一个纵向列表Column，列表里有三个并列Text，然后Flutter会根据相应语义在对应位置生成对应Element，这才是真正意义上的Flutter UI组件，也是显示到屏幕上的元素。

组件树对应到屏幕上还要经过一层渲染树（RenderObject）的转化，RenderObject是实际的渲染对象它负责布局测量以及绘制操作，这样做的目的是为了更好的应对上层UI的频繁变化，尽可能地去比较更新，修改配置而不是直接创建下层树，因为RenderObject树的创建开销比较大，所以Widget重新创建，ElementTree和RenderTree并不会完全重新创建，而是会复用一些节点，提升性能。UI线程工作到生成RenderTree的过程叫做渲染树

一旦创建了渲染树，GPU线程就会被唤醒，这个线程的工作是将渲染树的信息转换到GPU的命令缓冲区，然后在同一线程将数据提交给GPU执行

## 示例

**模拟一个组件耗时操作**

```dart
class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.tealAccent,
      child: Center(
        child: ListView(
          children: [
            for(var i=0;i<100000;i++) _buildItemWidget(i),
          ],
        ),
      ),
    );
  }

  Widget _buildItemWidget(int i) {
    var line = lines[i % lines.length];
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 18),
      child: Row(
        children: [
          Container(
            color: Colors.black,
            child: SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: Text(
                  line.substring(0,1),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(child: Text(
            line,
            softWrap: false,
          ))
        ],
      ),
    );
  }
}

```

可以看到，在ListView的children填充时，没有复用布局，模拟了一个重复创建十万条子child的情况，页面第一次加载时会看到明显卡顿，timeline显示如下，一条明显的红线，就是掉帧发生的位置。

<img src="http://p0.qhimg.com/t0182cf034657889347.png" alt="image-20210521112010591" style="zoom:50%;" />

点击Jank发生的位置，可以看到Timeline Events对应的事件被选中，下方有各个方法执行的耗时时间，可以看到`_buildItemWidget`方法耗时26.81ms发生掉帧

**模拟一个方法耗时**

```dart
class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Center(
        child: Text(
          '第2页 ' + _fibonacci(30).toString(),
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
      ),
    );
  }

  static int _fibonacci(int i) {
    if(i <= 1) return i;
    return _fibonacci(i - 1) + _fibonacci(i - 2);
  }
}

```

<img src="http://p0.qhimg.com/t0187fbf2f5c9f171b8.png" alt="image-20210521112622278" style="zoom:50%;" />

组建初始化时，执行一个斐波那契函数递归调用，时间复杂度为O(2^n)，传入参数30，即函数运行2^30次运算，初始化页面可看到明显卡顿，定位耗时方法同上。

示例代码已上传至[github](https://github.com/fxfSean/timeline_demo)

## 拓展

这里给大家推荐一个小工具**fps_monitor**，贝壳同学开源的检测页面流畅度的小工具，可以更直观和量化的评估页面流畅度，页面大概长这样

<img src="http://p0.qhimg.com/t019bf2b47a36aafbe3.png" alt="image.png" style="zoom:50%;" />

**最大耗时**和**平均耗时**可以直观的观测页面优化前后对比效果。

页面流畅度划为了四个级别：**流畅（蓝色）**、**良好(黄色)**、**轻微卡顿(粉色)**、**卡顿(红色)**，将 FPS 折算成一帧所消耗的时间，不同级别采用不一样的颜色，统计不同级别出现的次数

具体可以[跳转链接](https://juejin.cn/post/6947911434424549384)

## 总结

性能优化在任何平台任何语言上都是永恒不变的话题，理解性能优化原理，提升观察的敏锐性对一个开发者至关重要。利用Flutter提供的插件和性能分析工具，能够帮助我们快速的定位到问题代码，提升开发效率，Flutter Inspector可以在写代码阶段提升页面编码质量，Timeline可以在运行阶段发现哪个页面掉帧严重，重点分析。

## 参考链接

https://medium.com/flutter/profiling-flutter-applications-using-the-timeline-a1a434964af3

[https://cloud.tencent.com/developer/article/1614400](https://cloud.tencent.com/developer/article/1614400)

[https://juejin.cn/post/6940134891606507534](https://juejin.cn/post/6940134891606507534)

