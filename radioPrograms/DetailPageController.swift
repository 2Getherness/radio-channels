//
//  DetailPageController.swift
//  radioPrograms
//
//  Created by Imran Khan on 2019-07-02.
//  Copyright © 2019 upgradingmachine. All rights reserved.
//

import UIKit

class DetailPageController: UIViewController {
    // Olika labels, textview, imageView som är koplad till DetailPageController storyboard
    @IBOutlet weak var radioImage: UIImageView!
    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var channelEditor: UILabel!
    @IBOutlet weak var editorEmail: UILabel!
    @IBOutlet weak var channelDescription: UITextView!
    
    @IBOutlet weak var facebookLink: UILabel!
    @IBOutlet weak var twitterLink: UILabel!
    @IBOutlet weak var instagramLink: UILabel!
    @IBOutlet weak var facebookImageView: UIImageView!
    @IBOutlet weak var twitterImageView: UIImageView!
    @IBOutlet weak var instagramImageView: UIImageView!
    @IBOutlet var facebookStackClicked: UITapGestureRecognizer!
    @IBOutlet var twitterStackClicked: UITapGestureRecognizer!
    @IBOutlet var instagramStackClicked: UITapGestureRecognizer!
    
    
    var bigPictureisHidden = false
    
    
    // Action metoder för facebook, twitter, instagram som körs gotoWeb metoden
    @IBAction func facebookStackClicked(_ sender: Any) {
        print("facebook")
        self.gotoWeb(channelObject: recievedData!, platformName: "Facebook")
    }
    @IBAction func twitterStackClicked(_ sender: Any) {
        print("twitter")
        self.gotoWeb(channelObject: recievedData!, platformName: "Twitter")
    }
    @IBAction func instagramStackClicked(_ sender: Any) {
        print("instagram")
        self.gotoWeb(channelObject: recievedData!, platformName: "Instagram")
    }
    @IBAction func profilePictureTapped(_ sender: Any) {
        self.hideAndShowPicture(popupView: self.popupView)
    }
    
    // recievedData är den typ av variable som innehåller samma egenskapar som radioChannels har
    var recievedData: radioChannels?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Matar in imageView, lables, textarea så fort denna metoden körs.
        channelName.text = recievedData?.name
        channelEditor.text = recievedData?.responsibleeditor
        editorEmail.text = recievedData?.email
        channelDescription.text = recievedData?.description
        //print("Data recieved from Program Table Controller: ","\(String(describing: recievedData))")
        
        
        self.showImage(imageView: radioImage)
        
        radioImage.layer.masksToBounds = false
        radioImage.layer.cornerRadius = radioImage.frame.height/2
        radioImage.clipsToBounds = true
        
        // alla socialMedia imageView ska vara gömda från början
        self.facebookImageView.isHidden = true
        self.instagramImageView.isHidden = true
        self.twitterImageView.isHidden = true
        
        self.popupView.alpha = 0
        guard let data = recievedData else {
            return
        }
        // För att visa eller gömma socialMedia imageView kör jag denna metod
        self.checkForSocialMedia(media: data)
    }
    
    // showImage visar den lilla bilden samt när man trycker på bilden så vissas den i en stor viewImage också.
    func showImage(imageView: UIImageView) {
        if let image = recievedData?.programimage {
            if let imageUrl = URL(string: image) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageUrl)
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            imageView.image = image
                        }
                    }
                }
            }
        }
    }
    
    // Animering på visa bilden i popup view
    func hideAndShowPicture(popupView: UIView) {
        if self.popupView.alpha == 1 {
            UIView.animate(withDuration: 0.3/*Animation Duration second*/, animations: {
                self.popupView.alpha = 0
            }, completion:  {
                (value: Bool) in
//                self.showImage(imageView: self.bigImageView)
                guard let image = self.radioImage.image else { return }
                self.bigImageView.image = image
            })
        } else if self.popupView.alpha == 0 {
            UIView.animate(withDuration: 0.3/*Animation Duration second*/, animations: {
                self.popupView.alpha = 1
            }, completion: nil)
        }
    }

//    func hideImageViews(image: UIImageView) {
//        UIView.animateKeyframes(withDuration: 1.0, delay: 0.5, animations: {
//            image.alpha = 0
//        }, completion: nil)
//    }
    
    // i denna metod hämtar jag radiChannels objekt och strängen som har namn på de olika platformer.
    // Om strängen matchar med radioChannel objekt platform sträng då varigerar jag till vebview med den specifika länken
    func gotoWeb(channelObject: radioChannels, platformName: String) {
        guard let socialMediaform = channelObject.socialmediaplatforms else {
            return
        }
        for platform in socialMediaform {
            if platform.platform == platformName {
                guard let url = platform.platformurl else { return }
                UIApplication.shared.open(URL(string: url)! as URL, options: [:], completionHandler: nil)
            }
        }
    }
    
    // Här kollar jag om radioChannels objekt har socialmediaplatform och sedan kollar ifall den innehåller något och sedan hämförar med hjälp av switch statement. Om det finns någon av facebook, twitter eller instagram så filler jag label med texten brevid annars gömmer jag.
    func checkForSocialMedia(media: radioChannels) {
        guard let mediaUrl = media.socialmediaplatforms, let titleName = media.programslug else {
            return
        }
        self.title = titleName
        for url in mediaUrl {
            //print(url)
            switch url.platform {
                case "Instagram":
                    print("instagram")
                    self.instagramImageView.isHidden = false
                    self.instagramLink.text = url.platform
                case "Facebook":
                    print("Facebook")
                    self.facebookImageView.isHidden = false
                    self.facebookLink.text = url.platform
                case "Twitter":
                    print("Twitter")
                    self.twitterImageView.isHidden = false
                    self.twitterLink.text = url.platform
                default:
                print("Something else")
            }
        }
    }

//    @IBAction func dismissView(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
}
