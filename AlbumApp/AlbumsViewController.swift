//
//  AlbumsViewController.swift
//  AlbumApp
//
//  Created by iMac on 02/06/21.
//

import UIKit

class AlbumsViewController: UIViewController {

    //MARK:- UI Components
    lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .darkGray
        control.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return control
    }()
    
    lazy var tblAlbums: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "AlbumTableViewCell")
        tableView.refreshControl = refreshControl
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    //MARK:- Variables
    let albumsViewModel = AlbumsViewModel()
    let activityIndicator = UIActivityIndicatorView.init(style: .medium)
    
    //MARK:- Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
        addComponents()
        addConstraints()
    }
    
    func initialization() {
        
        self.view.backgroundColor = .white
        self.title = "Albums"
        
        fetchAlbums()
    }

    @objc func handleRefresh() {
        fetchAlbums()
    }
    
    func fetchAlbums() {
        activityIndicator.startAnimating()
        tblAlbums.backgroundView = activityIndicator
        
        albumsViewModel.fetchData { [weak self] (status) in
            
            self?.refreshControl.endRefreshing()
            self?.activityIndicator.stopAnimating()
            self?.tblAlbums.backgroundView = nil
            self?.tblAlbums.reloadData()
        }
    }
    
    //MARK:- Add UI Components
    func addComponents() {
        self.view.addSubview(tblAlbums)
    }
    
    //MARK:- Set Constraints
    private func addConstraints() {
        
        NSLayoutConstraint.activate([

            tblAlbums.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tblAlbums.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tblAlbums.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tblAlbums.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),

        ])
    }
    
    deinit {
        print("Albums view deinitialize")
    }
}

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsViewModel.arrAlbums.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
        cell.bindData(objAlbum: albumsViewModel.arrAlbums[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vcDetail = DetailViewController()
        vcDetail.objAlbum = albumsViewModel.arrAlbums[indexPath.row]
        self.navigationController?.pushViewController(vcDetail, animated: true)
    }
}
