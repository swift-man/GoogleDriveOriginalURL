//
//  TopViewModel.swift
//  GoogleDriveOriginalURL
//
//  Created by SwiftMan on 2022/03/28.
//

import SwiftUI

final class TopViewModel: ObservableObject {
  @Published var viewModels: [URLInputViewModel]
  
  init(viewModels: [URLInputViewModel]) {
    self.viewModels = viewModels
  }
  
  func convertAll() {
    for viewModel in viewModels {
      viewModel.convert()
    }
  }
  
  func hasSuccess() -> Bool {
    for viewModel in viewModels {
      if viewModel.state == .success {
        return true
      }
    }
    return false
  }
  
  @discardableResult
  func copyAll() -> String {
    var successText = ""
    for viewModel in viewModels where viewModel.state == .success {
      if successText.isEmpty {
        successText = viewModel.input
      } else {
        successText += "\n"
        successText += viewModel.input
      }
    }
    
    guard !successText.isEmpty else { return successText }
    
    let pasteBoard = NSPasteboard.general
    pasteBoard.clearContents()
    pasteBoard.setString(successText, forType: .string)
    
    return successText
  }
  
  func undoAll() {
    for viewModel in viewModels {
      viewModel.undo()
    }
  }
  
  func clearAll() {
    for viewModel in viewModels {
      viewModel.clear()
    }
  }
}
