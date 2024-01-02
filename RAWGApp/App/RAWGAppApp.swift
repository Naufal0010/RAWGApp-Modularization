//
//  RAWGAppApp.swift
//  RAWGApp
//
//  Created by Naufal Abiyyu on 09/11/23.
//

import SwiftUI
import RealmSwift
import Core
import Game

let gameUseCase: Interactor<
    Any,
    [GameDomainModel],
    GetGamesRepository<
        GetGamesLocaleDataSource,
        GetGamesRemoteDataSource,
        GameTransformer>
> = Injection.init().provideGame()

let searchUseCase: Interactor<
    String,
    [GameDomainModel],
    SearchGamesRepository<
        GetSearchLocaleDataSource,
        GetSearchRemoteDataSource,
        SearchTransformer>
> = Injection.init().provideSearch()

@main
struct RAWGAppApp: SwiftUI.App {
    let homePresenter = GamePresenter(useCase: gameUseCase)
    let searchPresenter = SearchPresenter(useCase: searchUseCase)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
                .environmentObject(searchPresenter)
        }
    }
}
