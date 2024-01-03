//
//  GetSearchRemoteDataSource.swift
//
//
//  Created by Naufal Abiyyu on 29/12/23.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetSearchRemoteDataSource: DataSource {
    
    public typealias Request = String
    
    public typealias Response = [GameResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        self._endpoint = endpoint
    }
    
    public func execute(request: Request?) -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in
            guard let request = request else { return completion(.failure(URLError.invalidRequest)) }
            
            if let url = URL(string: _endpoint + request) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}

