//
//  ArticleViewModel.swift
//  RxSwiftNeww
//
//  Created by 노영재 on 2023/02/08.
//

import Foundation

struct ArticleViewModel {
    private let article : Article
    
    var imageURL : String? {
        return article.urlToImage
    }
    
    var title : String? {
        return article.title
    }
    
    var description : String? {
        return article.description
    }
    
    init(article: Article) {
        self.article = article
    }
}
