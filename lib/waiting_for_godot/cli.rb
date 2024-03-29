
class WaitingForGodot::CLI
  @@muted="\e[1;31m"
  @@grn="\e[1;32m"
  @@blu="\e[1;34m"
  @@mag="\e[1;35m"
  @@cyn="\e[1;36m"
  @@white="\e[0m"

  def call
    list_options
    lets_go
  end

  def list_options
    input = ""
    idx = ""
    while input != "let's go"
      puts "\nWhat shall we look at whilst we wait?\n"
      @topics = WaitingForGodot::Topic.all
      @topics.each do |topic|
        puts "=> #{topic.id}... #{topic.name}\n"
      end
      idx = gets.strip.downcase
      @topic = WaitingForGodot::Topic.find(idx)
      if @topic
        @topic.nested ? show_sub_topics(@topic) : show_content(@topic)
      else
        puts "I don't know what you mean..."
      end
      puts "Do you want to keep waiting or shall we go?\n"
      input = gets.strip.downcase
    end
  end

  def show_sub_topics(topic)
    puts "\nOkay, but what specifically do you want to think about?\n"
    topic.get_sub_topics
    topic.sub_topics.each.with_index(1) do |st, i|
      puts "#{i} => #{st.name}\n"
    end
    idx = gets.strip.downcase
    @sub_topic = topic.sub_topics[idx.to_i-1]
    if @sub_topic
      show_content(@sub_topic)
    else
      puts "I don't know what you mean..."
    end
  end

  def show_content(topic)
    puts "\n\n#{topic.name}\n"
    topic.get_details
    topic.content.each do |paragraph|
      puts "#{paragraph}\n"
    end
  end

  def lets_go
    puts "\nYeah, let's go."
  end
end
