//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Gabrijel Bartosek on 05.07.2023..
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketDataModel: MarketDataModel? = nil
    
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            return
        }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion(completion:), receiveValue: { [weak self] returnedGlobalData in
                self?.marketDataModel = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
