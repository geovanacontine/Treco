//
//  TrecoButton.swift
//  Treco
//
//  Created by Pedro Contine on 25/03/22.
//

import SwiftUI

public struct TrecoButton: View {
    
    public init() {
        
    }
    
    public var body: some View {
        Button {
            print()
        } label: {
            Text("Button")
                .padding()
                .background(Color.treco(.brandPure))
                .foregroundColor(Color.treco(.neutralDarkPure))
                .addBorder(radius: .small, width: .thin, color: .brandPure)
        }
    }
}

struct TrecoButton_Previews: PreviewProvider {
    static var previews: some View {
        TrecoButton()
    }
}
