//
//  MovieView.swift
//  MachineCodingAssignment
//
//  Created by Nandan Prabhu on 19/11/22.
//

import SwiftUI

struct MovieView: View {
    let movie: Movie
    var body: some View {
        GeometryReader { geo in
            Section {
                if let url = URL(string: "https://image.tmdb.org/t/p/w500" + (movie.posterPath ?? "")) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                        } else {
                            Image(systemName: "popcorn.fill")
                        }
                    }.aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width, height: 400, alignment: .center)
                } else {
                    Color.white
                }
//                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text(movie.title ?? "no title")
                            .font(.caption)
                            .padding(.bottom, 5)
                        Text("Rating - " + String(movie.voteAverage ?? 0))
                            .font(.caption2)
                            .foregroundColor(Color.gray)
                            .padding(.bottom, 5)
                    }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                    Image(systemName: "star")
                }.background(Color.gray)
            }
        }
    }
}

