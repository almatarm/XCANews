//
//  ContentView.swift
//  Shared
//
//  Created by Mufeed AlMatar on 23/11/1443 AH.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    var body: some View {
        switch horizontalSizeClass {
        case .regular:
            SidebarContentView()
            
        default:
            TabContentView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        ContentView()
            .environmentObject(articleBookmarkVM)
    }
}
