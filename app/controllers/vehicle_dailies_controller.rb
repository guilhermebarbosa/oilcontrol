class VehicleDailiesController < ApplicationController
  before_filter [:load_vehicles]
  
  # GET /vehicle_dailies
  # GET /vehicle_dailies.xml
  def index
    @vehicle_dailies = VehicleDaily.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vehicle_dailies }
    end
  end

  # GET /vehicle_dailies/1
  # GET /vehicle_dailies/1.xml
  def show
    @vehicle_daily = VehicleDaily.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vehicle_daily }
    end
  end

  # GET /vehicle_dailies/new
  # GET /vehicle_dailies/new.xml
  def new
    @vehicle_daily = VehicleDaily.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vehicle_daily }
    end
  end

  # GET /vehicle_dailies/1/edit
  def edit
    @vehicle_daily = VehicleDaily.find(params[:id])
  end

  # POST /vehicle_dailies
  # POST /vehicle_dailies.xml
  def create
    @vehicle_daily = VehicleDaily.new(params[:vehicle_daily])

    respond_to do |format|
      if @vehicle_daily.save
        format.html { redirect_to(@vehicle_daily, :notice => 'Vehicle daily was successfully created.') }
        format.xml  { render :xml => @vehicle_daily, :status => :created, :location => @vehicle_daily }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vehicle_daily.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vehicle_dailies/1
  # PUT /vehicle_dailies/1.xml
  def update
    @vehicle_daily = VehicleDaily.find(params[:id])

    respond_to do |format|
      if @vehicle_daily.update_attributes(params[:vehicle_daily])
        format.html { redirect_to(@vehicle_daily, :notice => 'Vehicle daily was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vehicle_daily.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicle_dailies/1
  # DELETE /vehicle_dailies/1.xml
  def destroy
    @vehicle_daily = VehicleDaily.find(params[:id])
    @vehicle_daily.destroy

    respond_to do |format|
      format.html { redirect_to(vehicle_dailies_url) }
      format.xml  { head :ok }
    end
  end
  
  private
    def load_vehicles
      @vehicles = Vehicle.select('
        vehicles.id,
        vehicles.license_plate
      ').joins("
        INNER JOIN carmodels ON carmodels.id = vehicles.carmodel_id
        INNER JOIN carmodel_oils co ON co.carmodel_id = carmodels.id
        INNER JOIN oils ON oils.id = co.oil_id
        LEFT JOIN vehicle_historics vh ON vh.vehicle_id = vehicles.id AND vh.oil_id = oils.id
      ").find(:all, :conditions => ["
          ( 
        	(
        	SELECT
        		vhis.status
        	FROM
        		vehicle_historics vhis
        	WHERE
        		vhis.vehicle_id = vehicles.id 
        	AND 
        		vhis.oil_id = oils.id
        	ORDER BY
        		vhis.status
        	LIMIT
        		0,1
        	) = 'aberto'
          )"], :group => "vehicles.id").collect { |c| [c.license_plate, c.id] }
    end
end
