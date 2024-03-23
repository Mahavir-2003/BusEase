import { DEBUG_MODE } from "../config";
import { NextFunction, Request, Response } from "express";
import { ValidationError } from "joi";
import CustomErrorHandler from "../services/CustomErrorHandler";

const errorHandler = (err: Error, req: Request, res: Response, next: NextFunction) => {
    let statusCode = 500;
    let data = {
        message: 'Internal server error',
        ...(DEBUG_MODE === 'true' && { originalError: err.message }),
    }

    if(err instanceof ValidationError){
        statusCode = 422;
        data = {
            message: err.message,
            ...(DEBUG_MODE === 'true' && { originalError: err.message }),
        }
    } 


    if(err instanceof CustomErrorHandler){
        statusCode = err.statusCode;    
        data = {
            message: err.message,
            ...(DEBUG_MODE === 'true' && { originalError: err.message }),
        }
    }



    return res.status(statusCode).json(data);
}

export default errorHandler;