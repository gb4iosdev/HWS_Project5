//
//  ViewController.swift
//  Project5
//
//  Created by Gavin Butler on 2018-10-08.
//  Copyright © 2018 Gavin Butler. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordPath) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        startGame()
    }

    func startGame() {
        if let allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as? [String] {
            title = allWords[0]
            usedWords.removeAll()
            tableView.reloadData()
        }
    }
    
    /// MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
            cell.textLabel?.text = usedWords[indexPath.row]
            return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [unowned self, ac] (action: UIAlertAction) in
            let answer = ac.textFields![0]
            self.submit(answer: answer.text!)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(answer: String) {
        let lowerAnswer = answer.lowercased()
        
        let wordError: WordCheckError
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                } else {
                    wordError = .notReal
                }
            } else {
                wordError = .notOriginal
            }
        } else {
            wordError = .notPossible
        }
        
        let ac = UIAlertController(title: wordError.title, message: wordError.message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
    
    func isPossible(word: String) -> Bool { //Can be made from the letters of the shown word
        var titleWord = title!.lowercased()
        
        for letter in word {
            if let pos = titleWord.range(of: String(letter)) {
                titleWord.remove(at: pos.lowerBound)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool { //Isn't duplicate of a word already made
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool { //Is an actual English word
        
        let range = NSMakeRange(0, word.utf16.count)
        let misspelledRange = UITextChecker().rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
}

