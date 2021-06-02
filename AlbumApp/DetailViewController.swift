//
//  DetailViewController.swift
//  AlbumApp
//
//  Created by iMac on 03/06/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK:- UI Components
    lazy var viewImgAlbum: UIView = {
        let viewImg = UIView()
        viewImg.translatesAutoresizingMaskIntoConstraints = false
        viewImg.backgroundColor = .white
        viewImg.layer.cornerRadius = 12.0
        viewImg.layer.shadowColor = UIColor.lightGray.cgColor
        viewImg.layer.shadowOffset = CGSize.init(width: 2.0, height: 2.0)
        viewImg.layer.shadowRadius = 10.0
        viewImg.layer.shadowOpacity = 1.0
        return viewImg
    }()
    
    lazy var imgAlbum: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 12.0
        img.clipsToBounds = true
        return img
    }()
    
    //
    lazy var lblNameTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Name :"
        return label
    }()
    
    lazy var lblName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    //
    lazy var lblArtistTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Artist :"
        return label
    }()
    
    lazy var lblArtist: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = UIColor.init(red: 255.0/255.0, green: 32.0/255.0, blue: 57.0/255.0, alpha: 1.0)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    //
    lazy var lblGenresTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Genres :"
        return label
    }()
    
    lazy var lblGenres: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    //
    lazy var lblReleaseTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Release Date :"
        return label
    }()
    
    lazy var lblRelease: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    //
    lazy var lblCopyrightTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Copyright :"
        return label
    }()
    
    lazy var lblCopyright: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let goItunes: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        button.setTitle("Go to iTunes", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.init(red: 255.0/255.0, green: 32.0/255.0, blue: 57.0/255.0, alpha: 1.0)
        button.layer.cornerRadius = 10.0
        button.layer.shadowColor = UIColor.init(red: 255.0/255.0, green: 32.0/255.0, blue: 57.0/255.0, alpha: 1.0).cgColor
        button.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
        button.layer.shadowRadius = 5.0
        button.layer.shadowOpacity = 0.5
        button.addTarget(self, action: #selector(iTunesTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK:- Variables
    var objAlbum: AlbumModel?
    
    //MARK:- Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
        addComponents()
        addConstraints()
    }
    
    func initialization() {
        view.backgroundColor = .white
        
        guard let objAlbum = objAlbum else {
            return
        }
        
        self.title = objAlbum.name
        imgAlbum.downloadImage(link: objAlbum.artworkUrl100 ?? "", placeholder: "album_placeholder")
        lblName.text = objAlbum.name
        lblArtist.text = objAlbum.artistName
        
        if let arr = objAlbum.genres {
            let arrGenre = arr.map({ $0.name ?? "" })
            let strGenres = arrGenre.joined(separator: ", ")
            lblGenres.text = strGenres
        }
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd"
        if let date = dateformatter.date(from: objAlbum.releaseDate ?? "") {
            dateformatter.dateFormat = "MMMM d, YYYY"
            let strDate = dateformatter.string(from: date)
            lblRelease.text = strDate
        }
        
        lblCopyright.text = objAlbum.copyright ?? ""
    }

    //MARK:- Add UI Components
    func addComponents() {
        self.view.addSubview(goItunes)
        self.view.addSubview(viewImgAlbum)
        self.view.addSubview(imgAlbum)
        
        self.view.addSubview(lblNameTitle)
        self.view.addSubview(lblName)
        self.view.addSubview(lblArtistTitle)
        self.view.addSubview(lblArtist)
        self.view.addSubview(lblGenresTitle)
        self.view.addSubview(lblGenres)
        self.view.addSubview(lblReleaseTitle)
        self.view.addSubview(lblRelease)
        self.view.addSubview(lblCopyrightTitle)
        self.view.addSubview(lblCopyright)
    }
    
    //MARK:- Set Constraints
    private func addConstraints() {
        
        NSLayoutConstraint.activate([

            goItunes.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            goItunes.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            goItunes.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            goItunes.heightAnchor.constraint(equalToConstant: 44),
            
            viewImgAlbum.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            viewImgAlbum.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            viewImgAlbum.heightAnchor.constraint(equalToConstant: 250),
            viewImgAlbum.widthAnchor.constraint(equalToConstant: 250),
            
            imgAlbum.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imgAlbum.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imgAlbum.heightAnchor.constraint(equalToConstant: 250),
            imgAlbum.widthAnchor.constraint(equalToConstant: 250),
            
            lblNameTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblNameTitle.topAnchor.constraint(equalTo: imgAlbum.bottomAnchor, constant: 20),
            lblNameTitle.heightAnchor.constraint(equalToConstant: 21),
            lblNameTitle.widthAnchor.constraint(equalToConstant: 54),

            lblName.leadingAnchor.constraint(equalTo: lblNameTitle.trailingAnchor, constant: 5),
            lblName.topAnchor.constraint(equalTo: lblNameTitle.topAnchor, constant: 1),
            lblName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            lblArtistTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblArtistTitle.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 5),
            lblArtistTitle.heightAnchor.constraint(equalToConstant: 21),
            lblArtistTitle.widthAnchor.constraint(equalToConstant: 52),

            lblArtist.leadingAnchor.constraint(equalTo: lblArtistTitle.trailingAnchor, constant: 5),
            lblArtist.topAnchor.constraint(equalTo: lblArtistTitle.topAnchor, constant: 1),
            lblArtist.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            lblGenresTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblGenresTitle.topAnchor.constraint(equalTo: lblArtist.bottomAnchor, constant: 5),
            lblGenresTitle.heightAnchor.constraint(equalToConstant: 21),
            lblGenresTitle.widthAnchor.constraint(equalToConstant: 64),

            lblGenres.leadingAnchor.constraint(equalTo: lblGenresTitle.trailingAnchor, constant: 5),
            lblGenres.topAnchor.constraint(equalTo: lblGenresTitle.topAnchor, constant: 1),
            lblGenres.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            lblReleaseTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblReleaseTitle.topAnchor.constraint(equalTo: lblGenres.bottomAnchor, constant: 5),
            lblReleaseTitle.heightAnchor.constraint(equalToConstant: 21),
            lblReleaseTitle.widthAnchor.constraint(equalToConstant: 108),

            lblRelease.leadingAnchor.constraint(equalTo: lblReleaseTitle.trailingAnchor, constant: 5),
            lblRelease.topAnchor.constraint(equalTo: lblReleaseTitle.topAnchor, constant: 1),
            lblRelease.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            lblCopyrightTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblCopyrightTitle.topAnchor.constraint(equalTo: lblRelease.bottomAnchor, constant: 5),
            lblCopyrightTitle.heightAnchor.constraint(equalToConstant: 21),
            lblCopyrightTitle.widthAnchor.constraint(equalToConstant: 84),

            lblCopyright.leadingAnchor.constraint(equalTo: lblCopyrightTitle.trailingAnchor, constant: 5),
            lblCopyright.topAnchor.constraint(equalTo: lblCopyrightTitle.topAnchor, constant: 1),
            lblCopyright.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

        ])
    }
    
    //MARK:- Button action
    @objc func iTunesTapped() {
        if let url = URL(string: objAlbum?.url ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    deinit {
        print("Detail view deinitialize")
    }
}
