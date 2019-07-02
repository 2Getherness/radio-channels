////
////  ViewController.swift
////  radioPrograms
////
////  Created by erica palm on 2019-07-01.
////  Copyright © 2019 upgradingmachine. All rights reserved.
////
//
//import UIKit
//
//struct parentJson: Decodable {
//    let copyright: String?
//    let programs: [radioChannels]?
//}
//
//struct radioChannels: Decodable {
//    let id: Int?
//    let responsibleeditor: String?
//    let name: String?
//    let description: String?
//    let email: String?
//    let programslug: String?
//    let channel: channel
//}
//
//struct channel: Decodable {
//    let name: String
//    let id: Int
//}
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var imageViewContainer: UIImageView!
//
//    var usableRadioPrograms: [radioChannels]  = []
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let jsonUrl = "http://api.sr.se/api/v2/programs?format=json&size=40"
//        self.parseJSON(jsonUrl: jsonUrl.self)
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.usableRadioPrograms.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let radioProgramCell = "programsCell"
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: radioProgramCell, for: indexPath) as? TableViewCell else {
//            fatalError("The dequeued cell is not an instance of TableViewCell.")
//        }
//        let prog = usableRadioPrograms[indexPath.row]
//        cell.radioProgramName.text = prog.channel.name
//        print(prog.channel.name)
//        return cell
//    }
//
//
//    func parseJSON(jsonUrl: String) {
//        guard let url = URL(string: jsonUrl) else { return }
//        URLSession.shared.dataTask(with: url) {(data, response, error) in
//
//            //            guard let data = data else { return }
//            //            guard let dataString = String(data: data, encoding: .utf8) else { return }
//            //            dump(dataString)
//            if error == nil {
//                guard let data = data else { return }
//                do {
//                    let radioPrograms = try JSONDecoder().decode(parentJson.self, from: data)
//                    if let name = radioPrograms.copyright {
//                        print(name)
//                    }
//                    if let pro:[radioChannels] = radioPrograms.programs {
//                        for p in pro {
//                            //print(p)
//                            self.usableRadioPrograms.append(p)
//                        }
//                        //dump(self.usableRadioPrograms)
//                    }
//
//                } catch let jsonError {
//                    print("Error while fetching data", jsonError)
//                }
//            } else {
//                print("Error while URLSession", error)
//            }
//            }.resume()
//    }
//}
//
//
///*
// struct radioChannels: Decodable {
// let id: Int?
// let channelName: String?
// let email: String?
// let programslug: String?
// let responsibleeditor: String?
// let name: String?
//
// }
//
//
//
// let jsonUrl = "http://api.sr.se/api/v2/programs?format=json&size=40"
// guard let constructedJsonURL = URL(string: jsonUrl) else { return }
// URLSession.shared.dataTask(with: constructedJsonURL) {(data, response, error) in
// if error == nil {
// //                let loadedImage = UIImage(data: data!)
// //                self.imageViewContainer.image = loadedImage
// guard let data = data else { return }
// do {
// let radioPrograms = try JSONDecoder().decode(radioChannels.self, from: data)
// print(radioPrograms.name)
// } catch let jsonError {
// print(jsonError)
// }
//
// }
// }.resume()
// */
