//
//  ArticleRawView.swift
//  XCANews
//
//  Created by Mufeed AlMatar on 24/11/1443 AH.
//

import SwiftUI

struct ArticleRawView: View {
    let article: Article
    var body: some View {
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
            .frame(minHeight: 200, maxHeight: 300)
            .background(Color.gray.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 0) {
                Text(article.titleText)
                    .font(.headline)
                    .lineLimit(3)
            
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)
            
                HStack {
                    Text(article.captionText)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    Spacer()
                
                    Button {
                    } label: {Image(systemName: "bookmark")}
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
struct ArticleRawView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ArticleRawView(article: .previewData[0])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
        }
        .previewDevice("iPhone SE (3rd generation)")
    }
}


