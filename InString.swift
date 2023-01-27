//
//  InStream.swift
//  OS:Console
//
//  Created by Lorenzo Fatibene on 2019-09-11.
//  Copyright © 2019 Lorenzo Fatibene. All rights reserved.
//

import Foundation


class InString {
    var Buffer:String
    var LineNum:Int
    var CharNum:Int
    var LastLine:String

    var count : Int {
        return Buffer.count
    }
    
    init(_ s:String = ""){
        LineNum = 1
        CharNum = 0
        Buffer = s
        LastLine = ""
    }
    
    func StampPos() -> (Int, Int) {
        return (LineNum,CharNum)
    }
    
    func Add(_ s:String) {
        Buffer += s
    }
    
    func Clear() {
        LineNum = 1
        CharNum = 0
        Buffer = ""
        LastLine = ""
  }
    
    func FromFile(path p:String = "", name n:String) {
        let home = FileManager.default.homeDirectoryForCurrentUser
        let Path = home.appendingPathComponent(p)
        
        let fileManager = FileManager.default
        let File = Path.appendingPathComponent(n).path
        if(!fileManager.fileExists(atPath:File)){
            fileManager.createFile(atPath: File, contents: nil, attributes: nil)
        }
        if let file = FileHandle(forReadingAtPath: File) {
            let Data = file.readDataToEndOfFile()
            if let c = String(data: Data, encoding: String.Encoding.utf8) {
                Buffer += c
            }
            file.closeFile()
        }
    }
    
    func IsEmpty() -> Bool {
        return Buffer.count == 0
    }
        
    func GetOne(IgnoreMultipleSpaces:Bool = false) -> String {
        var ReturnVal = ""
        if !IsEmpty() {
            ReturnVal = String(Buffer.removeFirst())
            LastLine += ReturnVal
            if CharNum >= 0 {
                CharNum += 1
            }
            if IsSpace(ReturnVal) && IgnoreMultipleSpaces {
                TrimWS()
            }
            if ReturnVal == "\n" {
                LineNum += 1
                CharNum = 0
                LastLine = ""
            }
        }
        return ReturnVal
    }
    
    func TrimWS() {
        var GoOn = true
        while GoOn {
            if IsEmpty() {
                GoOn = false
            } else {
                let r = GetOne()
                if IsSpace(r) {
                    // loop
                } else {
                    PushBack(r)
                }
            }
        }
    }
    
    func PushBack(_ ss:String) {
        var s = ss
        var GoOn = true
        while GoOn {
            if s.count != 0 {
                let r = String(s.removeLast())
                if r == "\n" {
                    LineNum -= 1
                    CharNum = -1
                    LastLine.removeLast()
                }
                Buffer = r + Buffer
            } else {
                GoOn = false
            }
        }
    }
    
    func GetLine(delimiter:String = "\n") -> String {  // up to a line without \n which is removed but not stored
        var ReturnVal = ""
        var c:String = ""
        while !IsEmpty() && c != delimiter {
            ReturnVal += String(c)
            c = GetOne()
        }
        return ReturnVal
    }
    
    func Report() {
        let S = String(Buffer)
        while(!self.IsEmpty()){
            let c = self.GetOne()
            Out.Write(c, BlockConsole:true)
        }
        Buffer = S
    }
    
}  // End of class InString

func IsSpace(_ c:String) -> Bool {
    if c == " " || c == "\t" || c == "\n" || c == "\r"  {
        return true
    }
    return false
}

func IsSpace(_ c:String.Element) -> Bool {
    return IsSpace(String(c))
}

func NoSpaces(_ s:String) -> String {
    var n = "", nn = s
    if nn.count == 0 {
        return n
    }
    var c = nn.first!
    while nn.count > 1 {                    // get rid of spaces
        if !IsSpace(c) {
            n.append(c)
        }
        nn.removeFirst()
        c = nn.first!
    }
    return n
}
