//
//  ViewController.swift
//  BitirmeProjesi
//
//  Created by ahmet gökdemir on 1.04.2022.
//

import UIKit
import Kingfisher

class AnasayfaVC: UIViewController {
    
    //var yemeklerListesi = [Yemekler]()

    @IBOutlet weak var yemeklerCollectionView: UICollectionView!
    
    var anasayfaPresenterNesnesi:ViewToPresenterAnasayfaProtocol?
    
    var yemeklerListesi = [Yemekler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yemeklerCollectionView.delegate = self
        yemeklerCollectionView.dataSource = self
        tabBar.delegate = self
        
        AnasayfaRouter.createModule(ref: self)

        anasayfaPresenterNesnesi?.yemekleriYukle()
        
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        tasarim.minimumLineSpacing = 5
        tasarim.minimumInteritemSpacing = 5
        let genislik = yemeklerCollectionView.frame.size.width
        tasarim.itemSize = CGSize(width: (genislik-20)/3, height: genislik*0.55)
        yemeklerCollectionView!.collectionViewLayout = tasarim
        
        
    }
    @IBOutlet weak var tabBar: UITabBar!
    
}

extension AnasayfaVC : PresenterToViewAnasayfaProtocol {
    
    func vieweVeriGonder(yemeklerListesi: Array<Yemekler>) {
        self.yemeklerListesi = yemeklerListesi
        DispatchQueue.main.async {
            self.yemeklerCollectionView.reloadData()
        }
    }
    
}

extension AnasayfaVC : UICollectionViewDelegate,UICollectionViewDataSource,HucreProtocol,UITabBarDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return yemeklerListesi.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let yemek = self.yemeklerListesi[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "yemekHucre", for: indexPath) as! YemeklerCollectionViewCell
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
            
            DispatchQueue.main.async {
                cell.yemekImageView.kf.setImage(with:url)
            }
            
        }
        cell.yemekAdiLabel.text = yemek.yemek_adi!
        cell.yemekFiyatLabel.text = "\(yemek.yemek_fiyat!) ₺"
        
        cell.layer.borderColor = UIColor.red.cgColor
        cell.layer.borderWidth = 0.3
        cell.layer.cornerRadius = 10
        
        cell.hucreProtocol = self
        cell.indexPath = indexPath
        
        return cell
        
    }
    
    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let yemek = yemeklerListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
        
    }*/
    
    func sepeteEkleTikla(indexPath: IndexPath){
        
        let yemek = yemeklerListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "toDetay" {
            
            let yemek = sender as? Yemekler
            let gidilecekVC = segue.destination as! DetayVC
            gidilecekVC.yemek = yemek
            
        }
        
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if (item.tag == 2 ) {
            performSegue(withIdentifier: "toSepet", sender: nil)
            
        }
    }
    
}

