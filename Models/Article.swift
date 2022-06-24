//
//  Article.swift
//  XCANews
//
//  Created by Mufeed AlMatar on 23/11/1443 AH.
//

import Foundation

fileprivate let relativeDateTimeFormatter = RelativeDateTimeFormatter()

struct Article {
    let source: Source
    let author: String?
    let title: String?
    let url: String
    let publishedAt: Date
    let description: String?
    let urlToImage: String?
    
    var authorText: String {
        author ?? ""
    }
    
    var titleText: String {
        title ?? ""
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var articalURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
    var captionText: String {
        "\(source.name) · \(relativeDateTimeFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
}

extension Article: Codable {}
extension Article: Equatable {}
extension Article: Identifiable {
    var id: String { url }
}

extension Article {
    static var previewData: [Article] {
        let previewDataUrl = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataUrl)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(NewsAPIReponse.self, from: data)
        return apiResponse.articles ?? []
    }
}

struct Source {
    let name: String
}

extension Source: Codable {}
extension Source: Equatable {}
