//
//  TextView.swift
//  CharEdit
//
//  Created by Adrian Thomas Clinansmith on 2020-09-19.
//  Copyright © 2020 Adrian Thomas Clinansmith. All rights reserved.
//

import Cocoa

class TextView: NSTextView {
   
   weak var textViewDelegate: TextViewDelegate?
   
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
   
   override func keyDown(with event: NSEvent) {
      if event.modifierFlags.intersection(.deviceIndependentFlagsMask) == [NSEvent.ModifierFlags.command, NSEvent.ModifierFlags.option, NSEvent.ModifierFlags.function, NSEvent.ModifierFlags.numericPad] {
         if event.keyCode == 126 {
            textViewDelegate?.textViewDidReceiveOptCmdArrow(self, pressedArrow: "up")
         }
         else if event.keyCode == 125 {
            textViewDelegate?.textViewDidReceiveOptCmdArrow(self, pressedArrow: "down")
         }
      }
      else {
         super.keyDown(with: event)
      }
   }
    
}

//MARK:- TextViewDelegate

protocol TextViewDelegate: AnyObject {
   func textViewDidReceiveOptCmdArrow(_ charView: TextView, pressedArrow arrow: String)
}
