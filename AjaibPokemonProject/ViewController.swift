//
//  ViewController.swift
//  AjaibPokemonProject
//
//  Created by Yudis Huang on 19/10/21.
//

import UIKit

class ViewController: UIViewController {

//    private let myView : UIView = {
//        let myView = UIView()
//        myView.translatesAutoresizingMaskIntoConstraints = false
//        myView.backgroundColor = .black
//        return myView
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.addSubview(myView)
//        addConstraints()
        
        ServiceAPI.shared.getResults(pokemonName: "Pikachu") { result in
            switch result {
            case .success(let results):
            print(results)
                
            case .failure(let error):
            print(error)
            }
        }
       
    }
    
//    private func addConstraints(){
//        var constraint = [NSLayoutConstraint]()
//
//        //add
//        constraint.append(myView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
//        constraint.append(myView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
//        constraint.append(myView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
//        constraint.append(myView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
//
//        //activated the constraint
//        NSLayoutConstraint.activate(constraint)
//
//
//    }


}

