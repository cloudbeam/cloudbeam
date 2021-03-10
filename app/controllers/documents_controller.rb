class DocumentsController < ApplicationController
  before_action :set_document, only: %i[ show edit update destroy ]

  # GET /documents or /documents.json
  def index
    if session[:user_id] == nil then
      redirect_to get_login_url, alert: "You need to be logged in to do that"
    end
    @documents = Document.all
  end

  # GET /documents/1 or /documents/1.json
  def show
    @document = Document.find(params[:id])
    @recipients = DocumentRecipient.where(document_id: params[:id])
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents or /documents.json
  def create
    # create new document object with only name and attachment
    puts 'Hi'
    puts params[:document]
    @document = Document.create!(document_params)
    puts @document
    # get url key from attachment blob
    key = @document.upload.key
    # run model method to set remaining properties
    @document.set_properties_after_upload(session[:user_id], key)
    # @document.set_properties_after_upload(1, key)

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: "Document was successfully created." }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1 or /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: "Document was successfully updated." }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    # remove active storage entry and trigger removal from S3
    @document.upload.purge

    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: "Document was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(:name, :uploaded_at, :expired_at, :url, :user_id, :upload)
    end
end
