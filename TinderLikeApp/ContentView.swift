//
//  ContentView.swift
//  TinderLikeApp
//
//  Created by sajal on 4/16/21.
//

import SwiftUI

struct User: Hashable, CustomStringConvertible {
    var id: Int
    
    let firstName: String
    let lastName: String
    let age: Int
    let mutualFriends: Int
    let imageName: String
    let occupation: String
    
    var description: String {
        return "\(firstName), id: \(id)"
    }
}

struct ContentView: View {
    /// List of users
    @State var users: [User] = [
        User(id: 0, firstName: "Alexa", lastName: "Min", age: 20, mutualFriends: 12, imageName: "person_1", occupation: "Coach"),
        User(id: 1, firstName: "Jhon", lastName: "Bennett", age: 30, mutualFriends: 3, imageName: "person_2", occupation: "Insurance Agent"),
        User(id: 2, firstName: "Mark", lastName: "Delaney", age: 29, mutualFriends: 6, imageName: "person_3", occupation: "Food Scientist"),
        User(id: 3, firstName: "Yeshna", lastName: "Watson", age: 29, mutualFriends: 9, imageName: "person_4", occupation: "Teacher"),
        User(id: 4, firstName: "Mandrin", lastName: "Peter", age: 21, mutualFriends:20, imageName: "person_5", occupation: "Immigration Counselor"),
        User(id: 5, firstName: "Roberto", lastName: "Lantave", age: 21, mutualFriends: 9, imageName: "person_6", occupation: "CEO"),
        User(id: 6, firstName: "Juliet", lastName: "Kantabe", age: 30, mutualFriends: 16, imageName: "person_7", occupation: "Butcher"),
        User(id: 7, firstName: "VY", lastName: "Rucher", age: 20, mutualFriends: 5, imageName: "person_8", occupation: "Deli Head"),
        User(id: 8, firstName: "Vience", lastName: "Rose", age: 31, mutualFriends: 8, imageName: "person_9", occupation: "Business Man"),
        User(id: 9, firstName: "Lezi", lastName: "Lucifer", age: 22, mutualFriends: 23, imageName: "person_10", occupation: "Paralegal")
    ]
    
    /// Return the CardViews width for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(users.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    
    /// Return the CardViews frame offset for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(users.count - 1 - id) * 10
    }
    
    private var maxID: Int {
        return self.users.map { $0.id }.max() ?? 0
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                LinearGradient(gradient: Gradient(colors: [Color.init(#colorLiteral(red: 0.8509803922, green: 0.6549019608, blue: 0.7803921569, alpha: 1)), Color.init(#colorLiteral(red: 1, green: 0.9882352941, blue: 0.862745098, alpha: 1))]), startPoint: .bottom, endPoint: .top)
                    .frame(width: geometry.size.width * 1.5, height: geometry.size.height)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .offset(x: -geometry.size.width / 4, y: -geometry.size.height / 2)
                
                VStack(spacing: 24) {
                    DateView()
                    ZStack {
                        ForEach(self.users, id: \.self) { user in
                            Group {
                                // Range Operator
                                if (self.maxID - 3)...self.maxID ~= user.id {
                                    CardView(user: user, onRemove: { removedUser in
                                        // Remove that user from our array
                                        self.users.removeAll { $0.id == removedUser.id }
                                    })
                                        .animation(.spring())
                                        .frame(width: self.getCardWidth(geometry, id: user.id), height: 400)
                                        .offset(x: 0, y: self.getCardOffset(geometry, id: user.id))
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }.padding()
    }
}

struct DateView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Sunday, 19th April")
                        .font(.title)
                        .bold()
                    Text("Today")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
