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
        VStack(alignment: .leading, spacing: 0) {
            if let url = URL(string: "https://image.tmdb.org/t/p/w500" + (movie.posterPath ?? "")) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable(resizingMode: .stretch)
                            .frame(height: UIScreen.main
                                .bounds.size.width)
                    } else {
                        Image(systemName: "popcorn.fill")
                            .frame(height: UIScreen.main
                                .bounds.size.width)
                    }
                }
            } else {
                Color.white
            }

            HStack {
                VStack(alignment: .leading) {
                    Text(movie.title ?? "no title")
                        .font(.caption)
                        .foregroundColor(Color.black)
                        .padding(.bottom, 5)
                    Text("Rating - " + String(movie.voteAverage ?? 0))
                        .font(.caption2)
                        .foregroundColor(Color.black)
                        .padding(.bottom, 5)
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                Spacer()
                Image(systemName: "star")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
            }.background(Color.gray)
        }.frame(maxWidth: .infinity)
    }
}

