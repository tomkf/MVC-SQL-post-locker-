class PostsController
  def initialize
    @view = PostsView.new
  end

  def index
    db_info = Post.all
    @view.display(db_info)
  end

  def create
    url = @view.gather_input("enter a url for your post")
    title = @view.gather_input("enter a title for your post")
    votes = @view.gather_input("enter number of votes")

    new_post = Post.new(url: url, votes: votes.to_i, title: title)
    new_post.save
  end

  def update
    id_value = @view.gather_input("enter the id")
    my_post = Post.find(id_value.to_i)
    url = @view.gather_input("enter a url for your post")
    title = @view.gather_input("enter a title for your post")
    my_post.url = url
    my_post.title = title
    my_post.save
    puts "I added your update to the DB"
    index
  end

  def destroy
    index
    db_info = Post.all
    user_input = @view.gather_input("What index would you like to remove")
    my_index = user_input.to_i
    my_instance = db_info[my_index - 1]
    destroy_this = Post.find(my_instance.id)
    destroy_this.destroy
  end

  def upvote
    index
    user_input = @view.gather_input("Enter index of post you want to update")
    user_index = user_input.to_i
    working_array = Post.all
    instance_desired = working_array[user_index - 1]
    user_votes = @view.gather_input("Enter the new number of votes")
    instance_desired.votes = user_votes.to_i
    instance_desired.save
    end
end
