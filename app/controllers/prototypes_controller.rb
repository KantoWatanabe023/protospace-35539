class PrototypesController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_prototype, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototypes_params)
    if @prototype.save
      # 保存された時はルートパスに戻るよう記述
      redirect_to root_path
    else
      # 保存されなかった時は新規投稿ページへ戻るよう記述
      render :new
      
    end
  end

  def show
    @comment = Comment.new
    # includesによってN＋1問題を解消
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def update
    if @prototype.update(prototypes_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototypes_params
    params.require(:prototype).permit(:name,:profile,:occupation,:position,:image,:title,:catch_copy,:concept).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def set_prototype
    # プロトタイプ情報をDBから取得している
    @prototype = Prototype.find(params[:id])
  end
end
