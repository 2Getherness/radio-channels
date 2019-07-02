//
//  RadioProgramStruct.swift
//  radioPrograms
//
//  Created by erica palm on 2019-07-01.
//  Copyright © 2019 upgradingmachine. All rights reserved.
//

import UIKit
//
//class RadioProgramStruct: UIViewController {
//
//    public var usableRadioPrograms: [radioChannels]  = []
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
//                        print("CopyRight String: **** ",name)
//                    }
//                    if let pro:[radioChannels] = radioPrograms.programs {
//                        for p in pro {
//                            //print(p)
//                            self.usableRadioPrograms.append(p)
//                        }
//                        dump(self.usableRadioPrograms)
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
//
//}
//
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
