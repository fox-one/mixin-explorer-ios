import SwiftUI

struct MiningCalculatorView: View {
    @State var rewardVol: String = "405000"
    @State var rewardPrecent: String = "10"
    @State var nodeCount: String = "32"
    @State var poolFee: String = "10"
    @State var pledgeCount: String = "11000"
    
    @State var yearReward: String = ""
    @State var yearRewardNode: String = ""
    @State var dayRewardNode: String = ""
    @State var ror: String = ""
    @State var pledgeRor: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Mining Calculator")) {
                VStack(alignment: .leading) {
                    Text("Reward Vol (XIN)")
                    TextField("Value", text: self.$rewardVol)
                }
                
                VStack(alignment: .leading) {
                    Text("Reward %")
                    TextField("Value", text: self.$rewardPrecent)
                }
                
                VStack(alignment: .leading) {
                    Text("Total Nodes")
                    TextField("Value", text: self.$nodeCount)
                }
                
                VStack(alignment: .leading) {
                    Text("Pledge （XIN）")
                    TextField("Value", text: self.$pledgeCount)
                }
                
                VStack(alignment: .leading) {
                    Text("Pool Fee %")
                    TextField("Value", text: self.$poolFee)
                }
                HStack {
                    Spacer()
                    
                    Button("Calculate") {
                        self.calculate()
                    }
                    Spacer()
                    
                    
                }
            }
            
            Section(header: Text("Result")) {
                VStack(alignment: .leading) {
                    Text("Yearly rewards")
                    TextField("0.00", text: self.$yearReward).disabled(true)
                }
                
                VStack(alignment: .leading) {
                    Text("Yearly rewards/node")
                    TextField("0.00", text: self.$yearRewardNode).disabled(true)
                }
                
                VStack(alignment: .leading) {
                    Text("Daily rewards/node") 
                    TextField("0.00", text: self.$dayRewardNode).disabled(true)
                }
                
                VStack(alignment: .leading) {
                    Text("Annualized ROR")
                    TextField("0.00%", text: self.$ror).disabled(true)
                }
                
                VStack(alignment: .leading) {
                    Text("After-tax ROR")
                    TextField("0.00", text: self.$pledgeRor)
                }
            }
            
        }.navigationBarTitle("Mining")
    }
    
    func calculate() {
        if let reward = Double(self.rewardVol), let percent = Double(self.rewardPrecent)
            , let node = Double(self.nodeCount), let pledge = Double(self.pledgeCount) {
            
            let rewardNode = (reward * percent * 0.01)
            let year = (reward * percent * 0.01) / node
            self.yearReward = "\(rewardNode)"
            self.yearRewardNode = "\(year)"
            self.dayRewardNode = "\(year / 365)"
            
            let ror = (year /  ( pledge )) * 100
            
            self.ror = String(format: "%.2f%%", ror)
            
            let program = (100 - (Double(self.poolFee) ?? 0.0)) * 0.01
            
            let pledgeRor = (year * program / pledge) * 100
            self.pledgeRor =  String(format: "%.2f%%", pledgeRor)
        }
    }
}

struct MineView_Previews: PreviewProvider {
    static var previews: some View {
        MiningCalculatorView()
    }
}
