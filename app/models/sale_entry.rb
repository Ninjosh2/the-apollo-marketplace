class SaleEntry < ActiveRecord::Base
    belongs_to :user

    def change_created_at
        self.created_at.strftime("%A, %d %b %Y %l:%M %p")
    end
end
