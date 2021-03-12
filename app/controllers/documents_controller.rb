class DocumentsController < ApplicationController
  before_action :set_document, only: %i[ show edit update destroy ]

  # GET /documents or /documents.json
  def index
    if session[:user_id] == nil then
      redirect_to login_url, alert: "You need to be logged in to do that"
    end

    @documents = Document.where(user_id: session[:user_id])
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
    if !document_params[:upload]
      redirect_to upload_url, notice: "You didn't choose a file." and return
    end

    @document = Document.create!(document_params)
    key = @document.upload.key
    @document.set_properties_after_upload(session[:user_id], key)

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

  def distribute_again
    puts "distributing"
    document_id = params[:document_id]
    recipient_id = params[:recipient_id]
    document = Document.find(document_id)

    if not session[:user_id] || session[:user_id] != document.user_id then
      redirect_to login_url, alert: "You need to be signed in to do that"
      return
    end

    document_recipient = DocumentRecipient.find(recipient_id)
    recipient = document_recipient.email
    message = "Resending the code for the file: #{document.name}"
    download_code = document_recipient.download_code
    #DocumentMailer.distributed(recipient, message, download_code).deliver_now
  end

  def distribute
    if not session[:user_id] then
      redirect_to login_url, alert: "You need to be signed in to do that"
      return
    end
    message = params[:message]
    document_id = params[:id]
    document = Document.find(document_id)

    if document && document.user_id != session[:user_id] then
      redirect_to documents_dashboard_url
      return
    end

    recipients = params[:recipients].split(",")
    recipients.each do |recipient|
      download_code = SecureRandom.uuid
      helpers.create_new_document_recipient(recipient, document_id, download_code)
      #DocumentMailer.distributed(recipient, message, download_code).deliver_now
    end


    # sender_email = User.find(session[:user_id]).email
    # DocumentMailer.sender_distributed(sender_email, document.name, recipients).deliver_now


    redirect_to document_dashboard_path(document_id), alert: "We are working to distribute your file"

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
