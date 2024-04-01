//
//  PostViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 31.03.2024.
//

import UIKit

protocol PostDisplayLogic {
    func displayError(_ error: String)
    func displayPostInfo(_ post: Post)
    func displayTitle(_ title: String)
}

class PostViewController: BaseViewController, PostDisplayLogic {
    enum Constants {
        static let titleTopOffset: CGFloat = 5
        static let navTopOffset: CGFloat = 32
        static let sideOffset: CGFloat = 16
        static let pageTitle: String = "post"
    }
    
    let postId: Int
    let projectId: Int
    let interactor: PostBusinessLogic?
    var router: PostRouterProtocol?
    var projectButton: Button = Button()
    var postName: UITextField = UITextField(frame:.zero)
    var postInfo: PostInfoView = PostInfoView()
    
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
    
    func configureEditableTitle(title: String) {
        postName.translatesAutoresizingMaskIntoConstraints = false
        postName.font = UIFont.appFont(.title)
        postName.text = title
        postName.textAlignment = .left
        postName.contentMode = .topLeft
        postName.sizeToFit()
        
        view.addSubview(postName)
        
        NSLayoutConstraint.activate([
            postName.topAnchor.constraint(equalTo: nav.bottomAnchor),
            postName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
        ])
    }
    
    internal override func configureUI() {
        configureEditableTitle(title: Constants.pageTitle)
        configurePostInfo()
    }
    
    func configurePostInfo() {
        view.addSubview(postInfo)
        
        NSLayoutConstraint.activate([
            postInfo.topAnchor.constraint(equalTo: postName.bottomAnchor),
            postInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            postInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
            postInfo.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    internal override func configureNav() {
        projectButton = ButtonFactory.createButton(type: .empty, title: "to project")
        projectButton.addTarget(self, action: #selector(openProject), for: .touchUpInside)
        projectButton.translatesAutoresizingMaskIntoConstraints = false
        
        let navBuilder = NavBuilder(nav: self.nav)
        navBuilder.addLeftButton(button: projectButton)
        
        displayNav(topOffset: Constants.navTopOffset)
    }
    
    func displayPostInfo(_ post: Post) {
        displayProjectName(post.projectName)
        displayTitle(post.title)
        displayPostText(post)
    }
    
    func displayProjectName(_ title: String) {
        projectButton.setTitle(title + " /", for: .normal)
    }
    
    func displayTitle(_ title: String) {
        postName.text = title
    }
    
    func displayPostText(_ post: Post) {
        postInfo.updateData(post)
    }
    
    @objc func openProject() {
        router?.navigateToProject()
    }
}
