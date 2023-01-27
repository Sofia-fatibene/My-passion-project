//
//  OutStream.swift
//  OS:Console
//
//  Created by Lorenzo Fatibene on 2019-09-11.
//  Copyright © 2019 Lorenzo Fatibene. All rights reserved.
//

import Foundation
import Cocoa

class OutStream : OutString {
    var Path:URL?
    var file:FileHandle?
    var Piped:OutStream?

    init(path s:String){  // Relative to the User home, eg "Documents/myMath/"
        let fileManager = FileManager.default
        file = nil
        Piped = nil
        let home = FileManager.default.homeDirectoryForCurrentUser
        Path = home.appendingPathComponent(s)
        if(fileManager.fileExists(atPath: Path!.path)){
        } else {
            do {
                try fileManager.createDirectory(atPath: Path!.path, withIntermediateDirectories: true, attributes: nil)
                Path = home.appendingPathComponent(s)
            } catch {
                print("I could not create the directory at ~/\(s)")
                Path = nil
            }
        }
        super.init(OnConsole: false)
        StringOff()
    }
    
    func Open(_ FileName:String, Clear: Bool = true) {
        let fileManager = FileManager.default
        if(Path == nil) {
            file = nil
        } else {
            let File = Path!.appendingPathComponent(FileName).path

            if(fileManager.fileExists(atPath:File)){
                file = FileHandle(forWritingAtPath: File)
            } else {
                if(fileManager.createFile(atPath: File, contents: nil, attributes: nil)){
                    file = FileHandle(forWritingAtPath: File)
                } else {
                    print("Cannot create file \(FileName)")
                    file = nil
                }
            }
            if(file != nil) {
                    if Clear {
                        file!.truncateFile(atOffset: 0)
                    } else {
                        file!.seekToEndOfFile()
                    }
            }
        }
    }
    
    func Close() {
        if file != nil {
            file!.closeFile()
        }
    }
    
    func Pipe(to ostream:OutStream? = nil) {
        Piped = ostream
    }
    
    override func Write(_ s:String, BlockConsole:Bool = false, BlockPipe:Bool = false, BlockFile:Bool = false ) {
        // print("Wrining OutStream: \(s)")
        if OnConsole && !BlockConsole {
            print(s)
        }
        if OnString {
            Buffer += s
        }
        if file != nil && !BlockFile {
          let data = (s as NSString).data(using: String.Encoding.utf8.rawValue)
           file!.write(data!)
        }
        if Piped != nil && !BlockPipe {
            //print("Piping \(s)")
            Piped!.Write(s, BlockConsole:BlockConsole, BlockPipe:BlockPipe, BlockFile:BlockFile)
        }
    }

}
