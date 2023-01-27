// Swift 5.1            ver 1.1.0
//                          1.1.2       (20 Aug 2022)
//
//  OS:Math:NaturalDigit
//
//      It encapsulates static methods for unsigned Digits (currently implemented as UInt64)
//      It provides functionalities to be used in NaturalNumbers.
//      All later classes should not use this directly.
//
//      See also NaturalDigital extensions which contains extensions, in this case bitwise operations
//
//  Created by Lorenzo Fatibene on 2019-07-30.
//  Copyright © 2019 Lorenzo Fatibene. All rights reserved.
//

import Foundation

protocol Record {
    init(Xml tree:XmlTree)
    func ReportXml(indent:String) -> String
}

class Song:Record {
    var Title:String = ""
    var Author:String = ""
    var Lyrics:String = ""

    init() {
    }
    
    init(_ s:Song) {
        Title = s.Title
        Author = s.Author
        Lyrics = s.Lyrics
    }
    
    /*
        Node:Song   @(2, 16)
            Node:Title   @(3, 8)
                Text:Goodbye_cruel_world   @(4, 9)
            Node:Author   @(4, 38)
                Text:Pink_Floyd   @(5, 10)
            Node:Lyrics   @(5, 31)
                Text:Goodbye_cruel_world.I|m_leaving_you_today.Goodbye.Goodbye.Goodbye...Goodbye_all_you_people.There|s_nothing_you_can_say.To_make_me_change_my_mind.Goodbye.   @(6, 10)
     */

    required init(Xml tree:XmlTree) {
        var cur = tree
        if let t = cur.CheckThisAndGoSub(ParseStata.Node, "Song") {
            cur = t
            //      Get List of Colors
            if let st = cur.CheckThisAndGoSub(ParseStata.Node, "Title") {
                if st.NodeType == ParseStata.Text {
                    Title = st.TokenContent.JSONDecode()
                } else {
                    Title = ""
                }
            } else {
                Out.Write("Title expected")
            }
            
            if let nt = cur.GoNext() {
                cur = nt
                if let st = cur.CheckThisAndGoSub(ParseStata.Node, "Author") {
                    if st.NodeType == ParseStata.Text {
                        Author = st.TokenContent.JSONDecode()
                    } else {
                        Author = ""
                    }
                } else {
                    Out.Write("Author expected")
                }
            }
            
            if let nt = cur.GoNext() {
                cur = nt
                if let st = cur.CheckThisAndGoSub(ParseStata.Node, "Lyrics") {
                    if st.NodeType == ParseStata.Text {
                        Lyrics = st.TokenContent.JSONDecode()
                    } else {
                        Lyrics = "qua_qua"
                    }
                } else {
                    Out.Write("Lyrics expected")
                }
            }
        } else {
            Out.Write("Song expected")
        }
    }
    
    func SongID() -> String {
        return "\(Title) (\(Author))"
        
    }
    
    
    
    func SetTitle(_ t:String) {
        Title = t
    }
    
    func SetAuthor(_ a:String) {
        Author = a
    }
    
    func SetLyrics(_ l:String) {
        Lyrics = l
    }
    

    func ReportXml(indent:String = "") -> String {
        var r = ""
        r = indent + "<Song>\n"
            //let i1 = indent + "   "
        r += indent + "<Title>\(Title.JSONEncode())</Title>\n"
        r += indent + "<Author>\(Author.JSONEncode())</Author>\n"
        r += indent + "<Lyrics>\(Lyrics.JSONEncode())</Lyrics>\n"
        r += indent + "</Song>"
        return r
    }

    
    func Report(indent:String = "", WithLyrics:Bool = false) -> String {
        var r = ""
        r = indent + "\(Title) (\(Author))"
        if WithLyrics {
            r += "\n\(Lyrics)\n"
        }
        return r
    }

    
    
}
