//
//  HomeView.swift
//  CryptoApp
//
//  Created by Gabrijel Bartosek on 03.07.2023..
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @State private var showPortfolio: Bool = false // animate right
    @State private var showPortfolioView: Bool = false // navigation on a new sheet
    
    @State private var showSettingsView: Bool = false // new sheet
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background layer
                Color.theme.background
                    .ignoresSafeArea()
                    .sheet(isPresented: $showPortfolioView) {
                        PortfolioView()
                            .environmentObject(homeViewModel)
                    }
                
                // content layer
                VStack {
                    homeHeader
                    
                    HomeStatsView(showPortfolio: $showPortfolio)
                    
                    SearchBarView(searchText: $homeViewModel.searchText)
                    
                    columnTitles
                    
                    if !showPortfolio {
                        allCoinsList
                            .transition(.move(edge: .leading))
                    }
                    
                    if showPortfolio {
                        ZStack(alignment: .top) {
                            if homeViewModel.portfolioCoins.isEmpty && homeViewModel.searchText.isEmpty {
                                portfolioEmptyText
                            } else {
                                portfolioCoinsList
                            }
                        }
                        .transition(.move(edge: .trailing))
                    }
                    
                    Spacer(minLength: 0)
                }
                .sheet(isPresented: $showSettingsView) {
                    SettingsView()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .toolbar(.hidden)
        }
        .environmentObject(dev.homeViewModel)
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    } else {
                        showSettingsView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none, value: showPortfolio)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((homeViewModel.sortOption == .rank || homeViewModel.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: homeViewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    homeViewModel.sortOption = homeViewModel.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((homeViewModel.sortOption == .holdings || homeViewModel.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: homeViewModel.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        homeViewModel.sortOption = homeViewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((homeViewModel.sortOption == .price || homeViewModel.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: homeViewModel.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    homeViewModel.sortOption = homeViewModel.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    homeViewModel.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: homeViewModel.isLoading ? 360 : 0), anchor: .center)
            
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(homeViewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coinModel: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .listStyle(.plain)
        .refreshable {
            homeViewModel.reloadData()
        }
        .navigationDestination(
            isPresented: $showDetailView) {
                DetailLoadingView(coinModel: $selectedCoin)
            }
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(homeViewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coinModel: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .listStyle(.plain)
        .refreshable {
            homeViewModel.reloadData()
        }
        .navigationDestination(
            isPresented: $showDetailView) {
                DetailLoadingView(coinModel: $selectedCoin)
            }
    }
    
    private var portfolioEmptyText: some View {
        Text("You haven't added any coins to your portfolio yet. Click the + button to get started! 🧐")
            .font(.callout)
            .foregroundColor(Color.theme.accent)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(50)
    }
    
    private func segue(coinModel: CoinModel) {
        selectedCoin = coinModel
        showDetailView.toggle()
    }
}
