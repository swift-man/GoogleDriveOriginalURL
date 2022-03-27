//
//  TopView.swift
//  GoogleDriveOriginalURL
//
//  Created by 김승진 on 2021/08/26.
//

import SwiftUI

struct TopView: View {
  @Binding var topViewModel: TopViewModel
  @State var isHiddenAllCopyButton = true
  
  var body: some View {
    HStack {
      Button(action: {
        topViewModel.convertAll()
        isHiddenAllCopyButton = !topViewModel.hasSuccess()
      }, label: {
        Image(systemName: "hammer")
        Text("Convert!")
      })
      Button(action: {
        topViewModel.copyAll()
      }, label: {
        Image(systemName: "text.badge.checkmark")
        Text("All Copy")
      })
      .opacity(isHiddenAllCopyButton ? 0 : 1)
      Spacer()
      Button(action: {
        topViewModel.undoAll()
        isHiddenAllCopyButton = !topViewModel.hasSuccess()
      }, label: {
        Image(systemName: "arrow.uturn.backward")
        Text("undo")
      })
      Button(action: {
        topViewModel.clearAll()
        isHiddenAllCopyButton = true
      }, label: {
        Image(systemName: "xmark")
        Text("All Clear")
      })
    }
  }
}
