//
//  SSOController.swift
//  bushnell-sso
//
//  Created by kwanso-ios on 5/8/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//

import UIKit
import SafariServices
import MBProgressHUD
import CommonCryptoModule

public class SSOController: UIViewController, SFSafariViewControllerDelegate {

//    init(target: UIViewController) {
//        self.nextTarget = target
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    var mtarget: UIViewController?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func registerNotification() {
        
        /**********
         //:- Register to handle the deep link notification.
         **********/
        
        print("---- registerNotification ----")
        
//        NOTIFICATION_CENTER.addObserver(self, selector: #selector(callTokenApi), name: NSNotification.Name(rawValue: SUCCESS_DEEPLINK_CODE), object: nil)
//        NOTIFICATION_CENTER.addObserver(self, selector: #selector(failWebResp), name: NSNotification.Name(rawValue: FAIL_DEEPLINK_CODE), object: nil)
//        NOTIFICATION_CENTER.addObserver(self, selector: #selector(reloadSafariTab), name: NSNotification.Name(rawValue: NO_DEEPLINK_CODE), object: nil)
    }
 
    
    // MARK: - Notification Handler Method
    
    @objc func failWebResp() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func reloadSafariTab() {
        
        self.dismiss(animated: true, completion: nil)
        Timer.scheduledTimer(timeInterval: TimeInterval(0.5), target: self, selector: #selector(openSafariTab), userInfo: nil, repeats: false)
    }
    
    @objc public func openSafariTab() {
        
        /**********
         //:- Open Safari Tab from call back URL through Brodcast Notification
         **********/
        
        //launchSafariTabWithPath(urlPath: "\(WEB_AUTH_BASE_URL)\(IOS_CLIENT_ID)\(WEB_AUTH_BASE_URL_SECOND)\(self.getEncryptedVerifierCode(IOS_CODE_VERIFIER))\(WEB_AUTH_BASE_URL_THIRD)")
        
        //        launchSafariTabWithCustomPath(urlPath: "\(WEB_AUTH_BASE_URL)\(IOS_CLIENT_ID)\(WEB_AUTH_BASE_URL_SECOND)\(self.getEncryptedVerifierCode(IOS_CODE_VERIFIER))\(WEB_AUTH_BASE_URL_THIRD)", viewController: self)
    }
    
    public func setBackgroundGradient(view: AnyObject) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.bushnellGrayColor().cgColor,  UIColor.silverColor().cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public func setBorderLayout(_ yourView: AnyObject, withWidth borderWidth: CGFloat, andColor borderColor: UIColor, cornerRadius radius: CGFloat) {
        
        yourView.layer.cornerRadius = radius
        yourView.layer.borderColor = borderColor.cgColor
        yourView.layer.borderWidth = borderWidth
    }
 
    public func ssoAthuntication(target: UIViewController) {
        
        //:- authentication url path e.g (client_url + client_id + remaining url path + encrypted code_verifier + code_challenge_method)
        
        let urlPath = "\(WEB_AUTH_BASE_URL)\(IOS_CLIENT_ID)\(WEB_AUTH_BASE_URL_SECOND)\(self.getEncryptedVerifierCode(IOS_CODE_VERIFIER))\(WEB_AUTH_BASE_URL_THIRD)"
        
        //let code_verifier = "k2oYXKqiZrucvpgengXLeM1zKwsygOuURBK7b4-PB68"
        //let urlPath = "\(WEB_AUTH_BASE_URL)\(IOS_CLIENT_ID)\(WEB_AUTH_BASE_URL_SECOND)\(code_verifier)\(WEB_AUTH_BASE_URL_THIRD)"
        
        
        print(urlPath)
        guard let url = URL(string: urlPath) else { return }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.dismissButtonStyle = .cancel
        safariVC.modalPresentationStyle = .overFullScreen
        //safariVC.delegate = self as SFSafariViewControllerDelegate
        
        target.present(safariVC, animated: true, completion: nil)
    }
    
    
    public func logoutSSOAuthentication(viewController: UIViewController) {
        
        //:- Logout url path e.g (client_url + session/end)
        
        guard let url = URL(string: WEB_AUTH_ENG_SESSION_URL) else { return }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.dismissButtonStyle = .cancel
        safariVC.modalPresentationStyle = .overFullScreen
        safariVC.delegate = self as SFSafariViewControllerDelegate
        viewController.present(safariVC, animated: true, completion: nil)
    }
    
    public func updateSSOProfile(viewController: UIViewController) {
        /*
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: PROFILE_IDENTIFIER) as! ProfileViewController
        viewController.navigationController?.pushViewController(vc, animated: true)
        */
        //let rootViewController = AppDel.window!.rootViewController as! UINavigationController
        //rootViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Auth Api Method
    
    //:- Call APi for access_token fetching
    
    public func callSSOTokenApiWithCodeCompletion(code: String, target: UIViewController, completion: @escaping (Bool?) -> Void) {
        
        self.mtarget = target
        
        if code.count > 0 {
            completion(true)
        }else{
            completion(false)
        }
        
    }
    
    public func callSSOTokenApiWithCode(code: String, target: UIViewController) {
        
        print(code)
        
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        
        self.mtarget = target
        
        //target.dismiss(animated: true, completion: nil)
        
        self.callTokenApi(code: code)

        
    }
    
    
    @objc func callTokenApi(code: String) {
        
        _ = MBProgressHUD.showHUDAddedGlobal()

        //:- Pass the parameter "code" and "code verifier"

        BushnellAPI.sharedInstance.tokenApi(responseCode: code as String, codeVerifier: IOS_CODE_VERIFIER as String) { (success, response) -> Void in
            if (success) {

                print("--response ------ ",response as Any)
                self.userInfoApi(accessToken: (CurrentUser.sharedInstance.tokenObject?.access_token)!)
            }
            else {
                if response != nil {
                    //UtilityHelper.showAlertWithM`essageAndTarget(ALERT_TITLE, message: response![ERROR_DESCRIPTION] as? String, btnTitle: OK, target: self)
                }

                MBProgressHUD.dismissGlobalHUD()
            }
        }
    }
 
    
    func userInfoApi(accessToken: String) {
        
        //:- Pass the parameter with access_token
        
        BushnellAPI.sharedInstance.userInfoApi(accessToken as String) { (success, response) -> Void in
            if (success) {
                
                print("-- userInfoApi ------ ",response as Any)
                
                MBProgressHUD.dismissGlobalHUD()
                
                self.mtarget!.dismiss(animated: true, completion: nil)
                //AppDel.setRootController(identifierName: DASHBOARD_IDENTIFIER)
            }
            else {
                if response != nil {
                    //UtilityHelper.showAlertWithMessageAndTarget(ALERT_TITLE, message: response![ERROR_DESCRIPTION] as? String, btnTitle: OK, target: self)
                }
                
                MBProgressHUD.dismissGlobalHUD()
            }
        }
    }
    
    
 
    // MARK: - SHA Encryption
    
    func getEncryptedVerifierCode(_ verifier: String) -> String {
        
        guard let data = verifier.data(using: .utf8) else { return "" }
        var buffer = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(data.count), &buffer)
        }
        let hash = Data(bytes: buffer)
        let encryptedVerifier = hash.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "\\_")
            .replacingOccurrences(of: "=", with: "")
            .trimmingCharacters(in: .whitespaces)
        
        return encryptedVerifier
    }
 
    // MARK: - Safari Delegates
    
    private func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        
        print("safariiii")
        
        //:- Delete sesison info
        if didLoadSuccessfully {
            //CurrentUser.sharedInstance.logOut()
        }
        
        AppDel.window?.rootViewController!.dismiss(animated: true, completion: nil)
    }
    
}