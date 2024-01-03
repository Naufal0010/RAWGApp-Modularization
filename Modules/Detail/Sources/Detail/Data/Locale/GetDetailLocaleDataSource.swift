//
//  GetDetailLocaleDataSource.swift
//
//
//  Created by Naufal Abiyyu on 28/12/23.
//

import Core
import Game
import Combine
import RealmSwift
import Foundation

public struct GetDetailLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Any
    
    public typealias Response = GameEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        self._realm = realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[GameEntity], Error> {
        fatalError()
    }
    
    public func add(entities: [GameEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: Int) -> AnyPublisher<GameEntity, Error> {
        return Future<GameEntity, Error> { completion in
            
            let details: Results<GameEntity> = {
                _realm.objects(GameEntity.self)
                    .filter("id == \(id)")
            }()
            
            guard let detail = details.first else {
                completion(.failure(DatabaseError.requestFailed))
                debugPrint(details)
                return
            }
            
            completion(.success(detail))
            debugPrint(details)
        }.eraseToAnyPublisher()
    }
    
    public func update(id: Int, entity: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let gameEntity = {
                _realm.objects(GameEntity.self).filter("id = \(id)")
            }().first {
                do {
                    try _realm.write {
                        gameEntity.setValue(entity.descriptionGames, forKey: DomainModelConstant.description)
                        gameEntity.setValue(entity.isFavorite, forKey: DomainModelConstant.isFavorite)
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}
