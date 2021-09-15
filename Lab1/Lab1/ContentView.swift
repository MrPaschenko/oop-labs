import SwiftUI

struct ContentView: View {
  @State private var work1 = false
  @State private var work2 = false
  @State var group: String = ""
  @State var text: String = ""

  var body: some View {
    return VStack(content: {
      Text("Пащенко")
        .bold()
        .font(.title)
        .padding()

      HStack(content: {
        Spacer()

        Button(action: {
          self.work1.toggle()
          self.work2 = false
          self.group = ""
        }, label: {
          Text("Робота 1")
        })

        Spacer()

        Button(action: {
          self.work2.toggle()
          self.work1 = false
          self.text = ""
        }, label: {
          Text("Робота 2")
        })

        Spacer()
      })

      Spacer()

      if work1 {

        HStack(content: {
          if group != "" {
            Image(systemName: "person.3.fill")
          }
          Text(group)
        })

        Spacer()

        Picker("Група", selection: $group, content: {
          Text("ІП-01").tag("ІП-01")
          Text("ІП-02").tag("ІП-02")
          Text("ІП-03").tag("ІП-03")
          Text("ІП-04").tag("ІП-04")
          Text("ІП-05").tag("ІП-05")
        })
      }

      if work2 {
        HStack(content: {
          if text != "" {
            Image(systemName: "text.justify")
          }
          Text(text)
        })

        Spacer()

        TextField("Введіть текст...", text: $text)
          .padding()
          .background(Color.gray.opacity(0.3).cornerRadius(15))
          .frame(maxWidth: 300)

        Spacer()
      }
    })
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
