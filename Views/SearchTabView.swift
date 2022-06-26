//
//  SearchTabView.swift
//  XCANews (iOS)
//
//  Created by Mufeed AlMatar on 25/11/1443 AH.
//

import SwiftUI

struct SearchTabView: View {
    @StateObject var searchVM = ArticleSearchViewModel.shared
    
    private var articles: [Article] {
        if  case .success(let articles) = searchVM.phase {
            return articles
        } else {
            return []
        }
    }
    
    var body: some View {
        ArticleListView(articles: articles)
            .overlay(overlayView)
            .navigationTitle("Search")
            .searchable(text: $searchVM.searchQuery) { sugguestoinsView }
            .onChange(of: searchVM.searchQuery) { newValue in
                if newValue.isEmpty {
                    searchVM.phase = .empty
                }
            }
            .onSubmit(of: .search, search)
        
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch searchVM.phase {
        case .empty:
            if !searchVM.searchQuery.isEmpty {
                ProgressView()
            } else if !searchVM.history.isEmpty {
                SearchHistoryListView(searchVM: searchVM) { newValue in
                    searchVM.searchQuery = newValue
                }
            } else {
                EmptyPlaceholderView(text: "Type your search query to search from NewsAPI", image: Image(systemName: "magnifyingglass"))
            }
            
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No search result found", image: Image(systemName: "magnifingglass"))
        
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: search)
            
        default: EmptyView()
        }
    }
    
    private func search() {
        let searchQuery = searchVM.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if !searchQuery.isEmpty {
            searchVM.addHistory(searchQuery)
        }
        async {
            await searchVM.searchArticle()
        }
    }
    
    @ViewBuilder
    private var sugguestoinsView: some View {
        ForEach(["Swift", "BTC", "PS5", "iOS 15"], id: \.self) { text in
            Button {
                searchVM.searchQuery = text
            } label: {
                Text(text)
            }
        }
    }
    
}

struct SearchTabView_Previews: PreviewProvider {
    @StateObject static var bookmarkVM = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        SearchTabView()
    }
}
