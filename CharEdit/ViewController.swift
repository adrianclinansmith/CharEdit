//
//  ViewController.swift
//  CharEdit
//
//  Created by Adrian Thomas Clinansmith on 2020-08-19.
//  Copyright © 2020 Adrian Thomas Clinansmith. All rights reserved.
//
// Use viewWillAppear: https://stackoverflow.com/questions/27702002/mac-app-storyboard-access-document-in-nsviewcontroller

import Cocoa

class ViewController: NSViewController, NSTextViewDelegate, TextViewDelegate {

   @IBOutlet var textView: TextView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.textView.textViewDelegate = self
      self.textView.usesFindBar = true
      self.textView.isIncrementalSearchingEnabled = true
   }
   
   override func viewWillAppear() {
      super.viewWillAppear()
      guard let content = self.representedObject as? Content else { return }
      if content.didReadData {
         self.textView.string = content.contentString!
         content.didReadData = false
      }
   }
   
   //MARK: NSTextView Delegate

   func textDidChange(_ notification: Notification) {
      self.updateModel()
   }
   
   //MARK: TextView Delegate
   
   func textViewDidReceiveOptCmdArrow(_ textView: TextView, pressedArrow arrow: String) {
      self.incrementChars(shouldDecrement: arrow == "down")
   }
   
   //MARK: IBActions
   
   @IBAction func addToChars(_ sender: NSSegmentedControl) {
      self.incrementChars(shouldDecrement: sender.selectedSegment == 0)
   }
   
   //MARK: Helper Methods
   
   func incrementChars(shouldDecrement decrement: Bool = false) {
      guard let selectedRange = self.textView.selectedRanges.first?.rangeValue else { return }
      guard selectedRange.length > 0 else { return }
      guard let stringRange = Range(selectedRange, in: self.textView.string) else { return }
      
      let newSubstring = String(self.textView.string[stringRange].unicodeScalars.map {
         Character(UnicodeScalar(decrement ? $0.value-1 : $0.value+1)!)
      })
      self.textView.string.replaceSubrange(stringRange, with: newSubstring)
      self.textView.setSelectedRange(selectedRange)
      self.updateModel()
   }
   
   func updateModel() {
      guard let content = self.representedObject as? Content else { return }
      guard let document = self.view.window?.windowController?.document as? Document else { return }
      
      content.contentString = self.textView.string
      document.updateChangeCount(.changeDone)
   }

}

