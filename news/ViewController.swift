//
//  ViewController.swift
//  news
//
//  Created by Mark Kuharich on 7/23/18.
//  Copyright © 2018 Mark Kuharich. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var articles = [NewsArticle]()
    
    @IBOutlet weak var itemsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsTable.delegate = self
        itemsTable.dataSource = self
        JSONGetter.shared.getJsonFromUrl(gotArticles)
        navigationController?.isNavigationBarHidden = true
    }
    
    func gotArticles(_ articles: [NewsArticle]?, _ error: String?) -> Void {
        guard let articles = articles else {
            return
        }
        self.articles = articles
        DispatchQueue.main.async {
            self.itemsTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
        let article = articles[indexPath.row]
        print("Got article: ", article.id)
        cell.headlineTextView.text = article.headline
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

