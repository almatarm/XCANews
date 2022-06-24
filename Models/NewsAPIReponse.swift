//
//  NewsAPIReponse.swift
//  XCANews
//
//  Created by Mufeed AlMatar on 23/11/1443 AH.
//

import Foundation

struct NewsAPIReponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
}
