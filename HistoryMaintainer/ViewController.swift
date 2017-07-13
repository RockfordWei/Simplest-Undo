//
//  ViewController.swift
//  HistoryMaintainer
//
//  Created by Rocky Wei on 2017-07-13.
//  Copyright © 2017 Rocky Wei. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }

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

}

