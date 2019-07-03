//
//  ProgramsTableViewController.swift
//  radioPrograms
//
//  Created by Imran Khan on 2019-07-01.
//  Copyright © 2019 upgradingmachine. All rights reserved.
//

import UIKit
import Foundation

// Swift colaste protokol för att parsa JSON data med hjälp av Codable och Decodable.
/* parentJson innehåller copyright som en sträng så fort man for 200 response från servern och den innehåller programs som har olika objekt */
struct parentJson: Decodable {
    let copyright: String?
    let programs: [radioChannels]
}
/* radioChannels innehåller alla program object samt array av channel */
public struct radioChannels: Decodable {
    let id: Int?
    let responsibleeditor: String?
    let name: String?
    let description: String?
    let email: String?
    let programslug: String?
    let programimage: String?
    let channel: channel
    let socialmediaplatforms: [socialmediaplatforms]?
}
/* channel innehåller namn samnt id på varje program */
struct channel: Decodable {
    let name: String?
    let id: Int
}
/* socialmediaplatforms innehåller platform namn som t.ex facebook, twitter eller instagram och platfrom url */
struct socialmediaplatforms: Decodable {
    let platform: String?
    let platformurl: String?
}

/* ProgramsTableViewController är den huvud entré till applikationen efter när applikationen har kört navigationController */
class ProgramsTableViewController: UITableViewController {

    // usableRadioPrograms är array av en typ radioChannels
    var usableRadioPrograms = [radioChannels]()
    final let jsonUrl = "http://api.sr.se/api/v2/programs?format=json&size=40"
    
    // I viewDidLoad har har gjord det viktigaste delan t.ex anrupa url och samt kopera data till globala variabln usableRatioPrograms
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.parseJSON(jsonUrl: jsonUrl)
        
    }

    // Att tableView saka innehålla en section retunerar jag 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    // numberOfRowsInSection ska lägga till mer celler beroende på usableRadioPrograms array lengd
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(self.usableRadioPrograms.count)
        return self.usableRadioPrograms.count
    }
    
    // När man vill skicka data till en nästa controller så använder man olika teknik t.ex delegate (backwards) eller prepare. Här hittar jag segue identifier och nästa UIViewController som är DetailPageController. Med hälp av indexPathForSelectedRow hitter jag index av den rad man trycker på och sedan sorterar jag inom usableRadioProgram den specifika objektet, sedan skickar jag till DetailPagecontroller hela objekt som heter recievedData ligger globalt här.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "detailPage",
            let destination = segue.destination as? DetailPageController,
            let blogIndex = tableView.indexPathForSelectedRow?.row
        {
            print(blogIndex)
            let cellData = self.usableRadioPrograms[blogIndex]
            destination.recievedData = cellData
        }
        //performSegue(withIdentifier: "detailPage", sender: nil)
    }
    
    // Den här metoten är anvarig för visa data på skärmen. Vi har i parentJSON metoden en rad kod self.tableView.reload() som kör denna metoden för att kunna reloada tableView och visa data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // radioPrgramCell innehåller identifier för tableView Cell
        let radioProgramCell = "programCell"
        // här kolla jag om cell finns annars visar jag fel medelande
        guard let cell = tableView.dequeueReusableCell(withIdentifier: radioProgramCell, for: indexPath) as? TableViewCell else {
            fatalError("The dequeued cell is not an instance of TableViewCell.")
        }
        let prog = self.usableRadioPrograms[indexPath.row]
        // när jag har data i usableRadioPrograms array och cell, då kommer jag åt cellen contents t.ex imageView eller label och filler från prog variable
        cell.radioProgramName.text = prog.channel.name
        if let image = prog.programimage {
            if let imageUrl = URL(string: image) {
                // global trod används för att appen körs något i backgrunden
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageUrl)
                    if let data = data {
                        let image = UIImage(data: data)
                        // när global är klar då vill jag visa data på skärmen, och därför använder jag main trod här nedan
                        DispatchQueue.main.async {
                            cell.radioProgramImage.image = image
                        }
                    }
                }
            }
        }
        return cell
    }
    // Så fort applikationen kommer till den här controller så i ViewDidLoad() körs denna metod som är ansvarig för att hämta data från servern via url:an
    func parseJSON(jsonUrl: String) {
        guard let url = URL(string: jsonUrl) else { return }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to get data from url:", error)
                }
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(parentJson.self, from: data)
                    
                    for item in jsonData.programs {
                        // här kopeirar jag programs till usableRadioPrograms array
                        self.usableRadioPrograms.append(item)
                    }
                    print(self.usableRadioPrograms)
                    self.tableView.reloadData()
                    
                } catch let jsonError {
                    print("Error while fetching data", jsonError)
                }
                //dump("Self.UsableRadioPrograms : \(self.usableRadioPrograms)")
            }
            }.resume()
    }


}
