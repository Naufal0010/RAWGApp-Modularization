//
//  GamesResponse.swift
//
//
//  Created by Naufal Abiyyu on 19/12/23.
//

import Foundation

// MARK: - Rawg
public struct GamesResponse: Decodable {
    public let results: [GameResponse]
}

// MARK: - RAWG
public struct GameResponse: Decodable {
    public let id: Int
    public let name: String
    public let released: String?
    public let backgroundImage: String?
    public let rating: Double?
    public let metacritic: Int?
    public let genres: [Genre]
    public let shortScreenshots: [ShortScreenshot]

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case rating
        case released
        case metacritic
        case genres
        case shortScreenshots = "short_screenshots"
    }
}

// MARK: - Genre
public struct Genre: Decodable {
    public let id: Int
    public let name: String
}

// MARK: - ShortScreenshot
public struct ShortScreenshot: Decodable {
    public let id: Int
    public let image: String
}
