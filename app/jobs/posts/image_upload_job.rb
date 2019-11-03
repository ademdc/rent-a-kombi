module Posts
  class ImageUploadJob < ApplicationJob

    def perform(post_id, options={})
      @post = Post.find(post_id)
      @post.images.attach(options[:file]) if options[:file]
    end
  end
end
