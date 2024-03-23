class CustomErrorHandler extends Error {
    statusCode: number;
    constructor(statusCode : number, message : string) {
        super();
        this.statusCode = statusCode;
        this.message = message;
    }

    static alreadyExists(message : string){
        return new CustomErrorHandler(409, message);
    }

    static notFound(message : string){
        return new CustomErrorHandler(404, message);
    }

    static invalidCredentials(message : string){
        return new CustomErrorHandler(401, message);
    }
    
}

export default CustomErrorHandler;