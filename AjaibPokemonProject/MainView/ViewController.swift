//
//  ViewController.swift
//  AjaibPokemonProject
//
//  Created by Yudis Huang on 19/10/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    //dummy data
    var items = ["007","jungle","shangchi"]
    //dummy data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: "PokemonCollectionViewCell", bundle: nil)
        pokemonCollectionView.register(nibCell, forCellWithReuseIdentifier: "PokemonCollectionViewCell")

        addConstraints()
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.delegate = self
        pokemonCollectionView.sizeToFit()
//        pokemonCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17)
        
        //API Stuffs
        ServiceAPI.shared.getResults(pokemonName: "Pikachu") { result in
            switch result {
            case .success(let results):
            print(results)
                
            case .failure(let error):
            print(error)
            }
        }
       
    }
    

    private func addConstraints(){
    
    
        self.pokemonCollectionView.snp.makeConstraints{ [weak self] (make) in
            guard let self = self else {return}
//            make.trailing.top.width.equalToSuperview()
//            make.width.top.equalToSuperview()
            make.height.width.equalToSuperview()
//            make.leading.trailing.equalToSuperview().offset(16)
    }
        
        
}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as! PokemonCollectionViewCell
        
        cell.imagePokemon.image = UIImage(named: items[indexPath.row])
        
        return cell
    }

}
