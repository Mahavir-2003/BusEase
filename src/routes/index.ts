import { registerController , loginController , userController , refreshController ,logoutController, paasController, ticketController } from "../controllers";
import { Router } from "express";
import auth from "../middlewares/auth";

const routes = Router();
// router.use(authMiddleware);


routes.post("/register", registerController.register);
routes.post("/login", loginController.login);
routes.get("/user", auth , userController.getUser);
routes.post("/refresh",refreshController.refresh);
routes.post("/logout",auth,logoutController.logout);
routes.post("/paas/create",auth,paasController.createPaas); 
routes.get("/paas/status",auth,paasController.paasStatus); 
routes.post("/ticket/create",auth,ticketController.createTicket); 
routes.get("/ticket/verify",ticketController.verifyTicket); 

export default routes;