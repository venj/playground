Playground
==========

This is a playground for myself.

The codes here are basically *ALL* template generated code from Xcode (or other tools).

The projects here are just for fun (and as reminders to myself), and may be not mature for production.

Projects Details
================

iOS
---

**CustomScrollView**

*Try to make a taobao product page scroll behavier replica.*

尝试实现类似淘宝产品页面的滚动效果。正在尝试中，未完成。

Not finished yet!!!

![Gif](https://raw.githubusercontent.com/venj/playground/master/CustomScrollView/screen.gif)

**NavBar Message**

*Mimic the info bar that can automatically hide, which can be used to replace UIAlertView or HUD in some occasions.*

A small info bar usually under navbar, which shows info to users, it will automatically hide itself within some seconds.

Know issue: View resize behavior is not right while rotating the device.

**ARC Shadow Table View**

*Shadow Table View originally by [Cocoa with love](http://www.cocoawithlove.com/2009/08/adding-shadow-effects-to-uitableview.html), remastered with ARC (and only ARC).*

This is the sample project to add shadows to tableview. 

The main class file are `ShadowTableView.h` && `ShadowTableView.m`. 

`GradientView.h` and `GradientView.m` are for table view cell gradient background.

**TapBack**

It is convinent to add doubletap gesture to navigation bar to let user quickly go back to the root level of the navigation controller's view controller stack. TapBack is a such demo app.

The core lies on a `UINavigationBar` subclass `VCNavigationBar`. Add VCNavigationBar.h and VCNavigationBar.m into your project, and import the header, then add following code (with your modification) to the proper place in your app:

```objc
TableViewController *tvControl = [[TableViewController alloc] initWithNibName:nil bundle:nil];
UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[VCNavigationBar class] toolbarClass:nil];
[nav addChildViewController:tvControl];
self.window.rootViewController = nav;
```

Before you use the code, you can try the demo app first. Click through into a really deeeeeeeep level in the view controller stack and then double tap the nav bar, and boom, you are back home again. ;) 

Mac
---

**Empty for now.**

(More projects to come.)


License
=======

[The MIT License (MIT)](http://opensource.org/licenses/MIT)<br>
Copyright (c) 2013 venj

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.