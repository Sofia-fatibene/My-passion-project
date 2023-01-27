//
//  OutStream.swift
//  OS:Console
//
//  Created by Lorenzo Fatibene on 2019-09-11.
//  Copyright © 2019 Lorenzo Fatibene. All rights reserved.
//

import Foundation
import Cocoa

class OutString {
    var OnString:Bool
    var OnConsole:Bool
    var Buffer:String
    
    init(OnConsole f:Bool = false){
        OnString = true
        OnConsole = f
        Buffer = ""
    }
    
    func ToFile(path p:String = "", name n:String, Clear:Bool = true) {
        // save current string to a file if it exists or can be created
        
        let home = FileManager.default.homeDirectoryForCurrentUser  //
        let Path = home.appendingPathComponent(p)
        let fileManager = FileManager.default
        let File = Path.appendingPathComponent(n).path
        var FileExists = false

        if(fileManager.fileExists(atPath:File)){
            FileExists = true
        } else {
            if(fileManager.createFile(atPath: File, contents: nil, attributes: nil)){
                FileExists = true
            } else {
                do {
                    try fileManager.createDirectory(atPath: Path.path, withIntermediateDirectories: true, attributes: nil)
                    if(fileManager.createFile(atPath: File, contents: nil, attributes: nil)){
                        FileExists = true
                    } else {
                        print("I could not create the file \(File)")
                        FileExists = false
                    }
                } catch {
                    print("I could not create the directory at \(Path)")
                    FileExists = false
                }
            }
        }
        if(FileExists){
            if let file = FileHandle(forWritingAtPath:File) {
                if Clear {
                    file.truncateFile(atOffset: 0)
                } else {
                    file.seekToEndOfFile()
                }
                let data = (Buffer as NSString).data(using: String.Encoding.utf8.rawValue)
                file.write(data!)
                Buffer = ""
            } else {
                print("I cannot write on file \(File)")
            }
        }
    }

    func ConsoleOff() {
        OnConsole = false
    }
    
    func ConsoleOn() {
        OnConsole = true
    }
    
    func StringOff() {
        OnString = false
    }
    
    func StringOn() {
        OnString = true
    }
    
    func Write(_ s:String, BlockConsole:Bool = false, BlockPipe:Bool = false, BlockFile:Bool = false ) {
        if OnConsole && !BlockConsole {
            print(s)
        }
        if OnString {
            Buffer += "\(s)\n"
        }
    }
    
    func GetString() -> String {
        return Buffer
    }
    
    func ConsumeString() -> String {
        let ReturnVal = Buffer
        Buffer = ""
        return ReturnVal
    }
    


}  // End Class OutString
