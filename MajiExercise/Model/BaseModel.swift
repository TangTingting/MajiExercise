//
//  BaseModel.swift
//  MajiExercise
//
//  Created by Ting on 2020/9/20.
//  Copyright © 2020 Ting. All rights reserved.
//

enum HttpCode : Int {
    case success = 1 //success code
}

struct BaseModel: Decodable {
    var code: Int
    var data: Content
    struct Content: Decodable {
        var message: String
    }
}


extension BaseModel {
    var generalCode: Int {
        return code
    }

    var generalMessage: String {
        return data.message
    }
}

