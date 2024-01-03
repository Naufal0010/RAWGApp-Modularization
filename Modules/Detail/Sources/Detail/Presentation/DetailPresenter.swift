//
//  File.swift
//  
//
//  Created by Naufal Abiyyu on 22/12/23.
//

import Foundation
import Combine
import Core
import Game

public class DetailPresenter<DetailUseCase: UseCase, FavoriteUseCase: UseCase>: ObservableObject
where
    DetailUseCase.Request == Int, DetailUseCase.Response == GameDomainModel,
    FavoriteUseCase.Request == Int, FavoriteUseCase.Response == GameDomainModel
{
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _detailUseCase: DetailUseCase
    private let _favoriteUseCase: FavoriteUseCase
    
    @Published public var item: GameDomainModel?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    @Published public var showingAlert: Bool = false
    
    public init(detailUseCase: DetailUseCase, favoriteUseCase: FavoriteUseCase) {
        _detailUseCase = detailUseCase
        _favoriteUseCase = favoriteUseCase
    }
    
    public func getDetailGame(request: DetailUseCase.Request) {
        self.isLoading = true
        _detailUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                    debugPrint(error)
                }
            }, receiveValue: { item in
                self.item = item
                debugPrint(item)
            })
            .store(in: &cancellables)
    }
    
    public func updateFavoriteGame(request: FavoriteUseCase.Request) {
        _favoriteUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure:
                    self.errorMessage = String(describing: completion)
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
}
