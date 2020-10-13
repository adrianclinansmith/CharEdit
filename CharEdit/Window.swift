//
//  Window.swift
//  CharEdit
//
//  Created by Adrian Thomas Clinansmith on 2020-09-19.
//  Copyright © 2020 Adrian Thomas Clinansmith. All rights reserved.
//

import Cocoa

class Window: NSWindow {
   
   override func keyDown(with event: NSEvent) {
      super.keyDown(with: event)
      print("key down")
   }
}
