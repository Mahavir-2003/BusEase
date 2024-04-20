import { NextFunction, Request, Response } from "express";
import Joi from "joi";
import { Paas } from "../../models";
import CustomErrorHandler from "../../services/CustomErrorHandler";

interface UserRequest extends Request{
    user? : { _id : string , role : string }
}

const paasController = {
    createPaas: async (req: UserRequest, res: Response, next: NextFunction) => {
        if (!req.user) {
            return next(CustomErrorHandler.unAuthorized());
        }

        const { _id, role } = req.user!;

        const paasSchema = Joi.object({
            organization: Joi.string().required(),
            from: Joi.string().required(),
            to: Joi.string().required(),
            expiryDate: Joi.date().min('now').required(),
            paasType: Joi.string().valid('NORMAL', 'EXPRESS').required(),
            depot: Joi.string().required()
        });

        const { error, value } = paasSchema.validate(req.body);
        if (error) {
            return next(error);
        }

        const { organization, from, to, status, expiryDate, paasType, depot } = value;

        const paas = new Paas({
            user: _id,
            organization,
            from,
            to,
            status : true,
            expiryDate,
            paasType,
            depot
        });

        // check if the user has already created a paas
        const isPaasExist = await Paas.findOne({ user: _id });

        if (isPaasExist) {
            return next(CustomErrorHandler.alreadyExist('You have already created a paas'));
        }

        try {
            const createdPaas = await paas.save();
            return res.status(201).json(createdPaas);
        } catch (error) {
            if (error.code === 11000) {
                // handle duplicate key error
                return next(CustomErrorHandler.duplicateKeyError('This paas already exists'));
            }
            return next(error);
        }
    },
    paasStatus: async (req: UserRequest, res: Response, next: NextFunction) => {
        if (!req.user) {
            return next(CustomErrorHandler.unAuthorized());
        }
    
        const { _id } = req.user!;
    
        try {
            const paas = await Paas.findOne({ user: _id });
            if (!paas) {
                return next(CustomErrorHandler.notFound('You have not created any paas, Unable to fetch status'));
            }
            return res.json({ status: paas.status });
    
        } catch (error) {
            return next(error);
        }
    }
};


export default paasController;