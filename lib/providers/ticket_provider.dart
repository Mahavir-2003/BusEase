
import 'package:flutter/material.dart';

class TicketProvider extends ChangeNotifier{
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
        notifyListeners();
    }

    
}