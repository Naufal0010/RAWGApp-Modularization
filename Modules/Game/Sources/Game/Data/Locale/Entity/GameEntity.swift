//
//  GameModuleEntity.swift
//
//
//  Created by Naufal Abiyyu on 19/12/23.
//

import Foundation
import RealmSwift

public class GameEntity: Object {
    
    @objc public dynamic var id: Int = 0
    @objc public dynamic var name: String = ""
    @objc public dynamic var released: String = ""
    @objc public dynamic var urlBackground: String = ""
    @objc public dynamic var descriptionGames: String = ""
    @objc public dynamic var rating: Double = 0.0
    @objc public dynamic var metacritic: Int = 0
    @objc public dynamic var isFavorite: Bool = false
    
    public override class func primaryKey() -> String? {
        return "id"
    }
}
