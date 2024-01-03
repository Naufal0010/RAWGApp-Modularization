//
//  GameTransformer.swift
//
//
//  Created by Naufal Abiyyu on 19/12/23.
//

import Core

public struct GameTransformer: Mapper {
    
    
    public typealias Request = String
    public typealias Response = [GameResponse]
    public typealias Entity = [GameEntity]
    public typealias Domain = [GameDomainModel]
    
    public init() {}
    
    public func transformResponseToEntity(request: String?, response: [GameResponse]) -> [GameEntity] {
        return response.map { result in
            let newGames = GameEntity()
            newGames.id = result.id
            newGames.name = result.name
            newGames.released = result.released ?? ""
            newGames.urlBackground = result.backgroundImage ?? ""
            newGames.rating = result.rating ?? 0.0
            newGames.metacritic = result.metacritic ?? 0
            
            return newGames
        }
    }
    
    public func transformEntityToDomain(entity: [GameEntity]) -> [GameDomainModel] {
        return entity.map { result in
            return GameDomainModel(id: result.id,
                             name: result.name,
                             released: result.released,
                             desc: result.descriptionGames,
                             urlBackground: result.urlBackground,
                             rating: result.rating,
                             metacritic: result.metacritic,
                             isFavorite: result.isFavorite
            )
        }
    }
}
