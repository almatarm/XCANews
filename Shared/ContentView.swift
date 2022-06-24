//
//  ContentView.swift
//  Shared
//
//  Created by Mufeed AlMatar on 23/11/1443 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ArticleListView(articles: Article.previewData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
