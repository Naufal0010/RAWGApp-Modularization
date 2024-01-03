//
//  UseCase.swift
//
//
//  Created by Naufal Abiyyu on 19/12/23.
//

import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
