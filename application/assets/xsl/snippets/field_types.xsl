<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:ft="urn:templates">

<xsl:variable name="templates" select="document('')//ft:templates" />

<xsl:template match="field">
	<xsl:variable name="template-name" select="field_type/field_type_name" />
	<xsl:apply-templates select="$templates/ft:*[local-name() = $template-name]">
		<xsl:with-param name="field" select="node()"/>
	</xsl:apply-templates>
</xsl:template>

<ft:templates>
	<ft:textarea_small/>
</ft:templates>

<xsl:template name="textarea_small" match="ft:textarea_small">
	<xsl:param name="field"/>

	<xsl:copy-of select="$field"/>

</xsl:template>

</xsl:stylesheet>