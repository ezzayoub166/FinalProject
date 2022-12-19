//
//  Extension.swift

//
//  Created by iosMaher on 4/13/19.
//  Copyright © 2019 iosMaher. All rights reserved.
//

//import AVKit
//import UIKit
////import SDWebImage
import PopupDialog
import SystemConfiguration
import Foundation
import UIKit
//import KSPhotoBrowser
import UIKit.UIColor
import TTGSnackbar

let color_517FF6 = "517FF6".color
let color_F0F4FB = "F0F4FB".color
let color_515151 = "515151".color
let color_989DB3 = "989DB3".color


private var kAssociationKeyMaxLength: Int = 0

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

//extension Sequence where Iterator.Element == JSON {
//
//    func printErros() -> String {
//        var str = ""
//        for item in self {
//            if let dic = item.dictionaryObject {
//                let val = dic.printErrors()
//                str += (val + "\n")
//            }
//        }
//        print(str)
//        str = String(str.dropLast(2))
//        return str
//    }
//
//}

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
    
    func printErrors() -> String {
        var str = ""
        for key in self.keys {
            let val = (self[key] as? [String] ?? []).map{$0}.joined(separator: "\n")
            str += (val + "\n")
        }
        str = String(str.dropLast(2))
        return str
    }
}

extension Date {
    
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0))
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }

    func toMillis() -> Int! {
        return Int(self.timeIntervalSince1970 * 1000)
    }

    func dateToString(_ format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    var nextDay : Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var previousDay:Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }

    var previousYear:Date {
        return Calendar.current.date(byAdding: .year, value: -18, to: self)!
    }

}

extension UIButton {
    func flipBtn() {
        self.setImage(self.currentImage?.imageFlippedForRightToLeftLayoutDirection(), for: .normal)
    }
}

extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

extension UINavigationBar {
    
    func setNavigationClear() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
    
    func removeNavigationClear() {
        self.setBackgroundImage(UIColor.white.colorToImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = false
    }

    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = color
        addSubview(bottomBorderView)
    }
    
    var shadow: Bool {
        get {
            return false
        }
        set {
            if newValue {
                self.layer.shadowOffset = CGSize(width: 0, height: 2)
                self.layer.shadowColor = UIColor.lightGray.cgColor
                self.layer.shadowRadius = 3
                self.layer.shadowOpacity = 0.5;
            }
        }
    }
}

extension UIColor {
    
    func colorToImage() -> UIImage
    {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let ctx = UIGraphicsGetCurrentContext()
        self.setFill()
        ctx!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    //random color
    static func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
}

extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){
        
        self.init()
        
        let path = CGMutablePath()
        
        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
            path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }
        
        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }
        
        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }
        
        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        path.closeSubpath()
        cgPath = path
    }
}

extension UIView {
    
    @IBInspectable var borderWidth : CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var radius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func halfWidth() -> CGFloat {
        return self.frame.size.width/2
    }

    func halfHeight() -> CGFloat {
        return self.frame.size.height/2
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func addDashedBorder(_ color : UIColor = UIColor.lightGray) {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [2,3]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func setRounded() {
        let radius = self.frame.height / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setRounded(radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    func addShadowView(color:UIColor,width:Int,height:Int,Opacity:Float,radius:CGFloat,cornerRadius:CGFloat) {
      self.layer.shadowColor = color.cgColor
      self.layer.shadowOffset = CGSize(width: width, height: height)
      self.layer.shadowOpacity = Opacity
      self.layer.shadowRadius = radius
      self.layer.masksToBounds = false
      self.layer.cornerRadius = cornerRadius
    }
    
    func setBorderGray() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }
    
    func setBorder(width:CGFloat,color:UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], gradientOrientation orientation: GradientOrientation) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func setShadowWithCornerRadius(width:Int,
                                   height:Int,
                                   opacity:Float,
                                   shadowRadius:CGFloat,
                                   color:UIColor,
                                   corners: CGFloat = 0) {
        
        self.layer.cornerRadius = corners
        let shadowPath2 = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowOpacity = opacity
        self.layer.shadowPath = shadowPath2.cgPath
        self.layer.shadowRadius = shadowRadius
        
    }
    
}

extension UIAlertController {
    func supportIpad(_ view:UIView){
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            // Ipad
            self.popoverPresentationController?.sourceView = view
            self.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        }
    }
}

extension UIStoryboard {
    func instance_vc<T: UIViewController>() -> T {
        guard let vc = instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
        }
        return vc
    }
}

extension String {
    var isEmptyStr:Bool{
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isValidPhone: Bool {
       let regularExpressionForPhone = "^\\d{3}\\d{3}\\d{4}$"
       let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
       return testPhone.evaluate(with: self)
    }
}

extension UIViewController {
    func showOkAlert(title:String = "",message:String) {
        
        // Create the dialog
        let width = self.view.frame.size.width - 60
        let popup = PopupDialog(title: title, message: message ,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn, preferredWidth: width,
                                tapGestureDismissal: false,
                                panGestureDismissal: false, hideStatusBar: false) {}
        
        let dialogAppearance = PopupDialogDefaultView.appearance()
        let align =  NSTextAlignment.center
//        dialogAppearance.titleFont            = MyTools.tool.appFont(size: 17)
//        dialogAppearance.messageFont          = MyTools.tool.appFont(size: 15)
        dialogAppearance.messageTextAlignment = align
        dialogAppearance.titleTextAlignment   = align
        
        let okButton = DefaultButton(title: "Ok".localized) {
            popup.dismiss()
        }
//        okButton.titleColor = Constant.PrimaryColor
//        okButton.titleFont = MyTools.tool.appFont(size: 16)
        popup.addButton(okButton)
        self.present(popup, animated: true, completion: nil)
    }
    
    func showOkAlertWithComp(title:String,message:String,completion:@escaping (Bool) -> Void) {
        
        let width = self.view.frame.size.width - 60
        let popup = PopupDialog(title: title, message: message ,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn, preferredWidth: width,
                                tapGestureDismissal: false,
                                panGestureDismissal: false, hideStatusBar: false) {}
        
        
        let dialogAppearance = PopupDialogDefaultView.appearance()
        let align =  NSTextAlignment.center
        
//        dialogAppearance.titleFont            = MyTools.tool.appFont(size: 17)
//        dialogAppearance.messageFont          = MyTools.tool.appFont(size: 15)
        dialogAppearance.messageTextAlignment = align
        dialogAppearance.titleTextAlignment   = align
        
        let okButton = DefaultButton(title: "Ok".localized) {
            completion(true)
        }
        
//        okButton.titleColor = Constant.PrimaryColor
//        okButton.titleFont = MyTools.tool.appFont(size: 16)
        popup.addButton(okButton)
        self.present(popup, animated: true, completion: nil)
    }
}

extension UITableView {
    
    func dequeueTVCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
        }
        return cell
    }
    
    func dequeueTHView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
        }
        return view
    }
    
    func registerHeaderView(id:UITableViewHeaderFooterView.Type){
        let _id = String(describing: id)
        self.register(UINib(nibName: _id, bundle: nil), forHeaderFooterViewReuseIdentifier: _id)
    }

    func registerCell(type: UITableViewCell.Type) {
        let id = String(describing: type)
        self.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
    }
    
    func layoutTableHeaderView() {
        
        guard let headerView = self.tableHeaderView else { return }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerWidth = headerView.bounds.size.width;
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": headerWidth], views: ["headerView": headerView])
        
        headerView.addConstraints(temporaryWidthConstraints)
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = headerSize.height
        var frame = headerView.frame
        
        frame.size.height = height
        headerView.frame = frame
        
        self.tableHeaderView = headerView
        
        headerView.removeConstraints(temporaryWidthConstraints)
        headerView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func reloadDataBy(indexPath: IndexPath) {
        UIView.setAnimationsEnabled(false)
        self.beginUpdates()
        self.reloadRows(at: [indexPath], with: .none)
        self.endUpdates()
        UIView.setAnimationsEnabled(true)
    }

}

extension UICollectionView {
    func dequeueCVCell<T: UICollectionViewCell>(indexPath:IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
        }
        return cell
    }
        
    func registerCell(type: UICollectionViewCell.Type) {
        let id = String(describing: type)
        self.register(UINib(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
    }
    
}

extension String {
    
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue]
        
        guard let html = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) else { return nil }
        return html
    }

    func replacingCharacter(newStr:String,range:NSRange) -> String {
        let str = NSString(string: self).replacingCharacters(in: range, with : newStr) as NSString
        return String(str)
    }
    
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: ".", with: "-").self.replacingOccurrences(of: "@", with: "-")
    }

    func middleLine() -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
//    func PlayVideo(on: UIViewController) {
//        let controller = AVPlayerViewController()
//        if let videourl = URL(string: self) {
//            controller.player = AVPlayer(url: videourl)
//            controller.modalTransitionStyle = .coverVertical
//            controller.modalPresentationStyle = .custom
//            on.present(controller, animated: true, completion: {
//                controller.player?.play()
//            })
//        }
//    }

    func OpenURL() {
        if let url = URL.init(string: self) {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                        
                    })
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    func stringToDate(_ format: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US")
//        formatter.timeZone = TimeZone.init(identifier: "UTC")
        return formatter.date(from: self) ??  Date()
    }

    func dateFormat(_ format: String = "dd/MM/yyyy") -> (String,String) {
        let newDate = self.stringToDate(format).dateToString("dd MMM")
        let newYear = self.stringToDate(format).dateToString("yyyy")
        return (newDate, newYear)
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var containsWhitespace : Bool {
        return (self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    var containtSpecialCharacter : Bool {
        let characterset = CharacterSet(charactersIn: "!@#$%^&*()=<>?/\';~`٫±§")
        //"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-_")
        return self.rangeOfCharacter(from: characterset) != nil ?  true : false
    }
    
    //cut first caracters from full names
    public func getAcronyms(separator: String = "") -> String {
        let acronyms = self.components(separatedBy: " ").map({ String($0.first!) }).joined(separator: separator);
        return acronyms;
    }
    
    //remove spaces from text
    var trimmed:String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var prepareFilterFirstString : String {
        return self.trimmed.first?.description ?? ""
    }
    
    var isEmailValid: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isMobileValid: Bool {
        do {
            let regStr2 =  "^(1)?[0-9]{3}?[0-9]{3}?[0-9]{4}$"
            let regex = try NSRegularExpression(pattern: regStr2, options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isUrlValid : Bool {
        if let url = URL.init(string: self){
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    var color: UIColor {
        let hex = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return UIColor.clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    var cgColor: CGColor {
        return self.color.cgColor
    }
    
    var TrimAllSpaces:String {
        return self.components(separatedBy: .whitespacesAndNewlines).joined()
    }
    
    var TrimWhiteSpaces:String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }
    
    func SizeOf(_ font: UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font: font])
    }
    
    func stringSize()-> CGSize {
        let size  = (self as NSString).size(withAttributes: nil)
        return size
    }

    var removeHtmlTags:String {
        //        return   self.replacingOccurrences(of: "<div*></div>", with: "")
        let regex:NSRegularExpression  = try! NSRegularExpression(  pattern: "<.*?>", options: .caseInsensitive)
        let range = NSMakeRange(0, self.count)
        let htmlLessString :String = regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(), range:range , withTemplate: "")
        
        return htmlLessString.replacingOccurrences(of: "&amp;", with: "")
    }
    
    var toImage: UIImage {
        if self == "" {
            return UIImage()
        }else{
            return UIImage(named: self) ?? UIImage()
        }
    }
    
}

//extension UITextView {
//    func switchDirection() {
//        if Auth_User._Language == "ar" {
//            self.textAlignment = .right
//        }else{
//            self.textAlignment = .left
//        }
//    }
//}

extension UITextField {
    
//    func switchDirection() {
//        if Auth_User._Language == "ar" {
//            self.textAlignment = .right
//        }else{
//            self.textAlignment = .left
//        }
//    }

    //@Change placeholder color
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    func setLeftView(width:Int){
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: width, height: Int(self.frame.size.height))
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    func setRightView(width:Int) {
        let rightView = UIView()
        rightView.frame = CGRect(x: 0, y: 0, width: width, height: Int(self.frame.size.height))
        self.rightView = rightView
        self.rightViewMode = .always
    }
    
}

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
}

extension UINavigationController {
    func pop(animated: Bool) {
        _ = self.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        _ = self.popToRootViewController(animated: animated)
    }
}

//extension UINavigationItem {
//
//    func centerImage(img: String = "icon_Nav") {
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 15))
//        imageView.contentMode = .scaleAspectFit
//        imageView.center = UINavigationBar.appearance().center
//
//        let image = UIImage(named: img)
//        imageView.image = image
//
//        self.titleView = imageView
//    }
//
//    func hideBackWord()  {
//        let backItem = UIBarButtonItem()
//        backItem.title = ""
//        self.backBarButtonItem = backItem
//    }
//}

extension UIViewController {
    
    var Nav_Title : String {
        get{
            return self.navigationItem.title ?? ""
        }
        set(title) {
            return self.navigationItem.title = title
        }
    }
    
    func centerImage(img: String = "icon_Nav") {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 15))
        imageView.contentMode = .scaleAspectFit
        imageView.center = UINavigationBar.appearance().center
        
        let image = UIImage(named: img)
        imageView.image = image
        
        self.navigationItem.titleView = imageView
    }
    
    func hideBackWord()  {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
    
    func hideShowNav(isHidden: Bool = false, animated: Bool = true) {
        self.navigationController?.setNavigationBarHidden(isHidden, animated: animated)
    }

    func showToast(_ message:String, backgroundColor : UIColor = color_517FF6) {
        let snackbar: TTGSnackbar = TTGSnackbar(message: message, duration: .middle)
        
        // Change the content padding inset
        snackbar.contentInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 7, right: 8)

        // Change margin
        snackbar.leftMargin = 0
        snackbar.rightMargin = 0
//        snackbar.topMargin = 0
        snackbar.bottomMargin = 0
        snackbar.cornerRadius = 0

        // Change message text font and color
        snackbar.backgroundColor = backgroundColor
        snackbar.messageTextColor = .white
        snackbar.messageTextFont = MyTools.appFont(size: 15)
        snackbar.messageTextAlign = .left

        // Change animation duration
        snackbar.animationDuration = 0.5

        // Animation type
        snackbar.animationType = .slideFromBottomBackToBottom
        snackbar.show()
    }

}
class MyTools: NSObject {
    
    static func appFont(name: e_font_type = .Regular, size: CGFloat = 16) -> UIFont {
        let font = UIFont.init(name: name.rawValue, size: size)
        return font ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func printAllFont() {
        for familyName in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: familyName ) {
                print("\(familyName) : \(fontName)")
            }
        }
    }
    
    static func randomString(length: Int) -> String {
        
        let letters : NSString = "0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

// Set Gradient To Any View
typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    
    var startPoint : CGPoint {
        get { return points.startPoint }
    }
    
    var endPoint : CGPoint {
        get { return points.endPoint }
    }
    
    var points : GradientPoints {
        get {
            switch(self) {
            case .topRightBottomLeft:
                return (CGPoint.init(x: 0.0,y: 1.0), CGPoint.init(x: 1.0,y: 0.0))
            case .topLeftBottomRight:
                return (CGPoint.init(x: 0.0,y: 0.0), CGPoint.init(x: 1,y: 1))
            case .horizontal:
                return (CGPoint.init(x: 0.0,y: 0.5), CGPoint.init(x: 1.0,y: 0.5))
            case .vertical:
                return (CGPoint.init(x: 0.0,y: 0.0), CGPoint.init(x: 0.0,y: 1.0))
            }
        }
    }
}

extension UILabel {
    func setUnderLine() {
        let textRange = NSMakeRange(0, self.text!.count)
        let attributedText = NSMutableAttributedString(string: self.text!)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle,
                                    value:NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        
        self.attributedText = attributedText
    }
}

extension UIScreen {
    var sizeType: SizeType {
        switch nativeBounds.height {
        case 960:
            return .iPhones4
        case 1136:
            return .iPhones5_SE
        case 1334:
            return .iPhones678
        case 1792:
            return .iPhone_XR
        case 1920, 2208:
            return .iPhones_678Plus
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax
        default:
            return .unknown
        }
    }
    
    enum SizeType: String {
        case iPhones4 = "iPhone 4 or iPhone 4S"
        case iPhones5_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones678 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_678Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR = "iPhone XR"
        case iPhone_XSMax = "iPhone XS Max"
        case unknown
    }
}

extension UIAlertController {
    
    func addCustomAction(_ title:String ,_ completion: ((UIAlertAction) -> Void)? = nil){
        self.addAction(UIAlertAction(title: title, style: .default, handler: { (alert) in
            completion?(alert)
        }))
    }
    
    func addDestructiveAction(_ title:String ,_ completion: ((UIAlertAction) -> Void)? = nil){
        self.addAction(UIAlertAction(title: title, style: .destructive, handler: { (alert) in
            completion?(alert)
        }))
    }
    
    
    func addCancelAction(_ title:String,_ completion: ((UIAlertAction) -> Void)? = nil){
        self.addAction(UIAlertAction(title: title, style: .cancel, handler: { (alert) in
            completion?(alert)
        }))
    }
    
    
//    func supportIpad(_ view:UIView){
//        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
//        {
//            // Ipad
//            self.popoverPresentationController?.sourceView = view
//            self.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
//        }
//    }
}
