//
//  ConvertListView.swift
//  GoogleDriveOriginalURL
//
//  Created by SwiftMan on 2022/03/27.
//

import SwiftUI

struct ConvertListView: View {
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
  
  var body: some View {
    List {
      TopView(viewModels: $viewModels)
      ForEach(0 ..< viewModels.count, id: \.self) { index in
        URLInputView(viewModel: viewModels[index])
      }
    }
  }
}
