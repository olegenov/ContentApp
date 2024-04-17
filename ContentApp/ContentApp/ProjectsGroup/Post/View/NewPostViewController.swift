//
//  NewPostViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 17.04.2024.
//

class NewPostViewController: PostViewController {
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        post.title = postName.text ?? "none"
        post.content = postTextSection.textView.text
        
        self.interactor?.createPost(projectId: self.projectId, postInfo: self.post)
    }
    
    override func displayPostInfo(_ post: PostInfo) {
        displayProjectName(post.projectName)
        displayTitle(post.title)
        postTextSection.configure(with: post)
        postInfoSection.configure(with: post)
        
        self.post = post
    }
}
