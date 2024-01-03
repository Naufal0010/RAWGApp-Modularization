//
//  GetSearchLocaleDataSource.swift
//
//
//  Created by Naufal Abiyyu on 02/01/24.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetSearchLocaleDataSource: LocaleDataSource {
    
    public typealias Request = String
    
    public typealias Response = GameEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: String?) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            let lists: Results<GameEntity> = {
                _realm.objects(GameEntity.self)
                    .filter("name contains[c] %@", request ?? "")
                    .sorted(byKeyPath: DomainModelConstant.rating, ascending: false)
            }()
            completion(.success(lists.toArray(ofType: GameEntity.self)))
            debugPrint(lists)
            
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GameEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for game in entities {
                        if let gameEntity = _realm.object(ofType: GameEntity.self, forPrimaryKey: game.id) {
                            if gameEntity.name == game.name {
                                game.isFavorite = gameEntity.isFavorite
                                _realm.add(game, update: .all)
                            } else {
                                _realm.add(game)
                            }
                        } else {
                            _realm.add(game)
                        }
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
