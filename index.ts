import express from "express";
import cors from "cors";
import mongoose from "mongoose";
import cookieParser from "cookie-parser";
import compression from "compression";
import { MONGO_URL, PORT } from "./src/config";
import routes from "./src/routes";
import errorHandler from "./src/middlewares/errorHandler";

// Create Express server
const app = express();

// Middlewares
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.use(cookieParser());
app.use(compression());
app.use("/api", routes);

app.get("/", (req, res) => {
  res.send("Hello and welcome to the BusEase server");
});

// connecting to the database
try {
  mongoose.connect(MONGO_URL);
  console.log("Connected to the database");
} catch (err) {
  console.log("Error in connecting to the database : ", err.message);
}

app.use(errorHandler)
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
