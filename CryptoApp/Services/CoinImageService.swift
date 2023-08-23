//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Gabrijel Bartosek on 05.07.2023..
//

import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coinModel: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coinModel: CoinModel) {
        self.coinModel = coinModel
        self.imageName = coinModel.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retreived image from File Manager.")
        } else {
            downloadCoinImage()
            print("Downloading image now.")
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coinModel.image) else {
            return
        }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion(completion:), receiveValue: { [weak self] returnedImage in
                guard let self = self,
                let downloadedImage = returnedImage else {
                    return
                }
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: imageName, folderName: folderName)
            })
    }
}
