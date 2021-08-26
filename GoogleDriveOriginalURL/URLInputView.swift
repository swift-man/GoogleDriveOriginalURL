//
//  URLInputView.swift
//  GoogleDriveOriginalURL
//
//  Created by 김승진 on 2021/08/26.
//

import Foundation
import SwiftUI
import CoreServices

struct URLInputView: View {
  @StateObject var viewModel: URLInputViewModel
  
  var body: some View {
    HStack {
      if viewModel.leftImageColor != .clear {
        Image(systemName: viewModel.leftImageName)
          .foregroundColor(viewModel.leftImageColor)
      }
      
      TextField(viewModel.placeholder, text: $viewModel.input)
      Button(action: {
        viewModel.parse()
      }, label: {
        Image(systemName: "wand.and.stars.inverse")
        Text("Parse")
      })
      Button(action: {
        viewModel.copy()
      }, label: {
        Image(systemName: "wand.and.stars.inverse")
        Text("Copy")
      })
      Button(action: {
        viewModel.clear()
      }, label: {
        Image(systemName: "xmark.circle")
        Text("clear")
      })
    }
  }
}
