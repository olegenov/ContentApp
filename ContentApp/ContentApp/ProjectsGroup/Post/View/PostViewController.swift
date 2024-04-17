//
//  PostViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 31.03.2024.
//

import UIKit

protocol PostDisplayLogic {
    func displayError(_ error: String)
    func displayPostInfo(_ post: PostInfo)
    func displayTitle(_ title: String)
}

class PostViewController: BaseViewController, PostDisplayLogic {
    enum Constants {
        static let titleTopOffset: CGFloat = 5
        static let navTopOffset: CGFloat = 32
        static let sideOffset: CGFloat = 16
        static let pageTitle: String = "post"
        static let projectButtonText: String = "info"
        static let infoButtonText: String = "info"
        static let textButtonText: String = "text"
        static let buttonsTopOffset: CGFloat = 12
        static let sectionTopOffset: CGFloat = 18
    }
    
    let postId: Int
    let projectId: Int
    let interactor: PostBusinessLogic?
    var router: PostRouterProtocol?
    var postTextSection: PostTextSection = PostTextSection()
    var postInfoSection: PostInfoSection = PostInfoSection()
    var projectButton: Button = ButtonFactory.createButton(type: .empty, title: Constants.projectButtonText)
    var textButton: Button = ButtonFactory.createButton(type: .regular, title: Constants.textButtonText)
    var infoButton: Button = ButtonFactory.createButton(type: .regular, title: Constants.infoButtonText)
    var post: PostInfo = PostInfo(title: "new post", assign: "none", publishing: Date.now, deadline: Date.now, content: "", projectName: "project")
    
    var postName: UITextField = UITextField(frame:.zero)
    var sectionButtons: UIStackView = UIStackView()
    
    init(interactor: PostBusinessLogic, projectId: Int, postId: Int) {
        self.interactor = interactor
        self.postId = postId
        self.projectId = projectId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.loadPost(projectId: self.projectId, postId: self.postId)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        post.title = postName.text ?? "none"
        post.content = postTextSection.textView.text
        
        self.interactor?.savePostChanges(projectId: self.projectId, postId: self.postId, postInfo: self.post)
    }
    
    func configureEditableTitle(title: String) {
        postName.translatesAutoresizingMaskIntoConstraints = false
        postName.font = UIFont.appFont(.title)
        postName.text = title
        
        view.addSubview(postName)
        
        NSLayoutConstraint.activate([
            postName.topAnchor.constraint(equalTo: nav.bottomAnchor),
            postName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            postName.heightAnchor.constraint(equalToConstant: postName.font?.lineHeight ?? 0)
        ])
    }
    
    internal override func configureUI() {
        configureEditableTitle(title: Constants.pageTitle)
        configureSectionButtons()
        configureTextSection()
        configureInfoSection()
    }
    
    func configureTextSection() {        
        view.addSubview(postTextSection)
        
        NSLayoutConstraint.activate([
            postTextSection.topAnchor.constraint(equalTo: sectionButtons.bottomAnchor, constant: Constants.sectionTopOffset),
            postTextSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            postTextSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
            postTextSection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureInfoSection() {
        postInfoSection.isHidden = true
        
        postInfoSection.configurePublishLabelAction(action: publishLabelTapped)
        postInfoSection.configureDeadlineLabelAction(action: deadlineLabelTapped)
        postInfoSection.configureAssignLabelAction(action: assignLabelTapped)
        
        view.addSubview(postInfoSection)
        
        NSLayoutConstraint.activate([
            postInfoSection.topAnchor.constraint(equalTo: sectionButtons.bottomAnchor, constant: Constants.sectionTopOffset),
            postInfoSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            postInfoSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
            postInfoSection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureSectionButtons() {
        textButton.makeActive()
        textButton.addTarget(self, action: #selector(textButtonTapped), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        sectionButtons.axis = .horizontal
        sectionButtons.translatesAutoresizingMaskIntoConstraints = false
        sectionButtons.spacing = 10
        sectionButtons.addArrangedSubview(textButton)
        sectionButtons.addArrangedSubview(infoButton)
        
        view.addSubview(sectionButtons)
        
        NSLayoutConstraint.activate([
            sectionButtons.topAnchor.constraint(equalTo: postName.bottomAnchor, constant: Constants.buttonsTopOffset),
            sectionButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
        ])
    }
    
    @objc private func textButtonTapped() {
        textButton.makeActive()
        infoButton.makeRegular()
        showTextSection()
    }
    
    @objc private func infoButtonTapped() {
        textButton.makeRegular()
        infoButton.makeActive()
        showInfoSection()
    }
    
    private func showTextSection() {
        postInfoSection.isHidden = true
        postTextSection.isHidden = false
    }
    
    private func showInfoSection() {
        postTextSection.isHidden = true
        postInfoSection.isHidden = false
    }
    
    internal override func configureNav() {
        projectButton.addTarget(self, action: #selector(openProject), for: .touchUpInside)
        projectButton.translatesAutoresizingMaskIntoConstraints = false
        
        let navBuilder = NavBuilder(nav: self.nav)
        navBuilder.addLeftButton(button: projectButton)
        
        displayNav(topOffset: Constants.navTopOffset)
    }
    
    func displayPostInfo(_ post: PostInfo) {
        displayProjectName(post.projectName)
        displayTitle(post.title)
        postTextSection.configure(with: post)
        postInfoSection.configure(with: post)
        
        self.post = post
    }
    
    internal func displayProjectName(_ title: String) {
        projectButton.setTitle(title + " /", for: .normal)
    }
    
    func displayTitle(_ title: String) {
        self.post.title = title
        postName.text = title
    }
    
    @objc func openProject() {
        router?.navigateToProject()
    }
    
    private func textEndEditing(text: String) {
        self.post.content = text
    }
    
    private func publishLabelTapped() {
        let alertController = UIAlertController(title: "select publication date", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 20, width: alertController.view.frame.width, height: 200))
        datePicker.datePickerMode = .dateAndTime
        alertController.view.addSubview(datePicker)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.addSubview(datePicker)
        
        let selectAction = UIAlertAction(title: "select", style: .default) { _ in
            self.post.publishing = datePicker.date
            self.displayPostInfo(self.post)
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 40),
            alertController.view.heightAnchor.constraint(equalToConstant: 220),
        ])
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func deadlineLabelTapped() {
        let alertController = UIAlertController(title: "select deadline date", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 20, width: alertController.view.frame.width, height: 200))
        datePicker.datePickerMode = .dateAndTime
        alertController.view.addSubview(datePicker)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.addSubview(datePicker)
        
        let selectAction = UIAlertAction(title: "select", style: .default) { _ in
            self.post.deadline = datePicker.date
            self.displayPostInfo(self.post)
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 40),
            alertController.view.heightAnchor.constraint(equalToConstant: 220),
        ])
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func assignLabelTapped() {
        let alertController = UIAlertController(title: "input username", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "username"
        }
        
        let confirmAction = UIAlertAction(title: "select", style: .default) { _ in
            guard let newValue = alertController.textFields?.first?.text else { return }
            self.post.assign = newValue
            self.displayPostInfo(self.post)
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
