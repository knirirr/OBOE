/**
 * User: Eamonn Maguire
 * Date: 29/04/2012
 * Time: 15:34
 * To change this template use File | Settings | File Templates.
 */

// parse the json document containing the service information

// display it in the ui by inserting links into the oboe-services div

var services = {};
var jQuery;
var currentDialog;

function loadData() {

    // json location
    var serviceData;

    serviceData = jobInformation;
    var oboeServicesContent = '<ul id="list" class="service-grid">';

    for (var key in serviceData) {
       
        for (var category in serviceData[key]) {
            var categoryObj = serviceData[key][category];


            // now we need to go through the jobs
            for (var job in categoryObj.jobs) {
                var jobObj = categoryObj.jobs[job];

                var newServiceObject = new Object();
                newServiceObject.category = categoryObj.name;
                newServiceObject.url = jobObj.url;
		newServiceObject.type = jobObj.type;
                newServiceObject.category = categoryObj.name;

                for (var descriptionIndex in jobObj.description) {
                    newServiceObject.longDescription = jobObj.description[descriptionIndex].long;
                    newServiceObject.shortDescription = jobObj.description[descriptionIndex].short;
                }

                // This is required to display the job's name as the title of
                // the popup
                newServiceObject.name = jobObj.name;

                for (var iconIndex in jobObj.icon) {
                    newServiceObject.smlIcon = jobObj.icon[iconIndex].small;
                    newServiceObject.lrgIcon = jobObj.icon[iconIndex].big;
                }


                if (jobObj.sponsors != undefined) {
                    newServiceObject.sponsors = [];

                    for (var sponsor in jobObj.sponsors) {

                        var sponsorObj = jobObj.sponsors[sponsor];

                        newServiceObject.sponsors[sponsorObj.name] = {};
                        newServiceObject.sponsors[sponsorObj.name].url = sponsorObj.link;
                        newServiceObject.sponsors[sponsorObj.name].image = sponsorObj.logo;
                    }
                }

                if (jobObj.mobile != undefined) {
                    newServiceObject.mobile = [];

                    for(var mobile in jobObj.mobile) {
			var mobileObj = jobObj.mobile[mobile];
			
			newServiceObject.mobile[mobileObj.platform] = {};
			newServiceObject.mobile[mobileObj.platform].url=mobileObj.url;
		    }
                }

                services[jobObj.name] = newServiceObject;

                var trimmedCategory = services[jobObj.name].category.replace(/\s/g, "");
                var divContent = '<li data-id="' + jobObj.type + '" class="' + trimmedCategory + '">';
                divContent += '<div id=\"' + jobObj.name + '\" class=\"services navigation-button\">';
                divContent += '<span>';
                divContent += '<img src="' + services[jobObj.name].smlIcon + '" alt="' + jobObj.name + '" onclick="showServiceInfo(\'' + jobObj.name + '\')"/>';
                //divContent += '</span></li>';
                oboeServicesContent += divContent;
            }
        }
    }


    $('#oboe-services').append(oboeServicesContent).show();

    var filterMenu = '<ul class="splitter"><li><ul>';
    filterMenu += '<li class="selected"><a href="#oboe-services" data-value="all">All</a></li>';

    var observedCategories = {};
    for (var jobName in services) {
        var trimmedCategory = services[jobName].category.replace(/\s/g, "");
        if (observedCategories[trimmedCategory] == undefined) {
            filterMenu += '<li class=""><a href="#oboe-services" data-value="' + trimmedCategory + '">' + services[jobName].category + '</a></li>';
            observedCategories[trimmedCategory] = [];
        }
    }

    filterMenu += '</li></ul>';

    $('#filter').append(filterMenu);
}


// close the current dialog, if one exists.
function showDialog(id, divContent) {
    if (currentDialog != undefined) {
        currentDialog.dialog('close');
    }

    currentDialog = jQuery('<div id=\"dialog-' + id + '\"></div>')
        .html(divContent)
        .dialog({
            autoOpen:false,
            title:""
        });

    currentDialog.dialog('open');
}
function showServiceInfo(id) {

    //var divContent = '<div align="center">' + services[id].category + '</div>' +
    var divContent = '<div align="center"><h1>' + services[id].name + '</h1></div>' +
        '<div align="center"><img src="' + services[id].lrgIcon + '"\" alt=\"" + key + "\"/></div>';

    if (services[id].url)
    {
      divContent += '<div align="center"><a href="/jobs/new/' + services[id].type + '" class="button"><span class="oboeButton">Submit Job</span></a>  ' +
        '<a href="' + services[id].url + '" target="_blank" class="button"><span class="urlButton">Website</span></a></p></div>';
    }
    else
    {
      divContent += '<div align="center"><a href="/jobs/new/' + services[id].type + '" class="button"><span class="oboeButton">Submit Job</span></a></p></div>'; 
    }
 
    var description;    
if(services[id].longDescription != undefined) {
    description = services[id].longDescription;
} else {
    description = services[id].shortDescription;
}
    divContent += '<br/><p class="serviceInformation">' + description + '</p><br/>';

    // output supporter links, if they are defined in the json.
    if (services[id].sponsors != undefined) {
        divContent += '<div class="extra-info-header"><div class="supporters-header"></div>';
        divContent += '<div class="sponsors">';


        for (var sponsor in services[id].sponsors) {
            var sponsorInfo = services[id].sponsors[sponsor];
            divContent += '<div class="sponsor_item">';
            divContent += '<a href="' + sponsorInfo.url + '" alt="' + sponsor + '" target="_blank" class="navigation-button">';
            divContent += '<img src="' + sponsorInfo.image + '" alt="' + sponsor + '" class="sponsor"/>';
            divContent += '</a>';
            divContent += '</div>';
        }
        divContent += '</div></div></div>';

        divContent += '<div class="clear"></div>';

    }

    // output mobile links, if they are defined in the json.
    if (services[id].mobile != undefined) {
        divContent += '<div class="extra-info-header"><div class="apps-header"></div>';
        divContent += '<div class="sponsors">';

        for (var mobilePlatform in services[id].mobile) {
            var mobileInfo = services[id].mobile[mobilePlatform];
            divContent += '<div class="mobile_item">';
            divContent += '<a href="' + mobileInfo.url + '" alt="' + mobilePlatform + '" target="_blank" class="navigation-button">';
            divContent += '<img src="assets/img/mobile/' + mobilePlatform + '.png" alt="android" class="mobile_image"/>';
            divContent += '</a>';
            divContent += '</div>';
        }

        divContent += '</div></div></div>';
        divContent += '<div class="clear"></div>';
    }


    showDialog(id, divContent);
}
