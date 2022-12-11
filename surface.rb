require 'ruby2d'

class Surface

  attr_accessor :x1, :x2
  attr_accessor :y1, :y2
  attr_accessor :surface

  def dimensions
    [5, 5]
  end 

  def draw_surface
    # This is just printing the outer edges of the board
    # A better way would be to assign the "|" and the "-" to
    # the array elements, e.g., make arr[0,1]="|" and so on 

    (0..dimensions[0]).each do |k|
      (0..dimensions[0]).each do |v|
        print("|") if ((k >= 0) && (v == 0 || v == 5)) 
        print("-") if (k < 1 || k == 5) && v < 5     
        print(" ") if v < 5 && k > 0 && k < 5
        print("\n") if v == 5
      end
    end
  end

end
