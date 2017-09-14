//
//  pokemonDetailVC.swift
//  My-Pokedex
//
//  Created by Игорь Антонченко on 13.09.17.
//  Copyright © 2017 Игорь Антонченко. All rights reserved.
//

import UIKit

class pokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heighLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var currentEvolImg: UIImageView!
    @IBOutlet weak var nextEvolImg: UIImageView!
    @IBOutlet weak var evolLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    
    
    
    
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            let img = UIImage(named: "\(pokemon.pokedexID)")
            mainImage.image = img
            currentEvolImg.image = img
            
           
            
            
            pokemon.downloadPokemonDetails { () -> () in
                // Это будет вызвано, после того как загрузка данных будет завершена
                self.updateUI()
            }
        }
    }
    
    func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heighLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        evolLbl.text = pokemon.evo
        pokedexLbl.text = "\(pokemon.pokedexID)"
        attackLbl.text = pokemon.attack
        
        if pokemon.evoId == "" {
            evolLbl.text = "No Evolutions"
            nextEvolImg.isHidden = true
        } else {
            nextEvolImg.isHidden = false
            nextEvolImg.image = UIImage(named: pokemon.evoId)
            var str = "Next Evolution: \(pokemon.evo)"
            
            if pokemon.evoLvl != "" {
              str += " - LVL \(pokemon.evoLvl)"
            }
        }
        
        
        
        
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
