//
//  FavoriteView.swift
//  RAWGApp
//
//  Created by Naufal Abiyyu on 23/11/23.
//

import SwiftUI
import Core
import Favorite
import Game

struct FavoriteView: View {
    @ObservedObject var presenter: FavoritePresenter<
        Int, GameDomainModel, Interactor<
            Int, [GameDomainModel], GetFavoriteGamesRepository<
                GetFavoriteGamesLocaleDataSource, FavoritesTransformer>>>
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                
                Text("Favorite Games")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                ScrollView(.vertical, showsIndicators: false) {
                    if presenter.isLoading {
                        VStack {
                            ForEach(0..<5, id: \.self) { _ in
                                ShimmerView()
                            }
                        }
                    } else {
                        if presenter.list.count == 0 {
                            EmptyView(selectedView: .favorite)
                        } else {
                            ForEach(self.presenter.list, id: \.id) { game in
                                ZStack {
                                    linkBuilder(for: game) {
                                        FavoriteRow(gameModel: game)
                                    }.buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color.bg)
        .onAppear {
            self.presenter.getFavoriteList(request: nil)
        }
    }
    
    func linkBuilder<Content: View>(
        for favorite: GameDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        
        NavigationLink(
            destination: FavoriteRouter().makeDetailView(for: favorite)
        ) { content() }
    }
}

