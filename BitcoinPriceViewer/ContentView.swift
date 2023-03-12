//
//  ContentView.swift
//  BitcoinPriceViewer
//
//  Created by wonki on 2023/03/11.
//

import Moya
import SwiftUI

struct ContentView: View {
    var orderCurrency: String = "BTC"
    var paymentCurrency: String = "KRW"

    @State var data = DataResponse.Data()

    var body: some View {
        VStack {
            Button("Refresh") { refresh() }
            Group {
                DataViewer(title: "결과 상태 코드",
                           data: orderCurrency)
                DataViewer(title: "시가 00시 기준: ",
                           data: data.opening_price)
                DataViewer(title: "종가 00시 기준: ",
                           data: data.closing_price)
                DataViewer(title: "저가 00시 기준: ",
                           data: data.min_price)
                DataViewer(title: "고가 00시 기준: ",
                           data: data.max_price)
                DataViewer(title: "거래량 00시 기준: ",
                           data: data.units_traded)
                DataViewer(title: "거래금액 00시 기준: ",
                           data: data.acc_trade_value)
                DataViewer(title: "전일 종가: ",
                           data: data.prev_closing_price)
                DataViewer(title: "최근 24시간 거래량: ",
                           data: data.units_traded_24H)
                DataViewer(title: "최근 24시간 거래금액: ",
                           data: data.acc_trade_value_24H)
            }
            Group {
                DataViewer(title: "최근 24시간 변동가: ",
                           data: data.fluctate_24H)
                DataViewer(title: "최근 24시간 변동률: ",
                           data: data.fluctate_rate_24H)
                DataViewer(title: "타임 스탬프: ",
                           data: data.date)
            }
        }
        .padding(30)
        .onAppear(perform: refresh)
    }
}

extension ContentView {
    func refresh() {
        let provider = MoyaProvider<BithumAPIService>()
        provider.request(
            .getData(orderCurrency, paymentCurrency)) {
                result in

                switch result {
                case .success(let response):
                    let result = try? response.map(DataResponse.self)
                    guard let receivedData = result?.data else { return }
                    data = receivedData

                case .failure(let error):
                    print(error)
                }
        }
    }
}

extension ContentView {
    func DataViewer(title: String, data: String)
        -> some View
    {
        GeometryReader { metrics in
            HStack {
                Text(title)
                    .frame(
                        width: metrics.size.width * 0.5,
                        alignment: .leading)
                Text(data)
                    .frame(
                        width: metrics.size.width * 0.5,
                        alignment: .trailing)
            }
        }
        .frame(height: 30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(data: DataResponse.Data())
    }
}
