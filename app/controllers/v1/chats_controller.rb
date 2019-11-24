class V1::ChatsController < ApplicationController
    before_action :get_application
    before_action :get_chat ,only: [:destroy,:show,:update]
    before_action :get_chat_search ,only: [:search]
    #get all applications
    def index
        @chats = @application.chats
        reponse       =[]
        
        @chats.each{ |chat|
            messages = []
            chat.messages.each do |msg|
                messages.push({number:msg.number, message: msg.message})
            end 
           reponse.push({number:chat.number, messages:messages,message_count: chat.messages.count})    
        }  
        render json:  {key: :success, data: reponse} , status: :ok
    end

    #create
    def create
        @chat = @application.chats.create()
        if @chat.valid?
            render json: {key: :success, data:{number: @chat.number, message_count: @chat.messages.count }}  , status: :ok
        else
            @response = {key: :fail, msg:"not created the chat", errors:@chat.errors}
            render json: @response 
        end   
    end

    #search
    def search
        puts "hi #{search_parms}  chat is #{@chat.id  }"

        if !search_parms.has_key?(:search)
            return render json:  {key: :error, msg: :search_required,errors: {msg: :search_required}}
        end
        @messages = Message.search_in_chat(search_parms[:search], @chat.id)
     
        messages = []
        @messages.each do |msg|
            messages.push({number:msg.number, message: msg.message})
        end 
        reponse = {number:@chat.number, messages:messages,message_count:  @messages.size} 
        render json:  {key: :success, data: reponse} , status: :ok
    end

    #destory
    def destroy
        @response = {key: :success, msg:"deleted"}
        if !@chat.destroy
            @response = {key: :fail, msg:"not deleted", errors:@chat.errors}
            render json: @response 
        end        
        render json: @response     
            
    end

     #show
     def show
        messages = []
        @chat.messages.each do |msg|
            messages.push({number:msg.number, message: msg.message})
        end 
        render json: {key: :success, data:{number: @chat.number, messages:messages ,message_count: @chat.messages.count } }  , status: :ok
     end
    
     #handle exception
     def action_missing(m, *args, &block)
        Rails.logger.error(m)
        redirect_to '/*path'
      end

    private
    
    #PARMAS
    def search_parms 
       params.permit(:search)    
    end 
    
    def get_application
    
        @application  =  Application::find_by_key(params[:application_id])
       
        if(!@application)
           return render json:  {key: :error, msg:"not found application",errors: {msg:"not found application"} , code:404}
        end
    end

    def get_chat
        @chat  = @application.chats.find_by_number(params[:id])
        if(!@chat)
            return render json:  {key: :error, msg:"not found chat in application",errors: {msg:"not found chat"} , code:404}
         end
    end

    def get_chat_search
        @chat  = @application.chats.find_by_number(params[:chat_id])
        if(!@chat)
            return render json:  {key: :error, msg:"not found chat in application",errors: {msg:"not found chat"} , code:404}
         end
    end


end
