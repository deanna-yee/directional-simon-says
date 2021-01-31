//
//  CurveCorner.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 1/26/21.
//  Copyright © 2021 cisstudent. All rights reserved.
//

import UIKit

@IBDesignable
class CurveCorner: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 10.0
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
        
    }
    
    func customizeView(){
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.25)
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 5.0
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

}
