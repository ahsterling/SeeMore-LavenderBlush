module SessionsHelper

class FeedPage

  attr_reader :all_posts, :number_of_pages, :this_page, :last_page, :next_page

  def initialize(user, start = 0, page_length = 5)  # start is the index of the post on the page we are retrieving
    @all_posts = user.posts.order(date: :desc)
    @pl = page_length

    @number_of_pages = @all_posts.length/@pl  # one less than actual number
    @last_page = @all_posts[@number_of_pages*@pl,@pl]  # page contains last set of <=@pl posts

    if start >= @all_posts.length
      @this_page = @last_page
      @next_page = @last_page
    else
      current_page_number = start/@pl   #current page number is actually this number plus 1
      @this_page = @all_posts[current_page_number*@pl,@pl]
      if @all_posts[current_page_number*@pl+ @pl] == nil
        @next_page = @last_page
      else
        @next_page = SessionsHelper::FeedPage.new(user,start + @pl)
      end
    end

  end


end

end
