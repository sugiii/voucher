class MsgformsController < ApplicationController
  before_action :set_msgform, only: [:show, :edit, :update, :destroy]

  # GET /msgforms
  # GET /msgforms.json
  def index
    @chk = "checked='checked'"
    @grp = Grp.new
    
    @msgforms = Msgform.where(seq: -1).find_each
    @msgform = Msgform.new
  end

  def self.setTestResult(res)
    @testResult = res
  end

  def send_msg
    msgs = params[:msg]
    comps = params[:comp]

    msgSender = MsgSender.new
    msgSender.sendMsg(comps, msgs)

    render json: { data: @testResult }
  end

  def save_test
    msgs = params[:msg]
    comps = params[:comp]
    tc = params[:tc]

    grp = Grp.find_or_create_by(comp: comps[0], port: comps[1], trcode: comps[2])
    testcase = Testcase.new
    testcase.grp_id = grp.id
    testcase.name =  tc[0]
    testcase.desc = tc[1]
    testcase.exprlt =  tc[2]
    testcase.save

    i = 0
    while(1==1)
      m = msgs[i]
      if (m == nil)
        break
      end
      i = i + 1
      msg = Msgdatum.new
      msgformId = grp.findMsg( comps, m )
      msg.msgform_id = msgformId
      msg.testcase_id = testcase.id
      msg.seq = m[0]
      msg.value = m[2]
      msg.save
    end
    render json: msgs
  end

  # POST /msgforms
  def save
    msgs = params[:msg]
    comps = params[:comp]

    i = 0
    while(1==1)
      m = msgs[i]
      if (m == nil)
        break
      end
      i = i + 1
      if m[7] == '1'  # new row
        msgform = Msgform.new
      elsif m[7] == '2' # row changed
        grp = Grp.new
        msgId = grp.findMsg( comps, m )
        msgform = Msgform.find_by('id' => msgId)
      end
      grp = Grp.find_or_create_by(comp: comps[0], port: comps[1], trcode: comps[2])
      msgform.seq = m[0]
      msgform.name = m[1]
      msgform.pos = m[3]
      msgform.len = m[4]
      msgform.desc = m[5]
      msgform.grp_id = grp.id
      msgform.save
    end

    render json: msgs
  end

  # GET /msgforms/1
  # GET /msgforms/1.json
  def show
  end

  # GET /msgforms/new
  def new
    @msgform = Msgform.new
  end

  # GET /msgforms/1/edit
  def edit
  end

  # POST /msgforms
  # POST /msgforms.json
  def create
    @msgform = Msgform.new(msgform_params)

    respond_to do |format|
      if @msgform.save
        format.html { redirect_to @msgform, notice: 'Msgform was successfully created.' }
        format.json { render :show, status: :created, location: @msgform }
      else
        format.html { render :new }
        format.json { render json: @msgform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /msgforms/1
  # PATCH/PUT /msgforms/1.json
  def update
    respond_to do |format|
      if @msgform.update(msgform_params)
        format.html { redirect_to @msgform, notice: 'Msgform was successfully updated.' }
        format.json { render :show, status: :ok, location: @msgform }
      else
        format.html { render :edit }
        format.json { render json: @msgform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /msgforms/1
  # DELETE /msgforms/1.json
  def destroy
    @msgform.destroy
    respond_to do |format|
      format.html { redirect_to msgforms_url, notice: 'Msgform was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete
    msgs = params[:msg]
    comps = params[:comp]
    @grp = Grp.new
    msgId = @grp.deleteMsgform(comps, msgs)
    form = Msgform.find_by('id' => msgId)
    form.destroy

    render json: msgs
  end

  def makeData
    comps =  params[:comp]
    msgforms = @grp.getMsgform comps
    msgforms.map do |m|
      [
        m.seq,
        m.name,
        '',
        m.pos,
        m.len,
        m.desc,
        '<input type="checkbox" name="select" value="">',
        '0'
      ]
    end
  end

  def load
    @chk = "checked='checked'"

    @msgform = Msgform.new
    @grp = Grp.new

 #  respond_to do |format|
 #    format.html { redirect_to root_path }
 #    format.json { render json: @msgforms }
 #  end
    render json: { data: makeData }
  end

  def make_testdata
    tc_id = params[:tc_id]
    
    msgRec = Msgdatum.new
    msgdata = msgRec.getMsgdata( tc_id)
    msgdata.map do |m|
      [
        m.seq,
        m.value
      ]
    end
  end

  def load_testdata
    render json: { data: make_testdata }
  end

  def dataload
    @grp = Grp.new

    render json: { data: makeTestData }
  end

  def makeHistData
    msgs = params[:msg]
    comps =  params[:comp]
    histdata = @grp.getHistdata(comps, msgs)
    histdata.map do |m|
      [
        '<a class="sel_test" style="width:100%;" href="/">' + m.name + '</a>',
        m.desc,
        m.exprlt,
        '',
        m.trydate.to_s,
        m.id
      ]
    end
  end

  def histload
    @grp = Grp.new

    render json: { data: makeHistData }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_msgform
      @msgform = Msgform.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def msgform_params
      params.require(:msgform).permit(:comp, :port, :trcode, :seq, :name, :pos, :len, :desc)
    end
end

