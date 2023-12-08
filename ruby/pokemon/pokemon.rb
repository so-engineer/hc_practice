# frozen_string_literal: true

# Rubyは抽象クラスなし
class Pokemon
  attr_accessor :name, :type1, :type2, :hp, :mp

  def initialize(name, type1, type2, hp, mp)
    @name = name
    @type1 = type1
    @type2 = type2
    @hp = hp
    @mp = mp
  end

  def attack
    "#{@name}のこうげき!"
  end
end

# Rubyは単一継承
class Pikachu < Pokemon
  attr_accessor :type3

  def initialize(name, type1, type2, hp, mp, type3)
    super(name, type1, type2, hp, mp)
    @type3 = type3
  end

  def attack
    "#{super}\n#{@name}の10万ボルト!"
  end

  private

  def deffence
    "#{super}\n#{@name}の身を守る!"
  end
end

# 多重継承の仕組みを作る
module Loggable
  def log(text)
    p "[LOG] #{text}"
  end
end

# 多重継承の仕組みを作る
module Pokemon2
  attr_accessor :name, :type1, :type2, :hp, :mp

  def initialize(name, type1, type2, hp, mp)
    @name = name
    @type1 = type1
    @type2 = type2
    @hp = hp
    @mp = mp
  end

  def attack
    "#{@name}のこうげき!"
  end
end

# 多重継承の仕組みを作る
class Zenigame
  include Loggable
  include Pokemon2

  attr_accessor :type3

  def initialize(name, type1, type2, hp, mp, type3)
    super(name, type1, type2, hp, mp)
    @type3 = type3
  end

  def attack
    "#{super}\n#{@name}のみずでっぽう"
  end

  def title
    log 'title is called.'
    'Pokemon'
  end
end

pokemons = (1..100).to_a.map { Pokemon.new(:リザードン, :ほのお, :ひこう, 100, 10) }
# p pokemons.size
p pokemons[0].name
# p pokemons[0].type1
# p pokemons[0].type2
p pokemons[0].attack
p '------------------'

pika = Pikachu.new(:ピカチュウ, :でんき, :とぶ, 50, 5, :むし)
p pika.name
puts pika.attack
p pika.type3
# p pika.deffence # 呼び出し不可
p '------------------'

zeni = Zenigame.new(:ぜにがめ, :みず, :およぐ, 80, 8, :かめ)
p zeni.title
puts zeni.attack
p '------------------'
