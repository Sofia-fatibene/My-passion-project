//
//  Phrase .swift
//  Database
//
//  Created by Sofia on 21/01/23.
//

import Foundation

class Phrase {
   
    var phrase:String = ""
    
    init(_ s:String = "") {
        
        phrase = s 
    }
    
    func Split() -> [Word] {
        var r:[Word] = []
        
        var p:String = ""
        for x in phrase {
            if x == "."
                || x == ","
                || x == "!"
                || x == "?"
                || x == "("
                || x == ")"
                || x == ";"
                || x == ":"
                || x == "_"
                || x == "\\"  {
                    p = p + " "
                
            } else {
                p = p + String(x)
            }
        }
        p = p.TrimHead()
        while p.count > 0 {
            //print(p)
            let index = p.firstIndex(of: " ") ?? p.endIndex
            let firstWord = String(p[..<index])
        // Substring
            p = String(p[index...])
        // Cast (change type) to String
        //  Add Word to Array r
            r.append(Word(firstWord))
            //print(":\(firstWord):|:\(p):.")
            p = p.TrimHead()
        }
        return r
    }
    
    func Evaluate(_ p:Phrase) -> Double {
        var r:Double = 1.0
        let aw = Split ()
        for W in aw {
            r = r * W.Evaluation(p)
        }
        return r
        
    }
    
}
