class FlashcardSet < ApplicationRecord
  enum access: { shared: 1, personal: 2, class: 3}
  belongs_to :user
  has_many :flashcards, dependent: :destroy
  has_many :flashcard_set_settings_panels, dependent: :destroy
  accepts_nested_attributes_for :flashcards
  validates :title, presence: true
  has_many :learning_sessions, as: :learnable
  has_many :answer_times, through: :learning_sessions

  def slug
    return nil unless persisted?
    "#{id}-#{title.parameterize}" # 12-human-body
  end

  def as_json(options={})
    super(:methods => ['slug'])
  end

end
