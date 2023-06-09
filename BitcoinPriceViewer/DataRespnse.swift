//
//  DataRespnse.swift
//  BitcoinPriceViewer
//
//  Created by wonki on 2023/03/12.
//

import Foundation

struct DataResponse: Codable {
    var status: String = ""
    var data = Data()
    
    struct Data: Codable {
        var opening_price: String = ""
        var closing_price: String = ""
        var min_price: String = ""
        var max_price: String = ""
        var units_traded: String = ""
        var acc_trade_value: String = ""
        var prev_closing_price: String = ""
        var units_traded_24H: String = ""
        var acc_trade_value_24H: String = ""
        var fluctate_24H: String = ""
        var fluctate_rate_24H: String = ""
        var date: String = ""
    }
}
