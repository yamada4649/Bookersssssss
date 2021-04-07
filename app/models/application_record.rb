class ApplicationRecord < ActiveRecord::Base#SQLに翻訳してくれる
  self.abstract_class = true
end
