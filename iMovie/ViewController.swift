//
//  ViewController.swift
//  iMovie
//
//  Created by Juan Jose Gomez Medina on 1/31/22.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet var tableView: UITableView!
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        print("hello sir");
        
        // the following is the network request to access the information about the movies
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data
                 self.movies = dataDictionary["results"] as! [[String:Any]]
                 self.tableView.reloadData()
                 
            //dataDictionary is where all the information will be.
                 print(dataDictionary);
             }
        }
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! movieTableViewCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        
        cell.titleLabel!.text = title
        cell.synopsisLabel!.text = overview
        cell.posterView.af.setImage(withURL: posterURL!)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        // this is getting the view controller ready to go to another view controller, it is used to send information from this viewcontroller to others.
        // the sender is the the cell that the user pushes.
        
        print("Loading content...")
        
        //find selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        //pass selected movie's information to the details view controller.
        let movieDetailsViewController = segue.destination as! detailsViewController
        movieDetailsViewController.movie = movie
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

