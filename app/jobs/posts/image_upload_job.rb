module Posts
  class ImageUploadJob < ApplicationJob

    def perform(post_id, options={})
      @post = Post.find(post_id)
      byebug
      @post.images.attach(options[:file]) if options[:file]
    end
  end
end
