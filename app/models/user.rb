class User < ApplicationRecord
  has_secure_password
  # この一文を挟むことでハッシュ化をしている

  has_many :reservations
# リファクタリング対象

  validates :name,
    presence: true
    # uniqueness: true(サービス上名前はユニークにしない)
  validates :login_id,
    presence: { message: 'は必須項目です' },
    uniqueness: { message: 'IDはすでに他のuserに使用されています' },
    length: { maximum: 15, minimum: 4 }
  validates :password,
    presence: { message: 'は必須項目です' },
    length: { maxmum: 16, minimum: 4 }
  validates :email,
    presence: { message: 'は必須項目です' }


  extend Enumerize

  enumerize :user_type, in: { teacher: 1, student: 2 }

end
