//
//  SettingsView.swift
//  GoogleDriveOriginalURL
//
//  Created by SwiftMan on 2022/03/27.
//

import SwiftUI

struct SettingsView: View {
  @State var viewModel = SettingsViewModel()
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0, content: {
      Toggle("Append MarkDown Tag", isOn: $viewModel.isOnMarkdownTag)
        .toggleStyle(SwitchToggleStyle())
      Toggle("Append MarkDown Enter Key", isOn: $viewModel.isOnMarkdownEnterKey)
        .toggleStyle(SwitchToggleStyle())
    })
  }
}
