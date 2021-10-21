//
//  PokemonCollectionViewCell.swift
//  AjaibPokemonProject
//
//  Created by Yudis Huang on 20/10/21.
//

import UIKit
import SnapKit

class PokemonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imagePokemon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setImageConstraints()
    }
    
    static func nib() -> UINib { UINib(nibName: "PokemonCollectionViewCell", bundle: nil) }
    
    static func cellName() -> String { "PokemonCollectionViewCell" }
    
    private func setImageConstraints() {
        self.imagePokemon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func setImage(image: UIImage?) {
        imagePokemon.image = image
    }
}
