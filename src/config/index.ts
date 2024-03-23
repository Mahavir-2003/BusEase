import dotenv from "dotenv";
dotenv.config();

export const {
    PORT,
    MONGO_URL,
    JWT_SECRET,
    REFRESH_SECRET,
    DEBUG_MODE
} = process.env;