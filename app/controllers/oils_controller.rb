class OilsController < ApplicationController
  # GET /oils
  # GET /oils.xml
  def index
    @oils = Oil.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @oils }
    end
  end

  # GET /oils/1
  # GET /oils/1.xml
  def show
    @oil = Oil.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @oil }
    end
  end

  # GET /oils/new
  # GET /oils/new.xml
  def new
    @oil = Oil.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @oil }
    end
  end

  # GET /oils/1/edit
  def edit
    @oil = Oil.find(params[:id])
  end

  # POST /oils
  # POST /oils.xml
  def create
    @oil = Oil.new(params[:oil])

    respond_to do |format|
      if @oil.save
        format.html { redirect_to(@oil, :notice => 'Oil was successfully created.') }
        format.xml  { render :xml => @oil, :status => :created, :location => @oil }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @oil.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /oils/1
  # PUT /oils/1.xml
  def update
    @oil = Oil.find(params[:id])

    respond_to do |format|
      if @oil.update_attributes(params[:oil])
        format.html { redirect_to(@oil, :notice => 'Oil was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @oil.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /oils/1
  # DELETE /oils/1.xml
  def destroy
    @oil = Oil.find(params[:id])
    @oil.destroy

    respond_to do |format|
      format.html { redirect_to(oils_url) }
      format.xml  { head :ok }
    end
  end
end
