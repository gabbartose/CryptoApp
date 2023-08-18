//
//  HomeStatsView.swift
//  CryptoApp
//
//  Created by Gabrijel Bartosek on 05.07.2023..
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(homeViewModel.statistics) { stat in
                StatisticView(statisticModel: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeViewModel)
    }
}
