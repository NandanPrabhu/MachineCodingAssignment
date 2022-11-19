//
//  ContentViewModel.swift
//  MachineCodingAssignment
//
//  Created by Nandan Prabhu on 19/11/22.
//

import SwiftUI
import Combine

protocol ViewModelTransformable {
    associatedtype Input
    associatedtype Output: ObservableObject
    func transform(input: Input) -> Output
}

struct ViewModelInput {
    let callAPI: PassthroughSubject<Int, Never>
}

class ViewModelOutput: ObservableObject {
    @Published var movies: [Movie] = []
}

class ContentViewModel: ViewModelTransformable {
    let service: AnyService
    var cancellables: Set<AnyCancellable> = []
    var output = ViewModelOutput()
    init(service: AnyService = Service()) {
        self.service = service
    }

    func transform(input: ViewModelInput) -> ViewModelOutput {
        input.callAPI
            .flatMap { [weak self] pageNumber -> AnyPublisher<MoviesResponseModel, Error> in
                guard let self = self else {
                    return Empty(completeImmediately: true).eraseToAnyPublisher()
                }
                let request = PopularMovieRequest.fetchPopularMovies(pageNumber: pageNumber)
                return self.service.fetchPopularMovies(request: request,
                                                       decodingType: MoviesResponseModel.self)
            }
            .receive(on: DispatchQueue.main)
            .sink { response in
                switch response {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            } receiveValue: { movies in
                self.output.movies = movies.results ?? []
            }.store(in: &cancellables)
        return self.output
    }
}
