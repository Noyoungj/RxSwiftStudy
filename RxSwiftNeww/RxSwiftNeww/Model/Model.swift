//
//  Model.swift
//  RxSwiftNeww
//
//  Created by 노영재 on 2023/02/01.
//

import Foundation

struct News : Decodable {
    var status: String
    var totalResults: Int
    var articles : [Article]?
}

struct Article: Decodable {
    var author : String?
    var title : String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
