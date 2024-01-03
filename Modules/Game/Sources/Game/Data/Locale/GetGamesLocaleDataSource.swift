//
//  GetGamesLocaleDataSource.swift
//
//
//  Created by Naufal Abiyyu on 19/12/23.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetGamesLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Any
    
    public typealias Response = GameEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            let games: Results<GameEntity> = {
                _realm.objects(GameEntity.self)
                    .sorted(byKeyPath: DomainModelConstant.id)
            }()
            completion(.success(games.toArray(ofType: GameEntity.self)))
            debugPrint(games)
            
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GameEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for game in entities {
                        _realm.add(game, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<GameEntity, Error> {
        fatalError()
    }
    
    public func update(id: Int, entity: GameEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}
