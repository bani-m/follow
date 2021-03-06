class CommentsController < ApplicationController
  # コメントを保存、投稿するためのアクションです。
  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog

    # respond_toは、クライアントからの要求に応じてレスポンスのフォーマットを変更します。
     respond_to do |format|
       if @comment.save
         format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
         format.json { render :show, status: :created, location: @comment }
         format.js { render :index }
       else
         format.html { render :new }
         format.json { render json: @comment.errors, status: :unprocessable_entity }
       end
     end
   end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Successfully destroyed comment."
    @comments = Comment.all
   end
  # ストロングパラメーター
  private
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end
end
