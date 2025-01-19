//
//  FeatureRequestViewModel.swift
//  Money
//
//  Created by Iacob Zanoci on 19/01/2025.
//

import SwiftUI

class FeatureRequestViewModel: ObservableObject {
    
    @Published var canSendMail: Bool = UIApplication.shared.canOpenURL(URL(string: "mailto:")!)
    let recipientEmail: String = "iacobzanoci.work@gmail.com"
    let emailSubject: String = "Feature Request"
    
    var emailBody: String {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Unknown App"
        let iosVersion = UIDevice.current.systemVersion
        let deviceModel = DeviceInfo.getDeviceName()
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown Version"
        let appBuild = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown Build"
        
        return """
        
        
        
        Application name: \(appName)
        iOS: \(iosVersion)
        Device Model: \(deviceModel)
        App version: \(appVersion)
        App Build: \(appBuild)
        """
    }
    
    func openMailApp() {
        let subjectEncoded = emailSubject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let bodyEncoded = emailBody.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let email = recipientEmail
        let mailURL = URL(string: "mailto:\(email)?subject=\(subjectEncoded)&body=\(bodyEncoded)")!
        
        if UIApplication.shared.canOpenURL(mailURL) {
            UIApplication.shared.open(mailURL)
        } else {
            print("Mail app not available.")
        }
    }
}
