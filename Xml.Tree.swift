/
//  XmlTree.swift
//  OS:XmlParser
//
//  Created by Lorenzo Fatibene on 2019-09-21.
//  Copyright © 2019 Lorenzo Fatibene. All rights reserved.
//

import Foundation


class XmlParseTree: Tree {
    var NodeType:ParseStata
    var TokenContent:String
    var TokenPos:(Int,Int)

    init(NodeType nt:ParseStata, Token t:Token) {
        NodeType = nt
        TokenContent = t.TokenContent
        TokenPos = t.TokenPos
        super.init()
    }
    
    init(NodeType nt:ParseStata, TokenContent tc:String, TokenPos tp:(Int, Int) ) {
        NodeType = nt
        TokenContent = tc
        TokenPos = tp
        super.init()
    }
    
    func Report(indent:String = "") -> String {
        var R:String
        let i1 = indent + "  "
        R = "\(indent)\(NodeType):\(TokenContent)   @\(TokenPos)\n"
        if Sub != nil {
            R += (Sub! as! XmlParseTree).Report(indent: i1)
        }
        if Next != nil {
            R += (Next! as! XmlParseTree).Report(indent: indent)
        }
        return R
    }
    
    private struct NormalStatus {
        var OName = "."                     // Outmost Open  Tag Name
        var CName = ".."                    // Outmost Close Tag Name
        var ContentText = ""                // Possible Text  (one and first content)
        var Content:XmlTree? = nil
        var Errors:[String] = []

        func Clone() -> NormalStatus {
            var R = NormalStatus()
            R.OName = self.OName
            R.CName = self.CName
            R.ContentText = self.ContentText
            R.Content = self.Content        
            R.Errors = self.Errors          
            return R
        }
        
        func Report() -> String {
            var r = ""
            r += "OName: \(self.OName)\n"
            r += "CName: \(self.CName)\n"
            r += "ContentText: \(self.ContentText)\n"
            if Content != nil {
                r += "Content:\n \(self.Content!.Report())\n"
            } else {
                r += "Content\n"
            }
            r += "Errors: # \(self.Errors.count)\n"
            return r
        }
    }
    
    func Normal() -> XmlTree {
        var S = recNormal()
        if S.Errors.count > 0 {
            Out.Write("Errors \(S.Errors.count) found.")
            for c in S.Errors {
                Out.Write(c)
            }
        } else {
             // Out.Write("Parsed with no errors.")
        }
        if S.Content == nil {
            S.Content = XmlTree()       // Empty XmlTree
        }
        return S.Content!
    }

    
    private func recNormal() -> NormalStatus {
        var status = NormalStatus()
        // self punta alla root di XmlParseTree
        let Type = self.NodeType
        var sSub = NormalStatus(), sNext = NormalStatus()
        var selfHasSub = false, selfHasNext = false
        var subHasContent = false, nextHasContent = false

        if let treeSub = (self.Sub as! XmlParseTree?) {
            selfHasSub = true
            sSub = treeSub.recNormal()
            if sSub.Content != nil {
                subHasContent = true
            }
        }

        if let treeNext = (self.Next as! XmlParseTree?) {
            selfHasNext = true
            sNext = treeNext.recNormal()
            if sNext.Content != nil {
                nextHasContent = true
            }
        }

        if Type == ParseStata.Node {
            let R = XmlTree()
            status.OName = "."
            status.CName = ".."
            status.ContentText = ""
            status.Content = nil
            if selfHasSub {
                if sSub.OName == sSub.CName {
                    R.TokenPos = self.TokenPos
                    R.NodeType = ParseStata.Node
                    R.TokenContent = sSub.OName
                    R.Sub = sSub.Content        
                    status.Content = R
                } else {
                    status.Errors.append("Error: Tag [\(sSub.OName)=\(sSub.CName)] not properly closed @(\(TokenPos.0):\(TokenPos.1))")
                }
            } else {
                status.Errors.append("Error: \(Type) must have a son @(\(TokenPos.0):\(TokenPos.1))")
            }
            if nextHasContent || selfHasNext {
                status.Errors.append("Error: \(Type) brothers ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
           
        } else if Type == ParseStata.ANode {
            status.OName = sSub.OName
            status.CName = sSub.OName
            status.ContentText = sSub.ContentText
            status.Content = sSub.Content
            if nextHasContent || selfHasNext {
                status.Errors.append("Error: \(Type) brothers ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
           
        } else if Type == ParseStata.OCNode {
            status.OName = sSub.OName
            status.CName = sSub.CName
            status.ContentText = sSub.ContentText
            status.Content = sSub.Content
            if nextHasContent || selfHasNext {
                status.Errors.append("Error: \(Type) brothers ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
           

        } else if Type == ParseStata.ONode {
            status.OName = sSub.OName
            status.CName = sNext.CName
            status.ContentText = sSub.ContentText
            status.Content = nil
            if selfHasNext {
                status.Content = sNext.Content
            } else {
                status.Errors.append("Error: \(Type) unclosed tag @(\(TokenPos.0):\(TokenPos.1))")
            }
            if selfHasSub {
                if subHasContent {
                    status.Errors.append("Error: \(Type) sons ignored @(\(TokenPos.0):\(TokenPos.1))")
                }
            } else {
                status.Errors.append("Error: \(Type) with no name @(\(TokenPos.0):\(TokenPos.1))")
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
           
        } else if Type == ParseStata.CNode {
            status.OName = sSub.OName
            status.ContentText = sSub.ContentText
            status.Content = nil
            if nextHasContent || selfHasNext {
                status.Errors.append("Error: \(Type) brothers ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            if selfHasSub {
                status.CName = sSub.CName
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
            
        } else if Type == ParseStata.Name {
            status.OName = sSub.OName
            status.CName = sSub.CName
            status.Content = nil
            if !selfHasNext {
                status.Errors.append("Error: \(Type) unclosed tag @(\(TokenPos.0):\(TokenPos.1))")
            }
            if subHasContent {
                status.ContentText = sSub.Content!.TokenContent
            } else {
                status.Errors.append("Error: \(Type) with no name @(\(TokenPos.0):\(TokenPos.1))")
                status.ContentText = "NoName@(\(TokenPos.0):\(TokenPos.1))"
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
           
        } else if Type == ParseStata.Content {
            status.OName = sSub.OName
            status.CName = sNext.CName
            status.ContentText = sSub.ContentText
            if nextHasContent && subHasContent {    // Sub + Next  
                status.Content = sSub.Content
                status.Content!.Append(Next: sNext.Content)
            } else if nextHasContent {              // Next
            
                status.Content = sNext.Content!
            } else if subHasContent {               // Sub
                
                status.Content = sSub.Content!
            } else {
               
                status.Content = nil
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
       
        } else if Type == ParseStata.Text || Type == ParseStata.String {
            let R = XmlTree()
            R.NodeType = ParseStata.Text
            R.TokenContent = self.TokenContent
            R.TokenPos = self.TokenPos
            status.OName = sSub.OName
            status.CName = sSub.CName
            status.ContentText = sSub.ContentText
            status.Content = R
            if nextHasContent || selfHasNext {
                status.Errors.append("Error: \(Type).brothers ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            if subHasContent || selfHasSub {
                status.Errors.append("Error: \(Type) sons ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
           
        } else if Type == ParseStata.OTag {
            status.CName = sSub.CName
            status.ContentText = ""
            status.Content = nil
            if nextHasContent || selfHasNext {
                status.OName = sNext.ContentText
            } else {
                status.Errors.append("Error: \(Type) with no name @(\(TokenPos.0):\(TokenPos.1))")
                status.OName = "NoOName@(\(TokenPos.0):\(TokenPos.1))"
            }
            if subHasContent {
                status.Errors.append("Error: \(Type) sons ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
            
        } else if Type == ParseStata.CTag {
            status.OName = sSub.OName
            status.CName = sSub.CName
            status.ContentText = sSub.ContentText
            status.Content = nil
            if nextHasContent || selfHasNext {
                status.Errors.append("Error: \(Type) brothers ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            if subHasContent || selfHasSub {
                status.Errors.append("Error: \(Type) sons ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
          
        } else if Type == ParseStata.OBTag {
            status.OName = sSub.OName
            status.ContentText = ""
            status.Content = nil
            if nextHasContent || selfHasNext {
                status.CName = sNext.ContentText
            } else {
                status.Errors.append("Error: \(Type) with no name @(\(TokenPos.0):\(TokenPos.1))")
                status.CName = "NoCName@(\(TokenPos.0):\(TokenPos.1))"
            }
            if subHasContent || selfHasSub {
                status.Errors.append("Error: \(Type) sons ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
            // Sotto ha sempre nil
            // A destra ha Name (sempre)
        } else if Type == ParseStata.BCTag {
            status.OName = sSub.OName
            status.CName = sSub.CName
            status.ContentText = sSub.ContentText
            status.Content = nil
            if nextHasContent || selfHasNext {
                status.Errors.append("Error: \(Type) brothers ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            if subHasContent || selfHasSub {
                status.Errors.append("Error: \(Type) sons ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
            // Sotto ha sempre nil
            // A destra ha sempre nil
        } else if Type == ParseStata.Error {
            status.OName = sSub.OName
            status.CName = sSub.CName
            status.ContentText = sSub.ContentText
            status.Content = nil
            status.Errors.append("Error: " + TokenContent + "  @(\(TokenPos.0):\(TokenPos.1))")
            if nextHasContent || selfHasNext {
                status.Errors.append("Error: \(Type) brothers ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            if subHasContent || selfHasSub {
                status.Errors.append("Error: \(Type) sons ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
        } else if Type == ParseStata.EoF {
            status.OName = sSub.OName
            status.CName = sSub.CName
            status.ContentText = sSub.ContentText
            status.Content = nil
            if nextHasContent || selfHasNext {
                status.Errors.append("Error: \(Type) brothers ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            if subHasContent || selfHasSub{
                status.Errors.append("Error: \(Type) sons ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
        } else if Type == ParseStata.ø {
            status.OName = sSub.OName
            status.CName = sSub.CName
            status.ContentText = sSub.ContentText
            status.Content = nil
            if nextHasContent || selfHasNext {
                status.Errors.append("Error: \(Type) brothers ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            if subHasContent || selfHasSub {
                status.Errors.append("Error: \(Type) sons ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
        } else {
            status.OName = "."
            status.CName = ".."
            status.ContentText = ""
            status.Content = nil
            status.Errors.append("Error: Unrecognised node \(Type):\(TokenContent) @(\(TokenPos.0):\(TokenPos.1))")
            if nextHasContent || selfHasNext {
                status.Errors.append("Error: \(Type) brothers ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            if subHasContent || selfHasSub {
                status.Errors.append("Error: \(Type) sons ignored @(\(TokenPos.0):\(TokenPos.1))")
            }
            status.Errors = status.Errors + sSub.Errors + sNext.Errors
        }
        
        if Type == ParseStata.ONode  && false {
            Out.Write("Report:\n\(NodeType):\(TokenContent) @(\(TokenPos.0):\(TokenPos.1))")
            Out.Write("\(status.Report())\n")
        }
        return status
    }
    
    func GoSub() -> XmlTree? {
        var t:XmlTree?
        if self.Sub != nil {
            t = (self.Sub as! XmlTree)
        } else {
            t = nil
        }
        return t
    }

    func GoNext() -> XmlTree? {
        var t:XmlTree?
        if self.Next != nil {
            t = (self.Next as! XmlTree)
        } else {
            t = nil
        }
        return t
    }

    func ThisIs(_ NodeType:ParseStata, _ TokenContent:String) -> Bool {
        if self.NodeType == NodeType &&  self.TokenContent == TokenContent {
            return true
        }
        return false
    }
    
    func SubIs(_ NodeType:ParseStata, _ TokenContent:String) -> Bool {
        var t:XmlTree
        if self.Sub != nil {
            t = (self.Sub as! XmlTree)
        } else {
            return false
        }
        if t.NodeType == NodeType &&  t.TokenContent == TokenContent {
            return true
        }
        return false
    }

    func NextIs(_ NodeType:ParseStata, _ TokenContent:String) -> Bool {
        var t:XmlTree
        if self.Next != nil {
            t = (self.Next as! XmlTree)
        } else {
            return false
        }
        if t.NodeType == NodeType &&  t.TokenContent == TokenContent {
            return true
        }
        return false
    }

    func SubExists() -> Bool {
        if self.Sub != nil {
            return true
        }
        return false
    }
    
    func NextExists() -> Bool {
        if self.Next != nil {
            return true
        }
        return false
    }

    func CheckThisAndGoNext(_ NodeType:ParseStata, _ TokenContent:String) -> XmlTree? {
        var t:XmlTree?
        if ThisIs(NodeType, TokenContent) {
            t = GoNext()
        } else {
            t = nil
        }
        return t
    }
    
    func CheckThisAndGoSub(_ NodeType:ParseStata, _ TokenContent:String) -> XmlTree? {
        var t:XmlTree?
        if ThisIs(NodeType, TokenContent) {
            t = GoSub()
        } else {
            t = nil
        }
        return t
    }
    

}



class XmlTree:XmlParseTree {
    // simplify structure, check syntax
    
    init(){
        super.init(NodeType:ParseStata.ø, TokenContent:"", TokenPos:(0, 0))
    }
    

}

