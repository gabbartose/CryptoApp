//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Gabrijel Bartosek on 07.07.2023..
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetailModel? = nil
    
    private let coinModel: CoinModel
    private var coinDetailDataSubscription: AnyCancellable?
    
    init(coinModel: CoinModel) {
        self.coinModel = coinModel
        getCoinDetails()
    }
    
    func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coinModel.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {
            return
        }
        
        coinDetailDataSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion(completion:), receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailDataSubscription?.cancel()
            })
    }
}
