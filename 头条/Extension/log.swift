//
//  log.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/22.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import Foundation
func Log<T>(message: T, fileName: String = #file, methodName: String =  #function, lineNumber: Int = #line)
{
        let fileName = (fileName as NSString).lastPathComponent
        print("\(fileName)\(methodName)[\(lineNumber)]:\(message)")
}

