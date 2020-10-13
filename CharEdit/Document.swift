//
//  Document.swift
//  CharEdit2
//
//  Created by Adrian Thomas Clinansmith on 2020-08-19.
//  Copyright © 2020 Adrian Thomas Clinansmith. All rights reserved.
//
// Source: https://developer.apple.com/documentation/appkit/documents_data_and_pasteboard/developing_a_document-based_app

import Cocoa

class Document: NSDocument {
   
   var content = Content(contentString: nil) 

   //MARK: Initializers
   
   override init() {
       super.init()
      // Add your subclass-specific initialization here.
   }
   
   //MARK: NSDocument Methods

   override class var autosavesInPlace: Bool {
      return false
   }

   override func makeWindowControllers() {
      // Returns the Storyboard that contains your Document window.
      let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
      if let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as? NSWindowController {
         self.addWindowController(windowController)
         
         // Set the view controller's represented object as your document.
         if let contentVC = windowController.contentViewController as? ViewController {
            contentVC.representedObject = self.content
         }
      }
   }

   override func data(ofType typeName: String) throws -> Data {
      guard let data = self.content.data() else {
         throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
      }
      return data
   }

   override func read(from data: Data, ofType typeName: String) throws {
      let didRead = self.content.read(from: data)
      if didRead == false {
         throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
      }
   }


}

