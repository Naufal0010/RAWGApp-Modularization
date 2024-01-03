//
//  File.swift
//  
//
//  Created by Naufal Abiyyu on 21/12/23.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetGamesDetailRemoteDataSource: DataSource {
    
    public typealias Request = Int
    
    public typealias Response = GamesDetailResponse
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        self._endpoint = endpoint
    }
    
    public func execute(request: Request?) -> AnyPublisher<GamesDetailResponse, Error> {
        return Future<GamesDetailResponse, Error> { completion in
            if let url = URL(string: _endpoint) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.self))
                            debugPrint(response)
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                            debugPrint(response)
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}

