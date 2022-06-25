//
//  BookmarkTapView.swift
//  XCANews (iOS)
//
//  Created by Mufeed AlMatar on 25/11/1443 AH.
//

import SwiftUI

struct BookmarkTapView: View {

    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    @State var searchText: String = ""
    
    private var articles: [Article] {
        if searchText.isEmpty {
            return articleBookmarkVM.bookmarks
        }
        return articleBookmarkVM.bookmarks
            .filter {
                $0.titleText.lowercased().contains(searchText.lowercased()) ||
                $0.descriptionText.lowercased().contains(searchText.lowercased())
            }
    }
    
    var body: some View {
        let articles = self.articles
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView(isEmpty: articles.isEmpty))
                .navigationTitle("Saved Articles")
        }
        .searchable(text: $searchText)
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No Saved Article", image: Image(systemName: "bookmark"))
        }
    }
}

struct BookmarkTapView_Previews: PreviewProvider {
    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        BookmarkTapView()
            .environmentObject(articleBookmarkVM)
    }
}
