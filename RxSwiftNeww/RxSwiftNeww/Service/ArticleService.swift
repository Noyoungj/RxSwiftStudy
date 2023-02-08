//
//  ArticleService.swift
//  RxSwiftNeww
//
//  Created by 노영재 on 2023/02/01.
//

import Alamofire
import Foundation
import RxSwift

protocol ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]>
}

class ArticleService : ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { observer -> Disposable in
            
            self.fetchNews { error, articles in
                if let error = error {
                    observer.onError(error)
                }
                
                if let articles = articles {
                    observer.onNext(articles)
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    private func fetchNews(completion: @escaping((Error?, [Article]?) -> Void)) {
        let urlString = "https://newsapi.org/v2/everything?q=apple&from=2023-01-31&to=2023-01-31&sortBy=popularity&apiKey=343581e57ad14404abbc1b0985471903"
        
        guard let url = URL(string: urlString) else { return completion(NSError(domain: "youngj", code: 404, userInfo: nil), nil) }
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).validate().responseDecodable(of: News.self) { response in
            switch response.result {
            case .success(let result):
                if let result = result.articles {
                    completion(nil, result)
                }
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
}
