//
//  UIKitHelper.swift
//  AjaibPokemonProject
//
//  Created by Yudis Huang on 20/10/21.
//

import Foundation
import UIKit

func getLabel(with frame: CGRect = .zero, title: String = "demo label")-> UILabel {
    let lable = UILabel(frame: frame)
    
    lable.text = title
    lable.textColor = .black
    lable.textAlignment = .center
    return lable
}
