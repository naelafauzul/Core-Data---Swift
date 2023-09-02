//
//  EditView.swift
//  CoreDataDemo
//
//  Created by Naela Fauzul Muna on 20/08/23.
//

import SwiftUI



struct EditView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    var products: FetchedResults<Product>.Element
    
    @State var name: String = ""
    @State var quantity: String = ""
    @State var jenis: String = ""
    
    private let jenisJenis = ["A", "B"]
    
    var body: some View {
        VStack {
            TextField("\(products.name!)", text: $name)
                .onAppear {
                    name = products.name!
                    quantity = products.quantity!
                }
            TextField("\(products.quantity!)", text: $quantity)
            Picker("\(products.jenis!)", selection: $jenis) {
                ForEach(jenisJenis, id: \.self) { jenis in
                    Text(jenis)
                }
            }
            
            HStack {
                Spacer()
                Button("Submit") {
                    editProduct()
                }
                Spacer()
            }
        }
    }
    
    private func editProduct() {
        
        withAnimation {
            let product = Product(context: viewContext)
            product.name = name
            product.quantity = quantity
            product.jenis = jenis
            
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occured: \(error)")
        }
    }
}

