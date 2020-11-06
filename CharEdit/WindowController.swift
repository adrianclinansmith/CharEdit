//
//  WindowController.swift
//  CharEdit
//
//  Created by Adrian Thomas Clinansmith on 2020-11-05.
//  Copyright © 2020 Adrian Thomas Clinansmith. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
   
   @IBOutlet var addToCharsItem: NSToolbarItem!
   @IBOutlet var addToCharsControl: NSSegmentedControl!
   
   override func windowDidLoad() {
      super.windowDidLoad()
      let area = NSTrackingArea.init(rect: self.addToCharsControl.bounds, options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways], owner: self, userInfo: nil)
      self.addToCharsControl.addTrackingArea(area)
   }
   
   override func mouseEntered(with event: NSEvent) {
      self.addToCharsItem.label = "⌥-⌘-(↑ or ↓)"
   }
   
   override func mouseExited(with event: NSEvent) {
      self.addToCharsItem.label = "chars±1"
   }
   
}


