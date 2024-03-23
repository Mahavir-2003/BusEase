import { NextFunction, Request, Response } from "express";
import { User } from "../../models";
import CustomErrorHandler from "../../services/CustomErrorHandler";

interface UserRequest extends Request{
    user? : { _id : string , role : string }
}

const userController = {
    getUser: async (req : UserRequest, res : Response , next : NextFunction) => {
        try{
            const user = await User.findOne({_id : req.user._id}).select("-password -updatedAt -createdAt -__v");
            if(!user){
                return next(CustomErrorHandler.notFound("User not found"));
            }
            res.json(user);
        }catch(err){
            return next(err);
        }
    },  
};

export default userController;