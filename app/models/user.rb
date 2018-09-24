class User < ApplicationRecord
  has_many :blogs, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_blogs, through: :favorites, source: :blog

  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  # ユーザーの値がバリデーション判定される前にemail属性を強制的に小文字に変換
  has_secure_password
  # セキュアにハッシュ化したパスワードを、データベース内のpassword_digestというカラムに保存する
  # 2つのペアの仮想的な属性 (passwordとpassword_confirmation) が使えるようになる。また、存在性と値が一致するかどうかのバリデーションも追加される
  # authenticateメソッドが使えるようになる (引数の文字列がパスワードと一致するとUserオブジェクトを、間違っているとfalseを返すメソッド) 。
  # has_secure_passwordメソッドを使用するためにはpassword_digestというカラムが必要
  validates :password, presence: true, length: { minimum: 6 }
end
