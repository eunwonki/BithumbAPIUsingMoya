//
//  BiithumAPI.swift
//  BitcoinPriceViewer
//
//  Created by wonki on 2023/03/12.
//

import Foundation
import Moya

enum BithumAPIService {
    case getData(String, String)
}

extension BithumAPIService: TargetType {
    // Base URL
    var baseURL: URL {
        return URL(string: "https://api.bithumb.com/public/ticker/")!
    }

    // 요청 경로
    var path: String {
        switch self {
        case .getData(let orderCurrency, let paymentCurrency):
            return "?order_currency=\(orderCurrency)&payment_currency=\(paymentCurrency)"
        }
    }
    
    // HTTP 요청 메소드
    var method: Moya.Method {
        switch self {
        case .getData:
            return .get
        }
    }
    
    // HTTP 작업 유형
    var task: Task {
        switch self {
        case .getData:
            return .requestPlain
        }
    }
    
    // HTTP 헤더
    var headers: [String : String]? {
        return [
            "content-type": "application/json"
        ]
    }
}
