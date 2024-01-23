//
//  ContainerViewController.swift
//  side menu
//
//  Created by SUMSKAR PC on 22/01/24.
import UIKit

class ContainerViewController: UIViewController {
    enum MenuState {
        case opened
        case closed
    }

    private var menuState: MenuState = .closed
    let menuVC = MenuViewController()
    var homeVC = HomeViewController()
    var navVC: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVCs()
    }

    private func addChildVCs() {
        // Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)

        // Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC // Assign a value to navVC
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }

    func toggleMenu(completion: (() -> Void)?) {
        // Animate the menu
        switch menuState {
        // Open it
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            } completion: { done in
                if done {
                    self.menuState = .opened
                }
            }

        // Close it
        case .opened:
            // Implement your closing animation logic here
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                // changing origin x to zero
                self.navVC?.view.frame.origin.x = 0
            } completion: { done in
                if done {
                    self.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        print("did Select")
        toggleMenu {
            switch menuItem {
            case .home:
                // go to a different view controller for the "home" option
                break
            case .info:
                let vc = InfoViewController()
                self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            case .appRating:
                // handle app rating
                break
            case .shareApp:
                // handle sharing the app
                break
            case .settings:
                // handle settings
                break
            }
        }
    }
}
