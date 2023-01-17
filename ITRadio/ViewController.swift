//
//  ViewController.swift
//  ITRadio
//
//  Created by zuzex-62 on 16.01.2023.
//

import UIKit

class ViewController: UIViewController, ViewModelDelegate {
    
    private var viewModel: ViewModel?
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var dataSource: [StreamModel] = []
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "StreamTableViewCell", bundle: nil), forCellReuseIdentifier: "StreamCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        addContent()
    }
    
    func reloadStreams(source: [StreamModel]) {
        dataSource.removeAll()
        dataSource = source
        tableView.reloadData()
    }
    
    private func addContent() {
        let rockModel = StreamModel(name: .rock, description: "Говорят, что рок – музыка протеста, не верьте, ведь рок — это свобода!", currentSong: "Whole Lotta Love — Led Zeppelin", isListening: true, image: UIImage(named: "image_rock")!)
        let metalcoreModel = StreamModel(name: .metalcore, description: "Объединяет экстремальный метал и хардкор-панк.", currentSong: "To The Stage — Asking Alexandria", isListening: false, image: UIImage(named: "image_metalcore")!)
        let liteModel = StreamModel(name: .lite, description: "Запоминающиеся мелодии признанных мировых хитов.", currentSong: "Friday I'M In Love — Cure", isListening: false, image: UIImage(named: "image_lite")!)
        dataSource.append(rockModel)
        dataSource.append(metalcoreModel)
        dataSource.append(liteModel)
    }
    
    func currentSongDidChage(name: String) {
        print("name == \(name)")
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StreamCell", for: indexPath) as? StreamTableViewCell else {
            fatalError("Could not dequeue cell of type NewsTableViewCell")
        }
        cell.setViews(item: dataSource[indexPath.row])
        return cell
    }
    
}
