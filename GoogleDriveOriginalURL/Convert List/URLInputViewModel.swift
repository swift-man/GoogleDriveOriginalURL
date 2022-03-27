//
//  URLInputViewModel.swift
//  GoogleDriveOriginalURL
//
//  Created by 김승진 on 2021/08/26.
//

import Foundation
import Combine
import SwiftUI

enum URLInputViewModelError: Error {
  case notString
  case notURL
  
  var message: String {
    switch self {
    case .notString:
      return "복사할 수 없는 값입니다. 다시 한번 확인해 주세요."
    case .notURL:
      return "복사된 값이 URL 형태인지 다시 한번 확인해 주세요.\n예(https://...)"
    }
  }
}

final class URLInputViewModel: ObservableObject {
  let index: Int
  let service = URLConvertService()
  var subscriptions = Set<AnyCancellable>()
  var leftImageName: String = ""
  @Published var leftImageColor = Color.clear
  @Published var input: String = ""
  @Published var state: URLConvertState = .normal
  
  @Published var isError: Bool = false
  @Published var errorMessage: String = ""
  
  lazy var placeholder = "https://drive.google.com/file/d/xxxx\(index)/view?usp=sharing"
  
  init(index: Int) {
    self.index = index
    
    service.inputSubject.sink(receiveValue: { [weak self] value in
      guard let self = self else { return }
      
      self.input = value.text
      self.state = value.state
      
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
  
  func convert() {
    let settingsViewModel = SettingsViewModel()
    service.convertInputURL(hasMarkdownTag: settingsViewModel.isOnMarkdownTag,
                            hasMarkdownEnterKey: settingsViewModel.isOnMarkdownEnterKey,
                            input: input)
  }
  
  func undo() {
    service.undo()
  }
  
  func clear() {
    service.clear()
  }
  
  func parse() {
    guard let str = NSPasteboard.general.pasteboardItems?.first?.string(forType: .string)
    else {
      isError = true
      errorMessage = URLInputViewModelError.notString.message
      return
    }
    guard URL(string: str) != nil
    else { isError = true
      isError = true
      errorMessage = URLInputViewModelError.notURL.message
      return
    }
    
    service.inputSubject.send((.normal, str))
  }
  
  func clearError() {
    isError = false
    errorMessage = ""
  }
  
  func copy() {
    let pasteBoard = NSPasteboard.general
    pasteBoard.clearContents()
    pasteBoard.setString(input, forType: .string)
  }
}
