import { NextFunction, Request, Response } from "express";
import Joi from "joi";
import { RefreshToken, User } from "../../models";
import CustomErrorHandler from "../../services/CustomErrorHandler";
import bcrypt from "bcrypt";
import jwtService from "../../services/JwtService";
import { REFRESH_SECRET } from "../../config";

const registerController = {

    async register(req: Request, res: Response, next: NextFunction) {
        // Validate request
        const registerSchema = Joi.object({
            firstName: Joi.string().required(),
            middleName: Joi.string().required(),
            lastName: Joi.string().required(),
            dob: Joi.date().required(),
            gender: Joi.string().valid('male', 'female', 'other').required(),
            phoneNumber: Joi.string().pattern(new RegExp('^[0-9]{10}$')).required(),
            email: Joi.string().email().required(),
            aadharCardNumber: Joi.string().pattern(new RegExp('^[0-9]{12}$')).required(),
            password: Joi.string().pattern(new RegExp('^[a-zA-Z0-9]{3,30}$')).required(),
            role: Joi.string().default('user').valid('user', 'gsrtcAdmin', 'collageAdmin', 'student', 'traveller', 'ticketChecker').required()
        });

        const { error } = registerSchema.validate(req.body);

        if (error) {
            return next(error);
        }

        // Check if user already exists
        try {
            const exists = await User.exists({ aadharCardNumber: req.body.aadharCardNumber });
            if (exists) {
                return next(CustomErrorHandler.alreadyExists('Account already exists!'));
            }
        } catch (err) {
            return next(err);
        }

        // Hash the password
        const hashedPassword = await bcrypt.hash(req.body.password, 10);

        // Prepare model
        const newUser = new User({
            ...req.body,
            password: hashedPassword,
        });

        // Save to database
        let access_token;
        let refresh_token;
        try {
            const result = await newUser.save();

            // Token generation
            access_token = jwtService.sign({ _id: result._id, role: result.role });
            refresh_token = jwtService.sign({ _id: result._id, role: result.role }, '1y', REFRESH_SECRET);

            // Database Whitelist
            await RefreshToken.create({ token: refresh_token });


        } catch (err) {
            return next(err);
        }

        // Send response with token
        res.json({ access_token , refresh_token });

    },

}

export default registerController; 