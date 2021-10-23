//
//  DetailViewController.swift
//  AjaibPokemonProject
//
//  Created by Yudis Huang on 22/10/21.
//

import UIKit

class DetailViewController: UIViewController {

    var details = Model()
    private let Backgroundcolor = UIColor(hexString: "#1A202C")
    private let navBackgroundColor = UIColor(hexString: "#161B22")
    
    var name : String!
    var subtypes : String!
    var types : String!
    var flavorText : String!
    var images : String!
    var hp : String!
    
    // MARK: - Outlets
    private var navBar : UINavigationBar = {
        let navbar = UINavigationBar()
//        let navItem = UINavigationItem()
//        navItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil )
//        navbar.setItems([navItem], animated: false)
        return navbar
    }()

    private var pokemonImage : UIImageView = {
        let pokemonimage = UIImageView()
        return pokemonimage
    }()
    
    private var pokemonName : UILabel = {
        let pokemonname = UILabel()
        pokemonname.text = "labelName"
        return pokemonname
    }()
    
    private var pokemonType : UILabel = {
        let pokemontype = UILabel()
        pokemontype.text = "labelType"
        return pokemontype
    }()
    
    private var flavor : UILabel = {
        let flavor = UILabel()
        flavor.text = "Flavor :"
        return flavor
    }()
    
    private var pokemonSubType : UILabel = {
        let pokemonsubtype = UILabel()
        pokemonsubtype.text = "labelSub"
        return pokemonsubtype
    }()
    
    private var pokemonHp : UILabel = {
        let pokemonhp = UILabel()
        pokemonhp.text = "labelHp"
        return pokemonhp
    }()
    
    private var pokemonFlavorText : UILabel = {
        let pokemonflavortext = UILabel()
        pokemonflavortext.text = "flavorText"
        pokemonflavortext.sizeToFit()
        return pokemonflavortext
    }()
    
    private var otherCards : UILabel = {
        let othercards = UILabel()
        othercards.text = "Other Cards :"
        return othercards
    }()
    
    private var detailCollectionView : UICollectionView = {
        let detailcollectionview = UICollectionView()
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.frame = CGRect(x: 16, y: 50, width: button.intrinsicContentSize.width, height: button.intrinsicContentSize.height)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
        view.addSubview(button)
        
        view.backgroundColor = Backgroundcolor
        addAllView()
        
        labelConfiguration()
        
        // Do any additional setup after loading the view.
    }
    
    @objc private func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setTitle(uilabel: UILabel){
        uilabel.textColor = .white
        uilabel.font = UIFont(name: "boldSystemFont", size: 20)
    }
    
    private func setContent(uilabel: UILabel){
        uilabel.textColor = .white
        uilabel.font = UIFont(name: "systemFont", size: 16)
    }
    
    private func labelConfiguration(){
               setTitle(uilabel: pokemonName)
               setContent(uilabel: pokemonType)
               setContent(uilabel: pokemonSubType)
               setContent(uilabel: pokemonHp)
               setTitle(uilabel: flavor)
               setContent(uilabel: pokemonFlavorText)
               setTitle(uilabel: otherCards)
    }
    
    private func initData(){
        getImageFromMain(string: details.images!)
        pokemonName.text = details.name
        pokemonType.text = details.types![0]
        pokemonSubType.text = details.subtypes![0]
        pokemonFlavorText.text = details.flavorText
        pokemonHp.text = details.hp
        
    }
    
    private func getImageFromMain(string : String){
        ImageLoaderService.shared.getImage(urlString: string ) { (data, error) in
            if error != nil {
                self.pokemonImage.image = UIImage(named: "jungle")
                return
            }
            self.pokemonImage.image = UIImage(data: data!)
        }
        
    }
    
    private func addAllView(){
//        self.view.addSubview(navBar)
//        self.navBar.snp.makeConstraints{make in
//            make.height.equalTo(100)
//            make.width.equalToSuperview()
//        }
        
        self.view.addSubview(pokemonImage)
        
        self.pokemonImage.snp.makeConstraints{make in
            make.height.equalTo(275)
            make.width.equalTo(190)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(108)
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
        
        self.view.addSubview(otherCards)
        
        self.otherCards.snp.makeConstraints{make in
            make.top.equalTo(pokemonFlavorText.snp.bottom).offset(100)
            make.leading.equalToSuperview().inset(16)
        }
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





