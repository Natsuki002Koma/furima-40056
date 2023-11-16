FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6, mix_case: true, special_characters: false) }
    password_confirmation { password }
    last_name { generate_kanji_hiragana_katakana }
    first_name { generate_kanji_hiragana_katakana }
    last_name_kana { generate_katakana }
    first_name_kana { generate_katakana }
    date_of_birth { Faker::Date.between(from: '1930-01-01', to: '2018-12-31') }
  end
end

def generate_kanji_hiragana_katakana(length = 2)
  # 全角の文字（漢字・ひらがな・カタカナ）をランダムに生成
  characters = ('ぁ'..'ん').to_a + ('ァ'..'ン').to_a + %w[亜 愛 和 夏 木 宇 美 千 流]
  characters.sample(length).join
end

def generate_katakana(length = 5)
  # カタカナの文字をランダムに生成
  katakana_chars = ('ァ'..'ン').to_a
  katakana_chars.sample(length).join
end
