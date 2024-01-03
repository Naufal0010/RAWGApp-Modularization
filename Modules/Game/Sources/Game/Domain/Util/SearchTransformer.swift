//
//  File.swift
//  
//
//  Created by Naufal Abiyyu on 29/12/23.
//

import Core

public struct SearchTransformer: Mapper {
    
    public typealias Request = String
    public typealias Response = [GameResponse]
    public typealias Entity = [GameEntity]
    public typealias Domain = [GameDomainModel]
    
    public init() {}
    
    public func transformResponseToEntity(request: String?, response: [GameResponse]) -> [GameEntity] {
        return response.map { result in
            let gameEntity = GameEntity()
            gameEntity.id = result.id
            gameEntity.name = result.name
            gameEntity.released = result.released ?? ""
            gameEntity.urlBackground = result.backgroundImage ?? ""
            gameEntity.rating = result.rating ?? 0.0
            gameEntity.metacritic = result.metacritic ?? 0
            
            debugPrint(gameEntity)
            return gameEntity
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
    
    
