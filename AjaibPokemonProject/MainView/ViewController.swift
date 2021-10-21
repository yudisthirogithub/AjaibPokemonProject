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
    private let Backgroundcolor = UIColor(hexString: "#1A202C")
    private let navBackgroundColor = UIColor(hexString: "#161B22")
    
    
    
    private var navBar : UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        
        return navbar
    }()
    
    private var searchPokemonBar : UISearchBar = {
        let searchpokemonbar = UISearchBar()
        searchpokemonbar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchpokemonbar
    }()
    
    //dummy data
    private var items = ["007","jungle","shangchi"]
    //dummy data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Backgroundcolor
        navBar.backgroundColor = navBackgroundColor
        
        view.addSubview(navBar)
        
        
        
        pokemonCollectionView.register(PokemonCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonCollectionViewCell.cellName())
        

        
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.delegate = self
    
        //API Stuffs
        ServiceAPI.shared.getResults(pokemonName: "Pikachu") { result in
            switch result {
            case .success(let results):
//                print(results)
                
                var pokemons = Model()
                
                for i in 0...5{
                    pokemons.name = results.data[i].name
                    pokemons.types = results.data[i].types
                    pokemons.subtypes = results.data[i].subtypes
  
                    print("\(pokemons.name) + \(pokemons.types) + \(pokemons.subtypes)")
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        addConstraints()
        pokemonCollectionView.backgroundColor = .clear
    }
    
    
    private func addConstraints() {
        
        self.navBar.snp.makeConstraints{
            make in
            make.width.equalToSuperview()
            make.height.equalTo(100)
        }
        
//        self.searchPokemonBar.snp.makeConstraints{
//            make in
////            make.leading.equalTo(16)
////            make.trailing.equalTo(-16)
//            make.top.equalTo(self.navBar.snp.height).offset(10)
//
//        }
        
        self.pokemonCollectionView.snp.makeConstraints{ make in
//            make.leading.equalTo(16)
//            make.trailing.equalTo(-16)
//            make.top.equalTo(10)
//            make.bottom.equalTo(-10)
            
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(108)
            make.bottom.equalTo(-10)
            

            
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

// MARK: - Extension for UIColor using HEX Code
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
