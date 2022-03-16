//
//  Welcome.swift
//  TestDogsMobile
//
//  Created by Jose Luis on 16/03/22.
//

import UIKit

class Welcome: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let vc = MainView()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
