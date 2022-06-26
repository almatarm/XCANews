//
//  TabContentView.swift
//  XCANews (iOS)
//
//  Created by Mufeed AlMatar on 27/11/1443 AH.
//

import SwiftUI

struct TabContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                NewsTabView()
                    .tabItem({
                        Label("News", systemImage: "newspaper")
                    })
            }
            
            NavigationView {
                SearchTabView()
                    .tabItem({
                        Label("Search", systemImage: "magnifyingglass")
                    })
            }
            
            NavigationView {
                BookmarkTapView()
                    .tabItem({
                        Label("Saved", systemImage: "bookmark")
                    })
            }
        }
    }
}

struct TabContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabContentView()
    }
}
