//
//  MenuViewController.swift
//  side menu
//
//  Created by SUMSKAR PC on 22/01/24.
//
import UIKit
var greyColor=UIColor(red: 33/225.0, green: 33/225.0, blue: 33/225.0, alpha: 1)
protocol MenuViewControllerDelegate:AnyObject{
    func didSelect(menuItem:MenuViewController.MenuOptions)
}
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    weak var delegate:MenuViewControllerDelegate?
    enum MenuOptions: String, CaseIterable {
        case home = "Home"
        case info = "Information"
        case appRating = "App Rating"
        case shareApp = "Share App"
        case settings = "Settings"
        var imageName:String{
            switch self{
                
            case .home:
                return "house"
            case .info:
                return "airplane"
            case .appRating:
                return "star"
            case .shareApp:
                return "message"
            case .settings:
                return "gear"
            }
        }
        static var allCases: [MenuOptions] {
            return [.home, .info, .appRating, .shareApp, .settings]
        }
    }

    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor=nil
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = greyColor
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height - view.safeAreaInsets.top)
    }

    // Table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
       
        cell.imageView?.image=UIImage(systemName:MenuOptions.allCases[indexPath.row].imageName )
        cell.imageView?.tintColor = .white
        cell.textLabel?.textColor = .white
        cell.backgroundColor=greyColor
        cell.contentView.backgroundColor=greyColor
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item=MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
}
