//
//  SecondViewController.swift
//  dog4
//
//  Created by Eshani Chauk on 8/8/19.
//  Copyright © 2019 Eshani Chauk. All rights reserved.
//

import UIKit

var playlist = [String]()

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var playlistTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return(playlist.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell2")
        cell.textLabel?.text = playlist[indexPath.row]
        if playlist[indexPath.row] == "Musettas Song"
        {
            cell.textLabel?.text = "Musetta's Song"
        }
        
        return(cell)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        playlistTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete)
        {
            playlist.remove(at: indexPath.row)
            playlistTable.deleteRows(at: [indexPath], with: .bottom)
        }
    }
}
