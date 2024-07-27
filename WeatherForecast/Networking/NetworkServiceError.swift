//
//  NetworkServiceError.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation

public enum NetworkServiceError: Error, Equatable {
    case noInternet
    case invalidURL
    case invalidResponse
    case errorResponse(error: Error)
    case response(errorResponse: APIErrorResponse)
}

extension NetworkServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return "The Internet connection appears to be offline."
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Server response error"
        case .errorResponse(let error):
            return error.localizedDescription
        case .response(let errorResponse):
            return errorResponse.message
        }
    }
}

public func == (lhs: NetworkServiceError, rhs: NetworkServiceError) -> Bool {
    return lhs.errorDescription == rhs.errorDescription
}

public struct APIErrorResponse: Codable {
    let code: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case code
        case message
    }
}

public struct ErrorResponse: Codable {
    let error: APIErrorResponse

    enum CodingKeys: String, CodingKey {
        case error
    }
}
