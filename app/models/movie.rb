class Movie < ActiveRecord::Base





  def self.similar_movies target
    tmp = []
    director = Movie.find_by(title: target).director
    if director == nil or director.blank?
      return nil
    else
      self.all.each do |data|
        if (director == data.director)
          tmp.append(data.title)
        end
      end
    end
    """
   self.all.each do |i|
      puts i.rating
   end
   """
    return tmp
  end



end
