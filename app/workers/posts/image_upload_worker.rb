module Posts
  class ImageUploadWorker
    include Sidekiq::Worker
    queue_as QUEUE_CRITICAL

    def perform(post_id, image_param)
      @post = Post.find(post_id)
      @post.images.attach(params[:post][:images]) if params[:post][:images]
    end
  end
end
