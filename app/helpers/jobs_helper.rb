module JobsHelper

  # these statuses should be replaced by one method rather than
  # this copy and paste horror below
  def jobstatus(type)
    status = "#{Vibrant::Application.config.dropbox}/#{type}/status.txt"
    data = ""
    if File.exists?(status)
      data += "<p><font color=\"red\">#{File.mtime(status)}:</font><br>\n"
      data += `cat #{status}`
    end
    return data.html_safe
  end


  def boxoff
    unless request.path =~ /new/
      return 'readonly'
    else
      return 'onchange="moveRect();"'
    end
  end

  # this is a shocking hack, but it is easier than trying to pass
  # a job parameter to this helper when there's no need to do it 
  # for the default OBOE styling
  def job_value
    return '<div class="field"><textarea cols="40" id="job_parameters_coords" name="job[parameters][coords]" rows="20" style="display:none;"></textarea></div>'
  end

  def initialise
    return "google.maps.event.addDomListener(window, 'load', initialize);"
  end

  # another shocking hack required by the javascript menu
  def form_type
    return '<form accept-charset="UTF-8" action="/jobs" class="new_job" enctype="multipart/form-data" id="job_form" method="post">'
  end


  def gmaps_header(jobtype)

    # load the google maps and polygon scripts
    scripts = 
"<link rel=\"stylesheet\" href=\"https://ajax.googleapis.com/ajax/libs/jqueryui/1.7.1/themes/base/jquery-ui.css\" type=\"text/css\"/>
<script type=\"text/javascript\" src=\"https://maps.googleapis.com/maps/api/js?sensor=false&libraries=drawing,places \"></script>
<script>
window.onerror = function () { 
    $('#map').hide(); 
}
</script>"


    # create a new map with this javascript
    header_create = 
 "#{scripts}	
	<script type=\"text/javascript\">
      var geocoder;
      var map;
      var drawingManager;
      var stopdrawing = false;
      var rect;

      function initialize() {
        geocoder = new google.maps.Geocoder();
        var skegness = new google.maps.LatLng(53.14188,0.343933);
        var mapOptions = {
  	    zoom: 4,
          minZoom: 2,
    	    center: skegness,
          scrollwheel: false,
          disableDoubleClickZoom: true,
  	    mapTypeId: google.maps.MapTypeId.TERRAIN
        };
        map = new google.maps.Map(document.getElementById('map'), mapOptions);


        drawingManager = new google.maps.drawing.DrawingManager({
          drawingMode: google.maps.drawing.OverlayType.RECTANGLE,
          drawingControl:true,
          drawingControlOptions: {
            position: google.maps.ControlPosition.TOP_CENTER,
            drawingModes: [google.maps.drawing.OverlayType.RECTANGLE]
          },
          rectangleOptions: {
            fillColor: '#{Job.fill_colour(jobtype)}',
            fillOpacity: 0.45,
            strokeWeight: 0,
            clickable: false,
            zIndex: 1,
            editable: true
          }
        });
        drawingManager.setDrawingMode(null);
        drawingManager.setMap(map);

        google.maps.event.addListener(drawingManager, 'rectanglecomplete', function(rectangle) {
          rect = rectangle;
          /*
           * Why is this setMap(null) here? It is causing a crash with the latest version of the maps API.
           */
          //drawingManager.setMap(null);
          drawingManager.setDrawingMode(null);
          updateCoords(rectangle.getBounds());
          google.maps.event.addListener(rectangle, 'bounds_changed', function() {
            updateCoords(rectangle.getBounds());
          });
        });

        // autocomplete addresses
        var input = document.getElementById('address');
        var options = {
          types: ['geocode']
        };
        autocomplete = new google.maps.places.Autocomplete(input, options);

        google.maps.event.addListener(autocomplete, 'place_changed', function() {
          var place = autocomplete.getPlace();
          map.setCenter(place.geometry.location);
          map.setZoom(10);
        });
      }

      function updateCoords(coords)
      {
        //alert(coords);
        var north = coords.getNorthEast().lat(); 
        var south = coords.getSouthWest().lat();
        var east = coords.getNorthEast().lng(); 
        var west = coords.getSouthWest().lng();

        // the hidden coords field
        // this first one is 'wrong', but we think it is a better format
        //
        var write = 'POLYGON((' + north + ',' + west + ' ' + north + ',' + east + ' ' + south + ',' + east + ' ' + south + ',' + west + '))';
        // here's how it should be written
        //var write = 'POLYGON((' + west + ' ' + north + ',' + east + ' ' + north + ',' + east + ' ' + south + ',' + west + ' ' + south + '))';
        $('#job_parameters_coords').text(write);

        // the visible fields
        $('#north').val(north.toString());
        $('#south').val(south.toString());
        $('#east').val(east.toString());
        $('#west').val(west.toString());

        // reveal the button
        $('#submit_message').hide();
        $('#submit_button').show();

      }


      // read text in boxes and move map
      $(function () { 
        $('#north').change( function() { moveRect(); });
      });
      $(function () { 
        $('#south').change( function() { moveRect(); });
      });
      $(function () { 
        $('#east').change( function() { moveRect(); });
      });
      $(function () { 
        $('#west').change( function() { moveRect(); });
      });

      function moveRect()
      {
        var north = $('#north').val();        
        var south = $('#south').val();        
        var east = $('#east').val();        
        var west = $('#west').val();        

        if (north && south && east && west)
        {
          var south_west = new google.maps.LatLng(south,west);
          var north_east = new google.maps.LatLng(north,east);
          var bounds = new google.maps.LatLngBounds(south_west,north_east);

          // if no rectangle, create one
          if (rect == null)
          {
            drawingManager.setMap(null);
            rect = new google.maps.Rectangle({
              map: map, 
              bounds: bounds, 
              editable: true,
              fillColor: '#{Job.fill_colour(jobtype)}',
              fillOpacity: 0.45,
              strokeWeight: 0,
              clickable: false,
              zIndex: 1
            });
            google.maps.event.addListener(rect, 'bounds_changed', function() {
              updateCoords(rect.getBounds());
            });
            map.fitBounds(bounds);
          }

          // change position
          rect.setBounds(bounds);
          rect.setMap(map);
          map.setCenter(bounds.getCenter());
        }
      }

      // Deletes all markers in the array by removing references to them.
      function deleteOverlays() 
      {
        $('#job_parameters_coords').text('');
        $('#north').val('');
        $('#south').val('');
        $('#east').val('');
        $('#west').val('');
        $('#submit_message').show();
        $('#submit_button').hide();
        rect.setMap(null);
        rect = null;
        drawingManager.setDrawingMode(null);
        drawingManager.setMap(map);
      }
      
      
      #{initialise}
  </script>"

    

    # set up for job display
    javascript = ""
    count = 0
    if !jobtype.nil? and Job.maptypes.include?(jobtype) and request.path !~ /new$/
      if !@job.nil?
        # here we need to correct the fact that we're not using the correct coordinate format in the
        # jobs 'coords' parameter
        if !@job.parameters['coords'].nil?
          if @job.parameters['coords'] =~ /^POLYGON\s*\(\([0-9\.-]+,/ # incorrect format
            #Rails.logger.error("INCORRECT: #{@job.parameters['coords']}")
            coords = Array[@job.parameters['coords'].gsub("POLYGON((","").gsub("))", "").split(/\s+/)]
          else
            #Rails.logger.error("CORRECT: #{@job.parameters['coords']}")
            tmp_coords = Array.new
            @job.parameters['coords'].gsub(/POLYGON\s*\(\(/,"").gsub("))", "").split(/,/).each do |c|
              parts = c.split(/\s+/)
              tmp_coords << "#{parts[1]},#{parts[0]}"
            end
            coords = Array[tmp_coords]
          end
        else
          coords = Array[["#{@job.parameters[:nlat]},#{@job.parameters[:wlong]}","#{@job.parameters[:nlat]},#{@job.parameters[:elong]}","#{@job.parameters[:slat]},#{@job.parameters[:elong]}","#{@job.parameters[:slat]},#{@job.parameters[:wlong]}"]]
        end
         
        # coordinates supplied by clicking on the map
        coords.each do |c|
          javascript += "var coords_#{count} = [\n"
          0.upto(c.length - 1) do |d|
            javascript += "new google.maps.LatLng(#{c[d]})"
            if d == c.length - 1
              javascript += "\n"
            else
              javascript += ",\n"             
            end
          end
          javascript += "];\n"

          javascript +=
            "poly_#{count} = new google.maps.Polygon({
             paths: coords_#{count},
             strokeColor: \"#{Job.fill_colour(jobtype)}\",
             strokeOpacity: 0.35,
             strokeWeight: 1,
             fillColor: \"#{Job.fill_colour(jobtype)}\",
             fillOpacity: 0.35
            });\n
            poly_#{count}.setMap(map);\n"

          boxlats = coords[count].collect{|x| x.split(',')[0].to_f}
          boxlongs = coords[count].collect{|x| x.split(',')[1].to_f}
          javascript += "var bBox_#{count} = [];\n"
          javascript += "bBox_#{count}.push(new google.maps.LatLng(#{boxlats.max},#{boxlongs.max}));\n"
          javascript += "bBox_#{count}.push(new google.maps.LatLng(#{boxlats.max},#{boxlongs.min}));\n"
          javascript += "bBox_#{count}.push(new google.maps.LatLng(#{boxlats.min},#{boxlongs.min}));\n"
          javascript += "bBox_#{count}.push(new google.maps.LatLng(#{boxlats.min},#{boxlongs.max}));\n"
          javascript +=
   "bBox_#{count} = new google.maps.Polygon({
    paths: bBox_#{count},
    strokeColor: \"#{Job.fill_colour(jobtype)}\",
    strokeOpacity: 0.9,
    strokeWeight: 1,
    fillColor: \"#{Job.fill_colour(jobtype)}\",
    fillOpacity: 0.1
  });\n
  bBox_#{count}.setMap(map);\n"
          javascript += 
       "$('#north').val('#{boxlats.max}');
        $('#south').val('#{boxlats.min}');
        $('#east').val('#{boxlongs.max}');
        $('#west').val('#{boxlongs.min}');
        $('#north').prop('disabled',true).css('background-color', '#E0E0E0');
        $('#south').prop('disabled',true).css('background-color', '#E0E0E0');
        $('#east').prop('disabled',true).css('background-color', '#E0E0E0');
        $('#west').prop('disabled',true).css('background-color', '#E0E0E0');\n"

        # deal with the annoying backspace problem
        javascript += "
        $(document).keydown(function(e) {
          var element = e.target.nodeName.toLowerCase();
          if (element != 'input' && element != 'textarea') {
            if (e.keyCode === 8) {
            return false;
          }
        }
        });\n"
         
          count += 1
        end
        # get lat/long for centre of map
        if !coords[0].empty?
          lats = Array.new
          longs = Array.new
          coords[0].each do |c|
            parts = c.split(",")
            lats << parts[0].to_f
            longs << parts[1].to_f
          end
          lat = lats.min + ((lats.max - lats.min) / 2);
          long = longs.min + ((longs.max - longs.min) / 2);
        else
          # eventually some info. from the KML file will go here instead
          lat = 51.751944
          long = -1.257778
        end
      end
    end

    # this javascript is to display the map; refer to the code above
    # for how the variables are set up
    header_view = 
 "#{scripts}	
	<script type=\"text/javascript\">
  $(function(){
		  //create map
		 var mapCentre=new google.maps.LatLng(#{lat}, #{long});
		 var myOptions = {
		  	zoom: 4,
        minZoom: 2,
		  	center: mapCentre,
        scrollwheel: false,
		  	mapTypeId: google.maps.MapTypeId.TERRAIN
		  }
		 map = new google.maps.Map(document.getElementById('map'), myOptions);

     /* a variety of points have to be collected here and
      * a polygon made out of them
      */
      #{javascript}

  });
	</script>"


    if !jobtype.nil? and Job.maptypes.include?(jobtype) and request.path =~ /new/
      return header_create
    elsif !jobtype.nil? and Job.maptypes.include?(jobtype)
      return header_view      
    else
      return ""
    end

  end

  # for the button which toggles a job between public and private
  def publicbuttong(flag)
    if flag == false
      return "btn btn-success"
    else
      return "btn btn-danger"
    end
  end

  def publictext(flag)
    if flag == true
      return "Public"
    else
      return "Private"
    end
  end

end
