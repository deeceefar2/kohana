<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes" />

<xsl:variable name="api-key" select="'ABQIAAAACgq4GHPTtYlEBLFv4j9ZABQcBjVj5tvavvjodnc9kSqL208uSxRhJVJtcIYy25R8xiXpsCye3H-v6Q'"/>

<xsl:template name="get-google-map">
	<xsl:param name="document" select="'yes'"/>
	<xsl:param name="map-id"/>
	<xsl:param name="map-width"/>
	<xsl:param name="map-height"/>
	<xsl:param name="location-name"/>
	<xsl:param name="street-address"/>
	<xsl:param name="city"/>
	<xsl:param name="state"/>
	<xsl:param name="zip-code"/>
	<xsl:param name="location-full-address" select="concat($street-address,' ',$city,' ',$state,' ',$zip-code)"/>
	<xsl:param name="location-no-city-address" select="concat($street-address,' ',$state,' ',$zip-code)"/>
	<xsl:param name="zoom-level"/>
	<!-- Map Type : Default = ROADMAP / Other Options = SATELLITE, HYBRID, OR TERRAIN -->
	<xsl:param name="map-type"/>
	<xsl:param name="latlong">
		<xsl:if test="$document='yes'">
			<xsl:choose>
				<xsl:when test="remove-city-from-google-map='Yes'">
					<xsl:call-template name="geocode">
						<xsl:with-param name="address" select="$location-no-city-address"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="geocode">
						<xsl:with-param name="address" select="$location-full-address"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:param>
	<xsl:param name="label"/>

	<xsl:param name="directions-to-map-link">
		<xsl:value-of select="concat('http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=',translate($location-full-address,' ','+'),',&amp;iwstate1=dir:to')"/>
	</xsl:param>



	<xsl:if test="$location-full-address!=''">
		<script type="text/javascript">
		<xsl:choose>
			<xsl:when test="$latlong='' or $latlong=', '">
				function initialize() {
					var geocoder = new google.maps.Geocoder();
					var address = '<xsl:value-of select="$location-full-address"/>';
					geocoder.geocode( { 'address': address}, function(results, status) {
						if (status == google.maps.GeocoderStatus.OK) {
							var myLatLng = results[0].geometry.location;
							var myOptions = {
								zoom: <xsl:choose><xsl:when test="$zoom-level!=''"><xsl:value-of select="$zoom-level"/></xsl:when><xsl:otherwise><xsl:text>14</xsl:text></xsl:otherwise></xsl:choose>,
								center: myLatLng,
								mapTypeId: google.maps.MapTypeId.<xsl:choose><xsl:when test="$map-type!=''"><xsl:value-of select="$map-type"/></xsl:when><xsl:otherwise><xsl:text>ROADMAP</xsl:text></xsl:otherwise></xsl:choose>
							}
							var map = new google.maps.Map(document.getElementById("<xsl:choose><xsl:when test="$map-id!=''"><xsl:value-of select="$map-id"/></xsl:when><xsl:otherwise><xsl:text>map_canvas</xsl:text></xsl:otherwise></xsl:choose>"), myOptions);
							var marker = new google.maps.Marker({
								position: myLatLng,
								map: map
							});
							codeAddress();
							<xsl:if test="$label='yes'">
								var infowindow = new google.maps.InfoWindow({
									content: '<strong><xsl:value-of select="$location-name"/></strong><xsl:if test="$location-full-address!=''"><br/><xsl:value-of select="$location-full-address"/></xsl:if><xsl:if test="$directions-to-map-link!=''"><br/><a href="{$directions-to-map-link}">Get Directions</a></xsl:if>',
									position: myLatLng
								});
								infowindow.open(map);
							</xsl:if>
						} else {
							alert("Geocode was not successful for the following reason: " + status);
						}
					});
				}
			</xsl:when>
			<xsl:otherwise>
				function initialize() {
					var myLatLng = new google.maps.LatLng(<xsl:value-of select="$latlong"/>);
					var myOptions = {
						zoom: <xsl:choose><xsl:when test="$zoom-level!=''"><xsl:value-of select="$zoom-level"/></xsl:when><xsl:otherwise><xsl:text>14</xsl:text></xsl:otherwise></xsl:choose>,
						center: myLatLng,
						mapTypeId: google.maps.MapTypeId.<xsl:choose><xsl:when test="$map-type!=''"><xsl:value-of select="$map-type"/></xsl:when><xsl:otherwise><xsl:text>ROADMAP</xsl:text></xsl:otherwise></xsl:choose>
					}
					var map = new google.maps.Map(document.getElementById("<xsl:choose><xsl:when test="$map-id!=''"><xsl:value-of select="$map-id"/></xsl:when><xsl:otherwise><xsl:text>map_canvas</xsl:text></xsl:otherwise></xsl:choose>"), myOptions);
					var marker = new google.maps.Marker({
						position: myLatLng,
						map: map
					});
					<xsl:if test="$label='yes'">
						var infowindow = new google.maps.InfoWindow({
							content: '<strong><xsl:value-of select="$location-name"/></strong><xsl:if test="$location-full-address!=''"><br/><xsl:value-of select="$location-full-address"/></xsl:if><xsl:if test="$directions-to-map-link!=''"><br/><a href="{$directions-to-map-link}">Get Directions</a></xsl:if>',
							position: myLatLng
						});
						infowindow.open(map);
					</xsl:if>
				}
			</xsl:otherwise>
		</xsl:choose>
			function loadScript() {
				var script = document.createElement('script');
				script.type = 'text/javascript';
				script.src = 'http://maps.googleapis.com/maps/api/js?sensor=false&amp;callback=initialize';
				document.body.appendChild(script);
			}

			window.onload = loadScript;
		</script>
		<div id="event_map">
			<xsl:choose>
				<xsl:when test="$map-id!=''"><div id="{$map-id}" style="width: {$map-width}; height: {$map-height}; border: 7px solid #ddd;"><!--Maps Here--></div></xsl:when>
				<xsl:otherwise><div id="map_canvas" style="width: {$map-width}; height: {$map-height};"><!--Maps Here--></div></xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:if>


</xsl:template>

<xsl:template name="geocode">
	<xsl:param name="address"/>
	<xsl:variable name="encodedAddress">
		<xsl:value-of select="translate($address,' ','+')"/>
	</xsl:variable>
	<xsl:variable name="urlString">http://maps.googleapis.com/maps/api/geocode/xml?address=<xsl:value-of select="$encodedAddress"/>&amp;sensor=false</xsl:variable>

	<xsl:variable name="geocoder" select="document($urlString)"/>

	<xsl:variable name="location" select="$geocoder//*[name()='location']"/>

	<xsl:value-of select="$location/lat"/><xsl:text>, </xsl:text><xsl:value-of select="$location/lng"/>
</xsl:template>

</xsl:stylesheet>