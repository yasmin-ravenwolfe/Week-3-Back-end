require 'JSON'
require 'rest-client'

# response = RestClient.get('http://makerblog.herokuapp.com/posts',
#   {:accept => :json})

# puts response
# puts response.code
# puts response.class

# posts = JSON.parse(response)
# puts posts.class
# puts posts

module MakerBlog
  class Client
    def list_posts
      posts = RestClient.get 'http://makerblog.herokuapp.com/posts', 
        :accept => :json
      posts = JSON.parse(posts)
      posts.each do |post|
        puts "The title is: #{post['title']}, The url is: #{post['url']}, The content is: #{post['content']}"
      end
    end

    def show_post(id)
      url = 'http://makerblog.herokuapp.com/posts/' + id.to_s
      response = RestClient.get url, :accept => :json
      puts response.code
      response = JSON.load(response)
      puts  "The title is: #{response['title']}, The url is: #{response['url']}, The content is: #{response['content']}"
      # can just put puts response but this is better visually 
    end

    def create_post(name, title, content)
      url = 'http://makerblog.herokuapp.com/posts/'
      payload = {:post => {'name' => name, 'title' => title, 'content' => content}}

      response = RestClient.post url, payload.to_json, :content_type => :json,
      :accept => :json
      puts response.code

      # Turns the response into a form that Ruby can work with (hashes or arrays)
      response = JSON.load(response)
      
      # The puts line isn't mandatory, just using to see if program works 
      puts "The name is: #{response['name']}, The title is: #{response['title']}, The content is: #{response['content']}"

    end
    

    def edit_post(id, options = {})
    url = 'http://makerblog.herokuapp.com/posts/' + id.to_s
    params = {}

    params[:name] = options[:name] unless options[:name].nil?
    params[:title] = options[:title] unless options[:title].nil?
    params[:content] = options[:content] unless options[:content].nil?

    response = RestClient.put url, {:post => params}.to_json, 
      :content_type => :json, :accept => :json
    puts response.code

    response = JSON.load(response)

    puts "The post with id: #{response['id']} was edited."
    
    end

    def delete_post(id)
      url = 'http://makerblog.herokuapp.com/posts/' + id.to_s
      response = RestClient.delete url, :accept => :json
      puts response.code
    end
  
  end
end

client = MakerBlog::Client.new
# client.list_posts
# client.show_post(93)
client.create_post("person", "title", "stuff")
# client.edit_post(57, {:name=> "Snake Plissssken", content: "Escape from LA"})
# client.delete_post(102)