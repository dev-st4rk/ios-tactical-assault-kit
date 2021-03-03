//
//  Place.swift
//  ITAK
//
//  Created by Henrique Gonçalves Lourenço Silva on 02/03/21.
//

import SwiftUI
import MapKit

struct Place : Identifiable{
    
    var id = UUID().uuidString
    var place = CLPlacemark()
    
}
