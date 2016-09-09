class Article < ApplicationRecord
	has_many :comments
	has_many :taggings
	has_many :tags, through: :taggings

	def tag_list
  		tags.join(", ")
	end

	def tag_list=(tags_string)
		tags = tags_string.split(',').collect{|s| s.strip.downcase}.uniq
		new_or_existing_tags = tags.collect{|s| Tag.find_or_create_by(name: s)}
		self.tags = new_or_existing_tags
	end

end
