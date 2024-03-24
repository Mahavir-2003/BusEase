import { NextFunction, Request, Response } from "express";
import Joi from "joi";
import { RefreshToken } from "../../models";

const logoutController ={
    logout: async (req: Request, res: Response , next : NextFunction) => {
        // validate the refresh token
        const refreshSchema = Joi.object({
            refresh_token: Joi.string().required()
        });

        const { error } = refreshSchema.validate(req.body);
        
        if (error) {
            return next(error);
        }

        try{
            await RefreshToken.deleteOne({token : req.body.refresh_token});
            return res.status(200).json({message : "User logged out successfully!"});
        }catch(err){
            console.log(err);
            return next(new Error("An error occurred while logging out!"));
        }
    }
}


export default logoutController;