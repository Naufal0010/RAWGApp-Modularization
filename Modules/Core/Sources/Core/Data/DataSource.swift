//
//  DataSource.swift
//  
//
//  Created by Naufal Abiyyu on 19/12/23.
//

import Combine

public protocol DataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
 
