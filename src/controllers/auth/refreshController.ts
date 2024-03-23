import { NextFunction, Request, Response } from "express";
import Joi from "joi";
import { RefreshToken, User } from "../../models";
import CustomErrorHandler from "../../services/CustomErrorHandler";
import jwtService from "../../services/JwtService";
import { REFRESH_SECRET } from "../../config";

const refreshController = {
    refresh: async (req: Request, res: Response , next : NextFunction) => {
        // validate the refresh token
        const refreshSchema = Joi.object({
            refresh_token: Joi.string().required()
        });

        const { error } = refreshSchema.validate(req.body);

        if (error) {
            return next(error);
        }

        // get the refresh token from the request body
        let refreshToken;

        try{
            // check if the refresh token is valid
            refreshToken = await RefreshToken.findOne({token : req.body.refresh_token});

            if(!refreshToken){
                return next(CustomErrorHandler.unAuthorized("Invalid refresh token!"));
            }

            // check if the refresh token is expired
            let userId;
            try{

                const { _id } = await jwtService.verify(refreshToken.token , REFRESH_SECRET);
                userId = _id;

            }catch(err){
                return next(CustomErrorHandler.unAuthorized("Invalid refresh token!"));
            }

            const user = await User.findOne({_id : userId});
            if(!user){
                return next(CustomErrorHandler.unAuthorized("No user found!"));
            }

            // generate new access token and refresh token
            const access_token = jwtService.sign({_id : user._id , role : user.role});
            const refresh_token = jwtService.sign({_id : user._id , role : user.role} , "1y" , REFRESH_SECRET);

            // database whitelist the refresh token
            await RefreshToken.create({token : refresh_token});

            // unwhitelist the old refresh token
            await RefreshToken.deleteOne({token : refreshToken.token});

            res.json({access_token , refresh_token});
            
        }catch(err){
            next(new Error("Something went wrong!"));
        }


    }
}

export default refreshController;