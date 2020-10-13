//
//  Content.swift
//  CharEdit2
//
//  Created by Adrian Thomas Clinansmith on 2020-08-21.
//  Copyright © 2020 Adrian Thomas Clinansmith. All rights reserved.
//

import Cocoa

class Content: NSObject {
   
   @objc dynamic var contentString: String?
   @objc dynamic var didReadData = false
   
   public init(contentString: String?) {
       self.contentString = contentString
   }
   
   @objc func data() -> Data? {
      guard let contentString = self.contentString else { return nil }
      return Data(contentString.utf8)
   }
   
   @objc func read(from data: Data) -> Bool {
      guard let contentString = String(data: data, encoding: .utf8) else { return false }
      self.contentString = contentString
      self.didReadData = true
      return true
   }
}
