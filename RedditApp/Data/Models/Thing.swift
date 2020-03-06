//
//  Thing.swift
//  RedditApp
//
//  Created by Manuel Munoz on 06/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import Foundation

struct Thing<T: Decodable>: Decodable {
    let id: String?
    let name: String?
    let kind: ThingKind
    let data: T
}

enum ThingKind: String, Decodable {
    case Listing
    case t1
    case t2
    case t3
    case more
}
