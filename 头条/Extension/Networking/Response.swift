//
//  Reqponse.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import Foundation

import Foundation

public struct DataResponse<Value>
{
    public let request: URLRequest?
    public let response: HTTPURLResponse?
    public let data: Data?
    public let result: Result<Value>
    
}

public enum Result<Value>
{
    case success(Value)
    case failure(Error?)
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    public var value: Value? {
        switch self
        {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    public var error: Error? {
        switch self
        {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

public struct DataResponseSerializer<T>
{
    public typealias SerializeResponse = (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<T>
    var serializeResponse: SerializeResponse
    public init(serializeResponse: @escaping SerializeResponse)
    {
        self.serializeResponse = serializeResponse
    }
}
