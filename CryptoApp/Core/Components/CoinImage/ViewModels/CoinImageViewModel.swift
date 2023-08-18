//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Gabrijel Bartosek on 05.07.2023..
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coinModel: CoinModel
    private let coinImageService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coinModel: CoinModel) {
        self.coinModel = coinModel
        self.coinImageService = CoinImageService(coinModel: coinModel)
        addSubscribers()
        isLoading = true
    }
    
    private func addSubscribers() {
        coinImageService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
