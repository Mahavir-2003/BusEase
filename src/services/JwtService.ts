import { JWT_SECRET } from "../config";
import jwt from "jsonwebtoken";

class jwtService{

    static sign(payload :  any, expiresIn : string = '1d' , secret : string = JWT_SECRET) : string{
        return jwt.sign(payload, secret, { expiresIn });
    }


}

export default jwtService;