//
//  HomeDatasource.swift
//  B & B Pools
//
//  Created by Allen Boynton on 10/7/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import LBTAComponents

class HomeDatasource: Datasource {
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return names[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return names.count
    }
}
