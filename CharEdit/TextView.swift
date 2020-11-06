//
//  TextView.swift
//  CharEdit
//
//  Created by Adrian Thomas Clinansmith on 2020-09-19.
//  Copyright © 2020 Adrian Thomas Clinansmith. All rights reserved.
//
// didSet delegate: https://stackoverflow.com/questions/25724709/overriding-delegate-property-of-uiscrollview-in-swift-like-uicollectionview-doe

import Cocoa

//MARK:- Extend Delegate

protocol TextViewDelegate: NSTextViewDelegate {
   func textViewDidReceiveOptCmdArrow(_ charView: NSTextView, pressedArrow arrow: String)
}

//MARK:- Class

class TextView: NSTextView {
   
   private weak var textViewDelegate: TextViewDelegate?
   override weak var delegate: NSTextViewDelegate? {
      didSet {
          textViewDelegate = delegate as? TextViewDelegate
      }
   }
   
   override public func keyDown(with event: NSEvent) {
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
