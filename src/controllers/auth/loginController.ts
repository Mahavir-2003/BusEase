import { NextFunction, Request, Response } from "express";
import Joi from "joi";
import { RefreshToken, User } from "../../models";
import CustomErrorHandler from "../../services/CustomErrorHandler";
import bcrypt from "bcrypt";
import jwtService from "../../services/JwtService";
import { REFRESH_SECRET } from "../../config";

const loginController = {

    async login(req: Request, res: Response, next: NextFunction) {
        // Validate request
        const loginSchema = Joi.object({
            email: Joi.string().email(),
            phoneNumber: Joi.string().pattern(new RegExp('^[0-9]{10}$')),
            aadharCardNumber: Joi.string().pattern(new RegExp('^[0-9]{12}$')),
            password: Joi.string().pattern(new RegExp('^[a-zA-Z0-9]{3,30}$')).required(),
        }).or('email', 'phoneNumber', 'aadharCardNumber');

        const { error } = loginSchema.validate(req.body);

        if (error) {
            return next(error);
        }

        // Check if user exists
        try {
            const user = await User.findOne({
                $or: [
                    { email: req.body.email },
                    { phoneNumber: req.body.phoneNumber },
                    { aadharCardNumber: req.body.aadharCardNumber }
                ],
            });
            if (!user) {
                return next(CustomErrorHandler.notFound('No account found!'));
            }

            // Check password
            const match = await bcrypt.compare(req.body.password, user.password);
            if (!match) {
                return next(CustomErrorHandler.invalidCredentials('Invalid credentials!'));
            }

            // Generate token
            const access_token = jwtService.sign({ _id: user._id, role: user.role });
            const refresh_token = jwtService.sign({ _id: user._id, role: user.role }, '1y', REFRESH_SECRET);

            // Database whitelist
            await RefreshToken.create({ token: refresh_token });

            res.json({ access_token, refresh_token });

        } catch (err) {
            return next(err);
        }


    },

}

export default loginController;