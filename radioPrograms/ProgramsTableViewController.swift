//
//  ProgramsTableViewController.swift
//  radioPrograms
//
//  Created by erica palm on 2019-07-01.
//  Copyright © 2019 upgradingmachine. All rights reserved.
//

import UIKit
import Foundation

struct parentJson: Decodable {
    let copyright: String?
    let programs: [radioChannels]
}

struct radioChannels: Decodable {
    let id: Int?
    let responsibleeditor: String?
    let name: String?
    let description: String?
    let email: String?
    let programslug: String?
    let programimage: String?
    let channel: channel
}

struct channel: Decodable {
    let name: String
    let id: Int
}

//struct Food: Decodable {
//    let name: String
//    let description: String
//}


class ProgramsTableViewController: UITableViewController {

    var usableRadioPrograms = [radioChannels]()
//    public var foodArray: [Food]  = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        let jsonUrl = "http://api.sr.se/api/v2/programs?format=json&size=40"
        guard let url = URL(string: jsonUrl) else { return }
        var backgroundTask = 0
        
//        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "BackgroundTask") {
//        UIApplication.shared.endBackgroundTask(UIBackgroundTaskIdentifier(rawValue: backgroundTask))
//        backgroundTask = UIBackgroundTaskIdentifier.invalid.rawValue
//        }.rawValue
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                print("Failed to get data from url:", error)
                }
                guard let data = data else { return }
//                guard let dataString = String(data: data, encoding: .utf8) else { return }
//                print(dataString)
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(parentJson.self, from: data)

                    for item in jsonData.programs {
                        self.usableRadioPrograms.append(item)
                    }
                    print(self.usableRadioPrograms)
                    self.tableView.reloadData()
//                    for item in jsonData.programs {
//                        self.usableRadioPrograms.append(item)
//                    }
//                    dump(self.usableRadioPrograms)

                } catch let jsonError {
                    print("Error while fetching data", jsonError)
                }
                //dump("Self.UsableRadioPrograms : \(self.usableRadioPrograms)")
            }
            }.resume()
        
//        let food1 = Food( name: "Chocolate Cake", description: "There is nothing better than a great chocolate cake.")
//        let food2 = Food( name: "Meringue & Berries", description: "I really don't like meringue but it's a nice photo.")
//        let food3 = Food( name: "Grilled Peaches", description: "This would be perfect as a summer time dessert.")
//        let food4 = Food( name: "Tiramisu", description: "One of my favorite Italian desserts. Yum.")
//
//        foodArray.append(food1)
//        foodArray.append(food2)
//        foodArray.append(food3)
//        foodArray.append(food4)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(self.usableRadioPrograms.count)
        return self.usableRadioPrograms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let radioProgramCell = "programCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: radioProgramCell, for: indexPath) as? TableViewCell else {
            fatalError("The dequeued cell is not an instance of TableViewCell.")
        }
        let prog = self.usableRadioPrograms[indexPath.row]
        cell.radioProgramName.text = prog.channel.name
        if let imageUrl = URL(string: prog.programimage!) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageUrl)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.radioProgramImage.image = image
                    }
                }
            }
        }
        return cell
    }
    

    
    func parseJSON(jsonUrl: String) {
        guard let url = URL(string: jsonUrl) else { return }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            //            guard let data = data else { return }
            //            guard let dataString = String(data: data, encoding: .utf8) else { return }
            //            dump(dataString)
            if error == nil {
                guard let data = data else { return }
                do {
                    let radioPrograms = try JSONDecoder().decode(parentJson.self, from: data)
                    if let name = radioPrograms.copyright {
                        print("CopyRight String: **** ",name)
                    }
                    if let pro:[radioChannels] = radioPrograms.programs {
                        for p in pro {
                            //print(p)
                            //self.usableRadioPrograms.append(p)
                        }
                        dump(self.usableRadioPrograms)
                    }
                    
                } catch let jsonError {
                    print("Error while fetching data", jsonError)
                }
            } else {
                print("Error while URLSession", error)
            }
            }.resume()
    }


}


/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
