//
//  NewYorkTableViewCell.swift
//  AppNoticias
//
//  Created by Alisson William on 15/11/22.
//

import UIKit

class NewYorkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var by: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageNews.layer.cornerRadius = 10
        imageNews.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with news: NewsData) {
        title.text = news.title
        by.text = news.byline
        
        guard let  url = URL(string: news.image) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.imageNews.image = UIImage(data: data)
            }
            
        }.resume()
    }

}
