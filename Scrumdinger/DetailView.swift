//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Anupama Biswas on 06/12/21.
//

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    @State private var isPresented = false
    var body: some View {
        List{
            Section(header: Text("Meeting Info").foregroundColor(.primary)){
                NavigationLink(
                    destination: MeetingView()){
                        Label("Start Meeting", systemImage: "timer")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                            .accessibilityLabel(Text("Start meeting"))
                    }
                    HStack {
                        Label("Length", systemImage: "clock")
                            .accessibilityLabel(Text("Meeting length"))
                        Spacer()
                        Text("\(scrum.lengthInMinutes) minutes")
                    }
                    HStack {
                        Label("Color", systemImage: "paintpalette")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(scrum.color)
                    }
                    .accessibilityElement(children: .ignore)
                }
                Section(header: Text("Attendees")){
                    ForEach(scrum.attendees, id: \.self){attendee in
                        Label(attendee, systemImage: "person")
                            .accessibilityLabel(Text("person"))
                            .accessibilityValue(Text(attendee))
                    }
                }
            }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button("Edit"){
            isPresented = true
        })
        .navigationTitle(scrum.title)
        .fullScreenCover(isPresented: $isPresented){
            NavigationView{
                EditView()
                    .navigationTitle(scrum.title)
                   .navigationBarItems(leading: Button("Cancel"){
                        isPresented = false
                    }, trailing: Button("Done"){
                        isPresented = false
                    })
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(scrum: DailyScrum.data[0])
        }
    }
}