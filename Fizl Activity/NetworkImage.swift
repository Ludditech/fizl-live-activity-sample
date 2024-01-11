//
//  NetworkImage.swift
//  Fizl
//
//  Created by Dominic on 2023-12-29.
//

import SwiftUI

struct NetworkImage: View {
  let url: URL?
  
  var body: some View {
    Group {
      if let url = url, let imageData = try? Data(contentsOf: url),
         let uiImage = UIImage(data: imageData) {
        
        Image(uiImage: uiImage)
          .resizable()
      }
      else {
        ProgressView()
      }
    }
  }
}
