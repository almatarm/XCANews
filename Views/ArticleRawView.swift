//
//  ArticleRawView.swift
//  XCANews
//
//  Created by Mufeed AlMatar on 24/11/1443 AH.
//

import SwiftUI

struct ArticleRawView: View {
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    let article: Article
    var body: some View {
        switch horizontalSizeClass {
        case .regular:
            GeometryReader { contentView(proxy: $0)}
        default:
            contentView()
        }
    }
    
    private func toggleBookmark(for article: Article) {
        if articleBookmarkVM.isBookmarked(for: article) {
            articleBookmarkVM.removeBookmark(for: article)
        } else {
            articleBookmarkVM.addBookmark(for: article)
        }
    }
    
    @ViewBuilder
    private func contentView(proxy: GeometryProxy? = nil) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: article.imageURL) {
                phase in
                switch phase {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                case .failure:
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                            .imageScale(.large)
                        Spacer()
                    }
                    
                @unknown default:
                    fatalError()
                
                }
            }
            .asyncImageFrame(horizontalSizeClass: horizontalSizeClass ?? .compact)
            .background(Color.gray.opacity(0.6))
            
            VStack(alignment: .leading, spacing: 0) {
                Text(article.titleText)
                    .font(.headline)
                    .lineLimit(3)
            
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)
            
                if horizontalSizeClass == .regular {
                    Spacer()
                }
                
                HStack {
                    Text(article.captionText)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    Spacer()
                
                    Button {
                        toggleBookmark(for: article)
                    } label: {Image(systemName: articleBookmarkVM.isBookmarked(for: article) ? "bookmark.fill" : "bookmark")}
                            .buttonStyle(.bordered)
                    
                    Button {
                        presentShareSheet(url: article.articalURL)
                    } label: {Image(systemName: "square.and.arrow.up")}
                            .buttonStyle(.bordered)
                    
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}
extension View {
    func presentShareSheet(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil  )
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
}

fileprivate extension View {
    @ViewBuilder
    func asyncImageFrame(horizontalSizeClass: UserInterfaceSizeClass) -> some View {
        switch horizontalSizeClass {
        case .compact:
            frame(minHeight: 200, maxHeight: 300)
        case .regular:
            frame(height: 180)
        }
    }
}

struct ArticleRawView_Previews: PreviewProvider {
    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        NavigationView {
            List {
                ArticleRawView(article: .previewData[0])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
        }
        .environmentObject(articleBookmarkVM)
        .previewDevice("iPhone SE (3rd generation)")
    }
}



