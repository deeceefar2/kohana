$(document).ready(function() {
	
	if (navigator.geolocation && !geolocation)
		navigator.geolocation.getCurrentPosition(geolocationSuccess, geolocationError);

	$('.modalLink').colorbox({
		opacity:		0.6,
		onComplete:		onComplete,
	});
	
	$('.sectionTitle').bind('click',function() {
		section = $(this).parent('.expandableSection');
		
		section.children('.collapsible').toggle();
		$(this).children('.expandHideIndividualSection').children().toggle();

		return false;
	});
	
	$(".expandHideAllSections, .expandHideAllQuestions").bind('click', function () {
		showOrHide = $(this).children('.expandAll').is(":visible");
		// Change the expandHideAllSections text
		$(this).children(".expandHide").toggle();
		
		// Show or hide all sections
		$('.collapsible').toggle(showOrHide);
		
		$(".sectionTitle").children(".expandHideIndividualSection").children(".plusSmallBlue").toggle(!showOrHide);
		$(".sectionTitle").children(".expandHideIndividualSection").children(".minusSmallBlue").toggle(showOrHide);
	});
	
	//*****************
	//* Browse column *
	//*****************
	
	$(".browseToggleSection").click(function () {
		// Toggle the browse open/close button
		
		if ($('.listings').hasClass('browse')) {
			$('.loadMoreResults').toggleClass('threeColumn twoColumn', 200);
			$('.browseResults').toggleClass('threeColumn twoColumn', 200, function() {
				$('.browseColumn').slideToggle(200);
			});
			$('.listings').toggleClass('browse categories', 100);
		} else {
			$('.browseColumn').slideToggle(200, function() {
				$('.listings').toggleClass('categories browse', 100);
				$('.browseResults').toggleClass('twoColumn threeColumn', 200);
				$('.loadMoreResults').toggleClass('twoColumn threeColumn', 200);
			});
		}
	});

	$('.expandHideSection').click(function() {
		$(this).toggleClass('selected');
		$(this).parent().children('.children').toggle();
		return false;
	});

	$('[placeholder]').focus(function() {
		var input = $(this);
		if (input.val() == input.attr('placeholder')) {
			input.val('');
			input.removeClass('placeholder');
		}
	}).blur(function() {
		var input = $(this);
		if (input.val() == '' || input.val() == input.attr('placeholder')) {
			input.addClass('placeholder');
			input.val(input.attr('placeholder'));
		}
	}).blur();
	
	$('form').bind('submit', cleanForm);

	$('.pageLinks').toggle();
	$('#loadmore').toggle();

	$('#loadmore').appear(loadPage);
});

function onComplete()
{
	//$('#colorbox').offset(x,y);
	$('#colorbox').draggable({
		handle: ".blueBar",
		containment: '#cboxOverlay',
	});
	$('#installDate').datepicker({ inline: true });
	$('#colorbox form').bind('submit', function () {
		absLeft = false;
		absTop = false;
		if(null != $('#colorbox').data('draggable').positionAbs) {
			absLeft = parseInt( $('#colorbox').data('draggable').positionAbs.left );
			absTop = parseInt( $('#colorbox').data('draggable').positionAbs.top );
		}
		var action = $(this).attr('action');
		$(this).unbind('submit');
		$.fn.colorbox({
			left:			absLeft,
			top:			absTop,
			href:			$(this).attr('action'),
			data:			($(this).attr('method')=='post')?$(this).serializeArray():$(this).serialize(),
			onComplete:		onComplete,
		});
		return false;
	});
}

function cleanForm(event)
{
	changed = false;
	$('[placeholder]').each(function() {
		var input = $(this);
		if(input.val() == input.attr('placeholder'))
			input.val('');
		changed = true;
	});
	if(changed) {
		$(this).unbind(event);
		$(this).submit();
		$(this).unbind(event);
		$(this).children('[placeholder]').each(function() { $(this).blur(); });
		$(this).bind('submit', cleanForm);
		return false;
	}
}

function geolocationSuccess(position)
{
	$.colorbox({
		href:			'/location/?latitude='+position.coords.latitude+'&longitude='+position.coords.longitude,
		opacity:		0.6,
		onComplete:		onComplete,
	});
}

function geolocationError(error) {  
	switch(error.code)  
	{  
		case error.PERMISSION_DENIED:
			$.colorbox({
				href:			'/location/?denied=1',
				opacity:		0.6,
				onComplete:		onComplete,
			});
		break;  

		case error.POSITION_UNAVAILABLE:
			$.colorbox({
				href:			'/location/?unavailable=1',
				opacity:		0.6,
				onComplete:		onComplete,
			});
		break;  

		case error.TIMEOUT:
			alert("retrieving position timed out");  
		break;  

		default:
			alert("ERROR:"+ error.message); 
		break;  
	}
}

function loadPage(event)
{
	if($('.pageRight').attr('href')!=''  && !$('.loadMoreButton').hasClass('loading')) {
		$('.loadMoreResults').addClass('loading');
		$.ajax({
			url: $('.pageRight').attr('href'),
			success: function(data){
				$(data).appendTo('.listingContainer');
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			},
			complete: function(){
				$('.loadMoreResults').removeClass('loading');
				$('#loadmore').appear(loadPage);
			},
		});
		next=$('.pageLink').filter("[href='"+$('.pageRight').attr('href')+"']").next();
		if(next.attr('href') != $('.pageRight').attr('href'))
			$('.pageRight').attr('href',next.attr('href'));
		else
			$('.loadMoreResults').css('display','none');
	}
}