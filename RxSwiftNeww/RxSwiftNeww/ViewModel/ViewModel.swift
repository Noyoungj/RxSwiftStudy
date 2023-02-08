//
//  ViewModel.swift
//  RxSwiftNeww
//
//  Created by 노영재 on 2023/02/05.
//

import Foundation
import RxSwift

final class ViewModel {
    let title = "Youngj News"
    
    //테스트에 용이하게 하기 위해 Class를 정의하기 보단 Protocol을 사용
    private let articleService : ArticleServiceProtocol
    
    init(articleService : ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    func fetchArticles() -> Observable<[ArticleViewModel]> {
        return articleService.fetchNews().map{ $0.map{ ArticleViewModel(article: $0) } }
    }
}
