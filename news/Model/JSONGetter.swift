//
//  JSONGetter.swift
//  news
//
//  Created by Mark Kuharich on 7/24/18.
//  Copyright © 2018 Mark Kuharich. All rights reserved.
//

import Foundation

class JSONGetter {
    
    static var shared = JSONGetter()    // singleton
    fileprivate init() { }
    
    fileprivate let urlString = "https://s3.amazonaws.com/shrekendpoint/news.json"
    
    func getJsonFromUrl(_ completion: @escaping (_ articles: [NewsArticle]?, _ error: String?) -> Void) {

        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: (url)!, completionHandler: {(data, response, error) -> Void in
            
            if let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                guard let data = json?.value(forKey: "data") as? [[String: Any]] else {
                    completion(nil, "Couldn't find data element in json")
                    return
                }
                var articles = [NewsArticle]()
                
                for article in data {
                    if let id = article["id"] as? String, let items = article["items"] as? [[String: Any]] {

                        for item in items {
                            if let headline = item["headline"] as? String, let summary = item["summary"] as? String, let datePublishedString = item["published"] as? String{
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                                let date = dateFormatter.date(from: datePublishedString)!
                                articles.append(NewsArticle(id: id, headline: headline, publishedDate: date, summary: summary))
                            }
                        }
                    }
                }
                articles = articles.sorted(by: { $0.publishedDate > $1.publishedDate})
                completion(articles, nil)
            }
        }).resume()
    }
    
}
