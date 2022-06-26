//
//  NewsTabView.swift
//  XCANews
//
//  Created by Mufeed AlMatar on 25/11/1443 AH.
//

import SwiftUI

struct NewsTabView: View {
    @StateObject var articleNewsVM = ArticleNewsViewModel()
    
    init(articles: [Article]? = nil, category: Category = .general) {
        self._articleNewsVM = StateObject(wrappedValue: ArticleNewsViewModel(articles: articles, selectedCategory: category))
    }
    
    
    var body: some View {
        ArticleListView(articles: articles)
            .overlay(overlayView)
            .task(id: articleNewsVM.fetchTaskToken, reloadTask)
            .refreshable(action: refreshTask)
//                .onAppear {
//                    reloadTask()
//                }
//                .onChange(of: articleNewsVM.selectedCategory) { _ in
//                    reloadTask()
//                }
            .navigationTitle(articleNewsVM.fetchTaskToken.category.text)
            .navigationBarItems(trailing: menu)
    }
    
    private var articles: [Article] {
        if case let .success(articles) = articleNewsVM.phase {
            return articles
        }
        return []
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch articleNewsVM.phase {
        case .empty: ProgressView()
        case .success(articles) where articles.isEmpty: EmptyPlaceholderView(text: "No Articles", image: nil)
        case .failure(let error): RetryView(text: error.localizedDescription, retryAction: refreshTask)
        default: EmptyView()
        }
    }
    
    private func reloadTask() async {
        await articleNewsVM.loadArticles()
    }
    
    private func refreshTask() {
        articleNewsVM.fetchTaskToken = FetchTaskToken(category: articleNewsVM.fetchTaskToken.category, token: Date())
    }
    
    private var menu: some View {
        Menu {
            Picker("Category", selection: $articleNewsVM.fetchTaskToken.category) {
                ForEach(Category.allCases) {
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .imageScale(.large)
        }
    }
}

struct NewsTabView_Previews: PreviewProvider {
    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        NewsTabView(articles: Article.previewData, category: .general)
            .environmentObject(articleBookmarkVM)
    }
}
