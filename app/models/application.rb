class Application < ApplicationRecord
   validates :name, presence: true


    #run hook auto
    before_create :set_key_token

    #realtion with chat
    has_many :chats ,dependent: :delete_all

    #heper
    private

    #set key for application
    def set_key_token
      self.key = generate_token
    end
  
    #genereate unique key
    def generate_token
      loop do
        token = SecureRandom.hex(15)
        break token unless Application.where(key: token).exists?
      end
    end
end
