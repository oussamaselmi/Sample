//
//  HomeTableViewController.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 07/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import UIKit
import SDWebImage

class HomeTableViewController: UITableViewController {
    
    var programmes : Array<Program>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.programmes = Array<Program>()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Vérification de connexion internet
        if Reachability.isConnectedToNetwork(){
             log.debug("Connexion Internet OK");
            self.getSchedule() // Chargement du Programme
        }else{
            DispatchQueue.main.async(execute: {
                let alert = AlertHelper()
                alert.showAlert(fromController: (UIApplication.shared.keyWindow?.rootViewController)!, withTitle: "", andMessage: NSLocalizedString("ErrorConnection", comment: ""))
            })
        }
    }
    // MARK: Programme
    /// Chargement du programme
    /// Chargement asynchrone pour ne pas bloquer l'ouverture de l'appli
    func getSchedule() {
        let programmeManager:ProgramRequestManager = ProgramRequestManager.sharedInstance; // initialisation du singleton
        programmeManager.loadProgramAtDate(myDate: Date(),async:true, completion: {prog,success in
            if(success){
                log.debug("Chargement du programme est OK");
                self.programmes = prog?.programs
                self.tableView.reloadData()
            }
            else{
                log.debug("Chargement du programme est KO");
            }
        });
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if !self.programmes.isEmpty {
            return self.programmes.count
        }else{
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let prog = self.programmes[section]
        let items = prog.elements.first
        return items!.items.count
    }
    override func tableView(_ tableView : UITableView,  titleForHeaderInSection section: Int)->String {
        let prog = self.programmes[section]
        return prog.title!

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 219
        }else{
            return 120
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let prog = self.programmes[section]
        if (prog.title == "") {
            return 0.0
        }else{
            return 10.0
        }
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell: HeaderTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            let title = self.programmes[indexPath.section].elements.first?.items[indexPath.row].title
            let style = NSMutableParagraphStyle()
            style.firstLineHeadIndent = 10.0
            style.headIndent = 10.0
            style.tailIndent = 0.0
            let attrText = NSAttributedString(string: title!, attributes: [NSAttributedStringKey.paragraphStyle : style])
            cell.titleArticle.attributedText = attrText
            //*** ANIMATION D'affichage d'image avec la variation du valeur d'Alpha
            let imageURL = URL(string: (self.programmes[indexPath.section].elements.first?.items[indexPath.row].images?.imageUrl)!)
            cell.headerImage.sd_setImage(with: imageURL! , placeholderImage: #imageLiteral(resourceName: "placeHolder"),options: .cacheMemoryOnly, completed: { (image, error, cacheType, imageURL) in
                UIView.animate(withDuration: 1.0, animations: {
                    cell.headerImage.alpha = 0.0
                    cell.headerImage.alpha = 1.0
                })
            })
            
            return cell

        }else{
             let cell: ArticleTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
            cell.articleTitle.text = self.programmes[indexPath.section].elements.first?.items[indexPath.row].title
            let imageURL = URL(string: (self.programmes[indexPath.section].elements.first?.items[indexPath.row].images?.imageUrl)!)
            cell.articleImage.sd_setImage(with: imageURL! , placeholderImage: #imageLiteral(resourceName: "placeHolder"),options: .cacheMemoryOnly, completed: { (image, error, cacheType, imageURL) in
                UIView.animate(withDuration: 1.0, animations: {
                    cell.articleImage.alpha = 0.0
                    cell.articleImage.alpha = 1.0
                })
            })
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = self.programmes[indexPath.section].elements.first?.items[indexPath.row]
        performSegue(withIdentifier: "ArticleViewControllerSegue", sender: article)

    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="ArticleViewControllerSegue") {
            if let articleViewController = segue.destination as? ArticleViewController {
                articleViewController.article = sender as? Article
            }
        }
    }
}
