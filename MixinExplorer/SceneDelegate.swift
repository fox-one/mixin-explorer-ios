import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var store: Store?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let store = createStore(connectionOptions.urlContexts)
        showMainTab(scene: scene, with: store)
    }
    
    private func showMainTab(scene: UIScene, with store: Store) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView:
                MainTab().environmentObject(store)
            )
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        let store = createStore(URLContexts)
         showMainTab(scene: scene, with: store)
    }
    
    private func createStore(_ URLContexts: Set<UIOpenURLContext>) -> Store {
           let store = Store()
           guard let url = URLContexts.first?.url,
                 let components =
                   URLComponents(url: url, resolvingAgainstBaseURL: false)
           else {
               return store
           }

           switch (components.scheme, components.host) {
           case ("mixinexplorer", "snapshot"):
               guard let idQuery = (components.queryItems?.first {
                       $0.name == "id"
                     }),
                     let idString = idQuery.value
               else {
                   break
               }
               
               store.dispatch(.loadSnapshot(snopshotID: idString))
               store.appState.settings.showSnapshot.showSnapshot = true
           default:
               break
           }
        self.store = store
           return store
       }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        self.store?.dispatch(.loadMixinNode)
        self.store?.dispatch(.loadMixinTopAssets)
        self.store?.dispatch(.loadMixinAssets)
    }

    func sceneWillResignActive(_ scene: UIScene) {
   
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

