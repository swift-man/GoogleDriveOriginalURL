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
  
  func convertInputURL(hasMarkdownTag: Bool,
                       hasMarkdownEnterKey: Bool,
                       input: String) {
    stack.append(inputSubject.value)
    
    var urlString = input
    if urlString.isEmpty {
      inputSubject.send((.failure, "입력된 URL 이 없어요!"))
      return
    }
    if !urlString.hasPrefix("https://drive.google.com/") {
      inputSubject.send((.failure, "URL 을 확인해보세요. ex) https://drive.google.com/"))
      return
    }
    urlString = urlString.replacingOccurrences(of: "/file/d/", with: "/uc?export=view&id=")
    urlString = urlString.replacingOccurrences(of: "/view?usp=sharing", with: "")
    urlString = urlString.replacingOccurrences(of: "/view?usp=share_link", with: "")
    
    if hasMarkdownTag {
      urlString = "![Image](\(urlString))"
    }
    
    if hasMarkdownEnterKey {
      urlString = "\(urlString)  "
    }
    
    inputSubject.send((.success, urlString))
  }
  
  func clear() {
    stack.append(inputSubject.value)
    inputSubject.send((.normal, ""))
  }
  
  func undo() {
    if !stack.isEmpty {
      inputSubject.send(stack.removeLast())
    }
  }
}
