//
//  detailsViewController.swift
//  iMovie
//
//  Created by Juan Jose Gomez Medina on 2/2/22.
//

import UIKit

class detailsViewController: UIViewController {

    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var movie: [String:Any]!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Adding info to details screen.
        print(movie["title"] ?? "")
        titleLabel.text = (movie["title"] as! String)
        titleLabel.sizeToFit()
        overviewLabel.text = (movie["overview"] as! String)
        overviewLabel.sizeToFit()
        
        // adding poster image and bg image
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        let backgroundPath = movie["backdrop_path"] as! String
        let backgroundURL = URL(string: "https://image.tmdb.org/t/p/w780" + backgroundPath)
        
        posterView.af.setImage(withURL: posterURL!)
        
        backgroundView.af.setImage(withURL: backgroundURL!)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
