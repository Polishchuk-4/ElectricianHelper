//
//  SwitcherListVC.swift
//  CoreData
//
//  Created by Denis Polishchuk on 19.07.2022.
//

import UIKit

enum SwitchesType {
    case choose
    case list
}

protocol SwitchesListVCDelegate {
    func get(switcher: Switcher)
}

class SwitchesListVC: UITableViewController {
    var switches: [Switcher] = []
    var switchesType: SwitchesType = .list
    var myDelegate: SwitchesListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSwitcher))
        self.navigationController?.navigationBar.tintColor = .text
        self.navigationItem.title = "Swithes list"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.switches = CoreDataManager.shared.getSwitherList()
        self.setTheme()
        self.tableView.reloadData()
    }
    
    private func setTheme() {
        self.view.backgroundColor = UIColor.background
        self.navigationController?.navigationBar.tintColor = .text
        self.navigationController?.tabBarController?.tabBar.tintColor = .text
        self.navigationController?.navigationBar.barTintColor = .background
        self.navigationController?.tabBarController?.tabBar.barTintColor = .background
    }
    
    @objc private func addSwitcher() {
        let vc = SwitcherVC()
        let switcher = CoreDataManager.shared.createSwitcher()
        vc.switcher = switcher
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.switches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idCell = "switcher"
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell) as? CellImage
        if cell == nil {
            cell = CellImage(style: .value1, reuseIdentifier: idCell)
            cell?.selectionStyle = .none
        }
        let switcher = self.switches[indexPath.row]
        if let photoData = switcher.photo {
            cell?.imgView.image = UIImage(data: photoData)
        } else {
            cell?.imgView.image = UIImage.init(systemName: "photo")
        }
        self.createDot(cell: cell!, switcher: switcher)
        return cell!
    }
    
    private func createDot(cell: CellImage, switcher: Switcher) {
        var dot: UIView
        if let v = cell.imgView.subviews.first {
            dot = v
        } else {
            dot = UIView()
            dot.frame.size = CGSize(width: 10, height: 10)
            dot.layer.cornerRadius = dot.frame.height / 2
            dot.backgroundColor = .magenta
            cell.imgView.addSubview(dot)
        }
        dot.center = self.setDotPosition(imgView: cell.imgView, switcher: switcher)
    }
    
    private func setDotPosition(imgView: UIImageView, switcher: Switcher) -> CGPoint {
        let imageSizeStr = UserDefaultsManager.shared.sizeImgView
        let componentsSize = imageSizeStr.components(separatedBy: " ")
        let hight = (componentsSize[1] as NSString).doubleValue
        let ratio = hight / imgView.frame.height
        let positionStr = switcher.centrePoint
        let componentsPosition = positionStr!.components(separatedBy: " ")
        let x = (componentsPosition[0] as NSString).doubleValue
        let y = (componentsPosition[1] as NSString).doubleValue
        let finX = x / ratio
        let finY = y / ratio
        return CGPoint(x: finX, y: finY)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellImage.height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.switchesType == .list {
            let vc = SwitcherVC()
            let switcher = self.switches[indexPath.row]
            vc.switcher = switcher
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.myDelegate.get(switcher: self.switches[indexPath.row])
            dismiss(animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let switcher = self.switches.remove(at: indexPath.row)
        CoreDataManager.shared.delete(swither: switcher)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if self.switchesType == .choose {
            return false
        } else {
            return true
        }
    }
}
