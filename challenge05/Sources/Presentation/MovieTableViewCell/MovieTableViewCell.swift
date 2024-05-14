//
//  MovieTableViewCell.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(movie: Movie) {
        movieTitleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitleLabel.text = ""
        releaseDateLabel.text = ""
        
        movieImageView.image = nil
    }
    
}
