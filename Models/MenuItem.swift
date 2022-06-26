//
//  MenuItem.swift
//  XCANews (iOS)
//
//  Created by Mufeed AlMatar on 27/11/1443 AH.
//

import Foundation


enum MenuItem: CaseIterable {
    case search
    case saved
    case category(Category)
    
    var text: String {
        switch self {
        case .search:
            return "Search"
        case .saved:
            return "Saved"
        case .category(let category):
            return category.text
        }
    }
    
    var systemImage: String {
        switch self {
        case .search:
            return "magnifyingglass"
        case .saved:
            return "bookmark"
        case .category(let category):
            return category.systemImage
        }
    }
    
    static var allCases: [MenuItem] {
        return [.search, .saved] + Category.menuItems
    }
    
}


extension Category {
    static var menuItems: [MenuItem] {
        allCases.map { .category($0) }
    }
}

extension MenuItem: Identifiable {
    
    var id: String {
        switch self {
        case .search:
            return "search"
        case .saved:
            return "saved"
        case .category(let category):
            return category.rawValue
        }
    }
}
