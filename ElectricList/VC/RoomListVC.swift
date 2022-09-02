//
//  ViewController.swift
//  CoreData
//
//  Created by Denis Polishchuk on 19.07.2022.
//

import UIKit

class RoomListVC: UITableViewController {
    var rooms: [Room] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Room list"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRoom))
        self.addButtonSettingUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rooms = CoreDataManager.shared.getRooms()
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
    
    private func addButtonSettingUser() {
        let image = "person.fill".getSymbol(pointSize: 25, weight: .light)
        let finalButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingUser))
        self.navigationItem.leftBarButtonItem = finalButton
    }
    
    @objc private func settingUser() {
        let vc = SettingUser()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc private func addRoom() {
        let vc = RoomVC()
        vc.room = CoreDataManager.shared.createRoom()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rooms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idCell = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell) as? CellImageLabelRoomListVC
        if cell == nil {
            cell = CellImageLabelRoomListVC(style: .value1, reuseIdentifier: idCell)
            cell?.selectionStyle = .none
        }
        let room = self.rooms[indexPath.row]
        if let photoData = room.photo {
            cell?.imgView.image = UIImage(data: photoData)
            cell?.imgView.contentMode = .scaleAspectFill
            cell?.imgView.clipsToBounds = true
        } else {
            cell?.imgView.image = UIImage.init(systemName: "photo")
            cell?.imgView.contentMode = .scaleAspectFit

        }
        
        cell?.label.text = room.name
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellImageLabelRoomListVC.height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RoomVC()
        let objc = self.rooms[indexPath.row]
        vc.room = objc
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let room = self.rooms.remove(at: indexPath.row)
        CoreDataManager.shared.delete(room: room)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}

