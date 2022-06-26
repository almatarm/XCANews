//
//  SidebarContentView.swift
//  XCANews (iOS)
//
//  Created by Mufeed AlMatar on 27/11/1443 AH.
//

import SwiftUI

struct SidebarContentView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach([MenuItem.saved, MenuItem.search]) {
                    navigationLinkForMenuItem($0)
                }
            
                Section {
                    ForEach(Category.menuItems) {
                        navigationLinkForMenuItem($0)
                    }
                } header: {
                    Text("Categories")
                }
                .navigationTitle("XCA News")
            }
            .listStyle(.sidebar)
            
            NewsTabView()
        }
    }
    
    private func navigationLinkForMenuItem(_ item: MenuItem) -> some View {
        NavigationLink(destination: viewForMenuItem(item: item)) {
            Label(item.text, systemImage: item.systemImage)
        }
    }
    
    @ViewBuilder
    private func viewForMenuItem(item: MenuItem) -> some View {
        switch item {
        case .search:
            SearchTabView()
        case .saved:
            BookmarkTapView()
        case .category(let category):
            NewsTabView(category: category)
        }
    }
}

struct SidebarContentView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarContentView()
    }
}
