//
//  Log.swift
//  toutiao
//
//  Created by dx7d9 on 2018/1/29.
//  Copyright © 2018年 dx7d9. All rights reserved.
//

import Foundation

///日志
func Log<T>(message: T,fileName:String = #file,methodName : String = #function , lineNumber : Int = #line){
    #if DEBUG
    let fileName = (fileName as NSString).lastPathComponent
    print("\(fileName)\(methodName)[\(lineNumber)]:\(message)")
    #endif
}


