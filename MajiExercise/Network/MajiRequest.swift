//
//  MajiRequest.swift
//  MajiExercise
//
//  Created by Ting on 2020/9/20.
//  Copyright © 2020 Ting. All rights reserved.
//

import Foundation
import Moya

public class MajiRequest: NSObject {
    /// - Parameters:
    ///   - target: TargetType’s enum
    ///   - model: model type
    ///   - cache: need to manage cache data
    ///   - success: request sucess
    ///   - error: connect sucess but get data faild
    ///   - failure: connect faild
    
    public class func loadData<T: TargetType, D: Decodable>(target: T, model: D.Type?, cache: ((D?) -> Void)? = nil, success: @escaping((D?, Data?) -> Void), failure: ((Int?, String) ->Void)?) {
        let provider = MoyaProvider<T>(plugins: [
            RequestHandlingPlugin(),
            networkLoggerPlugin
            ])
        provider.request(target) { result in
            switch result {
            case let .success(response):
                let model = try? response.map(D.self);
                success(model,response.data)
            case let .failure(error):
                let statusCode = error.response?.statusCode ?? 0
                let errorCode = "request error，errorCode：" + String(statusCode)
                failureHandle(failure: failure, stateCode: statusCode, message: error.errorDescription ?? errorCode)
            }
        }
        
        func failureHandle(failure: ((Int?, String) ->Void)? , stateCode: Int?, message: String) {
            failure?(stateCode ,message)
        }
        
    }

    static let networkLoggerPlugin = NetworkLoggerPlugin(verbose: true, cURL: true, requestDataFormatter: { data -> String in
        return String(data: data, encoding: .utf8) ?? ""
    }) { data -> (Data) in
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data
        }
    }
}
