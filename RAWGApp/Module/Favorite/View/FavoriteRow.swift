//
//  FavoriteRow.swift
//  RAWGApp
//
//  Created by Naufal Abiyyu on 23/11/23.
//

import SwiftUI
import CachedAsyncImage
import Game

struct FavoriteRow: View {
    var gameModel: GameDomainModel
    
    var body: some View {
        HStack {
            CachedAsyncImage(url: URL(string: gameModel.urlBackground )) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView("")
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.gray)
                    .frame(width: 120, height: 120)
            }
            
            VStack(alignment: .leading) {
                Text(gameModel.name)
                    .bold()
                    .font(.system(size: 16))
                    .foregroundColor(Color.white)
                
                Text("Rating: \(gameModel.rating, specifier: "%.2f")")
                    .font(.system(.caption))
                    .foregroundStyle(.white)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.leading)
                
                Text("Release Date: \(gameModel.released )")
                    .font(.system(.caption))
                    .foregroundStyle(.white)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .background(Color.grayItem)
        .cornerRadius(10)
    }
}

