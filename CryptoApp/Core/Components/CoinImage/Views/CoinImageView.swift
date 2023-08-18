//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by Gabrijel Bartosek on 05.07.2023..
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject private var coinImageViewModel: CoinImageViewModel
    
    init(coinModel: CoinModel) {
        _coinImageViewModel = StateObject(wrappedValue: CoinImageViewModel(coinModel: coinModel))
    }
    
    var body: some View {
        ZStack {
            if let image = coinImageViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if coinImageViewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coinModel: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
