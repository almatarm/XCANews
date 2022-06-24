//
//  XCANewsApp.swift
//  Shared
//
//  Created by Mufeed AlMatar on 23/11/1443 AH.
//

import SwiftUI

@main
struct XCANewsApp: App {
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
    }
}
