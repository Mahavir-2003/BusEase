import { NextFunction, Request, Response } from "express";
import Joi from "joi";
import { Paas } from "../../models";
import CustomErrorHandler from "../../services/CustomErrorHandler";

interface RouteData {
    [key: string]: {
        routes: Array<String>
    }
}

import routeData from "../../static/data/routeData/routes";

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


        const { organization, from, to, expiryDate, paasType, depot } = value;


        const FROM = from.toUpperCase();
        const TO = to.toUpperCase();
        const DEPOT = depot.toUpperCase();
        const routedata : RouteData = routeData;

        
        if (!routedata[DEPOT]) {
                return next(CustomErrorHandler.notFound('Depot not found'));
        }
        if(!routedata[DEPOT].routes.includes(FROM) || !routedata[DEPOT].routes.includes(TO)){
            return next(CustomErrorHandler.notFound('Route not found'));
        }
        const possibleDestinations : Array<String> = routedata[DEPOT].routes.slice(routedata[DEPOT].routes.indexOf(FROM) + 1 , routedata[DEPOT].routes.indexOf(TO)+1);


        const paas = new Paas({
            user: _id,
            organization,
            from,
            to,
            status : true,
            expiryDate,
            paasType,
            possibleDestinations,
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
            return res.json({ status: paas.status , paasId : paas._id , user : paas.user , possibleDestinations : paas.possibleDestinations});
    
        } catch (error) {
            return next(error);
        }
    }
};


export default paasController;