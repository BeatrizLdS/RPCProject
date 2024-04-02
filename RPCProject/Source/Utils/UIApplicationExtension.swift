//
//  UIApplicationExtension.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 02/04/24.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
