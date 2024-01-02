//
//  HomeView.swift
//  RAWGApp
//
//  Created by Naufal Abiyyu on 15/11/23.
//

import SwiftUI
import Core
import Game

struct HomeView: View {
    @ObservedObject var presenter: GamePresenter<Any, GameDomainModel, Interactor<Any, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>>>
    
    @ObservedObject var searchPresenter: SearchPresenter<GameDomainModel, Interactor<String, [GameDomainModel], SearchGamesRepository<GetSearchLocaleDataSource, GetSearchRemoteDataSource, SearchTransformer>>>
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HomeHeader()
            
            HStack {
                SearchBar(searchText: $searchPresenter.searchText)
                    .padding(.top, 8)
                    .onChange(of: self.searchPresenter.searchText) {
                        if self.searchPresenter.searchText.isEmpty {
                            self.presenter.getList(request: nil)
                            debugPrint(presenter.list)
                        } else {
                            self.searchPresenter.search()
                            presenter.list = searchPresenter.list
                        }
                    }
                
                linkBuilderFavorite {
                    Image(systemName: "heart.fill")
                        .padding()
                        .foregroundStyle(.gray800)
                        .background(.gray100)
                        .cornerRadius(10)
                }
            }
            
            Text("All Games")
                .font(.title)
                .fontWeight(.bold)
                .font(.system(size: 12))
                .foregroundStyle(.white)
                .padding(.top, 16)
            
            ScrollView(.vertical, showsIndicators: false) {
                if !networkMonitor.isConnected {
                    EmptyView(selectedView: .noInternet)
                } else {
                    if presenter.isLoading || searchPresenter.isLoading {
                        VStack {
                            ForEach(0..<5, id: \.self) { _ in
                                ShimmerView()
                            }
                        }
                    } else {
                        if presenter.list.isEmpty {
                            EmptyView(selectedView: .home)
                        } else {
                            ForEach(self.presenter.list, id: \.id) { game in
                                ZStack {
                                    linkBuilder(for: game) {
                                        GameRow(gameModel: game)
                                    }.buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.bg)
        .onAppear {
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: nil)
            }
        }
    }
    
    func linkBuilder<Content: View>(
        for detail: GameDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        
        NavigationLink(
            destination: HomeRouter().makeDetailView(for: detail)
        ) { content() }
    }
    
    func linkBuilderFavorite<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: HomeRouter().makeFavoriteView()
        ) { content() }
    }
}
