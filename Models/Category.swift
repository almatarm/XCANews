//
//  Category.swift
//  XCANews
//
//  Created by Mufeed AlMatar on 25/11/1443 AH.
//

import Foundation
import UIKit

enum Category: String, CaseIterable {
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health
    
    var text : String {
        if self == .general {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
    
    var systemImage: String {
           switch self {
           case .general:
               return "newspaper"
           case .business:
               return "building.2"
           case .technology:
               return "desktopcomputer"
           case .entertainment:
               return "tv"
           case .sports:
               return "sportscourt"
           case .science:
               return "wave.3.right"
           case .health:
               return "cross"
           }
       }
}

extension Category: Identifiable {
    var id: Self { self }
}
