//
//  ImageTileView.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-25.
//

import SwiftUI

struct ImageTile: View {
    let imageName: String
    let size: CGFloat
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(
                width: size,
                height: size
            )
    }
}

struct ImageTileView_Previews: PreviewProvider {
    static var previews: some View {
        ImageTile(imageName: "hearts", size: UIScreen.screenWidth/4)
            .previewLayout(.sizeThatFits)
    }
}
