//
//  Word.swift
//  Database
//
//  Created by Sofia on 18/01/23.
//

import Foundation

// create a word class
class Word {
// create an istance (variable) Word
    var word:String = ""
// initializer with a empty string
    init(_ s:String = "") {
        word = s
    }
    
 //create a method that evaluates words.
    func Evaluation(_ w:Word) -> Double {
        //Out.Write("Eval \(self.word) vs \(w.word)")
        if word == w.word {
            return 1.0
        }
        var r = 1.0
        var s = word
        var S1 = w.word
        for _ in 0..<s.count {
            let c = s.first
            let C1 = S1.first
            if C1 != nil {
                if c! == C1! {
                    r = r * 1.0
                } else {    // if c != C1
                    //print("entrato")
                    var S2 = w.word
                    for _ in 0 ..< S2.count + 1 {
                        let C2 = S2.first
                        if C2 == nil {
                            r = r * 0.3
                            break
                        } else {
                            //print("confronta \(c!) con \(C2!)")
                            if c! == C2! {
                                r = r * 0.8
                                break
                            } else {
                                S2.removeFirst()
                            }
                        }
                    }
                }
                if S1.count > 0 {
                    S1.removeFirst()
                }
                if s.count > 0 {
                    s.removeFirst()
                }
            } else {
                r = r * 0.1
            }
        }
        return r
    }
    
    func Evaluation(_ p:Phrase) -> Double {
        var r:Double = 0
        let aw = p.Split()
        for W in aw {
            let val = Evaluation(W)
            if val > r {
                r = val
            }
            
        }
      
        return r
    }
    
    func Report() -> String {
        return word
    }

}

