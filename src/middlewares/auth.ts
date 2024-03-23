import { NextFunction, Request, Response } from "express";
import CustomErrorHandler from "../services/CustomErrorHandler";
import jwtService from "../services/JwtService";

interface UserRequest extends Request{
    user? : { _id : string , role : string }
}

const auth = async (req : UserRequest , res : Response ,next : NextFunction) =>{
    let authHeader = req.headers.authorization;

    // Check if the header is present
    if(!authHeader){
        return next(CustomErrorHandler.unAuthorized());
    }

    const token = authHeader.split(' ')[1];


    // Check if the token is valid
    try {
        const { _id , role } = await jwtService.verify(token);
        req.user = { _id , role };
        next();
    } catch (error) {
        return next(CustomErrorHandler.unAuthorized());
    }
}   

export default auth;