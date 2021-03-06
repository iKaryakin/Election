var electionApp = {};

electionApp.listPollingStation = [];

(function() {
	if (electionApp.currentPage != 'index') return;
	var req = new XMLHttpRequest();
	req.responseType = 'json';
	req.open('GET', '/areas.json', true);
	req.onload  = function(req) {
		electionApp.listPollingStation = req.currentTarget.response;
	};
	req.send(null);
})();

electionApp.listPollingStationTemplate = '\
	<a class="list-polling-station__item" href="#url">\
	    <div class="list-polling-station__text list-polling-station__text--number">#number</div>\
	    <div class="list-polling-station__text list-polling-station__text--address">#address</div>\
	    <div class="list-polling-station__text list-polling-station__text--phone">#phone</div>\
	</a>';

electionApp.insertPollingStationData = function(list) {
	var container = document.querySelector('.polling-station__list');
	var html = '';
	container.innerHTML = '';
	list.forEach(function(item, index) {
		html += electionApp.
			listPollingStationTemplate.
			replace(/\#url|\#number|\#address|\#phone/g, function(match) {
				return list[index][match.slice(1)];
			});
	});
	container.insertAdjacentHTML('afterbegin', html);
}

electionApp.initMap = function() {
	var stationNumber;
    var map = new ymaps.Map("map", {
        center: [52.967187, 36.069613],
        zoom: 12
    });

    electionApp.listPollingStation.forEach(function(item) {
		var itemNumber = item.number.match(/\d/g);
		if (itemNumber) {
			stationNumber = itemNumber.filter(function(digit) {
				return parseInt(digit, 10);
			}).join('');
		} else {
			stationNumber = '';
		}

    	map.geoObjects.add(
	    	new ymaps.Placemark(
	    		item.coordinates,
	    		{
	    			hintContent: item.number,
	    			iconContent: stationNumber
	    		}
	    	)
    	);
    });
}

electionApp.filteringPollingStation = function(event) {
	var inputVal = event.srcElement.value;
	var result;

	['.search', '.search__input'].forEach(function(cls) {
		document.querySelector(cls).
			classList[inputVal.length > 0 ? 'add' : 'remove'](cls.slice(1) + '--filled');
	});

	if (inputVal.length === 0) electionApp.insertPollingStationData(electionApp.listPollingStation);

	if (inputVal.length < 3) return;

	result = electionApp.listPollingStation.filter(function(item) {
		return ~item.number.indexOf(inputVal) || ~item.address.indexOf(inputVal);
	});

	electionApp.insertPollingStationData(result);
	electionApp.scrollbar.update();
}

electionApp.camerasBtnClickHandler = function(event){
	document.querySelectorAll('.cameras__button').forEach(function(item) {
		item.classList.remove('button--active');
	});
	event.srcElement.classList.add('button--active');
}



document.addEventListener('DOMContentLoaded', function() {
	if (electionApp.currentPage == 'index') {
		if (electionApp.listPollingStation.length) {
			electionApp.insertPollingStationData(electionApp.listPollingStation);
			electionApp.scrollbar = new PerfectScrollbar(document.querySelector('.polling-station__list'));
			ymaps.ready(electionApp.initMap);
		} else {
			var intervaID = setInterval(function() {
				if (electionApp.listPollingStation.length) {
					electionApp.insertPollingStationData(electionApp.listPollingStation);
					electionApp.scrollbar = new PerfectScrollbar(document.querySelector('.polling-station__list'));
					electionApp.initMap();
					clearInterval(intervaID);
				}
			}, 50);
		}




		// electionApp.insertPollingStationData(electionApp.listPollingStation);

		document.querySelector('.search__input').
			addEventListener('input', electionApp.filteringPollingStation);

		// electionApp.scrollbar = new PerfectScrollbar(document.querySelector('.polling-station__list'));
	
		// ymaps.ready(electionApp.initMap);
	} else if (electionApp.currentPage == 'polling-station') {
		document.querySelectorAll('.cameras__buttons').forEach(function(btn) {
			btn.addEventListener('click', electionApp.camerasBtnClickHandler);
		})
		ymaps.ready(electionApp.initMap);
	}
});
