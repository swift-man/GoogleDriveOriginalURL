//
//  TopView.swift
//  GoogleDriveOriginalURL
//
//  Created by 김승진 on 2021/08/26.
//

import SwiftUI

struct TopView: View {
  @Binding var viewModels: [URLInputViewModel]
  
  var body: some View {
    HStack {
      Button(action: {
        for viewModel in viewModels {
          viewModel.convertAll()
        }
      }, label: {
        Image(systemName: "hammer")
        Text("Convert!")
      })
      Spacer()
      Button(action: {
        for viewModel in viewModels {
          viewModel.undo()
        }
      }, label: {
        Image(systemName: "arrow.uturn.backward")
        Text("undo")
      })
      Button(action: {
        for viewModel in viewModels {
          viewModel.clear()
        }
      }, label: {
        Image(systemName: "xmark")
        Text("All Clear")
      })
    }
  }
}
