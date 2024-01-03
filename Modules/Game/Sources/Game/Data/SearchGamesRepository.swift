//
//  SearchGamesRepository.swift
//
//
//  Created by Naufal Abiyyu on 20/12/23.
//

import Core
import Combine

public struct SearchGamesRepository<
    SearchLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    SearchLocaleDataSource.Request == String,
    SearchLocaleDataSource.Response == GameEntity,
    RemoteDataSource.Request == String,
    RemoteDataSource.Response == [GameResponse],
    Transformer.Request == String,
    Transformer.Response == [GameResponse],
    Transformer.Entity == [GameEntity],
    Transformer.Domain == [GameDomainModel] {
    
    public typealias Request = String
    public typealias Response = [GameDomainModel]
    
    private let _localeDataSource: SearchLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
        
    public init(
        localeDataSource: SearchLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
        
    public func execute(request: String?) -> AnyPublisher<[GameDomainModel], Error> {
        
        return _remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToEntity(request: request, response: $0) }
            .catch { _ in _localeDataSource.list(request: request) }
            .flatMap { responses in
                _localeDataSource.list(request: request)
                    .flatMap { locale -> AnyPublisher<[GameDomainModel], Error> in
                        if responses.count > locale.count {
                            return _localeDataSource.add(entities: responses)
                                .filter { $0 }
                                .flatMap { _ in _localeDataSource.list(request: request)
                                        .map {
                                            _mapper.transformEntityToDomain(entity: $0)
                                        }
                                }.eraseToAnyPublisher()
                        } else {
                            return _localeDataSource.list(request: request)
                                .map { _mapper.transformEntityToDomain(entity: $0) }
                                .eraseToAnyPublisher()
                        }
                    }
            }.eraseToAnyPublisher()
    }
}
