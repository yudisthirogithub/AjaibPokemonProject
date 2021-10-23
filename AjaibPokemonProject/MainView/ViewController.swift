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

    private var pokemonsStorage = [Model]()
    private var filteredData = [Model]()
    
    private var name : String!
    private var subtypes : [String]!
    private var types : [String]!
    private var flavorText : String!
    private var images : String!
    private var hp : String!
    
    
    // MARK: - Outlets
        private var navBar : UINavigationBar = {
            let navbar = UINavigationBar()
            navbar.translatesAutoresizingMaskIntoConstraints = false
            return navbar
        }()
        
        private var searchPokemonBar : UISearchBar = {
            let searchpokemonbar = UISearchBar()
            searchpokemonbar.translatesAutoresizingMaskIntoConstraints = false
            searchpokemonbar.barTintColor = .gray
            searchpokemonbar.backgroundColor = .black
            return searchpokemonbar
        }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Backgroundcolor
        navBar.backgroundColor = navBackgroundColor
        pokemonCollectionView.backgroundColor = .clear
        

        
        view.addSubview(navBar)
        view.addSubview(searchPokemonBar)
        
        
        pokemonCollectionView.register(PokemonCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonCollectionViewCell.cellName())
        
        //API Stuffs
        setupAPI()
        
        addConstraints()
        
        
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.delegate = self
        searchPokemonBar.delegate = self
        pokemonCollectionView.reloadData()
    }
    
    
    private func setupAPI(){
        ServiceAPI.shared.getResults{ result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let results):
                    
                    for result in results.data {
                        let pokemons = Model()
                        pokemons.name = result.name
                        pokemons.types = result.types
                        pokemons.subtypes = result.subtypes
                        pokemons.flavorText = result.flavorText
                        pokemons.images = result.images.small
                        pokemons.hp = result.hp
                        self?.pokemonsStorage.append(pokemons)
                    }
                case .failure(let error):
                    print(error)
                }
                self?.pokemonCollectionView.reloadData()
            }
        }
    }
    
    private func addConstraints() {
        
        self.navBar.snp.makeConstraints{
            make in
            make.width.equalToSuperview()
            make.height.equalTo(100)
        }
        
        self.searchPokemonBar.snp.makeConstraints{ make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(navBar.snp.bottomMargin).inset(18)
            make.bottom.equalTo(navBar)
        }
        
        self.pokemonCollectionView.snp.makeConstraints{ make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(108)
            make.bottom.equalTo(-10)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []

        if searchText == ""{
            filteredData = pokemonsStorage
        }else{
            for name in pokemonsStorage {
                if name.name!.lowercased().contains(searchText.lowercased()){
                    filteredData.append(name)
                }
            }
        }

        self.pokemonCollectionView.reloadData()
    }
    
    
    // MARK: -Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let destinationVC = segue.destination as! DetailViewController
        
        destinationVC.details.name = name
        destinationVC.details.flavorText = flavorText
        destinationVC.details.hp = hp
        destinationVC.details.types = types
        destinationVC.details.subtypes = subtypes
        destinationVC.details.images = images
        
//        detailView.details.name =
//        detailView.details.types = filteredData[indexPath.row].types
//        detailView.details.hp = filteredData[indexPath.row].hp
//        detailView.details.subtypes = filteredData[indexPath.row].subtypes
//        detailView.details.flavorText = filteredData[indexPath.row].flavorText
//        detailView.details.images = filteredData[indexPath.row].images
    }
}




// MARK: - Collection View Delegate
extension ViewController: UICollectionViewDelegate {}

// MARK: - Collection View Data Source
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return pokemonsStorage.count
            return filteredData.count
 
     
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as! PokemonCollectionViewCell
        
            ImageLoaderService.shared.getImage(urlString: filteredData[indexPath.row].images!) { (data, error) in
                if error != nil {
                    cell.setImage(image: UIImage(named: "jungle"))
                    return
                }
                cell.setImage(image: UIImage(data: data!))
            }
            
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(filteredData[indexPath.row].name)
        
        let detailView = DetailViewController()
        
        name = filteredData[indexPath.row].name
        types = filteredData[indexPath.row].types
        hp = filteredData[indexPath.row].hp
        subtypes = filteredData[indexPath.row].subtypes
        flavorText = filteredData[indexPath.row].flavorText
        images = filteredData[indexPath.row].images
        
        performSegue(withIdentifier: "goToDetail", sender: self)
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

// MARK: - UI Search Bar Delegate
extension ViewController : UISearchBarDelegate {}

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

