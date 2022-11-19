//
//  Service.swift
//  MachineCodingAssignment
//
//  Created by Nandan Prabhu on 19/11/22.
//

import Combine
import Foundation

protocol AnyService {
    func fetchPopularMovies<T: Decodable>(request: AnyRequestable, decodingType: T.Type) -> AnyPublisher<T, Error>
}

class Service: AnyService {
    func fetchPopularMovies<T: Decodable>(request: AnyRequestable, decodingType: T.Type) -> AnyPublisher<T, Error> {
        guard let urlRequest = getRequest(request)  else {
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap() { tuple -> Data in
                guard let httpResponse = tuple.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return tuple.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func getRequest(_ request: AnyRequestable) -> URLRequest? {
        var urlComponents = URLComponents(string: request.baseURL)
        urlComponents?.path = request.endpoint
        urlComponents?.queryItems = request.requestParams.map { URLQueryItem(name: $0.key, value: $0.value)}
        guard let url = urlComponents?.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        return urlRequest
    }
}
