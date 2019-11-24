class Chat < ApplicationRecord
  validates :number, uniqueness: { scope: :application_id }
  # hook event run auto
  after_create  :update_apllication_chat
  before_create :set_number

  # relation  application
  belongs_to :application

  #realtion messages
  has_many   :messages , dependent: :delete_all

  


  private
    
    #update number of chat in application
    def update_apllication_chat
      application = self.application.increment(:chat_count)
      application.save
    end

    #set number for chat
    def set_number
      self.number =  self.application.chat_count + 1
    end
  
end
