//
//  XmlFile.swift
//  OS:XmlParser
//
//  Created by Lorenzo Fatibene on 2019-09-11.
//  Copyright © 2019 Lorenzo Fatibene. All rights reserved.
//

import Foundation

//  Stata of the Scanner machine
//      negative stata are leaves
//      positive stata are internal
enum ScanStata: Int {
    case EoF    = -300
    case Error  = -200

    case Char   = -1
    case Seq    = -2
    case Space  = -3

    case Root   = 1
    case Amp    = 2
    
}

enum TerminalScanStata: Int {
    //  Possible Results of the Scanner machine
    case EoF    = -300
    case Error  = -200
    
    case Char   = -1
    case Seq    = -2
    case Space  = -3
}

enum NonTerminalScanStata: Int {
    // Internal stata of the Scanner machine
    case Root   = 1
    case Amp    = 2
}






//  Stata of the Tokenizer machine
//      negative stata are leaves
//      positive stata are internal
enum TokenStata : Int {
    case EoF        = -300
    case Error      = -200
    
    case Text       = -11
    case Eq         = -12
    case String     = -13
    case OTag       = -14
    case CTag       = -15
    case BCTag      = -16
    case OBTag      = -17
    
    case Root       = 10
    case GetDQStr   = 11
    case GetSQStr   = 12
    case GetBCTag   = 13
    case GetOTag    = 14
    case GetText    = 15
}

enum TerminalTokenStata : Int {
    // Possible results of Tokenizer
    case EoF        = -300
    case Error      = -200
    
    case Text       = -11
    case Eq         = -12
    case String     = -13
    case OTag       = -14
    case CTag       = -15
    case BCTag      = -16
    case OBTag      = -17
}

enum NonTerminalTokenStata : Int {
    // Internal stata of Tokenizer
    case Root       = 10
    case GetDQStr   = 11
    case GetSQStr   = 12
    case GetBCTag   = 13
    case GetOTag    = 14
    case GetText    = 15
}

// Stata of Parser Machine
//      negative stata are leaves
//      positive stata are internal
enum ParseStata : Int {
    case EoF        = -300
    case Error      = -200
    
    case Text       = -11
    case Eq         = -12
    case String     = -13
    case OTag       = -14
    case CTag       = -15
    case BCTag      = -16
    case OBTag      = -17
    
    case ø          = 0

    case Node       =   51
    case Name       =   52
    case ONode      =   53
    case OCNode     =   54
    case CNode      =   55
    case ANode      =   56
    case Content    =   57

}

enum TerminalParseStata : Int {
    // Terminal Items
    case EoF        = -300
    case Error      = -200
    
    case Text       = -11
    case Eq         = -12
    case String     = -13
    case OTag       = -14
    case CTag       = -15
    case BCTag      = -16
    case OBTag      = -17
}
    
enum NonTerminalParseStata : Int {
    // Non Terminal Items
    case Node       =   51
    case Name       =   52
    case ONode      =   53
    case OCNode     =   54
    case CNode      =   55
    case ANode      =   56
    case Content    =   57
}



// Utilities


func TrimWSLeft(_ s:String) -> String {
    var r=s
    var GoOn = true
    while GoOn {
        if let cc = r.first {
            if IsSpace(String(cc)) {
                r.removeFirst()
            } else {
                GoOn = false
            }
        } else {
            GoOn = false
        }
    }
    return r
}

func TrimWSRight(_ s:String) -> String {
    var r=s
    var GoOn = true
    while GoOn {
        if let cc = r.last {
            if IsSpace(String(cc)) {
                r.removeLast()
            } else {
                GoOn = false
            }
        } else {
            GoOn = false
        }
    }
    return r

}

func TrimWS(_ s:String) -> String {
    let r=TrimWSLeft(s)
    return TrimWSRight(r)
}


// Character Classes


var HexDigits = CharacterSet(charactersIn: Unicode.Scalar("A")...Unicode.Scalar("F")).union(CharacterSet(charactersIn: Unicode.Scalar("0")...Unicode.Scalar("9")))
var hexDigits = CharacterSet(charactersIn: Unicode.Scalar("a")...Unicode.Scalar("f")).union(CharacterSet(charactersIn: Unicode.Scalar("0")...Unicode.Scalar("9")))
var OctalDigits = CharacterSet(charactersIn: Unicode.Scalar("0")...Unicode.Scalar("7"))
var BinaryDigits = CharacterSet(charactersIn: Unicode.Scalar("0")...Unicode.Scalar("1"))



func IsEscape(_ c:String) -> Bool {
    if c == "\\" || c == "&" {
        return true
    }
    return false
}

func IsQuote(_ c:String) -> Bool {
    if c == "\"" || c == "'" {
        return true
    }
    return false
}

func IsDDuote(_ c:String) -> Bool {
    if c == "\""  {
        return true
    }
    return false
}

func IsSQuote(_ c:String) -> Bool {
    if c == "'" {
        return true
    }
    return false
}


func IsLetter(_ c:String) -> Bool {
    if let u = Unicode.Scalar(c) {
        return CharacterSet.letters.contains(u)
    }
    return false
}

func IsDecimalDigit(_ c:String) -> Bool {
    if let u = Unicode.Scalar(c) {
        return CharacterSet.decimalDigits.contains(u)
    }
    return false
}

func IsHexDigit(_ c:String) -> Bool {
    if let u = Unicode.Scalar(c) {
        return HexDigits.contains(u) || hexDigits.contains(u)
    }
    return false
}

func IsOctalDigit(_ c:String) -> Bool {
    if let u = Unicode.Scalar(c) {
        return OctalDigits.contains(u)
    }
    return false
}

func IsBinaryDigit(_ c:String) -> Bool {
    if let u = Unicode.Scalar(c) {
        return BinaryDigits.contains(u)
    }
    return false
}

func IsSpecial(_ c:String) -> Bool {
    if c == "=" || c == "<" || c == "\"" || c == "'" || c == ">" || c == "/" {
        return true
    }
    return false
}


