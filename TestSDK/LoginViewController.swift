//
//  LoginViewController.swift
//  TestSDK
//
//  Created by kwanso-ios on 5/8/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//

import UIKit
import Alamofire

public class LoginViewController: UIViewController {

    @IBOutlet private var viewBtn: UIView!
    
    let ssoVC = SSOController()
    
    public init() {
        super.init(nibName: "LoginViewController", bundle: Bundle(for: LoginViewController.self))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        /**********
         //:- Set screens background Gradient and buttons border styling.
         **********/
        
        self.setGradientBackground(view: self.view)
        self.setViewBorder(self.viewBtn, withWidth: 2.0, andColor: UIColor.busnellOrangeColor(), cornerRadius: 6.0)
        
        /**********
         //:- Register to handle the deep link notification.
         **********/
        
        NOTIFICATION_CENTER.addObserver(self, selector: #selector(callTokenApi), name: NSNotification.Name(rawValue: SUCCESS_DEEPLINK_CODE), object: nil)
        NOTIFICATION_CENTER.addObserver(self, selector: #selector(failWebResp), name: NSNotification.Name(rawValue: FAIL_DEEPLINK_CODE), object: nil)
        NOTIFICATION_CENTER.addObserver(self, selector: #selector(reloadSafariTab), name: NSNotification.Name(rawValue: NO_DEEPLINK_CODE), object: nil)
        
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
    }
    
    // MARK: - SHA Encryption
    /*
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
    */
    // MARK: - Auth Api Method
    
    //:- Call APi for access_token fetching
    
    @objc func callTokenApi() {
    /*
        _ = MBProgressHUD.showHUDAddedGlobal()
        
        let code = AppDel.deepLinkCode
        let code_verifier = IOS_CODE_VERIFIER
        
        //:- Pass the parameter "code" and "code verifier"
        
        BushnellAPI.sharedInstance.tokenApi(responseCode: code as String, codeVerifier: code_verifier as String) { (success, response) -> Void in
            if (success) {
                
                self.userInfoApi(accessToken: (CurrentUser.sharedInstance.tokenObject?.access_token)!)
            }
            else {
                if response != nil {
                    UtilityHelper.showAlertWithMessageAndTarget(ALERT_TITLE, message: response![ERROR_DESCRIPTION] as? String, btnTitle: OK, target: self)
                }
                
                MBProgressHUD.dismissGlobalHUD()
            }
        }
         */
    }
    /*
    func userInfoApi(accessToken: String) {
        
        //:- Pass the parameter with access_token
        
        BushnellAPI.sharedInstance.userInfoApi(accessToken as String) { (success, response) -> Void in
            if (success) {
                
                MBProgressHUD.dismissGlobalHUD()
                
                AppDel.setRootController(identifierName: DASHBOARD_IDENTIFIER)
            }
            else {
                if response != nil {
                    UtilityHelper.showAlertWithMessageAndTarget(ALERT_TITLE, message: response![ERROR_DESCRIPTION] as? String, btnTitle: OK, target: self)
                }
                
                MBProgressHUD.dismissGlobalHUD()
            }
        }
    }
    */
    
    // MARK: - Action
    
    @IBAction func actionOpenSSO(_ sender: Any) {
        
        /**********
         //:- Open Safari Tab for User login and signup
         //:- authentication url path e.g (client_url + client_id + remaining url path + encrypted code_verifier + code_challenge_method)
         **********/
        
        print("username")
        
        ssoVC.ssoAthuntication(target: self)
        
//        launchSafariTabWithPath(urlPath: "\(WEB_AUTH_BASE_URL)\(IOS_CLIENT_ID)\(WEB_AUTH_BASE_URL_SECOND)\(self.getEncryptedVerifierCode(IOS_CODE_VERIFIER))\(WEB_AUTH_BASE_URL_THIRD)")
    }

}
