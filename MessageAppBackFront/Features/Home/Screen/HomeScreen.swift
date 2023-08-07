//
//  HomeVC.swift
//  MessageAppBackFront
//
//  Created by Sergio Silva Macedo on 24/06/23.
//

import UIKit

class HomeScreen: UIView {

    lazy var navVIew : NavigationView = {
        let view = NavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.appLight
        return view
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        let cv = UICollectionView( frame: .zero, collectionViewLayout: layout )
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.delaysContentTouches = false
        cv.register(LastetMessageCVC.self, forCellWithReuseIdentifier: LastetMessageCVC.identifier)
        cv.register(MessageDetailsCVC.self, forCellWithReuseIdentifier: MessageDetailsCVC.identifier)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElementes()
        configContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    public func configColletionView(datasource: UICollectionViewDataSource, delegate: UICollectionViewDelegate){
        collectionView.dataSource = datasource
        collectionView.delegate = delegate
    }
    
    public func reloadData(){
        collectionView.reloadData()
    }
    private func addElementes(){
        addSubview(navVIew)
        addSubview(collectionView)
    }
    
    private func configContraints(){
        NSLayoutConstraint.activate([
            navVIew.topAnchor.constraint(equalTo: self.topAnchor),
            navVIew.trailingAnchor.constraint(equalTo: trailingAnchor),
            navVIew.leadingAnchor.constraint(equalTo: leadingAnchor),
            navVIew.heightAnchor.constraint(equalToConstant: 140),
            
            collectionView.topAnchor.constraint(equalTo: navVIew.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
        ])
    }
}
