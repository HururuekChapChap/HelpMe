//
//  ViewController.swift
//  Project3.5
//
//  Created by yoon tae soo on 2021/05/22.
//

import UIKit

extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        
        var viewsDictionary = [String:UIView]()
        for(index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary ))
    }
}


//CollectionView 코드로 작성 방법
//https://medium.com/@max.codes/programmatic-custom-collectionview-cell-subclass-in-swift-5-xcode-10-291f8d41fdb1
class ViewController: UIViewController {

    let mainCollectionView : UICollectionView = {
       
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        
        let clv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        clv.translatesAutoresizingMaskIntoConstraints = false
        clv.backgroundColor = UIColor.systemYellow
        return clv
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        mainCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        setContraint()
    }
    
    func setContraint(){
        
        view.addSubview(mainCollectionView)
        
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }

}

extension ViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
        
        cell.callBack = { flag in
                
            if flag {
                let vc = AllServiceViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                let vc = AddServiceViewController()
//                let vc = CodeBaseViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
        return cell
        
    }
    
}

extension ViewController : UICollectionViewDelegate {
    
}

extension ViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 200)
    }
    
}

