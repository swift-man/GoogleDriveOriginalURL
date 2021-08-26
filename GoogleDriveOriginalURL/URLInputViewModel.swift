//
//  URLInputViewModel.swift
//  GoogleDriveOriginalURL
//
//  Created by 김승진 on 2021/08/26.
//

import Foundation
import Combine
import SwiftUI

class URLInputViewModel: ObservableObject {
  let index: Int
  let service = URLConvertService()
  var subscriptions = Set<AnyCancellable>()
  var leftImageName: String = ""
  @Published var leftImageColor = Color.clear
  @Published var input: String = ""
  
  lazy var placeholder = "https://drive.google.com/file/d/xxxx\(index)/view?usp=sharing"
  
  init(index: Int) {
    self.index = index
    
    service.inputSubject.sink(receiveValue: { [weak self] value in
      guard let self = self else { return }
      self.input = value.text
      switch value.state {
      case .failure:
        self.leftImageName = "exclamationmark.octagon.fill"
        self.leftImageColor = .red
      case .normal:
        self.leftImageName = "checkmark.square.fill"
        self.leftImageColor = .clear
      case .success:
        self.leftImageName = "checkmark.square.fill"
        self.leftImageColor = .green
      }
    })
    .store(in: &subscriptions)
  }
  
  func convert(hasMarkdownTag: Bool) {
    service.convertInputURL(hasMarkdownTag: hasMarkdownTag, input: input)
  }
  
  func undo() {
    service.undo()
  }
  
  func clear() {
    service.inputSubject.send((.normal, ""))
  }
  
  func parse() {
    if let str = NSPasteboard.general.pasteboardItems?.first?.string(forType: .string) {
      if URL(string: str) != nil {
        service.inputSubject.send((.normal, str))
      }
    }
  }
  
  func copy() {
    let pasteBoard = NSPasteboard.general
    pasteBoard.clearContents()
    pasteBoard.setString(input, forType: .string)
  }
}
