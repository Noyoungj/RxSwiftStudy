//
//  Model.swift
//  APIBinding
//
//  Created by 노영재 on 2023/01/05.
//
 
import Foundation

struct Model : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : notice?
}

struct notice : Decodable {
    var notice : String
}
