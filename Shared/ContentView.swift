//
//  ContentView.swift
//  Shared
//
//  Created by Mufeed AlMatar on 23/11/1443 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsTabView()
                .tabItem({
                    Label("News", systemImage: "newspaper")
                })
            
            SearchTabView()
                .tabItem({
                    Label("Search", systemImage: "magnifyingglass")
                })
            
            BookmarkTapView()
                .tabItem({
                    Label("Saved", systemImage: "bookmark")
                })
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
