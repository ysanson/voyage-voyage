//
//  VoyageSet.swift
//  Voyage Voyage
//
//  Created by DSI on 18/03/2019.
//  Copyright © 2019 Yvan Sanson. All rights reserved.
//

import Foundation

class TravelSet: Sequence{
    fileprivate var travels = Set<Travel>()
    
    init(){}
    init(voyages: [Travel]){
        self.travels = Set<Travel>(voyages)
    }
    
    func isEmpty()->Bool{
        return travels.isEmpty
    }
    
    func add(voyage: Travel){
        if(!travels.contains(voyage)){
            travels.insert(voyage)
        }
    }
    
    func remove(voyage: Travel){
        if(travels.contains(voyage)){
            travels.remove(voyage)
        }
    }
    
    public func makeIterator() -> ItTravelSet {
        return ItTravelSet(set: self)
    }
    
}
struct ItTravelSet: IteratorProtocol{
    typealias Element = Travel
    
    private var iterator: SetIterator<Travel>
    private var set: TravelSet
    private var curr: Travel?
    
    fileprivate init(set: TravelSet){
        iterator = set.travels.makeIterator()
        self.set = set
    }
    
    mutating func next() -> Travel?{
        curr = iterator.next()
        return curr
    }
    
    mutating func reset(){
        iterator = set.travels.makeIterator()
    }
    
    func current() -> Travel?{
        return curr
    }
}
