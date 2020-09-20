//
//  MajiApi.swift
//  MajiExercise
//
//  Created by Ting on 2020/9/20.
//  Copyright © 2020 Ting. All rights reserved.
//

import UIKit
import Moya

enum  MajiApi {
    //api github
    case github
    //api others...
    case other1(p1: String, p2: Int, p3: String, p4: String)
}

extension MajiApi: TargetType {
    //path
    var path: String {
        switch self {
        case .github:
            return ""
        case let .other1(p1, p2, _, _):
            return "rank/list?pid=\(p1)&page=\(p2)"
        }
    }
    
    //pattern：post/get
    var method: Moya.Method {
        switch self {
        case .github:
            return .get
        case .other1:
            return .post
        }
    }
    
    //task is an enum type, choose different http tasks based on the server definition.
    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .github:
            return .requestPlain
        case let .other1(_, _, p3, p4):
            params["p3"] = p3
            params["p4"] = p4
        
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
}

