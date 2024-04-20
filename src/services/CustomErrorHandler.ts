class CustomErrorHandler extends Error {
    statusCode: number;
    constructor(statusCode : number, message : string) {
        super();
        this.statusCode = statusCode;
        this.message = message;
    }

    static alreadyExists(message : string){
        return new CustomErrorHandler(409, message = "Already Exists");
    }

    static notFound(message : string = "Not Found"){
        return new CustomErrorHandler(404, message = message);
    }

    static invalidCredentials(message : string = "Invalid Credentials"){
        return new CustomErrorHandler(401, message);
    }

    static duplicateKeyError(message : string = "Duplicate Key"){
        return new CustomErrorHandler(400, message);
    }

    static unAuthorized(message : string = "Unauthorized"){
        return new CustomErrorHandler(403, message);
    }

    static alreadyExist(message : string = "already exist"){
        return new CustomErrorHandler(500, message);
    }
    
}

export default CustomErrorHandler;