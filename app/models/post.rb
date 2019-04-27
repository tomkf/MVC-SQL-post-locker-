class Post
  attr_reader :id
  attr_accessor :title, :url, :votes

  def initialize(attributes = {})
    @id = attributes[:id]
    @url = attributes[:url]
    @votes = attributes[:votes]
    @title = attributes[:title]
  end

  def self.find(post_id)
    DB.results_as_hash = true
    post_hash = DB.execute("SELECT * FROM posts WHERE posts.id LIKE ? ", "#{post_id}%")
    # convert keys to symbols
    if post_hash == []
      return nil
    else
      instance_hash = { title: post_hash[0]["title"], url: post_hash[0]["url"], votes: post_hash[0]["votes"], id: post_hash[0]["id"] }
      Post.new(instance_hash)
  end
  end

  def self.all
    post_array = []
    DB.results_as_hash = true
    post_hash = DB.execute("SELECT * FROM posts;")
    if post_hash == []
      return post_hash
    else
      post_hash.each do |post|
        instance_hash = { title: post["title"], url: post["url"], votes: post["votes"], id: post["id"] }
        post_array.push(Post.new(instance_hash))
      end
      return post_array
  end
  end

  def save
    if @id.nil?
      DB.execute("INSERT INTO posts (url, votes, title)
        VALUES ('#{@url}', #{@votes}, '#{@title}')")
      @id = DB.last_insert_row_id
    else
      DB.execute("UPDATE posts SET url = '#{@url}', votes = #{@votes}, title = '#{@title}' WHERE id = #{@id} ")
    end
  end

  def destroy
    DB.execute("DELETE FROM posts WHERE id = #{@id} ")
end
end
