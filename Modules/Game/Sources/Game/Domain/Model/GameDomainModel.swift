//
//  GameDomainModel.swift
//
//
//  Created by Naufal Abiyyu on 19/12/23.
//

import Foundation

public struct GameDomainModel: Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let released: String
    public var desc: String
    public let urlBackground: String
    public let rating: Double
    public let metacritic: Int
    public var isFavorite: Bool = false
    
    public init(
        id: Int,
        name: String,
        released: String,
        desc: String,
        urlBackground: String,
        rating: Double,
        metacritic: Int,
        isFavorite: Bool
    ) {
        self.id = id
        self.name = name
        self.released = released
        self.desc = desc
        self.urlBackground = urlBackground
        self.rating = rating
        self.metacritic = metacritic
        self.isFavorite = isFavorite
    }
}
