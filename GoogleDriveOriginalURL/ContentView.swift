//
//  ContentView.swift
//  GoogleDriveOriginalURL
//
//  Created by 김승진 on 2021/08/26.
//

import SwiftUI

struct ContentView: View {
  
  var body: some View {
    TabView {
      ConvertListView()
        .tabItem {
          Image(systemName: "repeat")
          Text("Convert List")
        }
      SettingsView()
        .tabItem {
          Image(systemName: "gear")
          Text("Settings")
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

