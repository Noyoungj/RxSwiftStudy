//
//  ViewModel.swift
//  APIBinding
//
//  Created by 노영재 on 2023/01/05.
//

import Foundation
import Alamofire

class ViewModel {
    func appHome(completionHandler: @escaping (_ isSuccess : Bool, _ result: String) -> ()) {
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : ""]
        
        AF.request("", method: .get, parameters: nil, headers: headers).validate().responseDecodable(of: Model.self) { response in
            switch response.result {
            case .success(let result):
                if let result = result.result {
                    completionHandler(true, result.notice)
                } else {
                    completionHandler(false, result.message)
                }
            case .failure(let error):
                completionHandler(false, error.localizedDescription)
            }
        }
    }
}
