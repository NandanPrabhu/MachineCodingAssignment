//
//  AnyRequestable.swift
//  MachineCodingAssignment
//
//  Created by Nandan Prabhu on 19/11/22.
//

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}
protocol AnyRequestable {
    var endpoint: String { get }
    var baseURL: String { get }
    var httpMethod: HTTPMethod { get }
    var requestParams: [String: String] { get }
}
