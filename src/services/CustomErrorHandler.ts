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

    static notFound(message : string){
        return new CustomErrorHandler(404, message = "Not Found");
    }

    static invalidCredentials(message : string = "Invalid Credentials"){
        return new CustomErrorHandler(401, message);
    }

    static unAuthorized(message : string = "Unauthorized"){
        return new CustomErrorHandler(403, message);
    }
    
}

export default CustomErrorHandler;