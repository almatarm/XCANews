//
//  BookmarkTapView.swift
//  XCANews (iOS)
//
//  Created by Mufeed AlMatar on 25/11/1443 AH.
//

import SwiftUI

struct BookmarkTapView: View {

    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articleBookmarkVM.bookmarks)
                .overlay(overlayView(isEmpty: articleBookmarkVM.bookmarks.isEmpty))
                .navigationTitle("Saved Articles")
        }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No Saved Article", image: Image(systemName: "bookmark"))
        }
    }
}

struct BookmarkTapView_Previews: PreviewProvider {
    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel()
    
    static var previews: some View {
        BookmarkTapView()
            .environmentObject(articleBookmarkVM)
    }
}
