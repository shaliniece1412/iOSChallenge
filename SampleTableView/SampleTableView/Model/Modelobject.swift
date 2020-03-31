//
//  Modelobject.swift
//  SampleTableView
//
//  Created by 922235 on 26/03/20.
//  Copyright © 2020 922235. All rights reserved.
//

import UIKit


public struct Modelobject {
    let title: String
    let imageHref: String
    let description: String
   
    init?(dict: [String: Any]) {
        self.title = dict["title"] as? String ?? ""
        self.imageHref = dict["imageHref"] as? String ?? ""
        self.description = dict["description"] as? String ?? ""
    }
}
