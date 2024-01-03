//
//  DetailTransformer.swift
//
//
//  Created by Naufal Abiyyu on 22/12/23.
//

import Core
import Game

public struct DetailTransformer: Mapper {
    
    public typealias Request = Int
    public typealias Response = GamesDetailResponse
    public typealias Entity = GameEntity
    public typealias Domain = GameDomainModel
    
    public init() {}
    
    public func transformResponseToEntity(request: Int?, response: GamesDetailResponse) -> GameEntity {
        let detail = GameEntity()
        detail.id = response.id
        detail.name = response.name
        detail.released = response.released ?? ""
        detail.urlBackground = response.backgroundImage
        detail.descriptionGames = response.description ?? ""
        detail.rating = response.rating ?? 0.0
        detail.metacritic = response.metacritic ?? 0
        
        debugPrint(detail)
        
        return detail 
    }
    
    public func transformEntityToDomain(entity: GameEntity) -> GameDomainModel {
        return GameDomainModel(
            id: entity.id,
            name: entity.name,
            released: entity.released,
            desc: entity.descriptionGames,
            urlBackground: entity.urlBackground,
            rating: entity.rating,
            metacritic: entity.metacritic,
            isFavorite: entity.isFavorite)
    }
}
