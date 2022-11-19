//
//  PopularMovieRequest.swift
//  MachineCodingAssignment
//
//  Created by Nandan Prabhu on 19/11/22.
//

import Foundation

enum PopularMovieRequest: AnyRequestable {
    case fetchPopularMovies(pageNumber: Int)
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var requestParams: [String : String] {
        switch self {
        case .fetchPopularMovies(let pageNumber):
            var params: [String: String] = [:]
            params["api_key"] = "38a73d59546aa378980a88b645f487fc"
            params["language"] = Locale.current.languageCode
            params["page"] = String(pageNumber)
            return params
        }
    }
    
    var endpoint: String {
        return "/3/movie/popular"
    }
    
    var baseURL: String {
        return "https://api.themoviedb.org"
    }
}
