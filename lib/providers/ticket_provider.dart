
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TicketProvider extends ChangeNotifier{
  final _storage = const FlutterSecureStorage();
    String UserId = "XXXX-XXXX-XXXX-XXXX";
    String PaasId = "XXXX-XXXX-XXXX-XXXX";
    String TicketId = "XXXX-XXXX-XXXX-XXXX";
    String From = "XXXX";
    String To = "XXXX";
    String Date = "XXXX-XX-XX";
    String Passenger = "XXXX";
    String Depot = "XXXX";
    String TicketType = "XXXX";
    int TicketQuantity = 1;
    int TicketPrice = 0;

    void loadTicketData() async{
      var ticketData = await _storage.read(key: "ticket_data");
      if (ticketData != null) {
        var ticket_data = jsonDecode(ticketData);
        UserId = ticket_data['UserId'];
        PaasId = ticket_data['PaasId'];
        TicketId = ticket_data['TicketId'];
        From = ticket_data['From'];
        To = ticket_data['To'];
        Date = ticket_data['Date'];
        Passenger = ticket_data['Passenger'];
        Depot = ticket_data['Depot'];
        TicketType = ticket_data['TicketType'];
        TicketQuantity = ticket_data['TicketQuantity'];
        TicketPrice = ticket_data['TicketPrice'];
    
        notifyListeners();
      }
    }


    void setTicketData(String userId, String paasId, String ticketId, String from, String to, String date, String passenger, String depot, String ticketType, int ticketQuantity, int ticketPrice){
        UserId = userId;
        PaasId = paasId;
        TicketId = ticketId;
        From = from;
        To = to;
        Date = date;
        Passenger = passenger;
        Depot = depot;
        TicketType = ticketType;
        TicketQuantity = ticketQuantity;
        TicketPrice = ticketPrice;

        var ticketData = {
          'UserId': UserId,
          'PaasId': PaasId,
          'TicketId': TicketId,
          'From': From,
          'To': To,
          'Date': Date,
          'Passenger': Passenger,
          'Depot': Depot,
          'TicketType': TicketType,
          'TicketQuantity': TicketQuantity,
          'TicketPrice': TicketPrice,
        };
        
        _storage.write(key: "ticket_data", value: json.encode(ticketData));
        
        notifyListeners();
    }

    
}