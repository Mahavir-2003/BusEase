import { registerController , loginController , userController , refreshController ,logoutController } from "../controllers";
import { Router } from "express";
import auth from "../middlewares/auth";

const routes = Router();
// router.use(authMiddleware);


routes.post("/register", registerController.register);
routes.post("/login", loginController.login);
routes.get("/user", auth , userController.getUser);
routes.post("/refresh",refreshController.refresh);
routes.post("/logout",auth,logoutController.logout);


export default routes;