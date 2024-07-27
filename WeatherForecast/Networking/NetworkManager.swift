//
//  NetworkManager.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Alamofire
import Foundation

final class NetworkManager {
    private let session: Session
    private var baseURL: String

    public init(baseURL: String) {
        self.baseURL = baseURL
        let configuration = URLSessionConfiguration.af.default
        let serverTrustPolicies: [String: ServerTrustEvaluating] = ["api.weatherapi.com": DisabledTrustEvaluator()]
        let serverTrustManager = ServerTrustManager(evaluators: serverTrustPolicies)
        self.session = Session(configuration: configuration, serverTrustManager: serverTrustManager)
    }

    public func callAPI<T: Codable>(_ method: HTTPMethod,
                                    endPoint: String,
                                    parameters: [String: Any]? = nil,
                                    headers: [String: String] = [:],
                                    encoding: ParameterEncoding? = nil,
                                    completionHandler: @escaping (Swift.Result<T, NetworkServiceError>) -> Void)
    {
        let url = baseURL + endPoint
        let headers: HTTPHeaders? = HTTPHeaders(headers)
        let parameterEncoding: ParameterEncoding

        if let encoding = encoding {
            parameterEncoding = encoding
        } else {
            switch method {
            case .get:
                parameterEncoding = URLEncoding.default
            case .put, .post, .patch:
                parameterEncoding = JSONEncoding.default
            default:
                parameterEncoding = JSONEncoding.default
            }
        }

        guard NetworkManager.isConnectedToInternet() else {
            completionHandler(.failure(NetworkServiceError.noInternet))
            return
        }

        session.request(url,
                        method: method,
                        parameters: parameters,
                        encoding: parameterEncoding,
                        headers: headers,
                        interceptor: nil)
            .validate { (_, response, data) -> DataRequest.ValidationResult in
                switch response.statusCode {
                case 200 ..< 300:
                    return .success(())
                default:
                    guard let data = data, let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) else {
                        return .failure(NetworkServiceError.invalidResponse)
                    }
                    return .failure(NetworkServiceError.response(errorResponse: errorResponse.error))
                }
            }
            .responseDecodable(of: T.self) { response in
                self.mapResponse(response: response, completionHandler: completionHandler)
            }
    }

    private func mapResponse<T>(response: DataResponse<T, AFError>, completionHandler: @escaping (Swift.Result<T, NetworkServiceError>) -> Void) {
        switch response.result {
        case .success(let value):
            completionHandler(.success(value))

        case .failure(let error):
            handleError(error: error, httpStatusCode: response.response?.statusCode, completionHandler: completionHandler)
        }
    }

    private func handleError<T>(error: AFError, httpStatusCode: Int?, completionHandler: @escaping (Swift.Result<T, NetworkServiceError>) -> Void) {
        if let error = error.underlyingError as? NetworkServiceError {
            completionHandler(.failure(error))
        } else if case AFError.sessionTaskFailed(error: let afUrlError) = error, let urlError = afUrlError as? URLError, urlError.code == URLError.Code.notConnectedToInternet {
            completionHandler(.failure(.noInternet))
        } else {
            completionHandler(.failure(.errorResponse(error: error)))
        }
    }

    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

