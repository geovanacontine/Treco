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
            TrecoText("Heading 1")
                .textStyle(.heading1)
                .padding()
            TrecoText("Heading 2")
                .textStyle(.heading2)
                .padding()
            TrecoText("Heading 3")
                .textStyle(.heading3)
                .padding()
            TrecoText("Heading 4")
                .textStyle(.heading4)
                .padding()
            TrecoText("Paragraph")
                .textStyle(.paragraph)
                .padding()
            TrecoText("Description")
                .textStyle(.description)
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
