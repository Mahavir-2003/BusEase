
import 'package:flutter/material.dart';

class TicketProvider extends ChangeNotifier{
    String UserId = "XXXX-XXXX-XXXX-XXXX";
    String paasId = "XXXX-XXXX-XXXX-XXXX";
    String TicketId = "XXXX-XXXX-XXXX-XXXX";
    String From = "XXXX";
    String To = "XXXX";
    String Date = "XXXX";
    String Passenger = "XXXX";
    String depot = "XXXX";
    String TicketType = "XXXX";
    int TicketQuantity = 1;
    int TicketPrice = 0;



    void setTicketData(String userId, String paasId, String ticketId, String from, String to, String date, String passenger, String depot, String ticketType, int ticketQuantity, int ticketPrice){
        UserId = userId;
        paasId = paasId;
        TicketId = ticketId;
        From = from;
        To = to;
        Date = date;
        Passenger = passenger;
        depot = depot;
        TicketType = ticketType;
        TicketQuantity = ticketQuantity;
        TicketPrice = ticketPrice;
        notifyListeners();
    }

    
}