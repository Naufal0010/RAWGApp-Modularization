//
//  Injection.swift
//  RAWGApp
//
//  Created by Naufal Abiyyu on 14/11/23.
//

import Foundation
import RealmSwift
import Core
import Game
import Detail
import Favorite
import UIKit

final class Injection: NSObject {
    
    private let realm = try? Realm()
    
    func provideGame<U: UseCase>() -> U where U.Request == Any, U.Response == [GameDomainModel] {
        
        let locale = GetGamesLocaleDataSource(realm: realm!)
        
        let remote = GetGamesRemoteDataSource(endpoint: Endpoints.Gets.allGames.url)
        
        let mapper = GameTransformer()
        
        let repository = GetGamesRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideDetail<U: UseCase>(detail: GameDomainModel) -> U where U.Request == Int, U.Response == GameDomainModel {
        
        let locale = GetDetailLocaleDataSource(realm: realm!)
        
        let remote = GetGamesDetailRemoteDataSource(endpoint: Endpoints.Gets.gameDetails(detail.id).url)
        
        let mapper = DetailTransformer()
        
        let repository = GetDetailGamesRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideSearch<U: UseCase>() -> U where U.Request == String, U.Response == [GameDomainModel] {
        let locale = GetSearchLocaleDataSource(realm: realm!)
        
        let remote = GetSearchRemoteDataSource(endpoint: Endpoints.Gets.searchGames.url)
        
        let mapper = SearchTransformer()
        
        let repository = SearchGamesRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideFavorite<U: UseCase>() -> U where U.Request == Int, U.Response == [GameDomainModel] {
        
        let locale = GetFavoriteGamesLocaleDataSource(realm: realm!)
        
        let mapper = FavoritesTransformer()
        
        let repository = GetFavoriteGamesRepository(
            localeDataSource: locale,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideUpdateFavorite<U: UseCase>() -> U where U.Request == Int, U.Response == GameDomainModel {
        
        let locale = GetFavoriteGamesLocaleDataSource(realm: realm!)
        
        let mapper = FavoriteTransformer()
        
        let repository = UpdateFavoriteGamesRepository(
            localeDataSource: locale,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
}
