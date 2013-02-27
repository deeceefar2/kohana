<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:template name="root">
	<script type="text/javascript">
	<xsl:comment>
		$(document).ready(function() {
			$('#colorbox').draggable({ handle: ".topDarkPanel" });
		});
	//</xsl:comment>
	</script>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>