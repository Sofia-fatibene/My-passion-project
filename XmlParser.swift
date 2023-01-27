//  XmlFile.swift
//  OS:XmlParser
//      requires: OS:Console
//
//  Created by Lorenzo Fatibene on 2019-09-11.
//  Copyright © 2019 Lorenzo Fatibene. All rights reserved.
//

import Foundation

struct Token {
    var TokenContent:String
    var TokenType:TerminalTokenStata
    var TokenPos:(Int, Int)
    
    init(TokenContent c:String, TokenType t:TerminalTokenStata, TokenPos p:(Int, Int)) {
        TokenContent = c
        TokenType = t
        TokenPos = p
    }
}



class XmlParser: InString {
    let ShiftTable:[String:Int]
    let ReduceTable:[String:Int]
    let GoToTable:[String:Int]
    let Rules:[(lhs: ParseStata, rhs: [ParseStata])]
    
    override init(_ s:String = ""){
        ShiftTable = XmlParser.ShiftTableXmlSimple()
        ReduceTable = XmlParser.ReduceTableXmlSimple()
        GoToTable = XmlParser.GoToTableXmlSimple()
        Rules = XmlParser.RuleListXmlSimple()
        super.init(s)
    }

    private static func ShiftTableXmlSimple() -> [String:Int] {
        let Table:[String:Int] = [
            //
            ("\(TerminalParseStata.OTag),\(0)"):10,
            ("\(TerminalParseStata.EoF),\(0)"):-1,
            //
            ("\(TerminalParseStata.Text),\(1)"):17,
            ("\(TerminalParseStata.String),\(1)"):18,
            //
            ("\(TerminalParseStata.Text),\(10)"):11,
            //
            ("\(TerminalParseStata.CTag),\(12)"):15,
            ("\(TerminalParseStata.BCTag),\(12)"):13,
            //
            ("\(TerminalParseStata.OTag),\(20)"):10,
            ("\(TerminalParseStata.OBTag),\(20)"):30,
            //
            ("\(TerminalParseStata.Text),\(30)"):31,
            //
            ("\(TerminalParseStata.CTag),\(32)"):33
        ]
        return Table
    }
    
    private static func ReduceTableXmlSimple() -> [String:Int] {
        let Table:[String:Int] = [
            //
            ("\(TerminalParseStata.OTag),\(1)"):7,
            ("\(TerminalParseStata.OBTag),\(1)"):7,
            //
            ("\(TerminalParseStata.OTag),\(2)"):0,
            ("\(TerminalParseStata.OBTag),\(2)"):0,
            ("\(TerminalParseStata.EoF),\(2)"):0,
            //
            ("\(TerminalParseStata.OTag),\(3)"):1,
            ("\(TerminalParseStata.OBTag),\(3)"):1,
            ("\(TerminalParseStata.EoF),\(3)"):1,
            //
            ("\(TerminalParseStata.CTag),\(11)"):2,
            ("\(TerminalParseStata.BCTag),\(11)"):2,
            //
            ("\(TerminalParseStata.OTag),\(13)"):6,
            ("\(TerminalParseStata.OBTag),\(13)"):6,
            ("\(TerminalParseStata.EoF),\(13)"):6,
            //
            ("\(TerminalParseStata.Text),\(15)"):3,
            ("\(TerminalParseStata.String),\(15)"):3,
            ("\(TerminalParseStata.OTag),\(15)"):3,
            ("\(TerminalParseStata.OBTag),\(15)"):3,
            //
            ("\(TerminalParseStata.OTag),\(17)"):8,
            ("\(TerminalParseStata.OBTag),\(17)"):8,
            //
            ("\(TerminalParseStata.OTag),\(18)"):9,
            ("\(TerminalParseStata.OBTag),\(18)"):9,
            //
            ("\(TerminalParseStata.OTag),\(21)"):10,
            ("\(TerminalParseStata.OBTag),\(21)"):10,
            //
            ("\(TerminalParseStata.CTag),\(31)"):2,
            //
            ("\(TerminalParseStata.OTag),\(33)"):4,
            ("\(TerminalParseStata.OBTag),\(33)"):4,
            ("\(TerminalParseStata.EoF),\(33)"):4,
            //
            ("\(TerminalParseStata.OTag),\(34)"):5,
            ("\(TerminalParseStata.OBTag),\(34)"):5,
            ("\(TerminalParseStata.EoF),\(34)"):5
        ]
        return Table
    }
    
    private static func GoToTableXmlSimple() -> [String:Int] {
        let Table:[String:Int] = [
            //
            ("\(NonTerminalParseStata.Node),\(0)"):-2,
            ("\(NonTerminalParseStata.ONode),\(0)"):1,
            ("\(NonTerminalParseStata.OCNode),\(0)"):2,
            ("\(NonTerminalParseStata.ANode),\(0)"):3,
            //
            ("\(NonTerminalParseStata.Content),\(1)"):20,
            //
            ("\(NonTerminalParseStata.Name),\(10)"):12,
            //
            ("\(NonTerminalParseStata.Node),\(20)"):21,
            ("\(NonTerminalParseStata.ONode),\(20)"):1,
            ("\(NonTerminalParseStata.OCNode),\(20)"):2,
            ("\(NonTerminalParseStata.CNode),\(20)"):34,
            ("\(NonTerminalParseStata.ANode),\(20)"):3,
            //
            ("\(NonTerminalParseStata.Name),\(30)"):(32)
        ]
        return Table
    }
    
    private static func RuleListXmlSimple() -> [(lhs: ParseStata, rhs: [ParseStata])] {
        return [
            (ParseStata.Node,    [ParseStata.OCNode]),
            (ParseStata.Node,    [ParseStata.ANode]),
            (ParseStata.Name,    [ParseStata.Text]),
            (ParseStata.ONode,   [ParseStata.OTag,      ParseStata.Name,        ParseStata.CTag]),
            (ParseStata.CNode,   [ParseStata.OBTag,     ParseStata.Name,        ParseStata.CTag]),
            (ParseStata.OCNode,  [ParseStata.ONode,     ParseStata.Content,     ParseStata.CNode]),
            (ParseStata.ANode,   [ParseStata.OTag,      ParseStata.Name,        ParseStata.BCTag]),
            (ParseStata.Content, []),
            (ParseStata.Content, [ParseStata.Text]),
            (ParseStata.Content, [ParseStata.String]),
            (ParseStata.Content, [ParseStata.Content,   ParseStata.Node])
        ]
    }

// Scanner
//                 (Char,   Type)
    func Scan() -> (String, TerminalScanStata) { // it returns the first atom on stream, being it
        //                  (Action,NewStatus)
        let ARules:[String:(Int, ScanStata)] = [
            
            //     Root       EoF   ->  0   EoF.
            //                &     ->  1   Amp
            //                WS    ->  1   Space.
            //                      ->  1   Char.
            ("\(ScanStata.Root):EoF"):(0, ScanStata.EoF),
            ("\(ScanStata.Root):&"):(1, ScanStata.Amp),
            ("\(ScanStata.Root):Space"):(1, ScanStata.Space),
            ("\(ScanStata.Root)."):(1, ScanStata.Char),
            
            //  Amp         EoF -> -1   Error.
            //              WS  ->  1   Error.
            //          Letter  ->  1   Amp
            //              ;   ->  1   Seq.
            //                  -> -1   Error.
            ("\(ScanStata.Amp):;"):(1, ScanStata.Seq),
            ("\(ScanStata.Amp):Space"):(1, ScanStata.Error),
            ("\(ScanStata.Amp):Letter"):(1, ScanStata.Amp),
            ("\(ScanStata.Amp)."):(-1, ScanStata.Error)
        ]                                                           //  [8] Rules
        //  Terminals       [3]     Space   Seq     Char
        //  Errors          [2]     EoF     Error
        //  Internals       [2]     Root    Amp

        var c:String
        var ReturnVal = ""
        var TypeVal:ScanStata
        var Status = ScanStata.Root

        var Action:Int
        var NewStatus:ScanStata

        let (ILine, ICount) = StampPos()
        while Status.rawValue > 0 {
            if  Buffer.count == 0, let Rule = ARules["\(Status):EoF"] {               // Check EoF
                (Action, NewStatus) = Rule
                c = ""
            } else {
                c = GetOne()
                if IsSpace(c), let Rule = ARules["\(Status):Space"] {               // First check CharClasses
                    (Action, NewStatus) = Rule
                } else if IsLetter(c), let Rule = ARules["\(Status):Letter"] {
                    (Action, NewStatus) = Rule
                } else if let Rule = ARules["\(Status):\(c)"] {                     // Then single characters
                    (Action, NewStatus) = Rule
                } else if let Rule = ARules["\(Status)."]  {                        // Finally else clauses
                    (Action, NewStatus) = Rule
                } else {        // This should not happen
                    let (OLine, OCount) = StampPos()
                    Out.Write("Error: Scan rules are incomplete, it should not happen, but it did between (\(ILine):\(ICount)) and (\(OLine):\(OCount))")
                    Action = 0
                    ReturnVal = ""
                    NewStatus = ScanStata.Error
                }
            }
            if Action == -1 {
                PushBack(c)      //  PushBack(c)
            } else if Action == 1 {
                ReturnVal += c         // Save
            } else {                   // Drop
            }
            Status = NewStatus
        }
        TypeVal = Status
        if TypeVal == ScanStata.Error {
            let (OLine, OCount) = StampPos()
            Out.Write("Error: Character unknown between (\(ILine):\(ICount)) and (\(OLine):\(OCount) scanning Line \(LastLine)")
            ReturnVal = ""
        }
        return (ReturnVal, TerminalScanStata(rawValue: TypeVal.rawValue)!)
    }

    
    
// Tokenizer
    //                 (Content,   Type  )
    //func GetToken() -> (String, TerminalTokenStata) {
    func GetToken() -> Token {
        //   (OldStatus, c):(PushBack, NewStatus)
        let ARules:[String:(Int, TokenStata)] = [
             //Tokenizer   ->
             // Root       Eof  ->  0   EoF.            EoF
             //             >   ->  0   CTag.           >
             //             =   ->  0   Eq.             =
             //          Space  ->  0    Root
             //             <   ->  0    GetOTag
             //             "   ->  0    GetDQStr
             //             '   ->  0    GetSQStr
             //             /   ->  0    GetBCTag
             //                 ->  1    GetText
            ("\(TokenStata.Root):EoF"):(0, TokenStata.EoF),     // exit
            ("\(TokenStata.Root):Space"):(0, TokenStata.Root),
            ("\(TokenStata.Root):>"):(0, TokenStata.CTag),      // exit
            ("\(TokenStata.Root):="):(0, TokenStata.Eq),        // exit
            ("\(TokenStata.Root):<"):(0, TokenStata.GetOTag),
            ("\(TokenStata.Root):\""):(0, TokenStata.GetDQStr),
            ("\(TokenStata.Root):'"):(0, TokenStata.GetSQStr),
            ("\(TokenStata.Root):/"):(0, TokenStata.GetBCTag),
            ("\(TokenStata.Root)."):(1, TokenStata.GetText),

                        // r = <
             // GetOTag    Eof  -> -1   OTag.           <
             //             !   ->  0    OI
             //             ?   ->  0   ODir.           <?
             //             /   ->  0   OBTag.          </
             //                 -> -1   OTag.           <
            ("\(TokenStata.GetOTag):EoF"):(0, TokenStata.OTag),     // exit     // else
            ("\(TokenStata.GetOTag):/"):(0, TokenStata.OBTag),      // exit
            ("\(TokenStata.GetOTag)."):(-1, TokenStata.OTag),       // exit

                        //  r = "
             // GetDQStr   EoF  ->  0   Error.
             //             "   ->  0   String.         "..."
             //                 ->  1    GetDQStr
            ("\(TokenStata.GetDQStr):EoF"):(0, TokenStata.Error),   // exit
            ("\(TokenStata.GetDQStr):\""):(0, TokenStata.String),   // exit
            ("\(TokenStata.GetDQStr)."):(1, TokenStata.GetDQStr),

                        //  r = '
             // GetSQStr   EoF  ->  0   Error.
             //             '   ->  0   String.         '...'
             //                 ->  1    GetSQStr
            ("\(TokenStata.GetSQStr):EoF"):(0, TokenStata.Error),   // exit
            ("\(TokenStata.GetSQStr):'"):(0, TokenStata.String),    // exit
            ("\(TokenStata.GetSQStr)."):(1, TokenStata.GetSQStr),

                        //  r = /
             // GetBCTag   EoF  ->  0   Error.
             //             >   ->  0   BCTag.          />
             //                 -> -1   Error.
            ("\(TokenStata.GetBCTag):EoF"):(0, TokenStata.Error),   // exit     // else
            ("\(TokenStata.GetBCTag):>"):(0, TokenStata.BCTag),     // exit
            ("\(TokenStata.GetBCTag)."):(-1, TokenStata.Error),     // exit

             // GetText    EoF  ->  0   Text.          qweerty
             //          Space  ->  0   Text.
             //         Special -> -1   Text.
             //                 ->  1    GetText
            ("\(TokenStata.GetText):EoF"):(0, TokenStata.Text),     // exit
            ("\(TokenStata.GetText):Space"):(0, TokenStata.Text),   // exit
            ("\(TokenStata.GetText):Special"):(-1, TokenStata.Text),// exit
            ("\(TokenStata.GetText)."):(1, TokenStata.GetText)
        ]                                                                           // 44 rules
        // Token Terminal       [7]    Text    Eq      String      OTag        CTag        OBTag       BCTag
        // Errors               [2]    Error   EoF
        // Non Terminal         [6]    Root    GetDQString     GetSQString     GetBCTag        GetOTag     GetText

        var c:String
        var cType:TerminalScanStata
        var ReturnVal = ""
        var TypeVal:TokenStata
        var Status = TokenStata.Root
        var Pos:(Int, Int) = (-1, -1)

        var Action:Int
        var NewStatus:TokenStata

        // From Scan ->    (c,cType):    ("c", Space)   ("&amp;", Seq)   ("c",Char)   ("", EoF)     ("", Error)
        Pos = self.StampPos()
        while Status.rawValue > 0 {
            (c, cType) = Scan()
            // intercetta ("", Error)
            //Scan consuma almeno un charattere quindi report e riprova
            
            if cType == TerminalScanStata.EoF, let Rule = ARules["\(Status):EoF"] {     // First check Classes
                (Action, NewStatus) = Rule
            } else if cType == TerminalScanStata.Space, let Rule = ARules["\(Status):Space"] {
                (Action, NewStatus) = Rule
            } else if IsSpecial(c), let Rule = ARules["\(Status):Special"] {
                (Action, NewStatus) = Rule
            } else if let Rule = ARules["\(Status):\(c)"] {                     // Then Singles
                (Action, NewStatus) = Rule
            } else if let Rule = ARules["\(Status)."] {                         // Finally Else clauses
                (Action, NewStatus) = Rule
            } else {
                print("Rules are incomplete, it should not happen")
                Action = 0
                ReturnVal = ""
                NewStatus = TokenStata.Error
            }
            
            if Action == -1 {
                PushBack(c)       //  PushBack(c)
            } else if Action == 1 {
                ReturnVal += c         // Save
            } else {                   // Drop  Action == 0
            }
            Status = NewStatus
        }   // end while
        TypeVal = Status
        if TypeVal == TokenStata.Error {
            //print("Error Scanning '\(s)' = '\(ReturnVal)' < '\(Tail)'")     // eventually delegate message
            ReturnVal = ""
        }
        //return (ReturnVal, TerminalTokenStata(rawValue: TypeVal.rawValue)!)
        return Token(TokenContent: ReturnVal, TokenType:TerminalTokenStata(rawValue: TypeVal.rawValue)!, TokenPos:Pos)
    }   //  Checked
    
    //              Tree
    func Parse() -> XmlParseTree {
       return SimpleParse()

    }
    
    func ParseAndNormal() -> XmlTree {
        let R = Parse()
        return R.Normal()
    }
    
    private func SimpleParse() -> XmlParseTree {
        // initialize stack
        var IPos = StampPos()
        var Tree = XmlParseTree(NodeType:ParseStata.ø, TokenContent:"", TokenPos:IPos)
        var Status = 0, NewStatus = -1
        var Stack = [(Tree, Status)]
        
        var TokContent:String
        var TokType:TerminalTokenStata
        var TokPos:(Int, Int)
        var T = GetToken()
        IPos = T.TokenPos
        (TokContent, TokType, TokPos) = (T.TokenContent, T.TokenType, T.TokenPos)
        
        var ItemType:TerminalParseStata
        while Status >= 0 {
            if TokType == TerminalTokenStata.Error {    //TerminalParseStata
                ItemType = TerminalParseStata.EoF       // non serve
                Status = -4                             // Unknown Token
            } else {
                ItemType = TerminalParseStata(rawValue: TokType.rawValue)!
                if let Shift = ShiftTable["\(ItemType),\(Status)"] {
                    // se troviamo una regola di shift
                    Status = Shift
                    Stack.append((XmlParseTree(NodeType:ParseStata(rawValue:TokType.rawValue)!, TokenContent:TokContent, TokenPos:TokPos), Status))
                    T = GetToken()
                    (TokContent, TokType, TokPos) = (T.TokenContent, T.TokenType, T.TokenPos)
                } else if let Rule = ReduceTable["\(ItemType),\(Status)"] {
                    // Se troviamo una regola di reduce -> GoTo
                    var (LHS, RHS) = Rules[Rule]
                    let RuleRoot = XmlParseTree(NodeType:LHS, TokenContent: "", TokenPos:TokPos)
                    // In realtà per RuleRoot.TokenPos =  vorrei la posizione del primo token
                    while RHS.count > 0 {
                        let RuleLastItem = RHS.removeLast()
                        let (StackLastItem, _) = Stack.removeLast()
                        if RuleLastItem == StackLastItem.NodeType {
                            RuleRoot.Append(SubLeft: StackLastItem)
                            RuleRoot.TokenPos = StackLastItem.TokenPos
                        } else {
                            let (ILine, ICount) = IPos
                            let (OLine, OCount) = StampPos()
                            Out.Write("Error: Syntax rules are inconsistent. I tried to reduce a rule which was not in Stack.")
                            Out.Write(" between (\(ILine):\(ICount)) and (\(OLine):\(OCount) scanning Line \(LastLine)")
                        }
                    }
                    // if ok
                    if let (_, newStatus) = Stack.last {
                        NewStatus = newStatus
                        RuleRoot.NodeType = LHS
                        RuleRoot.TokenContent = ""
                    } else {
                        let (ILine, ICount) = IPos
                        let (OLine, OCount) = StampPos()
                        Out.Write("Error: Empty Stack ")
                        Out.Write(" between (\(ILine):\(ICount)) and (\(OLine):\(OCount) scanning Line \(LastLine)")
                    }
                    if let NewStatus = GoToTable["\(LHS),\(NewStatus)"] {
                        //  #  ->  \(NewStatus)")
                        Stack.append((RuleRoot, NewStatus))
                        Status = NewStatus
                    } else {
                        let (ILine, ICount) = IPos
                        let (OLine, OCount) = StampPos()
                        Out.Write("Error: Inconsistent GoTo Table")
                        Out.Write(" between (\(ILine):\(ICount)) and (\(OLine):\(OCount) scanning Line \(LastLine)")
                    }
                } else {
                    Status = -3 // Unexpected Token
                }
            }
        }   // end while
        if Status == -3 {   //  Errore
            let (Line, Count) = TokPos
            Out.Write("Unexpected token [\(TokType):\(TokContent)] at (\(Line):\(Count))")
            Tree = XmlParseTree(NodeType:ParseStata.Error, TokenContent:"Unexpected token", TokenPos:TokPos)
        } else if Status == -4 {   //  Errore
            let (Line, Count) = TokPos
            Out.Write("Unknown token [\(TokType):\(TokContent)] at (\(Line):\(Count))")
            Tree = XmlParseTree(NodeType:ParseStata.Error, TokenContent:"Unknown token", TokenPos:TokPos)
        } else {
            (Tree, _) = Stack.removeLast()
            if Stack.count > 1 {
                Out.Write("Error: \(Stack.count-1) items left on Stack")
            }
        }
        return Tree
    }
    
    func TestScan() {
        while(!self.IsEmpty()) {
            let (c, t) = self.Scan()
            Out.Write("\(t):\(c)\n")
        }

    }
    
    func TestTokenizer() {
        while(!self.IsEmpty()) {
            let Tok = self.GetToken()
            // Out.Write("\(Tok.TokenType):\(Tok.TokenContent)\n")
            Out.Write("\(Tok.TokenType):\(Tok.TokenContent) @\(Tok.TokenPos)\n")
        }

    }
    
}   // End of class XmlParser


