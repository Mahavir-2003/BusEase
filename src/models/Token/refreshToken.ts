import mongoose from "mongoose";

const refreshTokenSchema = new mongoose.Schema({
  token: { type: String, required: true , unique: true},
},{timestamps : false});

const RefreshToken = mongoose.model("refreshToken", refreshTokenSchema);

export default RefreshToken;