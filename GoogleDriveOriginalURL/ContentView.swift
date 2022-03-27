//
//  ContentView.swift
//  GoogleDriveOriginalURL
//
//  Created by 김승진 on 2021/08/26.
//

import SwiftUI

struct ContentView: View {
  @State var viewModels = [URLInputViewModel(index: 0),
                           URLInputViewModel(index: 1),
                           URLInputViewModel(index: 2),
                           URLInputViewModel(index: 3),
                           URLInputViewModel(index: 4),
                           URLInputViewModel(index: 5),
                           URLInputViewModel(index: 6),
                           URLInputViewModel(index: 7),
                           URLInputViewModel(index: 8),
                           URLInputViewModel(index: 9),
                           URLInputViewModel(index: 10),
                           URLInputViewModel(index: 11),
                           URLInputViewModel(index: 12),
                           URLInputViewModel(index: 13),
                           URLInputViewModel(index: 14),
                           URLInputViewModel(index: 15)]
  
  @State private var isOn = true
  
  var body: some View {
    List {
      ForEach(viewModels.indices) { index in
        URLInputView(viewModel: viewModels[index])
      }
      BottomView(isOn: $isOn, viewModels: $viewModels)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

