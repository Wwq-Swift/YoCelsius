//
//  String+Extention.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/16.
//  Copyright © 2017年 王伟奇. All rights reserved.
//
import UIKit

extension String {
    
    func path() -> String {
        return NSHomeDirectory().appending(self)
    }
    
    func bundleFile() -> String {
        return Bundle.main.path(forResource: self, ofType: nil)!
    }
    
    func bundleImage() -> UIImage? {
        return UIImage(named: self)
    }
    
    func exit() -> Bool {
        return FileManager.default.fileExists(atPath: NSHomeDirectory().appending(self), isDirectory: nil)
    }
    
    func createFolder() -> Bool {

        return ((try? FileManager.default.createDirectory(atPath: NSHomeDirectory().appending(self), withIntermediateDirectories: true, attributes: nil)) != nil)
    }
    
    func isDirectory() -> Bool {
        let isDirectory = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
        isDirectory[0] = true // or true
        FileManager.default.fileExists(atPath: NSHomeDirectory().appending(self), isDirectory: isDirectory)
        
        return isDirectory[0].boolValue ? true : false
    }
    
    func copyTo(path: String) -> Bool {
        return ((try? FileManager.default.copyItem(atPath: NSHomeDirectory().appending(self), toPath: NSHomeDirectory().appending(path))) != nil)
    }
    
    func moveTo(path: String) -> Bool {
        return ((try? FileManager.default.moveItem(atPath: NSHomeDirectory().appending(self), toPath: NSHomeDirectory().appending(path))) != nil)
    }
    
    func remove() -> Bool {
        return ((try? FileManager.default.removeItem(atPath: NSHomeDirectory().appending(self))) != nil)
    }
    
    func enumeratorFolder() -> [String]? {
        
        if self.isDirectory() {
            
            var storeArray: [String] = []
            
            let docsDir = NSHomeDirectory().appending(self)
            let localFileManager = FileManager()
            let dirEnum = localFileManager.enumerator(atPath: docsDir)
            var file = ""
            while ((dirEnum?.nextObject()) != nil) {
                file = dirEnum?.nextObject() as! String
                storeArray.append(NSHomeDirectory().appending(self).appending(file))
            }
            return storeArray
        }else {
            return nil
        }
    }
    
    func enumeratorFolderEach(completion: @escaping (_ path: String) -> Void) {
        
        if self.isDirectory() {
            var storeArray: [String] = []
            
            let docsDir = NSHomeDirectory().appending(self)
            let localFileManager = FileManager()
            let dirEnum = localFileManager.enumerator(atPath: docsDir)
            
            var file = ""
            
            while ((dirEnum?.nextObject()) != nil) {
                file = dirEnum?.nextObject() as! String
                storeArray.append(self.appending(file))
            }
            
            for i in storeArray {
                
                completion(i)
                
            }
        }
    }
    
    func fileInfo() -> [FileAttributeKey : Any]? {
        return try? FileManager.default.attributesOfItem(atPath: NSHomeDirectory().appending(self))
    }
    
    func fileSize() -> Int {
        let aa = fileInfo()
        guard let a = aa, let b = a.index(forKey: FileAttributeKey(rawValue: "NSFileSize")) else {
            return 0
        }
        let c = a[b].value
        return c as! Int
    }
    
    
}
































