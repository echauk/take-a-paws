//
//  FirstViewController.swift
//  dog4
//
//  Created by Eshani Chauk on 8/8/19.
//  Copyright © 2019 Eshani Chauk. All rights reserved.
//

// modified from The Swift Guy "How To Create A TableView In Xcode 8 (Swift 3.0)" https://www.youtube.com/watch?v=fFpMiSsynXM
// modified from The Swift Guy "Table View Cell Action In Xcode 8 (Swift 3)" https://www.youtube.com/watch?v=A6Wl8ySrOZI

import UIKit

let list = ["Pomp and Circumstance", "Waltz", "Musetta's Song", "Theme from Scheherazade", "Butterfly Waltz", "First Bloom", "Moon River", "Jasmine Flower", "Fascination", "Over the Rainbow", "Lotus Flowers in the Wind"]
let composers = ["Elgar", "Brahms", "Puccini", "Rimsky-Korsakov", "Crain", "Costley", "Macini", "", "", "Arlen", "Scher"]

var myIndex = 0

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return(list.count)
    }
    
    // content of cell in each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // cell that user tapped on
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        createAlert(title: "Please turn on your ringer to use Take-A-Paws.", message: "")
    }
    
    func createAlert(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

