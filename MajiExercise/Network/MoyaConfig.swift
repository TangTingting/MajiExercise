//
//  MoyaConfig.swift
//  MajiExercise
//
//  Created by Ting on 2020/9/20.
//  Copyright © 2020 Ting. All rights reserved.
//

import UIKit
import Moya

public extension TargetType {
    //TargetType protocol
    var baseURL: URL {
        return URL(string: MajiClient.apiServer)!
    }

    var headers: [String : String]? {
        return nil
    }

    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
}

//public parameters,as toke,version,time...
extension URLRequest {
    private var commonParams: [String: Any]? {
        return nil
    }
}

class RequestHandlingPlugin: PluginType {
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var mutateableRequest = request
        return mutateableRequest.appendCommonParams();
    }
}

extension URLRequest {
    mutating func appendCommonParams() -> URLRequest {
        let request = try? encoded(parameters: commonParams, parameterEncoding: URLEncoding(destination: .queryString))
        assert(request != nil, "append common params failed, please check common params value")
        return request!
    }

    func encoded(parameters: [String: Any]?, parameterEncoding: ParameterEncoding) throws -> URLRequest {
        do {
            return try parameterEncoding.encode(self, with: parameters)
        } catch {
            throw MoyaError.parameterEncoding(error)
        }
    }
}


