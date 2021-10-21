//
//  ViewController.swift
//  AjaibPokemonProject
//
//  Created by Yudis Huang on 19/10/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    private let spacing:CGFloat = 8.0
    
    //dummy data
    private var items = ["007","jungle","shangchi"]
    //dummy data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonCollectionView.register(PokemonCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonCollectionViewCell.cellName())
        
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.delegate = self
        //        pokemonCollectionView.sizeToFit()
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
        
        addConstraints()
    }
    
    
    private func addConstraints() {
        
        self.pokemonCollectionView.snp.makeConstraints{ make in
            //            make.trailing.top.width.equalToSuperview()
            //            make.width.top.equalToSuperview()
            //            make.height.equalToSuperview()
            //            make.width.equalToSuperview()
            //            make.leadingMargin.equalTo(16)
            //            make.trailingMargin.equalTo(16)
            //            make.topMargin.equalTo(10)
            //            make.bottomMargin.equalTo(10)
            
            
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            
            
            //            make.leading.equalToSuperview().offset(16)
            //            make.trailing.equalToSuperview().offset(-16)
            //            make.top.equalTo(10)
            //            make.bottom.equalTo(-10)
            
        }
    }
}

// MARK: - Collection View Delegate
extension ViewController: UICollectionViewDelegate {}

// MARK: - Collection View Data Source
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as! PokemonCollectionViewCell
        cell.setImage(image: UIImage(named: items[indexPath.row]))
        return cell
    }
}

// MARK: - Collection View Delegate Flow Layout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 0
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.pokemonCollectionView {
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            
            return CGSize(width: width, height: (width / 2) * 3)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
}
