//
//  TestingAndPrintingData.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 03.11.23.
//

import Foundation

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy HH:mm:ss" // You can adjust the format as needed
    return formatter
}()

// MARK: - Fetch All Finished and Upcoming Match
func fetchMatchData() async {
    do {
        let matchInfo = try await ApiManager.shared.fetchMatchInfo()
        let currentDate = Date()
        print("Match Info:")
        if let items = matchInfo.plan["KM"] {
            for item in items {
                let matchDate = Date(timeIntervalSince1970: TimeInterval(item.datum) / 1000)
                if matchDate < currentDate {
                    print("Finished Match:")
                } else {
                    print("Upcoming Match:")
                    let timeRemaining = timeRemainingUntilMatch(matchDate)
                    print("Time Remaining: \(timeRemaining)")
                }
                let formattedDate = formatDate(unixTimestamp: item.datum)
                print("Datum: \(formattedDate)")
                print("Live: \(item.live)")
                print("Ergebnis: \(item.ergebnis ?? "N/A")")
                print("Heim Name: \(item.heimName)")
                print("Heim Logo ID: \(item.heimLogoId ?? "N/A")")
                print("Heim Tore: \(item.heimTore)")
                print("Gast Name: \(item.gastName)")
                print("Gast Logo ID: \(item.gastLogoId ?? "N/A")")
                print("Gast Tore: \(item.gastTore)")
                print("Bewerb Bezeichnung: \(item.bewerbBezeichnung)")
                print("Spielort: \(item.spielort)")
                print("Heim Logo: \(item.heimLogo ?? "N/A")")
                print("Gast Logo: \(item.gastLogo ?? "N/A")")
                print("-------------------------------------------------------")
            }
        }
    } catch {
        print("Error: \(error)")
    }
}

// MARK: - Fetch only Last Match
func fetchLastMatch() async {
    do {
        let lastGameInfo = try await ApiManager.shared.fetchLastGameInfo()
        print("Last Game Info:")
        let unixTimestamp = Int(lastGameInfo.letztes.datum.timeIntervalSince1970)
        print("Datum: \(formatDate(unixTimestamp: unixTimestamp))")
        print("Heim Name: \(lastGameInfo.letztes.heimName)")
        print("Heim Tore: \(lastGameInfo.letztes.heimTore)")
        print("Gast Name: \(lastGameInfo.letztes.gastName)")
        print("Gast Tore: \(lastGameInfo.letztes.gastTore)")
        print("Bewerb Bezeichnung: \(lastGameInfo.letztes.bewerbBezeichnung)")
        print("Spielort: \(lastGameInfo.letztes.spielort)")
        print("Heim Logo: \(String(describing: lastGameInfo.letztes.heimLogo))")
        print("Gast Logo: \(String(describing: lastGameInfo.letztes.gastLogo))")
        print("Art: \(lastGameInfo.letztes.art)")
        print("Ticker: \(lastGameInfo.letztes.ticker)")
        print("Ergebnis: \(lastGameInfo.letztes.ergebnis)")
        print("-------------------------------------------------------")
        
        print("Tore Heim:")
        for toreHeim in lastGameInfo.letztes.toreHeim {
            print("Minute: \(toreHeim.minute)")
            print("Spieler Name: \(toreHeim.spielerName)")
        }

        print("Tore Gast:")
        for toreGast in lastGameInfo.letztes.toreGast {
            print("Minute: \(toreGast.minute)")
            print("Spieler Name: \(toreGast.spielerName)")
        }
        print("-------------------------------------------------------")
    } catch {
        print("Error: \(error)")
    }
}

// MARK: - Function to fetch and print table data for the main team
func fetchMainTeamTableData() async {
    do {
        let tableInfo = try await ApiManager.shared.fetchMainTeamTableInfo()

        // Access the properties of the League and Entry structs and print them for all entries in the "HEIM" table
        print("Main Team Table Info - HEIM:")

        for entry in tableInfo.tabellen.HEIM.eintraege {
            print("Bezeichnung: \(tableInfo.bezeichnung)")
            print("Rank: \(entry.rang)")
            print("Mannschaft Bezeichnung: \(entry.mannschaftBezeichnung)")
            print("Mannschaft Icon: \(entry.mannschaftIcon)")
            print("Spiele: \(entry.spiele)")
            print("Tore Erzielt: \(entry.toreErzielt)")
            print("Tordifferenz: \(entry.tordifferenz)")
            print("Punkte: \(entry.punkte)")
            print("------------------------------")
        }
    } catch {
        print("Error fetching main team table data: \(error)")
    }
}

// MARK: -  Function to fetch and print table data for the juniors team
func fetchJuniorsTableData() async {
    do {
        let tableInfo = try await ApiManager.shared.fetchJuniorsTableInfo()

        // Access the properties of the League and Entry structs and print them for all entries in the "HEIM" table
        print("Juniors Team Table Info - HEIM:")

        for entry in tableInfo.tabellen.HEIM.eintraege {
            print("Bezeichnung: \(tableInfo.bezeichnung)")
            print("Rank: \(entry.rang)")
            print("Mannschaft Bezeichnung: \(entry.mannschaftBezeichnung)")
            print("Mannschaft Icon: \(entry.mannschaftIcon)")
            print("Spiele: \(entry.spiele)")
            print("Tore Erzielt: \(entry.toreErzielt)")
            print("Tordifferenz: \(entry.tordifferenz)")
            print("Punkte: \(entry.punkte)")
            print("------------------------------")
        }
    } catch {
        print("Error fetching juniors team table data: \(error)")
    }
}



func formatDate(unixTimestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp) / 1000)
    return dateFormatter.string(from: date)
}

func timeRemainingUntilMatch(_ matchDate: Date) -> String {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day, .hour, .minute], from: Date(), to: matchDate)

    if let days = components.day, let hours = components.hour, let minutes = components.minute {
        return "\(days) days, \(hours) hours, and \(minutes) minutes"
    }

    return "N/A"
}
