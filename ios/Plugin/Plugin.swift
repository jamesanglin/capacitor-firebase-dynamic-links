import Foundation
import Capacitor
import FirebaseCore
import FirebaseDynamicLinks

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(FirebaseDynamicLinks)
public class FirebaseDynamicLinks: CAPPlugin {

    public override func load() {
         if FirebaseApp.app() == nil {
             FirebaseApp.configure()
         }

         DynamicLinks.performDiagnostics(completion: nil)

         NotificationCenter.default.addObserver(self, selector: #selector(handleUrlOpened(notification:)), name: Notification.Name(CAPNotifications.URLOpen.name()), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(handleUniversalLink(notification:)), name: Notification.Name(CAPNotifications.UniversalLinkOpen.name()), object: nil)
    }
    
    
    @objc func handleUrlOpened(notification: NSNotification) {
        guard
          let object = notification.object as? [String: Any?],
          let url = object["url"] as? URL
        else {
            print("CapacitorFirebaseDynamicLinks.handleUrlOpened() - couldn't parse url from notification")
            return
        }

        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
          self.handleLink(dynamicLink)
        } else {
          // This is likely to be a custom URL from some other process
      }
    }

    @objc func handleUniversalLink(notification: NSNotification) {
        guard
            let object = notification.object as? [String: Any?],
            let url = object["url"] as? NSURL,
            let parsed = URL(string: url.absoluteString!)
        else {
            print("CapacitorFirebaseDynamicLinks.handleUniversalLink() - couldn't parse url from notification")
            return
        }

        let response = DynamicLinks.dynamicLinks().handleUniversalLink(parsed) { (dynamiclink, error) in
            guard error == nil else {
              print("handleUniversalLink -> error: \(String(describing: error?.localizedDescription))")
              return
            }

            if let dynamicLink = dynamiclink {
              self.handleLink(dynamicLink)
            }
        }

        if !response {
            print("""
              CapacitorFirebaseDynamicLinks.handleUniversalLink()
              Unable to parse dynamic link. Please ensure you have set up Firebase Dynamic Links correctly.
            """)
        }
    }

    func handleLink(_ dynamicLink: DynamicLink) {
      guard let url = dynamicLink.url else {
        print("CapacitorFirebaseDynamicLinks.handleLink() - Dynamic link has no url")
        return
      }

      print("CapacitorFirebaseDynamicLinks.handleLink() - url: \(url.absoluteString)")

      self.notifyListeners("deepLinkOpen", data: ["url": url.absoluteString], retainUntilConsumed: true)
    }
    
    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.success([
            "value": value
        ])
    }
}
