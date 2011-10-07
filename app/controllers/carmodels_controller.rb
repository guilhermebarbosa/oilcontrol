class CarmodelsController < ApplicationController
  before_filter [:load_brands], :only=>[:new, :edit, :create, :update]
  before_filter [:load_oils], :only=>[:new, :create]
  # GET /carmodels
  # GET /carmodels.xml
  def index
    @carmodels = Carmodel.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @carmodels }
    end
  end

  # GET /carmodels/1
  # GET /carmodels/1.xml
  def show
    @carmodel = Carmodel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @carmodel }
    end
  end

  # GET /carmodels/new
  # GET /carmodels/new.xml
  def new
    @carmodel = Carmodel.new
    
    @oil_count = Oil.all.count
    
    @oil_count.times do
      @carmodel.carmodel_oils.build
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @carmodel }
    end
  end

  # GET /carmodels/1/edit
  def edit
    @carmodel = Carmodel.find(params[:id])
    
    @oil_count = Oil.all.count
    
    @oil_count.times do
      @carmodel.carmodel_oils.build
    end
    
    @x = 1
    @conditions = ""
    @carmodel.carmodel_oils.each do |co|
      unless co.oil_id.blank?
        @conditions = @conditions + "oils.id != '#{co.oil_id}' "
        if @x < @carmodel.carmodel_oils.count
          @conditions = @conditions + "AND "
        end
        @x = @x + 1
      end
    end
    
    @oils_except = Oil.find(:all, :conditions => "#{@conditions}").collect { |c| [c.name, c.id] }
    
  end

  # POST /carmodels
  # POST /carmodels.xml
  def create
    @carmodel = Carmodel.new(params[:carmodel])
    
    respond_to do |format|
      if @carmodel.save
        format.html { redirect_to(@carmodel, :notice => 'Carmodel was successfully created.') }
        format.xml  { render :xml => @carmodel, :status => :created, :location => @carmodel }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @carmodel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /carmodels/1
  # PUT /carmodels/1.xml
  def update
    @carmodel = Carmodel.find(params[:id])
    CarmodelOil.delete_all("carmodel_id = '#{params[:id]}'")

    respond_to do |format|
      if @carmodel.update_attributes(params[:carmodel])
        format.html { redirect_to(@carmodel, :notice => 'Carmodel was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @carmodel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /carmodels/1
  # DELETE /carmodels/1.xml
  def destroy
    @carmodel = Carmodel.find(params[:id])
    @carmodel.destroy

    respond_to do |format|
      format.html { redirect_to(carmodels_url) }
      format.xml  { head :ok }
    end
  end
  
  private
    def load_brands
      @brands = Brand.all.collect { |c| [c.name, c.id] }
    end
    def load_oils
      @oils = Oil.find(:all, :order => "name").collect { |c| [c.name, c.id] }
    end
end