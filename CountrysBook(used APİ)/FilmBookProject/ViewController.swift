//
//  ViewController.swift
//  FilmBookProject
//
//  Created by Gappze on 21.07.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var nameArray = [CountrysStats]()
    
    @IBOutlet weak var tableView: UITableView!
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSON {
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = nameArray[indexPath.row].countryName.capitalized
        return cell
    }
    func downloadJSON(completed: @escaping () -> ()){
        
let url =  URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/?rapidapi-key=59fa52c39fmsh5fa5965307421d2p1e84cdjsna8420fe1d37a")
        URLSession.shared.dataTask(with: url!) { data, response , error in
            
            if error == nil && data != nil {
                do {
                    self.nameArray = try JSONDecoder().decode([CountrysStats].self, from: data!)
                    DispatchQueue.main.sync {
                        completed()
                    }
                } catch {
                    print("JSON Error.")
                }
                
            }
        } .resume()
    }
}



