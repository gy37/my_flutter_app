#### 第一个flutter应用
1. flutter中所有组件都是widget，包括布局、填充、对齐；Scaffold默认的widget，包括导航栏、标题、主屏幕树的body属性；每个widget都有build方法来描述如何构建自己；
2. stateless widget不可变的，所有属性不能改变；stateful widget组件属性在widget生命周期内可以改变；stateful widget至少包括两个类，stateful widget类（不变）和state（变化）类；输入stful，回车创建有状态类模板代码；state类加下换线前缀；
3. 使用setstate方法，会重新调用widget的build方法，渲染组件；某些widget需要单个widget，有些widget需要一组widget；Navigator.push切换路由，入栈出栈操作；MaterialPageRoute路由页面，builder方法中创建页面并返回；ListTile 的 divideTiles() 方法在每个 ListTile 之间添加 1 像素的分割线；
4. widget类似UIView，当widget实例或状态变化时就会重绘节点树，UIView需要手动调用setneedsdisplay重绘；widget轻量级的，不可变，是对视图及特性的描述，不绘制视图；修改widget的state来间接修改视图；可能会动态变化的用statefulwidget，不会变化的用statelesswidget；
5. 不能移除或添加视图，可以通过判断来决定要显示的widget；在 Flutter 里，使用 AnimationController，它是一个可以暂停、查找、停止和反转动画的 Animation<double> 类型。它需要一个 Ticker，在屏幕刷新时发出信号量，并在运行时对每一帧都产生一个 0~1 的线性插值。使用AnimationController设置动画，添加一个或多个animation对象到控制器中；CustomPaint 和 CustomPainter绘制相关的类，CustomPainter可以自定义画笔的属性；
6. flutter里自定义视图需要组合小的widget来实现，而不是继承；页面间参数传递可以通过await push和pop(param)实现；dart是单线程执行，执行一个eventloop，除非生成了 Isolate，否则所有 Dart 代码将永远在主 UI 线程运行，并由事件循环驱动；可以通过async/await来实现异步操作；Isolate来执行其他复杂的异步操作，防止主线程阻塞，不和主线程共享内存，不能使用setstate更新ui；
7. ReceivePort：Opens a long-lived port for receiving messages.A [ReceivePort] is a non-broadcast stream. This means that it buffers incoming messages until a listener is registered. Only one listener can receive messages. 
8. SendPort：Sends messages to its [ReceivePort]s.[SendPort]s are created from [ReceivePort]s. Any message sent through a [SendPort] is delivered to its corresponding [ReceivePort]. There might be many [SendPort]s for the same [ReceivePort].
9. Isolate.spawn(entryPoint, message)：Creates and spawns an isolate that shares the same code as the current isolate..The argument [entryPoint] specifies the initial function to call in the spawned isolate. The entry-point function is invoked in the new isolate with [message] as the only argument.
10. 创建ReceivePort用于接收数据，sendPort不用自己创建，调用receivePort.sendPort即可；接收的消息可以通过receivePort.first或者遍历ReceivePort获得；
11. didChangeAppLifecycleState监听App运行状态；少量数据使用listview的构造方法，大量数据使用listview.builder方法；widget不能直接获取组件上的值，需要使用controller来中转，从controller获取；TextEditingController输入框controller，可以监控和获取输入框的值；
12. Flutter和原生通信，Flutter 提供了用来和宿主 ViewController 通信和交换数据的 平台通道。平台通道本质上是一个桥接了 Dart 代码与宿主 ViewController 和 iOS 框架的异步通信模型。你可以通过平台通道来执行原生代码的方法，或者获取设备的传感器信息等数据。
13. 命令式UI，你手动构建一个全功能的 UI 实例，比如一个 UIView 或其他类似的，在随后 UI 发生变化时，使用方法或 Setter 修改它。为了减轻开发人员的负担，无需编写如何在不同的 UI 状态之间进行切换的代码；声明式UI，Flutter 相反，让开发人员描述当前的 UI 状态，并将转换交给框架。
14. 在声明式风格中，视图配置（如 Flutter 的 Widget ）是不可变的，它只是轻量的“蓝图”。要改变 UI，widget 会在自身上触发重建；RenderObjects 管理传统 UI 对象， RenderObjects 在帧之间保持不变， Flutter 的轻量级 widget 通知框架在状态之间修改 RenderObjects；
15. Flutter 的盒子模型和 HTML 的是一样的，而通用的容器 Container 就相当于是一个通用的容器，和 HTML 的 div 标签一样。如果要控制一个元素的尺寸，外边距，内边距和边框，最通用的做法是使用 Container 容器将元素包裹。当然 Flutter 也提供了一些更为具体的布局组件方便开发，例如 ：
  SizedBox：指定尺寸的容器。
  ConstaintedBox：带约束条件的容器，如限制最小最大宽度和高度。
  DecoratedBox：带装饰的容器，比如渐变色。
  RotatedBox：旋转一定角度的容器。
16. Positioned widgets are placed directly inside Stack widgets, Stack->Positioned
17. Flutter 提供了用来和宿主 ViewController 通信和交换数据的 平台通道。平台通道本质上是一个桥接了 Dart 代码与宿主 ViewController 和 iOS 框架的异步通信模型。你可以通过平台通道来执行原生代码的方法，或者获取设备的传感器信息等数据。
18. 无状态和有状态的 Widget 本质上是行为一致的。它们每一帧都会重建，不同之处在于 StatefulWidget 有一个跨帧存储和恢复状态数据的 State 对象；
19. widget可以是类似按钮或者菜单的结构化元素、类似字体或者颜色方案的风格化元素、类似填充区或者对齐元素布局元素；
20. ListView 是 Flutter 最常用的滑动 widget。默认构造函数需要一个数据列表的参数。 ListView 非常适合用于少量子 widget 的列表。如果列表的元素比较多，可以使用 ListView.builder，它会按需构建子项并且只创建可见的子项。
21. Column 和 Row widget 接受一个数组的子元素并且分别按照纵向和横向进行排列。 Container widget 包含布局和样式属性的组合， Center widget 会将其子 widget 也设定居中。
22. Stack widget 将子 widget 根据容器的边界进行布局。如果你仅仅想把子 widget 重叠摆放的话，这个 widget 非常合适。
23. 特殊的样式使用Container里面的decoration: BoxDecoration属性实现；
24. Stack widget 不是线性（水平或垂直）定位的，而是按照绘制顺序将 widget 堆叠在一起。你可以用 Positioned widget 作为Stack 的子 widget，以相对于 Stack 的上，右，下，左来定位它们。 Stack 是基于 Web 中的绝对位置布局模型设计的。
25. Container widget 可以用来创建一个可见的矩形元素。 Container 可以使用 BoxDecoration 来进行装饰，如背景，边框，或阴影等。 Container 还可以设置外边距、内边距和尺寸的约束条件等。
26. StatefulWidget 和 State 是独立的对象。在 Flutter 中，这两种类型的对象具有不同的生命周期。 Widget 是临时对象，用于构造应用当前状态的展示。而 State 对象在调用 build() 之间是持久的，以此来存储信息；State类里使用widget获取对应的StatefulWidget对象；重新渲染时，StatefulWidget会重建，而State对象不会；didUpdateWidget当StatefulWidget里面的值变化时调用，用来比较oldWidget属性和widget属性变化；
27. ListTile列表项，CircleAvatar圆形填充图片，
28. 无状态 widget 的通用模式。它将构造函数中接受到的值存储在 final 成员变量中，然后在 build() 函数中使用它们；
29. 有状态组件中，使用setstate更新后会重新渲染组件，但是由于框架会将新构建的 widget 与先前构建的 widget 进行比较，仅将差异应用于底层的 RenderObject，这种代价是很小的。
30. 在 StatefulWidget 上调用 createState() 之后，框架将新的状态对象插入到树中，然后在状态对象上调用 initState()。 State 的子类可以重写 initState 来完成只需要发生一次的工作。例如，重写 initState 来配置动画或订阅平台服务。实现 initState 需要调用父类的 super.initState 方法来开始。
31. 当不再需要状态对象时，框架会调用状态对象上的 dispose() 方法。可以重写dispose 方法来清理状态。例如，重写 dispose 以取消计时器或取消订阅平台服务。实现 dispose 时通常通过调用 super.dispose 来结束。
32. 使用super(key: ObjectKey(product))指定组件的key；
33. Flutter 布局的核心机制是 widgets。在 Flutter 中，几乎所有东西都是 widget —— 甚至布局模型都是 widgets。你在 Flutter 应用程序中看到的图像，图标和文本都是 widgets。此外不能直接看到的也是 widgets，例如用来排列、限制和对齐可见 widgets 的行、列和网格。
34. 默认情况下，行或列沿其主轴会占用尽可能多的空间，但如果要将子项紧密组合在一起，请将其 mainAxisSize 设置为 MainAxisSize.min。
35. 为了最大限度地减少高度嵌套的布局代码可能导致的视觉混乱，可以在变量和函数中实现 UI 的各个部分。
36. MediaQuery.of(context).size.width获取窗口宽度；
37. 标准 widgets
  Container：向 widget 增加 padding、margins、borders、background color 或者其他的“装饰”。
  GridView：将 widget 展示为一个可滚动的网格。
  ListView：将 widget 展示为一个可滚动的列表。
  Stack：将 widget 覆盖在另一个的上面。
Material widgets（Material 库中的组件只能在 Material app 中使用）
  Card：将相关信息整理到一个有圆角和阴影的盒子中。
  ListTile：将最多三行的文本、可选的导语以及后面的图标组织在一行中。
38. Container组件属性，增加 padding、margins、borders；改变背景色或者图片；只包含一个子 widget，但是这个子 widget 可以是行、列或者是 widget 树的根 widget；
39. 使用Scrollbar和SingleChildScrollView嵌套实现滚动效果；使用ListView简单写；
40. GridView组件属性，在网格中使用 widget；当列的内容超出渲染容器的时候，它会自动支持滚动。创建自定义的网格，或者使用下面提供的网格的其中一个：GridView.count 允许你制定列的数量；GridView.extent 允许你制定单元格的最大宽度；
41. ListView组件属性，一个用来组织盒子中列表的专用 Column；可以水平或者垂直布局；当监测到空间不足时，会提供滚动；比 Column 的配置少，使用更容易，并且支持滚动；
42. Stack组件属性，用于覆盖另一个 widget；子列表中的第一个 widget 是基础 widget；后面的子项覆盖在基础 widget 的顶部；Stack 的内容是无法滚动的；你可以剪切掉超出渲染框的子项；控制没有定位的childWidget的布局策略；
43. [常用布局组件](https://juejin.cn/post/6844903939268149262)
44. ListTile 是 Material 库 中专用的行 widget，它可以很轻松的创建一个包含三行文本以及可选的行前和行尾图标的行。 ListTile 在 Card 或者 ListView 中最常用，但是也可以在别处使用。
45. BoxFit.cover 告诉系统图片应当尽可能等比缩小到刚好能够覆盖住整个渲染 box。
46. 布局组件：
单子级 (Single child)
  Align——让子级在其内部进行对齐。可使用 -1 至 1 之间的任意值在垂直和水平方向上进行对齐。
  AspectRatio——尝试让子级以指定的比例进行布局。
  ConstrainedBox——对子级施加尺寸限制，可以控制最小和最大的尺寸。
  CustomSingleChildLayout——使用代理方法对单个子级进行定位。代理方法可以为子级确定布局限制和定位。
  Expanded 和 Flexible——允许 Row 或 Column 的子级填充剩余空间或者尽可能地小。
  FractionallySizedBox——基于剩余空间的比例限定子级的大小。
  LayoutBuilder——让子级可以基于父级的尺寸重新调整其布局。
  SingleChildScrollView——为单一的子级添加滚动。通常配合 Row 或 Column 进行使用。
多子级 (Multi child)
  Column、Row 和 Flex—— 在同一水平线或垂直线上放置所有子级。 Column 和 Row 都继承了 Flex widget。
  CustomMultiChildLayout—— 在布局过程中使用代理方法对多个子级进行定位。
  Flow——相对于 CustomMultiChildLayout 更高效的布局方式。在绘制过程中使用代理方法对多个子级进行定位。
  ListView、GridView 和 CustomScrollView—— 为所有子级增加滚动支持。
  Stack——基于 Stack 的边界对多个子级进行放置和定位。与 CSS 中的 position: fixed 功能类似。
  Table——使用经典的表格布局算法，可以组合多列和多行。
  Wrap——将子级顺序显示在多行或多列内。
47. LayoutBuilder 让 widget 可以根据其父级的限制进行调整，相比依赖全局的尺寸限制而言更为通用。layoutbuilder的builder属性中有constraints属性，根据constraints.maxWidth的值来布局子组件；
48. Constraints go down. Sizes go up. Parent sets position. 
  首先，上层 widget 向下层 widget 传递约束条件；然后，下层 widget 向上层 widget 传递大小信息。最后，上层 widget 决定下层 widget 的位置。
49. 布局约束，
  Widget 会通过它的 父级 获得自身的约束。约束实际上就是 4 个浮点类型的集合：最大/最小宽度，以及最大/最小高度。
  然后，这个 widget 将会逐个遍历它的 children 列表。向子级传递 约束（子级之间的约束可能会有所不同），然后询问它的每一个子级需要用于布局的大小。
  然后，这个 widget 就会对它子级的 children 逐个进行布局。（水平方向是 x 轴，竖直是 y 轴）
  最后，widget 将会把它的大小信息向上传递至父 widget（包括其原始约束条件）。
50. 一个 widget 仅在其父级给其约束的情况下才能决定自身的大小。这意味着 widget 通常情况下 不能任意获得其想要的大小。
一个 widget 无法知道，也不需要决定其在屏幕中的位置。因为它的位置是由其父级决定的。
当轮到父级决定其大小和位置的时候，同样的也取决于它自身的父级。所以，在不考虑整棵树的情况下，几乎不可能精确定义任何 widget 的大小和位置。
如果子级想要拥有和父级不同的大小，然而父级没有足够的空间对其进行布局的话，子级的设置的大小可能会不生效。 这时请明确指定它的对齐方式。
51. ConstrainedBox 将 constraints 参数带来的约束附加到其子对象上。子对象大小小于约束最小值时取最小值，大于最大值时取最大值，介于两者之间时取原来尺寸。
52. UnconstrainedBox 允许其子级的 Container 可以变为任意大小。OverflowBox 与 UnconstrainedBox 类似，但不同的是，如果其子级超出该空间，它将不会显示任何警告。
53. FittedBox 让 Text 可以变为任意大小。但是在 Text 告诉 FittedBox 其大小后， FittedBox 缩放文本直到填满所有可用宽度。
54. 如果你使用 Flexible 而不是 Expanded 的话，唯一的区别是，Flexible 会让其子级具有与 Flexible 相同或者更小的宽度。而 Expanded 将会强制其子级具有和 Expanded 相同的宽度。但无论是 Expanded 还是 Flexible 在它们决定子级大小时都会忽略其宽度。
55. 如果你想要 Scaffold 的子级变得和 Scaffold 本身一样大的话，你可以将这个子级外包裹一个 SizedBox.expand。
56. flutter函数参数的下划线，表示不适用该参数；
57. Provider<UserModel>(create: (_) => UserModel(), child: <>);创建Provider对象，初始化model保存全局数据；Consumer<UserModel>( builder: (_, userModel, child) {})用来读取或修改provider中的数据；
58. 使用Provider数据变化时，不会更新页面，用来存储不会改变的数据；使用ChangeNotifier模型和ChangeNotifierProvider可以实现更新provider数据时，页面自动更新；调用notifyListeners来通知页面更新数据；
59. extends：继承Class；with：混入Class；implements：实现Class；
60. context.watch<CartModel>来监听model变化，更新页面；
61. CustomScrollView是可以使用Sliver来自定义滚动模型（效果）的组件。它可以包含多种滚动模型。包括header，footer，以及类似Android Coordinglayout布局的滑动效果，CustomScrollView可以实现把多个彼此独立的可滑动widget组合起来；
62. context.select()用于监听部分值变化，提高性能；R select<T, R>(R Function(T) selector)；
63. 被@immutable注解标明的类或者子类都必须是不可变的；定义到改类中的数据一定是不可变的，需要用final来修饰；
64. 构造函数后的冒号，它是一个初始化器。这意味着初始化器在构造函数体之前执行。
65. context.select<CartModel, bool>()，<>里面是用到的model和返回值类型；获取provider中的model的值，处理后返回新值，类似于consumer中的取值；
66. context.read<CartModel>()获取provider中的model对象，进而调用model中的方法，类似于consumer的执行方法；
67. context.watch<CartModel>()来监听model变化，更新页面；类似于consumer中的取值和执行方法结合；Obtain a value from the nearest ancestor provider of type [T] or [T?], and subscribe to the provider.等价于Provider.of()；
68. CustomScrollView+SliverList组合使用其实就相当于是个ListView；
69. SliverChildBuilderDelegate的totalCount属性，The total number of children this delegate can provide.If null, the number of children is determined by the least index for which [builder] returns null.
70. 对model中数据的修改，需要调用notifyListeners()方法通知监听者，更新页面；
71. [ReadContext] and its read method, similar to [watch], but doesn't make widgets rebuild if the value obtained changes.
72. late，显式声明一个非空的变量，但不初始化。如果不加late关键字，类实例化时此值是不确定的，无法通过静态检查，加上late关键字可以通过静态检查，但由此会带来运行时风险。
73. ChangeNotifierProvider  它会随着某些数据改变而被通知更新，也就是说，比如这个Model被用在多个page，那么当其中一处被改变时，他就应该告诉其他的地方，更新weight；ChangeNotifierProxyProvider，要协调Model与Model之间的更新，比如一个ModelA依赖另一个ModelB，ModelB更新，他就要让依赖它的ModelA也随之更新；
74. Provider.of()可以直接获取到provider中创建的model，select、read、watch类似这种；Consumer<CartModel>(builder:)在组件内部获取并使用model；
75. ProxyProvider本身是一个Provider，它把其他多个provider的数据结合成一个新的对象，并且把这个结果发送一个一个Provider。被结合的的这些provider中的任何一个数据更新了，这个新的对象都会更新。
76. 

### 集成Flutter到现有项目中
0. 新建flutter模块，flutter create --template module my_flutter，放在项目同级目录中；
1. podfile中添加如下脚本，并运行pod install；
    ```Ruby
    flutter_application_path = '../my_flutter'
    load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

    target 'Test' do 
      install_all_flutter_pods(flutter_application_path)
    end

    post_install do |installer|
      flutter_post_install(installer) if defined?(flutter_post_install)
    end
    ```
2. podhelper.rb 脚本会把你的 plugins， Flutter.framework，和 App.framework 集成到你的项目中；Flutter.framework 是 Flutter engine 的框架， App.framework 是你的 Dart 代码的编译产物；
3. 集成结束后，页面打开空白，在build phases里添加下面两行脚本即可
    `source "$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" embed`
    `source "$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" thin`
4. Expanded，Creates a widget that expands a child of a [Row], [Column], or [Flex] so that the child fills the available space along the flex widget's main axis.
5. FittedBox，Creates a widget that scales and positions its child within itself according to [fit]. The [fit] and [alignment] arguments must not be null.
6. DecoratedBox可以在其子组件绘制前(或后)绘制一些装饰(Decoration)，如背景、边框、渐变等。
7. Transform可以在其子组件绘制时对其应用一些矩阵变换来实现一些特效。
8. Container是一个组合类容器，它是DecoratedBox、ConstrainedBox、Transform、Padding、Align等组件组合的一个多功能容器，所以我们只需通过一个Container组件可以实现同时需要装饰、变换、限制的场景。
9. Scaffold，中文称之为脚手架，为开发者提供了路由页面的整体架构，开发者可以借助它快速便携地实现一个完整的页面。
10. 原生和flutter交互，应用中的 Flutter 部分通过平台通道向其宿主 (非 Dart 部分) 发送消息。宿主监听平台通道并接收消息。然后，它使用原生编程语言来调用任意数量的相关平台 API，并将响应发送回客户端（即应用程序中的 Flutter 部分）。
11. 通道的客户端和宿主端通过传递给通道构造函数的通道名称进行连接。一个应用中所使用的所有通道名称必须是唯一的；
  MethodChannel：flutter和Android之间互相调用，调用一次，执行一次，如Flutter调用Native拍照
  EventChannel：用于数据流（event streams）的通信，持续通信，收到消息后无法回复此次消息，通常用于Native向Dart的通信，如：手机电量变化，网络连接变化，陀螺仪，传感器等；
  BasicMessageChannel：用于传递字符串和半结构化的信息，持续通信，收到消息后可以回复此次消息，如：Native将遍历到的文件信息陆续传递到Dart，在比如：Flutter将从服务端陆陆续获取到信息交个Native加工，Native处理完返回等
12. 键值对是Map类型，as转换类型；
13. 要在 channel 对应的平台侧的后台中执行 handler，需要使用 Task Queue API。当前该功能仅支持在 iOS 和 Android。
14. 定义channel；setMethodCallHandler接受方法，通过call.method区分不同的方法调用；invokeMethod调用方法；
15. webview_flutter，初始化时需要配置允许js运行`javascriptMode: JavascriptMode.unrestricted`；
16. flutter调js，runJavascript或者runJavascriptReturningResult方法调用；js调flutter，javascriptChannels或者navigationDelegate两种方式都可以；js中使用scan.postMessage('test')调用；
17.
