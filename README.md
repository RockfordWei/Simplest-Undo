# 最简单的NSUndoManager示范 - Simplest NSUndoManager Demo

网上看了很多关于NSUndoManager的示例，很晕——其实Notification是用不上的。动手写了一个最基本最简单的示范。
Just read a lot of examples online about NSUndoManager, very hard to understand, so made a simplest one to show that Notification is actually ignorable.

## 创建工程 - Create an Empty Project

只需要创建一个空白的 mac Cocoa 工程即可，什么storyboard，统统不需要。
Create a blank Cocoa project for mac, that's it! You don't have to do anything about the storyboard.

## 实现目标 - Objectives

为了简化起见，我们仅响应鼠标在默认窗体上的点击动作，每点击一下就让窗体标题追加一个“1”。
We simplified the input to clicking on the window and every mouse down will result in an extra "1" appended in the window's title.

一旦点击，则要求随时Undo / Redo
Once clicked, you can do undo / redo at any time.

## 代码 - Code

``` swift

func add(last: String) {
  if let u = undoManager {
    u.registerUndo(withTarget: self) { this in
      this.remove(last: last)
    }//end u
    self.view.window?.title = last
    u.setActionName("Add")
  }//end if
}//end func

func remove(last: String) {
  if let u = undoManager {
    u.registerUndo(withTarget: self) { this in
      this.add(last: last)
    }//end u
    self.view.window?.title = last
    u.setActionName("Remove")
  }//end if
}

override func mouseUp(with event: NSEvent) {
  var text = self.view.window?.title ?? "unknown"
  text.append("1")
  add(last: text)
}


```

## 说明 - Notes
Add()和Remove()是可逆操作，因此内部必须向NSUndoManager注册逆向操作的实现方法，注册完了才能执行真正的操作，就这么一句话！
Simply because Add() and Remove() are reversible so both of them need to register the inversion before committing the modification, that's it!!!
