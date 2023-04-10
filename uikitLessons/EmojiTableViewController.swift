//
//  EmojiTableViewController.swift
//  uikitLessons
//
//  Created by Илья Клюковский on 09.04.2023.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    //создаем моковые данные из структуры модели
    var objects = [
        Emoji(emoji: "👨‍💻", name: "Программирование", description: "Программируй это", isFavorite: false),
        Emoji(emoji: "🎁", name: "Подарок", description: "Дарите подарки от души", isFavorite: false),
        Emoji(emoji: "🌙", name: "Луна", description: "Луна светит каждую ночь", isFavorite: false),
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        //элменты хэдера таблицы
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.title = "Emoji reader"
        
        //Регистрация ячейки по умолчанию. Не нужно потому что мы настроили свою ячейку через сториборд.
        //        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func unwindSegue (segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else {return}
        
        let sourceVC = segue.source as! NewEmojiTableViewController
        
        if let selectedIdxPath = tableView.indexPathForSelectedRow {
            objects[selectedIdxPath.row] = sourceVC.emoji
            tableView.reloadRows(at: [selectedIdxPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: objects.count, section: 0)
            objects.append(sourceVC.emoji)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else {return}
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        let navVC = segue.destination as! UINavigationController
        let newEmojiVC = navVC.topViewController as! NewEmojiTableViewController
        newEmojiVC.emoji = emoji
        newEmojiVC.title = "Редактирование"
    }
    
    // MARK: - Table view data source
    
    //регистрация кол-ва секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //регистрация кол-ва ячеек - берем из массива данных
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }
    
    
    //регистрация ячейки из собственного класса EmojiTableViewCell, вызывается столько раз сколько передано ячеек
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //кастим UITableViewCell к своему классу EmojiTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        
        let object = objects[indexPath.row]
        
        //вынесли настройку ячейки в отдельную функцию в классе ячейки
        cell.set(object: object)
        
        
        //        var content = cell.defaultContentConfiguration()
        //        content.text = "\(indexPath)"
        //        cell.contentConfiguration = content
        
        
        return cell
    }
    
    //действие при нажатии на редактироние таблицы
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //отслеживание нажатия на кнопку и действие с данными
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool { true }
    
    
    //перемещение ячейки от индекса индекса
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //удаляем нужну ячейку
        let moveEmoji = objects.remove(at: sourceIndexPath.row)
        //вставляем в массив с индексом куда
        objects.insert(moveEmoji, at: destinationIndexPath.row)
        //обновляем таблицу
        tableView.reloadData()
    }
    
    //создание экшена по свайпу
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let like = likeAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [like])
    }
    
    //создание кнопки экшена и действия с данными
    func likeAction (at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Like") { action, view, completion in
            
            self.objects[indexPath.row].isFavorite = !self.objects[indexPath.row].isFavorite
            
            completion(true)
        }
        action.backgroundColor = .systemBlue
        if self.objects[indexPath.row].isFavorite {
            action.image = UIImage(systemName: "hand.thumbsup.fill")
        } else {
            action.image = UIImage(systemName: "hand.thumbsup")
        }
        
        return action
    }
    
    
    
}
