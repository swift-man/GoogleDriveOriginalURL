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
      if viewModel.leftImageColor == .clear {
        Button(action: {
          viewModel.parse()
        }, label: {
          Image(systemName: "wand.and.stars.inverse")
          Text("Parse")
        })
        .alert(Text("오류가 발생했습니다."), isPresented: $viewModel.isError, actions: {
          Button(action: {
            viewModel.clearError()
          }, label: {
            Text("확인")
          })
        }, message: {
          Text(viewModel.errorMessage)
        })
      } else if viewModel.leftImageColor == .green {
        Button(action: {
          viewModel.copy()
          viewModel.updateCopyButtonColor()
        }, label: {
          Image(systemName: "wand.and.stars.inverse")
          Text("Copy")
        })
        .foregroundColor(viewModel.copyButtonColor)
      }
      
      Button(action: {
        viewModel.clear()
      }, label: {
        Image(systemName: "xmark.circle")
        Text("clear")
      })
    }
  }
}
