//
//  DetailView.swift
//  RAWGApp
//
//  Created by Naufal Abiyyu on 16/11/23.
//

import SwiftUI
import CachedAsyncImage
import RichText
import Detail
import Core
import Game
import Favorite

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter<
        Interactor<Int, GameDomainModel, GetDetailGamesRepository<GetDetailLocaleDataSource, GetGamesDetailRemoteDataSource, DetailTransformer>>,
        Interactor<Int, GameDomainModel, UpdateFavoriteGamesRepository<GetFavoriteGamesLocaleDataSource, FavoriteTransformer>>
    >
    
    var detail: GameDomainModel
                                                                                
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    CachedAsyncImage(url: URL(string: detail.urlBackground)) { image in
                            image
                                .resizable()
                                .aspectRatio(3 / 2, contentMode: .fit)
                        } placeholder: {
                            ProgressView("")
                                .progressViewStyle(CircularProgressViewStyle())
                                .tint(.gray)
                                .frame(width: 120, height: 120)
                        }
                        
                        VStack(alignment: .leading) {
                            
                            Text("\(detail.name)")
                                .fontWeight(.bold)
                                .font(.system(size: 24))
                                .foregroundStyle(.white)
                                .padding(.bottom, 12)
                            
                            HStack(alignment: .top ,spacing: 36) {
                                
                                VStack(alignment: .leading) {
                                    Text("Release Date")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.white)
                                    
                                    Text(detail.released)
                                        .font(.system(.caption))
                                        .foregroundStyle(.gray100)
                                        .fontWeight(.thin)
                                        .multilineTextAlignment(.leading)
                                }
                                
                                
                                VStack(alignment: .leading) {
                                    Text("Metacritic")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.white)
                                    
                                    Text("\(detail.metacritic)")
                                        .font(.system(.caption))
                                        .foregroundStyle(.gray100)
                                        .fontWeight(.thin)
                                        .multilineTextAlignment(.leading)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Rating")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.white)
                                    
                                    Text("\(detail.rating, specifier: "%.2f")")
                                        .font(.system(.caption))
                                        .foregroundStyle(.gray100)
                                        .fontWeight(.thin)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            
                            Spacer()
                            
                        }
                        .padding(16)
                        
                        VStack(alignment: .leading) {
                            
                            Divider()
                                .background(.white)
                            
                            Text("About")
                                .font(.system(.title2))
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                            if presenter.isLoading {
                                VStack {
                                    ForEach(0..<5, id: \.self) { _ in
                                        ShimmerTextView()
                                    }
                                }
                            } else {
                                RichText(html: self.presenter.item?.desc ?? "There is no description.")
                                    .foregroundColor(light: Color.white, dark: Color.white)
                                    .font(.system(size: 12))
                            }
                            
                        }
                        .padding(.horizontal, 16)
                        
                        Spacer()
                    }
                    
            }
            .background(Color.bg)
            .toolbar {
                Button {
                    if self.presenter.item?.isFavorite == true {
                        self.presenter.updateFavoriteGame(request: detail.id)
                        self.presenter.showingAlert = false
                    } else {
                        self.presenter.updateFavoriteGame(request: detail.id)
                        self.presenter.showingAlert = true
                    }
                } label: {
                    Label("Favorite Button", systemImage: self.presenter.item?.isFavorite == true ? "heart.fill" : "heart")
                }
            }
            .alert(isPresented: $presenter.showingAlert) {
                Alert(title: Text("Favorited!"), message: Text(" \(detail.name) added to favorite"), dismissButton: .default(Text("OK")))
            }
        }
        .tint(Color.accentColor)
        .onAppear {
            self.presenter.getDetailGame(request: detail.id)
        }
    }
}
