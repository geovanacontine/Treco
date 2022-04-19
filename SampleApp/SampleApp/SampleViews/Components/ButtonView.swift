//
//  ButtonView.swift
//  SampleApp
//
//  Created by Pedro Contine on 26/03/22.
//

import SwiftUI
import Treco

struct ButtonView: View {
    var body: some View {
        List {
            TrecoButton()
        }
        .navigationTitle("Buttons")
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
