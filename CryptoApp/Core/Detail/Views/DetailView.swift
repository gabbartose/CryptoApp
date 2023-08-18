//
//  DetailView.swift
//  CryptoApp
//
//  Created by Gabrijel Bartosek on 07.07.2023..
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coinModel: CoinModel?
    
    var body: some View {
        ZStack {
            if let coinModel = coinModel {
                DetailView(coinModel: coinModel)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject private var detailViewModel: DetailViewModel
    @State private var showFullDescription: Bool = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    
    init(coinModel: CoinModel) {
        _detailViewModel = StateObject(wrappedValue: DetailViewModel(coinModel: coinModel))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 10) {
                    ChartView(coinModel: detailViewModel.coinModel)
                        .padding(.vertical)
                        .padding(.horizontal, -14)
                    
                    overviewTitle
                    Divider()
                    
                    descriptionSection
                    
                    overviewGrid
                    
                    additionalTitle
                    Divider()
                    additionalGrid
                    
                    websiteSection
                }
                .padding()
            }
        }
        .background(
            Color.theme.background
                .ignoresSafeArea()
        )
        .navigationBarTitle(detailViewModel.coinModel.name, displayMode: .large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coinModel: dev.coin)
        }
    }
}

extension DetailView {
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(detailViewModel.coinModel.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coinModel: detailViewModel.coinModel)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing) {
                ForEach(detailViewModel.overviewStatistics) { stat in
                    StatisticView(statisticModel: stat)
                }
            }
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing) {
                ForEach(detailViewModel.additionalStatistics) { stat in
                    StatisticView(statisticModel: stat)
                }
            }
    }
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = detailViewModel.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Read less..." : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }
                    .tint(.blue)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteString = detailViewModel.websiteURL,
               let url = URL(string: websiteString) {
                Link("Website", destination: url)
            }
            
            if let redditString = detailViewModel.redditURL,
               let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
        }
        .font(.headline)
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
