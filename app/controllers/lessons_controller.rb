class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  skip_before_action :check_logined, only: [:show, :show_image, :set_lesson]

  def index
    @lessons = Lesson.all
  end

  def show
    @lessons = Lesson.find(params[:id])
  end

  def new
    @lesson = Lesson.new
  end

  def edit
  end

  def create
    upload_file = lesson_params[:image_data]
    lesson = {} #ローカル変数にからのハッシュを入れている
    if upload_file != nil #updateファイルがnil(空)ではない時
      lesson[:image_name] = upload_file.original_filename #t.lessonの:image_name カラムから original_filename で元々のファイルの名前を取り出す
      lesson[:image_data] = upload_file #t.lessonの:image_data カラムから read でファイル本体を取り出す
    end

    tmp = lesson_params
    tmp[:image_name] = lesson[:image_name]
    tmp[:image_data] = lesson[:image_data].read

    @lesson = Lesson.new(tmp)
    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def show_image
    #image表示用のアクション
    @lesson = Lesson.find(params[:id])
    #↓ここでimageデータが消えている↓
    send_data @lesson.image_data, type: "image/jpeg, image/png, image/gif", disposition: :inline
    #send_dataで動的に生産されたデータを出力し :typeでコンテントタイプを指定
    #dispositionでインライン表示 or ダウンロード表示をさせている
  end

  def update
    upload_file = lesson_params[:image_data]
    lesson = {} #ローカル変数にからのハッシュを入れている
    if upload_file != nil #updateファイルがnil(空)ではない時
      lesson[:image_name] = upload_file.original_filename #t.lessonの:image_name カラムから original_filename で元々のファイルの名前を取り出す
      lesson[:image_data] = upload_file #t.lessonの:image_data カラムから read でファイル本体を取り出す
      #訂正（⇑でreadをかけてしまうと正常に保存されない、且つ、readは複数回かけない事が望ましいので最後に読み込まれる値にかけるべき）
    end

    tmp = lesson_params
    tmp[:image_name] = lesson[:image_name]
    tmp[:image_data] = lesson[:image_data].read #上記の理由（読み込まれる直前なのでここにreadをかけている）

    @lesson = Lesson.new(tmp)
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroy' }
      format.json { head :no_content }
    end
  end

 private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:name, :content, :image_name, :image_data)
    #requireで外部ファイル、データを呼び出す(lesson がkey)
    #permitで保存を許可するカラムを設定
    #lessonにはpsermit以下が必要ですよという意味
  end
end
