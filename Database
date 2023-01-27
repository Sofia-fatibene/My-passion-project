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

class DBSong {
    var Num:Int = 0
    var Records:[Song] = []
    
    /*
      aggiungi una proprietà calcolata che valuta
     
     */
    
    init() {
    }
    
    static func BasicDB() -> DBSong {
        let A:DBSong
        A = DBSong()
        let s = Song()
        s.SetTitle("Goodbye cruel world")
        s.SetAuthor("Pink Floyd")
        s.SetLyrics("""
Goodbye cruel world
I'm leaving you today
Goodbye
Goodbye
Goodbye

Goodbye all you people
There's nothing you can say
To make me change my mind
Goodbye
""")
        A.Add(s)
       return A
    }
    
    
    static func Load(path:String) -> DBSong {
        let xfile = XmlParser()
        xfile.FromFile(path:path, name:"MyDBSongs.xml")
        let tree = xfile.ParseAndNormal()
        //print("&&&&: \(tree.Report())\n&&&&")

        var A:DBSong
        A = DBSong(Xml: tree)
        if A.Num == 0 {
            Out.Write("Empty DB: I create a dumb DB for you")
            A = DBSong.BasicDB()
        }
        return A
    }

    func Save(path:String = "Documents/MusicDB/DB/") {
        // let DBStream = OutStream(path:path)
        let xml = ReportXml()
        let File = OutString()
        File.Write(xml)
        File.ToFile(path:path, name:"MyDBSongs.xml")
    }

/*
 Node:DBSong   @(1, 0)
    Node:Num   @(1, 10)
        Text:1   @(2, 7)
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
        if let t = cur.CheckThisAndGoSub(ParseStata.Node, "DBSong") {
            cur = t
            if let st = cur.CheckThisAndGoSub(ParseStata.Node, "Num") {
                if st.NodeType == ParseStata.Text {
                    if let n = Int(st.TokenContent) {
                        var nt:XmlTree? = cur.GoNext()
                        while nt != nil {
                                let song = Song(Xml:nt!)
                                Add(Song(song))
                                nt = nt!.GoNext()
                        }
                        if Num != n {
                            Out.Write("Num Mismatch: \(Num) expected, \(n) found.")
                        }
                    }
                }
            } else {
                Out.Write("Num expected")
            }
        } else {
            Out.Write("DBSong expected")
        }
    }
    
//    Sort(by Phrase( "Coraline bye"))
    func Sort( by p:Phrase) -> [String] {
        var r:[String] = []
        var v:[Double] = []
//        array di stringhe
//        per ogni canzone (for) crea stringa Titolo autore evaluate (forse) val dentro v
        for song in Records {
// returns songs array
            r.append(song.SongID())
// prende song valuta con phrase
            v.append(p.Evaluate(Phrase(song.Lyrics)))
         
        }
        (r,v) = DBSong.BubbleSort(r,v)
        
        /*
         for n in 0..<r.count {
            Out.Write("[\(v[n])] \(r[n])")
        }
         */
        for n in 0..<r.count {
           r[n] = "\(r[n]) [\(v[n])]"
        }
        return r
    }
    
    
    
// array di stringe e di double = []stringe e di[] double
    static func BubbleSort(_ rr:[String], _ vv:[Double]) -> ([String], [Double]) {
        /*
procedure bubbleSort(A : list of sortable items)
n := length(A)
repeat
    swapped := false
    for i := 1 to n-1 inclusive do
                        /* if this pair is out of order */
        if A[i-1] > A[i] then
                            /* swap them and remember something changed */
            swap(A[i-1], A[i])
            swapped := true
        end if
    end for
until not swapped
end procedure
         
         */
        var swapped:Bool = false
        let n = rr.count
        if n != vv.count {
            return ([], [])
        }
        var r = rr
        var v = vv
        repeat{
            swapped = false
            for i in 1..<n {
                if v[i-1] < v[i] {
                    (r[i-1], r[i]) = (r[i], r[i-1])
                    (v[i-1], v[i]) = (v[i], v[i-1]) // swap
                    swapped = true
                }
            }
        } while swapped == true
        return (r, v)
    }

    func Add(_ s:Song) {
        Num += 1
        Records.append(Song(s))
    }
    
    func ReportXml(indent:String = "") -> String {
        var r = ""
        r = indent + "<DBSong>\n"
            //let i1 = indent + "   "
            r += indent + "<Num>\(Num)</Num>\n"
            for x in Records {
                r += indent + "\(x.ReportXml(indent:indent) )\n"
            }
        r += indent + "</DBSong>"
        return r
    }

    
    func Clear() {
        Records = []
        Num = 0
    }


}


extension String {
    func JSONEncode() -> String {
        var r = ""
        for x in self {
            if x == " " {
                r.append("_")
            } else if x == "\n" {
                r.append(".")
            } else if x == "'" {
                r.append("|")
            } else {
                r.append(x)
            }
        }
        return r
    }
    
    func JSONDecode() -> String {
        var r = ""
        for x in self {
            if x == "_" {
                r.append(" ")
            } else if x == "." {
                r.append("\n")
            } else if x == "|" {
                r.append("'")
            } else {
                r.append(x)
            }
        }
        return r
    }
    
    func TrimHead() -> String {
        var r:String = self
        while r.count > 0 && (r.first == " " || r.first == "\t")  {
            // se è uno spazio oppure un tab dimentiacalo
            // se no salva tutto fino alla fine
            
            r.removeFirst()
        }
        return r
    }
}
