//
//  CoinLogoView.swift
//  CryptoApp
//
//  Created by Gabrijel Bartosek on 06.07.2023..
//

import SwiftUI

struct CoinLogoView: View {
    
    let coinModel: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coinModel: coinModel)
                .frame(width: 50, height: 50)
            Text(coinModel.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coinModel.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinLogoView(coinModel: dev.coin)
                .previewLayout(.sizeThatFits)
            
            CoinLogoView(coinModel: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
