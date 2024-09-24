//
//  UIApplication.swift
//  SportScore
//
//  Created by Vladyslav Mi on 30.05.2024.
//

import Foundation

import Foundation
import SwiftUI

extension UIApplication{
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder),to : nil , from : nil , for : nil)
    }
}
