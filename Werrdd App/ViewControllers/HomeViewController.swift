//
//  ViewController.swift
//  Werrdd App
//
//  Created by Kevin Phan on 3/10/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviationItems()
        configureUI()
        configureKeyboard()
    }
    
    //MARK: - UI Properties
    let spinnerView = SpinnerViewController()
    var wordDetails = [Word]()
    var favoriteWordsList = [Word]()
    
    //MARK: - UI Properties
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 25
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIConfiguration.backgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 25
        tableView.allowsSelection = true
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    lazy var definitionCard : UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 25
        card.backgroundColor = UIConfiguration.definitionCardBackground
        return card
    }()
    
    lazy var word: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Menlo-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Random Word"
        return label
    }()
    
    lazy var wordType: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "noun"
        label.font = UIFont.italicSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var definition: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Menlo", size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 5
        label.text = "Press refresh button to generate a new word!"
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 40)
        let config = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: "arrow.counterclockwise.circle", withConfiguration: config)?.withTintColor(UIColor(red: 240/255, green: 113/255, blue: 103/255, alpha: 1), renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapRefresh), for: .touchUpInside)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        searchbar.barTintColor = UIConfiguration.backgroundColor
        searchbar.placeholder = "Search for a word"
        searchbar.layer.cornerRadius = 25
        searchbar.delegate = self
        return searchbar
    }()
    
    //MARK: - UI Setup
    private func configureUI() {
        
        view.backgroundColor = UIConfiguration.backgroundColor

        view.addSubview(stackView)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(searchBar)

        view.addSubview(definitionCard)
        view.addSubview(word)
        view.addSubview(wordType)
        view.addSubview(definition)
        view.addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            definitionCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            definitionCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            definitionCard.heightAnchor.constraint(equalToConstant: 200),
            definitionCard.widthAnchor.constraint(equalToConstant: 350),
            
            word.topAnchor.constraint(equalTo: definitionCard.topAnchor, constant: 10),
            word.leadingAnchor.constraint(equalTo: definitionCard.leadingAnchor, constant: 10),
            
            wordType.leadingAnchor.constraint(equalTo: word.trailingAnchor, constant: 5),
            wordType.topAnchor.constraint(equalTo: definitionCard.topAnchor, constant: 15),
            
            definition.topAnchor.constraint(equalTo: word.bottomAnchor, constant: 10),
            definition.leadingAnchor.constraint(equalTo: definitionCard.leadingAnchor, constant: 10),
            definition.trailingAnchor.constraint(equalTo: definitionCard.trailingAnchor, constant: -5),
            
            refreshButton.bottomAnchor.constraint(equalTo: definitionCard.bottomAnchor, constant: -10),
            refreshButton.trailingAnchor.constraint(equalTo: definitionCard.trailingAnchor, constant: -10),
            
            stackView.topAnchor.constraint(equalTo: definitionCard.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        if #available(iOS 15, *) {
            
            navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.red]

            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIConfiguration.backgroundColor
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().standardAppearance = appearance
        }
    }
    
    private func configureNaviationItems() {
        
        navigationController?.navigationBar.tintColor = UIConfiguration.definitionCardBackground

        //Main icon on navigation bar
        let imageView = UIImageView(image: #imageLiteral(resourceName: "book-icon"))
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        imageView.contentMode = .scaleAspectFit

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))

        titleView.addSubview(imageView)
        titleView.backgroundColor = .clear
        self.navigationItem.titleView = titleView
                
        //Bookmark icon on right side of navigation bar
        let tabBarImage = UIImage(systemName: "bookmark")?.withTintColor(UIConfiguration.definitionCardBackground, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: tabBarImage, style: .plain, target: self, action: #selector(didTapFavoritesListButton))
    }
    
    private func configureKeyboard() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    private func presentSpinnerView() {
        addChild(spinnerView)
        view.addSubview(spinnerView.view)
        spinnerView.view.frame = view.frame
        spinnerView.didMove(toParent: self)
    }
    
    private func removeSpinnerView() {
        spinnerView.willMove(toParent: nil)
        spinnerView.view.removeFromSuperview()
        spinnerView.removeFromParent()
    }
    
    //MARK: - Action Functions
    @objc private func didTapRefresh() {
        
        presentSpinnerView()
        
        NetworkManager.shared.fetchRandomWord { [weak self] result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self?.word.text = result.word
                    self?.definition.text = result.results?.first?.definition
                    self?.wordType.text = result.results?.first?.partOfSpeech
                    self?.removeSpinnerView()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func didTapFavoritesListButton() {
        navigationController?.pushViewController(FavoritesListViewController(), animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordDetails.first?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selectedWord = wordDetails.first?.word
                
        let selectedDetails = wordDetails.first?.results?[indexPath.row]
                
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = UIConfiguration.definitionCardBackground
        
        cell.wordTitle.text = selectedWord
        cell.partOfSpeech.text = selectedDetails?.partOfSpeech
        cell.definition.text  = selectedDetails?.definition
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedWord = wordDetails.first else {
            return
        }
        
        guard let selectedDetails = wordDetails.first?.results?[indexPath.row] else {
            return
        }

        navigationController?.pushViewController(DetailViewController(wordDetails: selectedDetails, selectedWord: selectedWord), animated: true)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
        
        guard let userInputedWord = searchBar.text else {
            return
        }
                
        presentSpinnerView()
        
        NetworkManager.shared.fetchWord(word: userInputedWord) { [weak self] result in
            
            switch result {
            case .success(let output):
                self?.wordDetails.insert(output, at: 0)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        removeSpinnerView()
    }
}
