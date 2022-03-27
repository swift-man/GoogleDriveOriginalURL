//
//  SettingsViewModel.swift
//  GoogleDriveOriginalURL
//
//  Created by SwiftMan on 2022/03/27.
//

import Foundation

final class SettingsViewModel: ObservableObject {
  @Published var isOnMarkdownTag: Bool = UserDefaults.isOnMarkdownTag {
    didSet {
      UserDefaults.isOnMarkdownTag = isOnMarkdownTag
    }
  }
  @Published var isOnMarkdownEnterKey: Bool = UserDefaults.isOnMarkdownEnterKey {
    didSet {
      UserDefaults.isOnMarkdownEnterKey = isOnMarkdownEnterKey
    }
  }
}

extension UserDefaults {
    @UserDefault(key: "isOnMarkdownTag", defaultValue: true)
    static var isOnMarkdownTag: Bool

    @UserDefault(key: "isOnMarkdownEnterKey", defaultValue: true)
    static var isOnMarkdownEnterKey: Bool
}
