class V1::MessagesController < ApplicationController
    
    before_action :get_application, :get_chat

    #create
    def create
        puts @chat.messages.count
        @message = @chat.messages.create(message_parms)
        puts @message
        if @message.valid?
            render json: {key: :success, data:{number: @message.number, message: @message.message }}  , status: :ok
        else
            @response = {key: :fail, msg:"not created the chat", errors:@message.errors}
            render json: @response 
        end   
    end
    
    private

    def message_parms
        params.permit(:message)
    end 

    def get_application
    
        @application  =  Application::find_by_key(params[:application_id])
       
        if(!@application)
           return render json:  {key: :error, msg:"not found application",errors: {msg:"not found application"} , code:404}
        end
    end

    def get_chat
        @chat  = @application.chats.find_by_number(params[:chat_id])
        if(!@chat)
            return render json:  {key: :error, msg:"not found chat in application",errors: {msg:"not found chat"} , code:404}
         end
    end
end
