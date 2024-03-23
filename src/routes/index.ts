import { registerController , loginController } from "../controllers";
import { Router } from "express";

const routes = Router();
// router.use(authMiddleware);

routes.post("/register", registerController.register);
routes.post("/login", loginController.login);

export default routes;