#### 第一个flutter应用
1. flutter中所有组件都是widget，包括布局、填充、对齐；Scaffold默认的widget，包括导航栏、标题、主屏幕树的body属性；每个widget都有build方法来描述如何构建自己；
2. stateless widget不可变的，所有属性不能改变；stateful widget组件属性在widget生命周期内可以改变；stateful widget至少包括两个类，stateful widget类（不变）和state（变化）类；输入stful，回车创建有状态类模板代码；state类加下换线前缀；
3. 使用setstate方法，会重新调用widget的build方法，渲染组件；某些widget需要单个widget，有些widget需要一组widget；Navigator.push切换路由，入栈出栈操作；MaterialPageRoute路由页面，builder方法中创建页面并返回；ListTile 的 divideTiles() 方法在每个 ListTile 之间添加 1 像素的分割线；
4. widget类似UIView，当widget实例或状态变化时就会重绘节点树，UIView需要手动调用setneedsdisplay重绘；widget轻量级的，不可变，是对视图及特性的描述，不绘制视图；修改widget的state来间接修改视图；可能会动态变化的用statefulwidget，不会变化的用statelesswidget；
5. 不能移除或添加视图，可以通过判断来决定要显示的widget；使用AnimationController设置动画，添加一个或多个animation对象到控制器中；
 CustomPaint 和 CustomPainter绘制相关的类，CustomPainter可以自定义画笔的属性；
6. flutter里自定义视图需要组合小的widget来实现，而不是继承；参数传递可以通过await push和pop(param)实现；dart是单线程执行，执行一个eventloop，除非生成了 Isolate，否则所有 Dart 代码将永远在主 UI 线程运行，并由事件循环驱动；可以通过async/await来实现异步操作；Isolate来执行其他复杂的异步操作，防止主线程阻塞，不和主线程共享内存，不能使用setstate更新ui；
7. ReceivePort：Opens a long-lived port for receiving messages.A [ReceivePort] is a non-broadcast stream. This means that it buffers incoming messages until a listener is registered. Only one listener can receive messages. 
8. SendPort：Sends messages to its [ReceivePort]s.[SendPort]s are created from [ReceivePort]s. Any message sent through a [SendPort] is delivered to its corresponding [ReceivePort]. There might be many [SendPort]s for the same [ReceivePort].
9. Isolate.spawn(entryPoint, message)：Creates and spawns an isolate that shares the same code as the current isolate.The argument [entryPoint] specifies the initial function to call in the spawned isolate. The entry-point function is invoked in the new isolate with [message] as the only argument.
10. 创建ReceivePort用于接收数据，sendPort不用自己创建，调用receivePort.sendPort即可；接收的消息可以通过receivePort.first或者遍历ReceivePort获得；
11. didChangeAppLifecycleState监听App运行状态；少量数据使用listview的构造方法，大量数据使用listview.builder方法；widget不能直接获取组件上的值，需要使用controller来中转，从controller获取；TextEditingController输入框controller，可以监控和获取输入框的值；
12. Flutter和原生通信，Flutter 提供了用来和宿主 ViewController 通信和交换数据的 平台通道。平台通道本质上是一个桥接了 Dart 代码与宿主 ViewController 和 iOS 框架的异步通信模型。你可以通过平台通道来执行原生代码的方法，或者获取设备的传感器信息等数据。
13. 命令式UI，你手动构建一个全功能的 UI 实例，比如一个 UIView 或其他类似的，在随后 UI 发生变化时，使用方法或 Setter 修改它。为了减轻开发人员的负担，无需编写如何在不同的 UI 状态之间进行切换的代码；声明式UI，Flutter 相反，让开发人员描述当前的 UI 状态，并将转换交给框架。
14. 在声明式风格中，视图配置（如 Flutter 的 Widget ）是不可变的，它只是轻量的“蓝图”。要改变 UI，widget 会在自身上触发重建；RenderObjects 管理传统 UI 对象， RenderObjects 在帧之间保持不变， Flutter 的轻量级 widget 通知框架在状态之间修改 RenderObjects；
15. 
