//
//  URLConvertService.swift
//  GoogleDriveOriginalURL
//
//  Created by 김승진 on 2021/08/26.
//

import Foundation
import Combine

enum URLConvertState {
  case failure
  case normal
  case success
}

final class URLConvertService {
  let inputSubject = CurrentValueSubject<(state: URLConvertState, text: String), Never>((.normal, ""))
  private var stack: [(URLConvertState, String)] = []
  
  func convertInputURL(hasMarkdownTag: Bool, input: String) {
    stack.append(inputSubject.value)
    
    var urlString = input
    if urlString.isEmpty {
      inputSubject.send((.failure, "text not have"))
      return
    }
    if !urlString.hasPrefix("https://drive.google.com/") {
      inputSubject.send((.failure, "invalid URL!! check https://drive.google.com/"))
      return
    }
    urlString = urlString.replacingOccurrences(of: "/file/d/", with: "/uc?export=view&id=")
    urlString = urlString.replacingOccurrences(of: "/view?usp=sharing", with: "")
    
    inputSubject.send((.success, hasMarkdownTag ? "![Image](\(urlString))" : urlString ))
  }
  
  func undo() {
    if !stack.isEmpty {
      inputSubject.send(stack.removeLast())
    }
  }
}
