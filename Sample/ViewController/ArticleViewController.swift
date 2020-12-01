//
//  ArticleViewController.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 08/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController,UIScrollViewDelegate {

    var article : Article?

    @IBOutlet private var viewBounceHeader: ImageHeaderView!
    @IBOutlet weak var chapoLabel: UILabel!
    @IBOutlet weak var captionImage: UILabel!
    @IBOutlet weak var copyrightImage: UILabel!
    @IBOutlet weak var titleArticle: UILabel!
    @IBOutlet weak var dateEditArticle: UILabel!
    @IBOutlet weak var articleHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var contentWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewBounceHeader.imageURL = (self.article?.images?.imageUrl)!
        self.viewBounceHeader.imagePlaceHolder = #imageLiteral(resourceName: "placeHolder") // Le cas ou l'article ne contient pas d'image.
        
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = 30.0
        style.headIndent = 30.0
        style.tailIndent = -30.0
        let attrText = NSAttributedString(string: (self.article?.images?.imageCaption)!, attributes: [NSAttributedStringKey.paragraphStyle : style])
        self.captionImage.attributedText = attrText
        self.captionImage.text = self.article?.images?.imageCaption
        self.copyrightImage.text = NSLocalizedString("Copyright", comment: "©")+(self.article?.images?.imageCopyright)!
        self.titleArticle.text = self.article?.title
        
        // On affiche les deux date s'il sont different
        if self.article?.dateArticle == self.article?.editDate {
            self.dateEditArticle.text = NSLocalizedString("PrefixeDate", comment: "Le")+setFormated(date: (self.article?.editDate)!)
        }else{
            self.dateEditArticle.text = "Le "+setFormated(date: (self.article?.dateArticle)!)+NSLocalizedString("SeparatorDate", comment: "Le")+setFormated(date: (self.article?.editDate)!)
        }
        
        self.chapoLabel.text = self.article?.chapo
        self.contentWebView.scrollView.isScrollEnabled = false
        self.contentWebView.scrollView.bounces = false
        self.contentWebView.delegate = self
        self.contentWebView.loadHTMLString((self.article?.content)!, baseURL: nil)

    }
    @IBAction func captionViewAction(_ sender: Any) {
       self.captionImage.isHidden = !self.captionImage.isHidden
    }
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewBounceHeader.scrollViewDidScroll(scrollView.contentOffset)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ArticleViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
         webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('body')[0].style.fontFamily =\"-apple-system\"")
        let height : Float = (webView.stringByEvaluatingJavaScript(from: "document.documentElement.scrollHeight")! as NSString).floatValue
        self.articleHeightConstant.constant = CGFloat(height) + self.contentWebView.frame.origin.y
    }
}

