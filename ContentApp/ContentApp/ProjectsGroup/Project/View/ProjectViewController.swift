//
//  ProjectView.swift
//  ContentApp
//
//  Created by Никита Китаев on 29.03.2024.
//

import UIKit

protocol ProjectDisplayLogic {
    func displayError(_ error: String)
    func displayPosts(_ posts: [Post])
    func displayTitle(_ title: String)
}

class ProjectViewController: BaseViewController, ProjectDisplayLogic {
    enum Constants {
        static let sideOffset: CGFloat = 16
        static let cardHeight: CGFloat = 140
        static let pageTitle: String = "project"
        static let allViewButtonText: String = "all"
        static let calendarViewButtonTExt: String = "calendar"
    }
    
    let projectId: Int
    var interactor: ProjectBusinessLogic?
    var router: ProjectRouterProtocol?
    private let cards = CardList(cardHeight: Constants.cardHeight)
    var allViewButton: Button = ButtonFactory.createButton(type: .regular, title: Constants.allViewButtonText)
    var calendarViewButton: Button = ButtonFactory.createButton(type: .regular, title: Constants.calendarViewButtonTExt)
    var sectionButtons: UIStackView = UIStackView()
    
    var calendarData: [Date: String] = [:]
    var posts: [Post] = []
    var startDate: Date = Date()
    var endDate: Date = Date()
    var calendarView: UICollectionView
    var currentMonth = Calendar.current.component(.month, from: Date())
    var calendarNav = UIStackView()
    var month = UILabel()
    
    init(interactor: ProjectBusinessLogic, projectId: Int) {
        self.interactor = interactor
        self.projectId = projectId
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        calendarView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.loadPosts(id: self.projectId)
    }
    
    internal override func configureUI() {
        configureTitle(title: Constants.pageTitle)
        configureSectionButtons()
        configureCards()
        configureCalendarNav()
        configureCalendarView()
        configureReloadButton()
    }
    
    internal override func configureNav() {
        let menuButton = ButtonFactory.createIconButton(type: .menu)
        menuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        let projectsButton = ButtonFactory.createIconButton(type: .cards)
        projectsButton.addTarget(self, action: #selector(openProjects), for: .touchUpInside)
        projectsButton.translatesAutoresizingMaskIntoConstraints = false
        
        let navBuilder = NavBuilder(nav: self.nav)
        navBuilder.addLeftButton(button: menuButton)
        navBuilder.addRightButton(button: projectsButton)
        navBuilder.addNameLabel()
        
        displayNav()
    }
    
    private func configureCalendarNav() {
        calendarNav.axis = .horizontal
        calendarNav.distribution = .equalSpacing
        calendarNav.isHidden = true
        
        let weekDay = UILabel()
        weekDay.text = "mon"
        weekDay.font = UIFont.appFont(.cardProperty)
        weekDay.translatesAutoresizingMaskIntoConstraints = false
        
        let weekDayEnd = UILabel()
        weekDayEnd.text = "sun"
        weekDayEnd.font = UIFont.appFont(.cardProperty)
        weekDayEnd.translatesAutoresizingMaskIntoConstraints = false
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        
        month.text = dateFormatter.monthSymbols[currentMonth - 1]
        month.font = UIFont.appFont(.cardProperty)
        month.translatesAutoresizingMaskIntoConstraints = false
        
        calendarNav.addArrangedSubview(weekDay)
        calendarNav.addArrangedSubview(month)
        calendarNav.addArrangedSubview(weekDayEnd)
        calendarNav.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(calendarNav)
        
        NSLayoutConstraint.activate([
            calendarNav.topAnchor.constraint(equalTo: sectionButtons.bottomAnchor, constant: 12),
            calendarNav.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            calendarNav.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
        ])
    }
    
    func configureCalendarView() {
        calendarView.isHidden = true
        
        let currentDate = Date()
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = 1
        self.startDate = currentDate
        self.endDate = calendar.date(byAdding: dateComponents, to: currentDate)!
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        calendarView.collectionViewLayout = layout
        calendarView.dataSource = self
        calendarView.delegate = self
        
        for monthIndex in 0..<12 {
            for dayIndex in 0..<31 {
                calendarView.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell_\(monthIndex)_\(dayIndex)")
            }
        }
        
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.isPagingEnabled = true
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: calendarNav.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configureSectionButtons() {
        allViewButton.makeActive()
        allViewButton.addTarget(self, action: #selector(allViewButtonTapped), for: .touchUpInside)
        calendarViewButton.addTarget(self, action: #selector(calendarViewButtonTapped), for: .touchUpInside)
        
        sectionButtons.axis = .horizontal
        sectionButtons.translatesAutoresizingMaskIntoConstraints = false
        sectionButtons.spacing = 10
        sectionButtons.addArrangedSubview(allViewButton)
        sectionButtons.addArrangedSubview(calendarViewButton)
        
        view.addSubview(sectionButtons)
        
        NSLayoutConstraint.activate([
            sectionButtons.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            sectionButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
        ])
    }
    
    @objc private func allViewButtonTapped() {
        allViewButton.makeActive()
        calendarViewButton.makeRegular()
        showAllView()
    }
    
    @objc private func calendarViewButtonTapped() {
        allViewButton.makeRegular()
        calendarViewButton.makeActive()
        showCalendarView()
    }
    
    private func showAllView() {
        calendarView.isHidden = true
        calendarNav.isHidden = true
        cards.isHidden = false
    }
    
    private func showCalendarView() {
        calendarView.isHidden = false
        calendarNav.isHidden = false
        cards.isHidden = true
    }
    
    private func configureReloadButton() {
        let reloadButton = ButtonFactory.createIconButton(type: .reload)
        reloadButton.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
        
        view.addSubview(reloadButton)
        
        NSLayoutConstraint.activate([
            reloadButton.topAnchor.constraint(equalTo: titleView.topAnchor, constant: Constants.sideOffset),
            reloadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
        ])
    }
    
    @objc private func reloadData() {
        interactor?.loadPosts(id: self.projectId)
    }
    
    private func configureCards() {
        cards.configureAddCardTapAction(self.handleCreatingNewPost)
        cards.configureCardsTapAction(self.handleOpeningPost)
        cards.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cards)
        
        NSLayoutConstraint.activate([
            cards.topAnchor.constraint(equalTo: sectionButtons.bottomAnchor, constant: 28),
            cards.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            cards.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
            cards.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func displayPosts(_ posts: [Post]) {
        self.posts = posts
        var cardsData: [CardData] = []
        
        for post in posts {
            var username = post.assign?.username
            
            if username == "" {
                username = "none"
            }
            
            cardsData.append(CardData(id: post.id, title: post.title, property: [
                (IconFactory.createIcon(type: .assign), username ?? "none"),
                (IconFactory.createIcon(type: .calendar), post.publishing.toString()),
                (IconFactory.createIcon(type: .deadline), post.deadline.toString()),
            ]))
        }
        
        cards.updateData(cardsData)
        calendarView.reloadData()
    }
    
    func handleCreatingNewPost() {
        router?.navigateToPostCreation(projectId: self.projectId, onClose: { self.interactor?.loadPosts(id: self.projectId) })
    }
    
    func handleOpeningPost(id: Int) {
        router?.navigateToPost(projectId: self.projectId, postId: id, onClose: { self.interactor?.loadPosts(id: self.projectId) })
    }
    
    func displayTitle(_ title: String) {
        titleView.titleView.text = title
    }
    
    @objc func openMenu() {
        router?.navigateToMenu()
    }
    
    @objc func openProjects() {
        router?.navigateToProjects()
    }
}

extension ProjectViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: startDate, to: endDate)
        return components.month! + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = section
        let monthStartDate = calendar.date(byAdding: dateComponents, to: startDate)!
        let range = calendar.range(of: .day, in: .month, for: monthStartDate)!
        return range.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "CalendarCell_\(indexPath.section)_\(indexPath.row)"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CalendarCell
            let calendar = Calendar.current
            var dateComponents = DateComponents()
            dateComponents.month = indexPath.section
            let monthStartDate = calendar.date(byAdding: dateComponents, to: startDate)!
            let day = calendar.date(byAdding: .day, value: indexPath.row, to: monthStartDate)!

            if let data = calendarData[day] {
                cell.textLabel.text = data
            } else {
                cell.textLabel.text = "\(calendar.component(.day, from: day))"
            }

            let postsForDate = posts.filter { post in
                calendar.isDate(post.publishing, inSameDayAs: day)
            }
            
            if !postsForDate.isEmpty {
                let postTitles = postsForDate.map { $0.title }
                let concatenatedTitles = postTitles.joined(separator: "\n")
                cell.configurePosts(postName: concatenatedTitles)
            }
            
            let dayMonth = calendar.component(.month, from: day)
            
            if dayMonth != currentMonth {
                cell.textLabel.textColor = UIColor.AppColors.outlineColor
            }
            
            collectionView.reloadItems(at: [indexPath])
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width / 7
        let cellHeight = collectionView.frame.height / 6
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = scrollView as? UICollectionView else { return }
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        
        if let firstIndexPath = visibleIndexPaths.first {
            let section = firstIndexPath.section
            let calendar = Calendar.current
            let dateComponents = DateComponents(month: section)
            
            if let monthStartDate = calendar.date(byAdding: dateComponents, to: startDate) {
                currentMonth = calendar.component(.month, from: monthStartDate)

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "LLLL"
                
                month.text = dateFormatter.monthSymbols[currentMonth - 1]
                reloadData()
            }
        }
    }
}

class CalendarCell: UICollectionViewCell {
    var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLabel = UILabel(frame: self.bounds)
        textLabel.textAlignment = .center
        textLabel.font = UIFont.appFont(.regular)
        
        self.addSubview(textLabel)
    }
    
    func configurePosts(postName: String) {
        let postNameLabel = UILabel()
        postNameLabel.text = postName
        postNameLabel.font = UIFont.appFont(.cardProperty)
        postNameLabel.translatesAutoresizingMaskIntoConstraints = false
        postNameLabel.backgroundColor = UIColor.AppColors.cardBackgroundColor
        addSubview(postNameLabel)
        
        NSLayoutConstraint.activate([
            postNameLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
