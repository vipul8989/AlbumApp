//
//  AlbumTableViewCell.swift
//  AlbumApp
//
//  Created by iMac on 02/06/21.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    //MARK:- UI Components
    lazy var viewMain: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imgAlbum: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 5.0
        img.clipsToBounds = true
        return img
    }()
    
    lazy var lblName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    lazy var lblArtist: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialization()
        addComponents()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        
    }
    
    //MARK:- Add UI Components
    private func addComponents() {

        viewMain.addSubview(imgAlbum)
        viewMain.addSubview(lblName)
        viewMain.addSubview(lblArtist)
        self.contentView.addSubview(viewMain)
    }
    
    //MARK:- Set Constraints
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            viewMain.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            viewMain.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            viewMain.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            viewMain.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),

            imgAlbum.leadingAnchor.constraint(equalTo: viewMain.leadingAnchor, constant: 16),
            imgAlbum.centerYAnchor.constraint(equalTo: viewMain.centerYAnchor, constant: 0),
            imgAlbum.widthAnchor.constraint(equalToConstant: 70),
            imgAlbum.heightAnchor.constraint(equalToConstant: 70),

            lblName.leadingAnchor.constraint(equalTo: imgAlbum.trailingAnchor, constant: 10),
            lblName.trailingAnchor.constraint(equalTo: viewMain.trailingAnchor, constant: -10),
            lblName.topAnchor.constraint(equalTo: imgAlbum.topAnchor, constant: 0),
            
            lblArtist.leadingAnchor.constraint(equalTo: imgAlbum.trailingAnchor, constant: 10),
            lblArtist.trailingAnchor.constraint(equalTo: viewMain.trailingAnchor, constant: -10),
            lblArtist.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 0),
        ])
    }
    
    func bindData(objAlbum: AlbumModel) {
        
        imgAlbum.downloadImage(link: objAlbum.artworkUrl100 ?? "", placeholder: "album_placeholder")
        lblName.text = objAlbum.name
        lblArtist.text = objAlbum.artistName
    }
}

