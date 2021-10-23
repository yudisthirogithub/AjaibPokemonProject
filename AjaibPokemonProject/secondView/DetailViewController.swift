//
//  DetailViewController.swift
//  AjaibPokemonProject
//
//  Created by Yudis Huang on 22/10/21.
//

import UIKit

class DetailViewController: UIViewController {

    var details = Model()
    
    var name : String!
    var subtypes : String!
    var types : String!
    var flavorText : String!
    var images : String!
    var hp : String!
    
    // MARK: - Outlets
    private var navBar : UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.backgroundColor = .gray
        let navItem = UINavigationItem()
        let doneItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(exit) )
        navItem.leftBarButtonItem = doneItem
        navbar.setItems([navItem], animated: false)
        return navbar
        
    }()
    
    @objc private func exit(){
        print("Test")
        self.dismiss(animated: true)
    }
 
    
    private var pokemonImage : UIImageView = {
        let pokemonimage = UIImageView()
        return pokemonimage
    }()
    
    private var pokemonName : UILabel = {
        let pokemonname = UILabel()
        pokemonname.font.withSize(12)
        return pokemonname
    }()
    
    private var pokemonType : UILabel = {
        let pokemontype = UILabel()
        pokemontype.font.withSize(12)
        return pokemontype
    }()
    
    private var flavor : UILabel = {
        let flavor = UILabel()
        flavor.text = "Flavor :"
        flavor.font.withSize(20)
        return flavor
    }()
    
    private var pokemonSubType : UILabel = {
        let pokemonsubtype = UILabel()
        pokemonsubtype.font.withSize(12)
        return pokemonsubtype
    }()
    
    private var pokemonHp : UILabel = {
        let pokemonhp = UILabel()
        pokemonhp.font.withSize(12)
        return pokemonhp
    }()
    
    private var pokemonFlavorText : UILabel = {
        let pokemonflavortext = UILabel()
        pokemonflavortext.font?.withSize(12)
        pokemonflavortext.sizeToFit()
        return pokemonflavortext
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


//        pokemonImage.image = UIImage(named: images)!
        getImageFromMain(string: details.images!)
        pokemonName.text = details.name
        pokemonType.text = details.types![0]
        pokemonSubType.text = details.subtypes![0]
        pokemonFlavorText.text = details.flavorText
        pokemonHp.text = details.hp
        
    
//        view.backgroundColor = Backgroundcolor
//        navBar.backgroundColor = navBackgroundColor
        addAllView()
        
        // Do any additional setup after loading the view.
    }
    
    private func getImageFromMain(string : String){
        ImageLoaderService.shared.getImage(urlString: string ) { (data, error) in
            if error != nil {
                self.pokemonImage.image = UIImage(named: "jungle")
                return
            }
            self.pokemonImage.image = UIImage(data: data!)
//            cell.setImage(image: UIImage(data: data!))
        }
        
    }
    
    private func addAllView(){
        self.view.addSubview(navBar)
        
        self.navBar.snp.makeConstraints{make in
            make.height.equalTo(100)
            make.width.equalToSuperview()
        }
        
        self.view.addSubview(pokemonImage)
        
        self.pokemonImage.snp.makeConstraints{make in
            make.height.equalTo(275)
            make.width.equalTo(190)
            make.centerX.equalToSuperview()
            make.top.equalTo(navBar.snp.bottom).offset(8)
        }
        
        self.view.addSubview(pokemonName)

        self.pokemonName.snp.makeConstraints{make in
            make.top.equalTo(pokemonImage.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        
        self.view.addSubview(pokemonType)

        self.pokemonType.snp.makeConstraints{make in
            make.top.equalTo(pokemonName.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        self.view.addSubview(pokemonHp)
        
        self.pokemonHp.snp.makeConstraints{make in
            make.leading.equalTo(pokemonType.snp.trailing).offset(8)
            make.top.equalTo(pokemonName.snp.bottom).offset(8)
        }
        
        self.view.addSubview(pokemonSubType)
        
        self.pokemonSubType.snp.makeConstraints{make in
            make.top.equalTo(pokemonType.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
//
        self.view.addSubview(flavor)
        
        self.flavor.snp.makeConstraints{make in
            make.top.equalTo(pokemonSubType.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }
        
        self.view.addSubview(pokemonFlavorText)
        
        self.pokemonFlavorText.snp.makeConstraints{make in
            make.top.equalTo(flavor.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        
        
//        self.view.addSubview(pokemonSubType)

//        self.view.addSubview(pokemonFlavorText)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


