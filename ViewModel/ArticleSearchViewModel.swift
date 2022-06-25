//
//  ArticleSearchViewModel.swift
//  XCANews (iOS)
//
//  Created by Mufeed AlMatar on 25/11/1443 AH.
//

import SwiftUI

@MainActor
class ArticleSearchViewModel: ObservableObject {
    @Published var phase: DataFetchPhase<[Article]> = .empty
    @Published var searchQuery = ""
    @Published var history = [String]()
    
    
    private let historyMaxLimit = 10
    private let newsAPI = NewsAPI.shared
    
    func searchArticle() async {
        if Task.isCancelled { return }
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let articles = try await newsAPI.search(for: searchQuery)
            if Task.isCancelled { return }
            if searchQuery != self.searchQuery { return }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            if searchQuery != self.searchQuery { return }
            phase = .failure(error)
        }
    }
    
    func addHistory(_ text: String) {
        if let index = history.firstIndex(where: { text.lowercased() == $0.lowercased()}) {
            history.remove(at: index)
        } else if history.count == historyMaxLimit {
            history.removeLast()
        }
        history.insert(text, at: 0)
    }
    
    func removeHistory(_ text: String) {
        guard let index = history.firstIndex(where: { text.lowercased() == $0.lowercased()}) else {
            return
        }
        history.remove(at: index)
    }
    
    func removeAllHistory() {
        history.removeAll()
    }
}