class V1::ApplicationsController < ApplicationController
    before_action :get_application ,only: [:destroy,:show,:update]
    #get all applications
    def index
        @applications = Application.all
        reponse       =[]
        @applications.each{ |app|
           reponse.push({key:app.key, chat_count: app.chats.count})    
        }  
        render json:  {key: :success, data: reponse} , status: :ok
    end

    #create
    def create
        @application = Application.new(application_parms)
        if @application.save
            render json: {key: :success, data:{key: @application.key, chat_count: @application.chats.count}}  , status: :ok
        else
            @response = {key: :fail, msg:"not created the application", errors:@application.errors}
            render json: @response 
        end   
    end

    #update
    def update
        if @application.update(application_parms)
            render json: {key: :success, msg:"updated"} , status: :ok
        else
            @response = {key: :fail, msg:"not created the application" ,errors:@application.errors}
            render json: @response 
        end 
    end

    
    #destory
    def destroy
        @response = {key: :success, msg:"deleted"}
        if !@application.destroy
            @response = {key: :fail, msg:"not deleted", errors:@application.errors}
            render json: @response 
        end        
        render json: @response     
            
    end

     #show
     def show
        render json: {key: :success, data:{key: @application.key, chat_count: @application.chats.count}}  , status: :ok
     end
    
     #handle exception
     def action_missing(m, *args, &block)
        Rails.logger.error(m)
        redirect_to '/*path'
      end

    private

    def application_parms
        params.permit(:name)
    end 

    def get_application
    
        @application  =  Application::find_by_key(params[:id])
       
        if(!@application)
           return render json:  {key: :error, msg:"not found application",errors: {msg:"not found application"} , code:404}
        end
    end

end
