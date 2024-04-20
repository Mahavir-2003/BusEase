import { NextFunction, Request, Response } from "express";

interface UserRequest extends Request{
    user? : { _id : string , role : string }
}

const paasController ={

    createPaas : async (req: UserRequest, res: Response, next : NextFunction) => {
        
    }
};

export default paasController;