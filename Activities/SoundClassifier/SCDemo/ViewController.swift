//
//  ViewController.swift
//  SCDemo
//
//  Created by Mars Geldard on 12/6/19.
//  Copyright © 2019 Mars Geldard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var recordButton: ThreeStateButton!
    
    @IBAction func recordButtonPressed(_ sender: Any) { toggleRecording() }
    
    private var recording: Bool = false
    private var classification: Animal?
    // TODO: needs something to query for sound classification

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
    }
    
    private func refresh(clear: Bool = false) {
        if clear { classification = nil }
        collectionView.reloadData()
    }
    
    private func toggleRecording() {
        recording = !recording
        
        if recording {
            refresh(clear: true)
            recordButton.changeState(to: 
                .inProgress(
                    title: "Stop", 
                    color: .systemRed
                )
            )
            
            // TODO: start collection/doing something with the sound input
            
        } else {
            refresh()
            recordButton.changeState(
                to: .enabled(
                    title: "Record Sound", 
                    color: .systemBlue
                )
            )
            
            // TODO: stop accepting/doing something with the sound input
        }
    }

    private func classify(_ animal: Animal?) {
        classification = animal
        refresh()
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {

        return Animal.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: AnimalCell.identifier,
                for: indexPath) as? AnimalCell else {

                return UICollectionViewCell()
        }

        let animal = Animal.allCases[indexPath.item]
        
        cell.textLabel.text = animal.icon
        cell.backgroundColor =
            (animal == self.classification) ? animal.color : .systemGray
        
        return cell
    }
}


