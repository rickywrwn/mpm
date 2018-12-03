//
//  HomeController.swift
//  mpm
//
//  Created by Ricky Wirawan on 03/12/18.
//  Copyright © 2018 Ricky Wirawan. All rights reserved.
//

import UIKit
import Hue

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    fileprivate let WelcomeCellId = "WelcomeCellId"
    fileprivate let ImageCellId = "ImageCellId"
    fileprivate let MenuCellId = "MenuCellId"
    fileprivate let NewsstandCellId = "NewsstandCellId"
    var isLogged : Bool = UserDefaults.standard.bool(forKey: "logged")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  isLogged{
            print("masuk home")
        }else {
            print("out home")
            //pakai perform selector aga bisa memunculkan login page ketika belum login
            perform(#selector(handleBack), with: nil, afterDelay: 0)
        }
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(WelcomeCell.self, forCellWithReuseIdentifier: WelcomeCellId)
        collectionView?.register(ImageCell.self, forCellWithReuseIdentifier: ImageCellId)
        collectionView?.register(MenuCell.self, forCellWithReuseIdentifier: MenuCellId)
        collectionView?.register(NewsstandCell.self, forCellWithReuseIdentifier: NewsstandCellId)
        
        // Create the navigation bar
        let screenSize: CGRect = UIScreen.main.bounds
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 0))
        navbar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navbar)
        navbar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        navbar.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
        navbar.barTintColor = UIColor(hex: "#ea7230")
        navbar.isTranslucent = false
        let navigationItem = UINavigationItem()
        navigationItem.title = "HOME"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Titip Juga", style: .plain, target: self, action: #selector(handleTitip))
        
        navbar.setItems([navigationItem], animated: false)
        
        if UIDevice().userInterfaceIdiom == .phone
        {
            switch UIScreen.main.nativeBounds.height
            {
            case 2436: //iPhone X
                collectionView?.frame = CGRect(x: 0, y: 86, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 64))
            case 2688: //iphone xs max
                collectionView?.frame = CGRect(x: 0, y: 86, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 64))
            default:
                collectionView?.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 64))
            }
        }
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(hex: "#ea7230")
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    
    @objc func handleBack(){
        let LoginCont = LoginController()
        print("back from home")
        self.present(LoginCont, animated: true, completion: {
            
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellId, for: indexPath) as! ImageCell
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
            
            return cell
        }else if indexPath.row == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCellId, for: indexPath) as! MenuCell
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
            
            return cell
        }else if indexPath.row == 3{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsstandCellId, for: indexPath) as! NewsstandCell
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WelcomeCellId, for: indexPath) as! WelcomeCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0{
            return CGSize(width: view.frame.size.width, height: 150)
        }else if indexPath.row == 1{
            return CGSize(width: view.frame.size.width, height: 200)
        }else if indexPath.row == 2{
            return CGSize(width: view.frame.size.width, height: 300)
        }else if indexPath.row == 3{
            return CGSize(width: view.frame.size.width, height: 500)
        }
        return CGSize(width: view.frame.size.width, height: 100)
    }
    
}

//row 1
class WelcomeCell: BaseCell {
    
    let labelTanggal : UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.text = "tanggal"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let labelNama : UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.text = "Welcome, Nama"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
//        iv.image = UIImage(named: "coba")
        iv.backgroundColor = UIColor.black
        iv.layer.masksToBounds = true
        return iv
    }()
    
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor.white
        
        addSubview(labelTanggal)
        addSubview(labelNama)
        addSubview(imageView)
        
        addConstraintsWithFormat("H:|[v0][v1(100)]-5-|", views: labelTanggal, imageView)
        addConstraintsWithFormat("H:|[v0][v1(100)]-5-|", views: labelNama, imageView)
        
        addConstraintsWithFormat("V:|[v0]-5-[v1]|", views:labelTanggal,labelNama )
        addConstraintsWithFormat("V:|[v0(100)]|", views:imageView )
    }
}

//row 2
class ImageCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        //        iv.image = UIImage(named: "coba")
        iv.backgroundColor = UIColor.yellow
        iv.layer.masksToBounds = true
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor.red
        addSubview(imageView)
        
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        addConstraintsWithFormat("V:|[v0]|", views:imageView )
    }
}

//row 3
class MenuCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    fileprivate let ItemCellId = "ItemCellId"
    
    let itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 6, right: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 25
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func setupViews() {
        super.setupViews()
        itemCollectionView.dataSource = self
        itemCollectionView.delegate = self
        itemCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCellId)
        
        addSubview(itemCollectionView)
        
        addConstraintsWithFormat("H:|[v0]|", views: itemCollectionView)
        addConstraintsWithFormat("V:|[v0]|", views:itemCollectionView )
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCellId, for: indexPath) as! ItemCell
        if indexPath.row == 0{
            cell.imageView.image = UIImage(named: "menu-request")
            cell.labelNama.text = "Request"
        }else if indexPath.row == 1{
            cell.imageView.image = UIImage(named: "menu-document")
            cell.labelNama.text = "Document"
        }else if indexPath.row == 2{
            cell.imageView.image = UIImage(named: "menu-news")
            cell.labelNama.text = "News"
        }else if indexPath.row == 3{
            cell.imageView.image = UIImage(named: "menu-survey")
            cell.labelNama.text = "Survey"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 110, height: 110)
    }
}

class ItemCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let labelNama : UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor.red
        addSubview(imageView)
        addSubview(labelNama)
        
        addConstraintsWithFormat("H:|-35-[v0(40)]-35-|", views: imageView)
        addConstraintsWithFormat("H:|-25-[v0(60)]-25-|", views: labelNama)
        addConstraintsWithFormat("V:|-25-[v0(40)][v1]|", views:imageView,labelNama )
    }
}

//row 4
class NewsstandCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    fileprivate let NewsCellId = "NewsCellId"
    
    let labelNews : UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.text = "NEWS"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 6, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func setupViews() {
        super.setupViews()
        itemCollectionView.dataSource = self
        itemCollectionView.delegate = self
        itemCollectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCellId)
        
        addSubview(itemCollectionView)
        addSubview(labelNews)
        
        addConstraintsWithFormat("H:|-10-[v0]|", views: labelNews)
        addConstraintsWithFormat("H:|[v0]|", views: itemCollectionView)
        addConstraintsWithFormat("V:|-10-[v0][v1]|", views:labelNews,itemCollectionView )
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCellId, for: indexPath) as! NewsCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: frame.width/2-16, height: 200)
    }
}

class NewsCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        //        iv.image = UIImage(named: "coba")
        iv.backgroundColor = UIColor.yellow
        iv.layer.masksToBounds = true
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor.red
        addSubview(imageView)
        
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        addConstraintsWithFormat("V:|[v0]|", views:imageView )
    }
}



//bantuan
class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}

extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}
