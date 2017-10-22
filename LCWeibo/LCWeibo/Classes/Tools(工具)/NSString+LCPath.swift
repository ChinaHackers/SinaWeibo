//
//  NSString+LCPath.swift
//  LCWeibo
//
//  Created by Liu Chuan on 2017/6/15.
//  Copyright © 2017年 LC. All rights reserved.
//

import Foundation

extension NSString {
    
    func lc_appendDocumentDir() -> NSString {
    //    let dir: String? = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
//    return URL(fileURLWithPath: dir!).appendingPathComponent(lastPathComponent).absoluteString
        
        let dir: NSString? = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last as NSString?
        
        return dir!.appendingPathComponent((dir?.lastPathComponent)!) as NSString
    }

}
