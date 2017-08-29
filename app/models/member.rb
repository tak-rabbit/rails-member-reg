class Member < ApplicationRecord
  has_secure_password
  validates :name, presence: { message: "必須項目です" }
  validates :email, presence: { message: "必須項目です" } , uniqueness: true,format: { with: /\A[a-zA-Z0-9_\#!$%&`'*+\-{|}~^\/=?\.]+@[a-zA-Z0-9][a-zA-Z0-9\.-]+\z/}
  validates :password, length: { minimum: 6, message: "6文字以上入力してください" }

  concerning  :Confirmable do
    included do
      validates :confirmed, acceptance: true
      validates :finished, acceptance: true

      after_validation :check_confirming

    end

    def check_confirming
      if self.confirmed == ""
        self.confirmed = errors.include?(:confirmed) && errors.size == 1 ? "1" : ""
      end

      if self.finished == ""
        self.confirmed = nil
        self.finished = nil
      end

      clear_confirm_errors
    end

    def clear_confirm_errors
      errors.delete :confirmed
      errors.delete :finished
    end
  end
end
