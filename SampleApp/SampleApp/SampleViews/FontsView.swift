//
//  FontsView.swift
//  SampleApp
//
//  Created by Pedro Contine on 02/03/22.
//

import SwiftUI
import Treco

struct FontsView: View {
    var body: some View {
        List {
            TrecoText("Large Title")
                .textStyle(.largeTitle)
                .padding()
            TrecoText("Title")
                .textStyle(.title)
                .padding()
            TrecoText("Title 2")
                .textStyle(.title2)
                .padding()
            TrecoText("Title 3")
                .textStyle(.title3)
                .padding()
            TrecoText("Body")
                .textStyle(.body)
                .padding()
            TrecoText("Caption")
                .textStyle(.caption)
                .padding()
        }
        .navigationTitle("Fonts")
    }
}

struct FontsView_Previews: PreviewProvider {
    static var previews: some View {
        FontsView()
    }
}
