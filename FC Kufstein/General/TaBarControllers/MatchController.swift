//
//  MatchController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 09.10.23.
//

import UIKit

class MatchController: BaseMatchController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Networking
    override func fetchData() {
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    await self.fetchMatchData(for: .KM)
                }
                group.addTask {
                    await self.fetchMatchData(for: .oneB)
                }
                for await _ in group {} // Wait for all tasks to complete
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            fetchDataAndUpdateTableView(for: .KM)
        case 1:
            fetchDataAndUpdateTableView(for: .oneB)
        default:
            break
        }
    }
}

// MARK: - TableView
extension MatchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFetchingData {
            return 10 // Adjust this based on your preference
        } else {
            if segmentedControl.selectedSegmentIndex == 0 {
                return finishedMatches.count
            } else {
                return finishedMatchesJuniors.count
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFetchingData {
            return tableView.dequeueReusableCell(withIdentifier: ShimmerFinishedMatchTableCell.cellID, for: indexPath)
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FinishedMatchTableCell.cellID,
                for: indexPath
            ) as? FinishedMatchTableCell else {
                return UITableViewCell()
            }
            
            var matchData: MetchInfo.KMData?
            
            if segmentedControl.selectedSegmentIndex == 0 {
                matchData = reversedFinishedMatches[indexPath.row]
            } else {
                matchData = reversedFinishedMatchesJuniors[indexPath.row]
            }
            
            if let data = matchData {
                let viewModel = MatchViewMode(model: data)
                cell.configureCell(withViewModel: viewModel)
            }
            
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
    
    private func fetchDataAndUpdateTableView(for dataType: MatchDataType) {
        Task {
            await fetchMatchData(for: dataType)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Networking
extension MatchController {
    func fetchMatchData(for dataType: MatchDataType) async {
        do {
            startShimmer() // Set isFetchingData to true before fetching data
            let matchInfo = try await ApiManager.shared.fetchMatchInfo()
            let currentDate = Date()
            
            let updatedMatches = filterMatches(matchInfo: matchInfo, for: dataType, currentDate: currentDate)
            
            updateMatches(for: dataType, updatedMatches: updatedMatches)
            reloadTableView()
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func filterMatches(matchInfo: MetchInfo, for dataType: MatchDataType, currentDate: Date) -> [MetchInfo.KMData] {
        guard let items = matchInfo.plan[dataType.rawValue] else {
            print("No \(dataType.rawValue) data found")
            return []
        }
        
        return items.filter { item in
            let matchDate = Date(timeIntervalSince1970: TimeInterval(item.datum) / 1000)
            return matchDate < currentDate
        }
    }
    
    private func updateMatches(for dataType: MatchDataType, updatedMatches: [MetchInfo.KMData]) {
        switch dataType {
        case .KM:
            finishedMatches = updatedMatches
        case .oneB:
            finishedMatchesJuniors = updatedMatches
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.stopShimmer()
            self.tableView.reloadData()
        }
    }
}
