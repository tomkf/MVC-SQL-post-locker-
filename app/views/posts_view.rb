# @id = attributes[:id]
#   @url = attributes[:url]
#   @votes = attributes[:votes]
#   @title = attributes[:title]



class PostsView
  # TODO: implement methods called by the PostsController


  def display(info_from_controller)
    info_from_controller.each_with_index do |item, index|
      puts "#{index + 1}: #{item.title} number of votes:#{item.votes} "
    end
end

  def gather_input(command)
    puts command
    user_input = gets.chomp
  end
end
