class StaticPagesController < ApplicationController
  def home
    puts params
    @swear_chain = params[:swear_chain] if params[:swear_chain].present?
    @min_length = params[:min_length] || 2
    @max_length = params[:max_length] || 11
    @accept_variants = params[:accept_variants].present? ? params[:accept_variants].to_s.downcase == "true" : true
  end

  def swear_chain
    min_length = params["min_length"].to_i
    max_length = params["max_length"].to_i
    accept_variants = params["accept_variants"].to_s.downcase == "true"

    if min_length <= max_length
      swear_chain = generate_swear_chain(min_length, max_length, accept_variants)
    else
      swear_chain = "La longueur minimale peut pas être plus grande que la longeuer maximale!"
    end

    redirect_to home_path(swear_chain: swear_chain, min_length: min_length, max_length: max_length, accept_variants: accept_variants)
  end

  def valid_params?
    min_length = params["min_length"].to_i
    max_length = params["max_length"].to_i

    min_length <= max_length
  end

  CRISSE_CLASS = [ 'crisse', 'cristie', 'crime' ].freeze
  CALISSE_CLASS = [ 'câlisse', 'câline', 'câlique' ].freeze
  OSTI_CLASS = [ 'osti', 'esti', 'asti', "'sti" ].freeze
  TABARNAK_CLASS = [ 'tabarnak', 'tabarnouche', 'tabarouette', 'tabaslak' ].freeze
  SACRAMENT_CLASS = [ 'sacrament', 'sacrifice', 'sapristi' ].freeze
  CALVAIRE_CLASS = [ 'calvaire', 'calvâsse', 'calvinse' ].freeze
  CIBOIRE_CLASS = [ 'ciboire', 'cibole' ].freeze
  VIERGE_CLASS = [ 'vierge', 'viarge' ].freeze
  SIMONAC_CLASS = [ 'simonac', 'saint-simonac' ].freeze
  MERDE_CLASS = [ 'merde', 'marde' ].freeze
  MAUDIT_CLASS = [ 'maudit', 'mautadit', 'mautadine', 'maudine' ].freeze

  SWEAR_CLASSES = [ CRISSE_CLASS, CALISSE_CLASS, OSTI_CLASS, TABARNAK_CLASS, SACRAMENT_CLASS,
                    CALVAIRE_CLASS, CIBOIRE_CLASS, VIERGE_CLASS, SIMONAC_CLASS, MERDE_CLASS, MAUDIT_CLASS ].freeze

  NUMBER_OF_SWEAR_CLASSES = SWEAR_CLASSES.length
  
  def generate_swear_chain(min_length = 1, max_length = 11, accept_variants = true)
    swear_chain = ''
    used_classes = []
    
    length = rand(min_length..max_length)

    (1..length).each do |n|
      current_swear_class_index = generate_swear_class_index

      while used_classes.include?(current_swear_class_index)
        current_swear_class_index = generate_swear_class_index
      end

      current_swear_word =
        accept_variants ? SWEAR_CLASSES[current_swear_class_index].sample : SWEAR_CLASSES[current_swear_class_index][0]

      current_swear_word_with_preposition = prepend_preposition(current_swear_word, n)

      swear_chain += current_swear_word_with_preposition

      used_classes << current_swear_class_index
    end

    swear_chain
  end

  def generate_swear_class_index
    rand(0..NUMBER_OF_SWEAR_CLASSES - 1)
  end

  def prepend_preposition(word, position)
    return word if position == 1

    start_with_vowel?(word) ? " d'" + word : ' de ' + word
  end

  def start_with_vowel?(word)
    %w[a e i o u].include?(word[0])
  end
end
