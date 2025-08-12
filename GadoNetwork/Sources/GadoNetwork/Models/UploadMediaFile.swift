//
//  UploadMediaFile.swift
//  GadoNetwork
//
//  Created by ahmed gado on 11/08/2025.
//

import Foundation

public
struct UploadMediaFile {
  let key: String
  let filename: String
  let data: Data
  let mimeType: String
  init(data: Data, forKey key: String) {
    self.key = key
    self.mimeType = "image/jpeg"
    self.filename = "imagefile.jpg"
    self.data = data
  }
}
