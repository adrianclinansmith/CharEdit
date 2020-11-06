//
//  ViewController.swift
//  CharEdit
//
//  Created by Adrian Thomas Clinansmith on 2020-08-19.
//  Copyright © 2020 Adrian Thomas Clinansmith. All rights reserved.
//
// Use viewWillAppear: https://stackoverflow.com/questions/27702002/mac-app-storyboard-access-document-in-nsviewcontroller

import Cocoa

class ViewController: NSViewController, TextViewDelegate {
   
   @IBOutlet var textView: TextView!
   
   //MARK: NSViewController Methods
   
   override func viewDidLoad() {
      super.viewDidLoad()
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
   
   //MARK: TextView Delegate

   func textDidChange(_ notification: Notification) {
      self.updateModel()
   }
   
   func textViewDidReceiveOptCmdArrow(_ textView: NSTextView, pressedArrow arrow: String) {
      let segment = NSSegmentedControl()
      segment.selectedSegment = arrow == "down" ? 0 : 1;
      self.addToChars(segment)
   }
   
   //MARK: IBActions
   
   @IBAction func addToChars(_ sender: NSSegmentedControl) {
      guard let selectedRange = self.textView.selectedRanges.first?.rangeValue else { return }
      guard selectedRange.length > 0 else { return }
      guard let stringRange = Range(selectedRange, in: self.textView.string) else { return }
      
      let decrement = sender.selectedSegment == 0
      let substring = String(self.textView.string[stringRange])
      let newSubstring = String(substring.unicodeScalars.map { Character(UnicodeScalar(decrement ? $0.value-1 : $0.value+1)!) })
      self.textView.string.replaceSubrange(stringRange, with: newSubstring)
      self.textView.setSelectedRange(selectedRange)
      self.updateModel()
   }
   
   //MARK: Helper Methods
   
   func updateModel() {
      guard let content = self.representedObject as? Content else { return }
      guard let document = self.view.window?.windowController?.document as? Document else { return }
      
      content.contentString = self.textView.string
      document.updateChangeCount(.changeDone)
   }

}

