//
//  Card.swift
//  mtg_waff
//
//  Created by Usuário Convidado on 04/11/14.
//  Copyright (c) 2014 WAFF Magic. All rights reserved.
//

import Foundation
import CoreData

class Card: NSManagedObject {

    @NSManaged var edicao: String
    @NSManaged var nome: String
    @NSManaged var id: NSNumber
    @NSManaged var imgpath: String

}
