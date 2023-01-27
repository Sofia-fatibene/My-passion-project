//
//  Tree.swift
//  OS:XmlParser
//
//  Created by Lorenzo Fatibene on 2019-09-21.
//  Copyright © 2019 Lorenzo Fatibene. All rights reserved.
//

import Foundation


class Tree {
    var Sub:Tree? = nil
    var Next:Tree? = nil
    
    init() {}
    
    func Append(SubLeft subtree:Tree) {
        subtree.Append(Next: Sub)
        Sub = subtree
    }
    func Append(SubRight subtree:Tree) {
        
    }

    func Append(Next nexttree:Tree? = nil, Sub subtree:Tree? = nil) {
        if nexttree != nil {
            if Next == nil {
                Next = nexttree
            } else {
                Next!.Append(Next: nexttree)
            }
        }
        if subtree != nil {
            if Sub == nil {
                Sub = subtree
            } else {
                Sub!.Append(Next: subtree)
            }
        }
    }
    
}
