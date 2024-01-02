//
//  HomeRouter.swift
//  RAWGApp
//
//  Created by Naufal Abiyyu on 14/11/23.
//

import SwiftUI
import Game
import Core
import Detail
import Favorite

class HomeRouter {
    
    func makeDetailView(for detail: GameDomainModel) -> some View {
        
        let detailUseCase: Interactor<
            Int,
            GameDomainModel,
            GetDetailGamesRepository<
                GetDetailLocaleDataSource,
                GetGamesDetailRemoteDataSource,
                DetailTransformer>> = Injection.init().provideDetail(detail: detail)
        
        let favoriteUseCase: Interactor<
            Int,
            GameDomainModel,
            UpdateFavoriteGamesRepository<
                GetFavoriteGamesLocaleDataSource,
                FavoriteTransformer>> = Injection.init().provideUpdateFavorite()
        
        let presenter = DetailPresenter(detailUseCase: detailUseCase, favoriteUseCase: favoriteUseCase)
            
        return DetailView(presenter: presenter, detail: detail)
    }
    
    func makeFavoriteView() -> some View {
        
        let favoriteUseCase: Interactor<
            Int,
            [GameDomainModel],
            GetFavoriteGamesRepository<
                GetFavoriteGamesLocaleDataSource,
                FavoritesTransformer>> = Injection.init().provideFavorite()
        
        let presenter = FavoritePresenter(useCase: favoriteUseCase)
        
        return FavoriteView(presenter: presenter)
    }
}
