import { NextFunction, Request, Response } from "express";
import busData from "../../static/data/busData/busData";

interface SingleBusData {
  busNumber: string;
  busType: string;
  busCapacity: number;
  busSource: string;
  busDestination: string;
  busPricePerKilometer: number;
  busRoute: {
    name: string;
    distance: number;
  }[];
}

// busData is a JSON object containing multiple bus data of type SingleBusData
const BusData: { [key: string]: SingleBusData } = busData;

const busController = {
  getBusData: async (req: Request, res: Response, next: NextFunction) => {
    try {
      // Get bus number from request
      const {busNumber} = req.body;
      if (!busNumber) {
        return res.status(400).json({ message: "Bus number is required" });
      }
      // Get bus data from busData
      const bus = BusData[busNumber];
      if (!bus) {
        return res.status(404).json({ message: "Bus not found" });
      }
      return res.status(200).json({ bus });
    } catch (error) {
      next(error);
    }
  },
};

export default busController;