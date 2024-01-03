//
//  GamesDetailResponse.swift
//
//
//  Created by Naufal Abiyyu on 21/12/23.
//

import Foundation

// MARK: - GamesDetailResponse
public struct GamesDetailResponse: Decodable {
    public let id: Int
    public let name: String
    public let nameOriginal: String
    public let description: String?
    public let released: String?
    public let backgroundImage: String
    public let backgroundImageAdditional: String?
    public let rating: Double?
    public let metacritic: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case nameOriginal = "name_original"
        case description
        case released
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case rating
        case metacritic
    }
}
