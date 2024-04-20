import { NextFunction, Request, Response } from "express";
import CustomErrorHandler from "../../services/CustomErrorHandler";
import Joi from "joi";
import { Paas, Ticket } from "../../models";

interface UserRequest extends Request{
    user? : { _id : string , role : string }
}

const ticketController = {
    createTicket: async (req: UserRequest, res: Response ,next : NextFunction) => {
        // check if user 
        if (!req.user) {
            return next(CustomErrorHandler.unAuthorized());
        }

        const { _id, role } = req.user!;

        const ticketSchema = Joi.object({
            userID : Joi.string().required(),
            paasId : Joi.string().required(),
            passengerName : Joi.string().required(),
            Depot : Joi.string().required(),
            type : Joi.string().required(),
            from : Joi.string().required(),
            to : Joi.string().required(),
            ticketQuantity : Joi.number().required(),
            ticketPrice : Joi.number().required(),
        });

        const { error, value } = ticketSchema.validate(req.body);
        if (error) {
            return next(error);
        }

        const { userID, paasId, passengerName, Depot, type, from, to, ticketQuantity, ticketPrice } = value;

        // create ticket
        const ticket = new Ticket({
            userID,
            paasId,
            passengerName,
            Depot,
            type,
            status : true,
            from,
            to,
            ticketQuantity,
            ticketPrice,
        })

        // get the paas details
        const paas = await Paas.findOne({ _id : paasId });

        // check if paas exist
        if(!paas){
            return next(CustomErrorHandler.notFound('Paas not found'));
        }

        // check if the paas is expired
        if(paas.expiryDate < new Date()){
            return next(CustomErrorHandler.unAuthorized('Paas expired'));
        }

        // check if the paas is valid for the destination
        if(!paas.possibleDestinations.includes(to)){
            return next(CustomErrorHandler.unAuthorized('Paas not valid for the destination'));
        }

        // save ticket
        try{
            // save ticket
            const createdTicket = await ticket.save();
            return res.json(createdTicket);
        }catch(err){
            return next(err);
        }

    },
    verifyTicket : async (req: Request, res: Response ,next : NextFunction) => {
        const ticketSchema = Joi.object({
            ticketID : Joi.string().required(),
        });

        const { error, value } = ticketSchema.validate(req.body);
        if (error) {
            return next(error);
        }

        const { ticketID } = value;

        // check if the ticket exist
        try{
            const ticket = await Ticket.findOne({ _id : ticketID });
            if(!ticket){
                return next(CustomErrorHandler.notFound('Ticket not found'));
            }
            return res.json(ticket);
        }catch(err){
            return next(CustomErrorHandler.notFound('Ticket not found'));
        }
    },
};

export default ticketController;