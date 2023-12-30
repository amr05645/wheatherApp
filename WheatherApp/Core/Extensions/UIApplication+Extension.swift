//
//  UIApplication+Extension.swift
//  WheatherApp
//
//  Created by Amr Hassan on 30/12/2023.
//

import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
