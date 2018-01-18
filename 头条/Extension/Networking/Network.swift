//
//  Network.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import Foundation

public enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
}

extension String
{
    func ToURL() throws -> URL {
        guard let url = URL(string: self)  else {
            throw NSError()
        }
        return url
    }
}

